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

import sandy.core.data.Matrix4;
import sandy.core.data.Vector;
import sandy.core.data.Vertex;	
import sandy.math.Matrix4Math;
import sandy.math.VectorMath;

/**
* The BSphere class is used to quickly and easily clip an object in a 3D scene.
* <p>It creates a bounding sphere that contains the whole object</p>
* 
* @example 	This example is taken from the Shape3D class. It is used in
* 				the <code>updateBoundingVolumes()</code> method:
*
* <listing version="3.0">
*     _oBSphere = BSphere.create( m_oGeometry.aVertex );
*  </listing>
*
* @author		Thomas Pfeiffer - kiroukou
* @author		Ported by FFlasher/Floris
* @version		2.0
* @date 		22.03.2006
*/

class sandy.bounds.BSphere
{
	/**
	 * Specifies if this object's boundaries are up to date with the object it is enclosing.
	 * If <code>false</code>, this object's <code>transform()</code> method must be called to get its updated boundaries in the current frame.
	 */
	public var uptodate:Boolean = false;
	
	/**
	 * A Vector representing the center of the bounding sphere.
	 */
		
	public var center:Vector ;
			
	/**
	 * The radius of the bounding sphere.
	 */
	public var radius:Number = 1;
	
	// -----------------------------
	//    [TRANSFORMED]  -----------
	public var position:Vector;
		
	/**
	 * Creates a bounding sphere that encloses a 3D from an Array of the object's vertices.
	 * 
	 * @param p_aVertices		The vertices of the 3D object the bounding sphere will contain.
	 * @return 					The BSphere instance.
	 */	
	public static function create( p_aVertices:Array ) : BSphere
	{
	    var l_sphere:BSphere = new BSphere();
	    /*
	    var l_min:Vector = new Vector();
	    var l_max:Vector = new Vector();
		
		var lTmp:Array;
		lTmp = p_aVertices.sortOn (["x"], [Array.NUMERIC|Array.RETURNINDEXEDARRAY ]);
		l_min.x = p_aVertices[lTmp[0]].x;
		l_max.x = p_aVertices[lTmp[lTmp.length-1]].x;
		  
		lTmp = p_aVertices.sortOn (["y"], [Array.NUMERIC|Array.RETURNINDEXEDARRAY ]);
		l_min.y = p_aVertices[lTmp[0]].y;
		l_max.y = p_aVertices[lTmp[lTmp.length-1]].y;
		  
		lTmp = p_aVertices.sortOn (["z"], [Array.NUMERIC|Array.RETURNINDEXEDARRAY ]);
		l_min.z = p_aVertices[lTmp[0]].z;
		l_max.z = p_aVertices[lTmp[lTmp.length-1]].z;
		
		l_sphere.center.copy( l_max );
		l_sphere.center.add( l_min );
		l_sphere.center.scale( 0.5 );
		
		// TODO : compare this method efficiency compared to the previous compute one
		var lDiff:Vector = l_max.clone();
		lDiff.sub( l_min );
		l_sphere.radius = lDiff.getMaxComponent()/2;
	    */
	    
	    l_sphere.compute( p_aVertices );
		return l_sphere;
	}
				
	/**
	 * <p>Creates a new BSphere instance.</p>
	 */ 	
	public function BSphere()
	{
		center = new Vector();
		position = new Vector();		
	}
		
	/**
     * Applies a transformation to the bounding sphere.
     * 
     * @param p_oMatrix		The transformation matrix.
     */	
    public function transform( p_oMatrix:Matrix4 ):Void
    {
        position.copy( center );
        p_oMatrix.vectorMult( position );
        //var l_ncale:Number = Math.sqrt( p_oMatrix.n11 * p_oMatrix.n11 + p_oMatrix.n22 * p_oMatrix.n22 + p_oMatrix.n33 * p_oMatrix.n33 );
        //tRadius = radius;// * l_ncale;
        uptodate = true;
    }
    
	/**
     * Returns a string representation of this object.
	 *
	 * @return	The fully qualified name of this object.
	 */ 	
	public function toString() : String
	{
		return "sandy.bounds.BSphere (center : " + center + ", radius : " + radius + ")";
	}
	
	/**
	 * Computes of the bounding sphere's center and radius.
	 * 
	 * @param p_aVertices		The vertices of the 3D object the bounding sphere will contain.
	 */		
	public function compute( p_aVertices:Array ) : Void
	{
		if( p_aVertices.length == 0 ) return;
		var x:Number, y:Number, z:Number, d:Number, i:Number = 0, j:Number = 0, l:Number = p_aVertices.length;
		var p1:Vertex = p_aVertices[0].clone();
		var p2:Vertex = p_aVertices[0].clone();
		// find the farthest couple of points
		var dmax:Number = 0;			
		var pA:Vertex, pB:Vertex;
		while( i < l )
		{
			j = i + 1;
			while( j < l )
			{
				pA = p_aVertices[ Math.round( i ) ];
				pB = p_aVertices[ Math.round( j ) ];
				x = pB.x - pA.x;
				y = pB.y - pA.y;
				z = pB.z - pA.z;
				d = x * x + y * y + z * z;
				if( d > dmax )
				{
					dmax = d;
					p1.copy( pA );
					p2.copy( pB );
				}
				j += 1;
			}
			i += 1;
		}
		// --
		center = new Vector( ( p1.x + p2.x ) / 2, ( p1.y + p2.y ) / 2, ( p1.z + p2.z ) / 2 );
		radius = Math.sqrt( dmax ) / 2;
	}
	  
	  
	/**
	 * Return the positions of the array of Position p that are outside the BoundingSphere.
	 * 
	 * @param 	An array containing the points to test
 	 * @return 	An array of points containing those that are outside. The array has a length 
 	 * 			of 0 if all the points are inside or on the surface.
	 */
	private function pointsOutofSphere( p_aPoints:Array ) : Array
	{
		var r:Array = new Array();
		var i:Number, l:Number = p_aPoints.length;
			
		while( i < l ) 
		{
			if( distance( p_aPoints[ Math.round( i ) ] ) > 0 ) 
			{
				r.push( p_aPoints[ Math.round( i ) ] );
			}
			
			i++;
		}
		return r;
	}
  
	/**
	 * Returns the distance of a Vector from the surface of the bounding sphere.
	 * The number returned will be positive if the vector is outside the sphere,
	 * negative if inside, or <code>0</code> if on the surface of the sphere.
	 * 
 	 * @return The distance from the bounding sphere to the Vector.
 	 */
	public function distance( p_oPoint:Vector ) : Number
	{
		var x:Number = p_oPoint.x - center.x;
		var y:Number = p_oPoint.y - center.y;
		var z:Number = p_oPoint.z - center.z;
		return  Math.sqrt( x * x + y * y + z * z ) - radius;
	}
		
	/**
	 * Computes the bounding sphere's radius.
	 * 
	 * @param p_aPoints		An Array containing the bounding sphere's points.
	 *
	 * @return The bounding sphere's radius.
	 */		
	private function computeRadius( p_aPoints:Array ) : Number
	{
		var x:Number, y:Number, z:Number, d:Number, dmax:Number = 0;
		var i:Number, l:Number = p_aPoints.length;
		while( i < l ) 
		{
			x = p_aPoints[ Math.round( i ) ].x - center.x;
			y = p_aPoints[ Math.round( i ) ].x - center.x;
			z = p_aPoints[ Math.round( i ) ].x - center.x;
			d = x * x + y * y + z * z;
			if( d > dmax ) dmax = d;
			i++;
		}
		return Math.sqrt( dmax );
	}
}
