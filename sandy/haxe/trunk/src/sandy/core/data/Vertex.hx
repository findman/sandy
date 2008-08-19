/*
# ***** BEGIN LICENSE BLOCK *****
Sandy is a software supplied by Thomas PFEIFFER
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

package sandy.core.data;

import sandy.util.NumberUtil;

/**
 * A vertex of a 3D mesh or polygon.
 *
 * <p>A vertex is a point which can be represented in different coordinate systems.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 */
class Vertex
{
	private static var ID:Null<Int>;
	public var id:Null<Int>;

	public var x:Null<Float>;
	public var y:Null<Float>;
	public var z:Null<Float>;

	/**
	* properties used to store transformed positions in the World coordinates
	*/
	public var wx:Null<Float>;
	public var wy:Null<Float>;
	public var wz:Null<Float>;

	/**
	* properties used to store transformed coordinates in screen World.
	*/
	public var sx:Null<Float>;
	public var sy:Null<Float>;

	/**
	 * Float of polygons this vertex belongs to.
	 * <p>Default value is 0.</p>
	 */
	public var nbFaces:Null<Int>;

	/**
	 * An array of faces.
	 *
	 * <p>List of polygons that actually use that vertex</p>
	 */
	public var aFaces:Array<Dynamic>;

       /**
        *  State if that vertex has been projected or not. If not, we can consider that vertex to not be visible in the current rendering step.
        */
       
       public var projected:Null<Bool>;
	/**
	* Creates a new vertex.
	*
	* @param p_nx 	The x position
	* @param p_ny 	The y position
	* @param p_nz 	The z position
	* @param ...rest	optional values for wx, wy, wz
	*/
	public function new( ?p_nx:Null<Float>, ?p_ny:Null<Float>, ?p_nz:Null<Float>, ?restx, ?resty, ?restz )
	{
	 ID = 0;
		id = ID ++;
		nbFaces = 0;
		aFaces = new Array();
		m_oWorld = new Vector();

		p_nx = (p_nx != null)?p_nx:0;
		p_ny = (p_ny != null)?p_ny:0;
		p_nz = (p_nz != null)?p_nz:0;
		x = p_nx;
		y = p_ny;
		z = p_nz;
		// --
		wx = (restx != null)?restx:x;
		wy = (resty != null)?resty:y;
		wz = (restz != null)?restz:z;
		// --
		sy = sx = 0;
	}
	
	
	/**
	 * Returns the 2D position of this vertex.
	 * This 2D position is the position on the screen after the camera projection.
	 * WARNING: There's actually a third value (the z one) which correspond to the depth screen position.
	 * @return Vector The 2D position of this vertex once projected.
	 */
	public function getScreenPoint():Vector
	{
		return new Vector( sx, sy, wz );
	}

	/**
	* Returns the transformed vertex in world coordinates.
	*
	* @return
	*/
	public function getWorldVector():Vector
	{
		m_oWorld.x = wx;
		m_oWorld.y = wy;
		m_oWorld.z = wz;
		return m_oWorld;
	}

	/**
	 * Returns a vector representing the original x, y, z values.
	 *
	 * @return 	The vector
	 */
    public function getVector():Vector
    {
   		return new Vector( x, y, z );
    }

	/**
	 * Returns a clone of this vertex.
	 *
	 * @return 	The clone
	 */
	public function clone():Vertex
	{
	    var l_oV:Vertex = new Vertex( x, y, z );
	    l_oV.wx = wx;    l_oV.sx = sx;
	    l_oV.wy = wy;    l_oV.sy = sy;
	    l_oV.wz = wz;
	    l_oV.nbFaces = nbFaces;
	    //l_oV.aFaces = aFaces.concat();
	    l_oV.aFaces = aFaces.concat([]);
	    return l_oV;
	}

	/**
	 * Returns a new vertex build on the transformed values of this vertex.
	 *
	 * <p>A new vertex is created with this vertex's transformed coordinates as start position.<br />
	 * So ( x, y, z ) of the new vertex is the ( wx, wy, wz ) of this vertex.</p>
	 * <p>[<strong>ToDo</strong>: What can this one be used for? - Explain! ]</p>
	 *
	 * @return 	The new vertex
	 */
	public function clone2():Vertex
	{
	    return new Vertex( wx, wy, wz );
	}

	/**
	 * Creates and returns a new vertex from the specified vector.
	 *
	 * @param p_v	The vertex position vector
	 * @return 	The new vertex
	 */
	static public function createFromVector( p_v:Vector ):Vertex
	{
	    return new Vertex( p_v.x, p_v.y, p_v.z );
	}

