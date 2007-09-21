﻿/*
 * Copyright the original author or authors.
 *
 * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.mozilla.org/MPL/MPL-1.1.html
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package sandy.events
{
	import flash.events.Event;


	/**
	 *
	 *
	 */
	public final class BubbleEventBroadcaster extends EventBroadcaster
	{
		private var m_oParent:BubbleEventBroadcaster = null;

		/**
		 *
		 *
		 */
		public function BubbleEventBroadcaster()
		{
			super();
		}

		/**
		 *
		 *
		 */
		public function set parent( pEB:BubbleEventBroadcaster ):void
		{
			m_oParent = pEB;
		}

		/**
		 *
		 *
		 */
		public function get parent():BubbleEventBroadcaster
		{
			return m_oParent;
		}


		/**
		 * Starts receiving bubble events from passed-in child.
		 *
		 * @param child a {@link BubbleEventBroadcaster} instance that will send bubble events.
		 */
		public function addChild( child : BubbleEventBroadcaster ) : void
		{
			child.parent = this;
		}

		/**
		 * Stops receiving bubble events from passed-in child.
		 *
		 * @param child a {@link BubbleEventBroadcaster} instance that will stop
		 * to send bubble events.
		 */
		public function removeChild( child : BubbleEventBroadcaster ) : void
		{
			child.parent = null;
		}

		/**
		 *
		 *
		 */
		public override function broadcastEvent( e : Event ) : void
		{
			if( e is BubbleEvent )
			{
				super.broadcastEvent( e );
				if ( parent )
				{
					parent.broadcastEvent( e );
				}
			}
		}

	}
}