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

package sandy.core.scenegraph;

import flash.display.Sprite;

import sandy.materials.Material;

/**
* The IDisplayable interface should be implemented by all visible objects.
*
* <This ensures that all necessary methods are implemented>
*
* @author		Thomas Pfeiffer - kiroukou
* @author		Niel Drummond - haXe port
* @author		Russell Weir - haXe port
* @version		3.1
* @date 		26.07.2007
*/
interface IDisplayable
{
	function clear():Void;
	// The container of this object
	var container(__getContainer, null):Sprite;
	private function __getContainer():Sprite;

	// The depth of this object
	public var depth(__getDepth, __setDepth):Float;
	private function __getDepth():Float;
	private function __setDepth( p_nDepth:Float ):Float;

	public var changed(__getChanged,__setChanged):Bool;
	private function __getChanged():Bool;
	private function __setChanged(v:Bool):Bool;

	public var material(__getMaterial,__setMaterial):Material;
	private function __getMaterial():Material;
	private function __setMaterial(v:Material):Material;

	// Called only if the useSignelContainer property is enabled!
	function display( ?p_oContainer:Sprite ):Void;
}

