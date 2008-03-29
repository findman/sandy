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
	 * @version		1.0
	 * @date 		20.05.2006
	 **/
	public class Sprite3D extends Sprite2D
	{
		// FIXME Create a Sprite as the spriteD container,
		// and offer a method to attach a visual content as a child of the sprite
		public var offset:uint = 0;
		
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
		 * @param p_nOffset 	A number between [0-360] to give angle offset into the clip.
		 */
		public function Sprite3D( p_sName:String = "", p_oContent:MovieClip = null, p_nScale:Number=1, p_nOffset:Number=0 )
		{
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
		override public function set content( p_content:DisplayObject ):void
		{
			if (p_content as MovieClip)
			{
				super.content = p_content;
				// --
				m_nAutoOffset = (m_oContent as MovieClip).totalFrames / 360;
			}
		}

		/**
		 * Renders this 3D sprite
		 *
		 * @param p_oScene The current scene
		 * @param p_oCamera	The current camera
		 */
		override public function render( p_oScene:Scene3D, p_oCamera:Camera3D ):void
		{
			if ((m_oMaterial != null) && !p_oScene.materialManager.isRegistered( m_oMaterial ))
			{
				p_oScene.materialManager.register( m_oMaterial );
			}

			const l_oMatrix:Matrix4 = viewMatrix,
				m11:Number = l_oMatrix.n11, m21:Number = l_oMatrix.n21, m31:Number = l_oMatrix.n31,
				m12:Number = l_oMatrix.n12, m22:Number = l_oMatrix.n22, m32:Number = l_oMatrix.n32,
				m13:Number = l_oMatrix.n13, m23:Number = l_oMatrix.n23, m33:Number = l_oMatrix.n33,
				m14:Number = l_oMatrix.n14, m24:Number = l_oMatrix.n24, m34:Number = l_oMatrix.n34;

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
			(m_oContent as MovieClip).gotoAndStop( __frameFromAngle( m_nAngle ) );
		}

		// Returns the frame to show at the current camera angle
		private function __frameFromAngle(a:Number):uint
		{
			// to degree
			a *= 57.295779513082321; // *= 180 / Math.PI
			// correction to simply use uint ()
			a += 0.5 / m_nAutoOffset;
			// force 0...360 range
			a = (( a + offset )+360) % 360;
			// convert corrected angle to frame number
			return 1 + uint (a * m_nAutoOffset);
		}

		// -- frames offset
		private var _vView:Vector;
		private var _dir:Vertex;
		private var m_oNormale:Vector = new Vector();
		private var m_nAutoOffset:Number;
		private var m_nAngle:Number;
	}
}