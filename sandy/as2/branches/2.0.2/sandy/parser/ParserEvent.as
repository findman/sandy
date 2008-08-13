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

import sandy.core.scenegraph.Group;

/**
* Class of the Parser events.
* @author 		Thomas Pfeiffer - kiroukou
* @author 		Floris van Veen - Floris
* @version 		2.0
* @date 		15.06.2008
*/

class sandy.parser.ParserEvent extends BasicEvent 
{
	
	/**
	* The load has failed
	*/
	public static var FAIL:EventType = new EventType( 'onFailEVENT' );
	/**
	* The Object3D object is initialized
	*/
	public static var INIT:EventType = new EventType( 'onInitEVENT' );
	/**
	* The load has started
	*/
	public static var LOAD:EventType = new EventType( 'onLoadEVENT' );
		
	/**
	* Parsing is in progress
	*/
	public static var PROGRESS:EventType = new EventType( 'onProgressEVENT' );
		
	public var group:Group;	
	
	public var percent:Number;
	
	public var message:String;
	
	public function ParserEvent( e:EventType, oT, np:Number, ps:String ) 
	{
		super( e, oT );
	}
	
}