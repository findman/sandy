/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author or authors.
Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 ( the "License" );
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
	http://www.mozilla.org/MPL/MPL-1.1.html
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# ***** END LICENSE BLOCK *****
*/

import com.bourre.data.libs.GraphicLib;
import com.bourre.data.libs.GraphicLibLocator;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.LibStack;

import flash.display.BitmapData;
	
import sandy.core.data.*;
import sandy.core.scenegraph.*;
import sandy.events.QueueEvent;
import sandy.materials.*;
import sandy.parser.AParser;
import sandy.parser.IParser;
import sandy.parser.ParserEvent;
import sandy.util.BitmapUtil;
import sandy.util.NumberUtil;
import sandy.util.XML2Object;

/**
 * Transforms a COLLADA XML document into Sandy geometries.
 * <p>Creates a Group as rootnode which appends all geometries it finds.
 * Recommended settings for the COLLADA exporter:</p>
 * <ul>
 * <li>Relative paths</li>
 * <li>Triangulate</li>
 * <li>Normals</li>
 * </ul>
 *
 * @author		Dennis Ippel - ippeldv
 * @author		(porting) Floris - xdevltd
 * @since		1.0
 * @version		2.0.2
 * @date 		26.07.2007
 *
 * @example To parse a COLLADA object at runtime:
 *
 * <listing version="3.0">
 *     var parser:IParser = Parser.create( "/path/to/my/colladafile.dae", Parser.COLLADA );
 * </listing>
 *
 * @example To parse an embedded COLLADA object:
 *
 * <listing version="3.0">
 *     var parser:IParser = Parser.create( "/path/to/my/colladafile.dae", Parser.COLLADA );
 * </listing>
 */

class sandy.parser.ColladaParser extends AParser implements IParser
{

	private var l_oImages:Object;
	
	private var m_oCollada:Object;
	private var m_bYUp:Boolean;

	private var m_oMaterials:Object;

	/**
	 * Default path for COLLADA images.
	 * <p>Can this be done without?</p>
	 */
	public var RELATIVE_TEXTURE_PATH:String;

	/**
	 * Creates a new COLLADA parser instance.
	 *
	 * @param  p_sUrl		Can be either a string pointing to the location of the
	 * 						COLLADA file or an instance of an embedded COLLADA file.
	 * @param  p_nScale		The scale factor.
	 */
	public function ColladaParser( p_sUrl, p_nScale:Number )
	{
		super( p_sUrl, p_nScale );
		RELATIVE_TEXTURE_PATH = ".";
	}

	/**
	 * @private
	 * Starts the parsing process
	 *
	 * @param  s				Boolean: loaded succesfully.
	 */
	private function parseData( s:Boolean ) : Void
	{
		super.parseData( s );
		// -- read the XML
		m_oCollada = new XML2Object( m_oFile ).data.COLLADA;
		
		m_bYUp = ( m_oCollada.asset.up_axis.data == "Y_UP" );
		//m_bYUp = !m_bYUp;
			
		//if( m_oCollada.library_images.length() > 0 ) 
		//	m_oMaterials = loadImages( m_oCollada.library_images.image );
		//else
			parseScene( m_oCollada.library_visual_scenes.visual_scene[ 0 ] );
			
	}
	
	/**
	 * Parses the 3D scene
	 * @param  p_oScene		COLLADA XML's scene node ( as Object )
	 */
	private function parseScene( p_oScene:Object ) : Void
	{
		// -- local variables
		var l_oNodes:Object = p_oScene.node; 
		var l_nNodeLen:Number = l_oNodes.length();
				
		for( var i:Number = 0; i < l_nNodeLen; i++ ) 
		{
			var l_oNode:Node = parseNode( l_oNodes[ i ] );
			// -- add the shape to the group node
			if( l_oNode != null )
				m_oGroup.addChild( l_oNode );
		}
 
		// -- Parsing is finished
		dispatchInitEvent();
	}		
	
