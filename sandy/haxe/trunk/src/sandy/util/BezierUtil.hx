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

package sandy.util;

import sandy.core.data.Vector;
import sandy.math.VectorMath;
      	
      	/**
 * Utility class for Bézier calculations.
 * 
 * <p>All credits go to Alex Ulhmann and his Animation Package Library </p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 * 
 */
class BezierUtil 
{
	/**
	 * Returns a point on a quadratic Bézier curve.
	 * 
	 * <p>Adapted from Robert Penner<br />
	 * with Robert Penner's optimization of the standard equation.</p>
	 * 
	 * @param p 	A fraction between [0-1] of the whole curve
	 * @param p1 	First point
	 * @param p2 	Second point
	 * @param p3 	Third point
	 * @return 	The resulting position vector
	 */
	public static inline function getPointsOnQuadCurve(p:Float, p1:Vector, p2:Vector, p3:Vector):Vector 
	{
		var ip2:Float = 2 * ( 1 - p );
		return new Vector(
			p1.x + p*(ip2*(p2.x-p1.x) + p*(p3.x - p1.x)),
			p1.y + p*(ip2*(p2.y-p1.y) + p*(p3.y - p1.y)),
			p1.z + p*(ip2*(p2.z-p1.z) + p*(p3.z - p1.z))
		);
	}
	
	/**
	 * Returns a point on a qubic Bézier curve.
	 * 
	 * <p>Adapted from Paul Bourke.</p>
	 * 
	 * @param p 	A fraction between [0-1] of the whole curve
	 * @param p1 	First point
	 * @param p2 	Second point
	 * @param p3 	Third point
	 * @param p4 	Fourth point
	 * @return 	The resulting position vector
	 */	
	public static inline function getPointsOnCubicCurve(p:Float, p1:Vector, p2:Vector, p3:Vector, p4:Vector):Vector 
	{
		var a:Float,b:Float,c:Float,d:Float,e:Float;	
		d = p * p;
		a = 1 - p;
		e = a * a;
		b = e * a;
		c = d * p;
		return new Vector(
			b * p1.x + 3 * p * e * p2.x + 3 * d * a * p3.x + c * p4.x,
			b * p1.y + 3 * p * e * p2.y + 3 * d * a * p3.y + c * p4.y,
			b * p1.z + 3 * p * e * p2.z + 3 * d * a * p3.z + c * p4.z
		);
	}
	
	/**
	 * Returns the control point for a quadratic Bézier curve.
	 *
	 * <p>Adapted from Robert Penner's drawCurve3Pts() method</p>
	 *
	 * @param start		The start point of the curve
	 * @param middle	The middle point
	 * @param end	 	The end point
	 * @return		The control point
	 */
	public static inline function getQuadControlPoints(start:Vector, middle:Vector,end:Vector):Vector
	{						        
		return new Vector(
			(2 * middle.x) - .5 * (start.x + end.x),
			(2 * middle.y) - .5 * (start.y + end.y),  
			(2 * middle.z) - .5 * (start.z + end.z)
		);
	}	
	
	/**
	 * Returns the control points for a qubic Bézier curve.
	 * 
	 * <p>If anybody finds a generic method to compute control points 
	 * for bezier curves with n control points, if only the points on the curve are given, 
	 * please let us know!</p>
	 * 
	 * @param start		The start point of the curve
	 * @param through1 	The second point
	 * @param through2 	The third point
	 * @param end	 	The end point
	 * @return 		A two dimensional array containing the two controls points.
	 */	
	public static inline function getCubicControlPoints(start:Vector, through1:Vector, through2:Vector, end:Vector):Array<Vector>
	{
		return [
			new Vector( 
				-(10 * start.x - 3 * end.x - 8 * (3 * through1.x - through2.x)) / 9,
				-(10 * start.y - 3 * end.y - 8 * (3 * through1.y - through2.y)) / 9,
				-(10 * start.z - 3 * end.y - 8 * (3 * through1.z - through2.z)) / 9 )
			,
			new Vector(
				(3 * start.x - 10 * end.x - 8 * through1.x + 24 * through2.x) / 9,
				(3 * start.y - 10 * end.y - 8 * through1.y + 24 * through2.y) / 9,
				(3 * start.z - 10 * end.z - 8 * through1.z + 24 * through2.z) / 9 )
			];
	}

	/**
	 * Applies the de Casteljau's algorithm.
	 *
	 * <p>[<strong>ToDo</strong>: Better explanations - link to wikipedia ]</p>
	 *
	 * @param p 	A fraction between [0-1] of the whole curve
	 * @param plist	The list of control points of the Bézier curve.
	 * @return	The position on the Bézier curve at the fraction p of the curve.
	 */
	public static inline function casteljau( p:Float, plist:Array<Vector> ):Vector
	{
		var list:Array<Vector> = plist.slice(0);
		var aNewList:Array<Vector> = [];
		var i:Int = 0;
		do
		{
			for( i in 0...(list.length-1) )
			{
				var v1:Vector = VectorMath.scale( VectorMath.clone( list[i] ), 1.0 - p );
				var v2:Vector = VectorMath.scale( VectorMath.clone( list[i+1] ), p );
				aNewList.push( VectorMath.addVector( v1, v2 ) );
				//delete v1; delete v2; // throws an error in as3
			}
			//delete list; // throws an error in as3
			list = aNewList;
			aNewList = [];
		} while( list.length > 1 );
		// --
		if( list.length != 1 )
		{
			trace('sandy.util.BezierUtil::casteljau > Error, size of array must be equal to 1');
		}
		// --
		return list[0];
	}
	
	/**
	 * Applies a more robust de Casteljau's algorithm if the intervals are "wierd".
	 * 
	 * <p>UNTESTED METHOD. MAY BE REMOVED IN THE FUTURE VERSION. USE IT CAREFULLY.</p>
	 * <p>[<strong>ToDo</strong>: Better explanations - link to wikipedia ]</p>
	 *
	 * @param p 	A fraction between [0-1] of the whole curve
	 * @param plist	The list of control points of the Bézier curve.
	 * @param	pdeb
	 * @param	pfin
	 * @return	The position on the Bézier curve at the fraction p of the curve.
	 */
	public static inline function casteljau_interval( p:Float, plist:Array<Vector>, pdeb:Int, pfin:Int ):Vector
	{
		var aNewList:Array<Vector> = plist.slice(0);
		// --
		for( i in pdeb...pfin )
		{
			var loc_p:Int = i % ( plist.length );
			if ( p < 0 ) 
				loc_p += plist.length;
			// --
			aNewList.push( plist[loc_p] );
		}
		// --
		return BezierUtil.casteljau( p, aNewList );
	}
}

