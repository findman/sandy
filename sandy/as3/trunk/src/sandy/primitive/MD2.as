// This class is generated from haxe branch r1141, with flash.Boot references manually commented out
package sandy.primitive {
	import sandy.core.data.UVCoord;
	import sandy.core.data.Point3D;
	import sandy.core.scenegraph.Geometry3D;
	import flash.utils.Endian;
	//import flash.Boot;
	import sandy.materials.Appearance;
	import sandy.primitive.KeyFramedShape3D;
	import flash.utils.ByteArray;
	public class MD2 extends sandy.primitive.KeyFramedShape3D {
		public function MD2(p_sName : String = "",data : flash.utils.ByteArray = null,scale : Number = 1.0,p_oAppearance : sandy.materials.Appearance = null,p_bUseSingleContainer : Boolean = true) : void { //if( !flash.Boot.skip_constructor ) {
			super(p_sName,data,scale,p_oAppearance,p_bUseSingleContainer);
		}//}
		
		public override function generate(... arguments/*arguments : Array = null*/) : sandy.core.scenegraph.Geometry3D {
			var i : int, j : int, char : int;
			var uvs : Array = [];
			var mesh : sandy.core.scenegraph.Geometry3D = new sandy.core.scenegraph.Geometry3D();
			var data : flash.utils.ByteArray = arguments[0];
			data.endian = flash.utils.Endian.LITTLE_ENDIAN;
			data.position = 0;
			this.ident = data.readInt();
			this.version = data.readInt();
			if(this.ident != 844121161 || this.version != 8) throw "Error loading MD2 file: Not a valid MD2 file/bad version";
			this.skinwidth = data.readInt();
			this.skinheight = data.readInt();
			this.framesize = data.readInt();
			this.num_skins = data.readInt();
			this.num_vertices = data.readInt();
			this.num_st = data.readInt();
			this.num_tris = data.readInt();
			this.num_glcmds = data.readInt();
			this.num_frames = data.readInt();
			this.offset_skins = data.readInt();
			this.offset_st = data.readInt();
			this.offset_tris = data.readInt();
			this.offset_frames = data.readInt();
			this.offset_glcmds = data.readInt();
			this.offset_end = data.readInt();
			data.position = this.offset_skins;
			this.texture = "";
			{
				var _g : int = 0;
				while(_g < 64) {
					var i1 : int = _g++;
					char = data.readUnsignedByte();
					if(char == 0) break;
					else this.texture += String.fromCharCode(char);
				}
			}
			data.position = this.offset_st;
			{
				var _g1 : int = 0, _g2 : int = this.num_st;
				while(_g1 < _g2) {
					var i12 : int = _g1++;
					uvs.push(new sandy.core.data.UVCoord(data.readShort() / this.skinwidth,data.readShort() / this.skinheight));
				}
			}
			data.position = this.offset_tris;
			var j1 : int = 0;
			{
				var _g12 : int = 0, _g3 : int = this.num_tris;
				while(_g12 < _g3) {
					var i13 : int = _g12++;
					var a : int = data.readUnsignedShort();
					var b : int = data.readUnsignedShort();
					var c : int = data.readUnsignedShort();
					var ta : int = data.readUnsignedShort();
					var tb : int = data.readUnsignedShort();
					var tc : int = data.readUnsignedShort();
					mesh.setVertex(a,1,0,0);
					mesh.setVertex(b,0,1,0);
					mesh.setVertex(c,0,0,1);
					mesh.setUVCoords(j1,uvs[ta].u,uvs[ta].v);
					mesh.setUVCoords(j1 + 1,uvs[tb].u,uvs[tb].v);
					mesh.setUVCoords(j1 + 2,uvs[tc].u,uvs[tc].v);
					mesh.setFaceVertexIds(i13,[a,b,c]);
					mesh.setFaceUVCoordsIds(i13,[j1,j1 + 1,j1 + 2]);
					j1 += 3;
				}
			}
			{
				var _g13 : int = 0, _g4 : int = this.num_frames;
				while(_g13 < _g4) {
					var i14 : int = _g13++;
					var sx : Number = data.readFloat();
					var sy : Number = data.readFloat();
					var sz : Number = data.readFloat();
					var tx : Number = data.readFloat();
					var ty : Number = data.readFloat();
					var tz : Number = data.readFloat();
					var name : String = "", wasNotZero : Boolean = true;
					{
						var _g22 : int = 0;
						while(_g22 < 16) {
							var j2 : int = _g22++;
							char = data.readUnsignedByte();
							wasNotZero = wasNotZero && (char != 0);
							if(wasNotZero) name += String.fromCharCode(char);
						}
					}
					this.frames.set(name,i14);
					var vi : Array = new Array();
					this.vertices[i14] = vi;
					{
						var _g32 : int = 0, _g23 : int = this.num_vertices;
						while(_g32 < _g23) {
							var j22 : int = _g32++;
							var vec : sandy.core.data.Point3D = new sandy.core.data.Point3D();
							vec.x = ((sx * data.readUnsignedByte()) + tx) * this.scaling;
							vec.z = ((sy * data.readUnsignedByte()) + ty) * this.scaling;
							vec.y = ((sz * data.readUnsignedByte()) + tz) * this.scaling;
							vi[j22] = vec;
							data.readUnsignedByte();
						}
					}
				}
			}
			return mesh;
		}
		
		protected var ident : int;
		protected var version : int;
		protected var skinwidth : int;
		protected var skinheight : int;
		protected var framesize : int;
		protected var num_skins : int;
		protected var num_st : int;
		protected var num_tris : int;
		protected var num_glcmds : int;
		protected var offset_skins : int;
		protected var offset_st : int;
		protected var offset_tris : int;
		protected var offset_frames : int;
		protected var offset_glcmds : int;
		protected var offset_end : int;
		protected var texture : String;
		public function get textureFileName() : String { return __getTextureFileName(); }
		protected var $textureFileName : String;
		public function __getTextureFileName() : String {
			return this.texture;
		}
		
	}
}
