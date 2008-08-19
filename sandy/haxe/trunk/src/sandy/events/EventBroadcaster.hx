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
import flash.utils.Dictionary;

import sandy.commands.Delegate;

/**
 * Perhaps a dev can enlighten us ;)
 *
 * 
 */
class EventBroadcaster
{
    private var m_oAll:Hash<Dynamic>;
    private var m_oType:Hash<Hash<Dynamic>>;
    private var m_oEventListener:Hash<Hash<Dynamic>>;
    private var m_oDelegateDico:Hash<Dynamic>;
    private var listeners:Array<Dynamic>;

    public function new()
    {
     m_oAll = new Hash();
     m_oType = new Hash();
     m_oEventListener = new Hash();
     m_oDelegateDico = new Hash();
    }

    public function isRegistered(listener:Dynamic, ?type:String):Null<Bool>
	{
		if (type == null)
		{
			return m_oAll.get(listener);
		}
		else
		{
			if (m_oType.get(type) != null)
			{
				for (lElt in m_oType.get(type))
				{
					if (lElt == listener)
					{
						return true;
					}
				}

				return false;
			}
			else
			{
				return false;
			}
		}
	}

    public function removeListenerCollection(type:String):Void
	{
		m_oType.set(type, null);
	}

    public function getListenerCollection(?type:String):Hash<Dynamic>
	{
		return (type != null) ? m_oType.get(type) : m_oAll;
	}

	public function addEventListener(type:String, listener:Dynamic, ?rest:Array<Event>):Null<Bool>
	{

		if (Reflect.isFunction(listener))
		{
			var d:Delegate = new Delegate(listener);

			if (rest != null)
			{
				d.setArgumentsArray(rest);
			}

			m_oDelegateDico.set(Std.string(listener), d);
			listener = d;

		}
		else if (listener.hasOwnProperty(type) && (Reflect.isFunction(listener.get(type))))
		{
			//

		}
		else if (listener.hasOwnProperty("handleEvent") && Reflect.isFunction(listener.handleEvent))
		{
			//

		}
		else
		{
			return false;	//ERROR CASE
		}

		if (!isRegistered(listener))
		{
			if ((m_oType.get(type) == null))
			{
				m_oType.set(type, new Hash());
			}
			// --
			var lDico:Hash<Dynamic> = getListenerCollection(type);

			if (lDico.get(listener) == null)
			{
				lDico.set(listener, listener);
				_storeRef(type, listener);
				return true;
			}
		}

		return false;
	}

	public function hasListenerCollection(type:String):Null<Bool>
	{
		return (m_oType.get(type) != null);
	}

	public function removeEventListener(type:String, listener:Dynamic):Null<Bool>
	{
		if (hasListenerCollection(type))
		{
			var c:Hash<Dynamic> = getListenerCollection(type);
			if (Reflect.isFunction(listener))
			{
				listener = m_oDelegateDico.get(Std.string(listener));
			}
			// --
			if (c.get(listener) != null)
			{
				_removeRef(type, listener);
				if (isDicoEmpty(c))
				{
					removeListenerCollection(type);
				}

				c.remove(Std.string(listener));

				return true;
			}
			else
			{
				return false;
			}
		}
		else
		{
			return false;
		}
	}

	public function broadcastEvent(e:Event):Void
	{
		if (hasListenerCollection(e.type))
		{
			_broadcastEvent( getListenerCollection(e.type), e );
		}
		//
		if (!isDicoEmpty(m_oAll))
		{
			_broadcastEvent(m_oAll, e);
		}
	}

	public function _broadcastEvent(c:Hash<Dynamic>, e:Event):Void
	{
		var type:String = e.type;

		for (listener in c)
		{
			if (listener.hasOwnProperty(type) && Reflect.isFunction(listener.get(type)))
			{
				listener.get(type)(e);

			}
			else if (listener.hasOwnProperty("handleEvent") && Reflect.isFunction(listener.handleEvent))
			{
				listener.handleEvent(e);

			}
			else
			{
				//ERROR
			}
		}
	}

	private function _removeRef(type:String, listener:Dynamic):Void
	{
		var m:Hash<Dynamic> = m_oEventListener.get(Std.string(listener));
		m.remove( type );

		if (isDicoEmpty(m))
		{
			m_oEventListener.remove( Std.string(listener) );
		}
	}

	private function _storeRef(type:String, listener:Dynamic):Void
	{
		if (m_oEventListener.get(listener) == null)
		{
			m_oEventListener.set(listener, new Hash());
		}
		m_oEventListener.get(Std.string(listener)).set(type, listener);
	}

	private function isDicoEmpty(pDico:Hash<Dynamic>):Null<Bool>
	{
		var i:Null<Int> = 0;
		for (lElt in pDico)
		{
			i++;
		}
		return (i == 0);
	}
}

