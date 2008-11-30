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
import flash.display.IBitmapDrawable;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.BlendMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Matrix;

import sandy.bounds.BSphere;
import sandy.core.Scene3D;
import sandy.core.data.Matrix4;
import sandy.core.data.Vertex;
import sandy.events.StarFieldRenderEvent;
import sandy.materials.Material;
import sandy.view.CullingState;
import sandy.view.Frustum;

/**
 * The StarField class renders dense star field at reasonable FPS.
 *
 * @author		makc
 * @author		pedromoraes - haXe port 
 * @author		Niel Drummond - tweaks
 * @version		3.0.3
 * @date 		03.03.2008
 */
class StarField extends ATransformable, implements IDisplayable
{
	/**
	 * Distance from screen where stars start to fade out
	 */
	public var fadeFrom:Float;

	/**
	 * Distance from fadeFrom to the point where stars fade out completely
	 */
	public var fadeTo:Float;

	/**
	 * Array of Vertex - star coordinates data.
	 */
	public var stars:Array<Vertex>;
	
	/**
	 * Array of star colors (if not specified, white is used).
	 */
#if js
	public var starColors:Array<Int>;
#else
	public var starColors:Array<UInt>;
#end

	/**
	 * Array of star sprites (any IBitmapDrawable-s; if not specified, StarField uses setPixel to draw a star).
	 *
	 * <p>Star sprites are affected by corresponding starColors value; for DisplayObject-s, StarField will use
	 * their blendMode to draw them.</p>
	 */
	public var starSprites:Array<IBitmapDrawable>;

	/**
	 * Creates a StarField.
	 *
	 * @param p_sName	A string identifier for this object
	 */	
	public function new( ?p_sName:String = '' ) : Void
	{
		super(p_sName);
		// create something
		fadeFrom = 0;
		fadeTo = 1000;
		stars = [];
		starColors = [];
		starSprites = [];
		depthIndex = -1;
		m_nDepth = 1e10;
		m_oDrawMatrix = new Matrix();

		m_oColorTransform = new ColorTransform();
		m_oContainer = new Sprite ();
		m_oBitmapData = new BitmapData (1, 1, true, 0); makeEvents ();
		m_oBitmap = new Bitmap (m_oBitmapData);
		m_oContainer.addChild (m_oBitmap);
		_vx = new Vertex(); _vy = new Vertex();
	}

	public var container(__getContainer,null):Sprite;
	/**
	 * The container of this object
	 */
	public function __getContainer():Sprite
	{
		return m_oContainer;
	}


	/**
	 * An index in stars array; if set to valid value, depth returns distance to that star.
	 */
	public var depthIndex:Int;

	public var depth(__getDepth, __setDepth):Float;
	/**
	 * The depth to draw the starfield at. If depthIndex is set to valid value,
	 * depth returns distance to that star, otherwise value set by user (default: 1e10).
	 */
	public function __getDepth ():Float
	{
		var v:Vertex = stars[depthIndex];
		if (v != null)
			return v.wz;

		return m_nDepth;
	}

	/**
	 * @private
	 */
	public function __setDepth (p_nDepth:Float):Float
	{
		return m_nDepth = p_nDepth;
	}
	  