	/**
	 * Reads the geometry and materials. Also performs scaling, translation
	 * and rotation operations.
	 * @param p_oNode		XML node ( as Object ) containing a node from the 3D scene
	 * @return 				A parsed Shape3D
	 */
	private function parseNode( p_oNode:Object ) : Node
	{
		// -- local variables
		var l_oNode:ATransformable;
		//var l_oMatrix:Matrix4 = new Matrix4();
		var l_sGeometryID:String;
		var l_oNodes:Object;
		var l_nNodeLen:Number;
		var l_oVector:Vector;
		//var l_oPivot:Vector = new Vector();
		var l_oGeometry:Geometry3D = null;
		//var l_oScale:Transform3D;
		var i:Number;
		
		if( p_oNode.instance_geometry.length() != 0 )
		{
			var l_aGeomArray:Array;
			var l_oAppearance:Appearance = m_oStandardAppearance;
			l_oGeometry = new Geometry3D();
			l_oAppearance = getAppearance( p_oNode );
			
			l_aGeomArray = p_oNode.instance_geometry.attributes.url.split( "#" );
			l_sGeometryID = l_aGeomArray[ 1 ];
			// -- get the vertices
			l_oGeometry = getGeometry( l_sGeometryID, m_oMaterials );

			if( l_oGeometry == null ) return null;
			// -- create the new shape
			l_oNode = new Shape3D( p_oNode.attributes.name, l_oGeometry, l_oAppearance );
		}
		else
		{
			l_oNode = new TransformGroup( p_oNode.attributes.name );
		}
		
		// -- scale
		if( p_oNode.scale.length() > 0 ) 
		{
			l_oVector = stringToVector( String( p_oNode.scale ) );
			// --
			formatVector( l_oVector );
			// --
			l_oNode.scaleX = l_oVector.x;
			l_oNode.scaleY = l_oVector.y;
			l_oNode.scaleZ = l_oVector.z;

		}
		
		// -- translation
		if( p_oNode.translate.length() >= 1 ) 
		{
			var l_nTransAtt:Number = p_oNode.translate.length();
			for( i = 0; i < l_nTransAtt; i++ )
			{
				var l_sTranslationValue:String = "";
				// --
				var l_sAttTranslateValue:String = p_oNode.translate[ i ].attributes.sid;
				if( l_sAttTranslateValue ) l_sAttTranslateValue = l_sAttTranslateValue.toLowerCase();
					
				if( l_sAttTranslateValue == "translation" || l_sAttTranslateValue ==  "translate" )
						l_sTranslationValue = String( p_oNode.translate[ i ] );
				else if( !l_sAttTranslateValue.length ) 
						l_sTranslationValue = String( p_oNode.translate[ i ] );

				if( l_sTranslationValue.length )
				{
					// --
					l_oVector = stringToVector( l_sTranslationValue );
					l_oVector.scale( m_nScale );
					// --
					formatVector( l_oVector );
					// --
					l_oNode.x = l_oVector.x;
					l_oNode.y = l_oVector.y;
					l_oNode.z = l_oVector.z;
				}
			}
		}
		
		// -- rotate
		if( p_oNode.rotate.length() == 1 ) 
		{
			var l_oRotations:Array = stringToArray( String( p_oNode.rotate ) );
				
			if( m_bYUp )
			{
				l_oNode.rotateAxis( l_oRotations[ 0 ], l_oRotations[ 1 ], l_oRotations[ 2 ], l_oRotations[ 3 ] );
			}
			else
			{
				l_oNode.rotateAxis( l_oRotations[ 0 ], l_oRotations[ 2 ], l_oRotations[ 1 ], l_oRotations[ 3 ] );
			}	
		} 
		else if( p_oNode.rotate.length() == 3 ) 
		{
			for( var j:Number = 0; j < 3; j++ )
			{
				var l_oRot:Array = stringToArray( String( p_oNode.rotate[ j ] ) );
				switch( p_oNode.rotate[ j ].attributes.sid.toLowerCase() )
				{
					case "rotatex":
					{
						if( l_oRot[ 3 ] != 0 )
						{
							if( m_bYUp ) l_oNode.rotateX = Number( l_oRot[ 3 ] );
							else 		 l_oNode.rotateX = Number( l_oRot[ 3 ] );
						}
						break;
					}
					case "rotatey":
					{
						if( l_oRot[ 3 ] != 0 )
						{
							if( m_bYUp ) l_oNode.rotateY = Number( l_oRot[ 3 ] );
							else 		 l_oNode.rotateZ = Number( l_oRot[ 3 ] );
						} 
						break;
					}
					case "rotatez":
					{
						if( l_oRot[ 3 ] != 0 ) 
						{
							if( m_bYUp ) l_oNode.rotateZ = Number( l_oRot[ 3 ] );
							else		 l_oNode.rotateY = Number( l_oRot[ 3 ] );
						}
						break;
					}
				}
			}
		}

		// -- baked matrix
		if( p_oNode.matrix.length() > 0 ) 
		{
			stringToMatrix( String( p_oNode.matrix ) );
			//l_oShape.setPosition( l_oMatrix.n14, l_oMatrix.n34, l_oMatrix.n24 );
			//l_oNode.scaleX = l_oMatrix.n11;
			//l_oNode.scaleY = l_oMatrix.n33;
			//l_oNode.scaleZ = l_oMatrix.n22;
		}

		// -- loop through subnodes
		l_oNodes = p_oNode.node;
		l_nNodeLen = l_oNodes.length();

		for( i = 0; i < l_nNodeLen; i++ )
		{
			var l_oChildNode:Node = parseNode( l_oNodes[ i ] );
			// -- add the shape to the group node
			if( l_oChildNode != null )
				l_oNode.addChild( l_oChildNode );
		}

		// quick hack to get url-ed nodes parsed
		if( p_oNode.instance_node.length() != 0 )
		{
			var l_sNodeId:String = p_oNode.instance_node.attributes.url;
			if( ( l_sNodeId != "" ) && ( l_sNodeId.charAt( 0 ) == "#" ) )
			{
				l_sNodeId = l_sNodeId.substr( 1 );
					
				var l_oMatchingNodes:Object = m_oCollada.library_nodes.node.where( 'attributes.id', l_sNodeId );
							
				for( var i in l_oMatchingNodes ) 
				{
					var l_oNode3D:Node = parseNode( l_oMatchingNodes[ i ] );
					// -- add the shape to the group node
					if( l_oNode3D != null )
						l_oNode.addChild( l_oNode3D );
				}
			}
		}

		//l_oShape.matrix = l_oMatrix;
		return l_oNode;
	}

