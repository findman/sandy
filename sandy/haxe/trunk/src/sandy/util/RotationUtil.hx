
package sandy.util;

import sandy.core.data.Point3D;
import sandy.core.scenegraph.ATransformable;
import sandy.util.NumberUtil;

import sandy.HaxeTypes;

/**
* Utility class for tweening ATransformale rotaions.
*
* @author		makc
* @author		Russell Weir - haXe port
* @version		3.1
* @date 		12.03.2008
*/
public class RotationUtil
{
	/**
	* Tweening variable (tween this from 0 to 1).
	*/
	public var t(__getT,__setT) : Float;
	private function __getT():Float { return _t; }

	/**
	* @private
	*/
	private function __setT(v:Float):Float
	{
		if ((obj != null) && (_axis != null))
		{
			// rotate
			if (_axis.getNorm () > NumberUtil.TOL)
			{
				obj.rotateAxis (_axis.x, _axis.y, _axis.z, (v - _t) * 180 * _ang / Math.PI);
			}
			else
				// it's either same or the opposite point (_dot is 1 or -1)
				if (_dot < 0)
				{
					obj.rotateAxis (obj.up.x, obj.up.y, obj.up.z, (v - _t) * 180);
				}
			// store v
			_t = v;

			if (enableRoll)
			{
				// do lookAt to reset roll (this will fail on poles)
				obj.lookAt (obj.out.x + obj.x, obj.out.y + obj.y, obj.out.z + obj.z);
				// roll
				obj.roll += (1 - _t) * roll0 + _t * roll1;
			}
		}
		return v;
	}

	/**
	* Initial "out" Point3D.
	*/
	public var out0(__getOut0,__setOut0) : Point3D;
	private function __getOut0():Point3D { return _out0; }

	/**
	* @private
	*/
	private function __setOut0(v:Point3D):Point3D
	{
		_out0 = v; preCalculate (); return v;
	}

	/**
		* Final "out" Point3D.
		*/
	public var out1(__getOut1,__setOut1) : Point3D;
	private function __getOut1():Point3D { return _out1; }

	/**
		* @private
		*/
	private function __setOut1(v:Point3D):Point3D
	{
		_out1 = v; preCalculate ();
		return v;
	}

	/**
		* ATransformable object to tween.
		*/
	public var obj:ATransformable;

	/**
		* If enabled, rolls ATransformable while tweening.
		*/
	public var enableRoll:Bool;

	/**
		* Initial roll angle.
		*/
	public var roll0:Float;

	/**
		* Final roll angle.
		*/
	public var roll1:Float;

	/**
		* Resets object (useful to call after tweening).
		*/
	public function reset ():Void
	{
		_t = 0;
		_out0 = null;
		_out1 = null;
		_dot = 0;
		_ang = 0;
		_axis = null;
	}

	// --
	private var _t:Float;
	private var _out0:Point3D;
	private var _out1:Point3D;
	private var _dot:Float;
	private var _ang:Float;
	private var _axis:Point3D;

	private function preCalculate ():Void
	{
		if ((_out0 != null) && (_out1 != null))
		{
			var _out0n:Point3D = _out0.clone (); _out0n.normalize ();
			var _out1n:Point3D = _out1.clone (); _out1n.normalize ();

			_dot = _out0n.dot (_out1n);
			_ang = Math.acos (_dot);

			_axis = _out0n.cross (_out1n);
		}
	}

	public function new() {
		_t = 0.;
	}
}