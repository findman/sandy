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
import sandy.core.data.Pool;
import sandy.core.data.Vector;
	
/**
 * The <code>BBox</code> object is used to quickly and easily clip an object in a 3D scene.
 * <p>It creates a bounding box that contains the whole object</p>
 * 
 * @example 	This example is taken from the Shape3D class. It is used in
 * 				the <code>updateBoundingVolumes()</code> method:
 *
 * <listing version="3.0">
 *     _oBBox = BBox.create( m_oGeometry.aVertex );
 *  </listing>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - xdevltd
 * @version		2.0.2
 * @date 		22.03.2006
 */
 
class sandy.bounds.BBox
{
	
	/**
	 *	Specifies if this object's boundaries are up to date with the object it is enclosing.
	 * If <code>false</code>, this object's <code>transform()</code> method must be called to get its updated boundaries in the current frame.
	 */
	public var uptodate:Boolean;
	
	/**
	 * A vector, representing the highest point of the cube volume
	 */
	public var max:Vector;		
		
	/**
	 * A vector representing the lowest point of the cube volume.
	 */
	public var min:Vector;		

	public var tmin:Vector;
	public var tmax:Vector;
		
	public var aCorners:Array;
	public var aTCorners:Array;
	
	/**
	 * Creates a new BBox instance.
	 * 
	 * @param p_min		A vector representing the lowest point of the cube volume.
	 * @param p_max		A vector representing the highest point of the cube volume.
	 */		
	public function BBox( p_min:Vector, p_max:Vector )
	{
		uptodate = false;
		min		= ( p_min != null ) ? p_min : new Vector( -0.5, -0.5, -0.5 );
		max		= ( p_max != null ) ? p_max : new Vector(  0.5,  0.5,  0.5 );
		tmin = Pool.getInstance().nextVector;
		tmax = Pool.getInstance().nextVector;
		aCorners = new Array( 8 );
		aTCorners = new Array( 8 );
		__computeCorners( false );
	}	
	
	/**
	 * Creates a bounding box that encloses a 3D from an Array of the object's vertices.
	 * 
	 * @param p_aVertices		The vertices of the 3D object the bounding box will contain.
	 *
	 * @return The BBox instance.
	 */		
	public static function create( p_aVertices:Array ) : BBox
	{
		if( p_aVertices.length == 0 ) return null;
	   
	    var l:Number = p_aVertices.length;
	    var l_min:Vector = Pool.getInstance().nextVector;
	    var l_max:Vector = Pool.getInstance().nextVector;
		
		var lTmp:Array;
		lTmp = p_aVertices.sortOn( [ "x" ], [Array.NUMERIC|Array.RETURNINDEXEDARRAY ] );
		l_min.x = p_aVertices[ lTmp[ 0 ] ].x;
		l_max.x = p_aVertices[ lTmp[ lTmp.length - 1 ] ].x;
		  
		lTmp = p_aVertices.sortOn( [ "y" ], [ Array.NUMERIC|Array.RETURNINDEXEDARRAY ] );
		l_min.y = p_aVertices[ lTmp[ 0 ] ].y;
		l_max.y = p_aVertices[ lTmp[ lTmp.length - 1 ] ].y;
		  
		lTmp = p_aVertices.sortOn( [ "z" ], [ Array.NUMERIC|Array.RETURNINDEXEDARRAY ] );
		l_min.z = p_aVertices[ lTmp[ 0 ] ].z;
		l_max.z = p_aVertices[ lTmp[ lTmp.length - 1 ] ].z;
		 
		return new BBox( l_min, l_max );
	}	
	
	/**
	 * Returns the center of the bounding box volume.
	 * 
	 * @return A Vector representing the center of the bounding box.
	 */
	public function getCenter() : Vector
	{
		return new Vector( ( max.x + min.x ) / 2,
						   ( max.y + min.y ) / 2,
						   ( max.z + min.z ) / 2 );
	}

	/**
	 * Returns the size of the bounding box.
	 * 
	 * @return A Vector object representing the size of the volume in three dimensions.
	 */
	public function getSize() : Vector
	{
		return new Vector( Math.abs( max.x - min.x ),
						   Math.abs( max.y - min.y ),
						   Math.abs( max.z - min.z ) );
	}

