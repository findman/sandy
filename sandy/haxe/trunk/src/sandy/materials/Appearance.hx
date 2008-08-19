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
import sandy.materials.Material;

/**
 * Represents the appearance property of the visible objects.
 *
 * <p>The appearance holds the front and back materials of the object</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 */
class Appearance 
{
	/**
	 * Creates an appearance with front and back materials.
	 *
	 * <p>If no material is passed, the default material for back and front is a default ColorMaterial.<br/>
	 * If only a front material is passed, it will be used as back material as well.</p>
	 *
	 * @param p_oFront	The front material
	 * @param p_oBack	The back material
	 */
	public function new( ?p_oFront:Material, ?p_oBack:Material )
	{
		m_oFrontMaterial = (p_oFront != null) 	? p_oFront :	new ColorMaterial();
		m_oBackMaterial  = (p_oBack != null) 	? p_oBack  :	m_oFrontMaterial;
	}
	
	/**
	 * Get the use of vertex normal feature of the appearance
	 *
	 * <p>true ONLY ONE of the materials is using this feature</p>
	 */		
	public var useVertexNormal(__getUseVertexNormal,null):Null<Bool>;
	private function __getUseVertexNormal():Null<Bool>
	{ 
		return (m_oBackMaterial.useVertexNormal != null && m_oFrontMaterial.useVertexNormal != null); 
	}
	
	
	/**
	 * @private
	 */
	private function __setFrontMaterial( p_oMat:Material ):Material
	{
		m_oFrontMaterial = p_oMat;
		if( m_oBackMaterial == null ) m_oBackMaterial = p_oMat;
		return p_oMat;
	}
	
	/**
	 * @private
	 */
	private function __setBackMaterial( p_oMat:Material ):Material
	{
		m_oBackMaterial = p_oMat;
		if( m_oFrontMaterial == null ) m_oFrontMaterial = p_oMat;
		return p_oMat;
	}

	/**
	 * The front material held by this appearance
	 *
	 */
	public var frontMaterial(__getFrontMaterial,__setFrontMaterial):Material;
	private function __getFrontMaterial():Material
	{
		return m_oFrontMaterial;
	}
	
	/**
	 * The back material held by this appearance
	 *
	 */
	public var backMaterial(__getBackMaterial,__setBackMaterial):Material;
	private function __getBackMaterial():Material
	{
		return m_oBackMaterial;
	}
	
	
	public var flags(__getFlags,null):Null<Int>;
	private function __getFlags():Null<Int>
	{
		var l_nFlag:Null<Int> =  m_oFrontMaterial.flags;
		if( m_oFrontMaterial != m_oBackMaterial ) l_nFlag |= m_oBackMaterial.flags;
		return l_nFlag;
	}
	
	/**
	 * Returns a string representation of this object.
	 *
	 * @return	The fully qualified name of this object
	 */
	public function toString():String
	{
		return "sandy.materials.Appearance";
	}
	
	// --
	private var m_oFrontMaterial:Material;
	private var m_oBackMaterial:Material;
}

