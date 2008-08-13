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

import sandy.core.*


/**
 * The SceneLocator serves as a registry of all scenes in the application.
 *
 * <p>You can only have one SceneLocator in an application.<br />
 * You can find, register and unregister scenes by their name.</p>
 * <p>When scenes (Scene3D ) are created in an application, they automatically
 * register with the SceneLocator registry</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		Floris van Veen - Floris
 * @version		2.0
 * @date 		26.07.2008
 */
class sandy.core.SceneLocator
{

	private static var _oI	: SceneLocator;
	private var _m		: Array;

	/**
	 * Creates the SceneLocator registry
	 *
	 * <p>This constructor is never called directly.<br />
	 * Instead you get the registry instance by calling SceneLocator.getInstance().</p>
	 *
	 * @param access	A singleton access flag object
	 */
	public function SceneLocator()
	{
		super();
	}
		
	/**
	 * Returns a SceneLocator.
	 *
	 * @return 	The single locator
	 */
	public static function getInstance() : SceneLocator
	{
		if ( !_oI ) _oI = new SceneLocator();
		return _oI
	}

	/**
	 * Returns the Scene3D object with the specified name.
	 *
	 * @param	key 	The name of the scene
	 * @return	The requested scene
	 */
	public function getScene( key : String ) : Scene3D
	{
		if ( !(isRegistered( key )) ) trace( "Can't locate scene instance with '" + key + "' name in " + this );
		return Scene3D( _m[ key ] );
	}

	/**
	 * Check if a scene with the specified name is registered.
	 *
	 * @param 	key The Name of the scene to check
	 * @return	true if a scene with that name is registered, false otherwise
	 */
	public function isRegistered( key : String ) 
	{
		return _m[ key ];
	}

	/**
	 * Registers a scene with this SceneLocator
	 *
	 * @param	key : String, name of the scene to register
	 * @param	o	: Scene3D, object to register
	 * @return	true if the registration was successful, false otherwise
	 */
	public function registerScene( key : String, o : Scene3D ) : Boolean
	{
		if ( isRegistered( key ) )
		{
			trace( "scene instance is already registered with '" + key + "' name in " + this );
			return false;
		}
		else
		{
			_m[ key ] = o;
			return true;
		}
	}

	/**
	 * Unregisters a scene with the specified name
	 *
	 * @param	key Th name of the scene to unregister
	 */
	public function unregisterScene( key : String ) : Void
	{
		_m[ key ] = null;
	}

}

