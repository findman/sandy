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

package sandy.view;

/**
 * Used to identify the culling state of an object.
 *
 * <p>A 3D object can be completely or partly inside the frustum of the camera, <br/>
 * or compleately outside. These are teh culling states.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 */

enum CullingState
{
		INTERSECT;
		INSIDE;
		OUTSIDE;
}

//  class CullingState 
//  {
//  	/**
//  	 * INTERSECT means that the object intersects one or more planes of the frustum, 
//  	 * and should be partly rendered.
//  	 */
//  	public static var INTERSECT:CullingState = new CullingState("intersect");
//  	
//  	/**
//  	 * INSIDE means that the object is completely inside the frustum, and should be rendered.
//  	 */
//  	public static var INSIDE:CullingState = new CullingState("inside");
//  	
//  	/**
//  	 * OUTSIDE means that the object is completely outside the frustum, and should not be rendered..
//  	 */
//  	public static var OUTSIDE:CullingState = new CullingState("outside");
//  	
//  	public function toString():String
//  	{
//  		return "[sandy.view.CullingState] :: state : "+m_sState;
//  	}
//  	
//  	/**
//  	 * Sets the value of this culling state.
//  	 */
//  	public function new( p_sState:String )
//  	{
//  		m_sState = p_sState;
//  	}
//  	
//  	private var m_sState:String;
//  	
//  }
//  
