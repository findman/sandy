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
package sandy.view ;

import sandy.bounds.BBox;
import sandy.bounds.BSphere;
import sandy.core.data.Plane;
import sandy.core.data.Point3D;
import sandy.core.data.Polygon;
import sandy.core.data.Pool;
import sandy.core.data.UVCoord;
import sandy.core.data.Vertex;
import sandy.math.PlaneMath;
import sandy.util.NumberUtil;

#if flash10
typedef TypedArray<T> = flash.Vector<T>;
#else
typedef TypedArray = Array;
#end
/**
 * Used to create the frustum of the camera.
 *
 * <p>The frustum is volume used to control if geometrical object, such as a box, a sphere, or a point
 * can be seen by the camera, and thus should be rendered.</p>
 * <p>Clipping of objects and polygons is performed against the frustum surfaces, as well as the near and far planes.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @version		3.1
 * @author		Niel Drummond - haXe port
 * @author		Russell Weir - haXe port
 */
class Frustum
{
	public var aPlanes:Array<Plane>;
	//  0-> +
	//  |
	//  V     5---4
	//  -    /|  /|
	//      / 6-/-7
	//     / / / /
	//    1---0 /
	//    |/  |/
	//    2---3
	public var aPoints:Array<Point3D>;
	public var aNormals:Array<Vertex>;
	public var aConstants:Array<Float>;
	private var m_aBoxEdges:Array<Point3D>;
	private var pool:Pool;
	private var aDist:TypedArray<Float>;
	// front plane : aNormals[0], aConstants[0] <-> aPoints[0], aPoints[1], aPoints[2], aPoints[3]
	// upper plane : aNormals[1], aConstants[1] <-> aPoints[0], aPoints[1], aPoints[4], aPoints[5]
	// lower plane : aNormals[2], aConstants[2] <-> aPoints[2], aPoints[3], aPoints[6], aPoints[7]
	// right plane : aNormals[3], aConstants[3] <-> aPoints[0], aPoints[3], aPoints[4], aPoints[7]
	// left plane  : aNormals[4], aConstants[4] <-> aPoints[1], aPoints[2], aPoints[5], aPoints[6]
	// back plane  : aNormals[5], aConstants[5] <-> aPoints[4], aPoints[5], aPoints[6], aPoints[7]
	public static inline var NEAR:Int 	= 0;
	public static inline var FAR:Int 	= 1;
	public static inline var RIGHT:Int 	= 2;
	public static inline var LEFT:Int	= 3;
	public static inline var TOP:Int 	= 4;
	public static inline var BOTTOM:Int = 5;

	public static var INSIDE:CullingState = CullingState.INSIDE;
	public static var OUTSIDE:CullingState = CullingState.OUTSIDE;
	public static var INTERSECT:CullingState = CullingState.INTERSECT;
	public static inline var EPSILON:Float = 0.005;

	/**
	 * Creates a frustum for the camera.
	 *
	 * <p>This constructor only creates the necessay data structures</p>
	 */
	public function new()
	{
		aPlanes = new Array();
		aPoints = new Array();
		aNormals = new Array();
		aConstants = new Array();
 		m_aBoxEdges = new Array(); // length 8
		pool = new Pool();
		aDist = new TypedArray(); // used only in clipPolygon
		for( i in 0...8 )
			m_aBoxEdges[i] = new Point3D();
	}

