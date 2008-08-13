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

import sandy.util.NumberUtil;

/**
 * A point in 3D world.
 *
 * <p>A representation of a position in a 3D space.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		Mirek Mencel
 * @author		Tabin Cédric - thecaptain
 * @author		Nicolas Coevoet - [ NikO ]
 * @author		Bruce Epstein - zeusprod - truncated toString output to 2 decimals
 * @author		Floris van Veen - Floris
 * @since		0.1
 * @version		3.0
 * @date 		24.08.2007
 */
class sandy.core.data.Vector
{
	public var x:Number;
	public var y:Number;
	public var z:Number;

	/**
	* Creates a new vector instance.
	*
	* @param	p_nX	the x coordinate
	* @param	p_nY	the y coordinate
	* @param	p_nZ	the z coordinate
	*/
	public function Vector( p_nX:Number, p_nY:Number, p_nZ:Number )
	{
		if( p_nX == null ) p_nX = 0;
		if( p_nY == null ) p_nY = 0;
		if( p_nZ == null ) p_nZ = 0;
		x = p_nX;
		y = p_nY;
		z = p_nZ;
	}

	/**
	 * Reset the vector components to 0
	 * after calling this method, x, y and z will be set to 0
	 */
	public function reset( px:Number, py:Number, pz:Number) : Void
	{
		if( px == null ) px = 0;
		if( py == null ) py = 0;
		if( pz == null ) pz = 0;
		x = px; y = py; z = pz;
	}
	
	/**
	 * Reset the vector components to the minimal value Flash can handle
	 * after calling this method, x, y and z will be set to Number.NEGATIVE_INFINITY;
	 */
	public function resetToNegativeInfinity() : Void
	{
		x = y = z = Number.NEGATIVE_INFINITY;
	}

	/**
	 * Reset the vector components to the maximal value Flash can handle
	 * after calling this method, x, y and z will be set to Number.POSITIVE_INFINITY;
	 */
	public function resetToPositiveInfinity() : Void
	{
		x = y = z = Number.POSITIVE_INFINITY;
	}
	
	/**
	 * Returns a clone of thei vector.
	 *
	 * @return 	The clone
	 */
	public function clone() : Vector
	{
	    var l_oV:Vector = new Vector( x, y, z );
	    return l_oV;
	}

	/**
	 * Makes this vector a copy of the specified vector.
	 *
	 * <p>All elements of this vector is set to those of the argument vector</p>
	 *
	 * @param p_oVector	The vector to copy
	 */
	public function copy( p_oVector:Vector ) : Void
	{
		x = p_oVector.x;
		y = p_oVector.y;
		z = p_oVector.z;
	}

	/**
	 * Computes and returns the norm of this vector.
	 *
	 * <p>The norm of the vector is sqrt( x*x + y*y + z*z )</p>
	 *
	 * @return 	The norm
	 */
	public function getNorm() : Number
	{
		return Math.sqrt( x*x + y*y + z*z );
	}

	/**
	 * Compute and returns the inverse of this vector.
	 *
	 * @return 	The inverse
	 */
	public function negate( /*v:Vector*/ ) : Vector
	{
		// Commented out the argument as it is never used - Petit
		return new Vector( - x, - y, - z );
	}

	/**
	 * Adds a specified vector to this vector.
	 *
	 * @param v 	The vector to add
	 */
	public function add( v:Vector ) : Void
	{
		x += v.x;
		y += v.y;
		z += v.z;
	}

	/**
	 * Substracts the specified vector from this vector.
	 *
	 * @param {@code v} a {@code Vector}.
	 * @param {@code w} a {@code Vector}.
	 * @return The resulting {@code Vector}.
	 */
	public function sub( v:Vector ) : Void
	{
		x -= v.x;
		y -= v.y;
		z -= v.z;
	}

	/**
	 * Raises this vector to the specified power.
	 *
	 * <p>Each component of the vector is raised to the argument power.<br />
	 * So x = Math.pow( x, pow ), y = Math.pow( y, pow ),z = Math.pow( z, pow )</p>
	 *
	 * @param {@code pow} a {@code Number}.
	 */
	public function pow( pow:Number ) : Void
	{
		x = Math.pow( x, pow );
        y = Math.pow( y, pow );
        z = Math.pow( z, pow );
	}

	/**
	 * Multiplies this vector by the specified scalar.
	 *
	 * @param {@code n a {@code Number}.
	 */
	public function scale( n:Number ) : Void
	{
		x *= n;
		y *= n;
		z *= n;
	}

