// This class is generated from haxe branch r1141
package sandy.util {
	public class DataOrder /*extends enum*/ {
		public static const __isenum : Boolean = true;
		public function DataOrder( t : String, index : int, p : Array = null ) : void { this.tag = t; this.index = index; this.params = p; }
		public static var DATA_MD3 : DataOrder = new DataOrder("DATA_MD3",1);
		public static var DATA_SANDY : DataOrder = new DataOrder("DATA_SANDY",0);
		public static var __constructs__ : Array = ["DATA_SANDY","DATA_MD3"];;

		// enum inlined
		public var tag : String;
		public var index : int;
		public var params : Array;
	}
}
