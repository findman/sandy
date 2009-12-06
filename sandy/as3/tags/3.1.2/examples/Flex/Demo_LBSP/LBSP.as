package  {
	import flash.display.Sprite;
	import flash.events.*;
	import sandy.core.*;
	import sandy.core.scenegraph.*;
	import sandy.materials.*;
	import sandy.materials.attributes.*;

	/**
	 * Lazy BSP test.
	 * Demonstrates optimized and non-optimized models display.
	 * @author makc
	 */
	[SWF (width="800", height="600", frameRate="60")]
	public class LBSP extends Sprite {
		private var scene:Scene3D;
		private var thingy1:Shape3D;
		private var thingy2:Shape3D;
		private var appearance:Appearance;
		private var scale:Number = 2;

		public function LBSP () {
			scene = new Scene3D ("scene", this, new Camera3D (800, 600, 45, 0), new Group ("root"));
			scene.camera.z = -5 * scale;

			appearance = new Appearance (new ColorMaterial (0x7F007F, 1, new MaterialAttributes (new LineAttributes (0, 0))));

			stage.addEventListener (Event.ENTER_FRAME, loop);
			stage.addEventListener (MouseEvent.CLICK, click);
			click ();
		}

		private function loop (e:Event):void {
			thingy1.resetCoords (); thingy1.x = -scale; thingy1.pan = mouseX; thingy1.rotateX = mouseY;
			thingy2.resetCoords (); thingy2.x = +scale; thingy2.pan = mouseX; thingy2.rotateX = mouseY;

			scene.render ();
		}

		private var uncut:Boolean;
		private function click (e:MouseEvent = null):void {

			if (thingy1 != null) {
				scene.root.removeChildByName (thingy1.name);
				scene.root.removeChildByName (thingy2.name);
			}

			if (uncut) {
				thingy1 = new ThingyAVGZ;
				thingy2 = new ThingyLBSP;
			} else {
				thingy1 = new Thingy;
				thingy2 = new Thingy;
			}

			thingy1.appearance = appearance; scene.root.addChild (thingy1);
			thingy2.appearance = appearance; scene.root.addChild (thingy2);

			thingy2.sortingMode = Shape3D.SORT_LAZY_BSP;

			uncut = !uncut;
		}
	}

}