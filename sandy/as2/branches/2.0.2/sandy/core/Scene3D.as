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

import com.bourre.events.EventBroadcaster;

import sandy.core.data.Vector;
import sandy.core.light.Light3D;
import sandy.core.scenegraph.Camera3D;
import sandy.core.scenegraph.Group;
import sandy.events.SandyEvent;
import sandy.materials.MaterialManager;
import sandy.core.SceneLocator;

/**
 * Dispatched when a light is added to the scene.
 *
 * @eventType sandy.events.SandyEvent.LIGHT_ADDED
 */
[Event("lightAdded")]

/**
* Dispatched when the scene is rendered.
*
* @eventType sandy.events.SandyEvent.SCENE_RENDER
*/
[Event("scene_render")]

/**
* Dispatched when the scene is culled.
*
* @eventType sandy.events.SandyEvent.SCENE_CULL
*/
[Event("scene_cull")]

/**
* Dispatched when the scene is updated.
*
* @eventType sandy.events.SandyEvent.SCENE_UPDATE
*/
[Event("scene_update")]

/**
* Dispatched when the display list is rendered.
*
* @eventType sandy.events.SandyEvent.SCENE_RENDER_DISPLAYLIST
*/
[Event("scene_render_display_list")]

/**
 * The Scene3D object is the central point of a Sandy world.
 *
 * <p>A Scene3D object encompasses all the data needed to render a virtual 3D environment.
 * A scene contains objects in the 3D space (shapes, primitives, sprites, etc.), a camera, a light source, and a
 * container where its 2D representation will be drawn. Multiple
 * Scene3D objects can exist in a single application.</p>
 * <p>The older World3D is a singleton special case of Scene3D.</p>
 *
 * @example	To create a scene, you pass a container, a camera and a root group to its constructor.<br/>
 * The rendering of the world is driven by a "heart beat", which may be a Timer or the Event.ENTER_FRAME event.
 *
 * <listing version="3.0">
 * 	var camera:Camera3D = new Camera3D(400, 300);
 * 	camera.z = -200;
 * 	// The call to createScene() will create the root Group of this scene
 * 	var scene:Scene3D = new Scene3D("Scene 1", this, camera, createScene());
 * 	scene.root.addChild(camera);
 * 	//The handler calls the world.render() method to render the world for each frame.
 * this.onEnterFrame = enterFrameHandler;
 * </listing>
 *
 * @author	Thomas Pfeiffer - kiroukou
 * @author	(porting) Floris - FFlasher
 * @version	2.0.2
 * @date 	07.09.2007
 *
 * @see World3D
 */
 
class sandy.core.Scene3D
{
	
	/**
	 * The camera looking at this scene.
	 *
     * @see sandy.core.scenegraph.Camera3D
	 */
	public var camera:Camera3D;

	/**
	 * The root of the scene graph for this scene.
	 *
     * @see sandy.core.scenegraph.Group
	 */
	public var root:Group;

	/**
	 * The container that stores all displayable objects for this scene.
	 */
	public var container:MovieClip;
		
	/**
	 * The material manager for the scene.
	 */
	public var materialManager:MaterialManager;

	public static var _oEB:EventBroadcaster;
		
	/**
	 * Creates a new 3D scene.
	 *
	 * <p>Each scene is automatically registered with the SceneLocator and must be given
	 * a unique name to make proper use of the SceneLocator registry.</p>
	 *
	 * @param p_sName		A unique name for this scene.
	 * @param p_oContainer 	The container where the scene will be drawn.
	 * @param p_oCamera		The camera for this scene.
	 * @param p_oRootNode	The root group of the scene's object tree.
	 *
     * @see sandy.core.scenegraph.Camera3D
     * @see sandy.core.scenegraph.Group
	 */
	public function Scene3D( p_sName:String, p_oContainer:MovieClip, p_oCamera:Camera3D, p_oRootNode:Group )
	{
		if( p_sName != null )
		{
			if( SceneLocator.getInstance().registerScene( p_sName, this ) )
			{
				container = p_oContainer;
				camera = p_oCamera;
				root = p_oRootNode;

				if( root != null && camera != null )
				{
					if( !camera.hasParent() ) 
						root.addChild( camera );
				}
			}
			m_sName = p_sName;
		}
		materialManager = new MaterialManager();
		_oEB = new EventBroadcaster( Scene3D );
		// --
		_light = new Light3D( new Vector( 0, 0, 1 ), 100 );
	}

