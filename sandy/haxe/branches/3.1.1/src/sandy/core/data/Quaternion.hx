
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

	/** The length, or magnitude, of the Quaternion **/
	public var length(magnitude,null) : Float;

	/**
	* Creates a quaternion.
	*
	* @param px X component of the vector
	* @param py Y component of the vector
	* @param pz Z component of the vector
	* @param pw Scalar component
	*/
	public function new( px : Float=0., py : Float=0., pz : Float=0., pw:Float=1. )
	{
		x = px;
		y = py;
		z = pz;
		w = pw;
	}

	/**
	 * Adds a passed in Quaternion to this Quaternion. The result is normalized.
	 *
	 * @param q2 	Quaternion to add to this Quaternion.
	 */
	public function add( q2 : Quaternion ) : Void {
		x = x + q2.x;
		y = y + q2.y;
		z = z + q2.z;
		w = w + q2.w;

		normalize();
	}

	/**
	* Returns a copy of this Quaternion
	*
	**/
	public function clone() : Quaternion {
		return new Quaternion(x, y, z, w);
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
	 * Divides this Quaternion by a passed in Quaternion.
	 *
	 * @param q2 	Quaternion to divide this Quaternion by.
	 */
	public function divide( q2 : Quaternion ) {
		var d = q2.clone();
		// invert vector
		d.x = -d.x;
		d.y = -d.y;
		d.z = -d.z;

		var r = this.clone();
		r.multiply(d);
		d.multiply(d);

		x = r.x / d.w;
		y = r.y / d.w;
		z = r.z / d.w;
		w = r.w / d.w;
	}

	/**
	* Calculate the dot product of this and another Quaternion
	*
	* @param q Second Quaternion
	* @return Float dot product
	**/
	public function dotProduct(q : Quaternion) : Float {
		return (x * q.x) + (y * q.y) + (z * q.z) + (w * q.w);
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

	/*
	* Gets the axis and angle of this Quaternion
	*
	* @return Object with axis and an angle in degrees
	*/
	public function getAxisAngle() : { axis : Point3D, angle : Float }
	{
		var ar = getAxisRadians();
		return {
			axis : ar.axis,
			angle : NumberUtil.toDegree(ar.radians),
		};
	}

	/**
	* Returns the translation of the axises to world axises
	**/
	public function getAxises() : TypedArray<Point3D> {
		var a = new TypedArray(#if flash10 3 #end);
		var p = new Point3D();
		p.x = 1; p.y = 0; p.z = 0;
		a[0] = multiplyVector(p);
		p.x = 0; p.y = 1; p.z = 0;
		a[1] = multiplyVector(p);
		p.x = 0; p.y = 0; p.z = 1;
		a[2] = multiplyVector(p);
		return( a );
	}

	/*
	* Gets the axis and angle of this Quaternion
	*
	* @return Object with axis and an angle in degrees
	*/
	public function getAxisRadians() : { axis : Point3D, radians : Float }
	{
		var l_pAxis : Point3D  = new Point3D();
		var l_fRads : Float = 0.;
		var len = x * x + y * y + z * z;

		if(len > 0.0000001) {
			var t = 1. / len;
			l_pAxis.x = x * t;
			l_pAxis.y = y * t;
			l_pAxis.z = z * t;
			l_fRads = 2. * Math.acos(w);
		}
		else {
			l_pAxis.x = 0.;
			l_pAxis.y = 0.;
			l_pAxis.z = 1.;
		}
		return {
			axis : l_pAxis,
			radians : l_fRads,
		};
	}

	/**
	* Returns a Euler angles representing this Quaternion.
	* @return Euler (pitch,yaw,roll)
	**/
	public function getEuler():Point3D
	{
		var sqw:Float = w*w;
		var sqx:Float = x*x;
		var sqy:Float = y*y;
		var sqz:Float = z*z;
		var atan2 = Math.atan2;
		var euler:Point3D = new Point3D();
		// roll = rotaton about z-axis
		euler.z = NumberUtil.toDegree(atan2(2 * (x*y + z*w), (sqx - sqy - sqz + sqw) ));
		// pitch = rotation about x-axis
		euler.x = NumberUtil.toDegree(atan2(2 * (y*z + x*w), (-sqx - sqy + sqz + sqw) ));
		// yaw = rotation about y-axis
		euler.y = NumberUtil.toDegree(Math.asin(-2 * (x*z - y*w)));

		return euler ;
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

	/**
	* Returns the pitch in radians
	*/
	public function getPitch() : Float
	{
		return Math.atan2(2.*(y*z + x*w), w*w - x*x - y*y + z*z);
	}

	/**
	* Returns the roll in radians
	*/
	public function getRoll(v:Int=1) : Float
	{
		return Math.atan2(2.*(x*y + z*w), w*w + x*x - y*y - z*z);
	}

	/**
	* Returns the 3x3 rotation matrix of this Quaternion
	*/
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

		m.n11  = 1. - 2. * ( yy + zz );
		m.n12  =      2. * ( xy + zw );
		m.n13  =      2. * ( xz - yw );

		m.n21  =      2. * ( xy - zw );
		m.n22  = 1. - 2. * ( xx + zz );
		m.n23  =      2. * ( yz + xw );

		m.n31  =      2. * ( xz + yw );
		m.n32  =      2. * ( yz - xw );
		m.n33  = 1. - 2. * ( xx + yy );

		return m;
	}

	/**
	* Returns translation to world of the local X axis vector
	**/
	public function getXAxis() : Point3D
	{
		var dy  = y*2.;
		var dz  = z*2.;
		return new Point3D(1.0 - (dy*y+dz*z), dy*x+dz*w, dz*x-dy*w);
	}

	/**
	* Returns the Yaw (pan) in Radians
	*/
	public function getYaw() : Float {
		return Math.asin( -2.*(x*z - y*w));
	}

	/**
	* Returns translation to world of the local Y axis vector
	**/
	public function getYAxis() : Point3D
	{
		var dx  = x*2.;
		var dy  = y*2.;
		var dz  = z*2.;

		return new Point3D(dy*x-dz*w, 1.0-(dx*x+dz*z), dz*y+dx*w);
	}

	/**
	* Returns translation to world of the local Z axis vector
	**/
	public function getZAxis() : Point3D
	{
		var dx  = x*2.;
		var dy  = y*2.;
		var dz  = z*2.;
		return new Point3D(dz*x+dy*w, dz*y-dx*w, 1.0 - (dx*x+dy*y));
	}

	/**
	* Sets this Quaternion to the multiplication identity. Quaternions have two identities,
	* one for addition and one for multiplication.
	*/
	public function identity() : Void {
		x = 0.;
		y = 0.;
		z = 0.;
		w = 1.;
	}

	/**
	* Sets this Quaternion to the addition identity. Quaternions have two identities,
	* one for addition and one for multiplication.
	*/
	public function identityAddition() : Void {
		x = 0.;
		y = 0.;
		z = 0.;
		w = 0.;
	}

	/**
	* Inverts the rotation
	*/
	public function inverse() : Void {
		var n : Float = x * x + y * y + z * z + w * w;
		if(n == 0.) return;
		x = x / n;
		y = y / n;
		z = z / n;
		w = w / n;
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
	* Multiplies this Quaternion with another, modifying this Quaternion. Quaternion
	* multiplication is not cummutative, so beware of order.
	*
	* @param q Other Quaternion
	**/
	public function multiply(q : Quaternion) : Void {
		var lq = if( q == this ) q.clone() else q;
		x = w * lq.x + x * lq.w + y * lq.z - z * lq.y;
		y = w * lq.y + y * lq.w + z * lq.x - x * lq.z;
		z = w * lq.z + z * lq.w + x * lq.y - y * lq.x;
		w = w * lq.w - x * lq.x - y * lq.y - z * lq.z;
	}

	public function multiplyVector( v : Point3D ) : Point3D {
		var q1 = new Point3D(x, y, z);
		var q2 = q1.cross(v);
		var q3 = q1.cross(q2);
		q2.scale(w*2.);
		q3.scale(2.);
		q3.add(q2);
		q3.add(v);
		return q3;
	}

	/**
	* Normalizes this Quaternion
	*
	**/
	public function normalize():Void
	{
		var m:Float = magnitude();
		if(m == 0) return;
		x /= m;
		y /= m;
		z /= m;
		w /= m;
	}

	/**
	* Scales the rotation angle of this Quaternion
	*
	* @param v Scaling value
	**/
	public function scale( v : Float ) {
		var aa = getAxisAngle();
		setAxisAngle(aa.axis, aa.angle * v);
	}

	/**
	* Sets the value of this Quaternion from an axis and angle.
	*
	* @param angle Angle in degrees
	**/
	public function setAxisAngle( axis:Point3D, angle:Float ) : Void
	{
		setAxisRadians(axis, NumberUtil.toRadian(angle));
	}

	/**
	* Sets the value of this Quaternion from an axis and angle.
	*
	* @param angle Angle in degrees
	**/
	public function setAxisRadians( axis:Point3D, radians:Float ) : Void
	{
		axis.normalize();
		var hr = radians / 2.;
		var s = Math.sin(hr);
		x = s*axis.x;
		y = s*axis.y;
		z = s*axis.z;
		w = TRIG.cos(hr);
		normalize();
	}

	/**
	* Set the Quaternion from a euler angle rotation
	*
	**/
	public function setByEuler(euler:Point3D) : Void {
		var sin = TRIG.sin;
		var cos = TRIG.cos;

		var hx = NumberUtil.toRadian(euler.x) / 2.0;
		var hy = NumberUtil.toRadian(euler.y) / 2.0;
		var hz = NumberUtil.toRadian(euler.z) / 2.0;

		var cx = cos(hx);
		var cy = cos(hy);
		var cz = cos(hz);

		var sx = sin(hx);
		var sy = sin(hy);
		var sz = sin(hz);

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
	 * Subtracts a passed in Quaternion from this Quaternion. The result is normalized.
	 *
	 * @param q2 	Quaternion to subtract from this Quaternion.
	 */
	public function subtract( q2 : Quaternion ) : Void {
		x = x - q2.x;
		y = y - q2.y;
		z = z - q2.z;
		w = w - q2.w;

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
	* Creates a new Quaternion from an axis and an angle in degrees
	* @param euler A point3d representing a an axis
	* @param angle Rotation angle in degrees
	* @return A new Quaternion
	**/
	public static inline function ofAxisAngle( axis:Point3D, angle:Float  ) : Quaternion {
		var q = new Quaternion();
		q.setAxisRadians(axis, NumberUtil.toRadian(angle));
		return q;
	}

	/**
	* Creates a new Quaternion from an axis and an angle in radians
	* @param euler A point3d representing an axis
	* @param radians Rotation angle in radians
	* @return A new Quaternion
	**/
	public static inline function ofAxisRadians( axis:Point3D, radians:Float  ) : Quaternion {
		var q = new Quaternion();
		q.setAxisRadians(axis, radians);
		return q;
	}

	/**
	* Creates a new Quaternion from a euler rotation
	* @param euler A point3d representing a euler rotation
	* @return A new Quaternion
	**/
	public static inline function ofEuler( euler : Point3D ) : Quaternion {
		var q = new Quaternion();
		q.setByEuler(euler);
		return q;
	}

	/**
	* Creates a new Quaternion from a rotation matrix
	* @param m Rotation matrix
	* @return New Quaternion instance
	**/
	public static inline function ofMatrix( m:Matrix4 ) : Quaternion {
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
	* @return normalized intermediate Quaternion
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

		if( (1. - ct) > 0.0000001 ) {
			var theta = Math.acos(ct);
			var st = TRIG.sin(theta);
			c1 = TRIG.sin(c1 * theta) / st;
			c2 = TRIG.sin(c2 * theta) / st;
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

	/**
	* Linear interpolation between a start and end Quaternion. Slightly faster, but
	* less accurate, than slerp.
	*
	* @param startQ Beginning Quaternion
	* @param endQ Ending Quaternion
	* @param fraction Range from 0.0 to 1.0
	* @return normalized intermediate Quaternion
	**/
	public static function lerp(startQ:Quaternion, endQ:Quaternion, fraction:Float) : Quaternion
	{
		if(fraction <= 0.)
			return startQ.clone();
		if(fraction >= 1.)
			return endQ.clone();

		var c1 = 1.0 - fraction;
		var c2 = fraction;

		if(startQ.dotProduct( endQ ) < 0.)
			c1 = -1. * c1;

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

