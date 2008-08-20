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

/**
 * A plane in 3D space.
 *
 * <p>This class is used primarily to represent the frustrum planes of the camera.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - FFlasher
 * @since		0.1
 * @version		2.0.2
 * @date 		24.08.2007
 *
 * @see sandy.view.Frustum
 */
 
class sandy.core.data.Plane
{
	
	/**
	 * The coordinate of the first plane.
	 */
	 public var a:Number;
		
	/**
	 * The coordinate of the second plane.
	 */
	 public var b:Number;
		 
	/**
	 * The coordinate of the third plane.
	 */
	 public var c:Number;
		
	/**
	 * The coordinate of the fourth plane.
	 */
	 public var d:Number;

	/**
	 * Creates a new Plane instance.
	 *
	 * @param p_nA	The coordinate of the first plane.
	 * @param p_nB	The coordinate of the second plane.
	 * @param p_nC	The coordinate of the third plane.
	 * @param p_nd	The coordinate of the forth plane.
	 */		
	 public function Plane( p_nA:Number, p_nB:Number, p_nC:Number, p_nd:Number )
	 {
		 this.a = p_nA||0; 
		 this.b = p_nB||0; 
		 this.c = p_nC||0; 
		 this.d = p_nd||0;
	 }
	
	
	/**
	 * Returns a string representation of this object.
	 *
	 * @return	The fully qualified name of this object.
	 */
	public function toString() : String
	{
		return "sandy.core.data.Plane" + "(a:" + a + ", b:" + b + ", c:" + c + ", d:" + d + ")";
	}
	
}
