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

import flash.geom.Rectangle;
	
import sandy.core.scenegraph.IDisplayable;
import sandy.core.scenegraph.ATransformable;
import sandy.core.Scene3D;
import sandy.core.data.Matrix4;
import sandy.core.data.Vertex;
import sandy.util.NumberUtil;
import sandy.view.Frustum;
import sandy.view.ViewPort;
	
/**
 * The Camera3D class is used to create a camera for the Sandy world.
 *
 * <p>As of this version of Sandy, the camera is added to the object tree,
 * which means it is transformed in the same manner as any other object.</p>
 * 
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - xdevltd
 * @version		2.0.2
 * @date 		26.07.2007
 */
 
class sandy.core.scenegraph.Camera3D extends ATransformable
{		
	
	/**
	 * The camera viewport
	 */
	public var viewport:ViewPort;
	
	/**
	 * The frustum of the camera.
	 */
	public var frustrum:Frustum;

	/**
	 * Creates a camera for projecting visible objects in the world.
	 *
	 * <p>By default the camera shows a perspective projection. <br />
	 * The camera is at -300 in z axis and look at the world 0,0,0 point.</p>
	 * 
	 * @param p_nWidth	Width of the camera viewport in pixels
	 * @param p_nHeight	Height of the camera viewport in pixels
	 * @param p_nFov	The vertical angle of view in degrees - Default 45
	 * @param p_nNear	The distance from the camera to the near clipping plane - Default 50
	 * @param p_nFar	The distance from the camera to the far clipping plane - Default 10000
	 */
	public function Camera3D( p_nWidth:Number, p_nHeight:Number, p_nFov:Number, p_nNear:Number, p_nFar:Number )
	{
		super( null );
		frustrum = new Frustum();			
		_mp = new Matrix4();
		_mpInv = new Matrix4();
		viewport = new ViewPort( 640, 80 );
		viewport.width = p_nWidth||550;
		viewport.height = p_nHeight||400;
		// --
		_nFov = p_nFov||45;
		_nFar = p_nFar||50;
		_nNear = p_nNear||10000;
		// --
		setPerspectiveProjection( _nFov, viewport.ratio, _nNear, _nFar );
		m_nOffx = viewport.width2; 
		m_nOffy = viewport.height2;
		viewport.hasChanged = false;
		// It's a non visible node
		visible = false;
		z = -300;
		lookAt( 0,0,0 );
	}
						
	/**
	 * The angle of view of this camera in degrees.
	 */
	public function set fov( p_nFov:Number ) : Void
	{
		_nFov = p_nFov;
		_perspectiveChanged = true;
	}
		
	/**
	 * @private
	 */
	public function get fov() : Number
	{ return _nFov; }
	
	/**
	 * Near plane distance for culling/clipping.
	 */
	public function set near( pNear:Number ) : Void
	{ _nNear = pNear; _perspectiveChanged = true; }
	
	/**
	 * @private
	 */
	public function get near() : Number
	{ return _nNear; }
			
	/**
	 * Far plane distance for culling/clipping.
	 */
	public function set far( pFar:Number ) : Void
	{ _nFar = pFar; _perspectiveChanged = true; }
	
	/**
	 * @private
	 */
	public function get far() : Number
	{ return _nFar; }

	///////////////////////////////////////
	//// GRAPHICAL ELEMENTS MANAGMENT /////
	///////////////////////////////////////
					
	/**
	 * <p>Project the vertices list given in parameter.	 * The vertices are projected to the screen, as a 2D position.
	 * </p>
	 */
	public function projectArray( p_oList:Array ) : Void
	{
		var l_nX:Number = viewport.offset.x + m_nOffx;
		var l_nY:Number = viewport.offset.y + m_nOffy;
		var l_nCste:Number;
		var l_mp11_offx:Number = mp11 * m_nOffx;   
		var l_mp22_offy:Number = mp22 * m_nOffy; 
		var l_oVertex:Vertex;
		for( l_oVertex in p_oList )
		{
			if( l_oVertex.projected == false )//(l_oVertex.flags & SandyFlags.VERTEX_PROJECTED) == 0)
			{ 
				l_nCste = 1 / l_oVertex.wz;   
				l_oVertex.sx = l_nCste * l_oVertex.wx * l_mp11_offx + l_nX;
				l_oVertex.sy = -l_nCste * l_oVertex.wy * l_mp22_offy + l_nY;
				//l_oVertex.flags |= SandyFlags.VERTEX_PROJECTED;
				l_oVertex.projected = true;
			}
		}
	}
			
	/**
	 * <p>Project the vertex passed as parameter.
	 * The vertices are projected to the screen, as a 2D position.
	 * </p>
	 */
	public function projectVertex( p_oVertex:Vertex ) : Void
	{
		if( p_oVertex.projected == false )//(p_oVertex.flags & SandyFlags.VERTEX_PROJECTED) == 0)
		{
			var l_nX:Number = ( viewport.offset.x + m_nOffx );
			var l_nY:Number = ( viewport.offset.y + m_nOffy );
			var l_nCste:Number = 1 / p_oVertex.wz;
			p_oVertex.sx =  l_nCste * p_oVertex.wx * mp11 * m_nOffx + l_nX;
			p_oVertex.sy = -l_nCste * p_oVertex.wy * mp22 * m_nOffy + l_nY;
			//p_oVertex.flags |= SandyFlags.VERTEX_PROJECTED;
			p_oVertex.projected = true;
		} 
	}
		
