/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author or authors.
Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License");
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
import sandy.util.LoaderQueue;
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
 * @author		(porting) Floris - FFlasher
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

	private var m_oCollada:Object;
	private var m_bYUp:Boolean;

	private var m_oMaterials:Object;

	/**
	 * Default path for COLLADA images.
	 * <p>Can this be done without?</p>
	 */
	public var RELATIVE_TEXTURE_PATH:String = ".";

	/**
	 * Creates a new COLLADA parser instance.
	 *
	 * @param p_sUrl		Can be either a string pointing to the location of the
	 * 						COLLADA file or an instance of an embedded COLLADA file.
	 * @param p_nScale		The scale factor.
	 */
	public function ColladaParser( p_sUrl, p_nScale:Number )
	{
		super( p_sUrl, p_nScale );
	}

	/**
	 * @private
	 * Starts the parsing process
	 *
	 * @param s				Boolean: loaded succesfully.
	 */
	private function parseData( s:Boolean ) : Void
	{
		super.parseData( s );

		// -- read the XML
		m_oCollada = XML2Object( m_oFile ).data.COLLADA;
		
		m_bYUp = ( m_oCollada.asset.up_axis.data == "Y_UP" );
		//m_bYUp = !m_bYUp;
			
		if( m_oCollada.library_images.image ) 
			m_oMaterials = loadImages( convertToArray( m_oCollada.library_images.image ) );
		else
			parseScene( convertToArray( m_oCollada.library_visual_scenes.visual_scene )[0] );
	}
	
	/**
	 * Parses the 3D scene
	 * @param p_oScene		COLLADA XML's scene node (as Object)
	 */
	private function parseScene( p_oScene:Object ) : Void
	{
		// -- local variables
		var l_oNodes:Array = convertToArray( p_oScene.node ); 
		var l_nNodeLen:Number = l_oNodes.length;

		for( var i:Number = 0; i < l_nNodeLen; i++ ) // -- loop through all the subnodes of the virtual scene node
		{
			var l_oNode:Node = parseNode( l_oNodes[i] );
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
	 * @param p_oNode		XML node (as Object) containing a node from the 3D scene
	 * @return 				A parsed Shape3D
	 */
	private function parseNode( p_oNode:Object ) : Node
	{
		// -- local variables
		var l_oNode:ATransformable;
		//var l_oMatrix : Matrix4 = new Matrix4();
		var l_sGeometryID:String;
		var l_oNodes:Object; // was first XMLList
		var l_nNodeLen:Number;
		var l_oVector:Vector;
		//var l_oPivot:Vector = new Vector();
		var l_oGeometry:Geometry3D = null;
		//var l_oScale : Transform3D;
		var i:Number;
		
		if( convertToArray( p_oNode.instance_geometry ).length  != 0 )
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
		if( convertToArray( p_oNode.scale ).length > 0 ) 
		{
			l_oVector = stringToVector( p_oNode.scale.data );
			// --
			formatVector( l_oVector );
			// --
			l_oNode.scaleX = l_oVector.x;
			l_oNode.scaleY = l_oVector.y;
			l_oNode.scaleZ = l_oVector.z;

		}
		
		// -- translation
		p_oNode.translate = convertToArray( p_oNode.translate );
		if( p_oNode.translate.length >= 1 ) 
		{
			var l_nTransAtt:Number = p_oNode.translate.length;
			for( i = 0; i < l_nTransAtt; i++ )
			{
				var l_sTranslationValue:String = "";
				// --
				var l_sAttTranslateValue:String = p_oNode.translate[i].attributes.sid;
				if( l_sAttTranslateValue ) l_sAttTranslateValue = l_sAttTranslateValue.toLowerCase();
					
				if( l_sAttTranslateValue == "translation" || l_sAttTranslateValue ==  "translate" )
						l_sTranslationValue = p_oNode.translate[i].data;
				else if( !l_sAttTranslateValue.length ) 
						l_sTranslationValue = p_oNode.translate[i].data;

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
		p_oNode.rotate = convertToArray( p_oNode.rotate );
		if( p_oNode.rotate.length == 1 ) 
		{
			var l_oRotations:Array = stringToArray( p_oNode.rotate[0].data );
				
			if( m_bYUp )
			{
				l_oNode.rotateAxis(	l_oRotations[ 0 ], l_oRotations[ 1 ], l_oRotations[ 2 ], l_oRotations[ 3 ] );
			}
			else
			{
				l_oNode.rotateAxis(	l_oRotations[ 0 ], l_oRotations[ 2 ], l_oRotations[ 1 ], l_oRotations[ 3 ] );
			}	
		} 
		else if( p_oNode.rotate.length == 3 ) 
		{
			for( var j:Number = 0; j < 3; j++ )
			{
				var l_oRot:Array = stringToArray( p_oNode.rotate[j].data );
				switch( p_oNode.rotate[j].attributes.sid.toLowerCase() )
				{
					case "rotatex":
					{
						if( l_oRot[ 3 ] != 0 )
						{
							if( m_bYUp ) 	l_oNode.rotateX = Number( l_oRot[ 3 ] );
							else 			l_oNode.rotateX = Number( l_oRot[ 3 ] );
						}
						break;
					}
					case "rotatey":
					{
						if( l_oRot[ 3 ] != 0 )
						{
							if( m_bYUp ) 	l_oNode.rotateY = Number( l_oRot[ 3 ] );
							else 			l_oNode.rotateZ = Number( l_oRot[ 3 ] );
						} 
						break;
					}
					case "rotatez":
					{
						if( l_oRot[ 3 ] != 0 ) 
						{
							if( m_bYUp ) 	l_oNode.rotateZ = Number( l_oRot[ 3 ] );
							else			l_oNode.rotateY = Number( l_oRot[ 3 ] );
						}
						break;
					}
				}
			}
		}

		// -- baked matrix
		if( convertToArray( p_oNode.matrix ).length > 0 ) 
		{
			stringToMatrix( p_oNode.matrix.data );
			//l_oShape.setPosition( l_oMatrix.n14, l_oMatrix.n34, l_oMatrix.n24 );
			//l_oNode.scaleX = l_oMatrix.n11;
			//l_oNode.scaleY = l_oMatrix.n33;
			//l_oNode.scaleZ = l_oMatrix.n22;
		}

		// -- loop through subnodes
		l_oNodes = convertToArray( p_oNode.node );
		l_nNodeLen = l_oNodes.length;

		for( i = 0; i < l_nNodeLen; i++ )
		{
			var l_oChildNode:Node = parseNode( l_oNodes[ i ] );
			// -- add the shape to the group node
			if( l_oChildNode != null )
				l_oNode.addChild( l_oChildNode );
		}

		// quick hack to get url-ed nodes parsed
		if( convertToArray( p_oNode.instance_node ).length != 0 )
		{
			var l_sNodeId:String = p_oNode.instance_node.attributes.url;
			if( ( l_sNodeId != "" ) && ( l_sNodeId.charAt( 0 ) == "#" ) )
			{
				l_sNodeId = l_sNodeId.substr( 1 );
					
				var l_oMatchingNodes:Object = new Object();
				var l_oMatchArray:Array = convertToArray( m_oCollada.library_nodes.node );
				for( var i in l_oMatchArray )
				{
					if( l_oMatchArray[ i ].attributes.id == l_sNodeId ) l_oMatchingNodes[ i ] = l_oMatchArray[ i ];
				}
				
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

		var l_oGeometry:Object = new Object();
		var l_oGeomArray:Array = convertToArray( m_oCollada.library_geometries.geometry );
		for( var i in l_oGeomArray )
		{
			if( l_oGeomArray[i].attributes.id == p_sGeometryID ) l_oGeometry = l_oGeomArray[i];
		}
		
		// -- triangles
		var l_oTriangles:Object = convertToArray( l_oGeometry.mesh.triangles )[0];
		if( l_oTriangles == null ) return null;
		var l_aTriangles:Array = stringToArray( l_oTriangles.p.data );
		var l_sMaterial:String = l_oTriangles.attributes.material;
		var l_nCount:Number = Number( l_oTriangles.attributes.count );
		var l_nStep:Number = convertToArray( l_oTriangles.input ).length;

		// -- get vertices float array
		var l_oTrianglesArray:Array = convertToArray( l_oTriangles.input );
		for( var i in l_oTrianglesArray )
		{
			if( l_oTrianglesArray[ i ].attributes.semantic == 'VERTEX' ) var l_sVerticesID:String = l_oTrianglesArray[ i ].attributes.source.split( '#' )[ 1 ];
		}
		
		var l_sPosSourceID:String;
		var l_oMeshArray:Array = convertToArray( l_oGeometry.mesh.vertices );
		for( var i in l_oMeshArray )
		{
			if( l_oMeshArray[i].attributes.id == l_sVerticesID ) 
			{
				for( var j in convertToArray( l_oMeshArray[i].input ) )
				{
					if( convertToArray( l_oMeshArray[i].input )[j].attributes.semantic == "POSITION" ) l_sPosSourceID =  convertToArray( l_oMeshArray[i].input )[j].attributes.source;
				}
			}
		}
		
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
			l_oOutpGeom.setVertex(	i,
									l_oVertex.x,
									l_oVertex.y,
									l_oVertex.z );
		}
		
		var l_sUVCoordID:String;
		var l_sNormalsID:String;
		
		for( var l_nUVCoordLength:Number = l_nNormalLength = n = 0; n < l_oTrianglesArray.length; n++ )
		{
			switch( l_oTrianglesArray[ n ].attributes.semantic ) 
			{
				
				case 'TEXCOORD' :
					l_nUVCoordLength++;
					l_sUVCoordID = l_oTrianglesArray[ n ].attributes.source.split( "#" )[ 1 ];
					break;
				
				case 'NORMAL' :
					l_nNormalLength++;
					l_sNormalsID = l_oTrianglesArray[ n ].attributes.source.split( "#" )[ 1 ];
					break;
					
			}
		}
		
		if( l_nUVCoordLength > 0 )
		{
			// -- get uvcoords float array
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
			
		if( l_nNormalLength > 0 )
		{
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
					l_oNormal.z	);*/
			}
		}

		l_aTriangles = convertTriangleArray( l_oTrianglesArray, l_aTriangles, l_nCount );
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
	 * @param p_oGeometry		An XMLList (as Object) containing space separated values
	 * @return 					An array containing parsed vectors
	 */
	private function getFloatArray( p_sSourceID:String, p_oGeometry:Object ) : Array
	{
		var l_nCount:Number;
		var l_aFloatArray:Array;
		var l_nOffset:Number;
		
		var l_aSourceArray:Array = convertToArray( l_oGeometry.mesh.source );
		for( var i in l_aSourceArray ) 
		{
			if( l_aSourceArray[ i ].attributes.id == p_sSourceID )
			{
				l_aFloatArray = l_aSourceArray[ i ].float_array.data.split( ' ' ); // FIXME content.split( ' ' ) will cause bugs?
				l_nCount = l_aSourceArray[ i ].technique_common.accessor.attributes.count;
				l_nOffset = l_aSourceArray[ i ].technique_common.accessor.attributes.stride;
			}
				
		}

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
										Number( l_aFloatArray[ i + 1 ]) , 0 );
			}
			l_aOutput.push( l_oCoords );
		}

		return l_aOutput;
	}

	/**
	 * The <triangles> element provides the information needed to bind vertex
	 * attributes together and then organize those vertices into individual
	 * triangles. This method binds the individual values to the given
	 * input semantics (can be VERTEX, TEXCOORD, NORMAL, ... )
	 *
	 * @param p_oInput				An XMLList (as Array) containing the input semantic elements
	 * @param p_aTriangles			An array containing the vertex attributes for a
	 * 								given number of triangles
	 * @param p_nTriangleCount		The number of triangles
	 * @return 						An array containing objects that hold vertex attributes
	 * 								for each input semantic
	 */
	private function convertTriangleArray( p_oInput:Array, p_aTriangles:Array, p_nTriangleCount:Number ) : Array
	{
		var l_nInput:Number = p_oInput.length;
		var l_nTriangles:Number = p_aTriangles.length;
		var l_aOutput:Array = new Array();
		var l_nValuesPerTriangle:Number = l_nTriangles / p_nTriangleCount;
		var l_nMaxOffse:Number;

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
	 * Returns the variable converted into an array. 
	 * When the variable is no array, return an array with the variable. 
	 *
	 * @param  src	Variable to convert in an array.
	 * @return 		The resulting array.
	 */
	private function convertToArray( src ) : Array
	{
		if( !src ) return null;
		else if( src instanceof Array ) return src;
		else return Array( src );
	}

	/**
	 * Converts a space separated string to an array
	 *
	 * @param p_sValues		A string containing space separated values
	 * @return 				The resulting array
	 */
	private function stringToArray( p_sValues:String ) : Array
	{
		var l_aValues:Array = p_sValues.split( ' ' ); // FIXME content.split( ' ' ) will cause bugs?
		var l_nValues:int = l_aValues.length;

		for( var i:Number = 0; i < l_nValues; i++ )
		{
			l_aValues[i] = Number( l_aValues[i] );
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
		var l_aValues:Array = p_sValues.split( ' ' ); // FIXME content.split( ' ' ) will cause bugs?
		var l_nValues:Number = l_aValues.length;
		// --
		if( l_nValues != 3 )
			throw new Error( "ColladaParser.stringToVector(): A vector must have 3 values" );
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
		var l_aValues:Array = p_sValues.split( ' ' ); // FIXME content.split( ' ' ) will cause bugs?
		var l_nValues:Number = l_aValues.length;

		if( l_nValues != 16 )
			throw new Error( "ColladaParser.stringToMatrix(): A vector must have 16 values" );

		var l_oMatrix4 : Matrix4 = new Matrix4( l_aValues[ 0 ], l_aValues[ 1 ], l_aValues[ 2 ], l_aValues[ 3 ],
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
	 * @param p_oNode		The XML node (as Object) containing material information
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
			var l_oMaterial:Object;
			var l_aMaterialArray:Array = convertToArray( m_oCollada.library_materials.material );
			for( var j in l_aMaterialArray )
			{
				if( l_aMaterialArray[ j ].attributes.id == p_oNodeMaterial[ i ].attributes.target.split( "#" )[ 1 ] ) l_oMaterial = l_aMaterialArray[ a ];
			}
			
			// -- get the corresponding effect
			var l_sEffectID:String = l_oMaterial.instance_effect.attributes.url.split( "#" )[ 1 ];

			var l_oEffectPre:Object;
			var l_aEffectArray:Array = convertToArray( m_oCollada.library_effects.effect );
			for( var i in l_aEffectArray )
			{
				if( l_aEffectArray[ i ].attributes.id == l_sEffectID ) l_oEffectPre = l_aEffectArray[ i ];
			}
			
			var l_oEffect:Object = ( l_sEffectID == "" )
				? convertToArray( convertToArray( m_oCollada.library_effects.effect )[ 0 ] )[ 0 ]
				: l_oEffectPre;

			// -- no textures here or colors defined
			
			if( l_oEffect./* what here */.texture.length() == 0 && convertToArray( l_oEffect.profile_COMMON.technique.phong ).length == 0 ) return m_oStandardAppearance;

			// --------------------------------------------------- GA HIER VERDER ----------------------------------------------------------
			
			if( l_oEffect..texture.length() > 0 )
			{
				// -- get the texture ID and use it to get the surface source
				var l_sTextureID : String = l_oEffect..texture[ 0 ].@texture;
				var l_sSurfaceID : String = l_oEffect..newparam.( @sid == l_sTextureID ).sampler2D.source;

				// -- now get the image ID
				var l_sImageID : String = l_oEffect..newparam.( @sid == l_sSurfaceID ).surface.init_from;
				// -- get image's location on the hard drive

				if( m_oMaterials[ l_sImageID ].bitmapData ) l_oAppearance = new Appearance( new BitmapMaterial( m_oMaterials[ l_sImageID ].bitmapData ) );
				if( l_oAppearance == null ) l_oAppearance = m_oStandardAppearance;
			}
			else if( l_oEffect..phong.length() > 0 )
			{
				// -- get the ambient color
				var l_aColors : Array = stringToArray( l_oEffect..phong..ambient.color );
				var l_nColor : Number;

				var r : int = NumberUtil.constrain( l_aColors[0] * 255, 0, 255 );
				var g : int = NumberUtil.constrain( l_aColors[1] * 255, 0, 255 );
				var b : int = NumberUtil.constrain( l_aColors[2] * 255, 0, 255 );

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
	 * @param p_oLibImages		An XMLList (as Array) containing information about the images
	 * @return 					An object array containg the object ID, filename
	 * 							and loader data
	 */
	private function loadImages( p_oLibImages:Array ) : Object
	{
		var l_oImages : Object = new Object();
		var l_oQueue : LoaderQueue = new LoaderQueue();

		for each( var l_oImage : XML in p_oLibImages )
		{
			var l_oInitFrom : String = l_oImage.init_from;
			l_oImages[ l_oImage.@id ] = {
				id : l_oImage.@id,
				fileName : l_oInitFrom.substring( l_oInitFrom.lastIndexOf( "/" ) + 1, l_oInitFrom.length )
			}

			l_oQueue.add(
				l_oImage.@id,
				new URLRequest( RELATIVE_TEXTURE_PATH + "/" + l_oImages[ l_oImage.@id ].fileName )
			);
		}
		l_oQueue.addEventListener( QueueEvent.QUEUE_COMPLETE, imageQueueCompleteHandler );
		l_oQueue.start();

		return l_oImages;
	}

	/**
	 * The event handler that is fired when the image loading queue has finished
	 * loading. Bitmapdata is transfered to a material array and the parseScene
	 * method is called.
	 *
	 * @param p_oEvent		Event object containing LoaderQueue information
	 */
	private function imageQueueCompleteHandler( p_oEvent : QueueEvent ) : void
	{
		var l_oLoaders : Object = p_oEvent.loaders;

		for each( var l_oLoader : Object in l_oLoaders )
		{
			if( l_oLoader.loader.content )
				m_oMaterials[ l_oLoader.name ].bitmapData = Bitmap( l_oLoader.loader.content ).bitmapData;
		}

		parseScene( convertToArray( m_oCollada.library_visual_scenes.visual_scene )[0] );
	}
	
}