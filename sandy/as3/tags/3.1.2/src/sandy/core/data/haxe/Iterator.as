package sandy.core.data.haxe {
	import flash.utils.Dictionary;
	/**
	 * Iterator implementation over Dictionary according to haXe specs.
	 * @see http://haxe.org/api/iterator
	 * @author makc
	 */
	public class Iterator {
		private var ref:Dictionary;
		private var keys:Array;
		public function Iterator (h:Dictionary) {
			keys = []; for (var key:String in h) keys.push (key); ref = h;
		}
		public function next ():* {
			if (keys.length > 0) {
				var key:String = keys.shift ();
				return ref [key];
			}
			return null;
		}
		public function hasNext ():Boolean {
			return (keys.length > 0)
		}
		public function toString ():String {
			return "[object Iterator, keys: [" + keys + "]]";
		}
	}

}