package sandy.extrusion.data 
{
	import sandy.core.data.Matrix4;
	import sandy.core.data.Vector;
	
	/**
	* Specifies a curve in 3D space.
	* @author makc
	*/
	public class Curve3D 
	{
		/**
		 * Array of points that curve passes through.
		 */
		public var v:Array;

		/**
		 * Array of tangent unit vectors at curve points.
		 */
		public var t:Array;

		/**
		 * Array of normal unit vectors at curve points.
		 */
		public var n:Array;

		/**
		 * Array of binormal unit vectors at curve points. Set to null in order to re-calculate it from t and n.
		 * @see http://en.wikipedia.org/wiki/Frenet-Serret_frame
		 */
		public function get b ():Array {
			if (_b == null) b = null; return _b;
		}

		public function set b (arg:Array):void {
			if (arg != null) {
				_b = arg;
			} else if ((t != null) && (n != null)) {
				_b = []; var i:int, N:int = Math.min (t.length, n.length);
				for (i = 0; i < N; i++) {
					_b [i] = Vector (t [i]).cross (Vector (n [i]));
				}
			}
		}

		private var _b:Array;

		/**
		 * Array of scalar values at curve points. toSections method uses
		 * these values to scale crossections.
		 */
		public var s:Array;

		/**
		 * Computes matrices to use this curve as extrusion path.
		 * @param stabilize whether to flip normals after inflection points.
		 * @return array of Matrix4 objects.
		 * @see Extrusion
		 */
		public function toSections (stabilize:Boolean = true):Array {
			if ((t == null) || (n == null)) return null;

			var sections:Array = [], i:int, N:int = Math.min (t.length, n.length), m1:Matrix4, m2:Matrix4 = new Matrix4;
			var normal:Vector = new Vector, binormal:Vector = new Vector;
			for (i = 0; i < N; i++) {
				normal.copy (n [i]); binormal.copy (b [i]);
				if (stabilize && (i > 0)) {
					if (Vector (n [i - 1]).dot (normal) * Vector (t [i - 1]).dot (t [i]) < 0) {
						normal.scale ( -1); binormal.scale ( -1);
					}
				}
				m1 = new Matrix4; m1.fromVectors (normal, binormal, t [i], v [i]);
				m2.scale (s [i], s [i], s [i]); m1.multiply (m2);
				sections [i] = m1;
			}
			return sections;
		}

		/**
		 * Return vector perpendicular to vector and as close to hint as possible.
		 * @param	vector
		 * @param	hint
		 * @return
		 */
		protected function orthogonalize (vector:Vector, hint:Vector):Vector {
			var w:Vector = vector.cross (hint); w.crossWith (vector); return w;
		}

	}
	
}