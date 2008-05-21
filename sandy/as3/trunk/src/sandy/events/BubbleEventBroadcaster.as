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
	 * BubbleEventBroadcaster defines a custom event broadcaster to work with.
	 *
	 * @author	Thomas Pfeiffer - kiroukou
	 * @version	3.0
	 */
	public final class BubbleEventBroadcaster extends EventBroadcaster
	{
		private var m_oParent:BubbleEventBroadcaster = null;

	 	/**
		 * Constructor.
	     */
		public function BubbleEventBroadcaster()
		{
			super();
		}

		/**
		 * Starts receiving bubble events from specified child.
		 *
		 * @param child	A BubbleEventBroadcaster instance that will send bubble events.
		 */
		public function addChild(child:BubbleEventBroadcaster):void
		{
			child.parent = this;
		}

		/**
		 * Stops receiving bubble events from specified child.
		 * <p>[<strong>ToDo</strong>: This method has very bad implementation and disabled for the moment. ]</p>
		 *
		 * @param child	A BubbleEventBroadcaster instance that will stop sending bubble events.
		 */
		public function removeChild(child:BubbleEventBroadcaster):void
		{
			//child.parent = null;
		}

	 	/**
		 * The parent of this broadcaster.
	     */
		public function get parent():BubbleEventBroadcaster
		{
			return m_oParent;
		}

		/**
		 * @private
		 */
		public function set parent(pEB:BubbleEventBroadcaster):void
		{
			m_oParent = pEB;
		}

		/**
		 * @private
		 */
		public override function broadcastEvent(e:Event):void
		{
			if (e is BubbleEvent)
			{
				super.broadcastEvent(e);

				if (parent)
				{
					parent.broadcastEvent(e);
				}
			}
			else
			{
				parent.broadcastEvent(e); // used for regular event dispatching
			}
		}

	}
}