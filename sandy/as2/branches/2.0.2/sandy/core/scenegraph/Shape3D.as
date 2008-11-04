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

import flash.geom.Point;
	
import com.bourre.commands.Delegate;
import com.bourre.events.BubbleEvent;
import com.bourre.events.BubbleEventBroadcaster;
import com.bourre.events.EventType;
	
import sandy.bounds.BBox;
import sandy.bounds.BSphere;
import sandy.core.Scene3D;
import sandy.core.data.Matrix4;
import sandy.core.data.Polygon;
import sandy.core.data.Vector;
import sandy.core.data.Vertex;
import sandy.core.sorters.IDepthSorter;
import sandy.events.MouseEvent;
import sandy.materials.Appearance;
import sandy.materials.Material;
import sandy.materials.WireFrameMaterial;
import sandy.math.IntersectionMath;
import sandy.core.scenegraph.ATransformable;
import sandy.core.scenegraph.Camera3D;
import sandy.core.scenegraph.Geometry3D;
import sandy.core.scenegraph.IDisplayable;
import sandy.view.CullingState;
import sandy.view.Frustum;
import sandy.core.data.UVCoord;
import sandy.events.Shape3DEvent;

/**
 * The Shape3D class is the base class of all true 3D shapes.
 *
 * <p>It represents a node in the object tree of the world.<br/>
 * A Shape3D is a leaf node and can not have any child nodes.</p>
 * <p>It must be the child of a branch group or a transform group, 
 * but transformations can be applied to the Shape directly.</p>
 * 
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - xdevltd
 * @version		2.0.2
 * @date 		26.07.2007
 */
 
class sandy.core.scenegraph.Shape3D extends ATransformable implements IDisplayable
{
	
	/**
	 * Default material for the DEFAULT_APPEARANCE object
	 */
	public static var DEFAULT_MATERIAL:Material;

	/**
	 * Default appearance for Shape3D instances. If no apperance is given, this default one will be applied using the DEFAULT_MATERIAL as front and back material
	 */
	public static var DEFAULT_APPEARANCE:Appearance;
	
	/**
	 * The array of polygons building this object.
	 */		
	public var aPolygons:Array;
		
	/**
	 * <p>
	 * Enable the Frustum near plane clipping on the visible polygons.
	 * Enable this when you need a perfect intersection between the front camera plane.
	 * This is mainly used when you need the camera to move on a long plane.</p>
	 * 
	 * <p>Important: Enable the clipping makes process a bit slower, especially with big scenes.</p>
	 */ 
	public var enableNearClipping:Boolean;
	
	/**
	 * <p>
	 * Enable the Frustum clipping on the visible polygons.
	 * Enable this when you need a perfect intersection between the camera and some object shapes.
	 * In case you need to make the camera look inside and outide a box, or other immerssive things.</p>
	 * 
	 * <p>Important: Enable the clipping makes process a bit slower, especially with big scenes.</p>
	 *
	 * <p>Specify if this object polygons should be clipped against the camera frustum planes.</p>
	 */
	public var enableClipping:Boolean;

	/**
	 * Should forced depth be enable for this object?.
	 *
	 * <p>If true it is possible to force this object to be drawn at a specific depth,<br/>
	 * if false the normal Z-sorting algorithm is applied.</p>
	 * <p>When correctly used, this feature allows you to avoid some Z-sorting problems.</p>
	 */
	public var enableForcedDepth:Boolean;
	
	/**
	 * The forced depth for this object.
	 *
	 * <p>To make this feature work, you must enable the ForcedDepth system too.<br/>
	 * The higher the depth is, the sooner the more far the object will be represented.</p>
	 */
	public var forcedDepth:Number;	
	
	/**
	 * Animated flag. 
	 * <p>If the geometry vertices are dynamically modified by some animation engine or mathematic function, some polygon may disapear with no reason.
	 * The normal vector is used to compute the polygon visibility, and if you don't update the normal vector after the vertices modifications, there's an error.
	 * To fix that problem, Sandy3D offers that new property appeared in 3.0.3 release, which once set to true, automatically update the normal vectors for you.
	 * As a performance warning, don't set this value to true if your model geometry isn't animated.</p>
	 */
	public var animated:Boolean;
	
	/**   
	 * Array containing the visible polygons of that shape.  
	 * Contente is available after the SCENE_RENDER_DISPLAYLIST event of the current scene has been dispatched  
	 */  
	public var aVisiblePolygons:Array; 
	
