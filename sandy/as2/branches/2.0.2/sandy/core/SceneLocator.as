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

import com.bourre.data.collections.Map;

import sandy.core.Scene3D;

/**
 * The SceneLocator serves as a registry of all scenes in the application.
 *
 * <p>An application can only have one SceneLocator. Using the SceneLocator, scenes can be located, registered, and unregistered.</p>
 * <p>When scenes are created in an application, they automatically
 * register with the SceneLocator registry.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - FFlasher
 * @version		2.0.2
 * @date 		26.07.2007
 *
 * @see Scene3D
 */
 
class sandy.core.SceneLocator
{

	private static var _oI	: SceneLocator;
	private var _m			: Map;

	/**
	 * Creates the SceneLocator registry.
	 *
	 * <p>This constructor is never called directly. Instead the registry instance is retrieved by calling SceneLocator.getInstance().</p>
	 *
	 * @param access	A singleton access flag object
	 */
	public function SceneLocator()
	{
		super();
	}
		
	/**
	 * Returns the instance of this SceneLocator object.
	 *
	 * @return This instance.
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
		return Scene3D( _m.get( key ) );
	}

	/**
	 * Checks if a scene with the specified name is registered.
	 *
	 * @param 	key The name of the scene to check.
	 *
	 * @return true if a scene with that name is registered, false otherwise.
	 */
	public function isRegistered( key : String ) 
	{
		return _m.containsKey( key );
	}

	/**
	 * Registers a scene.
	 *
	 * @param key	The name of the scene.
	 * @param o		The Scene3D object.
	 *
	 * @return Whether the scene was successfully registered.
	 */
	public function registerScene( key : String, o : Scene3D ) : Boolean
	{
		if ( isRegistered( key ) )
		{
			trace( "Scene instance is already registered with '" + key + "' name in " + this );
			return false;
		}
		else
		{
			_m.put( key, o );
			return true;
		}
	}

	/**
	 * Unregisters a scene with the specified name.
	 *
	 * @param	key The name of the scene to unregister.
	 */
	public function unregisterScene( key : String ) : Void
	{
		_m.remove( key );
	}

}