	/**
	 * Parses the geometry XML of a certain node.
	 *
	 * @param p_sGeometryID		The COLLADA node ID
	 * @param p_oMaterials		An object containing all the loaded materials
	 * @return 					The parsed Geometry3D
	 */
	private function getGeometry( p_sGeometryID:String, p_oMaterials:Object ) : Geometry3D
	{
		var i:Number;
		var l_oOutpGeom:Geometry3D = new Geometry3D();
		var l_oGeometry:Object = m_oCollada.library_geometries.geometry.where( 'attributes.id', p_sGeometryID );
		
		// -- triangles
		var l_oTriangles:Object = l_oGeometry.mesh.triangles[ 0 ];
		if( l_oTriangles == null ) return null;
		var l_aTriangles:Array = stringToArray( String( l_oTriangles.p ) );
		var l_sMaterial:String = l_oTriangles.attributes.material;
		var l_nCount:Number = Number( l_oTriangles.attributes.count );
		var l_nStep:Number = l_oTriangles.input.length();

		// -- get vertices float array
		var l_sVerticesID:String = l_oTriangles.input.where( "attributes.semantic", "VERTEX" ).attributes.source.split( "#" )[ 1 ];
		var l_sPosSourceID:String = l_oGeometry.mesh.vertices.where( "attributes.id", l_sVerticesID ).input.where( "attributes.semantic", "POSITION" ).attributes.source.split( "#" )[ 1 ];
		var l_aVertexFloats:Array = getFloatArray( l_sPosSourceID, l_oGeometry );
		var l_nVertexFloat:Number = l_aVertexFloats.length;
		var l_aVertices:Array = new Array();

		// -- set vertices
		for( i = 0; i < l_nVertexFloat; i++ )
		{
			var l_oVertex:Vector = l_aVertexFloats[ i ];
			l_oVertex.scale( m_nScale ); 
			// --
			formatVector( l_oVertex );
			// --
			l_oOutpGeom.setVertex( 	i,
									l_oVertex.x,
									l_oVertex.y,
									l_oVertex.z );
		}
		
		if( l_oTriangles.input.where( "attributes.semantic", "TEXCOORD" ).length() > 0 )
		{
			// -- get uvcoords float array
			var l_sUVCoordsID:String = l_oTriangles.input.where( "attributes.semantic", "TEXCOORD" ).attributes.source.split( "#" )[ 1 ];
			var l_aUVCoordsFloats:Array = getFloatArray( l_sUVCoordsID, l_oGeometry );
			var l_nUVCoordsFloats:Number = l_aUVCoordsFloats.length;

			// -- set uvcoords
			for( i = 0; i < l_nUVCoordsFloats; i++ )
			{
				var l_oUVCoord:Object = l_aUVCoordsFloats[ i ];

				l_oOutpGeom.setUVCoords( i, l_oUVCoord.x, 1 - l_oUVCoord.y );
			}
		}
		
		// -- get normals float array
		// THOMAS TODO: Why using VertexNormal?  It is face normal !
		if( l_oTriangles.input.where( "attributes.semantic", "NORMAL" ).length() > 0 )
		{
			var l_sNormalsID:String = l_oTriangles.input.where( "attributes.semantic", "NORMAL" ).attributes.source.split( "#" )[ 1 ];
			var l_aNormalFloats:Array = getFloatArray( l_sNormalsID, l_oGeometry );
			var l_nNormalFloats:Number = l_aNormalFloats.length;

			// -- set normals
			for( i = 0; i < l_nNormalFloats; i++ )
			{
				var l_oNormal:Vector = l_aNormalFloats[ i ];
				// STRANGE, AREN'T NORMAL VECTORS NORMALIZED?
				l_oNormal.normalize();
				// --
				formatVector( l_oNormal );
				// --
				if( !m_bYUp ) l_oOutpGeom.setFaceNormal( i, l_oNormal.x, l_oNormal.y, l_oNormal.z );
				/*
				l_oOutpGeom.aVertexNormals[ i ] = new Vertex( 
					l_oNormal.x,
					l_oNormal.y,
					l_oNormal.z	 );*/
			}
		}

		l_aTriangles = convertTriangleArray( l_oTriangles.input, l_aTriangles, l_nCount );
		var l_nTriangeLength:Number = l_aTriangles.length;

		for( i = 0; i < l_nTriangeLength; i++ )
		{
			var l_aVertex:Array = l_aTriangles[ i ].VERTEX;
			var l_aNormals:Array = l_aTriangles[ i ].NORMAL;
			var l_aUVs:Array = l_aTriangles[ i ].TEXCOORD;
			
			if( m_bYUp )
			{
				l_oOutpGeom.setFaceVertexIds( i, l_aVertex[ 0 ], l_aVertex[ 1 ], l_aVertex[ 2 ] );
				if( l_aUVs != null ) l_oOutpGeom.setFaceUVCoordsIds( i, l_aUVs[ 0 ], l_aUVs[ 1 ], l_aUVs[ 2 ] );
			}
			else
			{
				l_oOutpGeom.setFaceVertexIds( i, l_aVertex[ 0 ], l_aVertex[ 1 ], l_aVertex[ 2 ] );
				if( l_aUVs != null ) l_oOutpGeom.setFaceUVCoordsIds( i, l_aUVs[ 0 ], l_aUVs[ 1 ], l_aUVs[ 2 ] );
			}
		}

		return l_oOutpGeom;
	}

