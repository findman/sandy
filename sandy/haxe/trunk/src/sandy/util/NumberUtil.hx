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

package sandy.util;

/**
 * Utility class for useful numeric constants and number manipulation.
 *  
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 */
class NumberUtil 
{
	/**
	 * Math constant 2*pi
	 */
 public static inline var TWO_PI(__getTWO_PI, null):Null<Float>;
	private static inline function __getTWO_PI():Null<Float> { return __TWO_PI; }
	private static inline var __TWO_PI:Null<Float> = 2 * Math.PI;
	
	/**
	 * Math constant pi
	 */
 public static inline var PI(__getPI, null):Null<Float>;
	public static inline function __getPI():Null<Float> { return __PI; }
	private static inline var __PI:Null<Float> = Math.PI;	
	
	/**
	 * Math constant pi/2
	 */
 public static inline var HALF_PI(__getHALF_PI, null):Null<Float>;
	public static inline function __getHALF_PI():Null<Float> { return __HALF_PI; }
	private static inline var __HALF_PI:Null<Float> = 0.5 * Math.PI;	
	
	/**
	 * Constant used to convert angle from radians to degrees
	 */
 public static inline var TO_DEGREE(__getTO_DEGREE, null):Null<Float>;
	public static inline function __getTO_DEGREE():Null<Float> { return __TO_DREGREE; }
	private static inline var __TO_DREGREE:Null<Float> = 180 /  Math.PI;
	
	/**
	 * Constant used to convert degrees to radians.
	 */
 public static inline var TO_RADIAN(__getTO_RADIAN, null):Null<Float>;
	public static inline function __getTO_RADIAN():Null<Float> { return __TO_RADIAN; }
	private static inline var __TO_RADIAN:Null<Float> = Math.PI / 180;
	
	/**
	 * Value used to compare numbers with. 
	 * 
	 * <p>Basically used to say if a number is zero or not.<br />
	 * Adjust this number with regard to the precision of your application</p>
	 */
		public static inline var TOL:Float = 0.00001;	
		
	/**
	 * Is the number small enough to be regarded as zero?.
	 *
	 * <p>Adjust the TOL property depending on the precision of your application</p>
	 *
	 * @param p_nN 	The number to compare to zero
	 * @return 	true if the number is to be regarded as zero, false otherwise.
	 */
	public static inline function isZero( p_nN:Float ):Null<Bool>
	{
		return Math.abs( p_nN ) < TOL ;
	}
	
	/**
	 * Are the numbers close enough to be regarded as equal?.
	 * 
	 * <p>Adjust the TOL property depending on the precision of your application</p>
	 *
	 * @param p_nN 	The first number
	 * @param p_nM 	The second number
	 * @return 	true if the numbers are regarded as equal, false otherwise.
	 */
	public static inline function areEqual( p_nN:Float, p_nM:Float ):Null<Bool>
	{
		return Math.abs( p_nN - p_nM ) < TOL ;
	}
	
	/**
	 * Converts an angle from radians to degrees
	 *
	 * @param p_nRad	A number representing the angle in radians
	 * @return 		The angle in degrees
	 */
	public static inline function toDegree ( p_nRad:Float ):Float
	{
		return p_nRad * TO_DEGREE;
	}
	
	/**
	 * Converts an angle from degrees to radians.
	 * 
	 * @param p_nDeg 	A number representing the angle in dregrees
	 * @return 		The angle in radians
	 */
	public static inline function toRadian ( p_nDeg:Float ):Float
	{
		return p_nDeg * TO_RADIAN;
	}
		
	/**
	 * Constrains a number to a given interval
	 * 
	 * @param p_nN 		The number to constrain
	 * @param p_nMin 	The minimal valid value
	 * @param p_nMax 	The maximal valid value
	 * @return 		The constrained number
	 */
	public static inline function constrain( p_nN:Float, p_nMin:Float, p_nMax:Float ):Float
	{
		return Math.max( Math.min( p_nN, p_nMax ) , p_nMin );
	}
	 
	/**
	 * Rounds a number to specified accuracy.
	 *
	 * <p>To round off the number to 2 decimals, set the the accuracy to 0.01</p>
	 *
	 * @param p_nN 			The number to round off
	 * @param p_nRoundToInterval 	The accuracy to which to round
	 * @return 			The rounded number
	 */
	public static inline function roundTo (p_nN:Float, ?p_nRoundToInterval:Float):Float 
	{
		if (p_nRoundToInterval == 0) 
		{
			p_nRoundToInterval = 1;
		}
		return Math.round(p_nN/p_nRoundToInterval) * p_nRoundToInterval;
	}
	 	 
}