	/**
	 * The container of the Shape3D.
	 * Please note: this property is not defined in the IDisplayable interface ( as in the AS3 version ) with getter/setter!
	 */
	public var container:MovieClip;
		
	/**
	 * The depth of the Shape3D.
	 * Please note: this property is not defined in the IDisplayable interface ( as in the AS3 version ) with getter/setter!
	 */
	public var depth:Number;

	/**
	 * Creates a 3D object
	 *
	 * <p>[ <b>Todo</b>: some more explanations ]</p>
	 *
	 * @param p_sName		A string identifier for this object
	 * @param p_oGeometry		The geometry of this object
	 * @param p_oAppearance		The appearance of this object. If no apperance is given, the DEFAULT_APPEARANCE will be applied.
	 * @param p_bUseSingleContainer	Whether tis object should use a single container to draw on
	 */	
	public function Shape3D( p_sName:String, p_oGeometry:Geometry3D, p_oAppearance:Appearance, p_bUseSingleContainer:Boolean )
	{
		super( p_sName||"" )
		
		aPolygons = new Array();
		enableNearClipping = false;
		enableClipping 	   = false;
		animated 		   = false;
		forcedDepth = 0;
		
		aVisiblePolygons = new Array();
		
		p_bUseSingleContainer = p_bUseSingleContainer||true;
		// --
		m_oGeomCenter = new Vector();
		DEFAULT_MATERIAL = new WireFrameMaterial();
		DEFAULT_APPEARANCE = new Appearance( DEFAULT_MATERIAL );
		// -- Add this graphical object to the World display list
		container = new MovieClip();
		// --
        geometry = p_oGeometry;
        // -- HACK to make sure that the correct container system will be applied
		m_bUseSingleContainer = !p_bUseSingleContainer;
		useSingleContainer = p_bUseSingleContainer;
		// --
		appearance = ( p_oAppearance ) ? p_oAppearance : Shape3D.DEFAULT_APPEARANCE;
		// -- 
		updateBoundingVolumes();
    }
	    	
   	/**
   	 * setter that allow user to change the way to render this object.
   	 * set to true, the shape will be rendered into a single Sprite object, which is accessible through the container property.
   	 * set to false, the container property does not target anything, but all the polygons will be rendered into their own dedidated container.
   	 *
   	 * <p>If true, this object renders itself on a single container ( Sprite ),<br/>
   	 * if false, each polygon is rendered on its own container.</p>
   	 */
   	public function set useSingleContainer( p_bUseSingleContainer:Boolean ) : Void
   	{
   		var l_oFace:Polygon;
   		// --
   		if( p_bUseSingleContainer == m_bUseSingleContainer ) return;
   		// --
   		if( p_bUseSingleContainer )
   		{
   			for( l_oFace in aPolygons )
   			{
				if( aPolygons[ l_oFace ].container ) 
				{
					aPolygons[ l_oFace ].container.clear();
					aPolygons[ l_oFace ].container = container;
					this.broadcaster.removeChild( aPolygons[ l_oFace ].broadcaster );
				}
   			}
   		}
   		else
   		{
   			if( container )
   			{
   				container.clear();
   			}
   			// --
   			for( l_oFace in aPolygons )
   			{
				this.broadcaster.addChild( aPolygons[ l_oFace ].broadcaster );
				// we reset the polygon container to the original one, and add it to the world container
				aPolygons[ l_oFace ].container.clear();
   			}
   		}
   		m_bUseSingleContainer = p_bUseSingleContainer;
   	}

	/**
	 * @private
	 */
	public function get useSingleContainer() : Boolean
	{ return m_bUseSingleContainer; }

	/**
	 * Updates the bounding volumes of this object.
	 */
   	public function updateBoundingVolumes() : Void
   	{
   	    if( m_oGeometry )
   	    {
   	        boundingSphere 	= BSphere.create( m_oGeometry.aVertex );
   	        boundingBox	= BBox.create( m_oGeometry.aVertex );
   	    }
   	}
	  
