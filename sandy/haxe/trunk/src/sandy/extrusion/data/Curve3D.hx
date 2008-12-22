package sandy.extrusion.data;

import sandy.core.data.Matrix4;
import sandy.core.data.Vector;

/**
* Specifies a curve in 3D space.
* @author makc
* @author pedromoraes (haxe port)
*/
class Curve3D 
{
	/**
	 * Array of points that curve passes through.
	 */
	public var v:Array<Vector>;

	/**
	 * Array of tangent unit Point3Ds at curve points.
	 */
	public var t:Array<Vector>;

	/**
	 * Array of normal unit Point3Ds at curve points.
	 */
	public var n:Array<Vector>;

	/**
	 * Array of binormal unit Point3Ds at curve points. Set to null in order to re-calculate it from t and n.
	 * @see http://en.wikipedia.org/wiki/Frenet-Serret_frame
	 */
	public var b(getB,setB):Array<Vector>;
	private function getB():Array<Vector> {
		if (_b == null) b = null; return _b;
	}

	private function setB(arg:Array<Vector>):Array<Vector> {
		if (arg != null) {
			_b = arg;
		} else if ((t != null) && (n != null)) {
			_b = []; var i:Int;var N:Int = Std.int( Math.min (t.length, n.length) );
			for ( i in 0 ... N ) {
				_b [i] = t[i].cross (n[i]);
			}
		}
		return arg;
	}

	private var _b:Array<Vector>;

	/**
	 * Array of scalar values at curve points. toSections method uses
	 * these values to scale crossections.
	 */
	public var s:Array<Float>;

	/**
	 * Computes matrices to use this curve as extrusion path.
	 * @param stabilize whether to flip normals after inflection points.
	 * @return array of Matrix4 objects.
	 * @see Extrusion
	 */
	public function toSections (?stabilize:Bool = true):Array<Matrix4> {
		if ((t == null) || (n == null)) return null;

		var sections:Array<Matrix4> = [];
		var i:Int;
		var N:Int = Std.int( Math.min(t.length, n.length) );
		var m1:Matrix4;
		var m2:Matrix4 = new Matrix4();
		var normal:Vector = new Vector();
		var binormal:Vector = new Vector();
		for ( i in 0 ... N ) {
			normal.copy (n [i]); binormal.copy (b [i]);
			if (stabilize && (i > 0)) {
				if ( n[i - 1].dot (normal) * t[i - 1].dot (t [i]) < 0 ) {
					normal.scale ( -1); binormal.scale ( -1);
				}
			}
			m1 = new Matrix4(); m1.fromVectors(normal, binormal, t [i], v [i]);
			m2.scale (s [i], s [i], s [i]); m1.multiply (m2);
			sections [i] = m1;
		}
		return sections;
	}

	/**
	 * Return Vector perpendicular to Vector and as close to hint as possible.
	 * @param	Vector
	 * @param	hint
	 * @return
	 */
	private function orthogonalize (p_oPoint:Vector, hint:Vector):Vector {
		var w:Vector = p_oPoint.cross (hint); w.crossWith (p_oPoint); return w;
	}

	/**
	 * Creates empty Curve3D object.
	 */
	public function new () {
		v = []; t = []; n = []; s = [];
	}

}