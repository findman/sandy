/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author or authors.
Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 ( the "License" );
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
import sandy.materials.attributes.AAttributes;
import sandy.math.ColorMath;
import sandy.math.VertexMath;
	
/**
 * This attribute provides very basic simulation of partially opaque medium.
 * You can use this attribute to achieve wide range of effects ( e.g., fog, Rayleigh scattering, light attached to camera, etc ).
 * 
 * @author		makc
 * @author		(porting) Floris - xdevltd
 * @version		2.0.2
 * @date 		01.12.2007
 */
	 
class sandy.materials.attributes.MediumAttributes extends AAttributes
{

	/**
	 * @private
	 */
	public function set color( p_nColor:Number ) : Void
	{
		_c = int( p_nColor ) & 0xFFFFFF;
		_a = ( int( p_nColor ) - _c ) / 0x1000000 / 255.0;
	}
	
	/**
	 * Medium color ( 32-bit value ) at the point given by fadeFrom + fadeTo.
	 * If this value is transparent, color gradient will be extrapolated beyond that point.
	 */
	public function get color() : Number
	{
		return int( _c + Math.floor( 0xFF * _a ) * 0x1000000 );
	}

	/**
	 * @private
	 */
	public function set fadeTo( p_oW:Vector ) : Void
	{
		_fadeTo = p_oW;
		_fadeToN2 = p_oW.getNorm(); _fadeToN2 *= _fadeToN2;
	}
	
	/**
	 * Attenuation vector. This is the vector from transparent point to opaque point.
	 *
	 * @see sandy.core.data.Vector
	 */
	public function get fadeTo() : Vector
	{
		return _fadeTo;
	}

	/**
	 * Transparent point in wx, wy and wz coordinates.
	 *
	 * @see sandy.core.data.Vector
	 */
	public var fadeFrom:Vector;

	/**
	 * Maximum amount of blur to add. <b>Warning:</b> this feature is very expensive when shape useSingleContainer is false.
	 */
	public var blurAmount:Number;

	/**
	 * Creates a new MediumAttributes object.
	 *
	 * @param p_nColor		Medium color
	 * @param p_oFadeTo		Attenuation vector ( 500 pixels beyond the screen by default ).
	 * @param p_oFadeFrom	Transparent point ( at the screen by default ).
	 * @param p_nBlurAmount	Maximum amount of blur to add
	 *
	 * @see sandy.core.data.Vector
	 */
	public function MediumAttributes( p_nColor:Number, p_oFadeFrom:Vector, p_oFadeTo:Vector, p_nBlurAmount:Number )
	{
		if( p_oFadeFrom == null )
			p_oFadeFrom = new Vector ( 0, 0, 0 );
		if( p_oFadeTo == null )
			p_oFadeTo = new Vector ( 0, 0, 500 );
		// --
		color = int( p_nColor||0xFFFFFFFF ); fadeTo = p_oFadeTo; fadeFrom = p_oFadeFrom; blurAmount = p_nBlurAmount||0; _m = new Matrix();
	}

	/**
	 * @private
	 */
	public function draw( p_oMovieClip:MovieClip, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D ) : Void
	{
		var l_points:Array = ( ( p_oPolygon.isClipped ) ? p_oPolygon.cvertices : p_oPolygon.vertices );
		var n:Number = l_points.length; if( n < 3 ) return;

		var l_ratios:Array = new Array( n );
		for( var i:Number = 0; i < n; i++ ) l_ratios[ i ] = ratioFromWorldVector( l_points[ i ].getWorldVector() );

		var zIndices:Array = l_ratios.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY );

		var v0:Vertex = l_points[ zIndices[ 0 ] ];
		var v1:Vertex = l_points[ zIndices[ 1 ] ];
		var v2:Vertex = l_points[ zIndices[ 2 ] ];

		var r0:Number = l_ratios[ zIndices[ 0 ] ], ar0:Number = _a * r0;
		var r1:Number = l_ratios[ zIndices[ 1 ] ];
		var r2:Number = l_ratios[ zIndices[ 2 ] ], ar2:Number = _a * r2;

