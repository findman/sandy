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
import flash.net.URLRequest;

import sandy.events.QueueEvent;
import sandy.events.SandyEvent;

/*
[Event(name="queueComplete", type="sandy.events.QueueEvent")]
[Event(name="queueLoaderError", type="sandy.events.QueueEvent")]
*/

      	/**
 * Utility class for loading resources.
 *
 * <p>A LoaderQueue allows you to queue up requests for loading external resources</p>
 * 
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 */
class LoaderQueue extends EventDispatcher
{
	private var m_oLoaders : Hash<QueueElement>;
	private var m_nLoaders : Int;
	private var m_oQueueEvent : QueueEvent;
	
	public var data:Hash<DisplayObject>;
	/**
	 * Creates a new loader queue.
	 *
	 */
	public function new()
	{
	 data = new Hash();

  super();

		m_oLoaders = new Hash();
		m_oQueueEvent = new QueueEvent( QueueEvent.QUEUE_COMPLETE );
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
	public function add( p_sID : String, p_oURLRequest : URLRequest ) : Void
	{
		m_oLoaders.set( p_sID, new QueueElement( p_sID, new Loader(), p_oURLRequest ) );
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
	
	/**
	 * Starts the loading of all resources in the queue.
	 *
	 * <p>All loaders in the queue are started and IOErrorEvent and the COMPLETE event are subscribed to.</p>
	 */
	public function start() : Void
	{
		for ( l_oLoader in m_oLoaders )
		{
			l_oLoader.loader.load( l_oLoader.urlRequest );
			l_oLoader.loader.contentLoaderInfo.addEventListener( Event.COMPLETE, completeHandler );
			l_oLoader.loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
		}
	}
	
	/**
	 * Fires a QueueEvent, once all requested resources are loaded.
	 * Type QUEUE_COMPLETE
	 */
	private function completeHandler( p_oEvent:Event ) : Void
	{		
		var l_oLoaderInfos:LoaderInfo = p_oEvent.target;
		var l_oLoader:Loader = l_oLoaderInfos.loader;
		
		var l_sName:String = getIDFromLoader( l_oLoader );
		data.set( l_sName, l_oLoaderInfos.content );
		// --
		m_nLoaders--;
		// --
		if( m_nLoaders == 0 ) 
		{
			m_oQueueEvent.loaders = m_oLoaders;
			dispatchEvent( m_oQueueEvent );
		}
	}
	
	/**
	 * Fires an error event if any of the loaders didn't succeed
	 *
	 */
	private function ioErrorHandler( p_oEvent : IOErrorEvent ) : Void
	{	
		m_nLoaders--;
		
		if( m_nLoaders == 0 ) 
		{
			m_oQueueEvent.loaders = m_oLoaders;
			dispatchEvent( m_oQueueEvent );
		}
	}
}

import flash.display.Loader;
import flash.net.URLRequest;

class QueueElement
{
 
 public var name:String;
 public var loader:Loader;
 public var urlRequest:URLRequest;
 // --
 public function new( p_sName:String, p_oLoader:Loader, p_oURLRequest : URLRequest )
 {
 	name = p_sName;
 	loader = p_oLoader;
 	urlRequest = p_oURLRequest;
 }
 
}
