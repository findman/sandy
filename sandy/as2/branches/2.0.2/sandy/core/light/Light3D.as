﻿/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author or authors.
Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 ( the "License" );
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

import com.bourre.events.EventBroadcaster;

import sandy.core.data.Vector;
import sandy.events.SandyEvent;
import sandy.util.NumberUtil;

/**
 * Dispatched when the light is updated.
 *
 * @eventType sandy.events.SandyEvent.LIGHT_UPDATED
 */
[ Event( name = "lightUpdated", type = "sandy.events.SandyEvent" ) ]
	
/**
 * Dispatched when the light color is changed.
 *
 * @eventType sandy.events.SandyEvent.LIGHT_COLOR_CHANGED
 */
[ Event( name = "lightColorChanged", type = "sandy.events.SandyEvent" ) ]

/**
 * The Light3D class is used for creating the light of the world.
 *
 * <p>The light in Sandy is a light source at infinity, emitting parallel colored light.
 * The direction, color, and intensity of the light can be changed.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - xdevltd
 * @version		2.0.2
 * @date 		26.07.2007
 */
  
class sandy.core.light.Light3D extends EventBroadcaster
{
	
	/**
	 * Maximum value accepted for the power of the light.
	 * Be aware that even if this constant is changed, the actual lighting calculations are normalized
	 * ( <code>0</code> - <code>MAX_POWER</code> becomes <code>0</code> -> <code>1</code> ).
	 */
	public static var MAX_POWER:Number = 150;

	public static var _oEB:EventBroadcaster = new EventBroadcaster( Light3D );
		
	/**
	 * Creates a new light source.
	 *
	 * @param p_oD		The direction of the emitted light.
	 * @param p_nPow	Intensity of the emitted light.
	 *
     * @see sandy.core.data.Vector
	 */
	public function Light3D( p_oD:Vector, p_nPow:Number )
	{
		_dir = p_oD;
		_dir.normalize();
		setPower( p_nPow );
	}

	/**
	 * The power of the light. A number between 0 and MAX_POWER is necessary.
	 * The highter the power of the light is, the less the shadows are visibles.
	 *
	 * @param n	Number a Number between 0 and MAX_POWER. This number is the light intensity.
	 */
	public function setPower( p_nPow:Number ) : Void
	{
		_power =  NumberUtil.constrain( p_nPow, 0, Light3D.MAX_POWER );
		_nPower = _power / Light3D.MAX_POWER;
		_oEB.broadcastEvent.apply( new SandyEvent( SandyEvent.LIGHT_UPDATED ) );
	}

	/** Returns the intensity of the light.
	 *
	 * @return The intensity as a number between 0 - MAX_POWER.
	 */
	public function getPower() : Number
	{
		return _power;
	}

	/**
	 * Returns the power of the light normalized to the range 0 -> 1
	 *
	 * @return Number a number between 0 and 1
	 */
	public function getNormalizedPower() : Number
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
	public function getDirectionVector() : Vector
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
	public function setDirection( x:Number, y:Number, z:Number ) : Void
	{
		_dir.x = x; _dir.y = y; _dir.z = z;
		_dir.normalize();
		_oEB.broadcastEvent( new SandyEvent( SandyEvent.LIGHT_UPDATED ) );
	}

	/**
	 * Sets the direction of the Light3D.
	 *
	 * @param pDir	A Vector object representing the direction of the light.
	 *
     * @see sandy.core.data.Vector
	 */
	public function setDirectionVector( pDir:Vector ) : Void
	{
		_dir = pDir;
		_dir.normalize();
		_oEB.broadcastEvent( new SandyEvent( SandyEvent.LIGHT_UPDATED ) );
	}

	/**
	 * Calculates the strength of this light based on the supplied normal.
	 *
	 * @return Number	The strength between 0 and 1
	 *
     * @see sandy.core.data.Vector
	 */
	public function calculate( normal:Vector ) : Number
	{
		var DP:Number = _dir.dot( normal );
		DP = -DP;

		// if DP is less than 0 then the face is facing away from the light
		// so set it to zero
		if( DP < 0 )
		{
			DP = 0;
		}

		return _nPower * DP;
	}

	/**
	 * Not in use...
	 */
	public function destroy() : Void
	{
		//How clean the listeners here?
		//removeEventListener( SandyEvent.LIGHT_UPDATED, );
	}

	/**
	 * The color of the light.
	 */
	public function get color() : Number
	{
		return _color;
	}

	/**
	 * @private
	 */
	public function set color( p_nColor:Number ) : Void
	{
		_color = p_nColor;

		// we don't send LIGHT_UPDATED to avoid recalculating light maps needlessly
		// some event still has to be sent though, just in case...
		_oEB.broadcastEvent( new SandyEvent( SandyEvent.LIGHT_COLOR_CHANGED ) );
	}

	// Direction of the light. It is 3D vector.
	//Please refer to the Light tutorial to learn more about Sandy's lights.
	private var _dir:Vector;
	private var _power:Number;
	private var _nPower:Number;
	private var _color:Number;
	
}
