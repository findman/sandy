﻿/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author Thomas PFEIFFER
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

package sandy.materials.attributes;

import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.filters.BlurFilter;
import flash.geom.ColorTransform;
import flash.geom.Matrix;

import sandy.core.Scene3D;
import sandy.core.data.Polygon;
import sandy.core.data.Vector;
import sandy.core.data.Vertex;
import sandy.core.scenegraph.Shape3D;
import sandy.core.scenegraph.Sprite2D;
import sandy.materials.Material;
import sandy.math.ColorMath;
import sandy.math.VertexMath;

/**
 * This attribute provides very basic simulation of partially opaque medium.
 * You can use this attribute to achieve wide range of effects (e.g., fog, Rayleigh scattering, light attached to camera, etc).
 * 
 * @author		makc
 * @author Niel Drummond - haXe port 
 * 
 * 
 */
class MediumAttributes extends AAttributes
{
	/**
	 * Medium color (32-bit value) at the point given by fadeFrom + fadeTo.
	 * If this value is transparent, color gradient will be extrapolated beyond that point.
	 */
	private function __setColor (p_nColor:UInt):UInt
	{
		_c = p_nColor & 0xFFFFFF;
		_a = (p_nColor - _c) / 0x1000000 / 255.0;
        return p_nColor;
	}
	
	/**
	 * @private
	 */
	public var color (__getColor,__setColor):UInt;
	private function __getColor ():UInt
	{
		return _c + Math.floor (0xFF * _a) * 0x1000000;
	}

	/**
	 * Attenuation vector. This is the vector from transparent point to opaque point.
	 */
	private function __setFadeTo (p_oW:Vector):Vector
	{
		_fadeTo = p_oW;
		_fadeToN2 = p_oW.getNorm (); _fadeToN2 *= _fadeToN2;
        return p_oW;
	}
	
	/**
	 * @private
	 */
	public var fadeTo (__getFadeTo,__setFadeTo):Vector;
	private function __getFadeTo ():Vector
	{
		return _fadeTo;
	}

	/**
	 * Transparent point in wx, wy and wz coordinates.
	 */
	public var fadeFrom:Vector;

	/**
	 * Maximum amount of blur to add. <b>Warning:</b> this feature is very expensive when shape useSingleContainer is false.
	 */
	public var blurAmount:Float;

	/**
	 * Creates a new MediumAttributes object.
	 *
	 * @param p_nColor - Medium color (opaque white by default).
	 * @param p_oFadeTo - Attenuation vector (500 pixels beyond the screen by default).
	 * @param p_oFadeFrom - Transparent point (at the screen by default).
	 * @param p_nBlurAmount - Maximum amount of blur to add (0 by default).
	 */
	public function new (?p_nColor:UInt, ?p_oFadeFrom:Vector, ?p_oFadeTo:Vector, ?p_nBlurAmount:Float )
	{
        m_bWasNotBlurred = true;
	    _m = new Matrix();

        if ( p_nColor == null ) p_nColor = 0xFFFFFFFF;
        if ( p_nBlurAmount == null ) p_nBlurAmount = 0;

		if (p_oFadeFrom == null)
			p_oFadeFrom = new Vector (0, 0, 0);
		if (p_oFadeTo == null)
			p_oFadeTo = new Vector (0, 0, 500);
		// --
		super();
		color = p_nColor; fadeTo = p_oFadeTo; fadeFrom = p_oFadeFrom; blurAmount = p_nBlurAmount;
	}