	/**
	 * Is this vertex equal to the specified vertex?.
	 *
	 * <p>This vertex is compared to the argument vertex, component by component.<br />
	 * If all components of the two vertices are equal, a true value is returned.
	 *
	 * @return 	true if the vertices are considered equal, false otherwise
	 */
 	public function equals(p_vertex:Vertex):Null<Bool>
	{
		return ( p_vertex.x  ==  x && p_vertex.y  ==  y && p_vertex.z  ==  z &&
				p_vertex.wx == wx && p_vertex.wy == wy && p_vertex.wz == wz &&
				p_vertex.sx == wx && p_vertex.sy == sy);
	}

	/**
	 * Makes this vertex equal to the specified vertex.
	 *
	 * <p>All components of the argument vertex are copied to this vertex.</p>
	 *
	 * @param 	The vertex to copy to this
	 */
	public function copy( p_oVector:Vertex ):Void
	{
		x = p_oVector.x;
		y = p_oVector.y;
		z = p_oVector.z;
		wx = p_oVector.wx;
		wy = p_oVector.wy;
		wz = p_oVector.wz;
		sx = p_oVector.sx;
		sy = p_oVector.sy;
	}

	/**
	 * Returns the norm of this vertex.
	 *
	 * <p>The norm of the vertex is calculated as the length of its position vector.<br />
	 * That is sqrt( x*x + y*y + z*z )</p>
	 *
	 * @return 	The norm
	 */
	public function getNorm():Null<Float>
	{
		return Math.sqrt( x*x + y*y + z*z );
	}

	/**
	 * Return the invers of this vertex.
	 *
	 * <p>A new vertex is created with the negative of all values in this vertex.</p>
	 *
	 * @return 	The invers
	 */
	public function negate( /*v:Vertex*/ ): Void
	{
		// The argument is commented out, as it is not used - Petit
		x = -x;
		y = -y;
		z = -z;
		wx = -wx;
		wy = -wy;
		wz = -wz;
		//return new Vertex( -x, -y, -z, -wx, -wy, -wz);
	}

	/**
	 * Adds a specified vertex to this vertex.
	 *
	 * @param v 	The vertex to add to this vertex
	 */
	public function add( v:Vertex ):Void
	{
		x += v.x;
		y += v.y;
		z += v.z;

		wx += v.wx;
		wy += v.wy;
		wz += v.wz;
	}

	/**
	 * Substracts a specified vertex from this vertex.
	 *
	 * @param v 	The vertex to subtract from this vertex
	 */
	public function sub( v:Vertex ):Void
	{
		x -= v.x;
		y -= v.y;
		z -= v.z;
		wx -= v.wx;
		wy -= v.wy;
		wz -= v.wz;
	}

	/**
	 * Raises the vertex to the specified power.
	 *
	 * <p>All components of this vertex is raised to the power specified in the argument.</p>
	 *
	 * @param {@code pow} a {@code Float}.
	 */
	public function pow( pow:Null<Float> ):Void
	{
		x = Math.pow( x, pow );
       	y = Math.pow( y, pow );
       	z = Math.pow( z, pow );
       	wx = Math.pow( wx, pow );
       	wy = Math.pow( wy, pow );
       	wz = Math.pow( wz, pow );
	}

	/**
	 * Multiplies this vertex by the specified scalar value.
	 *
	 * <p>All components of the vertex are multiplied by the specified value</p>
	 *
	 * @param n 	The number to multiply with
	 */
	public function scale( n:Null<Float> ):Void
	{
		x *= n;
		y *= n;
		z *= n;
		wx *= n;
		wy *= n;
		wz *= n;
	}

	/**
	 * Returns the dot product between this vertex and a specified vertex.
	 *
	 * <p>Only the original positions values are used for this dot product.</p>
	 *
	 * @param w 	The vertex to make a dot product with
	 * @return 	The dot product
	 */
	public function dot( w: Vertex):Null<Float>
	{
		return ( x * w.x + y * w.y + z * w.z );
	}

	/**
	 * Returns the cross product between this vertex and the specified vertex.
	 *
	 * <p>Only the original positions values are used for this cross product.</p>
	 *
	 * @param v 	The vertex to make a cross product with
	 * @return 	the resulting vertex of the cross product.
	 */
	public function cross( v:Vertex):Vertex
	{
		// cross product vector that will be returned
        	// calculate the components of the cross product
		return new Vertex( 	(y * v.z) - (z * v.y) ,
                            (z * v.x) - (x * v.z) ,
                            (x * v.y) - (y * v.x) );
	}

