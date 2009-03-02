/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author Thomas PFEIFFER
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

package sandy.core.data;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

import sandy.core.Scene3D;
import sandy.core.interaction.VirtualMouse;
import sandy.core.scenegraph.Geometry3D;
import sandy.core.scenegraph.IDisplayable;
import sandy.core.scenegraph.Shape3D;
import sandy.events.BubbleEvent;
import sandy.events.BubbleEventBroadcaster;
import sandy.materials.Appearance;
import sandy.math.IntersectionMath;
import sandy.math.VectorMath;
import sandy.view.Frustum;
import sandy.events.Shape3DEvent;

/**
 * Polygon's are the building blocks of visible 3D shapes.
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		Mirek Mencel
 * @author Niel Drummond - haXe port 
 * 
 */
class Polygon implements IDisplayable
{
// _______
// STATICS_______________________________________________________
	private static var _ID_:Int = 0;
	
	/**
	 * This property lists all the polygons.
	 * This is an helping property since it allows to retrieve a polygon instance from its unique ID.
	 * Polygon objects have an unique ID with myPolygon.id.
	 * Using : Polygon.POLYGON_MAP[myPolygon.id] returns myPolygon (for sure this example has no interesst except showing the use of the property.
	 */
	public static var POLYGON_MAP:IntHash<Polygon> = new IntHash();
// ______
// PUBLIC________________________________________________________
	/**
	 * [READ-ONLY] property
	 * Unique polygon ID Number.
	 */
	public var id:Int;

	/**
	 * [READ-ONLY] property.
	 * Link to the Shape3D instance this polygon is related too.
	 */
	public var shape:Shape3D;
	
	/**
	 * [READ-ONLY] property.
	 * Refers to the Scene3D the shape is linked to.
	 */
	public var scene:Scene3D;
	
	/**
	 * [READ-ONLY] property.
	 * Specify if the polygon has been clipped
	 */
	public var isClipped:Bool;
	/**
	 * [READ-ONLY] property.
	 * Array of clipped vertices. Check isClipped property first to see if this array shall be containing the useful data or not.
	 */
	public var cvertices:Array<Vertex>;
	/**
	 * [READ-ONLY] property.
	 * Array of original vertices.
	 */
	public var vertices:Array<Vertex>;
	/**
	 * [READ-ONLY] property.
	 */
	public var vertexNormals:Array<Vertex>;
	/**
	 * [READ-ONLY] property.
	 */
	public var normal:Vertex;
	/**
	 * [READ-ONLY] property.
	 */
	public var aUVCoord:Array<UVCoord>;

	/**
	 * [READ-ONLY] property.
	 */
	public var aEdges:Array<Edge3D>;

	/**
	 * [READ-ONLY] property.
	 */
	public var caUVCoord:Array<UVCoord>;

	/**
	 * [READ-ONLY] property.
	 * This property contains the texture bounds as a Rectangle.
	 */
	public var uvBounds:Rectangle;
	
	/**
	 * [READ-ONLY] property
	 * Array of polygons that share an edge with the current polygon.
	 */
	public var aNeighboors:Array<Polygon>;
	/**
	 * Is this face visible?.
	 * The method returns the visibility value pre computed after precompute method call. This getter shall be called afer the precompute call.
	 * @return 	true if this face is visible, false otherwise.
	 */
	public var visible:Bool;
	
	public var minZ:Float;
	public var m_nDepth:Float;
	
	public var a:Vertex;
	public var b:Vertex;
	public var c:Vertex;

	/**
	 * States if the appearance of the polygon has changed since the previous rendering.
	 * Often used to update the scene material manager.
	 * WARNING: Shall not be changed manually
	 */
	public var hasAppearanceChanged:Bool;
	
