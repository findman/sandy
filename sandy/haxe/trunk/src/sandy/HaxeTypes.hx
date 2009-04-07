package sandy;

#if flash10
typedef TypedArray<T> = flash.Vector<T>;
#else
typedef TypedArray<T> = Array<T>;
#end

#if flash
typedef Bytes = flash.utils.ByteArray;
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

	/**
	* Converts a TypedArray to a normal array
	*/
	public static function toArray<T>(v : TypedArray<T>) : Array<T> {
		var a = new Array<T>();
		for(i in 0...v.length)
			a[i] = v[i];
		return a;
	}

	/**
	* Converts a normal Array to a TypedArray
	*/
	public static inline function toTypedArray<T>(v : Array<T>) : TypedArray<T> {
		#if flash10
			return untyped __vector__(v);
		#else
			return v;
		#end
	}

	static function __init__() {
		#if flash10
			MEM_POOL = new flash.utils.ByteArray();
			MEM_POOL.length = MEM_POOL_LENGTH;
			flash.Memory.select(MEM_POOL);
		#end
	}
}

#if flash
typedef Dictionary<K,V> = flash.utils.TypedDictionary<K,V>;
#else
#error
// you are getting this error because this work needs to be ported
// and this is not a hash, it will have to be done with an array or such
// This needs to be able to map any object type to any other object type.
class Dictionary<K,V>  {
	public function new() {
	}

	public inline function get(key:K) : Null<V> {
	}

	public inline function set(key:K, value:V) : Void {
	}

	public inline function exists(key:K) : Bool {
	}

	public inline function delete( key:K ) : Void {
	}

	public inline function keys() : Array<K> {
	}

	public inline function iterator() : Iterator<K> {
		return keys().iterator();
	}
}
#end

enum Alignment {
	XY;
	YZ;
	ZX;
}

enum ColorChannel {
	RED;
	GREEN;
	BLUE;
	ALPHA;
	AV;
}

enum CoordinateSystem {
	LOCAL;
	CAMERA;
	ABSOLUTE;
}

/**
* Asset types for LoaderQueues.
*
* BIN Binary file
*
* IMAGE png or jpeg files
*
* SWF swf files
*
* SOUND mp3 asset
**/
enum AssetType {
	BIN;
	TEXT;
	VARIABLES;
	IMAGE;
	SWF;
	SOUND;
}

