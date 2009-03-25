
package sandy.core.data;

import sandy.util.NumberUtil;

import sandy.HaxeTypes;

/**
* The Quaternion class is experimental and not used in this version.
*
* <p>It is not used at the moment in the library, but should becomes very usefull soon.<br />
* It should be stable but any kind of comments/note about it will be appreciated.</p>
*
* <p>[<strong>ToDo</strong>: Check the use of and comment this class ]</p>
*
* @author		Thomas Pfeiffer - kiroukou
* @author		Russell Weir
* @author		Niel Drummond - haXe port
* @since		0.3
* @version		3.1
* @date 		24.08.2007
**/
class Quaternion
{
	public var x:Float;
	public var y:Float;
	public var z:Float;
	public var w:Float;

	/**
	* Creates a quaternion.
	*
	* <p>[<strong>ToDo</strong>: What's all this here? ]</p>
	*/
	public function new( ?px : Float, ?py : Float, ?pz : Float, ?pw:Float )
	{
		if ( px == null ) px = 0.0;
		if ( py == null ) px = 0.0;
		if ( pz == null ) px = 0.0;
		if ( pw == null ) pw = 0.0;

		x = px;
		y = py;
		z = pz;
		w = pw;
	}

	/**
	* Returns a copy of this Quaternion
	*
	**/
	public function clone() : Quaternion {
		return new Quaternion(x, y, z, w);
	}

	/**
	* Calculate the dot product of this and another Quaternion
	* @param q Second Quaternion
	* @return Float dot product
	**/
	public function dotProduct(q : Quaternion) : Float {
		return ( x * q.x) + (y * q.y) + (z * q.z) + (w * q.w);
	}

	/**
	* Conjugates this Quaternion. This negates the vector part of the Quaternion.
	*/
	public function conjugate() : Void
	{
		x = -x;
		y = -y;
		z = -z;
	}

	/**
	* Tests if this Quaternion is equal to another
	* @param q Quaternion to compare to
	* @return True if Quaternions are equal
	**/
	public function equal( q:Quaternion ):Bool
	{
		return ( x == q.x && y == q.y && z == q.z && w == q.w );
	}

	/**
	* Returns the conjugate of this Quaternion
	*
	* @return The conjugate
	*/
	public function getConjugate() : Quaternion
	{
		return new Quaternion( -x, -y, -z, w );
	}

	public function getRotationMatrix():Matrix4
	{
		var xx:Float, yy:Float, zz:Float, xy:Float, xz:Float;
		var xw:Float, yz:Float, yw:Float, zw:Float;

		xx = x*x;
		xy = x*y;
		xz = x*z;
		xw = x*w;
		yy = y*y;
		yz = y*z;
		yw = y*w;
		zz = z*z;
		zw = z*w;

		var m:Matrix4 = new Matrix4();

		m.n11  = 1 - 2 * ( yy + zz );
		m.n12  =     2 * ( xy + zw );
		m.n13  =     2 * ( xz - yw );

		m.n21  =     2 * ( xy - zw );
		m.n22  = 1 - 2 * ( xx + zz );
		m.n23  =     2 * ( yz + xw );

		m.n31  =     2 * ( xz + yw );
		m.n32  =     2 * ( yz - xw );
		m.n33  = 1 - 2 * ( xx + yy );

		return m;
	}

	/**
	* The magnitude of this Quaternion
	*
	* @return The magnitude
	*/
	public function magnitude() : Float
	{
		return Math.sqrt ( w*w + x*x + y*y + z*z );
	}

	/**
	* Normalizes this Quaternion
	*
	**/
	public function normalize():Void
	{
		var m:Float = magnitude();
		x /= m;
		y /= m;
		z /= m;
		w /= m;
	}