	/**
	 * Takes a space separated string from an XML node and turns it into a vector array
	 * @param p_sSourceID		The COLLADA node ID
	 * @param p_oGeometry		An XMLList ( as Object ) containing space separated values
	 * @return 					An array containing parsed vectors
	 */
	private function getFloatArray( p_sSourceID:String, p_oGeometry:Object ) : Array
	{
		var str:String = String( p_oGeometry.mesh.source.where( "attributes.id", p_sSourceID ).float_array );
		while( str.indexOf( '  ' ) > -1 ) str = str.split( '  ' ).join( ' ' );
		var l_aFloatArray:Array = str.split( ' ' );
		var l_nCount:Number = p_oGeometry.mesh.source.where( "attributes.id", p_sSourceID ).technique_common.accessor.attributes.count;
		var l_nOffset:Number = p_oGeometry.mesh.source.where( "attributes.id", p_sSourceID ).technique_common.accessor.attributes.stride;

		var l_nFloatArray:Number = l_aFloatArray.length;
		var l_aOutput:Array = new Array();

		for( var i:Number = 0; i < l_nFloatArray; i += l_nOffset )
		{
			var l_oCoords:Vector;
			// FIX FROM THOMAS to solve the case there's only UV coords exported instead of UVW. To clean
			if( l_nOffset == 3 )
			{
				l_oCoords = new Vector( Number( l_aFloatArray[ i ] ),
										Number( l_aFloatArray[ i + 1 ] ),
										Number( l_aFloatArray[ i + 2 ] ) );
			}
			else if( l_nOffset == 2 )
			{
				l_oCoords =	new Vector( Number( l_aFloatArray[ i ] ),
										Number( l_aFloatArray[ i + 1 ] ) , 0 );
			}
			l_aOutput.push( l_oCoords );
		}

		return l_aOutput;
	}

