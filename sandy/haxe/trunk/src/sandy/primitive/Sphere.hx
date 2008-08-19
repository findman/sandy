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

/**
* The Sphere class is used for creating a sphere primitive
*
* @author		Thomas Pfeiffer - kiroukou
* @author Niel Drummond - haXe port 
* 
* 
*
* @example To create a sphere with radius 150 and with default settings
* for the number of horizontal and vertical segments, use the following statement:
*
* <listing version="3.0">
*     var mySphere:Sphere = new Sphere( "theSphere", 150);
*  </listing>
*/
class Sphere extends Shape3D, implements Primitive3D
{
	private var radius:Float;

	/**
	* The number of horizontal segments.
	*/
	public var segmentsW :Int;

	/**
	* The number of vertical segments.
	*/
	public var segmentsH :Int;

	/**
	* The default radius for a sphere.
	*/
	static public inline var DEFAULT_RADIUS :Float = 100;

	/**
	* The default scale for a sphere texture.
	*/
	static public inline var DEFAULT_SCALE :Float = 1;

	/**
	* The default number of horizontal segments for a sphere.
	*/
	static public inline var DEFAULT_SEGMENTSW :Float = 8;

	/**
	* The default number of vertical segments for a sphere.
	*/
	static public inline var DEFAULT_SEGMENTSH :Float = 6;

	/**
	* The minimum number of horizontal segments for a sphere.
	*/
	static public inline var MIN_SEGMENTSW :Float = 3;

	/**
	* The minimum number of vertical segments for a sphere.
	*/
	static public inline var MIN_SEGMENTSH :Float = 2;

	/**
	* Creates a Sphere primitive.
	*
	* <p>The sphere is created centered at the origin of the world coordinate system,
	* with its poles on the y axis</p>
	*
	* @param p_sName 		A string identifier for this object.
	* @param p_nRadius		Radius of the sphere.
	* @param p_nSegmentsW	Number of horizontal segments.
	* @param p_nSegmentsH	Number of vertical segments.
	*/
	public function new( ?p_sName:String , ?p_nRadius:Float, ?p_nSegmentsW:Float, ?p_nSegmentsH:Float )
	{
		if (p_nRadius == null) p_nRadius = 100;
		if (p_nSegmentsW == null) p_nSegmentsW = 8;
		if (p_nSegmentsH == null) p_nSegmentsH = 6;

		super( p_sName );
		// --
		this.segmentsW = Std.int(Math.max( MIN_SEGMENTSW, ((p_nSegmentsW != null)?p_nSegmentsW:DEFAULT_SEGMENTSW))); // Defaults to 8
		this.segmentsH = Std.int(Math.max( MIN_SEGMENTSH, ((p_nSegmentsH != null)?p_nSegmentsH:DEFAULT_SEGMENTSH))); // Defaults to 6
		radius = (p_nRadius != 0) ? p_nRadius : DEFAULT_RADIUS; // Defaults to 100
		// --
		var scale :Float = DEFAULT_SCALE;
		// --
		geometry = generate();
	}

	/**
	* Generates the geometry for the sphere.
	*
	* @see sandy.core.scenegraph.Geometry3D
	*/
	public function generate(?arguments:Array<Dynamic>):Geometry3D
	{
		if (arguments == null) arguments = new Array();

		var l_oGeometry:Geometry3D = new Geometry3D();
		// --
		var i:Int, j:Int, k:Int;
		var iHor:Int = Std.int(Math.max(3,this.segmentsW));
		var iVer:Int = Std.int(Math.max(2,this.segmentsH));
		// --
		var aVtc:Array<Array<Int>> = new Array();
		for ( j in 0...(iVer+1) )
		{ // vertical
			var fRad1:Float = (j/iVer);
			var fZ:Float = -radius*Math.cos(fRad1*Math.PI);
			var fRds:Float = radius*Math.sin(fRad1*Math.PI);
			var aRow:Array<Int> = new Array();
			var oVtx:Int = 0;
			for ( i in 0...iHor )
			{ // horizontal
				var fRad2:Float = (2*i/iHor);
				var fX:Float = fRds*Math.sin(fRad2*Math.PI);
				var fY:Float = fRds*Math.cos(fRad2*Math.PI);
				if (!((j==0||j==iVer)&&i>0))
				{ // top||bottom = 1 vertex
					oVtx = l_oGeometry.setVertex( l_oGeometry.getNextVertexID(), fY, fZ, fX );//fY, -fZ, fX );
				}
				aRow.push(oVtx);
			}
			aVtc.push(aRow);
		}
		// --
		var iVerNum:Int = aVtc.length;
		for ( j in 0...iVerNum )
		{
			var iHorNum:Int = aVtc[j].length;
			if (j>0)
			{ // &&i>=0
				for ( i in 0...iHorNum )
				{
					// select vertices
					var bEnd:Bool = i==(iHorNum-0);
					// --
					var l_nP1:Float = aVtc[j][bEnd?0:i];
					var l_nP2:Float = aVtc[j][(i==0?iHorNum:i)-1];
					var l_nP3:Float = aVtc[j-1][(i==0?iHorNum:i)-1];
					var l_nP4:Float = aVtc[j-1][bEnd?0:i];
					// uv
					var fJ0:Float = j		/ iVerNum;
					var fJ1:Float = (j-1)	/ iVerNum;
					var fI0:Float = (i+1)	/ iHorNum;
					var fI1:Float = i		/ iHorNum;

					var l_nUV4:Int = l_oGeometry.setUVCoords( l_oGeometry.getNextUVCoordID(), fI0, 1-fJ1 );
					var l_nUV1:Int = l_oGeometry.setUVCoords( l_oGeometry.getNextUVCoordID(), fI0, 1-fJ0 );
					var l_nUV2:Int = l_oGeometry.setUVCoords( l_oGeometry.getNextUVCoordID(), fI1, 1-fJ0 );
					var l_nUV3:Int = l_oGeometry.setUVCoords( l_oGeometry.getNextUVCoordID(), fI1, 1-fJ1 );
					var l_nF:Int;

					// 2 faces
					if (j<(aVtc.length-1))
					{
						l_nF = l_oGeometry.setFaceVertexIds( l_oGeometry.getNextFaceID(), [l_nP1, l_nP2, l_nP3] );
						l_oGeometry.setFaceUVCoordsIds( l_nF, [l_nUV1, l_nUV2, l_nUV3] );
						//aFace.push( new Face3D(new Array(aP1,aP2,aP3),new Array(aP1uv,aP2uv,aP3uv)) );
					}
					if (j>1)
					{
						l_nF = l_oGeometry.setFaceVertexIds( l_oGeometry.getNextFaceID(), [l_nP1, l_nP3, l_nP4] );
						l_oGeometry.setFaceUVCoordsIds( l_nF, [l_nUV1, l_nUV3, l_nUV4] );
						//aFace.push( new Face3D(new Array(aP1,aP3,aP4), new Array(aP1uv,aP3uv,aP4uv)) );
					}

				}
			}
		}
		// --
		return l_oGeometry;
	}

	/**
	* @private
	*/
	public override function toString():String
	{
		return "sandy.primitive.Sphere";
	}
}