	/**
	 * Tests this node against the camera frustum to get its visibility.
	 *
	 * <p>If this node and its children are not within the frustum, 
	 * the node is set to cull and it would not be displayed.<p/>
	 * <p>The method also updates the bounding volumes to make the more accurate culling system possible.<br/>
	 * First the bounding sphere is updated, and if intersecting, 
	 * the bounding box is updated to perform the more precise culling.</p>
	 * <p><b>[ MANDATORY ] The update method must be called first!</b></p>
	 *
	 * @param p_oScene 		The current scene
	 * @param p_oFrustum	The frustum of the current camera
	 * @param p_oViewMatrix	The view martix of the curren camera
	 * @param p_bChanged
	 */
	public function cull( p_oScene:Scene3D, p_oFrustum:Frustum, p_oViewMatrix:Matrix4, p_bChanged:Boolean ) : Void
	{
		super.cull( p_oScene, p_oFrustum, p_oViewMatrix, p_bChanged );
		if( culled == Frustum.OUTSIDE ) return;
		/////////////////////////
        //// BOUNDING SPHERE ////
        /////////////////////////
       	if( !boundingSphere.uptodate ) boundingSphere.transform( viewMatrix );
       	culled = p_oFrustum.sphereInFrustum( boundingSphere );
		// --
		if( culled == Frustum.INTERSECT && boundingBox )
		{
			////////////////////////
			////  BOUNDING BOX  ////
			////////////////////////
			if( !boundingBox.uptodate ) boundingBox.transform( viewMatrix );
			culled = p_oFrustum.boxInFrustum( boundingBox );
		}
		if( culled != CullingState.OUTSIDE && m_oAppearance != null )
		{
			p_oScene.renderer.addToDisplayList( this );
		}
	}
		
	/**
	* Clears the graphics object of this object's container.
	*
	* <p>The the graphics that were drawn on the Graphics object is erased, 
	* and the fill and line style settings are reset.</p>
	*/
	public function clear() : Void
	{
		if( container ) 
		container.clear();
	}
	
	/**
	 * Performs a z-sorting and renders the objects visible polygons.
	 *
	 * <p>The method is called only if the object renders on a single container<br/> 
	 * - ( useSingleContainer = true ).</p>
	 *
	 * @param p_oScene The current scene
	 * @param p_oContainer	The container to draw on
	 */
	public function display( p_oScene:Scene3D, p_oContainer:MovieClip ) : Void
	{
		aVisiblePolygons.sortOn( "depth", Array.NUMERIC | Array.DESCENDING );
	    // --
		var l_oFace:Polygon;
		for( var i in aVisiblePolygons )
		{
			l_oFace = aVisiblePolygons[ i ];
			if( l_oFace.hasAppearanceChanged )
			{
				var l_oApp:Appearance = l_oFace.appearance;
				if( p_oScene.materialManager.isRegistered( l_oApp.frontMaterial ) == false )
				{
					p_oScene.materialManager.register( l_oApp.frontMaterial );
				}
				if( l_oApp.frontMaterial != l_oApp.backMaterial )
				{
					if( p_oScene.materialManager.isRegistered( l_oApp.backMaterial ) == false )
					{
						p_oScene.materialManager.register( l_oApp.backMaterial );
					}
				}
				l_oFace.hasAppearanceChanged = false;
			}
			// --
			l_oFace.display( p_oScene, container );
		}
	}
		
	/**
 	 * This property call allows you to get the geometryCenter offset vector of the Shape.
	 * Modifying this vector will impact the way the shape is rendered, mainly its rotation center.
	 * 
	 * @return a vector which corresponds to the 2 directions offset.
	 */
	public function get geometryCenter() : Vector
	{ return m_oGeomCenter;  }
	
	/**
	 * Change the geometryCenter of the Shape3D.
	 * To change the geometryCenter point of a shape, simply set this geometryCenter property.
	 * The geometryCenter property requires a vector. This vector is an position offset relative to the original geometry one.
	 * For example, a Sphere primitive creates automatically a geometry which center is the 0,0,0 position. If you rotate this sphere as this,
	 * it will rotate around its center.
	 * Now if you set the geometryCenter property, this rotation center will change.
	 * 
	 * The updateBoundingVolumes method which does update the bounding volumes to enable a correct frustum culling is automatically called.
	 * 
	 * @example To change the geometryCenter center at runtime
	 * <listing version="3.0">
	 *    var l_oSphere:Sphere = new Sphere( "mySphere", 50, 3 );
	 *    // Change the rotation reference to -50 offset in Y direction from the orinal one
	 *    // and that corresponds to the bottom of the sphere
	 *    l_oSphere.geometryCenter = new Vector( 0, -50, 0 ); 
	 *    l_oSphere.rotateZ = 45;
	 * </listing>
	 */
	public function set geometryCenter( p_oGeomCenter:Vector ) : Void
	{
		var l_oDiff:Vector = p_oGeomCenter.clone();
		l_oDiff.sub( m_oGeomCenter );
		// --
		if( m_oGeometry )
		{
			var l_oVertex:Vertex;
			for( l_oVertex in m_oGeometry.aVertex )
			{
				l_oVertex = m_oGeometry.aVertex[ l_oVertex ];
				l_oVertex.x += l_oDiff.x;
				l_oVertex.y += l_oDiff.y;
				l_oVertex.z += l_oDiff.z;
			}
		}
		// --
		m_oGeomCenter.copy( p_oGeomCenter );	
		// --
		updateBoundingVolumes();	
	}
		
