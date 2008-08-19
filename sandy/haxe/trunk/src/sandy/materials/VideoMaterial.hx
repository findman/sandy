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

package sandy.materials;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.media.Video;
import flash.utils.Timer;
import flash.geom.ColorTransform;

import sandy.core.Scene3D;
import sandy.core.data.Polygon;
import sandy.materials.attributes.MaterialAttributes;
import sandy.math.ColorMath;
import sandy.util.NumberUtil;

/**
 * Displays a Flash video ( FLV ) on the faces of a 3D shape.
 *
 * <p>Based on the AS2 class VideoSkin made by kiroukou and zeusprod</p>
 *
 * @author		Xavier Martin - zeflasher
 * @author		Thomas PFEIFFER - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 * 
 */
class VideoMaterial extends BitmapMaterial
{
	/**
	 * Default color used to draw the bitmapdata content with.
	 * In case you need a specific color, change  this value at your application initialization
	 */
	public static var DEFAULT_FILL_COLOR:UInt;

	private var m_oTimer:Timer;
	private var m_oVideo:Video;
	private var m_bUpdate:Bool;
	private var m_oAlpha:ColorTransform;

	/**
	 * Creates a new VideoMaterial.
	 *
	 * <p>The video is converted to a bitmap to give it a perspective distortion.<br/>
	 * To see the animation, the bitmap has to be recreated from the video on a regular basis.</p>
	 *
	 * @param p_oVideo 	The video to be shown by this material
	 * @param p_nUpdateMS	The update interval
	 * @param p_oAttr	The material attributes
	 */
	public function new( p_oVideo:Video, ?p_nUpdateMS:UInt, ?p_oAttr:MaterialAttributes )
	{
	 DEFAULT_FILL_COLOR = 0;

		if ( p_nUpdateMS == null ) p_nUpdateMS = 40;

		super( new BitmapData( Std.int( p_oVideo.width ), Std.int( p_oVideo.height ), true, DEFAULT_FILL_COLOR ), p_oAttr );
		m_oAlpha = new ColorTransform ();
		m_oVideo = p_oVideo;
		m_oType = MaterialType.VIDEO;
		// --
		m_oTimer = new Timer( p_nUpdateMS );
		m_oTimer.addEventListener(TimerEvent.TIMER, _update );
		start();
	}

	/**
	 * Renders this material on the face it dresses.
	 *
	 * @param p_oScene		The current scene
	 * @param p_oPolygon	The face to be rendered
	 * @param p_mcContainer	The container to draw on
	 */
	public override function renderPolygon ( p_oScene:Scene3D, p_oPolygon:Polygon, p_mcContainer:Sprite ) : Void
	{
		m_bUpdate = true;
		super.renderPolygon( p_oScene, p_oPolygon, p_mcContainer );
	}

	/**
	 * Changes the transparency of the texture.
	 *
	 * <p>The passed value is the percentage of opacity.</p>
	 *
	 * @param p_nValue 	A value between 0 and 1. (automatically constrained)
	 */
	public override function setTransparency( p_nValue:Float ):Void
	{
		m_oAlpha.alphaMultiplier = NumberUtil.constrain( p_nValue, 0, 1 );
	}


	/**
	 * Updates this material each internal timer cycle.
	 */
	private function _update( p_eEvent:TimerEvent ):Void
	{
		if ( m_bUpdate )
		{
			m_oTexture.fillRect( m_oTexture.rect,
				ColorMath.applyAlpha( DEFAULT_FILL_COLOR, m_oAlpha.alphaMultiplier) );
			// --
			m_oTexture.draw( m_oVideo, null, m_oAlpha, null, null, smooth );
		}
		m_bUpdate = false;
	}

	/**
	 * Call this method when you want to start the material update.
	 * This is automatically called at the material creation so basically it is used only when the VideoMaterial::stop() method has been called
	 */
	public function start():Void
	{
		m_oTimer.start();
	}

	/**
	 * Call this method is case you would like to stop the automatic video material graphics update.
	 */
	public function stop():Void
	{
		m_oTimer.stop();
	}
}

