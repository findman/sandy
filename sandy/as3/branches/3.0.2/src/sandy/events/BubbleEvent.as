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

package sandy.events
{
	import flash.events.Event;

	/**
	 * BubbleEvent defines a custom event type to work with.
	 *
	 * @author	Thomas Pfeiffer
	 * @version	3.0
	 *
	 * @see BubbleEventBroadcaster
	 */
	public class BubbleEvent extends Event
	{
		private var m_oTarget:Object;
		//private var m_sType:String;

		/**
		 * Creates a new BubbleEvent instance.
	 	 *
		 * @example
		 * <listing version="3.0">
		 *   var e:BubbleEvent = new BubbleEvent(MyClass.onSomething, this);
		 * </listing>
		 *
		 * @param e		A name for the event.
		 * @param oT	The event target.
		 */
		public function BubbleEvent(e:String, oT:Object)
		{
			super(e, true, true);
			m_oTarget = oT;
		}

		/**
		 * The event target.
		 */
		public override function get target():Object
		{
			return m_oTarget;
		}

		/**
		 * Returns the string representation of this instance.
		 *
		 * @return String representation of this instance
		 */
		public override function toString():String
		{
			return "BubbleEvent";
		}
	}
}