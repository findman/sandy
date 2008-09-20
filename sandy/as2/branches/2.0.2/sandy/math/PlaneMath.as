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

import sandy.core.data.Plane;
import sandy.core.data.Vector;
import sandy.errors.SingletonError;
import sandy.math.VectorMath;
	
/**
 * Math functions for planes.
 *  
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - xdevltd
 * @since		0.3
 * @version		2.0.2
 * @date 		26.07.2007
 */
	 
class sandy.math.PlaneMath
{
	
	/**
	 * Specifies a negative distance from a vector to a plane.
	 */
	public static var NEGATIVE:Number = -1;
		
	/**
	 * Specifies a vector is on a plane.
	 */
	public static var ON_PLANE:Number = 0;
		
	/**
	 * Specifies a positive distance from a vector to a plane.
	 */
	public static var POSITIVE:Number = 1;
		
	/**
	 * Normalizes the plane. 
	 * 
	 * <p>Often before making some calculations with a plane you have to normalize it.</p>
	 *
	 * @param p_oPlane 	The plane to normalize.
	 */
	public static function normalizePlane( p_oPlane:Plane ) : Void
	{
		var mag:Number;
		mag = Math.sqrt( p_oPlane.a * p_oPlane.a + p_oPlane.b * p_oPlane.b + p_oPlane.c * p_oPlane.c );
		p_oPlane.a = p_oPlane.a / mag;
		p_oPlane.b = p_oPlane.b / mag;
		p_oPlane.c = p_oPlane.c / mag;
		p_oPlane.d = p_oPlane.d / mag;
	}
		
	/**
	 * Computes the distance between a plane and a vector.
	 *
	 * @param p_oPlane	The plane.
	 * @param p_oVector	The vector.
	 *
	 * @return 	The distance between the vector and the plane.
	 */
	public static function distanceToPoint( p_oPlane:Plane, p_oVector:Vector ) : Number
	{
		return p_oPlane.a * p_oVector.x + p_oPlane.b * p_oVector.y + p_oPlane.c * p_oVector.z + p_oPlane.d;
	}
	
	/**
	 * Returns a classification constant depending on a vector's position relative to a plane.
	 * 
	 * <p>The classification is one of PlaneMath.NEGATIVE, PlaneMath.POSITIVE, and PlaneMath.ON_PLANE.</p>
	 *
	 * @param p_oPlane	The reference plane.
	 * @param p_oVector	The vector we want to classify.
	 *
	 * @return The classification of the vector.
	 */
	public static function classifyPoint( p_oPlane:Plane, p_oVector:Vector ) : Number
	{
		var d:Number;
		d = PlaneMath.distanceToPoint( p_oPlane, p_oVector );
			
		if( d < 0 )
		{
			return PlaneMath.NEGATIVE;
		}
		if( d > 0 )
		{
			return PlaneMath.POSITIVE;
		}
		
		return PlaneMath.ON_PLANE;
	}
		
	/**
	 * Computes a plane from three vectors.
	 *
	 * @param p_oVectorA	The first vector.
	 * @param p_oVectorB	The second vector.
	 * @param p_oVectorC	The third vector.
	 *
	 * @return 	The computed plane.
	 */
	public static function computePlaneFromPoints( p_oVectorA:Vector, p_oVectorB:Vector, p_oVectorC:Vector ) : Plane
	{
		var n:Vector = VectorMath.cross( VectorMath.sub( p_oVectorA, p_oVectorB ), VectorMath.sub( p_oVectorA, p_oVectorC ) );
		VectorMath.normalize( n );
		var d:Number = VectorMath.dot( p_oVectorA, n );
		// --
		return new Plane( n.x, n.y, n.z, d );
	}
	
	/**
	 * Computes a plane from a normal vector and a specified point.
	 *
	 * @param p_oNormal	The normal vector.
	 * @param p_nPoint	The point.
	 *
	 * @return 	The computed plane.
	 */
	public static function createFromNormalAndPoint( p_oNormal:Vector, p_nPoint:Number ) : Plane
	{
		var p:Plane = new Plane();
		VectorMath.normalize( p_oNormal );
		p.a = p_oNormal.x;
		p.b = p_oNormal.y;
		p.c = p_oNormal.z;
		p.d = p_nPoint;
		PlaneMath.normalizePlane( p );
		return p;
	}
	
}