	/**
	 * Creates a new polygon.
	 *
	 * @param p_oShape		    The shape this polygon belongs to
	 * @param p_geometry		The geometry this polygon is part of
	 * @param p_aVertexID		The vertexID array of this polygon
	 * @param p_aUVCoordsID		The UVCoordsID array of this polygon
	 * @param p_nFaceNormalID	The faceNormalID of this polygon
	 * @param p_nEdgesID		The edgesID of this polygon
	 */
	public function new( p_oOwner:Shape3D, p_geometry:Geometry3D, p_aVertexID:Array<Int>, ?p_aUVCoordsID:Array<Int>, ?p_nFaceNormalID:Int, ?p_nEdgesID:Int )
	{

		id = _ID_++;
	 isClipped = false;
	 aNeighboors = new Array();
	 hasAppearanceChanged = false;

	 m_oEB = new BubbleEventBroadcaster();
	 mouseEvents = false;
	 mouseInteractivity = false;

		if (p_aUVCoordsID == null) p_aUVCoordsID = [];
  p_nFaceNormalID = (p_nFaceNormalID != null)?p_nFaceNormalID:0;
  p_nEdgesID = (p_nEdgesID != null)?p_nEdgesID:0;

		shape = p_oOwner;
		m_oGeometry = p_geometry;
		// --
		__update( p_aVertexID, p_aUVCoordsID, p_nFaceNormalID, p_nEdgesID );
		m_oContainer = new Sprite();
		// --
		POLYGON_MAP.set( id, this );
	}

	public var depth(__getDepth,__setDepth):Float;
	private function __getDepth():Float{ return m_nDepth; }
	private function __setDepth( p_nDepth:Float ):Float{ m_nDepth = p_nDepth; return p_nDepth; }
	
	/**
	 * The broadcaster property.
	 *
	 * <p>The broadcaster is the property used to send events to listeners.</p>
	 */
	public var broadcaster(__getBroadcaster,null):BubbleEventBroadcaster;
	private function __getBroadcaster():BubbleEventBroadcaster
	{
		return m_oEB;
	}

	/**
	 * Adds a listener for specifical event.
	 *
	 * @param p_sEvent 	Name of the Event.
	 * @param oL 		Listener object.
	 */
	public function addEventListener(p_sEvent:String, oL:Dynamic, arguments:Array<Dynamic> ) : Void
	{
		Reflect.callMethod( m_oEB.addEventListener, m_oEB, arguments );
	}

	/**
	 * Removes a listener for specifical event.
	 *
	 * @param p_sEvent 	Name of the Event.
	 * @param oL 		Listener object.
	 */
	public function removeEventListener(p_sEvent:String, oL:Dynamic) : Void
	{
		m_oEB.removeEventListener(p_sEvent, oL);
	}
		
	/**
	 * Pre-compute several properties of the polygon in the same time.
	 * List of the computed properties :
	 * <ul>
	 *  <li>minZ</li>
	 *  <li>visibility</li>
	 *  <li>depth</li>
	 * </ul>
	 */
	public function precompute():Void
	{
		minZ = a.wz;
		if (b.wz < minZ) minZ = b.wz;
		// --
		if (c != null)
		{
			if (c.wz < minZ) minZ = c.wz;
			m_nDepth = 0.333*(a.wz+b.wz+c.wz);
		}
		else
		{
			m_nDepth = 0.5*(a.wz+b.wz);
		}
	}


