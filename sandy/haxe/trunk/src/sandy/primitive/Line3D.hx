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
package sandy.primitive;

import sandy.core.scenegraph.Geometry3D;
import sandy.core.scenegraph.Shape3D;
import sandy.core.data.Vector;

/**
* The Line3D class is used for creating a line in 3D space.
*
* <p>The line is created by passing a comma delimited argument list containing vectors.<br/>
* A Line3D object can only use the WireFrameMaterial[?]</p>
*
* @author		Thomas Pfeiffer - kiroukou
* @author Niel Drummond - haXe port 
* 
* 
*
* @example To create a line between ( x0, y0, z0 ), ( x1, y1, z1 ), ( x2, y2, z3 ),
* use the following statement:
*
* <listing version="3.0">
*     var myLine:Line3D = new Line3D( "aLine", new Vector(x0, y0, z0), new Vector( x1, y1, z1 ), new Vector( x2, y2, z3 ));
*  </listing>
*/
class Line3D extends Shape3D, implements Primitive3D
{
	/**
	* Creates a Line3D primitive.
	*
	* <p>A line is drawn between vectors in the order they are passed. A minimum of two vectors must be passed.</p>
	*
	* @param p_sName	A string identifier for this object.
	* @param ...rest 	A comma delimited list of vectors.
	*
	* @see sandy.core.data.Vector
	*/
	public function new ( p_sName:String, rest : Array<Dynamic> )
	{
		super ( p_sName );
		if( rest.length < 2 )
		{
			trace('Line3D::Too few arguments');
		}
		else
		{
			geometry = generate( [rest] );
			enableBackFaceCulling = false;
		}
	}

	/**
	* Generates the geometry for the line.
	*
	* @see sandy.core.scenegraph.Geometry3D
	*/
	public function generate ( ?arguments:Array<Dynamic> ) : Geometry3D
	{
		if ( arguments == null ) arguments = [];

		var l_oGeometry:Geometry3D = new Geometry3D();
		var l_aPoints:Array<Dynamic> = arguments[0];
		// --
		var i:Int = 0;
		var l:Int = l_aPoints.length;
		// --
		while( i < l )
		{
			l_oGeometry.setVertex( i, l_aPoints[i].x, l_aPoints[i].y, l_aPoints[i].z );
			i++;
		}
		// -- initialisation
		i = 0;
		while( i < l-1 )
		{
			l_oGeometry.setFaceVertexIds( i, [i, i+1] );
			i++;
		}
		// --
		return l_oGeometry;
	}

	/**
	* @private
	*/
	public override function toString():String
	{
		return "sandy.primitive.Line3D";
	}
}

