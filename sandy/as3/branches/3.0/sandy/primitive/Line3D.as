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
package sandy.primitive 
{
	import sandy.core.data.Vector;
	import sandy.core.data.Vertex;
	import sandy.primitive.Primitive3D;
	import sandy.core.data.Polygon;
	import sandy.core.scenegraph.Shape3D;
	import sandy.core.scenegraph.Geometry3D;
	
	/**
	* Line3D
	* <p>Line3D, or how to create a simple line in Sandy</p>
	* 
	* @author		Thomas Pfeiffer - kiroukou
	* @version		2.0
	* @date 		20.04.2007 
	**/
	public class Line3D extends Shape3D implements Primitive3D
	{
		/**
		* Constructor
		*
		* <p>This is the constructor to call when you nedd to create a Line3D primitiv.</p>
		*
		* <p>This method will create a complete object with vertex,
		*    and the faces.</p>
		*
		* @param As many parameters as needed points can be passed. However a minimum of 2 vector instance must be given.
		*/
		public function Line3D ( p_sName:String, ...rest )
		{
			super ( p_sName );
			if( rest.length < 2 )
			{
				trace('Line3D::Number of arguments to low');
			}
			else
			{
				geometry = generate( rest );
				enableBackFaceCulling = false;
			}
		}
		
		/**
		* generate
		* 
		* <p>Generate all is needed to construct the Line3D : </p>
		*/
		public function generate ( ... arguments ) : Geometry3D
		{
			var l_oGeometry:Geometry3D = new Geometry3D();
			var l_aPoints:Array = arguments[0];
			// --
			var i:int;
			var l:int = l_aPoints.length;
			// --
			while( i < l )
			{
				l_oGeometry.setVertex( i, l_aPoints[int(i)].x, l_aPoints[int(i)].y, l_aPoints[int(i)].z );
				i++;
			}
			// -- initialisation
			i = 0;
			while( i < l-1 )
			{
				l_oGeometry.setFaceVertexIds( i, i, i+1 );
				i++;
			}
			// --
			return l_oGeometry;
		}
				
		public override function toString():String
		{
			return "sandy.primitive.Line3D";
		}		
	}
}