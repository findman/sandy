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

import haxe.FastList;

/**
* 	Fast trigonometry functions using cache table and precalculated data. 
* 	Based on Michael Kraus implementation.
* 
* 	@author	Mirek Mencel	// miras@polychrome.pl
* 	@author Niel Drummond - haXe port 
* 	
*/
class FastMath
{
	/** Precission. The bigger, the more entries in lookup table so the more accurate results. */
	public static var PRECISION:Int = 0x020000;
	public static var TWO_PI:Float = 2*Math.PI;
	public static var HALF_PI:Float = Math.PI/2;
	// OPTIMIZATION CONSTANTS
	public static var PRECISION_S:Int = PRECISION - 1;
	public static var PRECISION_DIV_2PI:Float = PRECISION / TWO_PI;
	/** Precalculated values with given precision */
	private var sinTable:Array<Float>;
	private var tanTable:Array<Float>;
	
	private var RAD_SLICE:Float;
	
	private static var _initialized:FastMath;
	// do this at the end of declarations
	public static function initialized():Bool { 
			if ( _initialized == null ) _initialized = initialize(); 
			return true;
	}

	private function new () {
	 sinTable = new Array();
	 tanTable = new Array();
		RAD_SLICE = TWO_PI / PRECISION;
	}
	
	private static function initialize():FastMath
	{
		var rad:Float = 0;
		var inst:FastMath = new FastMath();
		// --
		for (i in 0...PRECISION) 
		{
			rad = i * inst.RAD_SLICE;
			inst.sinTable[i] = Math.sin(rad);
			inst.tanTable[i] = Math.tan(rad);
		}
		// --
		return inst;
	}

	private static function radToIndex(radians:Float):Int 
	{
		return Std.int(Std.int(radians * PRECISION_DIV_2PI ) & (PRECISION_S));
	}

	/**
	 * Returns the sine of a given value, by looking up it's approximation in a
	 * precomputed table.
	 * @param radians The value to sine.
	 * @return The approximation of the value's sine.
	 */
	public static function sin(radians:Float):Float 
	{
		return _initialized.sinTable[ Std.int( radToIndex(radians) ) ];
	}

	/**
	 * Returns the cosine of a given value, by looking up it's approximation in a
	 * precomputed table.
	 * @param radians The value to cosine.
	 * @return The approximation of the value's cosine.
	 */
	public static function cos(radians:Float ):Float 
	{
		return _initialized.sinTable[ Std.int( radToIndex(HALF_PI-radians) ) ];
	}

	/**
	 * Returns the tangent of a given value, by looking up it's approximation in a
	 * precomputed table.
	 * @param radians The value to tan.
	 * @return The approximation of the value's tangent.
	 */
	public static function tan(radians:Float):Float 
	{
		return _initialized.tanTable[( radToIndex(radians) )];
	}

}

