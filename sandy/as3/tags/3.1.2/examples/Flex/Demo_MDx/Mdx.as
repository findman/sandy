package  {
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import sandy.core.Scene3D;
	import sandy.core.scenegraph.Camera3D;
	import sandy.core.scenegraph.Group;
	import sandy.core.scenegraph.KeyFramedTransformGroup;
	import sandy.events.QueueEvent;
	import sandy.materials.Appearance;
	import sandy.materials.BitmapMaterial;
	import sandy.parser.MD2Parser;
	import sandy.parser.MD3Parser;
	import sandy.parser.ParserEvent;
	import sandy.primitive.MD2;
	import sandy.primitive.MD3;
	import sandy.primitive.Sphere;
	import sandy.util.LoaderQueue;
	public class Mdx extends Sprite {
		public function Mdx () {
			[Embed(source='Archvile.md2',mimeType='application/octet-stream')]
			var MD2Model:Class;
			[Embed(source='Archvile.jpg')]
			var MD2Texture:Class;

			[Embed(source='shotgun.md3',mimeType='application/octet-stream')]
			var MD3Model:Class;
			[Embed(source='shotgun.jpg')]
			var MD3Texture:Class;

			scene = new Scene3D ("scene", this, new Camera3D (stage.stageWidth, stage.stageHeight), new Group ("root"));

			// load offline
			var md2:MD2 = new MD2 ("md2", new MD2Model, 1, new Appearance (new BitmapMaterial ((new MD2Texture).bitmapData)));
			md2.frame = md2.frameCount * 0.5;
			scene.root.addChild (md2);

			var md3data:ByteArray = new MD3Model;
			md3data.endian = Endian.LITTLE_ENDIAN;
			md3data.position = 64 + 4 * 9; md3data.position = md3data.readInt ();

			var md3:MD3 = new MD3 ("md3", md3data, 3, new Appearance (new BitmapMaterial ((new MD3Texture).bitmapData)));
			md3.rotateZ = 90; md3.rotateX = 90; md3.tilt = 270; md3.y = -50;
			scene.root.addChild (md3);
			scene.render ();

			// load online
			queue = new LoaderQueue ();
			queue.add ("shotgun", new URLRequest ("shotgun.jpg"));
			queue.addEventListener (QueueEvent.QUEUE_COMPLETE, onQueueDone);
			queue.start ();
		}
		private var scene:Scene3D;
		private var queue:LoaderQueue;
		private var parser:MD3Parser;
		private function onQueueDone (e:QueueEvent):void {
			parser = new MD3Parser ("shotgun.md3", "shotgun", queue);
			parser.addEventListener (ParserEvent.INIT, onParserDone);
			parser.parse();
		}
		private function onParserDone (e:ParserEvent):void {
			var kftg:KeyFramedTransformGroup = (e.group.children [0]) as KeyFramedTransformGroup;
			if (kftg != null) {
				trace ("md3 parsed OK: " + kftg.children);
				kftg.x = -50;
				scene.root.addChild (kftg);
				scene.render ();
			}
		}
	}
}