	/**
	 * Computes the frustum planes.
	 *
	 * @param p_nAspect	Aspect ration of the camera
	 * @param p_nNear	The distance from the camera to the near clipping plane
	 * @param p_nFar	The distance from the camera to the far clipping plane
	 * @param p_nFov	Vertical field of view of the camera
	 */
	public function computePlanes( p_nAspect:Float, p_nNear:Float, p_nFar:Float, p_nFov:Float ):Void
	{
		// store the information
		var lRadAngle:Float = NumberUtil.toRadian( p_nFov );
		// compute width and height of the near and far plane sections
		var tang:Float = Math.tan(lRadAngle * 0.5) ;

		// we inverse the vertical axis as Flash as a vertical axis inversed by our 3D one. VERY IMPORTANT
		var yNear:Float = -tang * p_nNear;
		var xNear:Float = yNear * p_nAspect;
		var yFar:Float = yNear * p_nFar / p_nNear;
		var xFar:Float = xNear * p_nFar / p_nNear;
		p_nNear = -p_nNear;
		p_nFar = -p_nFar;
		var p:Array<Point3D> = aPoints;
		p[0] = new Point3D( xNear, yNear, p_nNear); // Near, right, top
		p[1] = new Point3D( xNear,-yNear, p_nNear); // Near, right, bottom
		p[2] = new Point3D(-xNear,-yNear, p_nNear); // Near, left, bottom
		p[3] = new Point3D(-xNear, yNear, p_nNear); // Near, left, top
		p[4] = new Point3D( xFar,  yFar,  p_nFar);  // Far, right, top
		p[5] = new Point3D( xFar, -yFar,  p_nFar);  // Far, right, bottom
		p[6] = new Point3D(-xFar, -yFar,  p_nFar);  // Far, left, bottom
		p[7] = new Point3D(-xFar,  yFar,  p_nFar);  // Far, left, top

		aPlanes[LEFT] 	= PlaneMath.computePlaneFromPoints( p[2], p[3], p[6] ); // Left
		aPlanes[RIGHT] 	= PlaneMath.computePlaneFromPoints( p[0], p[1], p[4] ); // right
		aPlanes[TOP] 	= PlaneMath.computePlaneFromPoints( p[0], p[7], p[3] ); // Top
		aPlanes[BOTTOM] = PlaneMath.computePlaneFromPoints( p[1], p[2], p[5] ); // Bottom
		aPlanes[NEAR] 	= PlaneMath.computePlaneFromPoints( p[0], p[2], p[1] ); // Near
		aPlanes[FAR] 	= PlaneMath.computePlaneFromPoints( p[4], p[5], p[6] ); // Far

		for( i in 0...6 )
		{
			PlaneMath.normalizePlane( aPlanes[i] );
		}
	}

	/**
	 * Extracts the clipping planes.
	 *
	 * <p>[<strong>ToDo</strong>: Expalain this ]</p>
	 *
	 * @param comboMatrix
	 * @param normalize
	 *
	public function extractPlanes( comboMatrix:Matrix4, normalize:Bool ):Void
	{
		// Left clipping plane
		aPlanes[0].a = comboMatrix.n14 + comboMatrix.n11;
		aPlanes[0].b = comboMatrix.n24 + comboMatrix.n21;
		aPlanes[0].c = comboMatrix.n34 + comboMatrix.n31;
		aPlanes[0].d = comboMatrix.n44 + comboMatrix.n41;
		// Right clipping plane
		aPlanes[1].a = comboMatrix.n14 - comboMatrix.n11;
		aPlanes[1].b = comboMatrix.n24 - comboMatrix.n21;
		aPlanes[1].c = comboMatrix.n34 - comboMatrix.n31;
		aPlanes[1].d = comboMatrix.n44 - comboMatrix.n41;
		// Top clipping plane
		aPlanes[2].a = comboMatrix.n14 - comboMatrix.n12;
		aPlanes[2].b = comboMatrix.n24 - comboMatrix.n22;
		aPlanes[2].c = comboMatrix.n34 - comboMatrix.n32;
		aPlanes[2].d = comboMatrix.n44 - comboMatrix.n42;
		// Bottom clipping plane
		aPlanes[3].a = comboMatrix.n14 + comboMatrix.n12;
		aPlanes[3].b = comboMatrix.n24 + comboMatrix.n22;
		aPlanes[3].c = comboMatrix.n34 + comboMatrix.n32;
		aPlanes[3].d = comboMatrix.n44 + comboMatrix.n42;
		// Near clipping plane
		aPlanes[4].a = comboMatrix.n13;
		aPlanes[4].b = comboMatrix.n23;
		aPlanes[4].c = comboMatrix.n33;
		aPlanes[4].d = comboMatrix.n43;
		// Far clipping plane
		aPlanes[5].a = comboMatrix.n14 - comboMatrix.n13;
		aPlanes[5].b = comboMatrix.n24 - comboMatrix.n23;
		aPlanes[5].c = comboMatrix.n34 - comboMatrix.n33;
		aPlanes[5].d = comboMatrix.n44 - comboMatrix.n43;
		// Normalize the plane equations, if requested
		if ( normalize == true )
		{
			PlaneMath.normalizePlane( aPlanes[0] );
			PlaneMath.normalizePlane( aPlanes[1] );
			PlaneMath.normalizePlane( aPlanes[2] );
			PlaneMath.normalizePlane( aPlanes[3] );
			PlaneMath.normalizePlane( aPlanes[4] );
			PlaneMath.normalizePlane( aPlanes[5] );
		};
	}
*/
	/**
	 * Returns the culling state for the passed point.
	 *
	 * <p>The method tests if the passed point is within the frustum volume or not.<br/>
	 * The returned culling state is Frustum.INSIDE or Frustum.OUTSIDE</p>
	 *
	 * @param p_oPoint	The point to test
	 */
	public function pointInFrustum( p_oPoint:Point3D ):CullingState
	{
        for ( plane in aPlanes )
		{
			if ( PlaneMath.classifyPoint( plane, p_oPoint) == PlaneMath.NEGATIVE )
			{
				return Frustum.OUTSIDE;
			}
		}
		return Frustum.INSIDE ;
	}

