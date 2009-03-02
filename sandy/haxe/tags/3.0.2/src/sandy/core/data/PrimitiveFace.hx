/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author Thomas PFEIFFER
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

package sandy.core.data;

import sandy.core.scenegraph.Shape3D;
import sandy.materials.Appearance;
/** 
 * PrimitiveFace is a tool for generated primitive, allowing users (for some specifics primitives) to get the face polygon array
 * to have an easier manipulation.
 * @author		Thomas Pfeiffer - kiroukou
 * @author		Xavier Martin - zeflasher
 * @author Niel Drummond - haXe port 
 * 
 * 
 **/
class PrimitiveFace
{
	private var m_iPrimitive	: Shape3D;
	private var m_oAppearance	: Appearance;
	
	/**
	 * The array containing the polygon instances own by this primitive face
	 */
	public var aPolygons		: Array<Polygon>;

	/**
	 * PrimitiveFace class
	 * This class is a tool for the primitives. It will stores all the polygons that are owned by the visible primitive face.
	 * 
	 * @param p_iPrimitive The primitive this face will be linked to
	 */
	public function new( p_iPrimitive:Shape3D )
	{
	 aPolygons	= new Array();

		m_iPrimitive = p_iPrimitive;
	}

	public var primitive(__getPrimitive,null):Shape3D;
	private function __getPrimitive():Shape3D
	{
		return m_iPrimitive;
	}
	
	public function addPolygon( p_oPolyId:Int ):Void
	{
		aPolygons.push( m_iPrimitive.aPolygons[p_oPolyId] );
	}
	
	/**
	 * The appearance of this face.
	 */
	private function __setAppearance( p_oApp:Appearance ):Appearance
	{
		// Now we register to the update event
		m_oAppearance = p_oApp;
		// --
		if( m_iPrimitive.geometry != null )	// ?? is it needed?
		{
			for ( v in aPolygons )
				v.appearance = m_oAppearance;
		}
		return p_oApp;
	}
	
	public var appearance(__getAppearance,__setAppearance):Appearance;
	private function __getAppearance():Appearance
	{
		return m_oAppearance;
	}
}

