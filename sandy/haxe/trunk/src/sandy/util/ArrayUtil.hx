package sandy.util;

class ArrayUtil 
{
	
	// okay, obviously this untyped could be used directly. But, we might as well have target-specific conditions here, 
	// hypothetically, and this avoids that ugly keyword in the API. Other functions could be added as well. Just a maybe. Feel free to remove this.
	public static inline function indexOf( value : Dynamic, array : Array<Dynamic> ) : Int
	{
		untyped return array.indexOf( value );
	}
	
}