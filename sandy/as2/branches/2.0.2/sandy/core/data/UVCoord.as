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

/**
 * A 2D coordinate point on a texture that corresponds to a vertex of a polygon.
 *
 * <p>The UVCoord represents the position of a vertex on the Bitmap used to &quot;dress&quot; a polygon.<br />
 * It is the 2D texture coordinate, used in the BitmapMaterial and VideoMaterial.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		Ported by FFlasher/Floris
 * @since		0.3
 * @version		2.0.2
 * @date 		24.08.2007
 *
 * @see http://en.wikipedia.org/wiki/UV_mapping
 */
 
class sandy.core.data.UVCoord
{
	
	/**
	 * The u coordinate.
	 */
	public var v:Number;

	/**
	 * The v coordinate.
	 */
	public var u:Number;

	/**
	* Creates a new UV coordinate.
	*
	* @param p_nU	Number the x texture position on the bitmap
	* @param p_nV	Number the y texture position on the bitmap.
	*/
	public function UVCoord( p_nU:Number, p_nV:Number )
	{
		u = p_nU||0;
		v = p_nV||0;
	}

	/**
	 * The length.
	 */
	public function length() : Number
	{
		return Math.sqrt( u * u + v * v );
	}
		
	/**
	 * Normalizes this UV coordinate.
	 *
	 * <p>A UV coordinate is normalized when its components are divided by its length.
	 * The length is calculated by <code>Math.sqrt( u*u + v*v )</code>.</p>
	 */
	public function normalize() : Void
	{
		var l_nLength:Number = Math.sqrt( u * u + v * v );
		u /= l_nLength;
		v /= l_nLength;
	}

	/**
	 * Subtracts the specified UV coordinate from this UV coordinate.
	 *
	 * @param p_oUV The UV coordinate to substract.
	 */ 
	public function sub( p_oUV:UVCoord ) : Void
	{
		u -= p_oUV.u;
		v -= p_oUV.v;
	}
	
	/**
	 * Adds the specified UV coordinate from this UV coordinate.
	 *
	 * @param p_oUV The UVCoord to add.
	 */ 
	public function add( p_oUV:UVCoord ) : Void
	{
		u += p_oUV.u;
		v += p_oUV.v;
	}

	/**
	 * Scales the texture coordinates by a factor.
	 *
	 * @param p_nFactor The factor.
	 */
	public function scale( p_nFactor:Number ) : Void
	{
		u *= p_nFactor;
		v *= p_nFactor;
	}
		
	/**
	 * Returns a string representation of this object.
	 *
	 * @return The fully qualified name of this object.
	 */
	public function toString() : String
	{
		return "sandy.core.data.UVCoord" + "(u:" + u + ", v:" + v + ")";
	}

	/**
	 * Returns a new UVCoord object that is a clone of the original instance. 
	 * 
	 * @return A new UVCoord object that is identical to the original. 
	 */	
	public function clone() : UVCoord
	{
		return new UVCoord( u , v );
	}
		
	/**
	 * Makes this UV coordinate a copy of the specified UV coordinate.
	 *
	 * <p>All components of the specified UV coordinate are copied to this UV coordinate.</p>
	 *
	 * @param p_oUV	The vertex to copy.
	 */
	public function copy( p_oUV:UVCoord ) : Void
	{
		u = p_oUV.u;
		v = p_oUV.v;
	}
	
}
