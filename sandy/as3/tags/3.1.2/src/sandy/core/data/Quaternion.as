
package sandy.core.data
{
	import sandy.core.data.Matrix4;
	import sandy.core.data.Point3D;
	import sandy.util.NumberUtil;
	/**
	 * The Quaternion class is experimental and not used in this version.
	 *
	 * <p>It is not used at the moment in the library, but should becomes very usefull soon.<br />
	 * It should be stable but any kind of comments/note about it will be appreciated.</p>
	 *
	 * @internal updated to haxe version (added Russell Weir as an author :)
	 *
	 * @author		Thomas Pfeiffer - kiroukou
	 * @author		Russell Weir
	 * @since		0.3
	 * @version		3.1
	 * @date 		24.08.2007
	 **/
	public class Quaternion
	{
		public var x:Number;
		public var y:Number;
		public var z:Number;
		public var w:Number;

		/**
		 * Creates a quaternion.
		 *
		 * <p>[<strong>ToDo</strong>: What's all this here? ]</p>
		 */
		public function Quaternion( px : Number = 0, py : Number = 0, pz : Number = 0, pw:Number = 0 )
		{
			x = px;
			y = py;
			z = pz;
			w = pw;
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

		// haxe code below (isn't it funny how as3 had this class at all?)

		public function get length() : Number { return magnitude(); }
		protected var $length : Number;
		public function add(q2 : sandy.core.data.Quaternion) : void {
			this.x = this.x + q2.x;
			this.y = this.y + q2.y;
			this.z = this.z + q2.z;
			this.w = this.w + q2.w;
		}
		
		public function clone() : sandy.core.data.Quaternion {
			return new sandy.core.data.Quaternion(this.x,this.y,this.z,this.w);
		}
		
		public function conjugate() : void {
			this.x = -this.x;
			this.y = -this.y;
			this.z = -this.z;
		}
		
		public function divide(q2 : sandy.core.data.Quaternion) : void {
			var d : sandy.core.data.Quaternion = q2.clone();
			d.x = -d.x;
			d.y = -d.y;
			d.z = -d.z;
			var r : sandy.core.data.Quaternion = this.clone();
			r.multiplyAsLeft(d);
			d.multiplyAsRight(d);
			this.x = r.x / d.w;
			this.y = r.y / d.w;
			this.z = r.z / d.w;
			this.w = r.w / d.w;
		}
		
		public function dotProduct(q : sandy.core.data.Quaternion) : Number {
			return (this.x * q.x) + (this.y * q.y) + (this.z * q.z) + (this.w * q.w);
		}
		
		public function equal(q : sandy.core.data.Quaternion) : Boolean {
			return (this.x == q.x && this.y == q.y && this.z == q.z && this.w == q.w);
		}
		
		public function getAxisAngle() : * {
			var ar : * = this.getAxisRadians();
			return { axis : ar.axis, angle : sandy.util.NumberUtil.toDegree(ar.radians)}
		}
		
		public function getAxises() : Array {
			var a : Array = new Array();
			var p : sandy.core.data.Point3D = new sandy.core.data.Point3D();
			p.x = 1;
			p.y = 0;
			p.z = 0;
			a[0] = this.multiplyVector(p);
			p.x = 0;
			p.y = 1;
			p.z = 0;
			a[1] = this.multiplyVector(p);
			p.x = 0;
			p.y = 0;
			p.z = 1;
			a[2] = this.multiplyVector(p);
			return (a);
		}
		
		public function getAxisRadians() : * {
			var l_pAxis : sandy.core.data.Point3D = new sandy.core.data.Point3D();
			var l_fRads : Number = 0.;
			var len : Number = this.x * this.x + this.y * this.y + this.z * this.z;
			if(len > 0.0000001) {
				var t : Number = 1. / len;
				l_pAxis.x = this.x * t;
				l_pAxis.y = this.y * t;
				l_pAxis.z = this.z * t;
				l_fRads = 2. * Math.acos(this.w);
			}
			else {
				l_pAxis.x = 0.;
				l_pAxis.y = 0.;
				l_pAxis.z = 1.;
			}
			return { axis : l_pAxis, radians : l_fRads}
		}
		
		public function getEuler() : sandy.core.data.Point3D {
			var sqw : Number = this.w * this.w;
			var sqx : Number = this.x * this.x;
			var sqy : Number = this.y * this.y;
			var sqz : Number = this.z * this.z;
			var atan2 : Function = Math.atan2;
			var euler : sandy.core.data.Point3D = new sandy.core.data.Point3D();
			euler.z = sandy.util.NumberUtil.toDegree(atan2(2 * (this.x * this.y + this.z * this.w),(sqx - sqy - sqz + sqw)));
			euler.x = sandy.util.NumberUtil.toDegree(atan2(2 * (this.y * this.z + this.x * this.w),(-sqx - sqy + sqz + sqw)));
			euler.y = sandy.util.NumberUtil.toDegree(Math.asin(-2 * (this.x * this.z - this.y * this.w)));
			return euler;
		}
		
		public function getConjugate() : sandy.core.data.Quaternion {
			return new sandy.core.data.Quaternion(-this.x,-this.y,-this.z,this.w);
		}
		
		public function getInverse() : sandy.core.data.Quaternion {
			var q : sandy.core.data.Quaternion = this.clone();
			q.invert();
			return q;
		}
		
		public function getNorm() : Number {
			return this.x * this.x + this.y * this.y + this.z * this.z + this.w * this.w;
		}
		
		public function getPitch() : Number {
			return Math.atan2(2. * (this.y * this.z + this.x * this.w),this.w * this.w - this.x * this.x - this.y * this.y + this.z * this.z);
		}
		
		public function getRoll() : Number {
			return Math.atan2(2. * (this.x * this.y + this.z * this.w),this.w * this.w + this.x * this.x - this.y * this.y - this.z * this.z);
		}
		
		public function getRotationMatrix() : sandy.core.data.Matrix4 {
			var dx : Number = this.x * 2.;
			var dy : Number = this.y * 2.;
			var dz : Number = this.z * 2.;
			var dxw : Number = dx * this.w;
			var dyw : Number = dy * this.w;
			var dzw : Number = dz * this.w;
			var dxx : Number = dx * this.x;
			var dyx : Number = dy * this.x;
			var dzx : Number = dz * this.x;
			var dyy : Number = dy * this.y;
			var dzy : Number = dz * this.y;
			var dzz : Number = dz * this.z;
			var m : sandy.core.data.Matrix4 = new sandy.core.data.Matrix4();
			m.n11 = 1.0 - (dyy + dzz);
			m.n12 = dyx + dzw;
			m.n13 = dzx - dyw;
			m.n21 = dyx - dzw;
			m.n22 = 1.0 - (dxx + dzz);
			m.n23 = dzy + dxw;
			m.n31 = dzx + dyw;
			m.n32 = dzy - dxw;
			m.n33 = 1.0 - (dxx + dyy);
			return m;
		}
		
		public function getXAxis() : sandy.core.data.Point3D {
			var dy : Number = this.y * 2.;
			var dz : Number = this.z * 2.;
			return new sandy.core.data.Point3D(1.0 - (dy * this.y + dz * this.z),dy * this.x + dz * this.w,dz * this.x - dy * this.w);
		}
		
		public function getYaw() : Number {
			return Math.asin(-2. * (this.x * this.z - this.y * this.w));
		}
		
		public function getYAxis() : sandy.core.data.Point3D {
			var dx : Number = this.x * 2.;
			var dy : Number = this.y * 2.;
			var dz : Number = this.z * 2.;
			return new sandy.core.data.Point3D(dy * this.x - dz * this.w,1.0 - (dx * this.x + dz * this.z),dz * this.y + dx * this.w);
		}
		
		public function getZAxis() : sandy.core.data.Point3D {
			var dx : Number = this.x * 2.;
			var dy : Number = this.y * 2.;
			var dz : Number = this.z * 2.;
			return new sandy.core.data.Point3D(dz * this.x + dy * this.w,dz * this.y - dx * this.w,1.0 - (dx * this.x + dy * this.y));
		}
		
		public function identity() : void {
			this.x = 0.;
			this.y = 0.;
			this.z = 0.;
			this.w = 1.;
		}
		
		public function identityAddition() : void {
			this.x = 0.;
			this.y = 0.;
			this.z = 0.;
			this.w = 0.;
		}
		
		public function invert() : void {
			var n : Number = this.x * this.x + this.y * this.y + this.z * this.z + this.w * this.w;
			if(n == 0.) return;
			this.x = this.x / n;
			this.y = this.y / n;
			this.z = this.z / n;
			this.w = this.w / n;
		}
		
		public function magnitude() : Number {
			return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z + this.w * this.w);
		}
		
		public function multiplyAsRight(lq : sandy.core.data.Quaternion) : void {
			if(lq == this) lq = lq.clone();
			var x1 : Number = this.x;
			var y1 : Number = this.y;
			var z1 : Number = this.z;
			var w1 : Number = this.w;
			this.x = lq.w * x1 + lq.x * w1 + lq.y * z1 - lq.z * y1;
			this.y = lq.w * y1 + lq.y * w1 + lq.z * x1 - lq.x * z1;
			this.z = lq.w * z1 + lq.z * w1 + lq.x * y1 - lq.y * x1;
			this.w = lq.w * w1 - lq.x * x1 - lq.y * y1 - lq.z * z1;
		}
		
		public function multiplyAsLeft(rq : sandy.core.data.Quaternion) : void {
			if(rq == this) rq = rq.clone();
			var x1 : Number = this.x;
			var y1 : Number = this.y;
			var z1 : Number = this.z;
			var w1 : Number = this.w;
			this.x = w1 * rq.x + x1 * rq.w + y1 * rq.z - z1 * rq.y;
			this.y = w1 * rq.y + y1 * rq.w + z1 * rq.x - x1 * rq.z;
			this.z = w1 * rq.z + z1 * rq.w + x1 * rq.y - y1 * rq.x;
			this.w = w1 * rq.w - x1 * rq.x - y1 * rq.y - z1 * rq.z;
		}
		
		public function multiplyVector(v : sandy.core.data.Point3D) : sandy.core.data.Point3D {
			return new sandy.core.data.Point3D(this.x * v.x * -this.x,this.y * v.y * -this.y,this.z * v.z * -this.z);
		}
		
		public function normalize() : void {
			var len : Number = Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z + this.w * this.w);
			if(len == 0) return;
			this.x /= len;
			this.y /= len;
			this.z /= len;
			this.w /= len;
		}
		
		public function scale(v : Number) : void {
			var aa : * = this.getAxisAngle();
			this.setAxisAngle(aa.axis,aa.angle * v);
		}
		
		public function setAxisAngle(axis : sandy.core.data.Point3D,angle : Number) : void {
			this.setAxisRadians(axis,sandy.util.NumberUtil.toRadian(angle));
		}
		
		public function setAxisRadians(axis : sandy.core.data.Point3D,radians : Number) : void {
			axis.normalize();
			var hr : Number = radians / 2.;
			var s : Number = Math.sin(hr);
			this.x = s * axis.x;
			this.y = s * axis.y;
			this.z = s * axis.z;
			this.w = Math.cos(hr);
		}
		
		public function setByEuler(euler : sandy.core.data.Point3D) : void {
			var sin : Function = Math.sin;
			var cos : Function = Math.cos;
			var hx : Number = sandy.util.NumberUtil.toRadian(euler.x) / 2.0;
			var hy : Number = sandy.util.NumberUtil.toRadian(euler.y) / 2.0;
			var hz : Number = sandy.util.NumberUtil.toRadian(euler.z) / 2.0;
			var cx : Number = cos(hx);
			var cy : Number = cos(hy);
			var cz : Number = cos(hz);
			var sx : Number = sin(hx);
			var sy : Number = sin(hy);
			var sz : Number = sin(hz);
			var sycz : Number = sy * cz;
			var cycz : Number = cy * cz;
			var sysz : Number = sy * sz;
			var cysz : Number = cy * sz;
			this.x = (sx * cycz) - (cx * sysz);
			this.y = (cx * sycz) + (sx * cysz);
			this.z = (cx * cysz) - (sx * sycz);
			this.w = (cx * cycz) + (sx * sysz);
			this.normalize();
		}
		
		public function setByMatrix(m : sandy.core.data.Matrix4) : void {
			var t : Number = m.getTrace();
			var m0 : Number = m.n11;
			var m5 : Number = m.n22;
			var m10 : Number = m.n33;
			var s : Number;
			if(t > 0.0000001) {
				s = Math.sqrt(t) * 2;
				this.x = (m.n23 - m.n32) / s;
				this.y = (m.n31 - m.n13) / s;
				this.z = (m.n12 - m.n21) / s;
				this.w = 0.25 * s;
			}
			else if(m0 > m5 && m0 > m10) {
				s = Math.sqrt(1 + m0 - m5 - m10) * 2;
				this.x = 0.25 * s;
				this.y = (m.n12 + m.n21) / s;
				this.z = (m.n31 + m.n13) / s;
				this.w = (m.n23 - m.n32) / s;
			}
			else if(m5 > m10) {
				s = Math.sqrt(1 + m5 - m0 - m10) * 2;
				this.y = 0.25 * s;
				this.x = (m.n12 + m.n21) / s;
				this.w = (m.n31 - m.n13) / s;
				this.z = (m.n23 + m.n32) / s;
			}
			else {
				s = Math.sqrt(1 + m10 - m5 - m0) * 2;
				this.z = 0.25 * s;
				this.w = (m.n12 - m.n21) / s;
				this.x = (m.n31 + m.n13) / s;
				this.y = (m.n23 + m.n32) / s;
			}
			this.normalize();
		}
		
		public function subtract(q2 : sandy.core.data.Quaternion) : void {
			this.x = this.x - q2.x;
			this.y = this.y - q2.y;
			this.z = this.z - q2.z;
			this.w = this.w - q2.w;
		}
		
		static public function multiply(lq : sandy.core.data.Quaternion,rq : sandy.core.data.Quaternion) : sandy.core.data.Quaternion {
			return new sandy.core.data.Quaternion(lq.w * rq.x + lq.x * rq.w + lq.y * rq.z - lq.z * rq.y,lq.w * rq.y + lq.y * rq.w + lq.z * rq.x - lq.x * rq.z,lq.w * rq.z + lq.z * rq.w + lq.x * rq.y - lq.y * rq.x,lq.w * rq.w - lq.x * rq.x - lq.y * rq.y - lq.z * rq.z);
		}
		
		static public function ofAxisAngle(axis : sandy.core.data.Point3D,angle : Number) : sandy.core.data.Quaternion {
			var q : sandy.core.data.Quaternion = new sandy.core.data.Quaternion();
			q.setAxisRadians(axis,sandy.util.NumberUtil.toRadian(angle));
			return q;
		}
		
		static public function ofAxisRadians(axis : sandy.core.data.Point3D,radians : Number) : sandy.core.data.Quaternion {
			var q : sandy.core.data.Quaternion = new sandy.core.data.Quaternion();
			q.setAxisRadians(axis,radians);
			return q;
		}
		
		static public function ofEuler(euler : sandy.core.data.Point3D) : sandy.core.data.Quaternion {
			var q : sandy.core.data.Quaternion = new sandy.core.data.Quaternion();
			q.setByEuler(euler);
			return q;
		}
		
		static public function ofMatrix(m : sandy.core.data.Matrix4) : sandy.core.data.Quaternion {
			var q : sandy.core.data.Quaternion = new sandy.core.data.Quaternion();
			q.setByMatrix(m);
			return q;
		}
		
		static public function slerp(startQ : sandy.core.data.Quaternion,endQ : sandy.core.data.Quaternion,fraction : Number) : sandy.core.data.Quaternion {
			if(fraction <= 0.) return startQ.clone();
			if(fraction >= 1.) return endQ.clone();
			var ct : Number = startQ.dotProduct(endQ);
			var c1 : Number = 1.0 - fraction;
			var c2 : Number = fraction;
			var sign : Number = 1.;
			if(ct < 0.) {
				ct = -ct;
				sign = -1.;
			}
			if((1. - ct) > 0.0000001) {
				var theta : Number = Math.acos(ct);
				var st : Number = Math.sin(theta);
				c1 = Math.sin(c1 * theta) / st;
				c2 = Math.sin(c2 * theta) / st;
			}
			c1 = sign * c1;
			var q : sandy.core.data.Quaternion = new sandy.core.data.Quaternion((c1 * startQ.x) + (c2 * endQ.x),(c1 * startQ.y) + (c2 * endQ.y),(c1 * startQ.z) + (c2 * endQ.z),(c1 * startQ.w) + (c2 * endQ.w));
			q.normalize();
			return q;
		}
		
		static public function lerp(startQ : sandy.core.data.Quaternion,endQ : sandy.core.data.Quaternion,fraction : Number) : sandy.core.data.Quaternion {
			if(fraction <= 0.) return startQ.clone();
			if(fraction >= 1.) return endQ.clone();
			var c1 : Number = 1.0 - fraction;
			var c2 : Number = fraction;
			if(startQ.dotProduct(endQ) < 0.) c1 = -1. * c1;
			var q : sandy.core.data.Quaternion = new sandy.core.data.Quaternion((c1 * startQ.x) + (c2 * endQ.x),(c1 * startQ.y) + (c2 * endQ.y),(c1 * startQ.z) + (c2 * endQ.z),(c1 * startQ.w) + (c2 * endQ.w));
			q.normalize();
			return q;
		}
	}
}