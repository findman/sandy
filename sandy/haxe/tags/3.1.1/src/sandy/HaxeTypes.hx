package sandy;

#if flash10
typedef TypedArray<T> = flash.Vector<T>;
#else
typedef TypedArray<T> = Array<T>;
#end

#if SANDY_USE_FAST_MATH
typedef TRIG = sandy.math.FastMath;
#else
typedef TRIG = Math;
#end

#if (flash9 || flash10)
typedef Xml = sandy.util.FlashXml__;
typedef FastXml = sandy.util.FastXml__;
#else
typedef FastXml = haxe.xml.Fast;
#end

class Haxe {
	#if flash10
	private static inline var MEM_POOL_LENGTH : Int = 10240;
	private static var MEM_POOL:flash.utils.ByteArray;
	#end

	#if flash10
	public static inline function toTypedArray<T>(v : Array<T>) : TypedArray<T> {
		return untyped __vector__(v);
	}
	#else
	public static inline function toTypedArray<T>(v : Array<T>) : TypedArray<T> {
		return v;
	}
	#end

	static function __init__() {
		#if flash10
			MEM_POOL = new flash.utils.ByteArray();
			MEM_POOL.length = MEM_POOL_LENGTH;
			flash.Memory.select(MEM_POOL);
		#end
	}
}
