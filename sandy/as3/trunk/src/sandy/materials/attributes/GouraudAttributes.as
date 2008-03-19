/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author Thomas PFEIFFER
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


package sandy.materials.attributes
{
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	import sandy.core.SandyFlags;
	import sandy.core.Scene3D;
	import sandy.core.data.Polygon;
	import sandy.core.data.Vector;
	import sandy.core.data.Vertex;
	import sandy.materials.Material;
	import sandy.math.VertexMath;
	import sandy.util.NumberUtil;

	/**
	 * Realize a Gouraud shading on a material.
	 *
	 * <p>To make this material attribute use by the Material object, the material must have :myMAterial.lighteningEnable = true.<br />
	 * This attributes contains some parameters</p>
	 * 
	 * @author		Thomas Pfeiffer - kiroukou
	 * @author		Makc for effect improvment 
	 * @version		3.0
	 * @date 		13.11.2007
	 */
	public final class GouraudAttributes extends ALightAttributes
	{
		/**
		 * Flag for lightening mode.
		 * <p>If true, the lit objects use full light range from black to white.<b />
		 * If false (the default) they just range from black to their normal appearance.</p>
		 */
		public var useBright:Boolean = false;

		/**
		 * Create the GouraudAttribute object.
		 * @param p_bBright The brightness (value for useBright).
		 * @param p_nAmbient The ambient light value. A value between O and 1 is expected.
		 */
		public function GouraudAttributes( p_bBright:Boolean = false, p_nAmbient:Number = 0.0 )
		{
			useBright = p_bBright;
			ambient = NumberUtil.constrain( p_nAmbient, 0, 1 );
			m_nFlags |= SandyFlags.VERTEX_NORMAL_WORLD;
		}
		
		private var v0:Vertex, v1:Vertex, v2:Vertex;
		private var id0:int, id1:int, id2:int;
		private var v0N:Vector, v1N:Vector, v2N:Vector;
		private var v0L:Number, v1L:Number, v2L:Number;
		private var aL:Array = new Array(3);
		private var aLId:Array;
		
		private var alpha:Array = new Array(2);
		private var matrix:Matrix = new Matrix();
		private var l_oVertex:Vertex;
		 
		private var colours:Array = new Array(0,0); 
		private var ratios:Array = [ 0x00, 0xFF ];
		
		override public function draw(p_oGraphics:Graphics, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D):void
		{
			super.draw (p_oGraphics, p_oPolygon, p_oMaterial, p_oScene);

			if( !p_oMaterial.lightingEnable ) return;
			
			var m:Number;
			var l_aPoints:Array = (p_oPolygon.isClipped) ? p_oPolygon.cvertices : p_oPolygon.vertices;
			v0 = l_aPoints[0];
	        v1 = l_aPoints[1];
	        v2 = l_aPoints[2];
	        // --
	        v0N = p_oPolygon.vertexNormals[0].getWorldVector();
			v1N = p_oPolygon.vertexNormals[1].getWorldVector();
			v2N = p_oPolygon.vertexNormals[2].getWorldVector();
			// --
			v0L = NumberUtil.constrain (calculate (v0N, p_oPolygon.visible), 0, 1);
			v1L = NumberUtil.constrain (calculate (v1N, p_oPolygon.visible), 0, 1);
			v2L = NumberUtil.constrain (calculate (v2N, p_oPolygon.visible), 0, 1);
			v0L = NumberUtil.constrain( v0L, 0, 1 );
			v1L = NumberUtil.constrain( v1L, 0, 1 );
			v2L = NumberUtil.constrain( v2L, 0, 1 );	
			// --
			aL[0] = v0L; aL[1] =  v1L; aL[2] = v2L;
			aLId = aL.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY );
			// --
			id0 = int(aLId[0]);
			id1 = int(aLId[1]);
			id2 = int(aLId[2]);
			// --
			v0 = l_aPoints[int(id0)];
			v1 = l_aPoints[int(id1)];
			v2 = l_aPoints[int(id2)];

			// "b" is short for brightness; this is 0 when black, and up to 1
			// we want 1 to be mapped to transparent normally, and to white if useBright is set
			var b0:Number = aL[int(id0)] * (useBright ? 2 : 1);
			var b1:Number = aL[int(id2)] * (useBright ? 2 : 1);
			// now we have 4 situations to deal with
			if ((b0<=1)&&(b1<=1))
			{
			   // add black color (basically your 1st code)
			   colours = [ 0, 0 ];
			   alpha = [ 1-b0, 1-b1 ];
			   ratios = [ 0x00, 0xFF ];
			}
			else if ((b0>1)&&(b1>1))
			{
			   // add white color
			   colours = [ 0xFFFFFF, 0xFFFFFF ];
			   alpha = [ b0-1, b1-1 ];
			   ratios = [ 0x00, 0xFF ];
			}
			else if ((b0<1)&&(b1>1))
			{
			   // add black and white
			   colours = [ 0, 0, 0xFFFFFF, 0xFFFFFF ];
			   alpha = [ 1-b0, 0, 0, b1-1 ];
			   // find the midpoint
			   m = 0xFF * (1-b0)/(b1-b0);
			   ratios = [ 0x00, m, m, 0xFF ];
			}
			else
			/* if ((b0>1)&&(b1<1)) -- no need to check this, but keep in mind what this branch is for */
			{
			   // add white and black
			   colours = [ 0xFFFFFF, 0xFFFFFF, 0, 0 ];
			   alpha = [ b0-1, 0, 0, 1-b1 ];
			   // find the midpoint
			   m = 0xFF * (b0-1)/(b0-b1);
			   ratios = [ 0x00, m, m, 0xFF ];
			}

			// matrix
			linearGradientMatrix (v0, v1, v2, aL[int(id0)], aL[int(id1)], aL[int(id2)], matrix);

			p_oGraphics.lineStyle();
			p_oGraphics.beginGradientFill( "linear",colours, alpha, ratios, matrix );
			p_oGraphics.moveTo( l_aPoints[0].sx, l_aPoints[0].sy );
			for each( l_oVertex in l_aPoints )
			{
				p_oGraphics.lineTo( l_oVertex.sx, l_oVertex.sy );
			}
			p_oGraphics.endFill();
			
			// --
			l_aPoints = null;
			v0N = null;
			v1N = null;
			v2N = null;
		}

		/**
		 * Calculates linear gradient matrix from three vertices and ratios
		 *
		 * <p>This function expects vertices to be ordered in such a way that p_nR0 &lt; p_nR1 &lt; p_n2.
		 * Ratios can be scaled by any positive factor;
		 * see beginGradientFill documentation for ratios meaning.</p>
		 *
		 * @param p_oV0 Left-most vertex in a gradient.
		 * @param p_oV1 Inner vertex in a gradient.
		 * @param p_oV2 Right-most vertex in a gradient.
		 * @param p_nR0 Ratio for p_oV0.
		 * @param p_nR1 Ratio for p_oV1.
		 * @param p_nR2 Ratio for p_oV2.
		 * @param p_oMatrix (Optional) matrix object to use.
		 * @return 	The matrix to use with beginGradientFill, GradientType.LINEAR.
		 */
		private function linearGradientMatrix (p_oV0:Vertex, p_oV1:Vertex, p_oV2:Vertex,
			p_nR0:Number, p_nR1:Number, p_nR2:Number, p_oMatrix:Matrix = null):Matrix
		{
			const coef:Number = (p_nR1 - p_nR0) / (p_nR2 - p_nR0);
			const p3x:Number = p_oV0.sx + coef * (p_oV2.sx - p_oV0.sx);
			const p3y:Number = p_oV0.sy + coef * (p_oV2.sy - p_oV0.sy);
			const p4x:Number = p_oV2.sx - p_oV0.sx;
			const p4y:Number = p_oV2.sy - p_oV0.sy;
			const p4len:Number = Math.sqrt (p4x*p4x + p4y*p4y);
			const d:Number = Math.atan2 (p3x - p_oV1.sx, -(p3y - p_oV1.sy));

			if (p_oMatrix != null)
				p_oMatrix.identity ();
			else
				p_oMatrix = new Matrix ();

			p_oMatrix.a = Math.cos (Math.atan2 (p4y, p4x) - d) * p4len / (32768 * 0.05);
			p_oMatrix.rotate (d);
			p_oMatrix.translate ((p_oV2.sx + p_oV0.sx) / 2, (p_oV2.sy + p_oV0.sy) / 2);

			return p_oMatrix;
		}
	}
}