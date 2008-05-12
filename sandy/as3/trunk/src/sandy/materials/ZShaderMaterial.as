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
package sandy.materials
{
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	import sandy.core.Scene3D;
	import sandy.core.data.Polygon;
	import sandy.core.data.Vertex;
	import sandy.materials.attributes.MaterialAttributes;
	import sandy.math.VertexMath;
	import sandy.util.NumberUtil;

	/**
	 * Displays a kind of Z shading of any object that this material is applied to.
	 *
	 * @author		Thomas Pfeiffer - kiroukou
	 * @version		3.0
	 * @date 		26.07.2007
	 */	
	public class ZShaderMaterial extends Material
	{
		private var matrix:Matrix = new Matrix();
		// --
		
		/**
		 * @see sandy.materials.attributes.MaterialAttributes
		 */
		public function ZShaderMaterial( p_nCoef:Number = 1, p_oAttr:MaterialAttributes = null )
		{
			super(p_oAttr);
		}
		
		/**
		 * @private
		 */
		public override function renderPolygon( p_oScene:Scene3D, p_oPolygon:Polygon, p_mcContainer:Sprite ):void 
		{
			const l_points:Array = ((p_oPolygon.isClipped) ? p_oPolygon.cvertices : p_oPolygon.vertices);
			if( !l_points.length ) return;
			const l_graphics:Graphics = p_mcContainer.graphics;	

			//-- get zSort
			var zIndices: Array = l_points.sortOn( "wz", Array.NUMERIC | Array.RETURNINDEXEDARRAY );
			
			var v0: Vertex = l_points[zIndices[0]];
			var v1: Vertex = l_points[zIndices[1]];
			var v2: Vertex = l_points[zIndices[2]];

			//-- compute gray values
			if (!p_oPolygon.shape.boundingBox.uptodate)
				p_oPolygon.shape.boundingBox.transform (p_oPolygon.shape.viewMatrix);

			var zM: Number = p_oPolygon.shape.boundingBox.tmin.z;
			var zR: Number = p_oPolygon.shape.boundingBox.tmax.z - zM;
			
			var g0: Number = 0xff - ( v0.wz - zM ) / zR * 0xff;
			var g1: Number = 0xff - ( v1.wz - zM ) / zR * 0xff;
			var g2: Number = 0xff - ( v2.wz - zM ) / zR * 0xff;

			g0  = NumberUtil.constrain( g0, 0, 0xFF );
			g1  = NumberUtil.constrain( g1, 0, 0xFF );
			g2  = NumberUtil.constrain( g2, 0, 0xFF );

			//-- compute gradient matrix
			VertexMath.linearGradientMatrix (v0, v1, v2, g0, g1, g2, matrix);
	
			//-- draw gradient
			l_graphics.lineStyle();
			l_graphics.beginGradientFill( "linear", [ ( g0 << 16 ) | ( g0 << 8 ) | g0, ( g2 << 16 ) | ( g2 << 8 ) | g2 ], [ 100, 100 ], [ 0, 0xff ], matrix );
			l_graphics.moveTo( l_points[0].sx, l_points[0].sy );
            for each (var l_oVertex:Vertex in l_points )
            {
                l_graphics.lineTo( l_oVertex.sx, l_oVertex.sy );
            }
			l_graphics.endFill();
			// --
			if( attributes )  attributes.draw( l_graphics, p_oPolygon, this, p_oScene ) ;
		}

	}
	
}