	/**
	 * Nothing is done here - the camera is not rendered
	 */
	public function render( p_oScene:Scene3D, p_oCamera:Camera3D ) : Void
	{
		return;/* Nothing to do here */
	}
	
	/**
	 * Updates the state of the camera transformation.
	 *
	 * @param p_oScene			The current scene
	 * @param p_oModelMatrix The matrix which represents the parent model matrix. Basically it stores the rotation/translation/scale of all the nodes above the current one.
	 * @param p_bChanged	A boolean value which specify if the state has changed since the previous rendering. If false, we save some matrix multiplication process.
	 */
	public function update( p_oScene:Scene3D, p_oModelMatrix:Matrix4, p_bChanged:Boolean ) : Void
	{
		if( viewport.hasChanged )
		{
			_perspectiveChanged = true;
			// -- update the local values
			m_nOffx = viewport.width2; 
			m_nOffy = viewport.height2;
			// -- Apply a scrollRect to the container at the viewport dimension
			if( p_oScene.rectClipping ) 
				p_oScene.container.scrollRect = new Rectangle( 0, 0, viewport.width, viewport.height );
			// -- we warn the the modification has been taken under account
			viewport.hasChanged = false;
		}
		// --
		if( _perspectiveChanged ) updatePerspective();
		super.update( p_oScene, p_oModelMatrix, p_bChanged );
	}
	
	/**
	 * Nothing to do - the camera can't be culled
	 */
	public function cull( p_oScene:Scene3D, p_oFrustum:Frustum, p_oViewMatrix:Matrix4, p_bChanged:Boolean ) : Void
	{
		return;
	}
	
	/**
	* Returns the projection matrix of this camera. 
	* 
	* @return 	The projection matrix
	*/
	public function get projectionMatrix() : Matrix4
	{
		return _mp;
	}
	
	/**
	 * Returns the inverse of the projection matrix of this camera.
	 *
	 * @return 	The inverted projection matrix
	 */
	public function get invProjectionMatrix() : Matrix4
	{
		_mpInv.copy( _mp );  
		_mpInv.inverse(); 
		
		return _mpInv;
	}
		
	/**
	* Sets a projection matrix with perspective. 
	*
	* <p>This projection allows a natural visual presentation of objects, mimicking 3D perspective.</p>
	*
	* @param p_nFovY 	The angle of view in degrees - Default 45.
	* @param p_nAspectRatio The ratio between vertical and horizontal dimension - Default the viewport ratio ( width/height )
	* @param p_nZNear 	The distance betweeen the camera and the near plane - Default 10.
	* @param p_nZFar 	The distance betweeen the camera position and the far plane. Default 10 000.
	*/
	private function setPerspectiveProjection( p_nFovY:Number, p_nAspectRatio:Number, p_nZNear:Number, p_nZFar:Number ) : Void
	{
		var cotan:Number, Q:Number;
		// --
		frustrum.computePlanes( p_nAspectRatio, p_nZNear, p_nZFar, p_nFovY );
		// --
		p_nFovY = NumberUtil.toRadian( p_nFovY );
		cotan = 1 / Math.tan( p_nFovY / 2 );
		Q = p_nZFar / ( p_nZFar - p_nZNear );
		
		_mp.zero();

		_mp.n11 = cotan / p_nAspectRatio;
		_mp.n22 = cotan;
		_mp.n33 = Q;
		_mp.n34 = -Q * p_nZNear;
		_mp.n43 = 1;
		// to optimize later
		mp11 = _mp.n11; mp21 = _mp.n21; mp31 = _mp.n31; mp41 = _mp.n41;
		mp12 = _mp.n12; mp22 = _mp.n22; mp32 = _mp.n32; mp42 = _mp.n42;
		mp13 = _mp.n13; mp23 = _mp.n23; mp33 = _mp.n33; mp43 = _mp.n43;
		mp14 = _mp.n14; mp24 = _mp.n24; mp34 = _mp.n34; mp44 = _mp.n44;			
		
		changed = true;	
	}
			
	/**
	 * Updates the perspective projection.
	 */
	private function updatePerspective() : Void
	{
		setPerspectiveProjection( _nFov, viewport.ratio, _nNear, _nFar );
		_perspectiveChanged = false;
	}

	/**
	 * Delete the camera node and clear its displaylist.
	 *  
	 */
	public function destroy() : Void
	{
		viewport = null;
		// --
		super.destroy();
	}
 	
	public function toString() : String
	{
		return "sandy.core.scenegraph.Camera3D";
	}
			
	//////////////////////////
	/// PRIVATE PROPERTIES ///
	//////////////////////////
	private var _perspectiveChanged:Boolean = false;
	private var _mp:Matrix4; // projection Matrix4
	private var _mpInv:Matrix4; // Inverse of the projection matrix 
	private var _nFov:Number;
	private var _nFar:Number;
	private var _nNear:Number;
	private var mp11:Number, mp21:Number, mp31:Number, mp41:Number,
				mp12:Number, mp22:Number, mp32:Number, mp42:Number,
				mp13:Number, mp23:Number, mp33:Number, mp43:Number,
				mp14:Number, mp24:Number, mp34:Number, mp44:Number,				
				m_nOffx:Number, m_nOffy:Number;
				
}