	/**
	* Helping function to test a polygon against the frustum
	* <p>The method tests if the passed polygon is inside the frustum, outside or intersecting the frustum</p>
	*
	* @param p_oPoly The polygon to test
	*
	* @return The culling state of the polygon
	*/
	public function polygonInFrustum( p_oPoly:Polygon ):CullingState
	{
		var l_nIn:Int = 0, l_nOut:Int = 0, l_nDist:Float;
		// --
		for ( plane in aPlanes )
		{
			for ( l_oVertex in p_oPoly.vertices )
			{
				l_nDist = plane.a * l_oVertex.wx + plane.b * l_oVertex.wy + plane.c * l_oVertex.wz + plane.d;
				// is the corner outside or inside
				if ( l_nDist < 0 )
				{
					if( l_nIn > 0 )
						return Frustum.INTERSECT;
					l_nOut++;
				}
				else
				{
					if( l_nOut > 0 )
						return Frustum.INTERSECT;
					l_nIn++;
				}
			}
		}
		if( l_nIn == 0 )
			return Frustum.OUTSIDE ;
		else
			return Frustum.INSIDE ;
	}


	/**
	 * Returns the culling state for the passed bounding sphere.
	 *
	 * <p>The method tests if the bounding sphere is within the frustum volume or not.<br/>
	 * The returned culling state is Frustum.INSIDE, Frustum.OUTSIDE or Frustum.INTERSECT</p>
	 *
	 * @param p_oS	The sphere to test
	 */
	public function sphereInFrustum( p_oS:BSphere ):CullingState
	{
        var d:Float = 0, c:Int=0;
        var x:Float=p_oS.position.x, y:Float=p_oS.position.y, z:Float=p_oS.position.z, radius:Float = p_oS.radius;
        // --
        for ( plane in aPlanes )
        {
            d = plane.a * x + plane.b * y + plane.c * z + plane.d;
            if( d <= -radius )
            {
                return Frustum.OUTSIDE;
            }
            if( d > radius )
            {
                c++;
            }
        }
        // --
        return (c == 6) ? Frustum.INSIDE : Frustum.INTERSECT;
	}

	/**
	 * Returns the culling state for the passed bounding box.
	 *
	 * <p>The method tests if the bounding box is within the frustum volume or not.<br/>
	 * The returned culling state is Frustum.INSIDE, Frustum.OUTSIDE or Frustum.INTERSECT</p>
	 *
	 * @param p_oS	The box to test
	 */
	public function boxInFrustum( p_oBox:BBox ):CullingState
	{
		var result:CullingState = Frustum.INSIDE;
		var out:Float, iin:Float, lDist:Float;
		// --
		p_oBox.getEdges(m_aBoxEdges);
		// for each plane do the test
		for ( plane in aPlanes )
		{
			// reset counters for corners in and out
			out = 0; iin = 0;
			// for each corner of the box do ...
			// get out of the cycle as soon as a box as corners
			// both inside and out of the frustum
			for ( v in m_aBoxEdges )
			{
				lDist = plane.a * v.x + plane.b * v.y + plane.c * v.z + plane.d;
				// is the corner outside or inside
				if ( lDist < 0 )
				{
					out++;
				}
				else
				{
					iin++;
				}
				// --
				if( iin > 0 && out > 0 )
				{
					break;
				}
			}
			// if all corners are out
			if ( iin == 0 )
			{
				return Frustum.OUTSIDE;
			}
			// if some corners are out and others are in
			else if ( out > 0 )
			{
				return Frustum.INTERSECT;
			}
		}
		return result;
	}

