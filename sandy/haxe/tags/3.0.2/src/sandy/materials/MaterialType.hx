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

package sandy.materials;

/**
 * Represents the material types used in Sandy.
 * 
 * <p>All materialy types used in Sandy are registered here as constant properties.<br/>
 * If new materials are added to the Sandy library, they should be registered here.</p> 
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 */
enum MaterialType 
{

	/**
	 * Specifies the default material.
	 */
		NONE;

	/**
	 * Specifies a ColorMaterial
	 */
		COLOR;

	/**
	 * Specifies a WireFrameMaterial
	 */
		WIREFRAME;

	/**
	 * Specifies a BitmapMaterial
	 */
		BITMAP;

	/**
	 * Specifies a MovieMaterial
	 */
		MOVIE;

	/**
	 * Specifies a VideoMaterial
	 */
		VIDEO;

	/**
	 * Specifies a OutlineMaterial
	 */
		OUTLINE;
}
