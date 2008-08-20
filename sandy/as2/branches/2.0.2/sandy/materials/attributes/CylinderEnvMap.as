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

import com.bourre.data.collections.Map;

import flash.geom.Matrix;
import flash.geom.Point;

import sandy.core.SandyFlags;
import sandy.core.Scene3D;
import sandy.core.data.Polygon;
import sandy.core.data.Vector;
import sandy.core.data.Vertex;
import sandy.core.light.Light3D;
import sandy.materials.Material;
import sandy.materials.BitmapMaterial;
import sandy.materials.attributes.AAttributes;
import sandy.math.VertexMath;
import sandy.util.NumberUtil;

/**
 * Applies cylindric environment map.
 *
 * @author		makc
 * @author		(porting) Floris - FFlasher
 * @version		2.0.2
 */
	 
class sandy.materials.attributes.CylinderEnvMap extends AAttributes
{
	
	/**
	 * A bitmap-based material to use for environment map.
	 */
	public var mapMaterial:BitmapMaterial;

	/**
	 * Non-zero value adds sphere normals to actual normals for mapping.
	 * Use this with flat surfaces or cylinders.
	 */
	public var spherize:Number = 0;

	/**
	 * Create the CylinderEnvMap object.
	 *
	 * @param p_oBitmapMaterial A bitmap-based material to use for environment map.
	 */
	public function CylinderEnvMap( p_oBitmapMaterial:BitmapMaterial )
	{
		mapMaterial = p_oBitmapMaterial; mapMaterial.forceUpdate = true;

		m_nFlags |= SandyFlags.VERTEX_NORMAL_WORLD;
		
		// -- define some vars
		matrix = new Matrix();
		matrix2 = new Matrix();
		aN  = [ new Vector (), new Vector (), new Vector () ];
		aNP = [ new Point (), new Point (), new Point () ];
	}

	/**
	* @private
	*/
	public function draw( p_oMovieClip:MovieClip, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D ) : Void
	{
		var l_oVertex:Vertex,
			v:Vector, dv:Vector,
			p:Point, p1:Point, p2:Point,
			m2a:Number, m2b:Number, m2c:Number, m2d:Number, a:Number;

		// get vertices and prepare matrix2
		m_aPoints = ( p_oPolygon.isClipped ) ? p_oPolygon.cvertices : p_oPolygon.vertices;

		l_oVertex = m_aPoints[0];
		matrix2.tx = l_oVertex.sx; m2a = m2c = -l_oVertex.sx;
		matrix2.ty = l_oVertex.sy; m2b = m2d = -l_oVertex.sy;
			
		l_oVertex = m_aPoints[1];
		m2a += l_oVertex.sx; matrix2.a = m2a;
		m2b += l_oVertex.sy; matrix2.b = m2b;

		l_oVertex = m_aPoints[2];
		m2c += l_oVertex.sx; matrix2.c = m2c;
		m2d += l_oVertex.sy; matrix2.d = m2d;

		// transform 1st three normals
		for( i = 0; i < 3; i++ )
		{
			v = aN[i]; v.copy( p_oPolygon.vertexNormals[i].getWorldVector() );

			if( spherize > 0 )
			{
				// too bad, m_aPoints [i].getWorldVector () gives viewMatrix-based coordinates
				// when vertexNormals [i].getWorldVector () gives modelMatrix-based ones :(
				// so we have to use cache for modelMatrix-based vertex coords (and also scaled)
				l_oVertex = m_aPoints[i];
				if( m_oVertices[l_oVertex] == null )
				{
					dv = l_oVertex.getVector().clone();
					dv.sub( p_oPolygon.shape.geometryCenter );
					p_oPolygon.shape.modelMatrix.vectorMult3x3( dv );
					dv.normalize();
					dv.scale( spherize );
					m_oVertices.put( l_oVertex, dv );
				}
				else
				{
					dv = m_oVertices.get( l_oVertex );
				}
				v.add( dv );
				v.normalize();
			}

			if ( !p_oPolygon.visible ) v.scale( -1 );
		}

		// calculate coordinates in map texture
		computeMapping();

		// simple hack to resolve bad projections
		// where the hell do they keep coming from?
		p = aNP[0]; p1 = aNP[1]; p2 = aNP[2];
		a = ( p.x - p1.x ) * ( p.y - p2.y ) - ( p.y - p1.y ) * ( p.x - p2.x );
		while ( ( -2 < a ) && ( a < 2 ) )
		{
			p.x--; p1.y++; p2.x++;
			a = ( p.x - p1.x ) * ( p.y - p2.y ) - ( p.y - p1.y ) * ( p.x - p2.x );
		}

		// compute gradient matrix
		matrix.a = p1.x - p.x;
		matrix.b = p1.y - p.y;
		matrix.c = p2.x - p.x;
		matrix.d = p2.y - p.y;
		matrix.tx = p.x;
		matrix.ty = p.y;
		matrix.invert();

		matrix.concat( matrix2 );
		p_oMovieClip.beginBitmapFill( mapMaterial.texture, matrix, mapMaterial.repeat, mapMaterial.smooth );

		// render the map
		p_oMovieClip.moveTo( m_aPoints[0].sx, m_aPoints[0].sy );
		for( l_oVertex in m_aPoints )
		{
			p_oMovieClip.lineTo( m_aPoints[l_oVertex].sx, m_aPoints[l_oVertex].sy  );
		}
		p_oMovieClip.endFill();

		// --
		m_aPoints = null;
	}

	/**
	 * @private override this to create custom mapping m_aPoints, aN -> aNP
	 */
	private function computeMapping() : Void
	{
		var p:Point, v:Vector;
		for( i = 0; i < 3; i++ )
		{
			p = aNP[i]; v = aN[i];

			// x, z = -1 -> u = 0.5 
			p.x = 0.5 * ( 1 + Math.atan2( v.x, -v.z ) / Math.PI );

			// y -> v
			p.y = 0.5 * ( 1 - v.y );

			// re-calculate into map coordinates
			p.x *= mapMaterial.texture.width;
			p.y *= mapMaterial.texture.height;
		}
	}

	/**
	 * @private
	 */
	private var aN:Array;

	/**
	 * @private
	 */
	private var aNP:Array;

	/**
	 * @private
	 */
	private var m_aPoints:Array;

	// vertex dictionary
	private var m_oVertices:Map;

	/**
	 * @private
	 */
	public function begin( p_oScene:Scene3D ) : Void
	{
		// clear vertex dictionary
		m_oVertices = new Map();
	}

	// --
	private var matrix:Matrix;
	private var matrix2:Matrix;
	
}