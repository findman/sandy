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
 * <p>Types are registered here as constant properties.<br/>
 * If new materials are added to the Sandy library, they should be refistered here.</p> 
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 */
enum MaterialType 
{
		NONE;
		COLOR;
		WIREFRAME;
		BITMAP;
		MOVIE;
		VIDEO;
		OUTLINE;
}

//  class MaterialType
//  {
//  	//---------//
//  	//Constants//
//  	//---------//
//  	/**
//  	 * Constant value representing the default material
//  	 */
//  	public static var NONE:MaterialType = new MaterialType("default");
//  
//  	/**
//  	 * Constant value representing the ColorMaterial
//  	 */
//  	public static var COLOR:MaterialType = new MaterialType("color");
//  
//  	/**
//  	 * Constant value representing the WireFrameMaterial
//  	 */
//  	public static var WIREFRAME:MaterialType = new MaterialType("wireframe");
//  
//  	/**
//  	 * Constant value representing the BitmapMaterial
//  	 */
//  	public static var BITMAP:MaterialType = new MaterialType("bitmap");
//  
//  	/**
//  	 * Constant value representing the MovieMaterial
//  	 */
//  	public static var MOVIE:MaterialType = new MaterialType("movie");
//  
//  	/**
//  	 * Constant value representing the VideoMaterial
//  	 */
//  	public static var VIDEO:MaterialType = new MaterialType("video");
//  
//  	/**
//  	 * Constant value representing the OutlineMaterial
//  	 */
//  	public static var OUTLINE:MaterialType = new MaterialType("outline");
//  	
//  	public function new( p_sType:String )
//  	{
//  		m_sType = p_sType;
//  	}
//  	private var m_sType:String;
//  }
//  
