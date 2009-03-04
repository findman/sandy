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

package sandy.util;

import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;

import sandy.events.QueueEvent;
import sandy.events.SandyEvent;

/*
[Event(name="queueComplete", type="sandy.events.QueueEvent")]
[Event(name="queueResourceLoaded", type="sandy.events.QueueEvent")]
[Event(name="queueLoaderError", type="sandy.events.QueueEvent")]
*/
/**
* Utility class for loading resources.
*
* <p>A LoaderQueue allows you to queue up requests for loading external resources.</p>
*
* @author		Thomas Pfeiffer - kiroukou /Max Pellizzaro
* @author		Niel Drummond - haXe port
* @author		Russell Weir - haXe port
* @version		3.1
* @date 		07.16.2008
*/

class LoaderQueue extends EventDispatcher
{
	/**
	* Specifies the Image type of object to load
	*/
	static public inline var IMG:String = "IMG";
	/**
	* Specifies the SWF type of object to load
	*/
	static public inline var SWF:String = "SWF";
	/**
	* Specifies the Binary type of object to load
	*/
	static public inline var BIN:String = "BIN";

	private var m_oLoaders : Hash<QueueElement>;
	private var m_nLoaders : Int;
	private var m_oQueueCompleteEvent : QueueEvent;
	private var m_oQueueResourceLoadedEvent : QueueEvent;
	private var m_oQueueLoaderError : QueueEvent;

	public var data:Hash<Dynamic>;
	public var clips:Hash<LoaderInfo>;
	/**
	 * Creates a new loader queue.
	 *
	 */
	public function new()
	{
		data = new Hash();
		clips = new Hash();
		super();
		m_oLoaders = new Hash();
		m_oQueueCompleteEvent 		= new QueueEvent ( QueueEvent.QUEUE_COMPLETE );
		m_oQueueResourceLoadedEvent = new QueueEvent ( QueueEvent.QUEUE_RESOURCE_LOADED );
		m_oQueueLoaderError 		= new QueueEvent ( QueueEvent.QUEUE_LOADER_ERROR );
	}

	/**
	 * Adds a new request to this loader queue.
	 *
	 * <p>The request is given its own loader and is added to a loader queue<br/>
	 * The loding is postponed until the start method of the queue is called.</p>
	 *
	 * @param p_sID		A string identifier for this request
	 * @param p_oURLRequest	The request
	 */
	public function add( p_sID : String, p_oURLRequest : URLRequest, type:String = "IMG" ) : Void
	{
		if(type == BIN) {
			var tmpLoader = new URLLoader ();
			tmpLoader.dataFormat = URLLoaderDataFormat.BINARY;
			m_oLoaders.set( p_sID, new QueueElement( p_sID, null, tmpLoader, p_oURLRequest ));
		}
		else {
			m_oLoaders.set( p_sID, new QueueElement( p_sID, new Loader(), null, p_oURLRequest ) );
		}
		// --
		m_nLoaders++;
	}

	private function getIDFromLoader( p_oLoader:Loader ):String
	{
		for ( l_oElement in m_oLoaders )
		{
			if( p_oLoader == l_oElement.loader )
				return l_oElement.name;
		}
		return null;
	}

	private function getIDFromURLLoader( p_oLoader:URLLoader ):String
	{
		for ( l_oElement in m_oLoaders )
		{
			if( p_oLoader == l_oElement.urlLoader )
			{
				return l_oElement.name;
			}
		}
		return null;
	}

	/**
	 * Starts the loading of all resources in the queue.
	 *
	 * <p>All loaders in the queue are started and IOErrorEvent and the COMPLETE event are subscribed to.</p>
	 */
	public function start() : Void
	{
		var noLoaders = true;
		for ( l_oLoader in m_oLoaders )
		{
			noLoaders = false;
			if (l_oLoader.loader != null) {
				l_oLoader.loader.load( l_oLoader.urlRequest );
				l_oLoader.loader.contentLoaderInfo.addEventListener( Event.COMPLETE, completeHandler );
				l_oLoader.loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
			} else {
				l_oLoader.urlLoader.load( l_oLoader.urlRequest );
				l_oLoader.urlLoader.addEventListener( Event.COMPLETE, completeHandler );
	            l_oLoader.urlLoader.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
			}
		}
		if (noLoaders) {
			// still need to dispatch complete event
			m_oQueueCompleteEvent.loaders = m_oLoaders;
			dispatchEvent( m_oQueueCompleteEvent );
		}
	}

	/**
	 * Fires a QueueEvent, once all requested resources are loaded.
	 * Type QUEUE_COMPLETE
	 */
	private function completeHandler( p_oEvent:Event ) : Void
	{
		var l_sName:String = null;
		var l_oLoaderInfos:LoaderInfo = p_oEvent.target;

		// Fire an event to indicate that a single resource loading was completed (needs to be enhanced to provide more info)
		dispatchEvent( m_oQueueResourceLoadedEvent );

		if (Std.is(p_oEvent.target, flash.net.URLLoader)) {
			var l_oLoader:URLLoader = p_oEvent.target;
			l_sName = getIDFromURLLoader( l_oLoader );
			data.set( l_sName, l_oLoader.data);
			clips.set( l_sName, l_oLoaderInfos);
		} else {
			var l_oLoader:Loader = l_oLoaderInfos.loader;
			l_sName = getIDFromLoader( l_oLoader );
			data.set( l_sName, l_oLoaderInfos.content );
			clips.set( l_sName, l_oLoaderInfos);
		}
		// --
		m_nLoaders--;
		// --
		if( m_nLoaders == 0 )
		{
			m_oQueueCompleteEvent.loaders = m_oLoaders;
			dispatchEvent( m_oQueueCompleteEvent );
		}
	}

	/**
	 * Fires an error event if any of the loaders didn't succeed
	 *
	 */
	private function ioErrorHandler( p_oEvent : IOErrorEvent ) : Void
	{
		// Fire an event to indicate that a single resource loading failed (needs to be enhanced to provide more info)
		dispatchEvent( m_oQueueLoaderError );

		m_nLoaders--;

		if( m_nLoaders == 0 )
		{
			m_oQueueCompleteEvent.loaders = m_oLoaders;
			dispatchEvent( m_oQueueCompleteEvent );
		}
	}
}

class QueueElement
{
	public var name:String;
	public var loader:Loader;
	public var urlLoader:URLLoader;
	public var urlRequest:URLRequest;

	// --
	public function new( p_sName:String, p_oLoader:Loader, u_oLoader:URLLoader, p_oURLRequest : URLRequest )
	{
		name = p_sName;
		loader = p_oLoader;
		urlRequest = p_oURLRequest;
		urlLoader = u_oLoader;
	}

}
