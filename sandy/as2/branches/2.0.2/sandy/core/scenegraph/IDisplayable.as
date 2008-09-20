/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author or authors.
Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 ( the "License" );
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

import sandy.core.Scene3D;
	
/**
 * The IDisplayable interface should be implemented by all visible objects.
 * 
 * <This ensures that all necessary methods are implemented>
 * 
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - xdevltd
 * @version		2.0
 * @date 		26.07.2007
 */
 
interface sandy.core.scenegraph.IDisplayable
{
	
	function clear() : Void;
		
	// Called only if the useSingleContainer property is enabled!
	function display( p_oScene:Scene3D, p_oContainer:MovieClip ) : Void;
	
}