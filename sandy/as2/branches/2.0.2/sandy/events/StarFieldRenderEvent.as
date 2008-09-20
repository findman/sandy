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
	
import flash.display.BitmapData;

import sandy.core.scenegraph.StarField;

/**
 * This class represents the type of events broadcasted by StarField objects.
 * It gives you some additional control over StarField rendering process.
 *
 * @author	(porting) Floris - xdevltd
 * @version 2.0.2
 *
 * @see sandy.core.scenegraph.StarField
 */
 
class sandy.events.StarFieldRenderEvent extends BubbleEvent
{
	
	/**
	 * Constructs a new StarFieldRenderEvent instance.
	 *
	 * @param e				A name for the event.
	 * @param p_oStarField		The StarField object reference.
	 * @param p_oBitmapData		The BitmapData object reference.
	 * @param p_bClear		Clearing flag.
	 *
	 * @see sandy.core.scenegraph.StarField
	 */
	public function StarFieldRenderEvent( e:EventType, p_oStarField:StarField, p_oBitmapData:BitmapData, p_bClear:Boolean )
	{
		super( e, p_oStarField );
		bitmapData = p_oBitmapData;
		clear = p_bClear;
	}

	/**
	 * The BitmapData object reference.
	 */
	public var bitmapData:BitmapData = null;

	/**
	 * A flag indicating if BitmapData should be cleared by StarField after event.
	 * Setting this to false in BEFORE_RENDER event will force StarField to keep last frame image.
	 */
	public var clear:Boolean;

	/**
	 * Defines the value of the <code>type</code> property of a <code>beforeRender</code> event object.
	 *
	 * @eventType beforeRender
	 *
	 * @see sandy.core.scenegraph.StarField
	 */
	public static var BEFORE_RENDER:EventType = new EventType( "beforeRender" );

	/**
	 * Defines the value of the <code>type</code> property of a <code>afterRender</code> event object.
	 *
	 * @eventType afterRender
	 *
	 * @see sandy.core.scenegraph.StarField
	 */
	public static var AFTER_RENDER:EventType = new EventType( "afterRender" );
		
}