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

			var i:int, l_oVertex:Vertex,
				v:Vector, dv:Vector,
				p:Point, p1:Point, p2:Point,
				m2a:Number, m2b:Number, m2c:Number, m2d:Number, a:Number;

			// got anything at all to do?
			if( !p_oMaterial.lightingEnable )
			{
				return;
			}

			// get vertices and prepare matrix2
			var l_aPoints:Array = (p_oPolygon.isClipped) ? p_oPolygon.cvertices : p_oPolygon.vertices;

			l_oVertex = l_aPoints [0];
			matrix2.tx = l_oVertex.sx; m2a = m2c = -l_oVertex.sx;
			matrix2.ty = l_oVertex.sy; m2b = m2d = -l_oVertex.sy;
			
			l_oVertex = l_aPoints [1];
			m2a += l_oVertex.sx; matrix2.a = m2a;
			m2b += l_oVertex.sy; matrix2.b = m2b;

			l_oVertex = l_aPoints [2];
			m2c += l_oVertex.sx; matrix2.c = m2c;
			m2d += l_oVertex.sy; matrix2.d = m2d;

			// transform 1st three normals
			// see if we are on the backside
			var backside:Boolean = true;
			for (i = 0; i < 3; i++)
			{
				v = aN [i]; v.copy (p_oPolygon.vertexNormals [i].getWorldVector());

				if (spherize > 0)
				{
					// too bad, l_aPoints [i].getWorldVector () gives viewMatrix-based coordinates
					// when vertexNormals [i].getWorldVector () gives modelMatrix-based ones :(
					// so we have to use cache for modelMatrix-based vertex coords (and also scaled)
					l_oVertex = l_aPoints [i];
					if (m_oVertices [l_oVertex] == null)
					{
						dv = l_oVertex.getVector ();
						dv.sub (p_oPolygon.shape.geometryCenter);
						p_oPolygon.shape.modelMatrix.vectorMult3x3 (dv);
						dv.normalize ();
						dv.scale (spherize);
						m_oVertices [l_oVertex] = dv;
					}
					else
					{
						dv = m_oVertices [l_oVertex];
					}
					v.add (dv);
					v.normalize ();
				}

				if (!p_oPolygon.visible) v.scale (-1);

				a = m_oL.dot (v); if (a < 0) backside = false;

				// intersect with parabola - q(r) in computeLightMap() corresponds to this
				v.scale (1 / (1 - a));
			}

			if (backside)
			{
				// no reflection here - render the face in solid color
				var l:int = lightmap.colors[0].length;
				var c:uint = lightmap.colors[0][l -1];
				a = lightmap.alphas[0][l -1];
				p_oGraphics.beginFill( c, a );
			}

			else
			{
				// calculate two arbitrary vectors perpendicular to light direction
				if ((m_oL.x != 0) || (m_oL.y != 0))
				{
					e1.x = m_oL.y; e1.y = -m_oL.x; e1.z = 0;
				}
				else
				{
					e1.x = m_oL.z; e1.y = 0; e1.z = -m_oL.x;
				}
				e2.copy (m_oL); e2.crossWith (e1);
				e1.normalize ();
				e2.normalize ();

				for (i = 0; i < 3; i++)
				{
					p = aNP [i]; v = aN [i];
					
					// project aN [i] onto e1 and e2
					p.x = e1.dot (v);
					p.y = e2.dot (v);

					// re-calculate into light map coordinates
					p.x = (16384 - 1) * 0.05 * p.x;
					p.y = (16384 - 1) * 0.05 * p.y;
				}

				// simple hack to resolve bad projections
				// where the hell do they keep coming from?
				p = aNP[0]; p1 = aNP[1]; p2 = aNP[2];
				a = (p.x - p1.x) * (p.y - p2.y) - (p.y - p1.y) * (p.x - p2.x);
				while ((-20 < a) && (a < 20))
				{
					p.x--; p1.y++; p2.x++;
					a = (p.x - p1.x) * (p.y - p2.y) - (p.y - p1.y) * (p.x - p2.x);
				}

				// compute gradient matrix
				matrix.a = p1.x - p.x;
				matrix.b = p1.y - p.y;
				matrix.c = p2.x - p.x;
				matrix.d = p2.y - p.y;
				matrix.tx = p.x;
				matrix.ty = p.y;
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
		private var aN:Array  = [new Vector (), new Vector (), new Vector ()];
		private var aNP:Array = [new Point (), new Point (), new Point ()];

		private var e1:Vector = new Vector ();
		private var e2:Vector = new Vector ();

		private var matrix:Matrix = new Matrix();
		private var matrix2:Matrix = new Matrix();
	}
}