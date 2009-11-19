// This class is generated from haxe branch r1141, with flash.Boot references manually commented out
// and haxe types imported from sandy.core.data.haxe
package sandy.primitive {
	import sandy.core.data.UVCoord;
	import sandy.core.data.Point3D;
	import sandy.core.scenegraph.Geometry3D;
	import flash.utils.Endian;
	//import flash.Boot;
	import sandy.core.data.haxe.*;
	import sandy.materials.Appearance;
	import sandy.primitive.Primitive3D;
	import sandy.primitive.KeyFramedShape3D;
	import flash.utils.ByteArray;
	public class MD3 extends sandy.primitive.KeyFramedShape3D implements sandy.primitive.Primitive3D{
		public function MD3(p_sName : String = "",data : flash.utils.ByteArray = null,scale : Number = 1.0,p_oAppearance : sandy.materials.Appearance = null,p_bUseSingleContainer : Boolean = true) : void { //if( !flash.Boot.skip_constructor ) {
			super(p_sName,data,scale,p_oAppearance,p_bUseSingleContainer);
		}//}
		
		public override function generate(... arguments/*arguments : Array = null*/) : sandy.core.scenegraph.Geometry3D {
			var uvs : Array = [];
			var mesh : sandy.core.scenegraph.Geometry3D = new sandy.core.scenegraph.Geometry3D();
			var data : flash.utils.ByteArray = null;
			try {
				data = function($this:MD3) : flash.utils.ByteArray {
					var $r : flash.utils.ByteArray;
					var tmp : * = arguments[0];
					$r = (Std._is(tmp,flash.utils.ByteArray)?tmp:function($this:MD3) : * {
						var $r2 : *;
						throw "Class cast error";
						return $r2;
					}($this));
					return $r;
				}(this);
			}
			catch( e : * ){
				return mesh;
			}
			var offset_begin : uint = data.position;
			data.endian = flash.utils.Endian.LITTLE_ENDIAN;
			var ident : int = data.readInt();
			if(ident != 860898377) throw "Error loading MD3 file: Magic number error loading surface. " + Std.string(ident);
			this.name = sandy.primitive.KeyFramedShape3D.readCString(data,64);
			var flags : int = data.readInt();
			this.num_frames = data.readInt();
			var num_shaders : int = data.readInt();
			this.num_vertices = data.readInt();
			var num_tris : int = data.readInt();
			var offset_tris : int = data.readInt();
			var offset_shaders : int = data.readInt();
			var offset_st : int = data.readInt();
			var offset_verts : int = data.readInt();
			var offset_surface_end : int = data.readInt();
			data.position = offset_st + offset_begin;
			uvs = new Array();
			{
				var _g1 : int = 0, _g : int = this.num_vertices;
				while(_g1 < _g) {
					var i : int = _g1++;
					uvs.push(new sandy.core.data.UVCoord(data.readFloat(),data.readFloat()));
					mesh.setUVCoords(i,uvs[i].u,uvs[i].v);
				}
			}
			data.position = offset_verts + offset_begin;
			var ts : Number = 1.0 / 64 * this.scaling;
			{
				var _g12 : int = 0, _g2 : int = this.num_frames;
				while(_g12 < _g2) {
					var f : int = _g12++;
					var va : Array = new Array();
					{
						var _g3 : int = 0, _g22 : int = this.num_vertices;
						while(_g3 < _g22) {
							var i2 : int = _g3++;
							var p : sandy.core.data.Point3D = new sandy.core.data.Point3D();
							p.z = -data.readShort() * ts;
							p.x = data.readShort() * ts;
							p.y = data.readShort() * ts;
							va[i2] = p;
							var lat : uint = data.readUnsignedByte();
							var lon : uint = data.readUnsignedByte();
						}
					}
					this.vertices[f] = va;
				}
			}
			data.position = offset_tris + offset_begin;
			{
				var _g4 : int = 0;
				while(_g4 < num_tris) {
					var i3 : int = _g4++;
					var a : int = data.readInt();
					var c : int = data.readInt();
					var b : int = data.readInt();
					mesh.setVertex(a,1,0,0);
					mesh.setVertex(b,0,1,0);
					mesh.setVertex(c,0,0,1);
					mesh.setFaceVertexIds(i3,[a,b,c]);
					mesh.setFaceUVCoordsIds(i3,[a,b,c]);
				}
			}
			data.position = offset_begin + offset_surface_end;
			return mesh;
		}
		
		static public var MAGIC : int = 860898377;
		static public var VERSION : int = 15;
		static public var MAX_QPATH : int = 64;
		static public var MAX_FRAMES : int = 1024;
		static public var MAX_TAGS : int = 16;
		static public var MAX_SURFACES : int = 32;
		static public var MAX_SHADERS : int = 256;
		static public var MAX_VERTS : int = 4096;
		static public var MAX_TRIANGLES : int = 8192;
		static public var XYZ_SCALE : Number = 1.0 / 64;
		static public var ANIMATIONS_PLAYER : Array = ["Death 1","Dead 1","Death 2","Dead 2","Death 3","Dead 3","Gesture","Shoot","Hit","Drop Weapon","Raise Weapon","Stand With Weapon","Stand","Crouched Walk","Walk","Run","Backpedal","Swim","Jump Forward","Land Forward","Jump Backward","Land Backward","Stand Idle","Crouched Idle","Turn"];
		static public var ANIMATIONS_PLAYER_TYPES : Array = ["both","both","both","both","both","both","torso","torso","torso","torso","torso","torso","torso","legs","legs","legs","legs","legs","legs","legs","legs","legs","legs","legs","legs"];
	}
}
