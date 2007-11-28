///////////////////////////////////////////////////////////
//  BezierUtil.as
//  Macromedia ActionScript Implementation of the Class BezierUtil
//  Generated by Enterprise Architect
//  Created on:      26-VII-2006 13:46:04
//  Original author: Thomas Pfeiffer - kiroukou
///////////////////////////////////////////////////////////

package sandy.util
{
	import sandy.core.data.Vector;
	import sandy.math.VectorMath;
	
	/**
	 * BezierUtil All credits go to Alex Ulhmann and its Animation Package Library
	 * @since		1.0
	 * @author Thomas Pfeiffer - kiroukou
	 * @version 1.0
	 * @date 		27.04.2006
	 * @created 26-VII-2006 13:46:04
	 */
	public class BezierUtil
	{
	    /**
	     * Apply the casteljau algorithm.
	     * @return	Vector	The position on the Bezier curve at the ration p of the curve.
	     * 
	     * @param p    Number	A percentage value between [0-1]
	     * @param plist    Array of Vector The list of vector that are used as control
	     * points of the Bezier curve.
	     */
	    static public function casteljau(p:Number, plist:Array): Vector
	    {
	    	var list:Array = plist.slice();
			var aNewList:Array = [];
			var i:Number = 0;
			do
			{
				for( i=0; i < list.length-1; i++ )
				{
					var v1:Vector = VectorMath.scale( VectorMath.clone( list[i] ), 1.0 - p );
					var v2:Vector = VectorMath.scale( VectorMath.clone( list[i+1] ), p );
					aNewList.push( VectorMath.addVector( v1, v2 ) );
					v1 = v2 = null;
				}
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
	     * More robust casteljau algorithm if the intervals are wierd. UNTESTED METHOD.
	     * MAY BE REMOVED IN THE FUTURE VERSION. USE IT CAREFULLY.
	     * @return
	     * 
	     * @param p
	     * @param plist
	     * @param pdeb
	     * @param pfin
	     */
	    static public function casteljau_interval(p:Number, plist:Array, pdeb:Number, pfin:Number): Vector
	    {
	    	var aNewList:Array = plist.slice();
			// --
			for( var i:Number = pdeb; i < pfin; i++)
			{
				var loc_p:Number = i % ( plist.length );
				if ( p < 0 ) 
					loc_p += plist.length;
				// --
				aNewList.push( plist[loc_p] );
			}
			// --
			return BezierUtil.casteljau( p, aNewList );
	    }

	    /**
	     * @method getCubicControlPoints
	     * @description 	if anybody finds a generic method to compute control points for
	     * bezier curves with n control points, if only the points on the curve are given,
	     * please let us know!
	     * @return Array of Vector. A two dimensionnal array containing the two controls
	     * points.
	     * 
	     * @param start    (Vector)
	     * @param through1    (Vector)
	     * @param through2    (Vector)
	     * @param end    (Vector)
	     */
	    static public function getCubicControlPoints(start:Vector, through1:Vector, through2:Vector, end:Vector): Array
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
	     * Adapted from Paul Bourke.
	     * 
	     * @param p
	     * @param p1
	     * @param p2
	     * @param p3
	     * @param p4
	     */
	    static public function getPointsOnCubicCurve(p:Number, p1:Vector, p2:Vector, p3:Vector, p4:Vector): Vector
	    {
	    	var a:Number,b:Number,c:Number,d:Number,e:Number;	
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
	     * Adapted from Robert Penner.
	     * 
	     * @param p
	     * @param p1
	     * @param p2
	     * @param p3
	     */
	    static public function getPointsOnQuadCurve(p:Number, p1:Vector, p2:Vector, p3:Vector): Vector
	    {
	    	var ip2:Number = 2 * ( 1 - p );
			return new Vector(
								p1.x + p*(ip2*(p2.x-p1.x) + p*(p3.x - p1.x)),
								p1.y + p*(ip2*(p2.y-p1.y) + p*(p3.y - p1.y)),
								p1.z + p*(ip2*(p2.z-p1.z) + p*(p3.z - p1.z))
							  );
	    }

	    /**
	     * Adapted from Robert Penner's drawCurve3Pts() method
	     * 
	     * @param start
	     * @param middle
	     * @param end
	     */
	    static public function getQuadControlPoints(start:Vector, middle:Vector, end:Vector): Vector
	    {
	    	return new Vector(
								(2 * middle.x) - .5 * (start.x + end.x),
								(2 * middle.y) - .5 * (start.y + end.y),  
								(2 * middle.z) - .5 * (start.z + end.z)
							 );
	    }

	}//end BezierUtil

}