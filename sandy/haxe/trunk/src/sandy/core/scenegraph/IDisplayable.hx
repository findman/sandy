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

import sandy.core.Scene3D;

/**
 * The IDisplayable interface should be implemented by all visible objects.
 * 
 * <This ensures that all necessary methods are implemented>
 * 
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 */
interface IDisplayable
{
	function clear():Void;
	// The container of this object
	var container(__getContainer, null):Sprite;	
	private function __getContainer():Sprite;	
	// The depth of this object
	public var depth(__getDepth, __setDepth):Null<Float>;
	private function __getDepth():Null<Float>;
	private function __setDepth( p_nDepth:Null<Float> ):Null<Float>;
	// Called only if the useSignelContainer property is enabled!
	function display( p_oScene:Scene3D, ?p_oContainer:Sprite ):Void;
}