	/**
	 * Returns the real 3D position of the 2D screen position.
	 * The 2D position is usually coming from :
	 * <listing version="3.0">
	 * var l_nClicX:Float = m_oScene.container.mouseX;
        * var l_nClicY:Float = m_oScene.container.mouseY;
        * </listing>
        * 
        * @return the real 3D position which correspond to the intersection onto that polygone
        */
	public function get3DFrom2D( p_oScreenPoint:Point ):Vector
	{      
   		/// NEW CODE ADDED BY MAX with the help of makc ///
		
		var m1:Matrix= new Matrix(
					vertices[1].sx-vertices[0].sx,
					vertices[2].sx-vertices[0].sx,
					vertices[1].sy-vertices[0].sy,
					vertices[2].sy-vertices[0].sy,
					0,
					0);
		m1.invert();
							
		var capA:Float = m1.a *(p_oScreenPoint.x-vertices[0].sx) + m1.b * (p_oScreenPoint.y -vertices[0].sy);
		var capB:Float = m1.c *(p_oScreenPoint.x-vertices[0].sx) + m1.d * (p_oScreenPoint.y -vertices[0].sy);
		
		var l_oPoint:Vector = new Vector(			
			vertices[0].x + capA*(vertices[1].x -vertices[0].x) + capB *(vertices[2].x - vertices[0].x),
			vertices[0].y + capA*(vertices[1].y -vertices[0].y) + capB *(vertices[2].y - vertices[0].y),
			vertices[0].z + capA*(vertices[1].z -vertices[0].z) + capB *(vertices[2].z - vertices[0].z)
			);
										
		// transform the vertex with the model Matrix
		this.shape.matrix.vectorMult( l_oPoint );
		return l_oPoint;
	}
	
	/**
	 * Get the UVCoord under the 2D screen position after a mouse click or something
	 * The 2D position is usually coming from :
	 * <listing version="3.0">
	 * var l_nClicX:Float = m_oScene.container.mouseX;
        * var l_nClicY:Float = m_oScene.container.mouseY;
        * </listing>
        * 
        * @return the UVCoord under the 2D screen point
        */
	public function getUVFrom2D( p_oScreenPoint:Point ):UVCoord
	{
		var p0:Point = new Point(vertices[0].sx, vertices[0].sy);
           var p1:Point = new Point(vertices[1].sx, vertices[1].sy);
           var p2:Point = new Point(vertices[2].sx, vertices[2].sy);
         
           var u0:UVCoord = aUVCoord[0];
           var u1:UVCoord = aUVCoord[1];
           var u2:UVCoord = aUVCoord[2];
         
           var v01:Point = new Point(p1.x - p0.x, p1.y - p0.y );
          
           var vn01:Point = v01.clone();
           vn01.normalize(1);
          
           var v02:Point = new Point(p2.x - p0.x, p2.y - p0.y );
           var vn02:Point = v02.clone(); vn02.normalize(1);
          
           // sub that from click point
           var v4:Point = new Point( p_oScreenPoint.x - v01.x, p_oScreenPoint.y - v01.y );
           
           // we now have everything to find 1 intersection
           var l_oInter:Point = IntersectionMath.intersectionLine2D( p0, p2, p_oScreenPoint, v4 );
           
           // find vectors to intersection
           var vi02:Point = new Point( l_oInter.x - p0.x, l_oInter.y - p0.y );      
           var vi01:Point = new Point( p_oScreenPoint.x - l_oInter.x , p_oScreenPoint.y - l_oInter.y );

           // interpolation coeffs
           var d1:Float = vi01.length / v01.length ;
           var d2:Float = vi02.length / v02.length;
                    
           // -- on interpole linéairement pour trouver la position du point dans repere de la texture (normalisé)
           return new UVCoord( u0.u + d1*(u1.u - u0.u) + d2*(u2.u - u0.u),
			                u0.v + d1*(u1.v - u0.v) + d2*(u2.v - u0.v));
	}
	
	/**
	 * Returns an array containing the vertices, clipped by the camera frustum.
	 *
	 * @return 	The array of clipped vertices
	 */
	public function clip( p_oFrustum:Frustum ):Array<Vertex>
	{
		isClipped = true;
		// For lines we only apply front plane clipping
		if( vertices.length < 3 )
		{
			clipFrontPlane( p_oFrustum );
		} 
		else
		{
			cvertices = null;
			caUVCoord = null;
			// --	
			//cvertices = vertices.concat();
			cvertices = vertices.concat([]);
			//caUVCoord = aUVCoord.concat();
			caUVCoord = aUVCoord.concat([]);
			// --
			p_oFrustum.clipFrustum( cvertices, caUVCoord );
		}
		return cvertices;
	}

