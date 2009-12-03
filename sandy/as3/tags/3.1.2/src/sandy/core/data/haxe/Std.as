// This class is generated from haxe branch r1141, with flash.Boot references manually inlined
package sandy.core.data.haxe {
	//import flash.Boot;
	import flash.utils.getQualifiedClassName;
	public class Std {
		static public function _is(v : *,t : *) : Boolean {
			//return flash.Boot.__instanceof(v,t);
			if(t == Object) return true;
			return v is t;
		}
		
		static public function string(s : *) : String {
			//return flash.Boot.__string_rec(s,"");
			return __string_rec(s,"");
		}

		static public function __string_rec(v : *,str : String) : String {
			var cname : String = flash.utils.getQualifiedClassName(v);
			switch(cname) {
			case "Object":{
				var k : Array = function() : Array {
					var $r : Array;
					$r = new Array();
					for(var $k : String in v) $r.push($k);
					return $r;
				}();
				var s : String = "{";
				var first : Boolean = true;
				{
					var _g1 : int = 0, _g : int = k.length;
					while(_g1 < _g) {
						var i : int = _g1++;
						var key : String = k[i];
						if(first) first = false;
						else s += ",";
						s += " " + key + " : " + __string_rec(v[key],str);
					}
				}
				if(!first) s += " ";
				s += "}";
				return s;
			}break;
			case "Array":{
				var s2 : String = "[";
				var i2 : *;
				var first2 : Boolean = true;
				var a : Array = v;
				{
					var _g12 : int = 0, _g2 : int = a.length;
					while(_g12 < _g2) {
						var i1 : int = _g12++;
						if(first2) first2 = false;
						else s2 += ",";
						s2 += __string_rec(a[i1],str);
					}
				}
				return s2 + "]";
			}break;
			default:{
				switch(typeof v) {
				case "function":{
					return "<function>";
				}break;
				}
			}break;
			}
			return new String(v);
		}
		
		static public function _int(x : Number) : int {
			return int(x);
		}
		
		static public function _parseInt(x : String) : * {
			{
				var v : * = parseInt(x);
				if(isNaN(v)) return null;
				return v;
			}
		}
		
		static public function _parseFloat(x : String) : Number {
			return parseFloat(x);
		}
		
		static public function random(x : int) : int {
			return Math.floor(Math.random() * x);
		}
		
	}
}
