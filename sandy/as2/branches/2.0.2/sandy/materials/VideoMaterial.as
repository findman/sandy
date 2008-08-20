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

import flash.display.BitmapData;
import flash.geom.ColorTransform;

import sandy.core.Scene3D;
import sandy.core.data.Polygon;
import sandy.events.Timer;
import sandy.events.TimerEvent;
import sandy.materials.BitmapMaterial;
import sandy.materials.MaterialType;
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
 * @author		(porting) Floris - FFlasher
 * @since		1.0
 * @version		2.0.2
 * @date 		26.06.2007
 */
 
class sandy.materials.VideoMaterial extends BitmapMaterial
{
	
	/**
	 * Default color used to draw the bitmapdata content.
	 * In case you need a specific color, change this value at your application initialization.
	 */
	public static var DEFAULT_FILL_COLOR:Number = 0;

	private var m_oTimer:Number;
	private var m_bRunning:Boolean;
	private var m_nUpdate:Number;
	private var m_oVideo:Video;
	private var m_bUpdate:Boolean;
	private var m_oAlpha:ColorTransform;

	/**
	 * Creates a new VideoMaterial.
	 *
	 * <p>The video is converted to a bitmap to give it a perspective distortion.<br/>
	 * To see the animation, the bitmap has to be recreated from the video on a regular basis.</p>
	 *
	 * @param p_oVideo		The video to be shown by this material.
	 * @param p_nUpdateMS	The update interval.
	 * @param p_oAttr		The material attributes.
	 *
	 * @see sandy.materials.attributes.MaterialAttributes
	 */
	public function VideoMaterial( p_oVideo:Video, p_nUpdate:Number, p_oAttr:MaterialAttributes )
	{
		super( new BitmapData( p_oVideo._width, p_oVideo._height, true, DEFAULT_FILL_COLOR ), p_oAttr );
		m_oAlpha = new ColorTransform ();
		m_oVideo = p_oVideo;
		m_oType = MaterialType.VIDEO;
		// --
		m_nUpdate = p_nUpdate||40;
		m_bRunning = true;
		m_oTimer = setInterval( this, "_update", m_nUpdate );
	}

	/**
	 * @private
	 */
	public function renderPolygon ( p_oScene:Scene3D, p_oPolygon:Polygon, p_mcContainer:MovieClip ) : Void
	{
		m_bUpdate = true;
		super.renderPolygon( p_oScene, p_oPolygon, p_mcContainer );
	}

	/**
	 * @private
	 */
	public function setTransparency( p_nValue:Number ) : Void
	{
		m_oAlpha.alphaMultiplier = NumberUtil.constrain( p_nValue, 0, 1 );
	}

	/**
	 * Updates this material each internal timer cycle.
	 */
	private function _update( p_eEvent:TimerEvent ) : Void
	{
		if ( m_bUpdate || forceUpdate )
		{
			m_oTexture.fillRect( m_oTexture.rectangle,
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
	public function start() : Void
	{
		if( !m_bRunning ) clearInterval( m_oTimer ); m_oTimer = setInterval( this, "_update", m_nUpdate );  m_bRunning = true;
	}

	/**
	 * Call this method is case you would like to stop the automatic video material graphics update.
	 */
	public function stop() : Void
	{
		clearInterval( m_oTimer );
		m_bRunning = false;
	}
	
}