	/**
	 * Draw the attribute onto the graphics object to simulate viewing through partially opaque medium.
	 *  
	 * @param p_oGraphics the Graphics object to draw attributes into
	 * @param p_oPolygon the polygon which is going to be drawn
	 * @param p_oMaterial the refering material
	 * @param p_oScene the scene
	 */
	override public function draw( p_oGraphics:Graphics, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D ):Void
	{
		var l_points:Array<Vertex> = ((p_oPolygon.isClipped) ? p_oPolygon.cvertices : p_oPolygon.vertices);
		var n:Int = l_points.length; if (n < 3) return;

		var l_ratios:Array<Float> = new Array ();
		for (i in 0...n) l_ratios[i] = ratioFromWorldVector (l_points[i].getWorldVector ());

		trace( "Doing something funny here::::" );
		var zIndices:Array<Int> = untyped Reflect.callMethod( l_ratios, "sort", [Array.NUMERIC | Array.RETURNINDEXEDARRAY] );
		/*
		var tmp_ratios:Array<Float> = l_ratios.slice(0);
		tmp_ratios.sort( function (a,b) { 
						if (a > b ) return 1;
						if (a < b ) return -1;
						return 0;
						});
		var zIndices:Array<Int>;
		for ( i in 0...tmp_ratios.length ) zIndices.push( i );
		*/

		var v0: Vertex = l_points[zIndices[0]];
		var v1: Vertex = l_points[zIndices[1]];
		var v2: Vertex = l_points[zIndices[2]];

		var r0: Float = l_ratios[zIndices[0]], ar0:Float = _a * r0;
		var r1: Float = l_ratios[zIndices[1]];
		var r2: Float = l_ratios[zIndices[2]], ar2:Float = _a * r2;

		if (ar2 > 0)
		{
			if (ar0 < 1)
			{
				// gradient matrix
				VertexMath.linearGradientMatrix (v0, v1, v2, r0, r1, r2, _m);

				p_oGraphics.beginGradientFill (flash.display.GradientType.LINEAR, [_c, _c], [ar0, ar2], [0, 0xFF], _m);
			}

			else
			{
				p_oGraphics.beginFill (_c, 1);
			}

			// --
			p_oGraphics.moveTo (l_points[0].sx, l_points[0].sy);
			for (l_oVertex in l_points)
			{
				p_oGraphics.lineTo (l_oVertex.sx, l_oVertex.sy);
			}
			p_oGraphics.endFill();
		}

		blurDisplayObjectBy (
			p_oPolygon.shape.useSingleContainer ? p_oPolygon.shape.container : p_oPolygon.container,
			prepareBlurAmount (blurAmount * r0)
		);
	}

	/**
	 * Draw the attribute on sprite to simulate viewing through partially opaque medium.
	 *  
	 * @param p_oSprite the Sprite2D object to apply attributes to
	 * @param p_oScene the scene
	 */
	override public function drawOnSprite( p_oSprite:Sprite2D, p_oMaterial:Material, p_oScene:Scene3D ):Void
	{
		var l_ratio:Float = Math.max (0, Math.min (1, ratioFromWorldVector (p_oSprite.getPosition ("camera")) * _a));
		var l_color:Dynamic = ColorMath.hex2rgb (_c);
		var l_coltr:ColorTransform = p_oSprite.container.transform.colorTransform;
		// --
		l_coltr.redOffset = Math.round (l_color.r * l_ratio);
		l_coltr.greenOffset = Math.round (l_color.g * l_ratio);
		l_coltr.blueOffset = Math.round (l_color.b * l_ratio);
		l_coltr.redMultiplier = l_coltr.greenMultiplier = l_coltr.blueMultiplier = 1 - l_ratio;
		// --
		p_oSprite.container.transform.colorTransform = l_coltr;

		blurDisplayObjectBy (
			p_oSprite.container,
			prepareBlurAmount (blurAmount * l_ratio)
		);
	}

	// --
	private function ratioFromWorldVector (p_oW:Vector):Float
	{
		p_oW.sub (fadeFrom); return p_oW.dot (_fadeTo) / _fadeToN2;
	}

	private function prepareBlurAmount (p_nBlurAmount:Float):Float
	{
		// a) constrain blur amount according to filter specs
		// b) quantize blur amount to make filter reuse more effective
		return Math.round (10 * Math.min (255, Math.max (0, p_nBlurAmount)) ) * 0.1;
	}

	private var m_bWasNotBlurred:Bool;
	private function blurDisplayObjectBy (p_oDisplayObject:DisplayObject, p_nBlurAmount:Float):Void
	{
		if (m_bWasNotBlurred && (p_nBlurAmount == 0)) return;

		var fs:Array<BlurFilter> = [], changed:Bool = false;
        var i:Int = p_oDisplayObject.filters.length -1;
		while (i > -1)
		{
			if (!changed && Std.is(p_oDisplayObject.filters[i], BlurFilter) && (p_oDisplayObject.filters[i].quality == 1))
			{
				var bf:BlurFilter = p_oDisplayObject.filters[i];

				// hopefully, this check will save some cpu
				if ((bf.blurX == p_nBlurAmount) &&
				    (bf.blurY == p_nBlurAmount)) return;

				// assume this is our filter and change it
				bf.blurX = bf.blurY = p_nBlurAmount; fs[i] = bf; changed = true;
			}
			else
			{
				// copy the filter
				fs[i] = p_oDisplayObject.filters[i];
			}
            i--;
		}
		// if filter was not found, add new
		if (!changed)
		{
			fs.push (new BlurFilter (p_nBlurAmount, p_nBlurAmount, 1));
			// once we added blur we have to track it all the time
			m_bWasNotBlurred = false;
		}
		// re-apply all filters
		p_oDisplayObject.filters = fs;
	}

	// --
	private var _m:Matrix;
	private var _c:UInt;
	private var _a:Float;
	private var _fadeTo:Vector;
	private var _fadeToN2:Float;
}

