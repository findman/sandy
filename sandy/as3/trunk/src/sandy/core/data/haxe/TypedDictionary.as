// This class is generated from haxe branch r1141, with flash.Boot references manually commented out
package sandy.core.data.haxe/*flash.utils*/ {
	import flash.utils.Dictionary;
	//import flash.Boot;
	public class TypedDictionary extends flash.utils.Dictionary {
		public function TypedDictionary(weakKeys : * = null) : void { //if( !flash.Boot.skip_constructor ) {
			super(weakKeys);
		}//}
		
		public function get(k : *) : * {
			return this[k];
		}
		
		public function set(k : *,v : *) : void {
			this[k] = v;
		}
		
		public function exists(k : *) : Boolean {
			return this[k] != null;
		}
		
		public function _delete(k : *) : void {
			delete(this[k]);
		}
		
		public function keys() : Array {
			return function($this:TypedDictionary) : Array {
				var $r : Array;
				$r = new Array();
				for(var $k : String in $this) $r.push($k);
				return $r;
			}(this);
		}
		
		public function iterator() : * {
			return this.keys().iterator();
		}
		
	}
}