	/**
	 * Normalizes this vertex.
	 *
	 * <p>Normalization means that all components of the vertex are divided by its norm.<br />
	 * The norm is calculated as the sqrt(x*x + y*y + z*z), that is the length of the position vector.</p>
	 */
	public function normalize():Void
	{
		// -- We get the norm of the vector
		var norm:Null<Float> = getNorm();
		// -- We escape the process is norm is null or equal to 1
		if( norm == 0 || norm == 1) return;
		x /= norm;
		y /= norm;
		z /= norm;

		wx /= norm;
		wy /= norm;
		wz /= norm;
	}

	/**
	 * Returns the angle between this vertex and the specified vertex.
	 *
	 * @param w	The vertex making an angle with this one
	 * @return 	The angle in radians
	 */
	public function getAngle ( w:Vertex ):Null<Float>
	{
		var ncos:Null<Float> = dot( w ) / ( getNorm() * w.getNorm() );
		var sin2:Null<Float> = 1 - ncos * ncos;
		if (sin2<0)
		{
			trace(" wrong "+ncos);
			sin2 = 0;
		}
		//I took long time to find this bug. Who can guess that (1-cos*cos) is negative ?!
		//sqrt returns a NaN for a negative value !
		return  Math.atan2( Math.sqrt(sin2), ncos );
	}


	/**
	 * Returns a string representing this vertex.
	 *
	 * @param decPlaces	Float of decimals
	 * @return	The representation
	 */
	public function toString(?decPlaces:Null<Float>):String
	{
		decPlaces = (decPlaces != null)?decPlaces:0;

		if (decPlaces == 0)
		{
			decPlaces = 0.01;
		}
		// Round display to two decimals places
		// Returns "{x, y, z}"
		return "{" + 	NumberUtil.roundTo(x, decPlaces) + ", " +
				NumberUtil.roundTo(y, decPlaces) + ", " +
				NumberUtil.roundTo(z, decPlaces) + ", " +
				NumberUtil.roundTo(wx, decPlaces) + ", " +
				NumberUtil.roundTo(wy, decPlaces) + ", " +
				NumberUtil.roundTo(wz, decPlaces) + ", " +
				NumberUtil.roundTo(sx, decPlaces) + ", " +
				NumberUtil.roundTo(sy, decPlaces) + "}";
	}


	// Useful for XML output
	/**
	 * Returns a string representation of this vertex with rounded values.
	 *
	 * <p>[<strong>ToDo</strong>: Explain why this is good for XML output! ]</p>
	 *
	 * @param decPlaces	Float of decimals
	 * @return 		The specific serialize string
	 */
	public function serialize(?decPlaces:Null<Float>):String
	{
		decPlaces = (decPlaces != null)?decPlaces:0;

		if (decPlaces == 0)
		{
			decPlaces = .01;
		}
		//returns x,y,x
		return  (NumberUtil.roundTo(x, decPlaces) + "," +
				 NumberUtil.roundTo(y, decPlaces) + "," +
				 NumberUtil.roundTo(z, decPlaces) + "," +
				 NumberUtil.roundTo(wx, decPlaces) + "," +
				 NumberUtil.roundTo(wy, decPlaces) + "," +
				 NumberUtil.roundTo(wz, decPlaces) + "," +
				 NumberUtil.roundTo(sx, decPlaces) + "," +
				 NumberUtil.roundTo(sy, decPlaces));
	}

	// Useful for XML output
	/**
	 * Sets the elements of this vertex from a string representation.
	 *
	 * <p>[<strong>ToDo</strong>: Explain why this is good for XML intput! ]</p>
	 *
	 * @param 	A string representing the vertex ( specific serialize format )
	 */
	public function deserialize(convertFrom:String):Void
	{
		var tmp:Array<String> = convertFrom.split(",");
		if (tmp.length != 9)
		{
			trace ("Unexpected length of string to deserialize into a vector " + convertFrom);
		}

		x = Std.parseFloat(tmp[0]);
		y = Std.parseFloat(tmp[1]);
		z = Std.parseFloat(tmp[2]);

		wx = Std.parseFloat(tmp[3]);
		wy = Std.parseFloat(tmp[4]);
		wz = Std.parseFloat(tmp[5]);

		sx = Std.parseFloat(tmp[6]);
		sy = Std.parseFloat(tmp[7]);
	}
	
	private var m_oWorld:Vector;
}