	/**
	 * The <triangles> element provides the information needed to bind vertex
	 * attributes together and then organize those vertices into individual
	 * triangles. This method binds the individual values to the given
	 * input semantics ( can be VERTEX, TEXCOORD, NORMAL, ... )
	 *
	 * @param p_oInput				An XMLList ( as Object ) containing the input semantic elements
	 * @param p_aTriangles			An array containing the vertex attributes for a
	 * 								given number of triangles
	 * @param p_nTriangleCount		The number of triangles
	 * @return 						An array containing objects that hold vertex attributes
	 * 								for each input semantic
	 */
	private function convertTriangleArray( p_oInput:Object, p_aTriangles:Array, p_nTriangleCount:Number ) : Array
	{
		var l_nInput:Number = p_oInput.length();
		var l_nTriangles:Number = p_aTriangles.length;
		var l_aOutput:Array = new Array();
		var l_nValuesPerTriangle:Number = l_nTriangles / p_nTriangleCount;
		var l_nMaxOffset:Number;

		for( var m:Number = 0; m < l_nInput; m++ )
		{
			l_nMaxOffset = Math.max( l_nMaxOffset, Number( p_oInput[ m ].attributes.offset ) );
		}
		l_nMaxOffset++;
		// -- iterate through all triangles
		for( var i:Number = 0; i < p_nTriangleCount; i++ )
		{
			var semantic:Object = new Object();

			for( var j:Number = 0; j < l_nValuesPerTriangle; j++ )
			{
				for( var k:Number = 0; k < l_nInput; k++ )
				{
					if( int( p_oInput[ k ].attributes.offset ) == j % l_nMaxOffset )
					{
						if( !semantic[ p_oInput[ k ].attributes.semantic ] )
							 semantic[ p_oInput[ k ].attributes.semantic ] = new Array();
						var index:Number = ( i * l_nValuesPerTriangle ) + j;
						semantic[ p_oInput[ k ].attributes.semantic ].push( p_aTriangles[ index ] );
					}
				}
			}

			l_aOutput.push( semantic );
		}

		return l_aOutput;
	}

	/**
	 * Converts a space separated string to an array
	 *
	 * @param p_sValues		A string containing space separated values
	 * @return 				The resulting array
	 */
	private function stringToArray( p_sValues:String ) : Array
	{
		while( p_sValues.indexOf( '  ' ) > -1 ) p_sValues = p_sValues.split( '  ' ).join( ' ' );
		var l_aValues:Array = p_sValues.split( ' ' );
		var l_nValues:Number = l_aValues.length;

		for( var i:Number = 0; i < l_nValues; i++ )
		{
			l_aValues[ i ] = Number( l_aValues[ i ] );
		}

		return l_aValues;
	}