	/**
	 * Get all the eight corner vertices of the bounding box.
	 * 
	 * @param p_bRecalcVertices 	If set to true the vertices array will be recalculated.
	 * 								Otherwise it will return the last calculated array.
	 * @return The array containing eight vertices representing the Bounding Box corners.
	 */
	private function __computeCorners( p_bRecalcVertices:Boolean ) : Array
	{
		if( p_bRecalcVertices == null ) p_bRecalcVertices = false;
		
		var minx:Number, miny:Number, minz:Number, maxx:Number, maxy:Number, maxz:Number;
		
		if( p_bRecalcVertices == true )
		{
		    minx = tmin.x;    miny = tmin.y;    minz = tmin.z;
		    maxx = tmax.x;    maxy = tmax.y;    maxz = tmax.z;
		}
		else
		{
		    minx = min.x;    miny = min.y;    minz = min.z;
		    maxx = max.x;    maxy = max.y;    maxz = max.z;
		}
		// --
		aTCorners[ 0 ] = Pool.getInstance().nextVector; aCorners[ 0 ] = new Vector( ( minx ), ( maxy ), ( maxz ) );
		aTCorners[ 1 ] = Pool.getInstance().nextVector; aCorners[ 1 ] = new Vector( ( maxx ), ( maxy ), ( maxz ) );
		aTCorners[ 2 ] = Pool.getInstance().nextVector; aCorners[ 2 ] = new Vector( ( maxx ), ( miny ), ( maxz ) );
		aTCorners[ 3 ] = Pool.getInstance().nextVector; aCorners[ 3 ] = new Vector( ( minx ), ( miny ), ( maxz ) );
		aTCorners[ 4 ] = Pool.getInstance().nextVector; aCorners[ 4 ] = new Vector( ( minx ), ( maxy ), ( minz ) );
		aTCorners[ 5 ] = Pool.getInstance().nextVector; aCorners[ 5 ] = new Vector( ( maxx ), ( maxy ), ( minz ) );
		aTCorners[ 6 ] = Pool.getInstance().nextVector; aCorners[ 6 ] = new Vector( ( maxx ), ( miny ), ( minz ) );
		aTCorners[ 7 ] = Pool.getInstance().nextVector; aCorners[ 7 ] = new Vector( ( minx ), ( miny ), ( minz ) );
		// --
		return aCorners;
	}	
	
    /**
     * Applies a transformation to the bounding box.
     * 
     * @param p_oMatrix		The transformation matrix.
     */		
    public function transform( p_oMatrix:Matrix4 ) : Void
    {
	    aTCorners[ 0 ].copy( aCorners[ 0 ] );
	    p_oMatrix.vectorMult( aTCorners[ 0 ] );
		tmin.copy( aTCorners[ 0 ] ); tmax.copy( tmin );

		var lId:Number;
		var lVector:Vector;
	    // --
	    for( lId = 1; lId < 8; lId ++ )
	    {
	        aTCorners[ lId ].copy( aCorners[ lId ] );
	        p_oMatrix.vectorMult( aTCorners[ lId ] );
	    
			lVector = aTCorners[ lId ];

			if( lVector.x < tmin.x )	  tmin.x = lVector.x;
			else if( lVector.x > tmax.x ) tmax.x = lVector.x;
			// --
			if( lVector.y < tmin.y )	  tmin.y = lVector.y;
			else if( lVector.y > tmax.y ) tmax.y = lVector.y;
			// --
			if( lVector.z < tmin.z )	  tmin.z = lVector.z;
			else if( lVector.z > tmax.z ) tmax.z = lVector.z;
    	}
	    	
    	// --
    	uptodate = true;
    }
	    
	/**
	 * Returns a string representation of this object.
	 *
	 * @return The fully qualified name of this object.
	 */			
	public function toString() : String
	{
		return "sandy.bounds.BBox";
	}
	
	/**
	 * Returns a new BBox object that is a clone of the original instance. 
	 * 
	 * @return A new BBox object that is identical to the original. 
	 */
	public function clone() : BBox
	{
	    var l_oBBox:BBox = new BBox();
	    l_oBBox.max = max.clone();
	    l_oBBox.min = min.clone();
	    l_oBBox.tmax = tmax.clone();
	    l_oBBox.tmin = tmin.clone();
	    return l_oBBox;
	}
	
}
