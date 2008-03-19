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
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	import sandy.core.SandyFlags;
	import sandy.core.Scene3D;
	import sandy.core.data.Polygon;
	import sandy.core.data.Vector;
	import sandy.core.data.Vertex;
	import sandy.core.light.Light3D;
	import sandy.materials.Material;
	import sandy.math.VertexMath;
	import sandy.util.NumberUtil;

	/**
	 * Realize a Cell shading on a material.
	 * <b>Note:</b> this class ignores all properties inherited from ALightAttributes!
	 *
	 * @author		rafajafar + makc :)
	 */
	public final class CelShadeAttributes extends ALightAttributes
	{
		/**
		 * Used if a lightmap needs to be overridden.
		 */
		public var lightmap:PhongAttributesLightMap;

		/**
		 * Non-zero value adds sphere normals to actual normals for light rendering.
		 * Use this with flat surfaces or cylinders.
		 */
		public var spherize:Number = 0;

		/**
		 * Create the CelShadeAttributes object.
		 *
		 * @param p_oLightMap A lightmap that the object will use (default map has four shades of gray).
		 *
		 * @see PhongAttributesLightMap
		 */
		public function CelShadeAttributes (p_oLightMap:PhongAttributesLightMap = null)
		{
			if (p_oLightMap)
			{
				lightmap = p_oLightMap;
			}
			else
			{
				lightmap = new PhongAttributesLightMap ();
				lightmap.alphas[0] = [
					0.5, 0.5,
					0.5, 0.5,
					0.5, 0.5,
					0.5, 0.5];
				lightmap.colors[0] = [
					0xFFFFFF, 0xFFFFFF ,
					0x888888, 0x888888,
					0x666666, 0x666666,
					0x444444, 0x444444];
				lightmap.ratios[0] = [
					   0,  40,
					  40,  80,
					  80, 120,
					 120, 180];
			}

			m_nFlags |= SandyFlags.VERTEX_NORMAL_WORLD;
		}

		/**
		* @inheritDoc
		*/
		override public function draw(p_oGraphics:Graphics, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D):void
		{
			super.draw (p_oGraphics, p_oPolygon, p_oMaterial, p_oScene);

			var i:int, l_oVertex:Vertex;

			// got anything at all to do?
			if( !p_oMaterial.lightingEnable )
			{
				return;
			}

			// get vertices and prepare matrix2
			var l_aPoints:Array = (p_oPolygon.isClipped) ? p_oPolygon.cvertices : p_oPolygon.vertices;
			matrix2.a = l_aPoints[1].sx - l_aPoints[0].sx;
			matrix2.b = l_aPoints[1].sy - l_aPoints[0].sy;
			matrix2.c = l_aPoints[2].sx - l_aPoints[0].sx;
			matrix2.d = l_aPoints[2].sy - l_aPoints[0].sy;
			matrix2.tx = l_aPoints[0].sx;
			matrix2.ty = l_aPoints[0].sy;

			// transform 1st three normals
			for (i = 0; i < 3; i++)
			{
				aN0 [i].copy (p_oPolygon.vertexNormals [i].getWorldVector());
				if (!p_oPolygon.visible)
				{
					aN0 [i].scale (-1);
				}

				if (spherize > 0)
				{
					// too bad, l_aPoints [i].getWorldVector () gives viewMatrix-based coordinates
					// when vertexNormals [i].getWorldVector () gives modelMatrix-based ones :(
					// so we have to use cache for modelMatrix-based vertex coords (and also scaled)
					var dv:Vector;
					if (m_oVertices [l_aPoints [i]] == null)
					{
						dv = l_aPoints [i].getVector ();
						dv.sub (p_oPolygon.shape.geometryCenter);
						p_oPolygon.shape.modelMatrix.vectorMult3x3 (dv);
						dv.normalize ();
						dv.scale (spherize);
						m_oVertices [l_aPoints [i]] = dv;
					}
					else
					{
						dv = m_oVertices [l_aPoints [i]];
					}
					aN0 [i].add (dv);
					aN0 [i].normalize ();
				}
			}

			// get highlight direction vector
			var d:Vector =  m_oL ;

			// see if we are on the backside
			var backside:Boolean = true
			for (i = 0; i < 3; i++)
			{
				aN [i].copy (aN0 [i]);

				var d_dot_aNi:Number = d.dot (aN [i]);
				if (d_dot_aNi < 0)
				{
					backside = false;
				}

				// intersect with parabola - q(r) in computeLightMap() corresponds to this
				aN[i].scale (1 / (1 - d_dot_aNi));
			}

			if (backside)
			{
				// no reflection here - render the face in solid color
				var l:int = lightmap.colors[0].length;
				var c:uint = lightmap.colors[0][l -1];
				var a:Number = lightmap.alphas[0][l -1];
				p_oGraphics.beginFill( c, a );
			}

			else
			{
				// calculate two arbitrary vectors perpendicular to light direction
				var e1:Vector = (Math.abs (d.x) + Math.abs (d.y) > 0) ? new Vector (d.y, -d.x, 0) : new Vector (d.z, 0, -d.x);
				var e2:Vector = d.cross (e1);
				e1.normalize ();
				e2.normalize ();

				for (i = 0; i < 3; i++)
				{
					// project aN [i] onto e1 and e2
					aNP [i].x = e1.dot (aN [i]);
					aNP [i].y = e2.dot (aN [i]);

					// re-calculate into light map coordinates
					aNP [i].x = (16384 - 1) * 0.05 * aNP [i].x;
					aNP [i].y = (16384 - 1) * 0.05 * aNP [i].y;
				}

				// simple hack to resolve bad projections
				// where the hell do they keep coming from?
				while ((Math.abs(
						(aNP[0].x - aNP[1].x) * (aNP[0].x - aNP[2].x) + (aNP[0].y - aNP[1].y) * (aNP[0].y - aNP[2].y)
						) > (1 - NumberUtil.TOL) *
						Point.distance(aNP[0], aNP[1]) * Point.distance(aNP[0], aNP[2])
					)
					|| (Math.abs(
						(aNP[0].x - aNP[1].x) * (aNP[2].x - aNP[1].x) + (aNP[0].y - aNP[1].y) * (aNP[2].y - aNP[1].y)
						) > (1 - NumberUtil.TOL) *
						Point.distance(aNP[0], aNP[1]) * Point.distance(aNP[2], aNP[1])
					))
				{
					aNP[0].x--; aNP[1].y++; aNP[2].x++;
				}

				// compute gradient matrix
				matrix.a = aNP[1].x - aNP[0].x;
				matrix.b = aNP[1].y - aNP[0].y;
				matrix.c = aNP[2].x - aNP[0].x;
				matrix.d = aNP[2].y - aNP[0].y;
				matrix.tx = aNP[0].x;
				matrix.ty = aNP[0].y;
				matrix.invert ();

				matrix.concat (matrix2);
				p_oGraphics.beginGradientFill( "radial", lightmap.colors [0], lightmap.alphas [0], lightmap.ratios [0], matrix );
			}

			// render the lighting
			p_oGraphics.moveTo( l_aPoints[0].sx, l_aPoints[0].sy );
			for each( l_oVertex in l_aPoints )
			{
				p_oGraphics.lineTo( l_oVertex.sx, l_oVertex.sy  );
			}
			p_oGraphics.endFill();

			// --
			l_aPoints = null;
		}

		// vertex dictionary
		private var m_oVertices:Dictionary;

		/**
		* @private
		*/
		override public function begin( p_oScene:Scene3D ):void
		{
			super.begin (p_oScene);

			// clear vertex dictionary
			m_oVertices = new Dictionary (true);
		}

		// --
		private var aN0:Array = [new Vector (), new Vector (), new Vector ()];
		private var aN:Array  = [new Vector (), new Vector (), new Vector ()];
		private var aNP:Array = [new Point (), new Point (), new Point ()];

		private var matrix:Matrix = new Matrix();
		private var matrix2:Matrix = new Matrix();
	}
}