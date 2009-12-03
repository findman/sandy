package sandy.util {
	import sandy.math.QuaternionMath;
	import sandy.core.data.Matrix4;
	import sandy.core.data.Quaternion;
	import sandy.util.DataOrder;
	import sandy.core.data.Point3D;
	public class DataConverter {
		static public function rotationMatrix3x3ToSandy(matrix : sandy.core.data.Matrix4,dataOrder : sandy.util.DataOrder) : sandy.core.data.Matrix4 {
			//{
				var $e : DataOrder/*enum*/ = (dataOrder);
				switch( $e.index ) {
				case 0:
				{
					return matrix;
				}break;
				case 1:
				{
					var nm : sandy.core.data.Matrix4 = new sandy.core.data.Matrix4();
					nm.n33 = matrix.n11;
					nm.n31 = matrix.n12;
					nm.n32 = matrix.n13;
					nm.n13 = matrix.n21;
					nm.n11 = matrix.n22;
					nm.n12 = matrix.n23;
					nm.n23 = matrix.n31;
					nm.n21 = matrix.n32;
					nm.n22 = matrix.n33;
					var q : sandy.core.data.Quaternion = sandy.math.QuaternionMath.setByMatrix(nm);
					q.x *= -1;
					nm = sandy.math.QuaternionMath.getRotationMatrix(q);
					return nm;
				}break;
				}
			//}
			return null;
		}
		
		static public function point3DToSandy(point : sandy.core.data.Point3D,dataOrder : sandy.util.DataOrder) : sandy.core.data.Point3D {
			//{
				var $e : DataOrder/*enum*/ = (dataOrder);
				switch( $e.index ) {
				case 0:
				{
					return point;
				}break;
				case 1:
				{
					var p : sandy.core.data.Point3D = new sandy.core.data.Point3D();
					p.x = point.y;
					p.y = point.z;
					p.z = point.x;
					return p;
				}break;
				}
			//}
			return null;
		}
		
	}
}