		if( ar2 > 0 )
		{
			if( ar0 < 1 )
			{
				// gradient matrix
				VertexMath.linearGradientMatrix( v0, v1, v2, r0, r1, r2, _m );

				p_oMovieClip.beginGradientFill( "linear", [ _c, _c ], [ ar0, ar2 ], [ 0, 0xFF ], _m );
			}
			else
			{
				p_oMovieClip.beginFill( _c, 1 );
			}

			// --
			p_oMovieClip.moveTo( l_points[ 0 ].sx, l_points[ 0 ].sy );
			var l_oVertex:Vertex;
			for( l_oVertex in l_points )
			{
				p_oMovieClip.lineTo( l_points[ l_oVertex ].sx, l_points[ l_oVertex ].sy );
			}
			p_oMovieClip.endFill();
		}

		blurDisplayObjectBy( p_oPolygon.shape.useSingleContainer ? p_oPolygon.shape.container : p_oPolygon.container, prepareBlurAmount( blurAmount * r0 ) );
	}

	/**
	 * @private
	 */
	public function drawOnSprite( p_oSprite:Sprite2D, p_oMaterial:Material, p_oScene:Scene3D ) : Void
	{
		var l_ratio:Number = Math.max( 0, Math.min ( 1, ratioFromWorldVector( p_oSprite.getPosition( "camera" ) ) * _a ) );
		var l_color:Object = ColorMath.hex2rgb( _c );
		var l_coltr:ColorTransform = p_oSprite.container.transform.colorTransform;
		// --
		l_coltr.redOffset = Math.round( l_color.r * l_ratio );
		l_coltr.greenOffset = Math.round( l_color.g * l_ratio );
		l_coltr.blueOffset = Math.round( l_color.b * l_ratio );
		l_coltr.redMultiplier = l_coltr.greenMultiplier = l_coltr.blueMultiplier = 1 - l_ratio;
		// --
		p_oSprite.container.transform.colorTransform = l_coltr;

		blurDisplayObjectBy( p_oSprite.container, prepareBlurAmount( blurAmount * l_ratio ) );
	}

	// --
	private function ratioFromWorldVector( p_oW:Vector ) : Number
	{
		p_oW.sub( fadeFrom ); return p_oW.dot( _fadeTo ) / _fadeToN2;
	}

	private function prepareBlurAmount( p_nBlurAmount:Number ) : Number
	{
		// a ) constrain blur amount according to filter specs
		// b ) quantize blur amount to make filter reuse more effective
		return Math.round( 10 * Math.min( 255, Math.max( 0, p_nBlurAmount ) ) ) * 0.1;
	}

	private var m_bWasNotBlurred:Boolean = true;
	private function blurDisplayObjectBy( p_oMovieClip:MovieClip, p_nBlurAmount:Number ) : Void
	{
		if( m_bWasNotBlurred && ( p_nBlurAmount == 0 ) ) return;

		var fs:Array = [], changed:Boolean = false;

		for( var i:Number = p_oMovieClip.filters.length - 1; i > -1; i-- )
		{
			if( !changed && ( p_oMovieClip.filters[ i ] instanceof BlurFilter ) && ( p_oMovieClip.filters[ i ].quality == 1 ) )
			{
				var bf:BlurFilter = p_oMovieClip.filters[ i ];

				// hopefully, this check will save some cpu
				if( ( bf.blurX == p_nBlurAmount ) &&
				    ( bf.blurY == p_nBlurAmount ) ) return;

				// assume this is our filter and change it
				bf.blurX = bf.blurY = p_nBlurAmount; fs[ i ] = bf; changed = true;
			}
			else
			{
				// copy the filter
				fs[ i ] = p_oMovieClip.filters[ i ];
			}
		}
		// if filter was not found, add new
		if( !changed )
		{
			fs.push( new BlurFilter( p_nBlurAmount, p_nBlurAmount, 1 ) );
			// once we added blur we have to track it all the time
			m_bWasNotBlurred = false;
		}
		// re-apply all filters
		p_oMovieClip.filters = fs;
	}

	// --
	private var _m:Matrix;
	private var _c:Number;
	private var _a:Number;
	private var _fadeTo:Vector;
	private var _fadeToN2:Number;
	
}