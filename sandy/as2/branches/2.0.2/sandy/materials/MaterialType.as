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

/**
 * Represents the material types used in Sandy.
 * 
 * <p>All materialy types used in Sandy are registered here as constant properties.<br/>
 * If new materials are added to the Sandy library, they should be registered here.</p> 
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - xdevltd
 * @version		2.0.2
 * @date 		26.07.2007
 */
 
class sandy.materials.MaterialType
{

	/**
	 * Specifies the default material.
	 */
	public static var NONE:MaterialType = new MaterialType( "default" );

	/**
	 * Specifies a ColorMaterial.
	 */
	public static var COLOR:MaterialType = new MaterialType( "color" );

	/**
	 * Specifies a WireFrameMaterial.
	 */
	public static var WIREFRAME:MaterialType = new MaterialType( "wireframe" );

	/**
	 * Specifies a BitmapMaterial.
	 */
	public static var BITMAP:MaterialType = new MaterialType( "bitmap" );

	/**
	 * Specifies a MovieMaterial.
	 */
	public static var MOVIE:MaterialType = new MaterialType( "movie" );

	/**
	 * Specifies a VideoMaterial.
	 */
	public static var VIDEO:MaterialType = new MaterialType( "video" );

	/**
	 * Specifies a OutlineMaterial.
	 */
	public static var OUTLINE:MaterialType = new MaterialType( "outline" );
		
	
	public function MaterialType( p_sType:String )
	{
		m_sType = p_sType;
	}
	
	public function typeString() : String
	{
		return m_sType;
	}
	
	private var m_sType:String;

}