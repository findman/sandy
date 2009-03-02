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

package sandy.math;

typedef ColorMathRGB = {
		r:Float,
		g:Float,
		b:Float
}
/**
 * Math functions for colors.
 *  
 * @author		Thomas Pfeiffer - kiroukou
 * @author		Tabin Cédric - thecaptain
 * @author		Nicolas Coevoet - [ NikO ]
 * @author Niel Drummond - haXe port 
 * 
 */
class ColorMath
{
	
	/**
	 * Returns the color with altered alpha value.
	 * 
	 * @param c	32-bit color.
	 * @param a	New alpha. 	( 0 - 1 )
	 * @return	The hexadecimal value
	 */
	public static function applyAlpha (c:Int, a:Float):Int
	{
		var a0:Int = Std.int(c / 0x1000000); 
		return (c & 0xFFFFFF) + Math.floor(a * a0) * 0x1000000;
	}
	
	/**
	 * Converts color component values ( rgb ) to one hexadecimal value.
	 * 
	 * @param r	Red Color. 	( 0 - 255 )
	 * @param g	Green Color. 	( 0 - 255 )
	 * @param b	Blue Color. 	( 0 - 255 )
	 * @return	The hexadecimal value
	 */
	public static function rgb2hex(r:Int, g:Int, b:Int):Int  
	{
		return ((r << 16) | (g << 8) | b);
	}

	/**
	 * Converts a hexadecimal color value to rgb components
	 * 
	 * @param	hex	hexadecimal color.
	 * @return	The rgb color of the hexadecimal given.
	 */   
	public static function hex2rgb(hex:Int):ColorMathRGB 
	{
		var r:Float;
		var g:Float;
		var b:Float;
		r = (0xFF0000 & hex) >> 16;
		g = (0x00FF00 & hex) >> 8;
		b = (0x0000FF & hex);
		return {r:r,g:g,b:b} ;
	}

	/**
	* Converts hexadecimal color value to normalized rgb components ( 0 - 1 ).
	* 
	* @param	hex	hexadecimal color value.
	* @return	The normalized rgb components ( 0 - 1.0 )
	*/   
	public static function hex2rgbn(hex:Int):Dynamic 
	{
		var r:Float;
		var g:Float;
		var b:Float;
		r = (0xFF0000 & hex) >> 16;
		g = (0x00FF00 & hex) >> 8;
		b = (0x0000FF & hex);
		return {r:r/255,g:g/255,b:b/255} ;
	}
	
	/**
	 * Calculate the colour for a particular lighting strength.
	 * This converts the supplied pre-multiplied RGB colour into HSL
	 * then modifies the L according to the light strength. 
	 * The result is then mapped back into the RGB space.
	 */	
	public static function calculateLitColour(col:Int, lightStrength:Float):Float
	{
		var r:Float = ( col >> 16 )& 0xFF;
		var g:Float = ( col >> 8 ) & 0xFF;
		var b:Float = ( col ) 		& 0xFF;

		// divide by 256
		r *= 0.00390625;
		g *= 0.00390625;
		b *= 0.00390625;
												   
		var min:Float = 0.0, mid:Float = 0.0, max:Float = 0.0, delta:Float = 0.0;
		var l:Float = 0.0, s:Float = 0.0, h:Float = 0.0, F:Float = 0.0, n:Int = 0;
		
		var a:Array<Float> = [r,g,b];
		a.sort(function (a,b) {return ((a>b)?1:(a<b)?-1:0); } );

		min = a[0];
		mid = a[1];		
		max = a[2];
		
		var range:Float = max - min;
		
		l = (min + max) * 0.5;
		
		if (l == 0) 
		{
			s = 1;
		}
		else
		{
			delta = range * 0.5;
			
			if (l < 0.5) 
			{
				s = delta / l;
			}
			else 
			{
				s = delta / (1 - l);
			}

			if (range != 0) 
			{
				while (true) 
				{
					if (r == max) 
					{
						if (b == min) n = 0; 
						else n = 5;
						
						break;
					}
						
					if (g == max) 
					{
						if (b == min) n = 1; 
						else n = 2;
						
						break;
					}
						
					if (r == min) n = 3; 
					else n = 4;
					
					break;
				}
				
				if ((n % 2) == 0) 
				{
					F = mid - min;
				}
				else 
				{
					F = max - mid;
				}
				
				F = F / range;
				h = 60 * (n + F);
			}
		}

		if (lightStrength < 0.5) 
		{
			delta = s * lightStrength;
		}
		else 
		{
			delta = s * (1 - lightStrength);
		}
		

		min = lightStrength - delta;
		max = lightStrength + delta;

		n = Math.floor(h / 60);
		F = (h - n*60) * delta / 30;
		n %= 6;
		
		var mu:Float = min + F;
		var md:Float = max - F;
		
		switch (n) 
		{
			case 0: r = max; g= mu;  b= min;
			case 1: r = md;  g= max; b= min;
			case 2: r = min; g= max; b= mu;
			case 3: r = min; g= md;  b= max;
			case 4: r = mu;  g= min; b= max;
			case 5: r = max; g= min; b= md;
		}
			
		return (Std.int(r * 256) << 16 | Std.int(g * 256) << 8 |  Std.int(b * 256));
	}
}