	/**
	 * This tests for stars visibility.
	 *
	 * @param p_oScene The current scene
	 * @param p_oFrustum	The frustum of the current camera
	 * @param p_oViewMatrix	The view martix of the curren camera
	 * @param p_bChanged
	 */
	public override function cull( p_oScene:Scene3D, p_oFrustum:Frustum, p_oViewMatrix:Matrix4, p_bChanged:Bool ):Void
	{
		//super.cull( p_oScene, p_oFrustum, p_oViewMatrix, p_bChanged );
		if( visible == false )
		{
			culled = CullingState.OUTSIDE;
		}
		else
		{
			if( p_bChanged || changed )
			{
				viewMatrix.copy( p_oViewMatrix );
				viewMatrix.multiply4x3( modelMatrix );
			}
		}
		// check if we need to resize our canvas
		if ((m_oBitmapData.width  != p_oScene.camera.viewport.width)
		 || (m_oBitmapData.height != p_oScene.camera.viewport.height))
		{
			m_oBitmap.bitmapData.dispose ();
			m_oBitmapData = new BitmapData (p_oScene.camera.viewport.width,
				p_oScene.camera.viewport.height, true, 0); makeEvents ();
			m_oBitmap.bitmapData = m_oBitmapData;
		}
	}
	var n:Bool;
	/**
	 * Renders the starfield
	 *
	 * @param p_oScene The current scene
	 * @param p_oCamera	The current camera
	 */
	public override function render( p_oScene:Scene3D, p_oCamera:Camera3D ):Void
	{
		resetEvents ();
		m_oBitmapData.lock();
		m_oEB.broadcastEvent (m_oEventBefore);
		if (m_oEventBefore.clear) m_oBitmapData.fillRect (m_oBitmapData.rect, 0);
		// --
#if js
		var c32:Int, a:Float, c:Int, r:Float, rgb_r:Float, rgb_g:Float, rgb_b:Float, bY:Float;
#else
		var c32:UInt, a:Float, c:UInt, r:Float, rgb_r:Float, rgb_g:Float, rgb_b:Float, bY:Float;
#end
		for (i in 0 ... stars.length)
		{
			var _v:Vertex = stars [i];
			_v.wx = _v.x * viewMatrix.n11 + _v.y * viewMatrix.n12 + _v.z * viewMatrix.n13 + viewMatrix.n14;
			_v.wy = _v.x * viewMatrix.n21 + _v.y * viewMatrix.n22 + _v.z * viewMatrix.n23 + viewMatrix.n24;
			_v.wz = _v.x * viewMatrix.n31 + _v.y * viewMatrix.n32 + _v.z * viewMatrix.n33 + viewMatrix.n34;

			if (_v.wz >= p_oScene.camera.near)
			{
				r = Math.min(1, Math.max (0, (_v.wz - fadeFrom) / fadeTo));
				if (r < 1)
				{
					// will uint and bit shift really make a difference?
					c32 = (i < starColors.length) ? starColors [i] : 0xFFFFFFFF;
					a = Std.int(c32 / 0x1000000 * (1 - r)); c = c32 & 0xFFFFFF;
					p_oCamera.projectVertex (_v);
					if ((i < starSprites.length /* avoid array access */) && (Std.is( starSprites [i], IBitmapDrawable)))
					{
						_vx.copy (_v); _vx.wx++; p_oCamera.projectVertex (_vx);
						_vy.copy (_v); _vy.wy++; p_oCamera.projectVertex (_vy);
						m_oDrawMatrix.tx = _v.sx; m_oDrawMatrix.a = (_vx.sx - _v.sx);
						m_oDrawMatrix.ty = _v.sy; m_oDrawMatrix.d = (_v.sy - _vy.sy);

						if (c != 0xFFFFFF)
						{
							rgb_r = (0xFF0000 & c) >> 16;
							rgb_g = (0x00FF00 & c) >> 8;
							rgb_b = (0x0000FF & c);
							bY = /* a * */ 1.7321 /*Math.sqrt (3)*/ / Math.sqrt (rgb_r * rgb_r + rgb_g * rgb_g + rgb_b * rgb_b);
							rgb_r *= bY; rgb_g *= bY; rgb_b *= bY;
						}
						else
						{
							rgb_r = rgb_g = rgb_b = 1;
						}

						m_oColorTransform.redMultiplier = rgb_r;
						m_oColorTransform.greenMultiplier = rgb_g;
						m_oColorTransform.blueMultiplier = rgb_b;

						// TODO think about support for fade-to-black along with fade-to-transparent?
						m_oColorTransform.alphaMultiplier = a / 255.0;

						var star : IBitmapDrawable = starSprites [i];
						if ( Std.is( star, DisplayObject ) )
						{
							m_sBlendMode = untyped star.blendMode;
						}
						else
						{
							m_sBlendMode = BlendMode.NORMAL;
						}

						//suggest the following to makc:
						//if ( m_oBitmapData.rect.contains( m_oDrawMatrix.tx, m_oDrawMatrix.ty ) )
						m_oBitmapData.draw( star, m_oDrawMatrix, m_oColorTransform, m_sBlendMode );
					}
					else
					{
						m_oBitmapData.setPixel32(Std.int(_v.sx), Std.int(_v.sy), c + Std.int (a) * 0x1000000);
					}
				}
			}
		}
		m_oEB.broadcastEvent (m_oEventAfter);
		if (m_oEventAfter.clear) m_oBitmapData.fillRect (m_oBitmapData.rect, 0);
		m_oBitmapData.unlock();

		p_oCamera.addToDisplayList (this);
	}

	/**
	 * Clearing is done in render() method.
	 */	
	public function clear():Void
	{
		
	}

	/**
	 * Provide the classical remove behaviour, plus remove the container to the display list.
	 */
	public override function remove():Void
	{
		m_oBitmap.bitmapData.dispose ();
		if( m_oContainer.parent != null )
			m_oContainer.parent.removeChild( m_oContainer );
		super.remove();
	}

	/**
	 * @inheritDoc
	 */
	public override function destroy():Void
	{
		remove (); super.destroy ();
	}
	
	/**
	 * Displays the starfield.
	 *
	 * @param p_oScene The current scene
	 * @param p_oContainer	The container to draw on
	 */
	public function display( p_oScene:Scene3D, p_oContainer:Sprite = null  ):Void
	{
		// viewport upper left?
		m_oContainer.x = 0;
		m_oContainer.y = 0;
	}

	private var m_oDrawMatrix:Matrix;
	private var m_nDepth:Float;
	private var m_oContainer:Sprite;
	private var m_oBitmap:Bitmap;
	private var m_oBitmapData:BitmapData;
	private var m_oColorTransform:ColorTransform;
	private var m_sBlendMode:BlendMode;
	private var _vx:Vertex;
	private var _vy:Vertex;
	private var m_oEventBefore:StarFieldRenderEvent;
	private var m_oEventAfter:StarFieldRenderEvent;

	private function makeEvents ():Void
	{
		m_oEventBefore = new StarFieldRenderEvent (StarFieldRenderEvent.BEFORE_RENDER, this, m_oBitmapData, true);
		m_oEventAfter  = new StarFieldRenderEvent (StarFieldRenderEvent.AFTER_RENDER,  this, m_oBitmapData, false);
	}

	private function resetEvents ():Void
	{
		// reset whatever could have been changed by listener
		m_oEventBefore.clear = true;
		m_oEventAfter.clear = false;
	}
}