	/**
	 * Perform a clipping against the near frustum plane.
	 *
	 * @return 	The array of clipped vertices
	 */
	public function clipFrontPlane( p_oFrustum:Frustum ):Array<Vertex>
	{
		isClipped = true;
		cvertices = null;
		//cvertices = vertices.concat();
		cvertices = vertices.concat([]);
		// If line
		if( vertices.length < 3 ) 
		{
			p_oFrustum.clipLineFrontPlane( cvertices );
		}
		else
		{
			caUVCoord = null;
			//caUVCoord = aUVCoord.concat();
			caUVCoord = aUVCoord.concat([]);
			p_oFrustum.clipFrontPlane( cvertices, caUVCoord );
		}
		return cvertices;
	}
	
	/**
	 * Updates the vertices and normals for this polygon.
	 *
	 * <p>Calling this method make the polygon gets its vertice and normals by reference
	 * instead of accessing them by their ID.<br/>
	 * This method shall be called once the geometry created.</p>
	 *
	 * @param p_aVertexID		The vertexID array of this polygon
	 * @param p_aUVCoordsID		The UVCoordsID array of this polygon
	 * @param p_nFaceNormalID	The faceNormalID of this polygon
	 * @param p_nEdgesID		The edgesID of this polygon
	 */
	private function __update( p_aVertexID:Array<Int>, p_aUVCoordsID:Array<Int>, p_nFaceNormalID:Int, p_nEdgeListID:Int ):Void
	{
		var i:Int=0, l:Int;
		// --
		vertexNormals = new Array();
		vertices = new Array();
		for ( o in p_aVertexID )
		{
			vertices[i] = m_oGeometry.aVertex[ p_aVertexID[i] ];
			vertexNormals[i] = m_oGeometry.aVertexNormals[ p_aVertexID[i] ];
			i++;
		}
		// --
		a = vertices[0];
		b = vertices[1];
		c = vertices[2];
		// -- every polygon does not have some texture coordinates
		if( p_aUVCoordsID != null )
		{
			var l_nMinU:Float = Math.POSITIVE_INFINITY, l_nMinV:Float = Math.POSITIVE_INFINITY,
								l_nMaxU:Float = Math.NEGATIVE_INFINITY, l_nMaxV:Float = Math.NEGATIVE_INFINITY;
			// --
			aUVCoord = new Array();
			i = 0;
			for ( p in p_aUVCoordsID )
			{
				var l_oUV:UVCoord = m_oGeometry.aUVCoords[ p_aUVCoordsID[i] ];
				aUVCoord[i] = l_oUV;
				if( l_oUV.u < l_nMinU ) l_nMinU = l_oUV.u;
				else if( l_oUV.u > l_nMaxU ) l_nMaxU = l_oUV.u;
				// --
				if( l_oUV.v < l_nMinV ) l_nMinV = l_oUV.v;
				else if( l_oUV.v > l_nMaxV ) l_nMaxV = l_oUV.v;
				// --
				i++;
			}
			// --
			uvBounds = new Rectangle( l_nMinU, l_nMinV, l_nMaxU-l_nMinU, l_nMaxV-l_nMinV );
		}
		// --
		normal = m_oGeometry.aFacesNormals[ p_nFaceNormalID ];
		// If no normal has been given, we create it ourself.
		if( normal == null )
		{
			var l_oNormal:Vector = createNormal();
			var l_nID:Int = m_oGeometry.setFaceNormal( m_oGeometry.getNextFaceNormalID(), l_oNormal.x, l_oNormal.y, l_oNormal.z );
			normal = m_oGeometry.aFacesNormals[ l_nID ];
		}
		// --
		aEdges = new Array();
		for ( l_nEdgeId in m_oGeometry.aFaceEdges[p_nEdgeListID] )
		{
			var l_oEdge:Edge3D = m_oGeometry.aEdges[ l_nEdgeId ];
			l_oEdge.vertex1 = m_oGeometry.aVertex[ l_oEdge.vertexId1 ];
			l_oEdge.vertex2 = m_oGeometry.aVertex[ l_oEdge.vertexId2 ];
			aEdges.push( l_oEdge );
		}
	}

