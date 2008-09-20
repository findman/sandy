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
 * Implementation of the AS3 KeyboardEvent class.
 *
 * @author	Floris - xdevltd
 * @version	2.0.2
 */
 
class sandy.events.KeyboardEvent extends BasicEvent 
{
	
	public static var KEY_DOWN:EventType = new EventType( "KeyDownEVENT" );
	
	public static var KEY_UP:EventType = new EventType( "KeyUpEVENT" );
		
	public function KeyboardEvent( e:EventType, oT ) 
	{
		super( e, oT );
	}

}