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
* Plane representation in a 3D space. Used maily to represent the frustrum planes of the camera
* This class is not used yet in Sandy.
* @author		Thomas Pfeiffer - kiroukou
* @version		0.1
* @date 		22.02.2006
*/
class sandy.core.data.Plane
{
	public var a:Number;
	public var b:Number;
	public var c:Number;
	public var d:Number;

	/**
	* <p>Create a new {@code Plane} Instance</p>
	* 
	* @param	a	the first plane coordinate
	* @param	b	the second plane coordinate
	* @param	c	the third plane coordinate
	* @param	d	the forth plane coordinate
	*/ 	
	public function Plane( a:Number, b:Number, c:Number, d:Number )
	{
		this.a = a||0; 
		this.b = b||0; 
		this.c = c||0; 
		this.d = d||0;
	}
	
	
	/**
	* Get a String represntation of the {@code Plane}.
	* 
	* @return	A String representing the {@code Plane}.
	*/ 	
	public function toString():String
	{
		return "sandy.core.data.Plane" + "(a:"+a+", b:"+b+", c:"+c+", d:"+d+")";
	}
}
