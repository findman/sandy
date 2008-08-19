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

import flash.display.AVM1Movie;
import flash.display.ActionScriptVersion;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BitmapDataChannel;
import flash.display.BlendMode;
import flash.display.CapsStyle;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.FrameLabel;
import flash.display.GradientType;
import flash.display.Graphics;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsEndFill;
import flash.display.GraphicsGradientFill;
import flash.display.GraphicsPath;
import flash.display.GraphicsPathCommand;
import flash.display.GraphicsPathWinding;
import flash.display.GraphicsShaderFill;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.GraphicsTrianglePath;
import flash.display.IBitmapDrawable;
import flash.display.IGraphicsData;
import flash.display.IGraphicsFill;
import flash.display.IGraphicsPath;
import flash.display.IGraphicsStroke;
import flash.display.InteractiveObject;
import flash.display.InterpolationMethod;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.MorphShape;
import flash.display.MovieClip;
import flash.display.PixelSnapping;
import flash.display.SWFVersion;
import flash.display.Scene;
import flash.display.Shader;
import flash.display.ShaderData;
import flash.display.ShaderInput;
import flash.display.ShaderJob;
import flash.display.ShaderParameter;
import flash.display.ShaderParameterType;
import flash.display.ShaderPrecision;
import flash.display.Shape;
import flash.display.SimpleButton;
import flash.display.SpreadMethod;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.display.TriangleCulling;

import flash.events.Event;
import flash.events.TimerEvent;
import flash.geom.ColorTransform;
import flash.geom.Rectangle;
import flash.utils.Timer;

import sandy.core.Scene3D;
import sandy.core.data.Polygon;
import sandy.materials.attributes.MaterialAttributes;
import sandy.math.ColorMath;
import sandy.util.NumberUtil;

/**
 * Displays a MovieClip on the faces of a 3D shape.
 *
 * <p>Based on the AS2 class VideoSkin made by kiroukou and zeusprod</p>
 *
 * @author		Xavier Martin - zeflasher
 * @author		Thomas PFEIFFER - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 * 				this should be add directly in the bitmap material I reckon
 * 
 */
class MovieMaterial extends BitmapMaterial
{
	/**
	 * Default color used to draw the bitmapdata content with.
	 * In case you need a specific color, change  this value at your application initialization
	 */
	public static var DEFAULT_FILL_COLOR:Int = 0;

	private var m_oTimer:Timer;
	private var m_oMovie:Sprite;
	private var m_bUpdate:Bool;
	private var m_oAlpha:ColorTransform;

	/**
	 * Creates a new MovieMaterial.
	 *
	 * <p>The MovieClip used for the material may contain animation.<br/>
	 * It is converted to a bitmap to give it a perspective distortion.<br/>
	 * To see the animation the bitmap has to be recreated from the MovieClip on a regular basis.</p>
	 *
	 * @param p_oMovie 	The Movieclip to be shown by this material
	 * @param p_nUpdateMS	The update interval
	 * @param p_oAttr	The material attributes
	 * @param p_bRemoveTransparentBorder	Remove the transparent border
	 * @param p_nWidth	desired width ( chunk the movieclip )
	 * @param p_nHeight	desired height ( chunk the movieclip )
	 */
	public function new( p_oMovie:Sprite, ?p_nUpdateMS:Null<Int>, ?p_oAttr:MaterialAttributes, ?p_bRemoveTransparentBorder:Null<Bool>, ?p_nHeight:Null<Float>, ?p_nWidth:Null<Float> )
	{
		var w : Null<Float>;
		var h : Null<Float>;

		if ( p_nUpdateMS == null ) p_nUpdateMS = 40;
		if ( p_bRemoveTransparentBorder == null ) p_bRemoveTransparentBorder = false;
		if ( p_nHeight == null ) p_nHeight = 0;
		if ( p_nWidth == null ) p_nWidth = 0;

		m_oAlpha = new ColorTransform ();

		var tmpBmp : BitmapData = null;
		var rect : Rectangle;
		if ( p_bRemoveTransparentBorder )
		{
			tmpBmp = new BitmapData(  Std.int(p_oMovie.width), Std.int(p_oMovie.height), true, 0 );
			tmpBmp.draw( p_oMovie );
			rect = tmpBmp.getColorBoundsRect( 0xFF000000, 0x00000000, false );
			w = rect.width;
			h = rect.height;
		}
		else
		{
			w = p_nWidth != 0 ? p_nWidth :  p_oMovie.width;
			h = p_nHeight != 0 ? p_nHeight : p_oMovie.height;
		}

		super( new BitmapData( Std.int(w), Std.int(h), true, DEFAULT_FILL_COLOR), p_oAttr );
		m_oMovie = p_oMovie;
		m_oType = MaterialType.MOVIE;
		// --
		m_bUpdate = true;
		m_oTimer = new Timer( p_nUpdateMS );
		m_oTimer.addEventListener(TimerEvent.TIMER, _update );
		m_oTimer.start();

		if( tmpBmp != null ) 
		{
			tmpBmp.dispose();tmpBmp = null;
		}
		rect = null;
		w = null;
		h = null;
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
	private function _update( p_eEvent:Event ):Void
	{
		if ( m_bUpdate )
		{
			m_oTexture.fillRect( m_oTexture.rect,
				ColorMath.applyAlpha( DEFAULT_FILL_COLOR, m_oAlpha.alphaMultiplier) );
			// --
			m_oTexture.draw( m_oMovie, null, m_oAlpha, null, null, smooth );
		}
		m_bUpdate = false;
	}

	/**
	 * Call this method when you want to start the material update.
	 * This is automatically called at the material creation so basically it is used only when the MovieMaterial::stop() method has been called
	 */
	public function start():Void
	{
		m_oTimer.start();
	}

	/**
	 * Call this method is case you would like to stop the automatic MovieMaterial texture update.
	 */
	public function stop():Void
	{
		m_oTimer.stop();
	}

	/**
	 * Get the movieclip used for the material
	 */
	public var movie(__getMovie,null) : Sprite;
	private function __getMovie() : Sprite
	{
		return m_oMovie;
	}
}