	/**
	 * The appearance of this object.
	 */
	public function set appearance( p_oApp:Appearance ) : Void
	{
		// Now we register to the update event
		m_oAppearance = p_oApp;
		// --
		if( m_oGeometry )
		{
			var v:Polygon;
			for( v in aPolygons )
				aPolygons[ v ].appearance = m_oAppearance;
		}
	}
		
	/**
	 * Apply a new depth sorter to all the polygons.
	 * @param p_iSorter The new depth sorting object
	 */
	public function set depthSorter( p_iSorter:IDepthSorter ) : Void
   	{
		var l_oPoly:Polygon;
   		for( l_oPoly in aPolygons )
		{
			aPolygons[ l_oPoly ].depthSorter = p_iSorter;
		}
   	}
		
	/**
	 * @private
	 */
	public function get appearance() : Appearance 
	{
		return m_oAppearance;
	}
	       
	/**
	 * The geometry of this object.
	 */
	public function set geometry( p_geometry:Geometry3D ) : Void
	{
		if( p_geometry == null ) return;
		// TODO shall we clone the geometry?
		m_oGeometry = p_geometry;
		updateBoundingVolumes();
		// -- we generate the possible missing normals
		m_oGeometry.generateFaceNormals();//Must be called first
		m_oGeometry.generateVertexNormals();//must be called second
		// --
		__destroyPolygons();
		__generatePolygons( m_oGeometry );
	}
	
	/**
	 * @private
	 */
	public function get geometry() : Geometry3D
	{
		return m_oGeometry;
	}
	
	/**
	 * Should back face culling be enabled for this object?.
	 *
	 * <p>If set to false all faces of this object are drawn.<br/>
	 * A true value enables the back face culling algorithm - Default true</p>
	 */
	public function set enableBackFaceCulling( b:Boolean ) : Void
	{
		if( b != m_bBackFaceCulling )
		{
			m_bBackFaceCulling = b;
			changed = true;
		}
	}
		
	/**
	 * @private
	 */
	public function get enableBackFaceCulling() : Boolean
	{
		return m_bBackFaceCulling;
	}
		
	
	/**
	 * Enable the interactivity on this shape and its polygon.
	 * Be careful, this mode have some requirements :
	 *   - to have useSingleContainer set to false. It is done automatically if enabled
	 * 
	 * The original settings are back to their  original state when the mode is disabled
	 */
	public function set enableInteractivity( p_bState:Boolean ) : Void
	{
		if( p_bState != m_bMouseInteractivity )
		{
			if( p_bState )
			{
				if( m_bUseSingleContainer == true )
				{
					m_bUseSingleContainer = false;
					m_bForcedSingleContainer = true;
				}
			}
			else
			{
				if( m_bForcedSingleContainer == true )
				{
					useSingleContainer = true;
					m_bForcedSingleContainer = false;
				}
			}
			// --
			var l_oPolygon:Polygon;
			for( l_oPolygon in aPolygons )
			{
	    		aPolygons[ l_oPolygon ].enableInteractivity = p_bState;
	    	}
	    			
			m_bMouseInteractivity = p_bState;
		}
	}	
	
	public function get enableInteractivity() : Boolean
	{ return m_bMouseInteractivity; }
	
