// This class is generated from haxe branch r1141, with flash.Boot references manually commented out
// and haxe types imported from sandy.core.data.haxe
package sandy.parser {
	import sandy.animation.IKeyFramed;
	import sandy.parser.ParserEvent;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.ByteArray;
	import sandy.core.scenegraph.TagCollection;
	import sandy.util.DataOrder;
	//import flash.Boot;
	import sandy.core.data.haxe.*;
	import sandy.animation.Tag;
	import sandy.primitive.KeyFramedShape3D;
	import sandy.parser.IParser;
	import sandy.util.LoaderQueue;
	import sandy.core.scenegraph.Node;
	import flash.utils.Endian;
	import sandy.primitive.MD3;
	import sandy.core.scenegraph.KeyFramedTransformGroup;
	import sandy.materials.Appearance;
	import sandy.materials.BitmapMaterial;
	import flash.events.Event;
	import sandy.parser.AParser;
	public class MD3Parser extends sandy.parser.AParser implements sandy.parser.IParser{
		public function MD3Parser(p_sUrl : * = null,p_sDefaultName : String = null,p_oTextureData : sandy.util.LoaderQueue = null,p_nScale : Number = 1.0,p_sTextureExtension : String = null) : void { //if( !flash.Boot.skip_constructor ) {
			this.m_eDataOrder = defaultOrientation;
			this.m_sDefaultName = p_sDefaultName;
			super(p_sUrl,p_nScale,p_sTextureExtension);
			this.m_sDataFormat = flash.net.URLLoaderDataFormat.BINARY;
			this.m_oTextureQueue = p_oTextureData;
		}//}
		
		protected var m_eDataOrder : sandy.util.DataOrder;
		protected var m_oTextureQueue : sandy.util.LoaderQueue;
		protected var m_sDefaultName : String;
		protected override function parseData(e : flash.events.Event = null) : void {
			super.parseData(e);
			var data : flash.utils.ByteArray = ByteArray(this.m_oFile);
			data.endian = flash.utils.Endian.LITTLE_ENDIAN;
			data.position = 0;
			var event : sandy.parser.ParserEvent = new sandy.parser.ParserEvent(sandy.parser.ParserEvent.PARSING);
			event.percent = 80;
			this.dispatchEvent(event);
			this.ident = data.readInt();
			this.version = data.readInt();
			if(this.ident != 860898377 || this.version != 15) throw "Error loading MD3 file: Not a valid MD3 file/bad version";
			var fname : String = sandy.primitive.KeyFramedShape3D.readCString(data,64);
			if(this.m_sDefaultName != null) this.name = this.m_sDefaultName;
			else this.name = fname;
			var flags : int = data.readInt();
			this.num_frames = data.readInt();
			this.num_tags = data.readInt();
			this.num_surfaces = data.readInt();
			this.num_skins = data.readInt();
			this.offset_frames = data.readInt();
			this.offset_tags = data.readInt();
			this.offset_surfaces = data.readInt();
			this.offset_end = data.readInt();
			data.position = this.offset_frames;
			this.frames = new Hash();
			{
				var _g1 : int = 0, _g : int = this.num_frames;
				while(_g1 < _g) {
					var i : int = _g1++;
					var minx : Number = data.readFloat();
					var miny : Number = data.readFloat();
					var minz : Number = data.readFloat();
					var maxx : Number = data.readFloat();
					var maxy : Number = data.readFloat();
					var maxz : Number = data.readFloat();
					var originX : Number = data.readFloat();
					var originY : Number = data.readFloat();
					var originZ : Number = data.readFloat();
					var bSpherRadius : Number = data.readFloat();
					var name : String = sandy.primitive.KeyFramedShape3D.readCString(data,16);
					this.frames.set(name,i);
				}
			}
			var tg : sandy.core.scenegraph.KeyFramedTransformGroup = new sandy.core.scenegraph.KeyFramedTransformGroup(this.name);
			this.m_oGroup.addChild(tg);
			if(this.num_tags > 0) {
				data.position = this.offset_tags;
				var tags : Hash = sandy.animation.Tag.read(data,this.num_frames,this.num_tags,this.m_eDataOrder);
				tg.addChild(new sandy.core.scenegraph.TagCollection(null,tags));
			}
			if(this.num_surfaces > 0) {
				data.position = this.offset_surfaces;
				{
					var _g12 : int = 0, _g2 : int = this.num_surfaces;
					while(_g12 < _g2) {
						var i2 : int = _g12++;
						var md3 : sandy.primitive.MD3 = new sandy.primitive.MD3((this.name.length > 0?this.name:null),ByteArray(this.m_oFile),this.m_nScale);
						if(md3.__getFrameCount() != this.num_frames) throw "Error loading MD3 file: Frame count mismatch loading surface " + Std.string(i2) + ". Expected " + this.num_frames + " got " + md3.__getFrameCount();
						if(md3.name != null && this.m_oTextureQueue != null && (this.m_oTextureQueue.data [md3.name] != undefined/*this.m_oTextureQueue.data.exists(md3.name)*/)) {
							try {
								var mat : sandy.materials.BitmapMaterial = new sandy.materials.BitmapMaterial(this.m_oTextureQueue.data[md3.name]["bitmapData"]/*Reflect.field(this.m_oTextureQueue.data.get(md3.name),"bitmapData")*/);
								md3.appearance = new Appearance(mat); //md3.__setAppearance(new sandy.materials.Appearance(mat));
							}
							catch( e1 : * ){
								md3.appearance = this.m_oStandardAppearance; //md3.__setAppearance(this.m_oStandardAppearance);
								md3.visible = false; //md3.__setVisible(false);
							}
						}
						else {
							md3.appearance = this.m_oStandardAppearance; //md3.__setAppearance(this.m_oStandardAppearance);
							md3.visible = false; //md3.__setVisible(false);
						}
						md3.__setFrame(0);
						tg.addChild(md3);
						var event1 : sandy.parser.ParserEvent = new sandy.parser.ParserEvent(sandy.parser.ParserEvent.PARSING);
						event1.percent = 80 + Std._int((i2 * 1.) / this.num_surfaces * 20.);
						this.dispatchEvent(event1);
					}
				}
			}
			{
				var _g3 : int = 0, _g13 : Array = tg.children;
				while(_g3 < _g13.length) {
					var c : sandy.core.scenegraph.Node = _g13[_g3];
					++_g3;
					IKeyFramed(c)/*(function($this:MD3Parser) : sandy.animation.IKeyFramed {
						var $r : sandy.animation.IKeyFramed;
						var tmp : sandy.core.scenegraph.Node = c;
						$r = (Std._is(tmp,sandy.animation.IKeyFramed)?tmp:function($this:MD3Parser) : sandy.core.scenegraph.Node {
							var $r2 : sandy.core.scenegraph.Node;
							throw "Class cast error";
							return $r2;
						}($this));
						return $r;
					})(this)*/.__setFrame(0);
				}
			}
			this.dispatchInitEvent();
		}
		
		protected var ident : int;
		protected var version : int;
		protected var name : String;
		protected var num_frames : int;
		protected var num_tags : int;
		protected var num_surfaces : int;
		protected var num_skins : int;
		protected var offset_frames : int;
		protected var offset_tags : int;
		protected var offset_surfaces : int;
		protected var offset_end : int;
		protected var frames : Hash;
		static public var defaultOrientation : sandy.util.DataOrder = sandy.util.DataOrder.DATA_MD3;
	}
}
