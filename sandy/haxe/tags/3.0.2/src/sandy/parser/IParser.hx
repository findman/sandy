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
import flash.events.IEventDispatcher;

import sandy.materials.Appearance;

/**
	* The IParser interface defines the interface that parser classes such as ColladaParser must implement.
	*
	* @author		Thomas Pfeiffer - kiroukou
	* @author Niel Drummond - haXe port 
	* 
	* 
	* 
	*/
interface IParser
{
		/* Identifies this parser in a ParserStack */
		public var m_sName:String;

		/**
			* This method starts the parsing process.
			*/
		public function parse():Void;

		/**
			* Creates a transformable node in the object tree of the world.
			*
			* @param p_oAppearance The default appearance that will be applied to the parsed obj
			*/
		public var standardAppearance( null, __setStandardAppearance ):Appearance;
		private function __setStandardAppearance( p_oAppearance:Appearance ):Appearance;

}

