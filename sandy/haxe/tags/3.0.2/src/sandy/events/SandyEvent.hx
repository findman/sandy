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

package sandy.events;

import flash.events.Event;

/**
 * Conatains custom Sandy events.
 *
 * @author	Dennis Ippel
 * @author Niel Drummond - haXe port 
 * 
 *
 * @see BubbleEventBroadcaster
 */
class SandyEvent extends Event
{
    /**
     * Indicates that a light has been added to a Scene3D object.
     *
     * @eventType lightAdded
     *
     * @see sandy.core.Scene3D
     */
	public static var LIGHT_ADDED:String = "lightAdded";

    /**
     * Indicates that the Light3D object of the scene has been updated.
     *
     * @eventType lightUpdated
     *
     * @see sandy.core.light.Light3D
     */
	public static var LIGHT_UPDATED:String = "lightUpdated";

    /**
     * Indicates that the color of the light has changed.
     *
     * @eventType lightColorChanged
     *
     * @see sandy.core.light.Light3D
     */
	public static var LIGHT_COLOR_CHANGED:String = "lightColorChanged";

    /**
     * Indicates the scene has been rendered.
     *
     * @eventType scene_render
     *
     * @see sandy.core.Scene3D
     */
	public static var SCENE_RENDER:String = "scene_render";

    /**
     * Indicates the scene has been culled.
     *
     * @eventType scene_cull
     *
     * @see sandy.core.Scene3D
     */
	public static var SCENE_CULL:String = "scene_cull";

    /**
     * Indicates the scene has been updated.
     *
     * @eventType scene_update
     *
     * @see sandy.core.Scene3D
     */
	public static var SCENE_UPDATE:String = "scene_update";

    /**
     * Indicates the display list has been rendered.
     *
     * @eventType scene_render_display_list
     *
     * @see sandy.core.Scene3D
     */
	public static var SCENE_RENDER_DISPLAYLIST:String = "scene_render_display_list";

    /**
     * Not in use?
     *
     * @eventType containerCreated
     *
     * @see sandy.core.World3D
     */
	public static var CONTAINER_CREATED:String = "containerCreated";

    /**
     * Uneeded? Also in QueueEvent class...
     *
     * @eventType queueComplete
     *
     * @see sandy.util.LoaderQueue
     */
	public static var QUEUE_COMPLETE:String = "queueComplete";

    /**
     * Uneeded? Also in QueueEvent class...
     *
     * @eventType queueLoaderError
     *
     * @see sandy.util.LoaderQueue
     */
	public static var QUEUE_LOADER_ERROR:String = "queueLoaderError";

 	/**
	 * Constructor.
	 *
	 * @param type The event type; indicates the action that caused the event.
	 * @param bubbles Specifies whether the event can bubble up the display list hierarchy.
	 * @param cancelable Specifies whether the behavior associated with the event can be prevented.
     */
	public function new(type:String, ?bubbles:Bool, ?cancelable:Bool)
	{
		if (bubbles == null) bubbles = false;
		if (cancelable == null) cancelable = false;
		super(type, bubbles, cancelable);
	}

	/**
	 * @private
	 */
	override public function clone():Event
    {
        return new SandyEvent(type, bubbles, cancelable);
    }
}

