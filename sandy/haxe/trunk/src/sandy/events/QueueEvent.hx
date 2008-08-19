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
import sandy.util.LoaderQueue;

/**
 * Conatains events use for loading resources.
 *
 * 
 *
 * @see sandy.util.LoaderQueue
 * @see BubbleEventBroadcaster
 */
class QueueEvent extends Event
{
	private var _loaders:Hash<QueueElement>;

    /**
     * Indicates a resource has been loaded.
     *
     * @eventType queueComplete
     */
	public static inline var QUEUE_COMPLETE:String = "queueComplete";

    /**
     * Indicates an error was encountered while loading a resource.
     *
     * @eventType queueLoaderError
     */
	public static inline var QUEUE_LOADER_ERROR:String = "queueLoaderError";

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

		_loaders = loaders;
	}

    /**
     * Someone care to explain?
     */
	public var loaders(__getLoaders,__setLoaders):Hash<QueueElement>;
	private function __getLoaders():Hash<QueueElement>
	{
		return _loaders;
	}

	/**
	 * @private
	 */
	private function __setLoaders(loaderObject:Hash<QueueElement>):Hash<QueueElement>
	{
		_loaders = loaderObject;
		return loaderObject;
	}

	/**
	 * @private
	 */
	override public function clone():Event
    {
    	var e:QueueEvent = new QueueEvent(type, bubbles, cancelable);
    	e.loaders = _loaders;
        return e;
    }
}

