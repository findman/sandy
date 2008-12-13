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

package sandy.core.scenegraph;

import flash.display.Sprite;
import flash.geom.Rectangle;

import sandy.core.Scene3D;
import sandy.core.data.Matrix4;
import sandy.core.data.Vertex;
import sandy.core.data.Polygon;
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
 * @author Niel Drummond - haXe port 
 * 
 */
class Camera3D extends ATransformable
{		
	/**
	 * <p>Inverse of the model matrix
	 * This is apply at the culling phasis
	 * The matrix is inverted in comparison of the real model view matrix.<br/>
	 * This allows replacement of the objects in the correct camera frame before projection</p>
	 */
	public var invModelMatrix:Matrix4;
	
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
	public function new( p_nWidth:Int, p_nHeight:Int, ?p_nFov:Float, ?p_nNear:Float, ?p_nFar:Float )
	{
		if (p_nFov == null) p_nFov = 45;
		if (p_nNear == null) p_nNear = 50;
		if (p_nFar == null) p_nFar = 10000;

		super( null );
	 invModelMatrix = new Matrix4();
		viewport = new ViewPort(640,480);
		frustrum = new Frustum();

		_perspectiveChanged = false;
		_mp = new Matrix4(); 
		_mpInv = new Matrix4(); 

		m_aDisplayList = new Array();

		viewport.width = p_nWidth;
		viewport.height = p_nHeight;
		// --			
		_nFov = p_nFov;
		_nFar = p_nFar;
		_nNear = p_nNear;
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
	public function __setFov( p_nFov:Float ):Float
	{
		_nFov = p_nFov;
		_perspectiveChanged = true;
		return p_nFov;
	}
	
	/**
	 * @private
	 */
	public var fov(__getFov, __setFov):Float;
	private function __getFov():Float
	{return _nFov;}
	
	/**
	 * Near plane distance for culling/clipping.
	 */
	public function __setNear( pNear:Float ):Float
	{_nNear = pNear; _perspectiveChanged = true; return pNear;}
	
	/**
	 * @private
	 */
	public var near(__getNear, __setNear):Float;
	private function __getNear():Float
	{return _nNear;}
			
	/**
	 * Far plane distance for culling/clipping.
	 */
	public function __setFar( pFar:Float ):Float
	{_nFar = pFar;_perspectiveChanged = true; return pFar;}
	
	/**
	 * @private
	 */
	public var far(__getFar, __setFar):Float;
	private function __getFar():Float
	{return _nFar;}

	///////////////////////////////////////
	//// GRAPHICAL ELEMENTS MANAGMENT /////
	///////////////////////////////////////
	/**
	 * Process the rendering of the scene.
	 * The camera has all the information needed about the objects to render.
	 * 
	 * The camera stores all the visible shape/polygons into an array, and loop through it calling their display method.
	 * Before the display call, the container graphics is cleared.
	 */
	public function renderDisplayList( p_oScene:Scene3D ):Void
	{

		var l_oShape:IDisplayable;
		// --
		if ( m_aDisplayedList != null ) 
		{
				for ( l_oShape in m_aDisplayedList )
				{
					l_oShape.clear();
				}
		}
	    // --
	    var l_mcContainer:Sprite = p_oScene.container;
	    // we go high quality for drawing part
	   	//l_mcContainer.stage.quality = StageQuality.HIGH;
	    // --
					
					/* we need to bypass visibility - untyped does not work on getters/setters */
#if flash
					untyped m_aDisplayList.sortOn( "m_nDepth", Array.NUMERIC | Array.DESCENDING );
#else
					m_aDisplayList.sort(function(a,b){return (a.depth>b.depth)?1:a.depth<b.depth?-1:0;} );
#end
					for ( l_oShape in m_aDisplayList )
					{
							l_oShape.display( p_oScene );
							l_mcContainer.addChild( l_oShape.container );
					}

		// -- back to low quality
		//l_mcContainer.stage.quality = StageQuality.LOW;
		// --
		m_aDisplayedList = m_aDisplayList.splice(0,m_aDisplayList.length);
	}

	/**
	 * Adds a displayable object to the display list.
	 *
	 * @param p_oShape	The object to add
	 */
	public function addToDisplayList( p_oShape:IDisplayable ):Void
	{
		if( p_oShape != null ) m_aDisplayList[m_aDisplayList.length] = ( p_oShape );
	}

       /**
        * Adds a displayable array of object to the display list.
        *
        * @param p_oShape  The object to add
        */
       public function addArrayToDisplayList( p_aShapeArray:Array<IDisplayable>  ):Void
       {
           m_aDisplayList = m_aDisplayList.concat( p_aShapeArray );
       }
       
	/**
	 * <p>Project the vertices list given in parameter.
	 * The vertices are projected to the screen, as a 2D position.
	 * </p>
	 */
	public function projectArray( p_oList:Array<Vertex> ):Void
	{
		var l_nX:Float = viewport.offset.x + m_nOffx;
		var l_nY:Float = viewport.offset.y + m_nOffy;
		var l_nCste:Float;
		var l_mp11_offx:Float = mp11 * m_nOffx;
		var l_mp22_offy:Float = mp22 * m_nOffy; 
		for ( l_oVertex in p_oList )
		{
			if( !l_oVertex.projected )
			{
				l_nCste = 1 / l_oVertex.wz;
				l_oVertex.sx =  l_nCste * l_oVertex.wx * l_mp11_offx + l_nX;
				l_oVertex.sy = -l_nCste * l_oVertex.wy * l_mp22_offy + l_nY; 
				//nbVertices += 1;
				l_oVertex.projected = true;
			}
		}
	}
			
	/**
	 * <p>Project the vertex passed as parameter.
	 * The vertices are projected to the screen, as a 2D position.
	 * </p>
	 */
	public function projectVertex( p_oVertex:Vertex ):Void
	{
		var l_nX:Float = (viewport.offset.x + m_nOffx);
		var l_nY:Float = (viewport.offset.y + m_nOffy);
		var l_nCste:Float = 1 / p_oVertex.wz;
		p_oVertex.sx =  l_nCste * p_oVertex.wx * mp11 * m_nOffx + l_nX;
		p_oVertex.sy = -l_nCste * p_oVertex.wy * mp22 * m_nOffy + l_nY;
	}
	
	/**
	 * Nothing is done here - the camera is not rendered
	 */
	public override function render( p_oScene:Scene3D, p_oCamera:Camera3D):Void
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
	public override function update( p_oScene:Scene3D, p_oModelMatrix:Matrix4, p_bChanged:Bool ):Void
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
	
	/**
	 * Nothing to do - the camera can't be culled
	 */
	public override function cull( p_oScene:Scene3D, p_oFrustum:Frustum, p_oViewMatrix:Matrix4, p_bChanged:Bool ):Void
	{
		return;
	}
	
	/**
	* Returns the projection matrix of this camera. 
	* 
	* @return 	The projection matrix
	*/
	public var projectionMatrix(__getProjectionMatrix,null):Matrix4;
	private function __getProjectionMatrix():Matrix4
	{
		return _mp;
	}
	
	/**
	 * Returns the inverse of the projection matrix of this camera.
	 *
	 * @return 	The inverted projection matrix
	 */
	public var invProjectionMatrix(__getInvProjectionMatrix,null):Matrix4;
	private function __getInvProjectionMatrix():Matrix4
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
	* @param p_nAspectRatio The ratio between vertical and horizontal dimension - Default the viewport ratio (width/height)
	* @param p_nZNear 	The distance betweeen the camera and the near plane - Default 10.
	* @param p_nZFar 	The distance betweeen the camera position and the far plane. Default 10 000.
	*/
	private function setPerspectiveProjection(p_nFovY:Float, p_nAspectRatio:Float, p_nZNear:Float, p_nZFar:Float):Void
	{
		var cotan:Float, Q:Float;
		// --
		frustrum.computePlanes(p_nAspectRatio, p_nZNear, p_nZFar, p_nFovY );
		// --
		p_nFovY = NumberUtil.toRadian( p_nFovY );
		cotan = 1 / Math.tan(p_nFovY / 2);
		Q = p_nZFar/(p_nZFar - p_nZNear);
		
		_mp.zero();

		_mp.n11 = cotan / p_nAspectRatio;
		_mp.n22 = cotan;
		_mp.n33 = Q;
		_mp.n34 = -Q*p_nZNear;
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
	private function updatePerspective():Void
	{
		setPerspectiveProjection( _nFov, viewport.ratio, _nNear, _nFar );
		_perspectiveChanged = false;
	}


	/**
	 * Delete the camera node and clear its displaylist.
	 *  
	 */
	public override function destroy():Void
	{
		var l_oShape:IDisplayable;
		// --
		for ( l_oShape in m_aDisplayedList )
		{
			if( l_oShape != null ) l_oShape.clear();
		}
		
		for ( l_oShape in m_aDisplayList )
		{
			if( l_oShape != null ) l_oShape.clear();
		}
		// --
		m_aDisplayedList = null;
		m_aDisplayList = null;
		viewport = null;
		// --
		super.destroy();
	}
	
	public override function toString():String
	{
		return "sandy.core.scenegraph.Camera3D";
	}
		
	//////////////////////////
	/// PRIVATE PROPERTIES ///
	//////////////////////////
	private var _perspectiveChanged:Bool;
	private var _mp:Matrix4;
	private var _mpInv:Matrix4;

	private var m_aDisplayList:Array<IDisplayable>;
	private var m_aDisplayedList:Array<IDisplayable>;
	
	private var _nFov:Float;
	private var _nFar:Float;
	private var _nNear:Float;
	
	private var mp11:Float;
 private var mp21:Float;
 private var mp31:Float;
	private var mp41:Float;
	private var mp12:Float;
	private var mp22:Float;
	private var mp32:Float;
	private var mp42:Float;
	private var mp13:Float;
	private var mp23:Float;
	private var mp33:Float;
	private var mp43:Float;
	private var mp14:Float;
	private var mp24:Float;
	private var mp34:Float;
	private var mp44:Float;
	private var m_nOffx:Float;
	private var m_nOffy:Float;
}

