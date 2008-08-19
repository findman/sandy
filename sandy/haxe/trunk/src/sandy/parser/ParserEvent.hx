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

package sandy.parser;

import flash.events.Event;

import sandy.core.scenegraph.Group;

/**
 * Events that are used by the Parser classes.
 * 
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 **/
 
class ParserEvent extends Event
{
	/**
     * The load has failed
     */
    static public inline var FAIL:String = 'onFailEVENT';
    /**
     * The OBject3D object is initialized
     */
    static public inline var INIT:String = 'onInitEVENT';
    /**
     * The load has started
     */
    static public inline var LOAD:String = 'onLoadEVENT';
	/**
	 *  The load is in progress
	 */
	public static inline var PROGRESS:String = 'onProgressEVENT';
	
	/**
	 * Parsing is in progress
	 */
	public static inline var PARSING:String = 'onParsingEVENT';
	
	public var percent:Float;
	public var group:Group;

	/**
	 * The ParserEvent constructor
	 * 
	 * @param p_sType		The event type string
	 */
	public function new( p_sType:String )
	{
		super( p_sType );
	}
}