	/**
	 * Enables the event system for mouse events.
	 *
	 * <p>When set to true, the onPress, onRollOver and onRollOut events are broadcast.<br/>
	 * The event system is enabled or disabled for all faces of this object.<br/>
	 * As an alternative, you have the possibility to enable events only for specific faces.</p>
	 *
	 * <p>Once this feature is enabled, the animation is more CPU intensive.</p>
	 * 
	 * <p>Example
	 * <code>
	 * 	var l_oShape:Shape3D = new Sphere( "sphere" );
	 * 	l_oShape.enableEvents = true;
	 * 	l_oShape.addEventListener( MouseEvent.CLICK, onClick );
	 * 
	 * 	function onClick( p_eEvent:Shape3DEvent ) : Void
     * 	{
     *   	var l_oPoly:Polygon = ( p_eEvent.polygon );  
	 *   	var l_oPointAtClick:Vector =  p_eEvent.point;
	 *   	// -- get the normalized uv of the point under mouse position
	 *  	var l_oIntersectionUV:UVCoord = p_eEvent.uv;
	 *   	// -- get the correct material
	 *   	var l_oMaterial:BitmapMaterial = BitmapMaterial( l_oPoly.visible ? l_oPoly.appearance.frontMaterial:l_oPoly.appearance.backMaterial );
	 * 	}
	 * </code>
	 */
	public function set enableEvents( b:Boolean ) : Void
	{
		// To use only when use Single container is disabled 
		var v:Polygon = null;
		
		if( b )
		{
			if( !m_bEv )
			{
    			if( m_bUseSingleContainer == false )
    			{
	    			for( v in aPolygons )
					{
	    			    aPolygons[ v ].enableEvents = true;
	    			}
    			}
    			else
    			{
					container.onPress = Delegate.create( this, _onInteraction, MouseEvent.CLICK );
					container.mouseUp = Delegate.create( this, _onInteraction, MouseEvent.MOUSE_UP ); 
					container.mouseDown = Delegate.create( this, _onInteraction, MouseEvent.MOUSE_DOWN ); 
					container.rollOver = Delegate.create( this, _onInteraction, MouseEvent.ROLL_OVER ); 
					container.rollOut = Delegate.create( this, _onInteraction, MouseEvent.ROLL_OUT ); 
   		
					container.onMouseWheel = Delegate.create( this, _onInteraction, MouseEvent.MOUSE_WHEEL ); 
					container.mouseOut = Delegate.create( this, _onInteraction, MouseEvent.MOUSE_OUT ); 
					container.mouseOver = Delegate.create( this, _onInteraction, MouseEvent.MOUSE_OVER ); 
					container.mouseMove = Delegate.create( this, _onInteraction, MouseEvent.MOUSE_MOVE ); 
    			}
			}
		}
		else if( !b && m_bEv )
		{
			if( m_bUseSingleContainer == false )
   			{
    			for( v in aPolygons )
				{
    			   aPolygons[ v ].enableEvents = false;
    			}
   			}
   			else
   			{
				container.onPress = null;
				container.mouseUp = null;
				container.mouseDown = null;
				container.rollOver = null;
				container.rollOut = null;
   	
				container.onMouseWheel = null;
				container.mouseOut = null;
				container.mouseOver = null;
				container.mouseMove = null;
   			}
		}
		m_bEv = b;
	}

	private function _onInteraction( p_oEvt:EventType ) : Void
	{
		// we need to get the polygon which has been clicked.
		var l_oClick:Point = new Point( container._xmouse, container._ymouse );
		var l_oA:Point = new Point(), l_oB:Point = new Point(), l_oC:Point = new Point();
		var l_oPoly:Polygon;
		var l_aSId:Array = aPolygons.sortOn( 'depth', Array.NUMERIC | Array.RETURNINDEXEDARRAY );
		var l:Number = aPolygons.length, j:Number;
		for( j = 0; j < l; j += 1 )
		//j = l;
		//while( --j > -1 )
		{
			l_oPoly = aPolygons[ l_aSId[ Number( j ) ] ];
			if( !l_oPoly.visible && m_bBackFaceCulling ) continue;
			// --
			var l_nSize:Number = l_oPoly.vertices.length;
			var l_nTriangles:Number = l_nSize - 2;
			var i:Number;
			for( var i:Number = 0; i < l_nTriangles; i++ )
			{
				l_oA.x = l_oPoly.vertices[ i ].sx; l_oA.y = l_oPoly.vertices[ i ].sy;
				l_oB.x = l_oPoly.vertices[ i + 1 ].sx; l_oB.y = l_oPoly.vertices[ i + 1 ].sy;
				l_oC.x = l_oPoly.vertices[ ( i + 2 ) % l_nSize ].sx; l_oC.y = l_oPoly.vertices[ ( i + 2 ) % l_nSize ].sy;
				// --
				if( IntersectionMath.isPointInTriangle2D( l_oClick, l_oA, l_oB, l_oC ) )
				{
					var l_oUV:UVCoord = l_oPoly.getUVFrom2D( l_oClick );
					var l_oPt3d:Vector = l_oPoly.get3DFrom2D( l_oClick );
					m_oEB.broadcastEvent( new Shape3DEvent( p_oEvt, this, l_oPoly, l_oUV, l_oPt3d ) );
					return;
				}
			}
		}
		//m_oEB.broadcastEvent( new BubbleEvent( p_oEvt.type, this, p_oEvt ) );
	}
	