	/**
	 * Clears the container of this polygon from graphics.
	 */
	public function clear():Void
	{
		m_oContainer.graphics.clear();
	}

	/**
	 * Displays this polygon on its container if visible.
	 *
	 * @param p_oScene The current scene this polygon is rendered into
	 * @param p_oContainer	The container to draw on
	 */
	public function display( p_oScene:Scene3D, ?p_oContainer:Sprite ):Void
	{
		scene = p_oScene;
		// --
		var lCont:Sprite = (p_oContainer != null)?p_oContainer:m_oContainer;
		if( visible )
		{
			m_oAppearance.frontMaterial.renderPolygon( p_oScene, this, lCont );
		}
		else
		{
			m_oAppearance.backMaterial.renderPolygon( p_oScene, this, lCont );
		}
	}

	/**
	 * The container for this polygon.
	 */
	public var container(__getContainer,null):Sprite;
	private function __getContainer():Sprite
	{
		return m_oContainer;
	}

	/**
	 * Returns a string representing of this polygon.
	 *
	 * @return	The string representation.
	 */
	public function toString():String
	{
		return "sandy.core.data.Polygon::id=" +id+ " [Points: " + vertices.length + "]";
	}

	/**
	 * Enables or disables object events for this polygon.
	 *
	 * <p>If a value of true is passed, the object events onPress, onRollOver and onRollOut are enabled.<br />.
	 * To use them, you have to add listeners for the events.</p>
	 *
	 * @param b 	Pass true to enable the events, false to disable.
	 */
	private function __setEnableEvents( b:Bool ):Bool
	{
        if( b && !mouseEvents )
        {
        	container.addEventListener(MouseEvent.CLICK, _onInteraction);
    		container.addEventListener(MouseEvent.MOUSE_UP, _onInteraction);
    		container.addEventListener(MouseEvent.MOUSE_DOWN, _onInteraction);
    		container.addEventListener(MouseEvent.ROLL_OVER, _onInteraction);
    		container.addEventListener(MouseEvent.ROLL_OUT, _onInteraction);
    		
			container.addEventListener(MouseEvent.DOUBLE_CLICK, _onInteraction);
			container.addEventListener(MouseEvent.MOUSE_MOVE, _onInteraction);
			container.addEventListener(MouseEvent.MOUSE_OVER, _onInteraction);
			container.addEventListener(MouseEvent.MOUSE_OUT, _onInteraction);
			container.addEventListener(MouseEvent.MOUSE_WHEEL, _onInteraction);
   
		}
		else if( !b && mouseEvents )
		{
			container.removeEventListener(MouseEvent.CLICK, _onInteraction);
			container.removeEventListener(MouseEvent.MOUSE_UP, _onInteraction);
			container.removeEventListener(MouseEvent.MOUSE_DOWN, _onInteraction);
			container.removeEventListener(MouseEvent.ROLL_OVER, _onInteraction);
			container.removeEventListener(MouseEvent.ROLL_OUT, _onInteraction);
			
			container.removeEventListener(MouseEvent.DOUBLE_CLICK, _onInteraction);
			container.removeEventListener(MouseEvent.MOUSE_MOVE, _onInteraction);
			container.removeEventListener(MouseEvent.MOUSE_OVER, _onInteraction);
			container.removeEventListener(MouseEvent.MOUSE_OUT, _onInteraction);
			container.removeEventListener(MouseEvent.MOUSE_WHEEL, _onInteraction);
    	}
    	mouseEvents = b;
					return b;
	}
	
