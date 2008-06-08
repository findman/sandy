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
package sandy.util 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	import sandy.core.scenegraph.Shape3D;
	import sandy.core.data.Polygon;
	
	/**
	 * Utility class for Bitmap calculations.
	 * 
	 * @author		Thomas Pfeiffer - kiroukou
	 * @version		3.0
	 * @date 		26.07.2007
	 */
	public class BitmapUtil
	{
		/**
		 * Converts a sprite to a bitmap respecting the sprite position.
		 * 
		 * <p>The simple BitmapData.draw method doesn't take care of the negative part of the sprite during the draw.<br />
		 * This method does.</p>
		 * 
		 * @param p_oSprite 		The sprite to convert.
		 * @param p_bTransparent	Whether to allow transparency.
		 * @param p_nColor			Background color (32 bit).
		 *
		 * @return 			The converted bitmap.
		 */
		public static function movieToBitmap( p_oSprite:Sprite, p_bTransparent:Boolean=true, p_nColor:Number=0x00FF00CC /* a random color, needed tby the bitmapData constructor to apply transparency */ ):BitmapData
		{
			var bmp:BitmapData;
			// --
			bmp = new BitmapData( p_oSprite.width, p_oSprite.height, p_bTransparent, p_nColor );
			bmp.draw( p_oSprite );
			// --
			return bmp;
		}
		
		
		/**
		 * Returns a scaled version of a bitmap.
		 * 
		 * <p>The method takes a bitmap as input, and returns a scaled copy.<br/>
		 * The original is not changed.</p>
		 *
		 * @param p_oBitmap	The bitmap to scale.
		 * @param p_nScalex	The x-scale.
		 * @param p_nScaley	The y-scale.
		 *
		 * @return 		The scaled bitmap data.
		 */
		public static function getScaledBitmap( p_oBitmap:BitmapData, p_nScalex:Number, p_nScaley:Number=0 ):BitmapData
		{
			//scaley = (undefined == scaley) ? scalex : scaley;
			var tex:BitmapData = new BitmapData( p_nScalex * p_oBitmap.width, p_nScaley * p_oBitmap.height);
			tex.draw( p_oBitmap, new Matrix( p_nScalex, 0, 0, p_nScaley ) );
			return tex;
		}
		
		/**
		 * Returns a concatenation of two bitmap matrices.
		 * 
		 * <p>[<strong>ToDo</strong>: Explain what matrices are handled here ]</p>
		 * 
		 * @param p_oM1	The matrix of the first bitmap.
		 * @param p_oM2	The matrix of the second bitmap.
		 *
		 * @return 	The resulting matrix.
		 */
		public static function concatBitmapMatrix( p_oM1:Object, p_oM2:Object ):Object
		{	
			var r:Object = new Object();
			// --
			r.a = p_oM1.a * p_oM2.a;
			r.d = p_oM1.d * p_oM2.d;
			r.b = r.c = 0;
			r.ty = p_oM1.ty * p_oM2.d + p_oM2.ty;
			r.tx = p_oM1.tx * p_oM2.a + p_oM2.tx;
			// --
			if( p_oM1.b != 0 || p_oM1.c !=0 || p_oM2.b != 0 || p_oM2.c != 0 )
			{
				r.a  += p_oM1.b * p_oM2.c;
				r.d  += p_oM1.c * p_oM2.b;
				r.b  += p_oM1.a * p_oM2.b + p_oM1.b * p_oM2.d;
				r.c  += p_oM1.c * p_oM2.a + p_oM1.d * p_oM2.c;
				r.tx += p_oM1.ty * p_oM2.c;
				r.ty += p_oM1.tx * p_oM2.b;
			}
			// --
			return r;
		}

		/**
		 * Creates shape texture map template. This is useful for 3rd party models texturing :)
		 *
		 * @param obj	Shape to rip texture template from.
		 * @param size	Template size (will be size x size pixels).
		 *
		 * @return 		Sprite with texture map template drawn in.
		 */
		public static function ripShapeTexture (obj:Shape3D, size:Number = 256):Sprite {
			var tex:Sprite = new Sprite ();
			tex.graphics.beginFill (0); tex.graphics.drawRect (0, 0, size, size); tex.graphics.endFill ();
			tex.graphics.lineStyle (1, 0xFF0000);
			for each (var p:Polygon in obj.aPolygons) {
				var i:int = p.vertices.length -1;
				tex.graphics.moveTo (size * p.aUVCoord [i].u, size * p.aUVCoord [i].v);
				for (i = 0; i < p.vertices.length; i++)
					tex.graphics.lineTo (size * p.aUVCoord [i].u, size * p.aUVCoord [i].v);
			}
			return tex;
		}

	}
}