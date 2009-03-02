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

import sandy.core.Scene3D;

/**
 * The MaterialManager class is used to keep track of all materials used in a scene.
 *
 * @see sandy.core.Scene3D
 **/
class MaterialManager
{

	/**
	 * Creates a new MaterialManager object.
	 **/
	public function new()
	{
	 m_aList = new Array();
	}

	private var m_aList:Array<Material>;
	
	/**
	 * Determines whether a material is registered in the material manager.
	 *
	 * @param p_oMaterial	The material to check for.
	 *
	 * @return Whether the material is registered.
	 */
	public function isRegistered( p_oMaterial:Material ):Bool
	{
		for(i in 0...m_aList.length )
		{
			if( m_aList[i] == p_oMaterial )
			{
				return true;
			}
		}
		return false;
	}
	
	/**
	 * Calls the <code>begin()</code> method of all materials in the material manager.
	 *
	 * @param p_oScene	The scene.
	 */
	public function begin( p_oScene:Scene3D ):Void
	{
		for ( l_oMaterial in m_aList )
			l_oMaterial.begin( p_oScene );
	}
	
	/**
	 * Calls the <code>finish()</code> method of all materials in the material manager.
	 *
	 * @param p_oScene	The scene.
	 */
	public function finish( p_oScene:Scene3D ):Void
	{
		for ( l_oMaterial in m_aList )
			l_oMaterial.finish( p_oScene );
	}
	
	/**
	 * Registers a material with the material manager.
	 *
	 * @param p_oMaterial	The material to register.
	 */
	public function register( p_oMaterial:Material ):Void
	{
		m_aList.push( p_oMaterial );
	}
	
	/**
	 * Removes a material from the material manager.
	 *
	 * @param p_oMaterial	The material to remove.
	 */
	public function unregister( p_oMaterial:Material ):Void
	{
		for( i in 0...m_aList.length )
		{
			if( m_aList[i] == p_oMaterial )
			{
				m_aList.splice( i, 1 );
				return;
			}
		}
	}
}

