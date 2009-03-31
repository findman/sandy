﻿package sandy.core.data{	import flash.display.Sprite;	import flash.events.Event;	import flash.events.KeyboardEvent;	import flash.events.MouseEvent;	import flash.geom.Matrix;	import flash.geom.Point;	import flash.geom.Rectangle;	import flash.utils.Dictionary;		import sandy.core.Scene3D;	import sandy.core.interaction.VirtualMouse;	import sandy.core.scenegraph.Geometry3D;	import sandy.core.scenegraph.IDisplayable;	import sandy.core.scenegraph.Shape3D;	import sandy.events.BubbleEventBroadcaster;	import sandy.events.SandyEvent;	import sandy.events.Shape3DEvent;	import sandy.materials.Appearance;	import sandy.materials.Material;	import sandy.math.IntersectionMath;	import sandy.math.Point3DMath;	import sandy.view.CullingState;	import sandy.view.Frustum;	/**	 * Polygon's are the building blocks of visible 3D shapes.	 *	 * @author		Thomas Pfeiffer - kiroukou	 * @author		Mirek Mencel	 * @since		1.0	 * @version		3.1	 * @date 		24.08.2007	 *	 * @see sandy.core.scenegraph.Shape3D	 */	public final class Polygon implements IDisplayable	{	// _______	// STATICS_______________________________________________________		private static var _ID_:uint = 0;				/**		 * This property lists all the polygons.		 * This is a helper property since it allows all polygons of a scene to be retrieved from a single list by its unique identifier.		 * A polygon's unique identifier can be retrieved useing <code>myPolygon.id</code>.		 *		 * @example The examples below shows how to retrieve a ploygon from this property. 		 * <listing version="3.1">		 * var p:Polygon = Polygon.POLYGON_MAP[myPolygon.id];		 * </listing>		 */		public static var POLYGON_MAP:Dictionary = new Dictionary(true);	// ______	// PUBLIC________________________________________________________		/**		 * The unique identifier for this polygon.		 */		public const id:uint = _ID_++;		/**		 * A reference to the Shape3D object this polygon belongs to.		 */		public var shape:Shape3D;						/**		 * Specifies if the polygon has been clipped.		 */		public var isClipped:Boolean = false;				/**		 * An array of clipped vertices. Check the <code>isClipped</code> property first to see if this array will contain the useful data.		 */		public var cvertices:Array;				/**		 * An array of the polygon's original vertices.		 */		public var vertices:Array;				/**		 * An array of the polygon's vertex normals.		 */		public var vertexNormals:Array;				public var aUVCoord:Array;		/**		 * An array of the polygon's edges.		 */		public var aEdges:Array;		public var caUVCoord:Array;		/**		 * The texture bounds.		 */		public var uvBounds:Rectangle;				/**		 * An array of polygons that share an edge with this polygon.		 */		public var aNeighboors:Array = new Array();		/**		 * Specifies whether the face of the polygon is visible.		 */		public var visible:Boolean;				/**		 * Minimum depth value of that polygon in the camera space		 */		public var minZ:Number;						public var a:Vertex, b:Vertex, c:Vertex, d:Vertex;				/**		 * Creates a new polygon.		 *		 * @param p_oShape			The shape the polygon belongs to.		 * @param p_geometry		The geometry the polygon belongs to.		 * @param p_aVertexID		An array of verticies of the polygon.		 * @param p_aUVCoordsID		An array of UV coordinates of this polygon.		 * @param p_nFaceNormalID	The faceNormalID of this polygon.		 * @param p_nEdgesID		The edgesID of this polygon.		 */		public function Polygon( p_oOwner:Shape3D, p_geometry:Geometry3D, p_aVertexID:Array, p_aUVCoordsID:Array=null, p_nFaceNormalID:Number=0, p_nEdgesID:uint=0 )		{			shape = p_oOwner;			m_oGeometry = p_geometry;			// --			__update( p_aVertexID, p_aUVCoordsID, p_nFaceNormalID, p_nEdgesID );			m_oContainer = new Sprite();			// --			POLYGON_MAP[id] = this;			m_oEB = new BubbleEventBroadcaster(this);		}		public function get changed():Boolean		{			return shape.changed;		}				/**		 * A reference to the Scene3D object this polygon is in.		 */		public function set scene(p_oScene:Scene3D):void		{			if( p_oScene == null ) return;			if( m_oScene != null )			{				m_oScene.removeEventListener(SandyEvent.SCENE_RENDER_FINISH, _finishMaterial );				m_oScene.removeEventListener(SandyEvent.SCENE_RENDER_DISPLAYLIST, _beginMaterial );			}			// --			m_oScene = p_oScene;			// --			m_oScene.addEventListener(SandyEvent.SCENE_RENDER_FINISH, _finishMaterial );			m_oScene.addEventListener(SandyEvent.SCENE_RENDER_DISPLAYLIST, _beginMaterial );		}				public function get scene():Scene3D		{			return m_oScene;		}		private var m_oScene:Scene3D = null;				/**		 * Updates the vertices and normals for this polygon.		 *		 * <p>Calling this method make the polygon gets its vertice and normals by reference		 * instead of accessing them by their ID.<br/>		 * This method shall be called once the geometry created.</p>		 *		 * @param p_aVertexID		The vertexID array of this polygon		 * @param p_aUVCoordsID		The UVCoordsID array of this polygon		 * @param p_nFaceNormalID	The faceNormalID of this polygon		 * @param p_nEdgesID		The edgesID of this polygon		 */		private function __update( p_aVertexID:Array, p_aUVCoordsID:Array, p_nFaceNormalID:uint, p_nEdgeListID:uint ):void		{			var i:int=0;			// --			vertexNormals = new Array();			vertices = new Array();			for each( var o:* in p_aVertexID )			{				vertices[i] = Vertex( m_oGeometry.aVertex[ p_aVertexID[i] ] );				vertexNormals[i] = m_oGeometry.aVertexNormals[ p_aVertexID[i] ];				i++;			}			// --			a = vertices[0];			b = vertices[1];			c = vertices[2];			d = vertices[3];			// -- every polygon does not have some texture coordinates			if( p_aUVCoordsID )			{				var l_nMinU:Number = Number.POSITIVE_INFINITY, l_nMinV:Number = Number.POSITIVE_INFINITY,									l_nMaxU:Number = Number.NEGATIVE_INFINITY, l_nMaxV:Number = Number.NEGATIVE_INFINITY;				// --				aUVCoord = new Array();				i = 0;				if( p_aUVCoordsID )				{					for each( var p:* in p_aUVCoordsID )					{						var l_oUV:UVCoord = ( m_oGeometry.aUVCoords[ p_aUVCoordsID[i] ] as UVCoord);						if( l_oUV == null ) l_oUV = new UVCoord(0,0);						// --						aUVCoord[i] = l_oUV;						if( l_oUV.u < l_nMinU ) l_nMinU = l_oUV.u;						else if( l_oUV.u > l_nMaxU ) l_nMaxU = l_oUV.u;						// --						if( l_oUV.v < l_nMinV ) l_nMinV = l_oUV.v;						else if( l_oUV.v > l_nMaxV ) l_nMaxV = l_oUV.v;						// --						i++;					}					// --					uvBounds = new Rectangle( l_nMinU, l_nMinV, l_nMaxU-l_nMinU, l_nMaxV-l_nMinV );				}				else				{					aUVCoord = [new UVCoord(), new UVCoord(), new UVCoord()];					uvBounds = new Rectangle(0,0,0,0);				}			}			// --			m_nNormalId = p_nFaceNormalID;			normal = Vertex( m_oGeometry.aFacesNormals[ p_nFaceNormalID ] );			// If no normal has been given, we create it ourself.			if( normal == null )			{				var l_oNormal:Point3D = createNormal();				m_nNormalId = m_oGeometry.setFaceNormal( m_oGeometry.getNextFaceNormalID(), l_oNormal.x, l_oNormal.y, l_oNormal.z );			}			// --			aEdges = new Array();			for each( var l_nEdgeId:uint in  m_oGeometry.aFaceEdges[p_nEdgeListID] )			{				var l_oEdge:Edge3D = m_oGeometry.aEdges[ l_nEdgeId ];				l_oEdge.vertex1 = m_oGeometry.aVertex[ l_oEdge.vertexId1 ];				l_oEdge.vertex2 = m_oGeometry.aVertex[ l_oEdge.vertexId2 ];				aEdges.push( l_oEdge );			}		}				public function get normal():Vertex		{			return m_oGeometry.aFacesNormals[ m_nNormalId ];		}				public function set normal( p_oVertex:Vertex ):void		{			if( p_oVertex != null )				m_oGeometry.aFacesNormals[ m_nNormalId ].copy( p_oVertex );		}				public function updateNormal():void		{			var x:Number = 	((a.y - b.y) * (c.z - b.z)) - ((a.z - b.z) * (c.y - b.y)) ;			var y:Number =	((a.z - b.z) * (c.x - b.x)) - ((a.x - b.x) * (c.z - b.z)) ;			var z:Number = 	((a.x - b.x) * (c.y - b.y)) - ((a.y - b.y) * (c.x - b.x)) ;			normal.reset( x, y, z );		}				/**		 * The depth of the polygon.		 */		public function get depth():Number		{			return m_nDepth;		}				/**		 * @private		 */		public function set depth( p_nDepth:Number ):void		{			m_nDepth = p_nDepth;		}				/**		 * The broadcaster of the polygon that sends events to listeners.		 */		public function get broadcaster():BubbleEventBroadcaster		{			return m_oEB;		}		/**		 * Adds an event listener to the polygon.		 *		 * @param p_sEvent 	The name of the event to add.		 * @param oL 		The listener object.		 */		public function addEventListener(p_sEvent:String, oL:*) : void		{			m_oEB.addEventListener.apply(m_oEB, arguments);		}		/**		 * Removes an event listener to the polygon.		 *		 * @param p_sEvent 	The name of the event to remove.		 * @param oL 		The listener object.		 */		public function removeEventListener(p_sEvent:String, oL:*) : void		{			m_oEB.removeEventListener(p_sEvent, oL);		}		/**		 * Computes several properties of the polygon.		 * <p>The computed properties are listed below:</p>		 * <ul>		 *  <li><code>visible</code></li>		 *  <li><code>minZ</code></li>		 *  <li><code>depth</code></li>		 * </ul>		 */		public function precompute():void		{			isClipped = false;			// --			minZ = a.wz;			if (b.wz < minZ) minZ = b.wz;			m_nDepth = a.wz + b.wz;			// --			if (c != null)			{				if (c.wz < minZ) minZ = c.wz;				m_nDepth += c.wz;			}			if (d != null)			{				if (d.wz < minZ) minZ = d.wz;				m_nDepth += d.wz;			}			m_nDepth /= vertices.length;		}			/**		 * Returns a Point3D (3D position) on the polygon relative to the specified point on the 2D screen.		 *		 * @example	Below is an example of how to get the 3D coordinate of the polygon under the position of the mouse:		 * <listing version="3.1">		 * var screenPoint:Point = new Point(myPolygon.container.mouseX, myPolygon.container.mouseY);		 * var scenePosition:Point3D = myPolygon.get3DFrom2D(screenPoint);         * </listing>         *          * @return A Point3D that corresponds to the specified point.         */		public function get3DFrom2D( p_oScreenPoint:Point ):Point3D		{          		/// NEW CODE ADDED BY MAX with the help of makc ///						var m1:Matrix= new Matrix(						vertices[1].sx-vertices[0].sx,						vertices[2].sx-vertices[0].sx,						vertices[1].sy-vertices[0].sy,						vertices[2].sy-vertices[0].sy,						0,						0);			m1.invert();											var capA:Number = m1.a *(p_oScreenPoint.x-vertices[0].sx) + m1.b * (p_oScreenPoint.y -vertices[0].sy);			var capB:Number = m1.c *(p_oScreenPoint.x-vertices[0].sx) + m1.d * (p_oScreenPoint.y -vertices[0].sy);						var l_oPoint:Point3D = new Point3D(							vertices[0].x + capA*(vertices[1].x -vertices[0].x) + capB *(vertices[2].x - vertices[0].x),				vertices[0].y + capA*(vertices[1].y -vertices[0].y) + capB *(vertices[2].y - vertices[0].y),				vertices[0].z + capA*(vertices[1].z -vertices[0].z) + capB *(vertices[2].z - vertices[0].z)				);														// transform the vertex with the model Matrix			this.shape.matrix.transform( l_oPoint );			return l_oPoint;		}				/**		 * Returns a UV coordinate elative to the specified point on the 2D screen.		 *		 * @example	Below is an example of how to get the UV coordinate under the position of the mouse:		 * <listing version="3.1">		 * var screenPoint:Point = new Point(myPolygon.container.mouseX, myPolygon.container.mouseY);		 * var scenePosition:Point3D = myPolygon.getUVFrom2D(screenPoint);         * </listing>         *          * @return A the UV coordinate that corresponds to the specified point.         */		public function getUVFrom2D( p_oScreenPoint:Point ):UVCoord		{			var p0:Point = new Point(vertices[0].sx, vertices[0].sy);            var p1:Point = new Point(vertices[1].sx, vertices[1].sy);            var p2:Point = new Point(vertices[2].sx, vertices[2].sy);                      var u0:UVCoord = aUVCoord[0];            var u1:UVCoord = aUVCoord[1];            var u2:UVCoord = aUVCoord[2];                      var v01:Point = new Point(p1.x - p0.x, p1.y - p0.y );                       var vn01:Point = v01.clone();            vn01.normalize(1);                       var v02:Point = new Point(p2.x - p0.x, p2.y - p0.y );            var vn02:Point = v02.clone(); vn02.normalize(1);                       // sub that from click point            var v4:Point = new Point( p_oScreenPoint.x - v01.x, p_oScreenPoint.y - v01.y );                        // we now have everything to find 1 intersection            var l_oInter:Point = IntersectionMath.intersectionLine2D( p0, p2, p_oScreenPoint, v4 );                        // find Point3Ds to intersection            var vi02:Point = new Point( l_oInter.x - p0.x, l_oInter.y - p0.y );                  var vi01:Point = new Point( p_oScreenPoint.x - l_oInter.x , p_oScreenPoint.y - l_oInter.y );            // interpolation coeffs            var d1:Number = vi01.length / v01.length ;            var d2:Number = vi02.length / v02.length;                                 // -- on interpole linéairement pour trouver la position du point dans repere de la texture (normalisé)            return new UVCoord( u0.u + d1*(u1.u - u0.u) + d2*(u2.u - u0.u),				                u0.v + d1*(u1.v - u0.v) + d2*(u2.v - u0.v));		}				/**		 * Clips the polygon.		 *		 * @return An array of vertices clipped by the camera frustum.		 */		public function clip( p_oFrustum:Frustum ):Array		{			cvertices = null;			caUVCoord = null;			// --			var l_oCull:CullingState = p_oFrustum.polygonInFrustum( this );			if( l_oCull == CullingState.INSIDE )				return vertices;			else if( l_oCull == CullingState.OUTSIDE )				return null;			// For lines we only apply front plane clipping			if( vertices.length < 3 )			{				clipFrontPlane( p_oFrustum );			} 			else			{				cvertices = vertices.concat();				caUVCoord = aUVCoord.concat();				// --				isClipped = p_oFrustum.clipFrustum( cvertices, caUVCoord );			}			return cvertices;		}		/**		 * Perform a clipping against the camera frustum's front plane.		 *		 * @return An array of vertices clipped by the camera frustum's front plane.		 */		public function clipFrontPlane( p_oFrustum:Frustum ):Array		{			cvertices = vertices.concat();			// If line			if( vertices.length < 3 ) 			{				isClipped = p_oFrustum.clipLineFrontPlane( cvertices );			}			else			{				caUVCoord = aUVCoord.concat();				isClipped = p_oFrustum.clipFrontPlane( cvertices, caUVCoord );			}			return cvertices;		}		/**		 * Clears the polygon's container.		 */		public function clear():void		{			if (m_oContainer != null) m_oContainer.graphics.clear();		}		/**		 * Draws the polygon on its container if visible.		 *		 * @param p_oScene		The scene this polygon is rendered in.		 * @param p_oContainer	The container to draw on.		 */		public function display( p_oContainer:Sprite = null ):void		{			const lCont:Sprite = (p_oContainer)?p_oContainer:m_oContainer;			if( material )				material.renderPolygon( scene, this, lCont );		}				/**		 * Returns the material currently used by the renderer		 * @return Material the material used to render		 */		public function get material():Material		{			if( m_oAppearance == null ) return null;			return ( visible ) ? m_oAppearance.frontMaterial : m_oAppearance.backMaterial;		}		/**		 * The polygon's container.		 */		public function get container():Sprite		{			return m_oContainer;		}		/**		 * Returns a string representation of this object.		 *		 * @return	The fully qualified name of this object.		 */		public function toString():String		{			return "sandy.core.data.Polygon::id=" +id+ " [Points: " + vertices.length + "]";		}		/**		 * Specifies whether mouse events are enabled for this polygon.		 *		 * <p>To apply events to a polygon, listeners must be added with the <code>addEventListener()</code> method.</p>		 *		 * @see #addEventListener()		 */		public function get enableEvents():Boolean		{			return mouseEvents;		}				/**		 * @private		 */		public function set enableEvents( b:Boolean ):void		{	        if( b && !mouseEvents )	        {	        	container.addEventListener(MouseEvent.CLICK, _onInteraction);	    		container.addEventListener(MouseEvent.MOUSE_UP, _onInteraction);	    		container.addEventListener(MouseEvent.MOUSE_DOWN, _onInteraction);	    		container.addEventListener(MouseEvent.ROLL_OVER, _onInteraction);	    		container.addEventListener(MouseEvent.ROLL_OUT, _onInteraction);	    						container.addEventListener(MouseEvent.DOUBLE_CLICK, _onInteraction);				container.addEventListener(MouseEvent.MOUSE_MOVE, _onInteraction);				container.addEventListener(MouseEvent.MOUSE_OVER, _onInteraction);				container.addEventListener(MouseEvent.MOUSE_OUT, _onInteraction);				container.addEventListener(MouseEvent.MOUSE_WHEEL, _onInteraction);    			}			else if( !b && mouseEvents )			{				container.removeEventListener(MouseEvent.CLICK, _onInteraction);				container.removeEventListener(MouseEvent.MOUSE_UP, _onInteraction);				container.removeEventListener(MouseEvent.MOUSE_DOWN, _onInteraction);				container.removeEventListener(MouseEvent.ROLL_OVER, _onInteraction);				container.removeEventListener(MouseEvent.ROLL_OUT, _onInteraction);								container.removeEventListener(MouseEvent.DOUBLE_CLICK, _onInteraction);				container.removeEventListener(MouseEvent.MOUSE_MOVE, _onInteraction);				container.removeEventListener(MouseEvent.MOUSE_OVER, _onInteraction);				container.removeEventListener(MouseEvent.MOUSE_OUT, _onInteraction);				container.removeEventListener(MouseEvent.MOUSE_WHEEL, _onInteraction);	    	}	    	mouseEvents = b;		}		private var m_bWasOver:Boolean = false;		/**		 * @private		 */		protected function _onInteraction( p_oEvt:Event ):void		{ 			var l_oClick:Point = new Point( m_oContainer.mouseX, m_oContainer.mouseY );			var l_oUV:UVCoord = getUVFrom2D( l_oClick );			var l_oPt3d:Point3D = get3DFrom2D( l_oClick );			shape.m_oLastContainer = this.m_oContainer;			shape.m_oLastEvent = new Shape3DEvent( p_oEvt.type, shape, this, l_oUV, l_oPt3d, p_oEvt );			m_oEB.dispatchEvent( shape.m_oLastEvent );			if( p_oEvt.type == MouseEvent.MOUSE_OVER )				shape.m_bWasOver = true;		}				/**		 * @private		 */		public function _startMouseInteraction( e : MouseEvent = null ) : void		{			container.addEventListener(MouseEvent.CLICK, _onTextureInteraction);			container.addEventListener(MouseEvent.MOUSE_UP, _onTextureInteraction);			container.addEventListener(MouseEvent.MOUSE_DOWN, _onTextureInteraction);						container.addEventListener(MouseEvent.DOUBLE_CLICK, _onTextureInteraction);			container.addEventListener(MouseEvent.MOUSE_MOVE, _onTextureInteraction);			container.addEventListener(MouseEvent.MOUSE_OVER, _onTextureInteraction);			container.addEventListener(MouseEvent.MOUSE_OUT, _onTextureInteraction);			container.addEventListener(MouseEvent.MOUSE_WHEEL, _onTextureInteraction);						container.addEventListener(KeyboardEvent.KEY_DOWN, _onTextureInteraction);			container.addEventListener(KeyboardEvent.KEY_UP, _onTextureInteraction);						m_oContainer.addEventListener( Event.ENTER_FRAME, _onTextureInteraction );		}				/**		 * @private		 */		public function _stopMouseInteraction( e : MouseEvent = null ) : void		{			m_oContainer.removeEventListener(MouseEvent.CLICK, _onTextureInteraction);			m_oContainer.removeEventListener(MouseEvent.MOUSE_UP, _onTextureInteraction);			m_oContainer.removeEventListener(MouseEvent.MOUSE_DOWN, _onTextureInteraction);						m_oContainer.removeEventListener(MouseEvent.DOUBLE_CLICK, _onTextureInteraction);			m_oContainer.removeEventListener(MouseEvent.MOUSE_MOVE, _onTextureInteraction);			m_oContainer.removeEventListener(MouseEvent.MOUSE_OVER, _onTextureInteraction);			m_oContainer.removeEventListener(MouseEvent.MOUSE_OUT, _onTextureInteraction);			m_oContainer.removeEventListener(MouseEvent.MOUSE_WHEEL, _onTextureInteraction);			m_oContainer.removeEventListener( Event.ENTER_FRAME, _onTextureInteraction );						m_oContainer.removeEventListener(KeyboardEvent.KEY_DOWN, _onTextureInteraction);			m_oContainer.removeEventListener(KeyboardEvent.KEY_UP, _onTextureInteraction);					}				/**		 * Specifies whether <code>MouseEvent.ROLL_&#42;</code> events are enabled for this polygon.		 *		 * <p>To apply events to a polygon, listeners must be added with the <code>addEventListener()</code> method.</p>		 *		 * @see #addEventListener()		 */		public function get enableInteractivity():Boolean		{			return mouseInteractivity;		}				/**		 * @private		 */		public function set enableInteractivity( p_bState:Boolean ):void		{			if( p_bState != mouseInteractivity )			{				if( p_bState )				{					container.addEventListener( MouseEvent.ROLL_OVER, _startMouseInteraction, false );					container.addEventListener( MouseEvent.ROLL_OUT, _stopMouseInteraction, false );				}				else				{					_stopMouseInteraction();				}				// --				mouseInteractivity = p_bState;			}		}				/**		 * @private		 */		public function _onTextureInteraction( p_oEvt:Event = null ) : void		{			if ( p_oEvt == null || !(p_oEvt is MouseEvent) ) p_oEvt = new MouseEvent( MouseEvent.MOUSE_MOVE, true, false, 0, 0, null, false, false, false, false, 0);					    //	get the position of the mouse on the poly			var pt2D : Point = new Point( scene.container.mouseX, scene.container.mouseY );			var uv : UVCoord = getUVFrom2D( pt2D );			VirtualMouse.getInstance().interactWithTexture( this, uv, p_oEvt as MouseEvent );			_onInteraction( p_oEvt );		}			/**		 * Returns the transformed normal Point3D of the polygon.		 *		 * @return The transformed normal Point3D of the polygon.		 */		public function createTransformedNormal():Point3D		{			if( vertices.length > 2 )			{				var v:Point3D, w:Point3D;				var a:Vertex = vertices[0], b:Vertex = vertices[1], c:Vertex = vertices[2];				v = new Point3D( b.wx - a.wx, b.wy - a.wy, b.wz - a.wz );				w = new Point3D( b.wx - c.wx, b.wy - c.wy, b.wz - c.wz );				// we compute de cross product				var l_normal:Point3D = Point3DMath.cross( v, w );				// we normalize the resulting Point3D				Point3DMath.normalize( l_normal ) ;				// we return the resulting vertex				return l_normal;			}			else			{				return new Point3D();			}		}		/**		 * Returns the normal Point3D of the polygon.		 *		 * @return The normal Point3D of the polygon.		 */		public function createNormal():Point3D		{			if( vertices.length > 2 )			{				var v:Point3D, w:Point3D;				var a:Vertex = vertices[0], b:Vertex = vertices[1], c:Vertex = vertices[2];				v = new Point3D( b.x - a.x, b.y - a.y, b.z - a.z );				w = new Point3D( b.x - c.x, b.y - c.y, b.z - c.z );				// we compute de cross product				var l_normal:Point3D = Point3DMath.cross( v, w );				// we normalize the resulting Point3D				Point3DMath.normalize( l_normal ) ;				// we return the resulting vertex				return l_normal;			}			else			{				return new Point3D();			}		}				/**		 * The appearance of this polygon.		 */		public function get appearance():Appearance		{			return m_oAppearance;		}				/**		 * @private		 */		public function set appearance( p_oApp:Appearance ):void		{			if( p_oApp == m_oAppearance ) return;			// --			if( m_oAppearance != null && p_oApp != null)			{				if( p_oApp.frontMaterial != m_oAppearance.frontMaterial )				{					m_oAppearance.frontMaterial.unlink( this );					p_oApp.frontMaterial.init( this );				}				if( m_oAppearance.frontMaterial != m_oAppearance.backMaterial && p_oApp.backMaterial != m_oAppearance.backMaterial )				{					m_oAppearance.backMaterial.unlink( this );				}				if( p_oApp.frontMaterial != p_oApp.backMaterial	&& p_oApp.backMaterial != m_oAppearance.backMaterial )				{					p_oApp.backMaterial.init( this );				}				m_oAppearance = p_oApp;			}			else if( p_oApp )			{				m_oAppearance = p_oApp;				m_oAppearance.frontMaterial.init( this );				if( m_oAppearance.backMaterial != m_oAppearance.frontMaterial ) 					m_oAppearance.backMaterial.init( this );			}			else if( m_oAppearance )			{				m_oAppearance.frontMaterial.unlink( this );				if( m_oAppearance.backMaterial != m_oAppearance.frontMaterial ) 					m_oAppearance.backMaterial.unlink( this );				m_oAppearance = null;			}		}				private function _finishMaterial( pEvt:SandyEvent ):void		{			if( !m_oAppearance ) return;			// --			if( m_oAppearance.frontMaterial )			{				m_oAppearance.frontMaterial.finish( m_oScene );			}			if(  m_oAppearance.backMaterial && m_oAppearance.backMaterial != m_oAppearance.frontMaterial ) 			{				m_oAppearance.backMaterial.finish( m_oScene );			}		}				private function _beginMaterial( pEvt:SandyEvent ):void		{			if( !m_oAppearance ) return;			// --			if( m_oAppearance.frontMaterial )			{				m_oAppearance.frontMaterial.begin( m_oScene );			}			if( m_oAppearance.backMaterial && m_oAppearance.backMaterial != m_oAppearance.frontMaterial ) 			{				m_oAppearance.backMaterial.begin( m_oScene );			}		}		/**		 * Changes which side is the "normal" culling side.		 *		 * <p>This method also swaps the front and back skins.</p>		 */		public function swapCulling():void		{			normal.negate();		}		/**		 * Removes the polygon's container from the stage.		 */		public function destroy():void		{			clear();			if (scene) {				scene.removeEventListener(SandyEvent.SCENE_RENDER_FINISH, _finishMaterial );				scene.removeEventListener(SandyEvent.SCENE_RENDER_DISPLAYLIST, _beginMaterial );			}			// --			enableEvents = false;			enableInteractivity = false;			if( appearance )			{				if( appearance.backMaterial ) appearance.backMaterial.unlink( this );				if( appearance.frontMaterial ) appearance.frontMaterial.unlink( this );				appearance = null;			}			if( m_oContainer ) {				if( m_oContainer.parent ) m_oContainer.parent.removeChild( m_oContainer );				m_oContainer = null;			}			// --			cvertices = null;			vertices = null;			m_oEB = null;			m_oGeometry = null;			shape = null;			scene = null;			// -- memory leak fix from nopmb on mediabox forums			delete POLYGON_MAP[id];		}	// _______	// PRIVATE_______________________________________________________		/** Reference to its owner geometry */		private var m_oGeometry:Geometry3D;		private var m_oAppearance:Appearance;		private var m_nNormalId:uint;		private var m_nDepth:Number;		/**		 * @private		 */		protected var m_oContainer:Sprite;		/**		 * @private		 */		protected var m_oEB:BubbleEventBroadcaster;		/** Boolean representing the state of the event activation */		private var mouseEvents:Boolean = false;		private var mouseInteractivity:Boolean = false;	}}