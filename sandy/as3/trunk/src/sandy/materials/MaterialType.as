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
package sandy.materials 
{
	/**
	 * Represents the material types used in Sandy.
	 * 
	 * <p>Types are registered here as constant properties.<br/>
	 * If new materials are added to the Sandy library, they should be refistered here.</p> 
	 *
	 * @author		Thomas Pfeiffer - kiroukou
	 * @version		3.0
	 * @date 		26.07.2007
	 */
	public class MaterialType
	{
		/**
		 * Constant value representing the default material
		 */
		public static const NONE:MaterialType = new MaterialType("default");

		/**
		 * Constant value representing the ColorMaterial
		 */
		public static const COLOR:MaterialType = new MaterialType("color");

		/**
		 * Constant value representing the WireFrameMaterial
		 */
		public static const WIREFRAME:MaterialType = new MaterialType("wireframe");

		/**
		 * Constant value representing the BitmapMaterial
		 */
		public static const BITMAP:MaterialType = new MaterialType("bitmap");

		/**
		 * Constant value representing the MovieMaterial
		 */
		public static const MOVIE:MaterialType = new MaterialType("movie");

		/**
		 * Constant value representing the VideoMaterial
		 */
		public static const VIDEO:MaterialType = new MaterialType("video");

		/**
		 * Constant value representing the OutlineMaterial
		 */
		public static const OUTLINE:MaterialType = new MaterialType("outline");
		
		
		public function MaterialType( p_sType:String )
		{
			m_sType = p_sType;
		}
		private var m_sType:String;
	}
}