	/**
	* Set the Quaternion from a euler angle rotation
	*
	**/
	public function setByEuler(euler:Point3D) : Void {
		var hx = NumberUtil.toRadian(euler.x) / 2.0;
		var hy = NumberUtil.toRadian(euler.y) / 2.0;
		var hz = NumberUtil.toRadian(euler.z) / 2.0;

		var cx = Math.cos(hx);
		var cy = Math.cos(hy);
		var cz = Math.cos(hz);

		var sx = Math.sin(hx);
		var sy = Math.sin(hy);
		var sz = Math.sin(hz);

		var sycz = sy * cz;
		var cycz = cy * cz;
		var sysz = sy * sz;
		var cysz = cy * sz;

		x = (sx * cycz) - (cx * sysz);
		y = (cx * sycz) + (sx * cysz);
		z = (cx * cysz) - (sx * sycz);
		w = (cx * cycz) + (sx * sysz);

		normalize();
	}

	/**
	* Sets the value of the Quaternion from a rotation matrix
	* @param m Rotation matrix
	**/
	public function setByMatrix( m:Matrix4 ) : Void
	{
		var t:Float = m.getTrace();
		var m0:Float = m.n11; var m5:Float = m.n22; var m10:Float = m.n33;
		var s:Float;
		if( t > 0.0000001 )
		{
			s = Math.sqrt( t ) * 2 ;
			x = ( m.n23 - m.n32 ) / s ;
			y = ( m.n31 - m.n13 ) / s ;
			z = ( m.n12 - m.n21 ) / s ;
			w = 0.25 * s ;
		}
		else if( m0 > m5 && m0 > m10 )
		{
			s = Math.sqrt( 1 + m0 - m5 - m10 ) * 2 ;
			x = 0.25 * s ;
			y = ( m.n12 + m.n21 ) / s ;
			z = ( m.n31 + m.n13 ) / s ;
			w = ( m.n23 - m.n32 ) / s ;
		}
		else if( m5 > m10 )
		{
			s = Math.sqrt( 1 + m5 - m0 - m10 ) * 2 ;
			y = 0.25 * s ;
			x = ( m.n12 + m.n21 ) / s ;
			w = ( m.n31 - m.n13 ) / s ;
			z = ( m.n23 + m.n32 ) / s ;
		}
		else
		{
			s = Math.sqrt( 1 + m10 - m5 - m0 ) * 2 ;
			z = 0.25 * s ;
			w = ( m.n12 - m.n21 ) / s ;
			x = ( m.n31 + m.n13 ) / s ;
			y = ( m.n23 + m.n32 ) / s ;
		}
		normalize();
	}


	/**
	* Returns a string representing this quaternion.
	*
	* @return	The string representatation
	*/
	public function toString():String
	{
		var s:String = "sandy.core.data.Quaternion";
		s += "(x:"+x+" , y:"+y+", z:"+z+" w:"+w + ")";
		return s;
	}


	/**
	* Creates a new Quaternion from a rotation matrix
	* @param m Rotation matrix
	* @return New Quaternion instance
	**/
	public static function ofMatrix( m:Matrix4 ) : Quaternion {
		var q = new Quaternion();
		q.setByMatrix( m );
		return q;
	}

	/**
	* Sperical Linear interpolation between a start and end Quaternion.
	*
	* @param startQ Beginning Quaternion
	* @param endQ Ending Quaternion
	* @param fraction Range from 0.0 to 1.0
	*
	**/
	public static function slerp(startQ:Quaternion, endQ:Quaternion, fraction:Float) : Quaternion
	{
		if(fraction <= 0.)
			return startQ.clone();
		if(fraction >= 1.)
			return endQ.clone();

		var ct:Float = startQ.dotProduct( endQ );
		var c1 = 1.0 - fraction;
		var c2 = fraction;

		var sign : Float = 1.;
		if(ct < 0.) {
			ct = -ct;
			sign = -1.;
		}

		if( (1. - ct) > 0.01) {
			var theta = Math.acos(ct);
			var st = Math.sin(theta);
			c1 = Math.sin(c1 * theta) / st;
			c2 = Math.sin(c2 * theta) / st;
		}

		c1 = sign * c1;
		var q = new Quaternion(
				(c1 * startQ.x) + (c2 * endQ.x),
				(c1 * startQ.y) + (c2 * endQ.y),
				(c1 * startQ.z) + (c2 * endQ.z),
				(c1 * startQ.w) + (c2 * endQ.w)
			);
		q.normalize();
		return q;
	}
}

