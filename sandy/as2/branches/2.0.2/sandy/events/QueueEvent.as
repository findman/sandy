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

import com.bourre.events.BubbleEvent;
import com.bourre.events.EventType;

/**
 * Contains events use for loading resources.
 *
 * @author	(porting) Floris - FFlasher
 * @version	3.0
 *
 * @see sandy.util.LoaderQueue
 * @see BubbleEventBroadcaster
 */
class sandy.events.QueueEvent extends BubbleEvent
{
	private var _loaders:Object;
	
	public var type:EventType;

    /**
	 * Defines the value of the <code>type</code> property of a <code>queueComplete</code> event object.
     *
     * @eventType queueComplete
     */
	public static var QUEUE_COMPLETE:EventType = new EventType( "queueComplete" );

    /**
	 * Defines the value of the <code>type</code> property of a <code>queueResourceLoaded</code> event object.
     *
     * @eventType queueResourceLoaded
     */
	public static var QUEUE_RESOURCE_LOADED:EventType = new EventType( "queueResourceLoaded" );

    /**
	 * Defines the value of the <code>type</code> property of a <code>queueLoaderError</code> event object.
     *
     * @eventType queueLoaderError
     */
	public static var QUEUE_LOADER_ERROR:EventType = new EventType( "queueLoaderError" );

 	/**
	 * Constructor.
	 *
	 * @param type The event type; indicates the action that caused the event.
	 * @param bubbles Specifies whether the event can bubble up the display list hierarchy.
	 * @param cancelable Specifies whether the behavior associated with the event can be prevented.
     */
	public function QueueEvent( type:EventType, bubbles:Boolean, propagation:Boolean )
	{
		super( type, bubbles||false, propagation||false );
		_loaders = loaders;
	}

    /**
     * Someone care to explain?
     */
	public function get loaders() : Object
	{
		return _loaders;
	}

	/**
	 * @private
	 */
	public function set loaders( loaderObject:Object ) : Void
	{
		_loaders = loaderObject;
	}

	/**
	 * @private
	 */
	public function clone() : QueueEvent
    {
    	var e:QueueEvent = new QueueEvent( type, bubbles, propagation );
    	e.loaders = _loaders;
        return e;
    }
	
}