	public var enableEvents(__getEnableEvents,__setEnableEvents):Bool;
	private function __getEnableEvents():Bool
	{ return mouseEvents; }

	private function _onInteraction( p_oEvt:Event ):Void
	{ 
		var l_oClick:Point = new Point( m_oContainer.mouseX, m_oContainer.mouseY );
		var l_oUV:UVCoord = getUVFrom2D( l_oClick );
		var l_oPt3d:Vector = get3DFrom2D( l_oClick );
		m_oEB.broadcastEvent( new Shape3DEvent( p_oEvt.type, shape, this, l_oUV, l_oPt3d, p_oEvt ) );
	}
	
	private function _startMouseInteraction( ?e : MouseEvent ) : Void
	{
		container.addEventListener(MouseEvent.CLICK, _onTextureInteraction);
		container.addEventListener(MouseEvent.MOUSE_UP, _onTextureInteraction);
		container.addEventListener(MouseEvent.MOUSE_DOWN, _onTextureInteraction);
		
		container.addEventListener(MouseEvent.DOUBLE_CLICK, _onTextureInteraction);
		container.addEventListener(MouseEvent.MOUSE_MOVE, _onTextureInteraction);
		container.addEventListener(MouseEvent.MOUSE_OVER, _onTextureInteraction);
		container.addEventListener(MouseEvent.MOUSE_OUT, _onTextureInteraction);
		container.addEventListener(MouseEvent.MOUSE_WHEEL, _onTextureInteraction);
		
		container.addEventListener(KeyboardEvent.KEY_DOWN, _onTextureInteraction);
		container.addEventListener(KeyboardEvent.KEY_UP, _onTextureInteraction);
		
		m_oContainer.addEventListener( Event.ENTER_FRAME, _onTextureInteraction );
	}
	
	private function _stopMouseInteraction( ?e : MouseEvent ) : Void
	{
		container.removeEventListener(MouseEvent.CLICK, _onTextureInteraction);
		container.removeEventListener(MouseEvent.MOUSE_UP, _onTextureInteraction);
		container.removeEventListener(MouseEvent.MOUSE_DOWN, _onTextureInteraction);
		
		container.removeEventListener(MouseEvent.DOUBLE_CLICK, _onTextureInteraction);
		container.removeEventListener(MouseEvent.MOUSE_MOVE, _onTextureInteraction);
		container.removeEventListener(MouseEvent.MOUSE_OVER, _onTextureInteraction);
		container.removeEventListener(MouseEvent.MOUSE_OUT, _onTextureInteraction);
		container.removeEventListener(MouseEvent.MOUSE_WHEEL, _onTextureInteraction);
		m_oContainer.removeEventListener( Event.ENTER_FRAME, _onTextureInteraction );
		
		container.removeEventListener(KeyboardEvent.KEY_DOWN, _onTextureInteraction);
		container.removeEventListener(KeyboardEvent.KEY_UP, _onTextureInteraction);
		
	}
	
	private function __setEnableInteractivity( p_bState:Bool ):Bool
	{
		if( p_bState != mouseInteractivity )
		{
			if( p_bState )
			{
				container.addEventListener( MouseEvent.ROLL_OVER, _startMouseInteraction, false );
				container.addEventListener( MouseEvent.ROLL_OUT, _stopMouseInteraction, false );
			}
			else
			{
				_stopMouseInteraction();
			}
			// --
			mouseInteractivity = p_bState;
		}
		return p_bState;
	}
	
