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
package sandy.bounds;

import sandy.core.data.Matrix4;
import sandy.core.data.Vector;
import sandy.core.data.Vertex;	

/**
 * The <code>BSphere</code> object is used to clip the object faster.
 * <p>It Creates a bounding sphere that contains the whole object</p>
 * 
 * @example 	This example is taken from the Shape3D class. It is used in
 * 				the <code>updateBoundingVolumes()</code> method:
	 *
	 * <listing version="3.0">
	 *     _oBSphere = BSphere.create( m_oGeometry.aVertex );
	 *  </listing>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 */
class BSphere
{
	/**
	 * Specify if this object is up to date or not.
	 * If false, you need to call its transform method to get its correct bounds in the desired frame.
	 */
	public var uptodate:Bool;
	
	public var center:Vector;
	public var radius:Float;
	// -----------------------------
	//    [TRANSFORMED]  -----------
	public var position:Vector;
	
	/**
	 * Creates a bounding sphere that encloses a 3D object. This object's vertices are passed
	 * to the <code>create</code> method in the form of an <code>Array</code>. Very useful 
	 * for clipping and thus performance!
	 * 
	 * @param p_aVertices		The vertices of the 3D object
	 * @return 					A <code>BSphere</code> instance
	 */	
	public static function create( p_aVertices:Array<Vertex> ):BSphere
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
	 * <p>Create a new <code>BSphere</code> instance.</p>
	 */ 	
	public function new()
	{
	 uptodate = false;
	 center = new Vector();
	 radius = 1;
	 position = new Vector();
	}
	
	/**
     * Applies the transformation that is specified in the <code>Matrix4</code> parameter.
     * 
     * @param p_oMatrix		The transformation matrix
     */	
    public function transform( p_oMatrix:Matrix4 ):Void
    {
        position.copy( center );
        p_oMatrix.vectorMult( position );
        //var l_ncale:Float = Math.sqrt( p_oMatrix.n11 * p_oMatrix.n11 + p_oMatrix.n22 * p_oMatrix.n22 + p_oMatrix.n33 * p_oMatrix.n33 );
        //tRadius = radius;// * l_ncale;
        uptodate = true;
    }
    
	/**
	* Returns a <code>String</code> represntation of the <code>BSphere</code>.
	* 
	* @return	A String representing the bounding sphere
	*/ 	
	public function toString():String
	{
		return "sandy.bounds.BSphere (center : "+center+", radius : "+radius + ")";
	}
	
	/**
	 * Performs the actual computing of the bounding sphere's center and radius
	 * 
	 * @param p_aVertices		The vertices of the 3D object
	 */		
	public function compute( p_aVertices:Array<Vertex> ):Void
	{
		if(p_aVertices.length == 0) return;
		var x:Float, y:Float, z:Float, d:Float, i:Int = 0, j:Int = 0, l:Int = p_aVertices.length;
		var p1:Vertex = p_aVertices[0].clone();
		var p2:Vertex = p_aVertices[0].clone();
		// find the farthest couple of points
		var dmax:Float = 0;			
		var pA:Vertex, pB:Vertex;
		while( i < l )
		{
			j = i + 1;
			while( j < l )
			{
				pA = p_aVertices[i];
				pB = p_aVertices[j];
				x = pB.x - pA.x;
				y = pB.y - pA.y;
				z = pB.z - pA.z;
				d = x * x + y * y + z * z;
				if(d > dmax)
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
		center = new Vector((p1.x + p2.x) / 2, (p1.y + p2.y) / 2, (p1.z + p2.z) / 2);
		radius = Math.sqrt(dmax) / 2;
	}
  
  
	/**
	 * Return the positions of the array of Position p that are outside the BoundingSphere.
	 * 
	 * @param 	An array containing the points to test
 	 * @return 	An array of points containing those that are outside. The array has a length 
 	 * 			of 0 if all the points are inside or on the surface.
	 */
	private function pointsOutofSphere(p_aPoints:Array<Vector>):Array<Vector>
	{
		var r:Array<Vector> = new Array();
		var i:Int = 0, l:Int = p_aPoints.length;
		
		while( i < l ) 
		{
			if(distance(p_aPoints[(i)]) > 0) 
			{
				r.push( p_aPoints[(i)] );
			}
			
			i++;
		}
		return r;
	}
  
	/**
	 * Returns the distance of a point from the surface.
	 * 
	 * @return 	>0 if position is outside the sphere, <0 if inside, =0 if on the surface of the sphere
	 */
	public function distance(p_oPoint:Vector):Float
	{
		var x:Float = p_oPoint.x - center.x;
		var y:Float = p_oPoint.y - center.y;
		var z:Float = p_oPoint.z - center.z;
		return  Math.sqrt(x * x + y * y + z * z) - radius;
	}
	
	/**
	 * Computes the bounding sphere's radius
	 * 
	 * @param p_aPoints		An array containing the sphere's points
	 * @return 				The bounding sphere's radius
	 */		
	private function computeRadius(p_aPoints:Array<Vertex>):Float
	{
		var x:Float, y:Float, z:Float, d:Float, dmax:Float = 0;
		var i:Int = 0, l:Int = p_aPoints.length;
		while( i < l ) 
		{
			x = p_aPoints[(i)].x - center.x;
			y = p_aPoints[(i)].x - center.x;
			z = p_aPoints[(i)].x - center.x;
			d = x * x + y * y + z * z;
			if(d > dmax) dmax = d;
			i++;
		}
		return Math.sqrt(dmax);
	}
}

