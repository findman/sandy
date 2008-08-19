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

import sandy.core.data.Vector;
import sandy.core.light.Light3D;
import sandy.errors.SingletonError;
import sandy.events.SandyEvent;

/*
[Event(name="containerCreated", type="sandy.events.SandyEvent")]
[Event(name="lightAdded", type="sandy.events.SandyEvent")]
[Event(name="render", type="sandy.events.SandyEvent")]
*/

/**
 * The Sandy 3D world.
 *
 * <p>The World3D object is the central point of a Sandy world.<br/>
 * World3D is a singleton class, which means that you can have only one World3D instance.<br/>
 * It contains the object tree with groups, a camera, a light source and a canvas to draw on</p>
 *
 * @example	To create the world instance, you call the getInstance() class method.<br/>
 * To make the world visible, you add a canvas to draw on ( normally a Sprite ), and add a camera.<br/>
 * The rendering of the world is driven by a "heart beat", which may be a Timer or the Event.ENTER_FRAME event.
 *
 * <listing version="3.0">
 *     	var world:World3D = World3D.getInstance();
 *	world.container = this; // The document calss is a Sprite or MovieClip
 *	world.camera = new Camera3D( 200, 200 );
 *	world.root.addChild( world.camera );
 *	// Go on to create the 3D objects and transforms
 *	world.root = createScene();
 *	// Listen for the ENTER-FRAME event.
 *	//The handler calls the world.render() method to render the world for each frame.
 *	addEventListener( Event.ENTER_FRAME, enterFrameHandler );
 *  </listing>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		Xavier Martin - zeflasher - http://dev.webbymx.net
 * @author Niel Drummond - haXe port
 * 
 * 
 */
class World3D extends Scene3D
{
	/**
	 * Creates a specific Scene3D called World3D.
	 * This is done for backward compatibility
	 *
	 * <p>You can have only one World3D instance ( singleton ) in a Flash movie.<br/>
	 * You should not call this constructor directly, but use the static getInstance() method</p>
	 */
	public function new ()
	{
		if ( create )
		{
			// default light
			super( null, null, null, null );
			container = null;
		}
		else
		{
			throw new SingletonError();
		}
	}

	/**
	 * Returns an instance of World3D.
	 *
	 * @return	The single World3D instance
	 */
	public static function getInstance() : World3D
	{
		if (instance == null)
		{
			create = true;
			instance = new World3D();
			create = false;
		}

		return instance;
	}

	public override function toString():String
	{
		return "sandy.core.World3D";
	}


	////////////////////
	//// PRIVATE
	////////////////////
	//private var _light : Light3D; //the unique light instance of the world
	private static var instance:World3D;
	private static var create:Bool;
}

