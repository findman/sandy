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

import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;
	
import sandy.bounds.BSphere;
import sandy.core.Scene3D;
import sandy.core.data.Matrix4;
import sandy.core.data.Vector;
import sandy.core.data.Vertex;
import sandy.core.scenegraph.Sprite2D;
import sandy.core.scenegraph.Camera3D;
import sandy.events.MouseEvent;
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
 * @author		(porting) Floris - FFlasher
 * @version		2.0.2
 * @date 		20.05.2006
 */
 
class sandy.core.scenegraph.Sprite3D extends Sprite2D
{
	
	// FIXME Create a Sprite as the sprite3D container,
	// and offer a method to attach a visual content as a child of the sprite
	public var offset:Number = 0;
	
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
	public function Sprite3D( p_sName:String, p_oContent:MovieClip, p_nScale:Number, p_nOffset:Number )
	{
		super( p_sName||"", p_oContent, p_nScale||1 );
		// --
		m_oNormale = new Vector();
		// -- set the offset
		offset = p_nOffset||0;
	}

	/**
	 * The MovieClip that will used as content of this Sprite2D. 
	 * If this MovieClip has already a screen position, it will be reseted to 0,0.
	 * 
	 * @param p_content The MovieClip to attach to the Sprite3D#container. 
	 */
	public function set content( p_content:MovieClip ) : Void
	{
		if ( p_content instanceof MovieClip )
		{
			super.content = p_content;
			// --
			m_nAutoOffset = MovieClip( m_oContent )._totalframes / 360;
		}
	}

	/**
	 * Renders this 3D sprite
	 *
	 * @param p_oScene The current scene
	 * @param p_oCamera	The current camera
	 */
	public function render( p_oScene:Scene3D, p_oCamera:Camera3D ) : Void
	{
		super.render( p_oScene, p_oCamera );
		// --
		MovieClip( m_oContent ).gotoAndStop( __frameFromAngle( Math.atan2( viewMatrix.n13, viewMatrix.n33 ) ) );
	}

	// Returns the frame to show at the current camera angle
	private function __frameFromAngle( a:Number ) : Number
	{
		// to degree
		a *= 57.295779513082321; // *= 180 / Math.PI
		// correction to simply use uint ()
		a += 0.5 / m_nAutoOffset;
		// force 0...360 range
		a = (( a + offset ) + 360 ) % 360;
		// convert corrected angle to frame number
		return 1 + int( a * m_nAutoOffset );
	}

	// -- frames offset
	private var m_oNormale:Vector;
	private var m_nAutoOffset:Number;
	
}