	/**
	 * Renders the scene in its container.
	 * Several events are dispatched by the scene to allows you to control the rendering pipeline
	 * SandyEvent.SCENE_UPDATE is broadcasted before the update phasis of the scenegraph. During this phasis each node updates its information and creates its local matrix if any
	 * SandyEvent.SCENE_CULL is bradcasted before the scene cull phasis. This phasis corresponds to the frustum vs nodes bounding objects visibility test. Nodes that aren't in the camera field of view, are removed from the render phasis.
	 * SandyEvent.SCENE_RENDER process the render call of the visible nodes. During this process, visible polygons/sprites are registering for the camera display to the screen.
	 * SandyEvent.SCENE_RENDER_DISPLAYLIST render the visible polygons to the screen
	 * @param p_oEvt	An eventual event - defaults to null. Not in use...
	 *
     * @see sandy.events.SandyEvent
	 */
	public function render( p_oEvt:SandyEvent ) : Void
	{
		if (root && camera && container)
		{
			_oEB.broadcastEvent( new SandyEvent( SandyEvent.SCENE_UPDATE ) );
			root.update( this, null, false );
			// --
			_oEB.broadcastEvent( new SandyEvent( SandyEvent.SCENE_CULL ) );
			root.cull( this, camera.frustrum, camera.invModelMatrix, camera.changed );
			// --
			_oEB.broadcastEvent( new SandyEvent( SandyEvent.SCENE_RENDER ) );
			root.render( this, camera );
			// -- clear the polygon's container and the projection vertices list
			_oEB.broadcastEvent( new SandyEvent( SandyEvent.SCENE_RENDER_DISPLAYLIST ) );
            materialManager.begin( this );
            camera.renderDisplayList( this );
            materialManager.finish( this );
		}
	} // end method

	/**
	 * Disposes of all the scene's resources.
	 *
	 * <p>This method is used to clear memory and will free up all resources of the scene and unregister it from SceneLocator.</p>
	 */
	public function dispose() : Boolean
	{
		SceneLocator.getInstance().unregisterScene( m_sName );
		root.destroy();
		// --
		if (root)
		{
			root = null;
		}
		if (camera)
		{
			camera = null;
		}
		if (_light)
		{
			_light = null;
		}
		
		return true;
	}

	/**
	 * The Light3D object associated with this this scene.
	 *
	 * @see sandy.core.light.Light3D
	 */
	public function get light() : Light3D
	{
		return _light;
	}

	/**
	 * @private
	 */
	public function set light( l:Light3D ) : Void
	{
		if ( _light )
		{
			_light.destroy();
		}
		// --
		_light = l;
		_oEB.broadcastEvent( new SandyEvent( SandyEvent.LIGHT_ADDED ) );
	}

	/**
	 * Enable this property to perfectly clip your 3D scene to the viewport's dimensions.
	 * If set to <code>true</code>, the <code>enableClipping</code> property of any Shape3D
	 * objects will be ignored and nothing will be drawn outside the viewport's dimensions.
	 *
	 * @default true
	 */
	public function get rectClipping() : Boolean
	{
		return m_bRectClipped;
	}

	/**
	 * @private
	 */
	public function set rectClipping( p_bEnableClipping:Boolean ) : Void
	{
		m_bRectClipped = p_bEnableClipping;
		// -- we force the new state of the rectClipping property to be applied
		if ( camera )
		{
			camera.viewport.hasChanged = true;
		}
	}

	/**
	 * The name of this scene.
	 * This value can't be changed.d
	 */
	public function get name() : String
	{
		return m_sName;
	}

	/**
	 * @private
	 */
	private var m_sName:String;
	private var m_bRectClipped:Boolean = true;
	private var _light:Light3D; 	//the unique light instance of the world
	
}