	/**
	 * Converts a string to a vector
	 *
	 * @param p_sValues		A string containing space separated values
	 * @return 				The resulting vector
	 */
	private function stringToVector( p_sValues:String ) : Vector
	{ 
		while( p_sValues.indexOf( '  ' ) > -1 ) p_sValues = p_sValues.split( '  ' ).join( ' ' );
		var l_aValues:Array = p_sValues.split( ' ' ); 
		var l_nValues:Number = l_aValues.length;
		// --
		if( l_nValues != 3 )
			throw new Error( "ColladaParser.stringToVector() :  A vector must have 3 values" );
		// --
		return new Vector( l_aValues[ 0 ], l_aValues[ 1 ], l_aValues[ 2 ] );
	}

	/**
	 * Converts a space separated string to a matrix
	 *
	 * @param p_sValues		A string containing space separated values
	 * @return 				The resulting matrix
	 */
	private function stringToMatrix( p_sValues:String ) : Matrix4
	{
		while( p_sValues.indexOf( '  ' ) > -1 ) p_sValues = p_sValues.split( '  ' ).join( ' ' );
		var l_aValues:Array = p_sValues.split( ' ' );
		var l_nValues:Number = l_aValues.length;

		if( l_nValues != 16 )
			throw new Error( "ColladaParser.stringToMatrix() :  A vector must have 16 values" );

		var l_oMatrix4:Matrix4 = new Matrix4( l_aValues[ 0 ], l_aValues[ 1 ], l_aValues[ 2 ], l_aValues[ 3 ],
											  l_aValues[ 4 ], l_aValues[ 5 ], l_aValues[ 6 ], l_aValues[ 7 ],
											  l_aValues[ 8 ], l_aValues[ 9 ], l_aValues[ 10 ], l_aValues[ 11 ],
											  l_aValues[ 12 ], l_aValues[ 13 ], l_aValues[ 14 ], l_aValues[ 15 ] );

		return l_oMatrix4;
	}
		
	
	private function formatVector( p_oVect:Vector ) : Void
	{
		var tmp:Number;
		if( m_bYUp )
		{
			p_oVect.x = -p_oVect.x;
		}
		else
		{
			/*
			tmp = p_oVect.y;
			p_oVect.y = p_oVect.z;
			p_oVect.z = tmp;
			*/
		}
	}

