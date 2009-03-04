
package sandy.math;

import haxe.FastList;

#if flash
#if flash10
import flash.Memory;
import flash.utils.ByteArray;
#end
typedef TypedArray<T> = flash.Vector<T>;
#else
typedef TypedArray<T> = Array<T>;
#end

/**
* 	Fast trigonometry functions using cache table and precalculated data.
* 	Based on Michael Kraus implementation.
*
* 	@author	Mirek Mencel	// miras@polychrome.pl
* 	@author Niel Drummond - haXe port
*	@author Russell Weir - haXe optimizations
*
*/
class FastMath
{
	/**
	* The precision of the lookup table.
	* <p>The bigger this number, the more entries there are in the lookup table, which gives more accurate results.</p>
	*/
	public static var PRECISION:Int = 0x020000;

	/**
	* Math constant pi&#42;2.
	*/
	public static var TWO_PI:Float = 2*Math.PI;

	/**
	* Math constant pi/2.
	*/
	public static var HALF_PI:Float = Math.PI/2;

	// OPTIMIZATION CONSTANTS
	/**
	* <code>PRECISION</code> - 1.
	*/
	public static var PRECISION_S:Int = PRECISION - 1;

	/**
	* <code>PRECISION</code> / <code>TWO_PI</code>.
	*/
	public static var PRECISION_DIV_2PI:Float = PRECISION / TWO_PI;

	// Precalculated values with given precision
#if flash10
	private static var sinTable:ByteArray;
	private static var tanTable:ByteArray;
#else
	private static var sinTable:TypedArray<Float>;
	private static var tanTable:TypedArray<Float>;
#end

	private static var RAD_SLICE:Float;

	public static function initialized() : Bool {
		if(sinTable == null)
			initialize();
		return true;
	}

	/**
		Enables FastMath. There is no need to call initialize()
		as it will be called from this function.
	**/
	public static function enable() : Void {
		initialize();
		sandy.math.Matrix4Math.USE_FAST_MATH = true;
		sandy.core.data.Matrix4.USE_FAST_MATH = true;
	}

	/**
		Turns off FastMath.
	**/
	public static function disable() : Void {
		sandy.math.Matrix4Math.USE_FAST_MATH = false;
		sandy.core.data.Matrix4.USE_FAST_MATH = false;
	}

	public static function initialize():Void
	{
		PRECISION_S = PRECISION - 1;
		PRECISION_DIV_2PI = PRECISION / TWO_PI;
		RAD_SLICE = TWO_PI / PRECISION;
		#if flash10
			var fs : Int = #if SANDY_FAST_MATH_SINGLE 4 #else 8 #end;
			var len = PRECISION * fs;
			if(len < 1024) len = 1024;
			sinTable = new ByteArray(); sinTable.length = len;
			tanTable = new ByteArray(); tanTable.length = len;
		#else
			sinTable = new TypedArray();
			tanTable = new TypedArray();
		#end

		var rad:Float = 0;
		// --
		#if flash10
			Memory.select(sinTable);
			var f : Int->Float->Void =
				#if SANDY_FAST_MATH_SINGLE
					Memory.setFloat;
				#else
					Memory.setDouble;
				#end
			var shift : Int =
				#if SANDY_FAST_MATH_SINGLE
					1;
				#else
					3;
				#end
			for (i in 0...PRECISION)
			{
				rad = i * RAD_SLICE;
				f((i<<shift), Math.sin(rad));
			}
			Memory.select(tanTable);
			for (i in 0...PRECISION)
			{
				rad = i * RAD_SLICE;
				f((i<<shift), Math.tan(rad));
			}
		#else
			for (i in 0...PRECISION)
			{
				rad = i * RAD_SLICE;
				sinTable[i] = Math.sin(rad);
				tanTable[i] = Math.tan(rad);
			}
		#end
	}

	private static inline function radToIndex(radians:Float):Int
	{
		#if flash10
			#if SANDY_FAST_MATH_SINGLE
				return (Std.int(radians * PRECISION_DIV_2PI ) & (PRECISION_S)) << 1;
			#else
				return (Std.int(radians * PRECISION_DIV_2PI ) & (PRECISION_S)) << 3;
			#end
		#else
			return Std.int(radians * PRECISION_DIV_2PI ) & (PRECISION_S);
		#end
	}

	/**
	 * Returns the sine of a given value, by looking up it's approximation in a
	 * precomputed table.
	 * @param radians The value to sine.
	 * @return The approximation of the value's sine.
	 */
	public static function sin(radians:Float):Float
	{
		#if flash10
			Memory.select(sinTable);
			#if SANDY_FAST_MATH_SINGLE
				return Memory.getFloat(radToIndex(radians));
			#else
				return Memory.getDouble(radToIndex(radians));
			#end
		#else
			return sinTable[ radToIndex(radians) ];
		#end
	}

	/**
	 * Returns the cosine of a given value, by looking up it's approximation in a
	 * precomputed table.
	 * @param radians The value to cosine.
	 * @return The approximation of the value's cosine.
	 */
	public static function cos(radians:Float ):Float
	{
		#if flash10
			Memory.select(sinTable);
			#if SANDY_FAST_MATH_SINGLE
				return Memory.getFloat(radToIndex(HALF_PI-radians));
			#else
				return Memory.getDouble(radToIndex(HALF_PI-radians));
			#end
		#else
			return sinTable[ radToIndex(HALF_PI-radians) ];
		#end
	}

	/**
	 * Returns the tangent of a given value, by looking up it's approximation in a
	 * precomputed table.
	 * @param radians The value to tan.
	 * @return The approximation of the value's tangent.
	 */
	public static function tan(radians:Float):Float
	{
		#if flash10
			Memory.select(tanTable);
			#if SANDY_FAST_MATH_SINGLE
				return Memory.getFloat(radToIndex(radians));
			#else
				return Memory.getDouble(radToIndex(radians));
			#end
		#else
			return tanTable[ radToIndex(radians) ];
		#end
	}

}