	/**
	 * Computes and returns the dot product between this vector and the specified vector.
	 *
	 * @param w 	The vector to multiply
	 * @return 	The dot procuct
	 */
	public function dot( w: Vector) : Number
	{
		return ( x * w.x + y * w.y + z * w.z );
	}

	/**
	 * Computes and returns the cross between this vector and the specified vector.
	 *
	 * @param v 	The vector to make the cross product with ( right side )
	 * @return 	The cross product vector.
	 */
	public function cross( v:Vector ) : Vector
	{
		// cross product vector that will be returned
		return new Vector(
							(y * v.z) - (z * v.y) ,
		                 	(z * v.x) - (x * v.z) ,
		               		(x * v.y) - (y * v.x)
                           );
	}
		
	/**
   	 * Normalizes this vector.
	 *
	 * <p>After normalizing the vector, the direction is the same, but the length is = 1.</p>
	 */
	public function normalize() : Void
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
	 * Example : var lMax:Number = new Vector(5, 6.7, -4).getMaxComponent(); //returns 6.7
	 * 
	 * @return The biggest component value of the vector
	 */
	public function getMaxComponent() : Number
	{
		return Math.max( x, Math.max( y, z ) );
	}
		
	/**
	 * Gives the smallest component of the current vector.
	 * Example : var lMin:Number = new Vector(5, 6.7, -4).getMinComponent(); //returns -4
	 * 
	 * @return The smallest component value of the vector
	 */
	public function getMinComponent() : Number
	{
		return Math.min( x, Math.min( y, z ) );
	}
		
	/**
	 * Returns the angle between this vector and the specified vector.
	 *
	 * @param w	The vector making an angle with this one
	 * @return 	The angle in radians
	 */
	public function getAngle ( w:Vector ) : Number
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
			var sin2:Number = 1 - ( ncos * ncos );
			if ( sin2 < 0 )
			{
				trace( "Wrong: " + ncos );
				sin2 = 0;
			}
			//I took long time to find this bug. Who can guess that (1-cos*cos) is negative ?!
			//sqrt returns a NaN for a negative value !
			return  Math.atan2( Math.sqrt(sin2), ncos );
		}
	}


	/**
	 * Returns a string representing this vector.
	 *
	 * @param decPlaces	Number of decimals
	 * @return	The string representatation
	 */
	public function toString( decPlaces:Number ) : String
	{
		if( decPlaces == null ) decPlaces = .01;
		if ( decPlaces == 0 )
		{
			decPlaces = .01;
		}
		// Round display to two decimals places
		// Returns "{x, y, z}"
		return "sandy.core.data.vector {" +
					 NumberUtil.roundTo(x, decPlaces) + ", " +
					 NumberUtil.roundTo(y, decPlaces) + ", " +
					 NumberUtil.roundTo(z, decPlaces) + "}";
	}

	/**
	 * Is this vector equal to the specified vector?.
	 *
	 * <p>Compares this vector with the vector passed in the argument.<br />
	 * If all components in the two vectors are equal a value of true is returned.</p>
	 *
	 * @return 	true if the the two vectors are equal, fals otherwise.
	 */
	public function equals( p_vector:Vector ) : Boolean
	{
		return (p_vector.x == x && p_vector.y == y && p_vector.z == z);
	}

	// Useful for XML output
	/**
	 * Returns a string representation of this vector with rounded values.
	 *
	 * <p>[<strong>ToDo</strong>: Explain why this is good for XML output! ]</p>
	 *
	 * @param decPlaces	Number of decimals
	 * @return 		The specific serialize string
	 */
	public function serialize( decPlaces:Number ) : String
	{
		if( decPlaces == null ) decPlaces = .01;
		if (decPlaces == 0)
		{
			decPlaces = .01
		}
		//returns x,y,x
		return  ( NumberUtil.roundTo(x, decPlaces) + "," +
				  NumberUtil.roundTo(y, decPlaces) + "," +
				  NumberUtil.roundTo(z, decPlaces) );
	}

	// Useful for XML output
	/**
	 * Sets the elements of this vector from a string representation.
	 *
	 * <p>[<strong>ToDo</strong>: Explain why this is good for XML intput! ]</p>
	 *
	 * @param 	A string representing the vector ( specific serialize format )
	 */
	public function deserialize( convertFrom:String ) : Void
	{
		var tmp:Array = convertFrom.split( "," );
		if (tmp.length != 3)
		{
			trace ( "Unexpected length of string to deserialize into a vector " + convertFrom );
		}

		x = tmp[0];
		y = tmp[1];
		z = tmp[2];
	}
}