	/**
	 * Reads material information. If texture maps are used on the
	 * original object and the parser cannot find these files, then
	 * WireframeMaterial will be used by default.
	 *
	 * @param p_oNode		The XML node ( as Object ) containing material information
	 * @return 				The parsed appearance
	 */
	private function getAppearance( p_oNode:Object ) : Appearance
	{
		// -- local variables
		var l_oAppearance:Appearance = null;
		var p_oNodeMaterial:Object = p_oNode.instance_geometry.bind_material.technique_common.instance_material;
		
		// -- Get this node's instance materials
		for( var i in p_oNodeMaterial ) 
		{
			// -- get the corresponding material from the library
			var l_oMaterial:Object = m_oCollada.library_materials.material.where( "attributes.id", p_oNodeMaterial[ i ].attributes.target.split( "#" )[ 1 ] )[ 0 ];
			// -- get the corresponding effect
			var l_sEffectID:String = l_oMaterial.instance_effect.attributes.url.split( "#" )[ 1 ];
			
			var l_oEffect:Object = ( l_sEffectID == "" )
				? m_oCollada.library_effects.effect[ 0 ][ 0 ]
				: m_oCollada.library_effects.effect.where( 'attributes.id', l_sEffectID )[ 0 ];

			// -- no textures here or colors defined		
			if( l_oEffect.profile_COMMON.technique.phong.searchfor( "texture" ).length() == 0 && l_oEffect.profile_COMMON.technique.phong.length() == 0 ) return m_oStandardAppearance;
			
			if( l_oEffect.profile_COMMON.technique.phong.searchfor( "texture" ).length() > 0 )
			{
				// -- get the texture ID and use it to get the surface source
				var l_sTextureID:String = l_oEffect.profile_COMMON.technique.phong.searchfor( "texture" ).attributes.texture;
				var l_sSurfaceID:String = String( l_oEffect.profile_COMMON.newparam.where( "attributes.sid", l_sTextureID ).sampler2D.source );
					
				// -- now get the image ID
				var l_sImageID:String = String( l_oEffect.profile_COMMON.newparam.where( "attributes.sid", l_sSurfaceID ).surface.init_from );
				// -- get image's location on the hard drive

				if( m_oMaterials[ l_sImageID ].bitmapData ) l_oAppearance = new Appearance( new BitmapMaterial( m_oMaterials[ l_sImageID ].bitmapData ) );
				if( l_oAppearance == null ) l_oAppearance = m_oStandardAppearance;
			}
			else if( l_oEffect.profile_COMMON.technique.phong.length() > 0 )
			{
				// -- get the ambient color
				var l_aColors:Array = stringToArray( String( l_oEffect.profile_COMMON.technique.phong.ambient.color ) );
				var l_nColor:Number;

				var r:Number = NumberUtil.constrain( l_aColors[ 0 ] * 255, 0, 255 );
				var g:Number = NumberUtil.constrain( l_aColors[ 1 ] * 255, 0, 255 );
				var b:Number = NumberUtil.constrain( l_aColors[ 2 ] * 255, 0, 255 );

				l_nColor =  r << 16 | g << 8 |  b;

				l_oAppearance = new Appearance( new ColorMaterial( l_nColor, l_aColors[ 3 ] * 100 ) );
			}
		}

		if( l_oAppearance == null ) return m_oStandardAppearance;
		else return l_oAppearance;
	}

	/**
	 * Extracts the location of the images and used it to load the textures.
	 * If the images aren't found at the specified path, RELATIVE_TEXTURE_PATH
	 * will be used.
	 *
	 * @param p_oLibImages		An XMLList ( as Array ) containing information about the images
	 * @return 					An object array containg the object ID, filename
	 * 							and loader data
	 */
	private function loadImages( p_oLibImages:Array ) : Object
	{
		var l_oLStack:LibStack = new LibStack();
		var mc:MovieClip = new MovieClip();
		var l_oLContainer:MovieClip = mc.createEmptyMovieClip( "texture", mc.getNextHighestDepth() );
		var l_oGLib:GraphicLib = new GraphicLib( l_oLContainer, 0, false );
		
		l_oImages = new Object();
	
		for( var i in p_oLibImages )
		{
			var l_oInitFrom:String = p_oLibImages[ i ].init_from.data;
			l_oImages[ p_oLibImages[ i ].attributes.id ] = 
			{
				id : p_oLibImages[ i ].attributes.id,
				fileName : l_oInitFrom.substring( l_oInitFrom.lastIndexOf( "/" ) + 1, l_oInitFrom.length )
			}

			l_oLStack.enqueue(
				l_oGLib,
				p_oLibImages[ i ].attributes.id,
				RELATIVE_TEXTURE_PATH + "/" + l_oImages[ p_oLibImages[ i ].attributes.id ].fileName
			);

		}
		l_oLStack.addEventListener( LibStack.onLoadCompleteEVENT, this, imageQueueCompleteHandler );
		l_oLStack.load();

		return l_oImages;
	}

	/**
	 * The event handler that is fired when the image loading queue has finished
	 * loading. Bitmapdata is transfered to a material array and the parseScene
	 * method is called.
	 */
	private function imageQueueCompleteHandler() : Void
	{
		for( var id in l_oImages )
		{
			var gl:GraphicLib = GraphicLibLocator.getInstance().getGraphicLib( id );
			var lBmd:BitmapData = BitmapUtil.movieToBitmap( gl.getContent(), true );
			
			m_oMaterials[ id ].bitmapData = lBmd;
		}
		parseScene( m_oCollada.library_visual_scenes.visual_scene[ 0 ] );
	}
	
}