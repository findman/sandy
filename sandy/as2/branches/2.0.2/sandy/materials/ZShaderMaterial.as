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

import flash.geom.Matrix;

import sandy.core.Scene3D;
import sandy.core.data.Polygon;
import sandy.core.data.Vertex;
import sandy.materials.Material;
import sandy.materials.attributes.MaterialAttributes;
import sandy.math.VertexMath;
import sandy.util.NumberUtil;

/**
 * Displays a kind of Z shading of any object that this material is applied to.
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - FFlasher
 * @version		2.0.2
 * @date 		26.07.2007
 */	
	 
class sandy.materials.ZShaderMaterial extends Material
{
	
	private var matrix:Matrix;
	// --
	
	/**
	 * Creates a new ZShaderMaterial.
	 *
	 * @param p_nCoef	Could a dev help us out here? :)
	 * @param p_oAttr	The attributes for this material.
	 *
	 * @see sandy.materials.attributes.MaterialAttributes
	 */
	public function ZShaderMaterial( p_nCoef:Number /* default value = 1 */, p_oAttr:MaterialAttributes )
	{
		super( p_oAttr );
		// --
		matrix = new Matrix();
	}
	
	/**
	 * @private
	 */
	public function renderPolygon( p_oScene:Scene3D, p_oPolygon:Polygon, p_mcContainer:MovieClip ) : Void 
	{
		var l_points:Array = ( ( p_oPolygon.isClipped ) ? p_oPolygon.cvertices : p_oPolygon.vertices );
		if( !l_points.length )
		{
			return;
		}

		//-- get zSort
		var zIndices: Array = l_points.sortOn( "wz", Array.NUMERIC | Array.RETURNINDEXEDARRAY );
			
		var v0:Vertex = l_points[ zIndices[0] ];
		var v1:Vertex = l_points[ zIndices[1] ];
		var v2:Vertex = l_points[ zIndices[2] ];

		//-- compute gray values
		if( !p_oPolygon.shape.boundingBox.uptodate )
		{
			p_oPolygon.shape.boundingBox.transform( p_oPolygon.shape.viewMatrix );
		}

		var zM:Number = p_oPolygon.shape.boundingBox.tmin.z;
		var zR:Number = p_oPolygon.shape.boundingBox.tmax.z - zM;
		
		var g0:Number = 0xff - ( v0.wz - zM ) / zR * 0xff;
		var g1:Number = 0xff - ( v1.wz - zM ) / zR * 0xff;
		var g2:Number = 0xff - ( v2.wz - zM ) / zR * 0xff;

		g0  = NumberUtil.constrain( g0, 0, 0xFF );
		g1  = NumberUtil.constrain( g1, 0, 0xFF );
		g2  = NumberUtil.constrain( g2, 0, 0xFF );

		//-- compute gradient matrix
		VertexMath.linearGradientMatrix( v0, v1, v2, g0, g1, g2, matrix );

		//-- draw gradient
		p_mcContainer.lineStyle();
		p_mcContainer.beginGradientFill( "linear", [ ( g0 << 16 ) | ( g0 << 8 ) | g0, ( g2 << 16 ) | ( g2 << 8 ) | g2 ], [ 100, 100 ], [ 0, 0xff ], matrix );
		p_mcContainer.moveTo( l_points[0].sx, l_points[0].sy );
		for( l_oVertex in l_points )
		{
			p_mcContainer.lineTo( l_points[l_oVertex].sx, l_points[l_oVertex].sy );
		}
		p_mcContainer.endFill();
		// --
		if( attributes )
		{
			attributes.draw( p_mcContainer, p_oPolygon, this, p_oScene ) ;
		}
	}

}