	/**
	 * Clips a polygon against the frustum planes
	 *
	 * @param p_aCvert	Vertices of the polygon
	 * @param p_aUVCoords	UV coordiantes of the polygon
	 */
	public function clipFrustum( p_aCvert: Array<Vertex>, p_aUVCoords:Array<UVCoord> ):Bool
	{
        if( p_aCvert.length <= 2 ) return true;
		var l_bResult:Bool, l_bClipped:Bool;
		l_bResult = clipPolygon( aPlanes[NEAR], p_aCvert, p_aUVCoords ); // near
		l_bClipped = clipPolygon( aPlanes[LEFT], p_aCvert, p_aUVCoords ); // left
		l_bResult = l_bResult || l_bClipped;
		l_bClipped = clipPolygon( aPlanes[RIGHT], p_aCvert, p_aUVCoords ); // right
		l_bResult  = l_bResult || l_bClipped;
		l_bClipped = clipPolygon( aPlanes[BOTTOM], p_aCvert, p_aUVCoords ); // top
		l_bResult = l_bResult || l_bClipped;
		l_bClipped = clipPolygon( aPlanes[TOP], p_aCvert, p_aUVCoords ); // bottom
		l_bResult = l_bResult || l_bClipped;

		return l_bResult;
	}

	/**
	* Clips a polygon against the front frustum plane.
	*
	* @param p_aCvert		Vertices of the polygon.
	* @param p_aUVCoords	UV coordiantes of the polygon.
	*/
	public function clipFrontPlane( p_aCvert: Array<Vertex>, p_aUVCoords:Array<UVCoord> ):Bool
	{
		if( p_aCvert.length <= 2 ) return true;
		return clipPolygon( aPlanes[NEAR], p_aCvert, p_aUVCoords ); // near;
	}


	/**
	* Clip the given vertex and UVCoords arrays against the frustum front plane.
	*
	* @param p_aCvert	Vertices of the line.
	*/
	public function clipLineFrontPlane( p_aCvert: Array<Vertex> ):Bool
	{
		var l_oPlane:Plane = aPlanes[NEAR];
		var tmp:Array<Vertex> = p_aCvert.splice(0,p_aCvert.length);
		// --
		var v0:Vertex = tmp[0];
		var v1:Vertex = tmp[1];
		// --
		var l_nDist0:Float = l_oPlane.a * v0.wx + l_oPlane.b * v0.wy + l_oPlane.c * v0.wz + l_oPlane.d;
		var l_nDist1:Float = l_oPlane.a * v1.wx + l_oPlane.b * v1.wy + l_oPlane.c * v1.wz + l_oPlane.d;
		// --
		var d:Float = 0;
		var t:Vertex = new Vertex();
		// --
		if ( l_nDist0 < 0 && l_nDist1 >=0 )	// Coming in
		{
			d = l_nDist0/(l_nDist0-l_nDist1);
			t.wx = (v0.wx+(v1.wx-v0.wx)*d);
			t.wy = (v0.wy+(v1.wy-v0.wy)*d);
			t.wz = (v0.wz+(v1.wz-v0.wz)*d);
			//
			p_aCvert.push( t );
			p_aCvert.push( v1 );
			return true;
		}
		else if ( l_nDist1 < 0 && l_nDist0 >=0 ) // Going out
		{
			d = l_nDist0/(l_nDist0-l_nDist1);
			//
			t.wx = (v0.wx+(v1.wx-v0.wx)*d);
			t.wy = (v0.wy+(v1.wy-v0.wy)*d);
			t.wz = (v0.wz+(v1.wz-v0.wz)*d);

			p_aCvert.push( v0 );
			p_aCvert.push( t );
			return true;
		}
		else if( l_nDist1 < 0 && l_nDist0 < 0 ) // ALL OUT
		{
			p_aCvert = null;
			return true;
		}
		else if( l_nDist1 > 0 && l_nDist0 > 0 ) // ALL IN
		{
			p_aCvert.push( v0 );
			p_aCvert.push( v1 );
			return false;
		}
		return true;
	}


