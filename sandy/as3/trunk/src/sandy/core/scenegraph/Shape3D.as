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

package sandy.core.scenegraph 
{    
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import sandy.bounds.BBox;
	import sandy.bounds.BSphere;
	import sandy.core.SandyFlags;
	import sandy.core.Scene3D;
	import sandy.core.data.Matrix4;
	import sandy.core.data.Polygon;
	import sandy.core.data.UVCoord;
	import sandy.core.data.Vector;
	import sandy.core.data.Vertex;
	import sandy.core.sorters.IDepthSorter;
	import sandy.events.Shape3DEvent;
	import sandy.materials.Appearance;
	import sandy.materials.Material;
	import sandy.materials.WireFrameMaterial;
	import sandy.math.IntersectionMath;
	import sandy.view.CullingState;
	import sandy.view.Frustum;

	/**
	 * The Shape3D class is the base class of all true 3D shapes.
	 *
	 * <p>It represents a node in the object tree of the world.<br/>
	 * A Shape3D is a leaf node and can not have any child nodes.</p>
	 * <p>It must be the child of a branch group or a transform group, 
	 * but transformations can be applied to the Shape directly.</p>
	 * 
	 * @author		Thomas Pfeiffer - kiroukou
	 * @version		3.0
	 * @date 		26.07.2007
	 */
	public class Shape3D extends ATransformable implements IDisplayable
	{ 
		/**
		 * Default material for the DEFAULT_APPEARANCE object
		 */
		public static var DEFAULT_MATERIAL:Material = new WireFrameMaterial();
		/**
		 * Default appearance for Shape3D instances. If no apperance is given, this default one will be applied using the DEFAULT_MATERIAL as front and back material
		 */
		public static var DEFAULT_APPEARANCE:Appearance = new Appearance( DEFAULT_MATERIAL );
		
		/**
		 * The array of polygons building this object.
		 */		
		public var aPolygons:Array = new Array();
		
		/**
		 * This property will remains null until a material needs it, defining the SandyFlag INVERT_MODEL_MATRIX
		 * In that case, that property will return the invert model matrix on that node
		 */
		public var invModelMatrix:Matrix4;

		/**
		 * <p>
		 * Enable the Frustum near plane clipping on the visible polygons.
		 * Enable this when you need a perfect intersection between the front camera plane.
		 * This is mainly used when you need the camera to move on a long plane.</p>
		 * 
		 * <p>Important: Enable the clipping makes process a bit slower, especially with big scenes.</p>
		 */ 
		public var enableNearClipping:Boolean = false;
		
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
		public var enableClipping:Boolean = false;

		/**
		 * Should forced depth be enable for this object?.
		 *
		 * <p>If true it is possible to force this object to be drawn at a specific depth,<br/>
		 * if false the normal Z-sorting algorithm is applied.</p>
		 * <p>When correctly used, this feature allows you to avoid some Z-sorting problems.</p>
		 */
		public var enableForcedDepth:Boolean = false;
		
		/**
		 * The forced depth for this object.
		 *
		 * <p>To make this feature work, you must enable the ForcedDepth system too.<br/>
		 * The higher the depth is, the sooner the more far the object will be represented.</p>
		 */
		public var forcedDepth:Number = 0;	

		/**
		 * Creates a 3D object
		 *
		 * <p>[<b>Todo</b>: some more explanations]</p>
		 *
		 * @param p_sName		A string identifier for this object
		 * @param p_oGeometry		The geometry of this object
		 * @param p_oAppearance		The appearance of this object. If no apperance is given, the DEFAULT_APPEARANCE will be applied.
		 * @param p_bUseSingleContainer	Whether tis object should use a single container to draw on
		 */	
		public function Shape3D( p_sName:String = "", p_oGeometry:Geometry3D = null, p_oAppearance:Appearance = null, p_bUseSingleContainer:Boolean=true )
		{
			super( p_sName );
			// -- Add this graphical object to the World display list
			m_oContainer = new Sprite();
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
    	override public function set useSingleContainer( p_bUseSingleContainer:Boolean ):void
    	{
    		var l_oFace:Polygon;
    		// --
    		if( p_bUseSingleContainer == m_bUseSingleContainer ) return;
    		// --
    		if( p_bUseSingleContainer )
    		{
    			for each( l_oFace in aPolygons )
    			{
					if( l_oFace.container.parent ) 
					{
						l_oFace.container.graphics.clear();
						l_oFace.container.parent.removeChild( l_oFace.container );
						this.broadcaster.removeChild( l_oFace.broadcaster );
					}
    			}
    		}
    		else
    		{
    			if( m_oContainer.parent )
    			{
    				m_oContainer.graphics.clear();
    				m_oContainer.parent.removeChild( m_oContainer );
    			}
    			// --
    			for each( l_oFace in aPolygons )
    			{
					this.broadcaster.addChild( l_oFace.broadcaster );
					// we reset the polygon container to the original one, and add it to the world container
					l_oFace.container.graphics.clear();
    			}
    		}
    		m_bUseSingleContainer = p_bUseSingleContainer;
    	}
    

		/**
		 * @private
		 */
		public function get useSingleContainer ():Boolean
		{return m_bUseSingleContainer;}

		/**
		 * Updates the bounding volumes of this object.
		 */
    	public function updateBoundingVolumes():void
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
		 * <p><b>[MANDATORY] The update method must be called first!</b></p>
		 *
		 * @param p_oScene The current scene
		 * @param p_oFrustum	The frustum of the current camera
		 * @param p_oViewMatrix	The view martix of the curren camera
		 * @param p_bChanged
		 */
		public override function cull( p_oScene:Scene3D, p_oFrustum:Frustum, p_oViewMatrix:Matrix4, p_bChanged:Boolean ):void
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
			
			m_bClipped = ((culled == CullingState.INTERSECT) && ( enableClipping || enableNearClipping ));
		}
		
		/**
		 * Renders this 3D object.
		 *
		 * @param p_oScene The current scene
		 * @param p_oCamera	The current camera
		 */		
		public override function render( p_oScene:Scene3D, p_oCamera:Camera3D ):void
		{
			// IF no appearance has bene applied, no display
			if( m_oAppearance == null ) return;
			var 	m11:Number, m21:Number, m31:Number,
					m12:Number, m22:Number, m32:Number,
					m13:Number, m23:Number, m33:Number,
					m14:Number, m24:Number, m34:Number,
					x:Number, y:Number, z:Number, tx:Number, ty:Number, tz:Number;
					
			var  	l_nZNear:Number = p_oCamera.near, l_aPoints:Array = m_oGeometry.aVertex,
	        		l_oMatrix:Matrix4 = viewMatrix, l_oFrustum:Frustum = p_oCamera.frustrum, 
					l_aVertexNormals:Array = m_oGeometry.aVertexNormals,
					l_oVertexNormal:Vertex, l_oVertex:Vertex, l_oFace:Polygon, l_nMinZ:Number;
			
			// -- Now we can transform the objet vertices into the camera coordinates
			l_oMatrix = viewMatrix;
			m11 = l_oMatrix.n11; m21 = l_oMatrix.n21; m31 = l_oMatrix.n31;
			m12 = l_oMatrix.n12; m22 = l_oMatrix.n22; m32 = l_oMatrix.n32;
			m13 = l_oMatrix.n13; m23 = l_oMatrix.n23; m33 = l_oMatrix.n33;
			m14 = l_oMatrix.n14; m24 = l_oMatrix.n24; m34 = l_oMatrix.n34;
			for each( l_oVertex in l_aPoints )
			{				
				l_oVertex.wx = (x=l_oVertex.x) * m11 + (y=l_oVertex.y) * m12 + (z=l_oVertex.z) * m13 + m14;
				l_oVertex.wy = x * m21 + y * m22 + z * m23 + m24;
				l_oVertex.wz = x * m31 + y * m32 + z * m33 + m34;
				l_oVertex.projected = false;
			}
			// -- The polygons will be clipped, we shall allocate a new array container the clipped vertex.
			m_aVisiblePoly = [];
			m_nVisiblePoly = 0;
			m_nDepth = 0;
			
			for each( l_oFace in aPolygons )
            {
                l_oFace.isClipped = false;
                // --
                x =  l_oFace.normal.x ; y =  l_oFace.normal.y ; z =  l_oFace.normal.z ;
                // --
                tx = x * m11+ y * m12+ z * m13;
                ty = x * m21+ y * m22+ z * m23;
                tz = x * m31+ y * m32+ z * m33;
                // -- visibility computation
                x = l_oFace.a.wx*tx + l_oFace.a.wy*ty + l_oFace.a.wz*tz;
                l_oFace.visible = x < 0;
                // --
                if( l_oFace.visible || !m_bBackFaceCulling) 
                {
                    l_oFace.precompute();
                    l_nMinZ = l_oFace.minZ;
                    // --
                    if( m_bClipped && enableClipping ) // NEED COMPLETE CLIPPING
                    {
                            l_oFace.clip( l_oFrustum );
							// -- We project the vertices
					 		if( l_oFace.cvertices.length > 2 )
					 		{
					 			p_oCamera.projectArray( l_oFace.cvertices );
					 			if( !enableForcedDepth ) m_nDepth += l_oFace.m_nDepth;
                                else l_oFace.depth = forcedDepth;
                                // -- we manage the display list depending on the mode choosen
                                m_aVisiblePoly[int(m_nVisiblePoly++)] = l_oFace;
					 		}
					 }
					 else if(  enableNearClipping && l_nMinZ < l_nZNear ) // PARTIALLY VISIBLE
					 {
					 		l_oFace.clipFrontPlane( l_oFrustum );
							// -- We project the vertices
					 		if( l_oFace.cvertices.length > 2 )
					 		{
					 			p_oCamera.projectArray( l_oFace.cvertices );
					 			if( !enableForcedDepth ) m_nDepth += l_oFace.m_nDepth;
                                else l_oFace.depth = forcedDepth;
                                // -- we manage the display list depending on the mode choosen
                                m_aVisiblePoly[int(m_nVisiblePoly++)] = l_oFace;
					 		}
					 }
					 else if( l_nMinZ >= l_nZNear )
					 {
					 		p_oCamera.projectArray( l_oFace.vertices );
					 		if( !enableForcedDepth ) m_nDepth += l_oFace.m_nDepth;
					 		else l_oFace.depth = forcedDepth;
					    	// -- we manage the display list depending on the mode choosen
							m_aVisiblePoly[int(m_nVisiblePoly++)] = l_oFace;
					}
					else
					   continue;
					
					if( l_oFace.hasAppearanceChanged )
					{
						if( p_oScene.materialManager.isRegistered( l_oFace.appearance.frontMaterial ) == false )
						{
							p_oScene.materialManager.register( l_oFace.appearance.frontMaterial );
						}
						if( l_oFace.appearance.frontMaterial != l_oFace.appearance.backMaterial )
						{
							if( p_oScene.materialManager.isRegistered( l_oFace.appearance.backMaterial ) == false )
							{
								p_oScene.materialManager.register( l_oFace.appearance.backMaterial );
							}
						}
						l_oFace.hasAppearanceChanged = false;
					}
					
				}	 
		    }
			// --
			if( m_bUseSingleContainer )
			{
				if(enableForcedDepth) 	m_nDepth = forcedDepth;
				else 					m_nDepth /= m_aVisiblePoly.length;
				p_oCamera.addToDisplayList( this );
			}
			else
			{
			    p_oCamera.addArrayToDisplayList( m_aVisiblePoly );
			}
			
			var l_nFlags:int = appearance.flags;
			
			if( l_nFlags == 0 ) return;
			
			
			if( appearance.flags & SandyFlags.INVERT_MODEL_MATRIX )
			{
				// -- fast camera model matrix inverssion
				invModelMatrix.n11 = modelMatrix.n11;
				invModelMatrix.n12 = modelMatrix.n21;
				invModelMatrix.n13 = modelMatrix.n31;
				invModelMatrix.n21 = modelMatrix.n12;
				invModelMatrix.n22 = modelMatrix.n22;
				invModelMatrix.n23 = modelMatrix.n32;
				invModelMatrix.n31 = modelMatrix.n13;
				invModelMatrix.n32 = modelMatrix.n23;
				invModelMatrix.n33 = modelMatrix.n33;
				invModelMatrix.n14 = -(modelMatrix.n11 * modelMatrix.n14 + modelMatrix.n21 * modelMatrix.n24 + modelMatrix.n31 * modelMatrix.n34);
				invModelMatrix.n24 = -(modelMatrix.n12 * modelMatrix.n14 + modelMatrix.n22 * modelMatrix.n24 + modelMatrix.n32 * modelMatrix.n34);
				invModelMatrix.n34 = -(modelMatrix.n13 * modelMatrix.n14 + modelMatrix.n23 * modelMatrix.n24 + modelMatrix.n33 * modelMatrix.n34);
			}
			
			// DEPRECATED
			var i:int;
			l_oMatrix = modelMatrix;
            m11 = l_oMatrix.n11; m21 = l_oMatrix.n21; m31 = l_oMatrix.n31;
            m12 = l_oMatrix.n12; m22 = l_oMatrix.n22; m32 = l_oMatrix.n32;
            m13 = l_oMatrix.n13; m23 = l_oMatrix.n23; m33 = l_oMatrix.n33;
			if( appearance.flags & SandyFlags.POLYGON_NORMAL_WORLD )
            {
                // -- Now we transform the normals.
                for each( var l_oPoly:Polygon in m_aVisiblePoly )
                {
                    l_oVertex = l_oPoly.normal;
                    l_oVertex.wx  = (x=l_oVertex.x) * m11 + (y=l_oVertex.y) * m12 + (z=l_oVertex.z) * m13;
                    l_oVertex.wy  = x * m21 + y * m22 + z * m23;
                    l_oVertex.wz  = x * m31 + y * m32 + z * m33;
                }
            }
            if( appearance.flags & SandyFlags.VERTEX_NORMAL_WORLD )
            {
                // -- Now we transform the normals.
                i = m_oGeometry.aVertexNormals.length;
                while( --i > -1 )
                {
                    if( m_oGeometry.aVertex[int(i)].projected )
                    {
	                    l_oVertex = m_oGeometry.aVertexNormals[int(i)];
	                    l_oVertex.wx  = (x=l_oVertex.x) * m11 + (y=l_oVertex.y) * m12 + (z=l_oVertex.z) * m13;
	                    l_oVertex.wy  = x * m21 + y * m22 + z * m23;
	                    l_oVertex.wz  = x * m31 + y * m32 + z * m33;
                    }
                }
            }
		}
		
		
		public function get visiblePolygonsCount():uint
		{
			return m_nVisiblePoly;
		}
		
		/**
		* Clears the graphics object of this object's container.
		*
		* <p>The the graphics that were drawn on the Graphics object is erased, 
		* and the fill and line style settings are reset.</p>
		*/
		public function clear():void
		{
			if( m_oContainer ) m_oContainer.graphics.clear();
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
		public function display(  p_oScene:Scene3D, p_oContainer:Sprite = null  ):void
		{
			m_aVisiblePoly.sortOn( "depth", Array.NUMERIC | Array.DESCENDING );
		    // --
			for each( var l_oPoly:Polygon in m_aVisiblePoly )
			{
				l_oPoly.display( p_oScene, m_oContainer );
			}
		}

		/**
		 * The contianer for this object.
		 * This container property exist if the useSingleContainer is set to true.
		 * It is a direct access to the Shape3D container to, for example, apply nice effects such as filters etc.
		 */
		public function get container():Sprite
		{return m_oContainer;}
		
		/**
		 * The depth of this object.
		 * In case the useSingleContainer mode is enabled (default mode), this value returns the means depth of the Shape in the camera frame.
		 * This value is mainly used as a z-sorting value.
		 */
		public function get depth():Number
		{return m_nDepth;}
		
		/**
		 * This property call allows you to get the geometryCenter offset vector of the Shape.
		 * Modifying this vector will impact the way the shape is rendered, mainly its rotation center.
		 * 
		 * @return a vector which corresponds to the 2 directions offset.
		 */
		public function get geometryCenter():Vector
		{return m_oGeomCenter;}
		
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
		 *    var l_oSphere:Sphere = new Sphere("mySphere", 50, 3 );
		 *    // Change the rotation reference to -50 offset in Y direction from the orinal one
		 *    // and that corresponds to the bottom of the sphere
		 *    l_oSphere.geometryCenter = new Vector( 0, -50, 0 ); 
		 *    l_oSphere.rotateZ = 45;
		 * </listing>
		 */
		public function set geometryCenter( p_oGeomCenter:Vector ):void
		{
			var l_oDiff:Vector = p_oGeomCenter.clone();
			l_oDiff.sub( m_oGeomCenter );
			// --
			if( m_oGeometry )
			{
				for each( var l_oVertex:Vertex in m_oGeometry.aVertex )
				{
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
		 * Apply a new depth sorter to all the polygons.
		 * @param p_iSorter The new depth sorting object
		 */
		public function set depthSorter( p_iSorter:IDepthSorter ):void
    	{
    		for each( var l_oPoly:Polygon in  aPolygons)
			{
				l_oPoly.depthSorter = p_iSorter;
			}
    	}
    	
		/**
		 * The appearance of this object.
		 */
		override public function set appearance( p_oApp:Appearance ):void
		{
			// Now we register to the update event
			m_oAppearance = p_oApp;
			// --
			if( m_oGeometry )
			{
				for each( var v:Polygon in aPolygons )
					v.appearance = m_oAppearance;
			}
		}
		
		/**
		 * @private
		 */
		public function get appearance():Appearance 
		{
			return m_oAppearance;
		}
		       
		/**
		 * The geometry of this object.
		 */
		public function set geometry( p_geometry:Geometry3D ):void
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
		public function get geometry():Geometry3D
		{
			return m_oGeometry;
		}

	
		/**
		 * Should back face culling be enabled for this object?.
		 *
		 * <p>If set to false all faces of this object are drawn.<br/>
		 * A true value enables the back face culling algorithm - Default true</p>
		 */
		override public function set enableBackFaceCulling( b:Boolean ):void
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
		public function get enableBackFaceCulling():Boolean
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
		override public function set enableInteractivity( p_bState:Boolean ):void
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
				for each( var l_oPolygon:Polygon in aPolygons )
				{
		    		l_oPolygon.enableInteractivity = p_bState;
		    	}
		    			
				m_bMouseInteractivity = p_bState;
			}
		}	
		
		public function get enableInteractivity():Boolean
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
		 * 	var l_oShape:Shape3D = new Sphere("sphere");
		 * 	l_oShape.enableEvents = true;
		 * 	l_oShape.addEventListener( MouseEvent.CLICK, onClick );
		 * 
		 * 	function onClick( p_eEvent:Shape3DEvent ):void
         * 	{
         *   	var l_oPoly:Polygon = ( p_eEvent.polygon );  
         *   	var l_oPointAtClick:Vector =  p_eEvent.point;
         *   	// -- get the normalized uv of the point under mouse position
         *  	var l_oIntersectionUV:UVCoord = p_eEvent.uv;
         *   	// -- get the correct material
         *   	var l_oMaterial:BitmapMaterial = (l_oPoly.visible ? l_oPoly.appearance.frontMaterial : l_oPoly.appearance.backMaterial) as BitmapMaterial;
         * 	}
         * </code>
		 */
		override public function set enableEvents( b:Boolean ):void
		{
			// To use only when use Single container is disabled 
			var v:Polygon = null;
			
			if( b )
			{
				if( !m_bEv )
				{
	    			if( m_bUseSingleContainer == false )
	    			{
		    			for each( v in aPolygons )
						{
		    			    v.enableEvents = true;
		    			}
	    			}
	    			else
	    			{
	    				m_oContainer.addEventListener(MouseEvent.CLICK, _onInteraction);
			    		m_oContainer.addEventListener(MouseEvent.MOUSE_UP, _onInteraction);
			    		m_oContainer.addEventListener(MouseEvent.MOUSE_DOWN, _onInteraction);
			    		m_oContainer.addEventListener(MouseEvent.ROLL_OVER, _onInteraction);
			    		m_oContainer.addEventListener(MouseEvent.ROLL_OUT, _onInteraction);
			    		
						m_oContainer.addEventListener(MouseEvent.DOUBLE_CLICK, _onInteraction);
						m_oContainer.addEventListener(MouseEvent.MOUSE_MOVE, _onInteraction);
						m_oContainer.addEventListener(MouseEvent.MOUSE_OVER, _onInteraction);
						m_oContainer.addEventListener(MouseEvent.MOUSE_OUT, _onInteraction);
						m_oContainer.addEventListener(MouseEvent.MOUSE_WHEEL, _onInteraction);
	    			}
				}
			}
			else if( !b && m_bEv )
			{
				if( m_bUseSingleContainer == false )
    			{
	    			for each( v in aPolygons )
					{
	    			    v.enableEvents = false;
	    			}
    			}
    			else
    			{
    				m_oContainer.removeEventListener(MouseEvent.CLICK, _onInteraction);
					m_oContainer.removeEventListener(MouseEvent.MOUSE_UP, _onInteraction);
					m_oContainer.removeEventListener(MouseEvent.MOUSE_DOWN, _onInteraction);
					m_oContainer.removeEventListener(MouseEvent.ROLL_OVER, _onInteraction);
					m_oContainer.removeEventListener(MouseEvent.ROLL_OUT, _onInteraction);
					
					m_oContainer.removeEventListener(MouseEvent.DOUBLE_CLICK, _onInteraction);
					m_oContainer.removeEventListener(MouseEvent.MOUSE_MOVE, _onInteraction);
					m_oContainer.removeEventListener(MouseEvent.MOUSE_OVER, _onInteraction);
					m_oContainer.removeEventListener(MouseEvent.MOUSE_OUT, _onInteraction);
					m_oContainer.removeEventListener(MouseEvent.MOUSE_WHEEL, _onInteraction);
    			}
			}
			m_bEv = b;
		}
	
		protected function _onInteraction( p_oEvt:Event ):void
		{
			// we need to get the polygon which has been clicked.
			var l_oClick:Point = new Point( m_oContainer.mouseX, m_oContainer.mouseY );
			var l_oA:Point = new Point(), l_oB:Point = new Point(), l_oC:Point = new Point();
			var l_oPoly:Polygon;
			var l_aSId:Array = aPolygons.sortOn( 'depth', Array.NUMERIC | Array.RETURNINDEXEDARRAY );
			var l:int = aPolygons.length, j:int;
			for( j = 0; j < l; j += 1 )
			//j = l;
			//while( --j > -1 )
			{
				l_oPoly = aPolygons[ l_aSId[ int(j) ] ];
				if( !l_oPoly.visible && m_bBackFaceCulling ) continue;
				// --
				var l_nSize:int = l_oPoly.vertices.length;
				var l_nTriangles:int = l_nSize - 2;
				for( var i:int = 0; i < l_nTriangles; i++ )
				{
					l_oA.x = l_oPoly.vertices[i].sx; l_oA.y = l_oPoly.vertices[i].sy;
					l_oB.x = l_oPoly.vertices[i+1].sx; l_oB.y = l_oPoly.vertices[i+1].sy;
					l_oC.x = l_oPoly.vertices[(i+2)%l_nSize].sx; l_oC.y = l_oPoly.vertices[(i+2)%l_nSize].sy;
					// --
					if( IntersectionMath.isPointInTriangle2D( l_oClick, l_oA, l_oB, l_oC ) )
					{
						var l_oUV:UVCoord = l_oPoly.getUVFrom2D( l_oClick );
						var l_oPt3d:Vector = l_oPoly.get3DFrom2D( l_oClick );
						m_oEB.broadcastEvent( new Shape3DEvent( p_oEvt.type, this, l_oPoly, l_oUV, l_oPt3d, p_oEvt ) );
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
		 * (because you should not be in there).</p> 
		 *
		 * <p>If you need to be only inside the cube, you can call this method to change which side is culled.<br/>
		 * The faces will be visible only from the interior of the cube.</p>
		 *
		 * <p>If you want to be both on the inside and the outside, you want to make the faces visible from on both sides.<br/>
		 * In that case you just have to set enableBackFaceCulling to false.</p>
		 */
		public function swapCulling():void
		{
			for each( var v:Polygon in aPolygons )
			{
				v.swapCulling();
			}
			changed = true;
		}
		
		/**
		 * Destroy this object and all its faces
		 * container object is removed, and graphics cleared.  All polygons have their
		 */
		public override function destroy():void
		{
			// 	FIXME Fix it - it should be more like 
			m_oGeometry.dispose();
			// --
			clear();
			if( m_oContainer.parent ) m_oContainer.parent.removeChild( m_oContainer );
			if( m_oContainer ) m_oContainer = null;
			// --
			__destroyPolygons();
			// --
			super.destroy();
		}

		/**
		 * This method returns a clone of this Shape3D.
		 * The current appearance will be applied, and the geometry is cloned (not referenced to curent one).
		 * 
		 * @param p_sName The name of the new shape you are going to create
		 * @param p_bKeepTransform Boolean value which, if set to true, applies the current local transformations to the cloned shape. Default value is false.
		 *
		 * @return 	The clone
		 */
		public function clone( p_sName:String="", p_bKeepTransform:Boolean = false ):Shape3D
		{
			var l_oClone:Shape3D = new Shape3D( p_sName, geometry.clone(), appearance, m_bUseSingleContainer );
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
		public override function toString ():String
		{
			return "sandy.core.scenegraph.Shape3D" + " " +  m_oGeometry.toString();
		}

		///////////////////
		///// PRIVATE /////
		///////////////////
		
		private function __destroyPolygons():void
		{
	    	if( aPolygons != null && aPolygons.length > 0 )
			{
				var i:int, l:int = aPolygons.length;
				while( i<l )
				{
					if( broadcaster != null ) broadcaster.removeChild( aPolygons[i].broadcaster );
					if( aPolygons[i] ) Polygon( aPolygons[int(i)] ).destroy();
					// --
					aPolygons[int(i)] = null;
					// --
					i ++;
				}
			}
			aPolygons.splice(0);
			aPolygons = null;
		}
		
		private function __generatePolygons( p_oGeometry:Geometry3D ):void
		{
			var i:int = 0, j:int = 0, l:int = p_oGeometry.aFacesVertexID.length;
			aPolygons = new Array( l );
			// --
			for( i=0; i < l; i += 1 )
			{
				aPolygons[i] = new Polygon( this, p_oGeometry, p_oGeometry.aFacesVertexID[i], p_oGeometry.aFacesUVCoordsID[i], i, i );
				if( m_oAppearance ) aPolygons[int(i)].appearance = m_oAppearance;
				this.broadcaster.addChild( aPolygons[int(i)].broadcaster );
			}			
		}
	    		
		// ______________
		// [PRIVATE] DATA________________________________________________				
		private var m_oAppearance:Appearance ; // The Appearance of this Shape3D		
	    private var m_bEv:Boolean = false; // The event system state (enable or not)
		protected var m_oGeomCenter:Vector = new Vector();
		private var m_bBackFaceCulling:Boolean = true;
		private var m_bClipped:Boolean = false;
	
		/** Geometry of this object */
		private var m_oGeometry:Geometry3D;
		
		protected var m_bUseSingleContainer:Boolean = true;
		protected var m_nDepth:Number = 0;
		protected var m_oContainer:Sprite;

		private var m_aToProject:Array = new Array();
		private var m_aVisiblePoly:Array = new Array();	
		private var m_nVisiblePoly:int;	
		
		private var m_bMouseInteractivity:Boolean = false;
		private var m_bForcedSingleContainer:Boolean = false;
	}
}