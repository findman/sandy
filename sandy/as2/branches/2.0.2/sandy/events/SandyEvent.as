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

import com.bourre.events.EventType;
import com.bourre.events.BubbleEvent;

/**
 * Contains custom Sandy events.
 *
 * @author	Dennis Ippel
 * @author  (porting) Floris - xdevltd
 * @version	2.0.2
 *
 * @see BubbleEventBroadcaster
 */
 
class sandy.events.SandyEvent extends BubbleEvent 
{
	
    /**
	 * Defines the value of the <code>type</code> property of a <code>lightAdded</code> event object.
     *
     * @eventType lightAdded
     *
     * @see sandy.core.Scene3D
     */
	public static var LIGHT_ADDED:EventType = new EventType( "lightAdded" );

    /**
	 * Defines the value of the <code>type</code> property of a <code>lightUpdated</code> event object.
     *
     * @eventType lightUpdated
     *
     * @see sandy.core.light.Light3D
     */
	public static var LIGHT_UPDATED:EventType = new EventType( "lightUpdated" );

    /**
	 * Defines the value of the <code>type</code> property of a <code>lightColorChanged</code> event object.
     *
     * @eventType lightColorChanged
     *
     * @see sandy.core.light.Light3D
     */
	public static var LIGHT_COLOR_CHANGED:EventType = new EventType( "lightColorChanged" );

    /**
	 * Defines the value of the <code>type</code> property of a <code>scene_render</code> event object.
     *
     * @eventType scene_render
     *
     * @see sandy.core.Scene3D
     */
	public static var SCENE_RENDER:EventType = new EventType( "scene_render" );

    /**
	 * Defines the value of the <code>type</code> property of a <code>scene_cull</code> event object.
     *
     * @eventType scene_cull
     *
     * @see sandy.core.Scene3D
     */
	 public static var SCENE_CULL:EventType = new EventType( "scene_cull" );

	 /**
	 * Defines the value of the <code>type</code> property of a <code>scene_update</code> event object.
     *
     * @eventType scene_update
     *
     * @see sandy.core.Scene3D
     */
	public static var SCENE_UPDATE:EventType = new EventType( "scene_update" );

    /**
	 * Defines the value of the <code>type</code> property of a <code>scene_render_display_list</code> event object.
     *
     * @eventType scene_render_display_list
     *
     * @see sandy.core.Scene3D
     */
	public static var SCENE_RENDER_DISPLAYLIST:EventType = new EventType( "scene_render_display_list" );

	/**
	 * Defines the value of the <code>type</code> property of a <code>containerCreated</code> event object.
     * Not in use?
     *
     * @eventType containerCreated
     *
     * @see sandy.core.World3D
     */
	public static var CONTAINER_CREATED:EventType = new EventType( "containerCreated" );

    /**
	 * Defines the value of the <code>type</code> property of a <code>queueComplete</code> event object.
     * Deprecated, use QueueEvent.QUEUE_COMPLETE instead.
     *
     * @eventType queueComplete
     *
     * @see sandy.util.LoaderQueue
     */
	public static var QUEUE_COMPLETE:EventType = new EventType( "queueComplete" );

    /**
	 * Defines the value of the <code>type</code> property of a <code>queueLoaderError</code> event object.
     * Deprecated, use QueueEvent.QUEUE_LOADER_ERROR instead.
     *
     * @eventType queueLoaderError
     *
     * @see sandy.util.LoaderQueue
     */
	public static var QUEUE_LOADER_ERROR:EventType = new EventType( "queueLoaderError" );

 	/**
	 * Constructor.
	 *
	 * @param type The event type; indicates the action that caused the event.
	 * @param bubbles Specifies whether the event can bubble up the display list hierarchy.
	 * @param cancelable Specifies whether the behavior associated with the event can be prevented.
     */
	public function SandyEvent( type:EventType, bubbles:Boolean, propagation:Boolean ) 
	{
		super( type, bubbles||false, propagation||false );
	}

	/**
	 * @private
	 */
   	public function clone() : SandyEvent
    {
       return new SandyEvent( type, bubbles, propagation );
    }
	
	public var type:EventType;
	
}