	/**
	 * Clips a polygon against one the frustum planes
	 *
	 * @param p_oPlane	The plane to clip against
	 * @param p_aCvert	Vertices of the polygon
	 * @param p_aUVCoords	UV coordiantes of the polygon
	 */
	public function clipPolygon( p_oPlane:Plane, p_aCvert:Array<Vertex>, p_aUVCoords:Array<UVCoord> ):Bool
	{
		var allin:Bool = true, allout:Bool = true;
		var v:Vertex;
		var i:Int, l:Int = p_aCvert.length, lDist:Float;
		// -- If no points, we return null
		#if flash10
		untyped aDist.length = 0;
		#else
		aDist.splice(0, aDist.length);
		#end
		// -- otherwise we compute the distances to frustum plane
		for ( v in p_aCvert )
		{
			lDist = p_oPlane.a * v.wx + p_oPlane.b * v.wy + p_oPlane.c * v.wz + p_oPlane.d;
			if (lDist < 0) allin = false;
			if (lDist >= 0) allout = false;
			aDist.push( lDist );
		}

		if (allin)
		{
			return false;
		}
		else if (allout)
		{
			// we return an empty array
			p_aCvert.splice(0,p_aCvert.length);
			p_aUVCoords.splice(0,p_aUVCoords.length);
			return true;
		}
		// Clip a polygon against a plane
		var tmp:Array<Vertex> = p_aCvert.splice(0,p_aCvert.length);
		var l_aTmpUv:Array<UVCoord> = p_aUVCoords.splice(0,p_aUVCoords.length);
		var l_oUV1:UVCoord = l_aTmpUv[0], l_oUV2:UVCoord = null, l_oUVTmp:UVCoord = null;
		var v1:Vertex = tmp[0], v2:Vertex = null,  t:Vertex = null;
		//
		var d:Float, dist2:Float, dist1:Float = aDist[0];
		var clipped:Bool = false, inside:Bool = (dist1 >= 0);
		var curv:Float = 0;
		for (i in 1...(l+1))
		{
			v2 = tmp[i%l];
			l_oUV2 = l_aTmpUv[i%l];
			//
			dist2= aDist[i%l];
			// Sutherland-hodgeman clipping
			if ( inside && (dist2 >= 0) )
			{
				p_aCvert.push(v2);	// Both in
				p_aUVCoords.push(l_oUV2);
			}
			else if ( (!inside) && (dist2>=0) )		// Coming in
			{
				clipped = inside = true;
				//
				t = pool.nextVertex;
				d = dist1/(dist1-dist2);
				t.wx = (v1.wx+(v2.wx-v1.wx)*d);
				t.wy = (v1.wy+(v2.wy-v1.wy)*d);
				t.wz = (v1.wz+(v2.wz-v1.wz)*d);
				//
				p_aCvert.push( t );
				p_aCvert.push( v2 );
				//
				l_oUVTmp = new UVCoord();
				l_oUVTmp.u = (l_oUV1.u+(l_oUV2.u-l_oUV1.u)*d);
				l_oUVTmp.v = (l_oUV1.v+(l_oUV2.v-l_oUV1.v)*d);
				//
				p_aUVCoords.push(l_oUVTmp);
				p_aUVCoords.push(l_oUV2);
			}
			else if ( inside && (dist2<0) )		// Going out
			{
				clipped=true;
				inside=false;
				t = pool.nextVertex;
				d = dist1/(dist1-dist2);
				//
				t.wx = (v1.wx+(v2.wx-v1.wx)*d);
				t.wy = (v1.wy+(v2.wy-v1.wy)*d);
				t.wz = (v1.wz+(v2.wz-v1.wz)*d);
				//
				l_oUVTmp = pool.nextUV;
				l_oUVTmp.u = (l_oUV1.u+(l_oUV2.u-l_oUV1.u)*d);
				l_oUVTmp.v = (l_oUV1.v+(l_oUV2.v-l_oUV1.v)*d);
				//
				p_aUVCoords.push(l_oUVTmp);
				p_aCvert.push( t );
			}
			else
			{
				clipped = true;		// Both out
			}

			v1 = v2;
			dist1 = dist2;
			l_oUV1 = l_oUV2;
		}
		// we free the distance array
		return true;
	}
}

