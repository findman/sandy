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

import sandy.core.scenegraph.Geometry3D;
import sandy.core.scenegraph.Shape3D;	
import sandy.primitive.Primitive3D;
import sandy.primitive.PrimitiveMode;

/**
 * The Plane3D is used for creating a plane primitive.
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - xdevltd
 * @version		2.0.2
 * @date 		12.01.2006
 *
 * @example To create a 100x100 plane with default values quality and alignment, use the following statement:
 *
 * <listing version="3.0">
 *      var plane:Plane3D = new Plane3D( "thePlane", 100, 100 );
 *  </listing>
 * To create the same plane aligned parallel to the xy-plane use:
 * <listing version="3.0">
 *     var plane:Plane3D = new Plane3D( "thePlane", 100, 100, 1, 1, Plane3D.XY_ALIGNED );
 *  </listing>
 */
	
class sandy.primitive.Plane3D extends Shape3D implements Primitive3D
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
	private var _h:Number;
	private var _lg:Number;
	private var _qH:Number; 
	private var _qV:Number; 
	private var m_sType:String;
	private var _mode:String;
	
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
	 * @param p_sMode   	The generation mode. "tri" generates faces with 3 vertices, and "quad" generates faces with 4 vertices.
	 *
	 * @see PrimitiveMode
	 */
	public function Plane3D( p_sName:String, p_nHeight:Number, p_nWidth:Number, p_nQualityH:Number,
							 p_nQualityV:Number, p_sType:String, p_sMode:String )
	{
		super( p_sName );
		_h = p_nHeight||100;
		_lg = p_nWidth||100;
		_qV = p_nQualityV||1;
		_qH = p_nQualityH||1;
		_mode = ( p_sMode != PrimitiveMode.TRI && p_sMode != PrimitiveMode.QUAD ) ? PrimitiveMode.TRI : p_sMode;
		m_sType = p_sType||Plane3D.XY_ALIGNED;
		geometry = generate();
	}

	/**
	 * Generates the geometry for the plane.
	 *
	 * @see sandy.core.scenegraph.Geometry3D
	 */
	public function generate( /* Arguments */ ) : Geometry3D
	{
		var l_geometry:Geometry3D = new Geometry3D();
		//Creation of the points
		var i:Number, j:Number;
		var h2:Number = _h / 2;
		var l2:Number = _lg / 2;
		var pasH:Number = _h / _qV;
		var pasL:Number = _lg / _qH;
		var iH:Number, iL:Number, iTH:Number, iTL:Number;

		for( i = 0, iH = -h2, iTH = 0; i <= _qV; iH += pasH, iTH += pasH, i++ )
		{
			for( j = 0, iL = -l2, iTL = 0; j <= _qH; iL += pasL, iTL += pasL, j++ )
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
				l_geometry.setUVCoords( l_geometry.getNextUVCoordID(), iTL / _lg, 1 - iTH / _h );
			}
		}

		for( i = 0; i < _qV; i++ )
		{
			for( j = 0; j < _qH; j++ )
			{
				//Face creation
				l_geometry.setFaceVertexIds( l_geometry.getNextFaceID(), ( i * ( _qH + 1 ) ) + j, ( i * ( _qH + 1 ) ) + j + 1, ( i + 1 ) * ( _qH + 1 ) + j );
				l_geometry.setFaceUVCoordsIds( l_geometry.getNextFaceUVCoordID(), ( i * ( _qH + 1 ) ) + j, ( i * ( _qH + 1 ) ) + j + 1, ( i + 1 ) * ( _qH + 1 ) + j );
 
				l_geometry.setFaceVertexIds( l_geometry.getNextFaceID(), ( i * ( _qH + 1 ) ) + j + 1, ( i + 1 ) * ( _qH + 1 ) + j + 1, ( i + 1 ) * ( _qH + 1 ) + j );
				l_geometry.setFaceUVCoordsIds( l_geometry.getNextFaceUVCoordID(), ( i * ( _qH + 1 ) ) + j + 1, ( i + 1 ) * ( _qH + 1 ) + j + 1, ( i + 1 ) * ( _qH + 1 ) + j );
			}
		}

		return ( l_geometry );
	}

	/**
	 * @private
	 */
	public function toString() : String
	{
		return "sandy.primitive.Plane3D";
	}
	
}