// This class is generated from haxe branch r1141, with flash.Boot references manually commented out
// and haxe types imported from sandy.core.data.haxe
package sandy.animation {
	import sandy.core.data.Quaternion;
	import sandy.math.QuaternionMath;
	import sandy.core.data.Matrix4;
	import sandy.util.DataOrder;
	import sandy.core.data.Point3D;
	import sandy.util.DataConverter;
	import sandy.primitive.KeyFramedShape3D;
	//import flash.Boot;
	import sandy.core.data.haxe.*;
	import flash.utils.ByteArray;
	public class Tag {
		public function Tag(p_sName : String = "",p_oOrigin : sandy.core.data.Point3D = null,p_oMatrix : sandy.core.data.Matrix4 = null) : void { //if( !flash.Boot.skip_constructor ) {
			this.name = p_sName;
			this.origin = (p_oOrigin == null?new sandy.core.data.Point3D():p_oOrigin.clone());
			this.__setMatrix((p_oMatrix == null?new sandy.core.data.Matrix4():p_oMatrix.clone()));
		}//}
		
		public var name : String;
		public var origin : sandy.core.data.Point3D;
		public function get matrix() : sandy.core.data.Matrix4 { return __getMatrix(); }
		public function set matrix( __v : sandy.core.data.Matrix4 ) : void { __setMatrix(__v); }
		protected var $matrix : sandy.core.data.Matrix4;
		public function get quaternion() : sandy.core.data.Quaternion { return __getQuaternion(); }
		protected var $quaternion : sandy.core.data.Quaternion;
		public function clone() : sandy.animation.Tag {
			return new sandy.animation.Tag(this.name,this.origin.clone(),this.__getMatrix().clone());
		}
		
		public function __getMatrix() : sandy.core.data.Matrix4 {
			return this.m_oMatrix;
		}
		
		public function __setMatrix(v : sandy.core.data.Matrix4) : sandy.core.data.Matrix4 {
			this.m_oQuat = sandy.math.QuaternionMath.setByMatrix(v);
			return this.m_oMatrix = v;
		}
		
		public function __getQuaternion() : sandy.core.data.Quaternion {
			return this.m_oQuat;
		}
		
		public function toString() : String {
			return "sandy.primitive.Tag" + " [" + this.name + "] origin: " + Std.string(this.origin) + " rotation: " + Std.string(this.__getMatrix());
		}
		
		protected var m_oMatrix : sandy.core.data.Matrix4;
		protected var m_oQuat : sandy.core.data.Quaternion;
		static public function read(data : flash.utils.ByteArray,numFrames : int,numTags : int,dataOrder : sandy.util.DataOrder) : Hash {
			var tags : Hash = new Hash();
			{
				var _g : int = 0;
				while(_g < numFrames) {
					var f : int = _g++;
					{
						var _g1 : int = 0;
						while(_g1 < numTags) {
							var i : int = _g1++;
							var td : sandy.animation.Tag = new sandy.animation.Tag(sandy.primitive.KeyFramedShape3D.readCString(data,64));
							var origin : sandy.core.data.Point3D = new sandy.core.data.Point3D();
							origin.x = data.readFloat();
							origin.y = data.readFloat();
							origin.z = data.readFloat();
							td.origin = sandy.util.DataConverter.point3DToSandy(origin,dataOrder);
							var matrix : sandy.core.data.Matrix4 = new sandy.core.data.Matrix4();
							matrix.n11 = data.readFloat();
							matrix.n12 = data.readFloat();
							matrix.n13 = data.readFloat();
							matrix.n21 = data.readFloat();
							matrix.n22 = data.readFloat();
							matrix.n23 = data.readFloat();
							matrix.n31 = data.readFloat();
							matrix.n32 = data.readFloat();
							matrix.n33 = data.readFloat();
							td.__setMatrix(sandy.util.DataConverter.rotationMatrix3x3ToSandy(matrix,dataOrder));
							if(!tags.exists(td.name)) tags.set(td.name,new Array());
							tags.get(td.name).push(td);
						}
					}
				}
			}
			return tags;
		}
		
	}
}
