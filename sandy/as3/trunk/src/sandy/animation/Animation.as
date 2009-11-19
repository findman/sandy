// This class is generated from haxe branch r1141, with flash.Boot references manually commented out
// and haxe types imported from sandy.core.data.haxe
package sandy.animation {
	import sandy.core.scenegraph.Sound3D;
	//import flash.Boot;
	import sandy.core.data.haxe.*;
	public class Animation {
		public function Animation(p_sName : String = null) : void { //if( !flash.Boot.skip_constructor ) {
			this.name = p_sName;
			this.fps = 0.0;
			this.sex = "n";
		}//}
		
		public var name : String;
		public function get duration() : int { return __getDuration(); }
		protected var $duration : int;
		public var firstFrame : Number;
		public function get lastFrame() : Number { return __getLastFrame(); }
		protected var $lastFrame : Number;
		public var frames : Number;
		public var loopingFrames : Number;
		public var fps : Number;
		public var type : String;
		public var soundName : String;
		public var sound : sandy.core.scenegraph.Sound3D;
		public var sex : String;
		public function __getDuration() : int {
			if(this.fps == 0.) return 0;
			return Std._int(this.frames / this.fps * 1000);
		}
		
		public function __getLastFrame() : Number {
			var v : Number = this.firstFrame + this.frames - 1.;
			if(v < 0) return 0;
			return v;
		}
		
		public function toString() : String {
			return "sandy.animation.Animation " + this.name + " (" + this.type + ") start frame: " + this.firstFrame + " length: " + this.frames + " loop: " + this.loopingFrames + " fps: " + this.fps + " duration ms:" + this.__getDuration() + " sound: " + this.soundName;
		}
		
	}
}
