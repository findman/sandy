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
			super.render ( p_oScene, p_oCamera );
			// --
			(m_oContent as MovieClip).gotoAndStop( __frameFromAngle( Math.atan2( viewMatrix.n13, viewMatrix.n33 ) ) );
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
		private var m_oNormale:Vector = new Vector();
		private var m_nAutoOffset:Number;
	}
}