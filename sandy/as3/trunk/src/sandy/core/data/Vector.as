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
package sandy.core.data
{
	import sandy.util.NumberUtil;

	/**
	 * A 3D coordinate.
	 *
	 * <p>A representation of a position in a 3D space.</p>
	 *
	 * @author		Thomas Pfeiffer - kiroukou
	 * @author		Mirek Mencel
	 * @author		Tabin Cédric - thecaptain
	 * @author		Nicolas Coevoet - [ NikO ]
	 * @author		Bruce Epstein - zeusprod - truncated toString output to 2 decimals
	 * @since		0.1
	 * @version		3.0
	 * @date 		24.08.2007
	 */
	public final class Vector
	{
		/**
		 * The x coordinate.
		 */
		public var x:Number;
		/**
		 * The y coordinate.
		 */
		public var y:Number;
		/**
		 * The z coordinate.
		 */
		public var z:Number;

		/**
		* Creates a new vector.
		*
		* @param p_nX	The x coordinate.
		* @param p_nY	The y coordinate.
		* @param p_nZ	The z coordinate.
		*/
		public function Vector(p_nX:Number=0, p_nY:Number=0, p_nZ:Number=0)
		{
			x = p_nX;
			y = p_nY;
			z = p_nZ;
		}

		/**
		 * Sets the <code>x</code>, <code>y</code>, and <code>z</code> properties to <code>0</code>.
		 */
		public function reset( px:Number=0, py:Number=0, pz:Number=0):void
		{
			x = px; y = py; z = pz;
		}
		
		/**
		 * Sets the <code>x</code>, <code>y</code>, and <code>z</code> properties to lowest value Flash can handle (<code>Number.NEGATIVE_INFINITY</code>).
		 */
		public function resetToNegativeInfinity():void
		{
			x = y = z = Number.NEGATIVE_INFINITY;
		}

		/**
		 * Sets the <code>x</code>, <code>y</code>, and <code>z</code> properties to highest value Flash can handle (<code>Number.POSITIVE_INFINITY</code>).
		 */
		public function resetToPositiveInfinity():void
		{
			x = y = z = Number.POSITIVE_INFINITY;
		}
		
		/**
		 * Returns a new Vector object that is a clone of the original instance. 
		 * 
		 * @return A new Vector object that is identical to the original. 
		 */	
		public final function clone():Vector
		{
		    var l_oV:Vector = new Vector( x, y, z );
		    return l_oV;
		}

		/**
		 * Makes this vector a copy of the specified vector.
		 *
		 * <p>All components of the specified vector are copied to this vector.</p>
		 *
		 * @param p_oVector	The vector to copy.
		 */
		public final function copy( p_oVector:Vector ):void
		{
			x = p_oVector.x;
			y = p_oVector.y;
			z = p_oVector.z;
		}

		/**
		 * Returns the norm of this vector.
		 *
		 * <p>The norm is calculated by <code>Math.sqrt( x*x + y*y + z*z )</code>.</p>
		 *
		 * @return 	The norm.
		 */
		public final function getNorm():Number
		{
			return Math.sqrt( x*x + y*y + z*z );
		}

		/**
		 * Returns the inverse of this vector, will all properties as their negative values.
		 *
		 * @return 	The inverse of the vector.
		 */
		public final function negate( /*v:Vector*/ ): Vector
		{
			// Commented out the argument as it is never used - Petit
			return new Vector( - x, - y, - z );
		}

		/**
		 * Adds the specified vector to this vector.
		 *
		 * @param v 	The vector to add.
		 */
		public final function add( v:Vector ):void
		{
			x += v.x;
			y += v.y;
			z += v.z;
		}

		/**
		 * Substracts the specified vector from this vector.
		 *
		 * @param v		The vector to subtract.
		 */
		public final function sub( v:Vector ):void
		{
			x -= v.x;
			y -= v.y;
			z -= v.z;
		}

		/**
		 * Raises the vector to the specified power.
		 *
		 * <p>All components of the vertex are raised to the specified power.</p>
		 *
		 * @param pow The power to raise the vector to.
		 */
		public final function pow( pow:Number ):void
		{
			x = Math.pow( x, pow );
	        y = Math.pow( y, pow );
	        z = Math.pow( z, pow );
		}
		
		/**
		 * Multiplies this vector by the specified number.
		 *
		 * <p>All components of the vector are multiplied by the specified number.</p>
		 *
		 * @param n 	The number to multiply the vector with.
		 */
		public final function scale( n:Number ):void
		{
			x *= n;
			y *= n;
			z *= n;
		}

		/**
		 * Returns the dot product between this vector and the specified vector.
		 *
		 * @param w 	The vector to make a dot product with.
		 *
		 * @return The dot product.
		 */
		public final function dot( w: Vector):Number
		{
			return ( x * w.x + y * w.y + z * w.z );
		}

		/**
		 * Returns the cross product between this vector and the specified vector.
		 *
		 * @param v 	The vector to make a cross product with (right side).
		 *
		 * @return The resulting vector of the cross product.
		 */
		public final function cross( v:Vector):Vector
		{
			// cross product vector that will be returned
			return new Vector(
								(y * v.z) - (z * v.y) ,
			                 	(z * v.x) - (x * v.z) ,
			               		(x * v.y) - (y * v.x)
	                           );
		}

		/**
		 * Crosses this vector with the specified vector.
		 *
		 * @param v 	The vector to make the cross product with (right side).
		 */
		public final function crossWith( v:Vector):void
		{
			const cx:Number = (y * v.z) - (z * v.y);
			const cy:Number = (z * v.x) - (x * v.z);
			const cz:Number = (x * v.y) - (y * v.x);
			x = cx; y = cy; z = cz;
		}

		/**
		 * Normalizes this vector.
		 *
		 * <p>A vector is normalized when its components are divided by its norm.
		 * The norm is calculated by <code>Math.sqrt( x*x + y*y + z*z )</code>. After normalizing
		 * the vector, the direction is the same, but the length is <code>1</code>.</p>
		 */
		public final function normalize():void
		{
			// -- We get the norm of the vector
			var norm:Number = getNorm();
			// -- We escape the process is norm is null or equal to 1
			if( norm == 0 || norm == 1) return;
			x /= norm;
			y /= norm;
			z /= norm;
		}

		/**
		 * Gives the biggest component of the current vector.
		 * <listing version="3.0">
		 *     var lMax:Number = new Vector(5, 6.7, -4).getMaxComponent(); //returns 6.7
		 *  </listing>
		 * 
		 * @return The biggest component value of the vector
		 */
		public final function getMaxComponent():Number
		{
			return Math.max( x, Math.max( y, z ) );
		}
		
		/**
		 * Gives the smallest component of the current vector.
		 * <listing version="3.0">
		 *     var lMin:Number = new Vector(5, 6.7, -4).getMinComponent(); //returns -4
		 *  </listing>
		 * 
		 * @return The smallest component value of the vector
		 */
		public final function getMinComponent():Number
		{
			return Math.min( x, Math.min( y, z ) );
		}
		
		/**
		 * Returns the angle between this vector and the specified vector.
		 *
		 * @param w		The vector making an angle with this one.
		 *
		 * @return The angle in radians.
		 */
		public final function getAngle ( w:Vector ):Number
		{
			var n1:Number = getNorm();
			var n2:Number =  w.getNorm();
			var denom:Number = n1 * n2;
			if( denom  == 0 ) 
			{
				return 0;
			}
			else
			{
				var ncos:Number = dot( w ) / ( denom );
				var sin2:Number = 1 - (ncos * ncos);
				if ( sin2 < 0 )
				{
					trace(" wrong "+ncos);
					sin2 = 0;
				}
				//I took long time to find this bug. Who can guess that (1-cos*cos) is negative ?!
				//sqrt returns a NaN for a negative value !
				return  Math.atan2( Math.sqrt(sin2), ncos );
			}
		}


		/**
		 * Returns a string representation of this object.
		 *
		 * @param decPlaces	The number of decimal places to round the vector's components off to.
		 *
		 * @return	The fully qualified name of this object.
		 */
		public final function toString(decPlaces:Number=0):String
		{
			
			// Round display to the specified number of decimals places
			// Returns "{x, y, z}"
			return "{" + serialize(Math.pow (10, -decPlaces)) + "}";
		}
		
		// Useful for XML output
		public function serialize(decPlaces:Number=0.1):String
		{
			//returns x,y,x
			return  (NumberUtil.roundTo(x, decPlaces) + "," + 
					 NumberUtil.roundTo(y, decPlaces) + "," + 
					 NumberUtil.roundTo(z, decPlaces));
		}
		
		// Useful for XML input
		public static function deserialize(convertFrom:String):Vector
		{
			var tmp:Array = convertFrom.split(",");
			if (tmp.length != 3) {
				trace ("Unexpected length of string to deserialize into a vector " + convertFrom);
			}
			for (var i:Number = 0; i < tmp.length; i++) {
				tmp[i] = Number(tmp[i]);
			}
			return new Vector (tmp[0], tmp[1], tmp[2]);
		}

		/**
		 * Determines if this vector is equal to the specified vector.
		 *
		 * <p>This all properties of this vector is compared to the properties of the specified vector.
		 * If all properties of the two vectors are equal, a value of <code>true</code> is returned.</p>
		 *
		 * @return Whether the two vectors are equal.
		 */
		public final function equals(p_vector:Vector):Boolean
		{
			return (p_vector.x == x && p_vector.y == y && p_vector.z == z);
		}
		

	}
}
