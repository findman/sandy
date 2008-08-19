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

package sandy.core;

import flash.utils.Dictionary;

/**
 * The SceneLocator serves as a registry of all scenes in the application.
 *
 * <p>You can only have one SceneLocator in an application.<br />
 * You can find, register and unregister scenes by their name.</p>
 * <p>When scenes (Scene3D ) are created in an application, they aoutomatically
 * register with the SceneLocator registry</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 */
class SceneLocator
{

	private static var _oI	: SceneLocator;
	private var _m		: Hash<Scene3D>;

	/**
	 * Creates the SceneLocator registry
	 *
	 * <p>This constructor is never called directly.<br />
	 * Instead you get the registry instance by calling SceneLocator.getInstance().</p>
	 *
	 * @param access	A singleton access flag object
	 */
	public function new( access : PrivateConstructorAccess )
	{
		_m = new Hash();
	}

	/**
	 * Returns a SceneLocator.
	 *
	 * @return 	The single locator
	 */
	public static function getInstance() : SceneLocator
	{
		if ( _oI == null ) _oI = new SceneLocator( new PrivateConstructorAccess() );
		return _oI;
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
		return cast(_m.get( key ), Scene3D);
	}

	/**
	 * Check if a scene with the specified name is registered.
	 *
	 * @param 	key The Name of the scene to check
	 * @return	true if a scene with that name is registered, false otherwise
	 */
	public function isRegistered( key : String ) : Bool
	{
		return _m.get( key ) != null;
	}

	/**
	 * Registers a scene with this SceneLocator
	 *
	 * @param	key : String, name of the scene to register
	 * @param	o	: Scene3D, object to register
	 * @return	true if the registration was successful, false otherwise
	 */
	public function registerScene( key : String, o : Scene3D ) : Bool
	{
		if ( isRegistered( key ) )
		{
			trace( "scene instance is already registered with '" + key + "' name in " + this );
			return false;

		}
		else
		{
			_m.set( key, o );
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
		_m.remove( key );
	}

}


class PrivateConstructorAccess {
		public function new () {}
}
