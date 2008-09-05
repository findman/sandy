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

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import sandy.bounds.BSphere;
import sandy.core.Scene3D;
import sandy.core.data.Matrix4;
import sandy.core.data.Vector;
import sandy.core.data.Vertex;
import sandy.events.BubbleEvent;
import sandy.math.VectorMath;
import sandy.util.NumberUtil;
import sandy.view.CullingState;
import sandy.view.Frustum;

/**
 * The Sprite3D class is used to create a 3D sprite.
 *
 * <p>A Sprite3D can be seen as a special Sprite2D.<br/>
 * It has an appearance that is a movie clip containing 360 frames (as maximum!) with texture.</p>
 *
 * <p>Depending on the camera position, a different frame of the clip is shown, givin a 3D effect.<p/>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 **/
class Sprite3D extends Sprite2D
{
	// FIXME Create a Sprite as the spriteD container,
	// and offer a method to attach a visual content as a child of the sprite
	public var offset:Int;
	
	// Reference to sprite2D
	private var m_oSuper:Sprite2D;
	 /**
 	 * Creates a Sprite3D
	 *
	 * @param p_sName 	A string identifier for this object
	 * @param p_oContent	The Movieclip containing the pre-rendered textures
	 * @param p_nScale 	A number used to change the scale of the displayed object.
	 * 			In case that the object projected dimension
	 *			isn't adapted to your needs.
	 *			Default value is 1.0 which means unchanged.
	 * 			A value of 2.0 will make the object will double the size
	 *
	 * @param p_nOffset 	A number between [0-360] to give a frame offset into the clip.
	 */
	public function new( ?p_sName:String, ?p_oContent:DisplayObject, ?p_nScale:Float, ?p_nOffset:Int )
	{
	 offset = 0;

		if ( p_sName == null ) p_sName = "";
		if ( p_nScale == null ) p_nScale = 1;
		if ( p_nOffset == null ) p_nOffset = 0;

	 m_oNormale = new Vector();

		super(p_sName, p_oContent, p_nScale);

		// --
		_dir = new Vertex( 0, 0, -1 );
		_vView = new Vector( 0, 0, 1 );
		// -- set the offset
		offset = p_nOffset;
	}

	/**
	 * The MovieClip that will used as content of this Sprite2D. 
	 * If this MovieClip has already a scree position, it will be reseted to 0,0.
	 * 
	 * @param p_content The MovieClip to attach to the Sprite3D#container. 
	 */
	override public var content( null,__setContent ):DisplayObject;
	override private function __setContent( p_content:DisplayObject ):DisplayObject
	{
		if (p_content != null)
		{
			//super.content = p_content;

			p_content.transform.matrix.identity();
			if( m_oContent != null ) m_oContainer.removeChild( m_oContent );
			m_oContent = p_content;
			m_oContainer.addChildAt( m_oContent, 0 );
			m_oContent.x = 0;
			m_oContent.y = 0;
			m_nW2 = m_oContainer.width / 2;
			m_nH2 = m_oContainer.height / 2;

			// --
			m_nAutoOffset = untyped m_oContent.totalFrames / 360;
		}
		return p_content;
	}

	/**
	 * Renders this 3D sprite
	 *
	 * @param p_oScene The current scene
	 * @param p_oCamera	The current camera
	 */
	override public function render( p_oScene:Scene3D, p_oCamera:Camera3D ):Void
	{
		if ((m_oMaterial != null) && !p_oScene.materialManager.isRegistered( m_oMaterial ))
		{
			p_oScene.materialManager.register( m_oMaterial );
		}

		var l_oMatrix:Matrix4 = viewMatrix,
			m11:Float = l_oMatrix.n11, m21:Float = l_oMatrix.n21, m31:Float = l_oMatrix.n31,
			m12:Float = l_oMatrix.n12, m22:Float = l_oMatrix.n22, m32:Float = l_oMatrix.n32,
			m13:Float = l_oMatrix.n13, m23:Float = l_oMatrix.n23, m33:Float = l_oMatrix.n33,
			m14:Float = l_oMatrix.n14, m24:Float = l_oMatrix.n24, m34:Float = l_oMatrix.n34;

		_dir.wx = _dir.x * m11 + _dir.y * m12 + _dir.z * m13 + m14;
		_dir.wy = _dir.x * m21 + _dir.y * m22 + _dir.z * m23 + m24;
		_dir.wz = _dir.x * m31 + _dir.y * m32 + _dir.z * m33 + m34;

		_v.wx = _v.x * m11 + _v.y * m12 + _v.z * m13 + m14;
		_v.wy = _v.x * m21 + _v.y * m22 + _v.z * m23 + m24;
		_v.wz = _v.x * m31 + _v.y * m32 + _v.z * m33 + m34;

		m_nDepth = enableForcedDepth ? forcedDepth : _v.wz;
		// --
		p_oCamera.projectVertex( _v );
		p_oCamera.addToDisplayList( this );
		
		_vx.copy (_v); _vx.wx++; p_oCamera.projectVertex (_vx);
		_vy.copy (_v); _vy.wy++; p_oCamera.projectVertex (_vy);

		m_nPerspScaleX = _nScale * (_vx.sx - _v.sx);
		m_nPerspScaleY = _nScale * (_v.sy - _vy.sy);

		m_nRotation = Math.atan2( m12, m22 );
		// -- We push the vertex to project onto the viewport.
	        m_oNormale.x = _v.wx - _dir.wx;
	        m_oNormale.y = _v.wy - _dir.wy;
        	m_oNormale.z = _v.wz - _dir.wz;
		m_nAngle = VectorMath.getAngle( _vView, m_oNormale );
		if( m_oNormale.x < 0 ) m_nAngle = 2*Math.PI - m_nAngle;

			// FIXME problem around 180 frame. A big jump occurs. Problem of precision ?
			untyped m_oContent.gotoAndStop( __frameFromAngle( m_nAngle ) );
	}

	// Returns the frame to show at the current camera angle
	private function __frameFromAngle(a:Float):Int
	{
		a = NumberUtil.toDegree( a );
		a = (( a + offset )+360) % 360;
		// -- we have a frame for a 360 content, let's make it fit the current one
		var b:Int = Std.int( a * m_nAutoOffset ) << 0;
		return b;
	}

	// -- frames offset
	private var _vView:Vector;
	private var _dir:Vertex;
	private var m_oNormale:Vector;
	private var m_nAutoOffset:Float;
	private var m_nAngle:Float;
}

