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

class EventListener
{
   public var mListner : Dynamic->Void;
   static var sIDs = 1;
   public var mID:Int;

   public function new(inListener)
   {
      mListner = inListener;
      mID = sIDs++;
   }

   public function Is(inListener)
   {
      return Reflect.compareMethods(mListner,inListener);
   }

   public function dispatchEvent(event : Event)
   {
      mListner(event);
   }
}

typedef EventListenerList = Array<EventListener>;

typedef EventMap = Hash<EventListenerList>;

class EventBroadcaster 
{
   var mEventMap : EventMap;

   public function new() : Void
   {
      mEventMap = new EventMap();
   }

			public function addEventListener(type:String, listener:Dynamic->Void):Bool
   {
      var list = mEventMap.get(type);
      if (list==null)
      {
         list = new EventListenerList();
         mEventMap.set(type,list);
      }

      var l =  new EventListener(listener);

						for ( i in 0...list.length )
								if (list[i].mID == l.mID ) return false;
      list.push(l);

      return true;
   }

			public function broadcastEvent(event:Event):Void
   {
      var list = mEventMap.get(event.type);
      if (list!=null)
      {
         for(i in 0...list.length)
         {
            var listener = list[i];
               listener.dispatchEvent(event);
         }
      }
   }

   public function hasEventListener(type : String)
   {
      return mEventMap.exists(type);
   }

			public function removeEventListener(type:String, listener:Dynamic->Void):Bool
   {
      if (!mEventMap.exists(type)) return false;

      var list = mEventMap.get(type);
      for(i in 0...list.length)
      {
         if (list[i].Is(listener))
         {
             list.splice(i,1);
             return true;
         }
      }
						return false;
   }
}


