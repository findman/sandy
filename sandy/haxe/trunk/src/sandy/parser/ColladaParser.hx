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
package sandy.parser;

import flash.display.Bitmap;
import flash.events.Event;
import flash.net.URLRequest;

import sandy.core.data.BezierPath;
import sandy.core.data.BezierPath;
import sandy.core.data.Edge3D;
import sandy.core.data.Matrix4;
import sandy.core.data.Plane;
import sandy.core.data.Polygon;
import sandy.core.data.PrimitiveFace;
import sandy.core.data.Quaternion;
import sandy.core.data.Quaternion;
import sandy.core.data.UVCoord;
import sandy.core.data.Vector;
import sandy.core.data.Vertex;
import sandy.core.scenegraph.ATransformable;
import sandy.core.scenegraph.Camera3D;
import sandy.core.scenegraph.Geometry3D;
import sandy.core.scenegraph.Group;
import sandy.core.scenegraph.IDisplayable;
import sandy.core.scenegraph.Node;
import sandy.core.scenegraph.Shape3D;
import sandy.core.scenegraph.Shape3D;
import sandy.core.scenegraph.Sound3D;
import sandy.core.scenegraph.Sprite2D;
import sandy.core.scenegraph.Sprite3D;
import sandy.core.scenegraph.TransformGroup;
import sandy.events.QueueEvent;
import sandy.materials.Appearance;
import sandy.materials.Appearance;
import sandy.materials.BitmapMaterial;
import sandy.materials.ColorMaterial;
import sandy.materials.Material;
import sandy.materials.Material;
import sandy.materials.MaterialManager;
import sandy.materials.MaterialType;
import sandy.materials.MaterialType;
import sandy.materials.MovieMaterial;
import sandy.materials.VideoMaterial;
import sandy.materials.VideoMaterial;
import sandy.materials.WireFrameMaterial;
import sandy.materials.ZShaderMaterial;
import sandy.materials.ZShaderMaterial;
import sandy.util.LoaderQueue;
import sandy.util.NumberUtil;

import xpath.XPath;
import xpath.xml.XPathHxXml;
import xpath.xml.XPathXml;

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
 * @since		1.0
 * @version		3.0
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
 *     [Embed( source="/path/to/my/colladafile.dae", mimeType="application/octet-stream" )]
 *     private var MyCollada:Class;
 *
 *     ...
 *
 *     var parser:IParser = Parser.create( new MyCollada(), Parser.COLLADA );
 * </listing>
 */

class ColladaParser extends AParser, implements IParser
{
	private var m_oCollada : XPathHxXml;
	private var m_bYUp : Bool;

	private var m_oMaterials : Hash<Dynamic>;

	/**
	 * Default path for COLLADA images.
	 * <p>Can this be done without??</p>
	 */
	public var RELATIVE_TEXTURE_PATH : String;

	/**
	 * Creates a new COLLADA parser instance.
	 *
	 * @param p_sUrl		Can be either a string pointing to the location of the
	 * 						COLLADA file or an instance of an embedded COLLADA file.
	 * @param p_nScale		The scale factor.
	 */
	public function new( p_sUrl:Dynamic, p_nScale:Float )
	{
		RELATIVE_TEXTURE_PATH  = ".";
		super( p_sUrl, p_nScale );
	}

	/**
	 * @private
	 * Starts the parsing process
	 *
	 * @param e				The Event object
	 */
	private override function parseData( ?e:Event ) : Void
	{
		super.parseData( e );

		// -- read the XML
		//m_oCollada = XML( m_oFile );
		m_oCollada = XPathHxXml.wrapNode( Xml.parse( m_oFile ) );

		//default xml namespace = m_oCollada.namespace();
		

		m_bYUp = ((new XPath('//asset/up_axis')).selectNode(m_oCollada).getStringValue() == "Y_UP" ) ? true : false;
		m_bYUp = !m_bYUp;
		
		if( Lambda.count( (new XPath('//library_images')).selectNodes(m_oCollada)) > 0 )
			m_oMaterials = loadImages( new XPath('//library_images/image').selectNodes(m_oCollada));
		else
			parseScene( new XPath('//library_visual_scenes/visual_scene').selectNode(m_oCollada));
	}

