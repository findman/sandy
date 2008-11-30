﻿/*
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
* The Plane3D is used for creating a plane primitive.
*
* @author		Thomas Pfeiffer - kiroukou
* @author Niel Drummond - haXe port 
* 
* @example To create a 100x100 plane with default values quality and alignment, use the following statement:
*
* <listing version="3.0">
*     var plane:Plane3D = new Plane3D( "thePlane", 100, 100 );
*  </listing>
* To create the same plane aligned parallel to the xy-plane use:
* <listing version="3.0">
*     var plane:Plane3D = new Plane3D( "thePlane", 100, 100, 1, 1, Plane3D.XY_ALIGNED );
*  </listing>
*/
class Plane3D extends Shape3D, implements Primitive3D
{
	/**
	* Specifies plane will be parallel to the xy-plane.
	*/
	public static var XY_ALIGNED:String = "xy_aligned";

	/**
	* Specifies plane will be parallel to the yz-plane.
	*/
	public static var YZ_ALIGNED:String = "yz_aligned";

	/**
	* Specifies plane will be parallel to the zx-plane.
	*/
	public static var ZX_ALIGNED:String = "zx_aligned";

	//////////////////
	///PRIVATE VARS///
	//////////////////
	private var _h:Float;
	private var _lg:Float;
	private var _qH:Int;
	private var _qV:Int;
	private var m_sType:String;

	/**
	* Creates a Plane primitive.
	*
	* <p>The plane is created with its center in the origin of the global coordinate system.
	* It will be parallel to one of the global coordinate planes in accordance with the alignment parameter.</p>
	*
	* @param p_sName		A string identifier for this object.
	* @param p_nHeight		The height of the plane.
	* @param p_nWidth		The width of the plane.
	* @param p_nQualityH 	Number of horizontal segments.
	* @param p_nQualityV	Number of vertical segments.
	* @param p_sType		Alignment of the plane, one of XY_ALIGNED ( default ), YZ_ALIGNED or ZX_ALIGNED.
	*
	* @see PrimitiveMode
	*/
	public function new(p_sName:String = null, p_nHeight:Float = 100.0, p_nWidth:Float = 100.0, p_nQualityH:Int = 1,
							p_nQualityV:Int=1, ?p_sType:String )
	{
		if ( p_sType == null ) p_sType = Plane3D.XY_ALIGNED;

		super( p_sName ) ;
		_h = p_nHeight;
		_lg = p_nWidth;
		_qV = p_nQualityV;
		_qH = p_nQualityH;
		m_sType = p_sType;
		geometry = generate() ;
	}

	/**
	* Generates the geometry for the plane.
	*
	* @return The geometry object for the plane.
	*
	* @see sandy.core.scenegraph.Geometry3D
	*/
	public function generate( ?arguments:Array<Dynamic> ):Geometry3D
	{
		if ( arguments == null ) arguments = [];

		var l_geometry:Geometry3D = new Geometry3D();
		//Creation of the points
		var i:Int, j:Int;
		var h2:Float = _h/2;
		var l2:Float = _lg/2;
		var pasH:Float = _h/_qV;
		var pasL:Float = _lg/_qH;
		var iH:Float = 0 - h2, iL:Float, iTH:Float = 0, iTL:Float;

		for( i in 0...(_qV + 1) )
		{
			iL = 0 - l2;
			iTL = 0;
			for( j in 0...(_qH + 1) )
			{
				if( m_sType == Plane3D.ZX_ALIGNED )
				{
					l_geometry.setVertex( l_geometry.getNextVertexID(), iL, 0, iH );
				}
				else if( m_sType == Plane3D.YZ_ALIGNED )
				{
					l_geometry.setVertex( l_geometry.getNextVertexID(), 0, iL, iH );
				}
				else
				{
					l_geometry.setVertex( l_geometry.getNextVertexID(), iL, iH, 0 );
				}
				l_geometry.setUVCoords( l_geometry.getNextUVCoordID(), iTL/_lg, 1-iTH/_h );
				iL += pasL;
				iTL += pasL;
			}
			iH += pasH; 
			iTH += pasH;
		}

		for( i in 0..._qV )
		{
			for( j in 0..._qH )
			{
				//Face creation
				l_geometry.setFaceVertexIds( l_geometry.getNextFaceID(), [(i*(_qH+1))+j, (i*(_qH+1))+j+1, (i+1)*(_qH+1)+j] );
				l_geometry.setFaceUVCoordsIds( l_geometry.getNextFaceUVCoordID(), [(i*(_qH+1))+j, (i*(_qH+1))+j+1, (i+1)*(_qH+1)+j] );

				l_geometry.setFaceVertexIds( l_geometry.getNextFaceID(), [(i*(_qH+1))+j+1, (i+1)*(_qH+1)+j+1, (i+1)*(_qH+1)+j] );
				l_geometry.setFaceUVCoordsIds( l_geometry.getNextFaceUVCoordID(), [(i*(_qH+1))+j+1, (i+1)*(_qH+1)+j+1, (i+1)*(_qH+1)+j] );
			}
		}

		return (l_geometry);
	}

	/**
	* @private
	*/
	public override function toString():String
	{
		return "sandy.primitive.Plane3D";
	}
}

