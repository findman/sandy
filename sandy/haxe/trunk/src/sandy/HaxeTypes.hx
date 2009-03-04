package sandy;

#if flash10
// typedef Array<T> = flash.Vector<T>;
typedef TypedArray<T> = flash.Vector<T>;
#else
typedef TypedArray<T> = Array<T>;
#end

class Haxe {
	#if flash10
	public static inline function toTypedArray<T>(v : Array<T>) : TypedArray<T> {
		return untyped __vector__(v);
	}
	#else
	public static inline function toTypedArray<T>(v : Array<T>) : TypedArray<T> {
		return v;
	}
	#end

}