	private function parseScene( p_oScene : XPathXml ) : Void
	{
		// -- local variables
		var l_oNodes : Iterable<XPathXml> = (new XPath('node')).selectNodes(p_oScene);

		for( l_oN in l_oNodes )
		{
			var l_oNode : Node = parseNode( l_oN );
			// -- add the shape to the group node
			if( l_oNode != null )
				m_oGroup.addChild( l_oNode );
		}

		// -- Parsing is finished
		var l_eOnInit : ParserEvent = new ParserEvent( ParserEvent.INIT );
		l_eOnInit.group = m_oGroup;
		dispatchEvent( l_eOnInit );
	}

	private function parseNode( p_oNode : XPathXml ) : Node
	{
		// -- local variables
		var l_oNode:ATransformable = null;
		//var l_oMatrix : Matrix4 = new Matrix4();
		var l_sGeometryID : String;
		var l_oNodes : Iterable<XPathXml>;
		var l_nNodeLen : Int;
		var l_oVector : Vector;
		//var l_oPivot:Vector = new Vector();
		var l_oGeometry : Geometry3D = null;
		//var l_oScale : Transform3D;
		var i:Int;
		
		if( Lambda.count( new XPath('./instance_geometry').selectNodes(p_oNode) ) != 0 )
		{
			var l_aGeomArray:Array<String>;
			var l_oAppearance : Appearance = m_oStandardAppearance;
			l_oGeometry = new Geometry3D();
			l_oAppearance = getAppearance( p_oNode );

			l_aGeomArray = new XPath('instance_geometry/@url').selectNode(p_oNode).getStringValue().split( "#" );
			l_sGeometryID = l_aGeomArray[ 1 ];
			// -- get the vertices
			l_oGeometry = getGeometry( l_sGeometryID, m_oMaterials );

			if( l_oGeometry == null ) return null;
			// -- create the new shape
			l_oNode = new Shape3D( new XPath('@name').selectNode(p_oNode).getStringValue(), l_oGeometry, l_oAppearance );
		}
		else
		{
			l_oNode = new TransformGroup( new XPath('@name').selectNode(p_oNode).getStringValue() );
		}
		
		// -- scale
		if( Lambda.count( new XPath( './scale' ).selectNodes(p_oNode) ) > 0 ) 
		{
			l_oVector = stringToVector( new XPath( './scale' ).selectNode(p_oNode).getStringValue() );
			// --
			formatVector( l_oVector );
			// --
			l_oNode.scaleX = l_oVector.x;
			l_oNode.scaleY = l_oVector.y;
			l_oNode.scaleZ = l_oVector.z;

		}
		// -- translation
		if( Lambda.count( new XPath( './translate' ).selectNodes(p_oNode) ) >= 1 ) 
		{
			var l_aTransAtt:Iterable<XPathXml> = new XPath( './translate' ).selectNodes(p_oNode);
			for( l_oT in l_aTransAtt )
			{
				var l_sTranslationValue:String = "";
				// --
				var l_oAttTranslateNode:XPathXml = new XPath('./@sid').selectNode( l_oT );
				var l_sAttTranslateValue:String = "";
				if( l_oAttTranslateNode != null ) l_sAttTranslateValue = l_oAttTranslateNode.getStringValue().toLowerCase();
				
				if( l_sAttTranslateValue == "translation" || l_sAttTranslateValue ==  "translate" )
						l_sTranslationValue = l_oT.getStringValue();
				else if( l_sAttTranslateValue.length == 0 ) 
						l_sTranslationValue = l_oT.getStringValue();

				if( l_sTranslationValue.length > 0 )
				{
					// --
					l_oVector = stringToVector( l_sTranslationValue );
					l_oVector.scale(m_nScale);
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
			if( Lambda.count( new XPath( './rotate' ).selectNodes(p_oNode) ) == 1 ) 
			{
			var l_oRotations : Array<Float> = stringToArray( new XPath( './rotate' ).selectNode(p_oNode).getStringValue() );
			
			if( m_bYUp )
			{
				l_oNode.rotateAxis(	l_oRotations[ 0 ], l_oRotations[ 1 ], l_oRotations[ 2 ], l_oRotations[ 3 ] );
			}
			else
			{
				l_oNode.rotateAxis(	l_oRotations[ 0 ], l_oRotations[ 2 ], l_oRotations[ 1 ], l_oRotations[ 3 ] );
			}	
		} 
		else if( Lambda.count( new XPath( './rotate' ).selectNodes(p_oNode) ) == 3 ) 
		{
			for( l_oN in (new XPath( './rotate' ).selectNodes(p_oNode)) )
			{
				var l_oRot : Array<Float> = stringToArray( l_oN.getStringValue() );

				switch( new XPath('@sid').selectNode( l_oN ).getStringValue().toLowerCase() )
				{
					case "rotatex":
					{
						if( l_oRot[ 3 ] != 0 )
						{
							if( m_bYUp ) 	l_oNode.rotateX = l_oRot[ 3 ];
							else 			l_oNode.rotateX = l_oRot[ 3 ];
						}
						break;
					}
					case "rotatey":
					{
						if( l_oRot[ 3 ] != 0 )
						{
							if( m_bYUp ) 	l_oNode.rotateY = l_oRot[ 3 ];
							else 			l_oNode.rotateZ = l_oRot[ 3 ];
						} 
						break;
					}
					case "rotatez":
					{
						if( l_oRot[ 3 ] != 0 ) 
						{
							if( m_bYUp ) 	l_oNode.rotateZ = l_oRot[ 3 ];
							else			l_oNode.rotateY = l_oRot[ 3 ];
						}
						break;
					}
				}
			}
		}

		// -- baked matrix
		if( Lambda.count( new XPath( './matrix' ).selectNodes(p_oNode) ) > 0 ) 
		{
			stringToMatrix( new XPath( './matrix' ).selectNode(p_oNode).getStringValue() );
			//l_oShape.setPosition( l_oMatrix.n14, l_oMatrix.n34, l_oMatrix.n24 );
			//l_oNode.scaleX = l_oMatrix.n11;
			//l_oNode.scaleY = l_oMatrix.n33;
			//l_oNode.scaleZ = l_oMatrix.n22;
		}

		// -- loop through subnodes
		l_oNodes = new XPath( './node' ).selectNodes(p_oNode);
		//l_nNodeLen = l_oNodes.length();

		for( l_oN in l_oNodes )
		{
			var l_oChildNode : Node = parseNode( l_oN );
			// -- add the shape to the group node
			if( l_oChildNode != null )
				l_oNode.addChild( l_oChildNode );
		}

		// quick hack to get url-ed nodes parsed
		if( Lambda.count( new XPath( './instance_node' ).selectNodes(p_oNode) ) != 0 )
		{
			var l_sNodeId:String = new XPath( 'instance_node/@url' ).selectNode(p_oNode).getStringValue();
			if ((l_sNodeId != "") && (l_sNodeId.charAt(0) == "#"))
			{
				l_sNodeId = l_sNodeId.substr(1);
				var l_oMatchingNodes:Iterable<XPathXml> = new XPath( '//library_nodes/node[ @id = "' + l_sNodeId + '"' ).selectNodes(m_oCollada);
				for ( l_oMatchingNode in l_oMatchingNodes ) {
					var l_oNode3D:Node = parseNode( l_oMatchingNode );
					// -- add the shape to the group node
					if( l_oNode3D != null )
						l_oNode.addChild( l_oNode3D );
				}
			}
		}

		//l_oShape.matrix = l_oMatrix;
		return l_oNode;
	}

	private function getGeometry( p_sGeometryID : String, p_oMaterials : Hash<Dynamic> ) :  Geometry3D
	{
		var i : Int;
		var l_oOutpGeom : Geometry3D = new Geometry3D();
		var l_oGeometry : XPathXml = new XPath( '//library_geometries/geometry[ ./@id = "' + p_sGeometryID + '" ]' ).selectNode( m_oCollada );

		// -- triangles
		var l_oTriangles : XPathXml = new XPath( './mesh/triangles' ).selectNode(l_oGeometry);
		if( l_oTriangles == null ) return null;
		var l_aTriangles : Array<Float> = stringToArray( new XPath( './p' ).selectNode(l_oTriangles).getStringValue() );
		var l_sMaterial : String = new XPath( './@material' ).selectNode(l_oTriangles).getStringValue();
		var l_nCount : Int = Std.parseInt( new XPath( './@count' ).selectNode(l_oTriangles).getStringValue() );
		var l_nStep : Int = Lambda.count( new XPath( './input' ).selectNodes(l_oTriangles) );

		// -- get vertices float array
		var l_sVerticesID : String = new XPath( './input[ ./@semantic = "VERTEX" ]/@source' ).selectNode(l_oTriangles).getStringValue().split("#")[1];
		var l_sPosSourceID : String = new XPath( './/vertices[ ./@id = "' + l_sVerticesID + '"]/input[ ./@semantic = "POSITION" ]/@source' ).selectNode(l_oGeometry).getStringValue().split("#")[1];
		var l_aVertexFloats : Array<Vector> = getFloatArray( l_sPosSourceID, l_oGeometry );
		var l_nVertexFloat : Int = l_aVertexFloats.length;
		//var l_aVertices : Array = new Array();

		// -- set vertices
		for( i in 0...l_nVertexFloat )
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

		if( Lambda.count( new XPath( './input[ ./@semantic = "TEXCOORD" ]' ).selectNodes(l_oTriangles) ) > 0 )
		{
			// -- get uvcoords float array
			var l_sUVCoordsID : String = new XPath( './input[ @semantic = "TEXCOORD" ]/@source' ).selectNode(l_oTriangles).getStringValue().split("#")[1];
			var l_aUVCoordsFloats : Array<Vector> = getFloatArray( l_sUVCoordsID, l_oGeometry );
			var l_nUVCoordsFloats : Int = l_aUVCoordsFloats.length;

			// -- set uvcoords
			for( i in 0...l_nUVCoordsFloats )
			{
				var l_oUVCoord:Vector = l_aUVCoordsFloats[ i ];

				l_oOutpGeom.setUVCoords( i,l_oUVCoord.x, 1 - l_oUVCoord.y );
			}
		}

		// -- get normals float array
		// THOMAS TODO: Why using VertexNormal?  It is face normal !
		if( Lambda.count( new XPath( './input[ @semantic = "NORMAL" ]' ).selectNodes(l_oTriangles) ) > 0 )
		{
			var l_sNormalsID : String = new XPath( './input[ @semantic = "NORMAL" ]/@source' ).selectNode(l_oTriangles).getStringValue().split("#")[1];
			var l_aNormalFloats : Array<Vector> = getFloatArray( l_sNormalsID, l_oGeometry );
			var l_nNormalFloats : Int = l_aNormalFloats.length;

			// -- set normals
			for( i in 0...l_nNormalFloats )
			{
				var l_oNormal:Vector = l_aNormalFloats[ i ];
				// STRANGE, AREN'T NORMAL VECTORS NORMALIZED?
				l_oNormal.normalize();
				// --
				formatVector(l_oNormal);
				// --
				if( !m_bYUp ) l_oOutpGeom.setFaceNormal( i, l_oNormal.x, l_oNormal.y, l_oNormal.z	);
			}
		}
		var l_aTrianglez:Array<Hash<Array<Float>>> = convertTriangleArray( new XPath( './input' ).selectNodes(l_oTriangles), l_aTriangles, l_nCount );
		var l_nTriangeLength : Int = l_aTrianglez.length;

		for( i in 0...l_nTriangeLength )
		{
			var l_aVertex : Array<Float> = l_aTrianglez[ i ].get( 'VERTEX' );
			var l_aNormals : Array<Float> = l_aTrianglez[ i ].get( 'NORMAL' );
			var l_aUVs : Array<Float> = l_aTrianglez[ i ].get( 'TEXCOORD' );

			if( m_bYUp )
			{
				l_oOutpGeom.setFaceVertexIds( i, [l_aVertex[ 0 ], l_aVertex[ 1 ], l_aVertex[ 2 ]] );
				if( l_aUVs != null ) l_oOutpGeom.setFaceUVCoordsIds( i, [l_aUVs[ 0 ], l_aUVs[ 1 ], l_aUVs[ 2 ]] );
			}
			else
			{
				l_oOutpGeom.setFaceVertexIds( i, [l_aVertex[ 0 ], l_aVertex[ 1 ], l_aVertex[ 2 ]] );
				if( l_aUVs != null ) l_oOutpGeom.setFaceUVCoordsIds( i, [l_aUVs[ 0 ], l_aUVs[ 1 ], l_aUVs[ 2 ]] );
			}
		}

		return l_oOutpGeom;
	}

	private function getFloatArray( p_sSourceID : String, p_oGeometry : XPathXml ) : Array<Vector>
	{
		//var l_aFloatArray : Array = new XPath( './/..source/.( @id == p_sSourceID ).float_array ).selectNode(p_oGeometry).getStringValue().split(/\s+/);
		var l_aFloatArray : Array<String> = new XPath( './/source[ @id = "' + p_sSourceID + '" ]/float_array' ).selectNode(p_oGeometry).getStringValue().split(" ");
		var l_nCount:UInt = Std.parseInt( new XPath( './/source[ @id = "' + p_sSourceID + '"]/technique_common/accessor/@count' ).selectNode(p_oGeometry).getStringValue() );
		var l_nOffset:UInt = Std.parseInt( new XPath( './/source[ @id = "' + p_sSourceID + '"]/technique_common/accessor/@stride' ).selectNode(p_oGeometry).getStringValue() );

		var l_nFloatArray : Int = l_aFloatArray.length;
		var l_aOutput : Array<Vector> = new Array();

		var i:Int = 0;
		while(  i < l_nFloatArray )
		{
			var l_oCoords : Vector = null;
			// FIX FROM THOMAS to solve the case there's only UV coords exported instead of UVW. To clean
			if( l_nOffset == 3 )
			{
				l_oCoords = new Vector( Std.parseFloat( l_aFloatArray[ i ] ),
										Std.parseFloat( l_aFloatArray[ i + 1 ] ),
										Std.parseFloat( l_aFloatArray[ i + 2 ] ) );
			}
			else if( l_nOffset == 2 )
			{
				l_oCoords =	new Vector( Std.parseFloat( l_aFloatArray[ i ] ),
										Std.parseFloat( l_aFloatArray[ i + 1 ]) , 0 );
			}
			l_aOutput.push( l_oCoords );
			i += l_nOffset;
		}

		return l_aOutput;
	}

	private function convertTriangleArray( p_oInput : Iterable<XPathXml>, p_aTriangles : Array<Float>, p_nTriangleCount : Int ) : Array<Hash<Array<Float>>>
	{
		var l_nTriangles : Int = p_aTriangles.length;
		var l_aOutput : Array<Hash<Array<Float>>> = new Array();
		var l_nValuesPerTriangle : Int = Std.int( l_nTriangles / p_nTriangleCount );
		var l_nMaxOffset : Int = 0;

		var l_aInputA:Array<XPathXml> = Lambda.array(p_oInput);
		var l_aInputB:Array<XPathXml> = l_aInputA.copy();
		for( l_oI in l_aInputA )
		{
			l_nMaxOffset = Std.int( Math.max( l_nMaxOffset, Std.parseFloat( new XPath( './@offset' ).selectNode(l_oI).getStringValue() ) ) );
		}
		l_nMaxOffset += 1;
		// -- iterate through all triangles
		var l_oSemantic:XPath = new XPath( './@semantic' );
		var l_oOffset:XPath = new XPath( './@offset' );
		for( i in 0...p_nTriangleCount )
		{
			var semantic : Hash<Array<Float>> = new Hash();

			for( j in 0...l_nValuesPerTriangle )
			{
				for( l_oI in l_aInputB )
				{
					if( Std.parseInt( l_oOffset.selectNode( l_oI ).getStringValue() ) == j % l_nMaxOffset )
					{
						if( semantic.get( l_oSemantic.selectNode(l_oI).getStringValue() ) == null )
							semantic.set( l_oSemantic.selectNode(l_oI).getStringValue(), new Array() );

						var index:Int = ( i * l_nValuesPerTriangle ) + j;
						semantic.get( l_oSemantic.selectNode(l_oI).getStringValue() ).push( p_aTriangles[ index ] );
					}
				}
			}

			l_aOutput.push( semantic );
		}

		return l_aOutput;
	}

	private function stringToArray( p_sValues : String ) : Array<Float>
	{
		//var l_aValues : Array = p_sValues.split(/\s+/);
		var l_aValues : Array<String> = p_sValues.split(" ");
		var l_nValues : Array<Float> = new Array();

		for( l_oV in l_aValues )
		{
			l_nValues.push( Std.parseFloat( l_oV ) );
		}

		return l_nValues;
	}

	private function stringToVector( p_sValues : String ) : Vector
	{
		//var l_aValues : Array = p_sValues.split(/\s+/);
		var l_aValues : Array<String> = p_sValues.split(" ");
		var l_nValues : Int = l_aValues.length;
		// --
		if( l_nValues != 3 )
			throw "ColladaParser.stringToVector(): A vector must have 3 values";
		// --
		return new Vector( Std.parseFloat( l_aValues[ 0 ] ), Std.parseFloat( l_aValues[ 1 ] ), Std.parseFloat( l_aValues[ 2 ] ) );
	}

	private function stringToMatrix( p_sValues : String ) : Matrix4
	{
		//var l_aValues : Array = p_sValues.split(/\s+/);
		var l_aValues : Array<String> = p_sValues.split(" ");
		var l_nValues : Int = l_aValues.length;

		if( l_nValues != 16 )
			throw "ColladaParser.stringToMatrix(): A vector must have 16 values";

		var l_oMatrix4 : Matrix4 = new Matrix4(
			Std.parseFloat( l_aValues[ 0 ] ), Std.parseFloat( l_aValues[ 1 ] ), Std.parseFloat( l_aValues[ 2 ] ), Std.parseFloat( l_aValues[ 3 ] ),
			Std.parseFloat( l_aValues[ 4 ] ), Std.parseFloat( l_aValues[ 5 ] ), Std.parseFloat( l_aValues[ 6 ] ), Std.parseFloat( l_aValues[ 7 ] ),
			Std.parseFloat( l_aValues[ 8 ] ), Std.parseFloat( l_aValues[ 9 ] ), Std.parseFloat( l_aValues[ 10 ] ), Std.parseFloat( l_aValues[ 11 ] ),
			Std.parseFloat( l_aValues[ 12 ] ), Std.parseFloat( l_aValues[ 13 ] ), Std.parseFloat( l_aValues[ 14 ] ), Std.parseFloat( l_aValues[ 15 ] )
		);

		return l_oMatrix4;
	}
	
	
	private function formatVector( p_oVect:Vector ):Void
	{
		var tmp:Float;
		if( m_bYUp )
		{
			p_oVect.x = -p_oVect.x;
		}
	}

	private function getAppearance( p_oNode : XPathXml ) : Appearance
	{
		// -- local variables
		var l_oAppearance : Appearance = null;

		// -- Get this node's instance materials
		//for ( l_oInstMat in (new XPath( './///instance_material' ).selectNodes(p_oNode)) )
		for ( l_oInstMat in (new XPath( './/instance_material' ).selectNodes(p_oNode)) )
		{
			// -- get the corresponding material from the library
			var l_oMaterial : XPathXml = new XPath( '//library_materials/material[ ./@id = "' + new XPath( '@target' ).selectNode(l_oInstMat).getStringValue().split( "#" )[ 1 ] + '" ]' ).selectNode(m_oCollada);
			// -- get the corresponding effect
			var l_sEffectID : String = new XPath( './instance_effect/@url' ).selectNode(l_oMaterial).getStringValue().split( "#" )[ 1 ];

				//? new XPath( './library_effects/effect//' ).selectNode(m_oCollada)
			var l_oEffect : XPathXml = ( l_sEffectID == "" )
				? new XPath( '//library_effects/effect/' ).selectNode(m_oCollada)
				: new XPath( '//library_effects/effect[ ./@id = "' + l_sEffectID + '" ]' ).selectNode(m_oCollada);

			// -- no textures here or colors defined
			if( Lambda.count( new XPath( './/texture' ).selectNodes(l_oEffect) ) == 0 && Lambda.count( new XPath( './/phong' ).selectNodes(l_oEffect) ) == 0 ) return m_oStandardAppearance;

			if( Lambda.count( new XPath( './/texture' ).selectNodes(l_oEffect) ) > 0 )
			{
				// -- get the texture ID and use it to get the surface source
				var l_sTextureID : String = new XPath( './/texture/@texture' ).selectNode(l_oEffect).getStringValue();
				var l_sSurfaceID : String = new XPath( './/newparam[ ./@sid = "' + l_sTextureID + '" ]/sampler2D/source' ).selectNode(l_oEffect).getStringValue();

				// -- now get the image ID
				var l_sImageID : String = new XPath( './/newparam[ ./@sid = "' + l_sSurfaceID + '" ]/surface/init_from' ).selectNode(l_oEffect).getStringValue();
				// -- get image's location on the hard drive

				if( m_oMaterials.get( l_sImageID ).bitmapData != null) l_oAppearance = new Appearance( new BitmapMaterial( m_oMaterials.get( l_sImageID ).bitmapData ) );
				if( l_oAppearance == null ) l_oAppearance = m_oStandardAppearance;
			}
			else if( Lambda.count( new XPath( './/phong' ).selectNodes(l_oEffect) ) > 0 )
			{
				// -- get the ambient color
				//var l_aColors : Array<Float> = stringToArray( new XPath( './//phong/ambient/color' ).selectNode(l_oEffect).getStringValue() );
				var l_aColors : Array<Float> = stringToArray( new XPath( './/phong/ambient/color' ).selectNode(l_oEffect).getStringValue() );
				var l_nColor : Int;

				var r : Int = Std.int( NumberUtil.constrain( l_aColors[0] * 255, 0, 255 ) );
				var g : Int = Std.int( NumberUtil.constrain( l_aColors[1] * 255, 0, 255 ) );
				var b : Int = Std.int( NumberUtil.constrain( l_aColors[2] * 255, 0, 255 ) );

				l_nColor =  r << 16 | g << 8 |  b;

				l_oAppearance = new Appearance( new ColorMaterial( l_nColor, l_aColors[ 3 ] * 100 ) );
			}
		}

		if( l_oAppearance == null ) return m_oStandardAppearance;
		else return l_oAppearance;
	}


	private function loadImages( p_oLibImages : Iterable<XPathXml> ) : Hash<Dynamic>
	{
		var l_oImages : Hash<Dynamic> = new Hash();
		var l_oQueue : LoaderQueue = new LoaderQueue();

		for ( l_oImage in p_oLibImages )
		{
			var l_oInitFrom : String = new XPath('init_from').selectNode(l_oImage).getStringValue();
			l_oImages.set( new XPath('@id').selectNode(l_oImage).getStringValue() , {
				bitmapData: null,
				id : new XPath('@id').selectNode(l_oImage).getStringValue(),
				fileName : l_oInitFrom.substr( l_oInitFrom.lastIndexOf( "/" ) + 1, l_oInitFrom.length )
			});

			l_oQueue.add(
				new XPath('@id').selectNode(l_oImage).getStringValue(),
				new URLRequest( RELATIVE_TEXTURE_PATH + "/" + l_oImages.get( new XPath('@id').selectNode(l_oImage).getStringValue() ).fileName )
			);
		}
		l_oQueue.addEventListener( QueueEvent.QUEUE_COMPLETE, imageQueueCompleteHandler );
		l_oQueue.start();

		return l_oImages;
	}

	private function imageQueueCompleteHandler( p_oEvent : QueueEvent ) : Void
	{
		var l_oLoaders : Hash<QueueElement> = p_oEvent.loaders;

		for ( l_oLoader in l_oLoaders )
		{
			if( l_oLoader.loader.content != null && Reflect.hasField( l_oLoader.loader.content, "bitmapData" ) )
				m_oMaterials.get( l_oLoader.name ).bitmapData = Reflect.field( l_oLoader.loader.content, "bitmapData" );
		}

		parseScene( new XPath('//library_visual_scenes/visual_scene').selectNode(m_oCollada) );
	}
}

