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
package sandy.materials.attributes
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	import sandy.core.SandyFlags;
	import sandy.core.Scene3D;
	import sandy.core.data.Polygon;
	import sandy.core.data.Vector;
	import sandy.core.data.Vertex;
	import sandy.materials.Material;

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
		 * <p>If true, the lit objects use full light range from black to white. If false (the default) they just range from black to their normal appearance.</p>
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
			ambient = Math.min (Math.max (p_nAmbient, 0), 1);
			m_nFlags |= SandyFlags.VERTEX_NORMAL_WORLD;
			lightMap = defaultLightMap ();
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
		
		/**
		* @inheritDoc
		*/
		override public function draw(p_oGraphics:Graphics, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D):void
		{
			super.draw (p_oGraphics, p_oPolygon, p_oMaterial, p_oScene);

			if( !p_oMaterial.lightingEnable ) return;
			
			if (lightMap != null)
				drawRaster(p_oGraphics, p_oPolygon, p_oMaterial, p_oScene);
			else
				drawVector(p_oGraphics, p_oPolygon, p_oMaterial, p_oScene);
		}
		
		private var m1:Matrix = new Matrix();
		private var m2:Matrix = new Matrix();

		/**
		 * Current light map; setting this to null will use slower, but more accurate vector gradient map.
		 */
		public var lightMap:BitmapData;

		/**
		 * Amount of map width taken by end colors on both sides
		 */
		public var lightMapPadding:Number = 0.25;
		
		/**
		 * Setting this to false will probably speed things up but may also give your objects cel-shaded appearance.
		 */
		public var lightMapSmooth:Boolean = false;

		private function drawRaster(p_oGraphics:Graphics, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D):void
		{
			// get vertices
			var l_aPoints:Array = (p_oPolygon.isClipped) ? p_oPolygon.cvertices : p_oPolygon.vertices;
			// calculate light per vertex
			var v0L:Number = calculate (p_oPolygon.vertexNormals[0].getWorldVector(), p_oPolygon.visible); if (v0L < ambient) v0L = ambient; else if (v0L > 1)v0L = 1;
			var v1L:Number = calculate (p_oPolygon.vertexNormals[1].getWorldVector(), p_oPolygon.visible); if (v1L < ambient) v1L = ambient; else if (v1L > 1)v1L = 1;
			var v2L:Number = calculate (p_oPolygon.vertexNormals[2].getWorldVector(), p_oPolygon.visible); if (v2L < ambient) v2L = ambient; else if (v2L > 1)v2L = 1;
			// affine mapping
			var u0:Number = int((lightMapPadding + (1 - 2 * lightMapPadding) * v0L) * lightMap.width),
				v0:Number = 0,
				u1:Number = int((lightMapPadding + (1 - 2 * lightMapPadding) * v1L) * lightMap.width),
				v1:Number = lightMap.width,
				u2:Number = int((lightMapPadding + (1 - 2 * lightMapPadding) * v2L) * lightMap.width),
				v2:Number = lightMap.width * 2,
				tmp:Number;
				
			// perpendicular projections
			if( (u0 == u1) && (u1 == u2) )
			{
				u1++;
			}
			else
			{
				// in one line?
				if ((u2 - u1) * (u1 - u0) > 0)
				{
					tmp = v1; v1 = v2; v2 = tmp;
				}
			}

			// prepare matrix
			m1.a = u1 - u0; m1.b = v1 - v0;
			m1.c = u2 - u0; m1.d = v2 - v0;
			m1.tx = u0; m1.ty = v0;
			m1.invert ();
			m2.a = l_aPoints[1].sx - l_aPoints[0].sx; m2.b = l_aPoints[1].sy - l_aPoints[0].sy;
			m2.c = l_aPoints[2].sx - l_aPoints[0].sx; m2.d = l_aPoints[2].sy - l_aPoints[0].sy;
			m2.tx = l_aPoints[0].sx; m2.ty = l_aPoints[0].sy;
			m1.concat (m2);
			// draw the map
			p_oGraphics.lineStyle();
			p_oGraphics.beginBitmapFill (lightMap, m1, true, lightMapSmooth);
			p_oGraphics.moveTo( l_aPoints[0].sx, l_aPoints[0].sy );
			for each( var l_oVertex:Vertex in l_aPoints )
			{
				p_oGraphics.lineTo( l_oVertex.sx, l_oVertex.sy );
			}
			p_oGraphics.endFill();
		}

		private function drawVector(p_oGraphics:Graphics, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D):void
		{
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
			v0L = calculate (v0N, p_oPolygon.visible); if (v0L < 0) v0L = 0; else if (v0L > 1)v0L = 1;
			v1L = calculate (v1N, p_oPolygon.visible); if (v1L < 0) v1L = 0; else if (v1L > 1)v1L = 1;
			v2L = calculate (v2N, p_oPolygon.visible); if (v2L < 0) v2L = 0; else if (v2L > 1)v2L = 1;
			// --
			aL[0] = v0L; aL[1] =  v1L; aL[2] = v2L;
			aLId = aL.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY );
			// --
			id0 = int(aLId[0]);
			id1 = int(aLId[1]);
			id2 = int(aLId[2]);
			// --
			v0 = l_aPoints[id0];
			v1 = l_aPoints[id1];
			v2 = l_aPoints[id2];

			// "b" is short for brightness; this is 0 when black, and up to 1
			// we want 1 to be mapped to transparent normally, and to white if useBright is set
			var b0:Number = aL[id0] * (useBright ? 2 : 1);
			var b1:Number = aL[id2] * (useBright ? 2 : 1);
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
			linearGradientMatrix (v0, v1, v2, aL[id0], aL[id1], aL[id2], matrix);

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
		 * Calculates default light map.
		 */
		public function defaultLightMap ():BitmapData
		{
			var l_nH:Number = 8;
			var l_nW:Number = 1024;
			var l_oShape:Shape = new Shape ();
			var l_oMatrix:Matrix = new Matrix();
			l_oMatrix.createGradientBox (l_nW, l_nH, 0, 0);
			l_oShape.graphics.beginGradientFill ("linear",
				useBright ? [ 0, 0, 0xFFFFFF, 0xFFFFFF ] : [ 0, 0 ],
				useBright ? [ 1, 0, 0, 1 ] : [ 1, 0 ],
				// we pad map for safe mapping
				useBright ? [ 256 * lightMapPadding, 127, 127, 255 - 256 * lightMapPadding ] : [ 256 * lightMapPadding, 255 - 256 * lightMapPadding ],
				l_oMatrix);
			l_oShape.graphics.drawRect (0, 0, l_nW, l_nH);
			l_oShape.graphics.endFill ();
			var l_oMap = new BitmapData (l_nW, l_nH, true, 0); l_oMap.draw (l_oShape);
			return l_oMap;
		}

		/**
		 * Calculates linear gradient matrix from three vertices and ratios.
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
		 * @see http://psyark.jp/?entry=20060211231514
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