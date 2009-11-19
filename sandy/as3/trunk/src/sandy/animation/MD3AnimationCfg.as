// This class is generated from haxe branch r1141
package sandy.animation {
	import flash.utils.ByteArray;
	import sandy.animation.Animation;
	public class MD3AnimationCfg {
		static public function read(b : flash.utils.ByteArray,names : Array,types : Array,md3numbering : Boolean = true) : Hash {
			var idx : int = 0;
			var animations : Hash = new Hash();
			if(names.length != types.length) throw "Names and types must be the same length";
			var sex : String = "n";
			var footsteps : String = "";
			var eSex : EReg = new EReg("sex[\\s]+([a-z])","i");
			var eFootsteps : EReg = new EReg("footsteps[\\s]+([a-z]+)","i");
			var eAnim : EReg = new EReg("([0-9]+)[\\s]+([0-9]+)[\\s]+([0-9]+)[\\s]+([0-9]+)[\\s]+","");
			var inHeader : Boolean = true;
			var firstTorso : Number = -1.;
			var offset : Number = -1.;
			var text : String = b.readUTFBytes(b.length);
			var lines : Array = text.split("\n");
			{
				var _g : int = 0;
				while(_g < lines.length) {
					var l : String = lines[_g];
					++_g;
					if(inHeader) {
						if(eSex.match(l)) {
							sex = eSex.matched(1);
							continue;
						}
						if(eFootsteps.match(l)) {
							footsteps = eFootsteps.matched(1);
							continue;
						}
						if(eAnim.match(l)) inHeader = false;
					}
					if(!inHeader && eAnim.match(l) && idx < names.length) {
						var anim : sandy.animation.Animation = new sandy.animation.Animation(names[idx]);
						anim.type = types[idx];
						anim.sex = sex;
						anim.soundName = footsteps;
						anim.firstFrame = Std._parseFloat(eAnim.matched(1));
						anim.frames = Std._parseFloat(eAnim.matched(2));
						anim.loopingFrames = Std._parseFloat(eAnim.matched(3));
						anim.fps = Std._parseFloat(eAnim.matched(4));
						if(anim.type == "torso" && firstTorso == -1) firstTorso = anim.firstFrame;
						if(anim.type == "legs" && md3numbering) {
							if(offset == -1) offset = anim.firstFrame - firstTorso;
							anim.firstFrame -= offset;
						}
						animations.set(anim.name,anim);
						idx++;
					}
				}
			}
			return animations;
		}
		
	}
}
