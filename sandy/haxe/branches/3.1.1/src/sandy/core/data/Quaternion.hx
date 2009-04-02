
package sandy.core.data;

import sandy.HaxeTypes;

/**
* The Quaternion class is experimental and not used in this version.
*
* <p>It is not used at the moment in the library, but should becomes very usefull soon.<br />
* It should be stable but any kind of comments/note about it will be appreciated.</p>
*
* <p>[<strong>ToDo</strong>: Check the use of and comment this class ]</p>
*
* @author		Thomas Pfeiffer - kiroukou
* @author Niel Drummond - haXe port
* @since		0.3
* @version		3.1
* @date 		24.08.2007
**/
class Quaternion
{
	public var x:Float;
	public var y:Float;
	public var z:Float;
	public var w:Float;

	/**
	* Creates a quaternion.
	*
	* <p>[<strong>ToDo</strong>: What's all this here? ]</p>
	*/
	public function Quaternion( ?px : Float, ?py : Float, ?pz : Float, ?pw:Float )
	{
		if ( px == null ) px = 0.0;
		if ( py == null ) px = 0.0;
		if ( pz == null ) px = 0.0;
		if ( pw == null ) pw = 0.0;

		x = px;
		y = py;
		z = pz;
		w = pw;
	}

	/**
	* Returns a string representing this quaternion.
	*
	* @return	The string representatation
	*/
	public function toString():String
	{
		var s:String = "sandy.core.data.Quaternion";
		s += "(x:"+x+" , y:"+y+", z:"+z+" w:"+w + ")";
		return s;
	}
}

