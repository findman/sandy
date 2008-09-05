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

package sandy.core.data;

/**
 * A plane in 3D space.
 *
 * <p>Used maily to represent the frustrum planes of the camera.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 * 
 */
class Plane
{
	public var a:Float;
	public var b:Float;
	public var c:Float;
	public var d:Float;

	/**
	* Creates a new Plane instance.
	*
	* @param	p_nA	the first plane coordinate
	* @param	p_nB	the second plane coordinate
	* @param	p_nC	the third plane coordinate
	* @param	p_nd	the forth plane coordinate
	*/
	public function new( ?p_nA:Float, ?p_nB:Float, ?p_nC:Float, ?p_nd:Float )
	{
		p_nA = (p_nA != null)?p_nA:0;
		p_nB = (p_nB != null)?p_nB:0;
		p_nC = (p_nC != null)?p_nC:0;
		p_nd = (p_nd != null)?p_nd:0;

		this.a = p_nA;
		this.b = p_nB;
		this.c = p_nC;
		this.d = p_nd;
	}


	/**
	 * Returns a string represntation of this plane.
	 *
	 * @return	The string representing this plane.
	 */
	public function toString():String
	{
		return "sandy.core.data.Plane" + "(a:"+a+", b:"+b+", c:"+c+", d:"+d+")";
	}
}