	public var enableInteractivity(__getEnableInteractivity,__setEnableInteractivity):Bool;
	private function __getEnableInteractivity():Bool
	{ return mouseInteractivity; }
	
	
	private function _onTextureInteraction( ?p_oEvt:Event ) : Void
	{
		var l_bIsMouseEvent : Bool = switch ( Type.typeof( p_oEvt ) ) {
			case TClass( MouseEvent ):
				true;
			default:
				false;
		}
		if ( p_oEvt == null || !l_bIsMouseEvent ) p_oEvt = new MouseEvent( MouseEvent.MOUSE_MOVE, true, false, 0, 0, null, false, false, false, false, 0);
		
	    //	get the position of the mouse on the poly
		var pt2D : Point = new Point( scene.container.mouseX, scene.container.mouseY );
		var uv : UVCoord = getUVFrom2D( pt2D );
		
		VirtualMouse.getInstance().interactWithTexture( this, uv, p_oEvt );
		_onInteraction( p_oEvt );
	}
			
	/**
	 * Calculates and returns the normal vector of the polygon.
	 *
	 * @return	The normal vector
	 */
	public function createNormal():Vector
	{
		if( vertices.length > 2 )
		{
			var v:Vector, w:Vector;
			var a:Vertex = vertices[0], b:Vertex = vertices[1], c:Vertex = vertices[2];
			v = new Vector( b.wx - a.wx, b.wy - a.wy, b.wz - a.wz );
			w = new Vector( b.wx - c.wx, b.wy - c.wy, b.wz - c.wz );
			// we compute de cross product
			var l_normal:Vector = VectorMath.cross( v, w );
			// we normalize the resulting vector
			VectorMath.normalize( l_normal ) ;
			// we return the resulting vertex
			return l_normal;
		}
		else
		{
			return new Vector();
		}
	}

	/**
	 * The appearance of this polygon.
	 */
	private function __setAppearance( p_oApp:Appearance ):Appearance
	{
		if( scene != null )
		{
			if( scene.materialManager.isRegistered( m_oAppearance.frontMaterial ) )
				scene.materialManager.unregister( m_oAppearance.frontMaterial );
			if( scene.materialManager.isRegistered( m_oAppearance.backMaterial ) )
			scene.materialManager.unregister( m_oAppearance.backMaterial );
		} 
		if( m_oAppearance != null )
		{
			p_oApp.frontMaterial.unlink( this );
			if( p_oApp.backMaterial != p_oApp.frontMaterial ) 
				p_oApp.backMaterial.unlink( this );
		}
		m_oAppearance = p_oApp;
		// --
		p_oApp.frontMaterial.init( this );
		if( p_oApp.backMaterial != p_oApp.frontMaterial ) 
			p_oApp.backMaterial.init( this );
		// --
		hasAppearanceChanged = true;
		return p_oApp;
	}

	/**
	 * @private
	 */
	public var appearance(__getAppearance,__setAppearance):Appearance;
	private function __getAppearance():Appearance
	{
		return m_oAppearance;
	}

	/**
	 * Changes which side is the "normal" culling side.
	 *
	 * <p>The method also swaps the front and back skins.</p>
	 */
	public function swapCulling():Void
	{
		normal.negate();
	}

	/**
	 * Destroys the sprite attache to this polygon.
	 */
	public function destroy():Void
	{
		clear();
		// --
		if( m_oContainer.parent != null ) m_oContainer.parent.removeChild( m_oContainer );
		if( m_oContainer != null ) m_oContainer = null;
		// --
		cvertices = null;
		vertices = null;
		m_oEB = null;
		// -- memory leak fix from nopmb on mediabox forums
		POLYGON_MAP.set( id, null );
	}


// _______
// PRIVATE_______________________________________________________

	/** Reference to its owner geometry */
	private var m_oGeometry:Geometry3D;
	private var m_oAppearance:Appearance;
	/** array of ID of uv coordinates in geometry object */
	private var m_aUVCoords:Array<UVCoord>;

	private var m_oContainer:Sprite;

	private var m_oEB:BubbleEventBroadcaster;

	/** Boolean representing the state of the event activation */
	private var mouseEvents:Bool;
	private var mouseInteractivity:Bool;
}

