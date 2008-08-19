/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author or authors.
Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
	http://www.mozilla.org/MPL/MPL-1.1.html
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# ***** END LICENSE BLOCK *****
*/

package sandy.core.light;

import flash.events.EventDispatcher;

import sandy.core.data.Vector;
import sandy.events.SandyEvent;
import sandy.util.NumberUtil;

/*
[Event(name="lightUpdated", type="sandy.events.SandyEvent")]
[Event(name="lightColorChanged", type="sandy.events.SandyEvent")]
*/

 /**
 * The Light3D class is used for creating the light of the world.
 *
 * <p>The light in Sandy is a light source at infinity, emitting parallel colored light.<br/>
 * The direction of light and the intensity can be varied</p>
 *
 * @author	Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 */
class Light3D extends EventDispatcher
{
	/**
	* Maximum value accepted. If the default value (150) seems too big or too small for you, you can change it.
	* But be aware that the actual lighting calculations are normalised i.e. 0 -> MAX_POWER becomes 0 -> 1
	*/
	public static var MAX_POWER:Null<Float> = 150;

	/**
	 * Creates a new light source.
	 *
	 * @param p_oD		The direction of the emitted light.
	 * @param p_nPow	Intensity of the emitted light.
	 *
     * @see sandy.core.data.Vector
	 */
	public function new(p_oD:Vector, p_nPow:Null<Float>)
	{
		_dir = p_oD;
		_dir.normalize();

		super();

		setPower(p_nPow);
	}

	/**
	 * The the power of the light. A number between 0 and MAX_POWER is necessary.
	 * The highter the power of the light is, the less the shadows are visibles.
	 *
	 * @param n	Float a Float between 0 and MAX_POWER. This number is the light intensity.
	 */
	public function setPower(p_nPow:Null<Float>):Void
	{
		_power =  NumberUtil.constrain(p_nPow, 0, Light3D.MAX_POWER);
		_nPower = _power / Light3D.MAX_POWER;
		dispatchEvent(new SandyEvent(SandyEvent.LIGHT_UPDATED));
	}

	/**
	 * Returns the intensity of the light.
	 *
	 * @return The intensity as a number between 0 - MAX_POWER.
	 */
	public function getPower():Null<Float>
	{
		return _power;
	}

	/**
	 * Returns the power of the light normalized to the range 0 -> 1
	 *
	 * @return Float a number between 0 and 1
	 */
	public function getNormalizedPower():Null<Float>
	{
		return _nPower;
	}

	/**
	 * Returns the direction of the light.
	 *
	 * @return 	The light direction
	 *
     * @see sandy.core.data.Vector
	 */
	public function getDirectionVector():Vector
	{
		return _dir;
	}

	/**
	 * Uneeded? setDirectionVector() does the same thing...
	 *
	 * @param x	The x coordinate
	 * @param y	The y coordinate
	 * @param z	The z coordinate
	 */
	public function setDirection(x:Null<Float>, y:Null<Float>, z:Null<Float>):Void
	{
		_dir.x = x; _dir.y = y; _dir.z = z;
		_dir.normalize();
		dispatchEvent(new SandyEvent(SandyEvent.LIGHT_UPDATED));
	}

	/**
	 * Sets the direction of the Light3D.
	 *
	 * @param x	A Vector object representing the direction of the light.
	 *
     * @see sandy.core.data.Vector
	 */
	public function setDirectionVector(pDir:Vector):Void
	{
		_dir = pDir;
		_dir.normalize();
		dispatchEvent(new SandyEvent(SandyEvent.LIGHT_UPDATED));
	}

	/**
	 * Calculates the strength of this light based on the supplied normal.
	 *
	 * @return Float	The strength between 0 and 1
	 *
     * @see sandy.core.data.Vector
	 */
	public function calculate(normal:Vector):Null<Float>
	{
		var DP:Null<Float> = _dir.dot(normal);
		DP = -DP;

		// if DP is less than 0 then the face is facing away from the light
		// so set it to zero
		if (DP < 0)
		{
			DP = 0;
		}

		return _nPower * DP;
	}

	/**
	 * Not in use...
	 */
	public function destroy():Void
	{
		//How clean the listeners here?
		//removeEventListener(SandyEvent.LIGHT_UPDATED, );
	}

	/**
	 * Color of the light.
	 */
	public var color(__getColor, __setColor):Null<Int>;
	public function __getColor():Null<Int>
	{
		return _color;
	}

	/**
	 * @private
	 */
	private function __setColor(p_nColor:Null<Int>):Null<Int>
	{
		_color = p_nColor;

		// we don't send LIGHT_UPDATED to aVoid recalculating light maps needlessly
		// some event still has to be sent though, just in case...
		dispatchEvent(new SandyEvent(SandyEvent.LIGHT_COLOR_CHANGED));
		return p_nColor;
	}

	// Direction of the light. It is 3D vector.
	//Please refer to the Light tutorial to learn more about Sandy's lights.
	private var _dir:Vector;
	private var _power:Null<Float>;
	private var _nPower:Null<Float>;
	private var _color:Null<Int>;
}

