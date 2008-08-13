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
import com.bourre.events.EventType;
import com.bourre.events.IEvent;
import com.bourre.events.BasicEvent;

/**
 * Contains custom Sandy events.
 *
 * @author	Dennis Ippel
 * @author 	Floris van Veen - Floris
 * @version	2.0
 *
 * @see BubbleEventBroadcaster
 */
class sandy.events.SandyEvent extends BasicEvent 
{
    /**
     * Indicates that a light has been added to a Scene3D object.
     *
     * @eventType lightAdded
     *
     * @see sandy.core.Scene3D
     */
	public static var LIGHT_ADDED:EventType = new EventType( 'lightAdded' );
	
	/**
 	* Indicates that the Light3D object of the scene has been updated.
    *
    * @eventType lightUpdated
    *
    * @see sandy.core.light.Light3D
    */
	public static var LIGHT_UPDATED:EventType = new EventType( 'lightUpdated' );

	/**
     * Indicates that the color of the light has changed.
     *
     * @eventType lightColorChanged
     *
     * @see sandy.core.light.Light3D
     */
	public static var LIGHT_COLOR_CHANGED:EventType = new EventType( 'lightColorChanged' );

    /**
     * Indicates the scene has been rendered.
     *
     * @eventType scene_render
     *
     * @see sandy.core.Scene3D
     */
	public static var SCENE_RENDER:EventType = new EventType( 'scene_render' );

	/**
     * Indicates the scene has been culled.
     *
     * @eventType scene_cull
     *
     * @see sandy.core.Scene3D
     */
	public static var SCENE_CULL:EventType = new EventType( 'scene_cull' );

	/**
     * Indicates the scene has been updated.
     *
     * @eventType scene_update
     *
     * @see sandy.core.Scene3D
     */
	public static var SCENE_UPDATE:EventType = new EventType( 'scene_update' );

    /**
     * Indicates the display list has been rendered.
     *
     * @eventType scene_render_display_list
     *
     * @see sandy.core.Scene3D
     */
	public static var SCENE_RENDER_DISPLAYLIST:EventType = new EventType( 'scene_render_display_list' );

	/**
     * Not in use?
     *
     * @eventType containerCreated
     *
     * @see sandy.core.World3D
     */
	public static var CONTAINER_CREATED:EventType = new EventType( 'containerCreated' );

    /**
     * Uneeded? Also in QueueEvent class...
     *
     * @eventType queueComplete
     *
     * @see sandy.util.LoaderQueue
     */
	public static var QUEUE_COMPLETE:EventType = new EventType( 'queueComplete' );

	/**
     * Uneeded? Also in QueueEvent class...
     *
     * @eventType queueLoaderError
     *
     * @see sandy.util.LoaderQueue
     */
	public static var QUEUE_LOADER_ERROR:EventType = new EventType( 'queLoaderError' );

	private var e:EventType;
	
	private var oT;
	
	/**
	 * Constructor.
	 *
	 * @param type The event type; indicates the action that caused the event.
     */
	public function SandyEvent( e:EventType, oT, np:Number, ps:String ) 
	{
		super( e, oT );
	}

	/**
	 * @private
	 */

   	public function clone() : SandyEvent
    {
       return new SandyEvent( e, oT );
    }
}