	/**
	 * Changes the backface culling side.
	 *
	 * <p>When you want to display a cube and you are the cube, you see its external faces.<br/>
	 * The internal faces are not drawn due to back face culling</p>
	 *
	 * <p>In case you are inside the cube, by default Sandy's engine still doesn't draw the internal faces
	 * ( because you should not be in there ).</p> 
	 *
	 * <p>If you need to be only inside the cube, you can call this method to change which side is culled.<br/>
	 * The faces will be visible only from the interior of the cube.</p>
	 *
	 * <p>If you want to be both on the inside and the outside, you want to make the faces visible from on both sides.<br/>
	 * In that case you just have to set enableBackFaceCulling to false.</p>
	 */
	public function swapCulling() : Void
	{
		var v:Polygon;
		for( v in aPolygons )
		{
			aPolygons[ v ].swapCulling();
		}
		changed = true;
	}
	
	/**
	 * Destroy this object and all its faces
	 * container object is removed, and graphics cleared.  All polygons have their
	 */
	public function destroy() : Void
	{
		// 	FIXME Fix it - it should be more like 
		m_oGeometry.dispose();
		// --
		if( container ) container.removeMovieClip();
		if( container ) container = null;
		// --
		__destroyPolygons();
		// --
		super.destroy();
	}

	/**
	 * This method returns a clone of this Shape3D.
	 * The current appearance will be applied, and the geometry is cloned ( not referenced to curent one ).
	 * 
	 * @param p_sName The name of the new shape you are going to create
	 * @param p_bKeepTransform Boolean value which, if set to true, applies the current local transformations to the cloned shape. Default value is false.
	 *
	 * @return 	The clone
	 */
	public function clone( p_sName:String, p_bKeepTransform:Boolean ) : Shape3D
	{
		var l_oClone:Shape3D = new Shape3D( p_sName||"", geometry.clone(), appearance, m_bUseSingleContainer );
		// --
		if( p_bKeepTransform == true ) l_oClone.matrix = this.matrix;
		// --
		return l_oClone;
	}
	
	/**
	 * Returns a string representation of this object
	 *
	 * @return	The fully qualified name of this object and its geometry
	 */
	public function toString () : String
	{
		return "sandy.core.scenegraph.Shape3D " + m_oGeometry.toString();
	}

	///////////////////
	///// PRIVATE /////
	///////////////////
	
	private function __destroyPolygons() : Void
	{
    	if( aPolygons != null && aPolygons.length > 0 )
		{
			var i:Number, l:Number = aPolygons.length;
			while( i < l )
			{
				if( broadcaster != null ) broadcaster.removeChild( aPolygons[ i ].broadcaster );
				if( aPolygons[ i ] ) Polygon( aPolygons[ int( i ) ] ).destroy();
				// --
				aPolygons[ int( i ) ] = null;
				// --
				i ++;
			}
		}

		aPolygons.splice( 0 );
		aPolygons = null;
	}
		
	private function __generatePolygons( p_oGeometry:Geometry3D ) : Void
	{
		var i:Number = 0, l:Number = p_oGeometry.aFacesVertexID.length;
		aPolygons = new Array( l );
		// --
		for( i = 0; i < l; i++ )
		{
			aPolygons[ i ] = new Polygon( this, p_oGeometry, p_oGeometry.aFacesVertexID[ i ], p_oGeometry.aFacesUVCoordsID[ i ], i, i );
			if( m_oAppearance ) aPolygons[ int( i ) ].appearance = m_oAppearance;
			this.broadcaster.addChild( aPolygons[ int( i ) ].broadcaster );
		}			
	}
	    		
	// ______________
	// [ PRIVATE ] DATA________________________________________________				
	private var m_oAppearance:Appearance ; // The Appearance of this Shape3D		
    private var m_bEv:Boolean = false; // The event system state ( enable or not )
	private var m_oGeomCenter:Vector;
	private var m_bBackFaceCulling:Boolean = true;

	/** Geometry of this object */
	private var m_oGeometry:Geometry3D;
	
	private var m_bUseSingleContainer:Boolean = true;
	private var m_nDepth:Number = 0;
	private var m_bMouseInteractivity:Boolean = false;
	private var m_bForcedSingleContainer:Boolean = false;
	
}