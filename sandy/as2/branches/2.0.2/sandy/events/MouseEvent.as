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

import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;

/**
 * MouseEvents, based on the AS3 MouseEvent class.
 *
 * @author	Thomas Pfeiffer
 * @author	(porting) Floris - FFlasher
 * @version	2.0.2
 */
 
class sandy.events.MouseEvent extends BasicEvent 
{
	
	public static var CLICK:EventType = new EventType( "MouseClickEVENT" );
	
	public static var MOUSE_UP:EventType = new EventType( "MouseUpEVENT" );
	
	public static var MOUSE_DOWN:EventType = new EventType( "MouseDownEVENT" );
	
	public static var ROLL_OVER:EventType = new EventType( "MouseRollOverEVENT" );
	
	public static var ROLL_OUT:EventType = new EventType( "MouseRollOutEVENT" );
	
	public static var MOUSE_WHEEL:EventType = new EventType( "MouseClickEVENT" );
	
	public static var MOUSE_OUT:EventType = new EventType( "MouseUpEVENT" );
	
	public static var MOUSE_OVER:EventType = new EventType( "MouseDownEVENT" );
	
	public static var MOUSE_MOVE:EventType = new EventType( "MouseRollOverEVENT" );
		
	public function MouseEvent( e : EventType, oT ) 
	{
		super( e, oT );
	}

}