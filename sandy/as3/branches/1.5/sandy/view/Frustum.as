///////////////////////////////////////////////////////////
//  Frustum.as
//  Macromedia ActionScript Implementation of the Class Frustum
//  Generated by Enterprise Architect
//  Created on:      26-VII-2006 13:46:05
///////////////////////////////////////////////////////////

import sandy.core.data.Matrix4;
import sandy.core.data.Vector;

package sandy.view
{
	/**
	 * @version 1.0
	 * @created 26-VII-2006 13:46:05
	 */
	public class Frustum
	{
	    public var aPlanes: Array;

	    /**
	     * TODO Need to implement BBox object and corresponding methods
	     * 
	     * @param box
	     */
	    public function boxInFrustum(box:Object): Number
	    {
	    }

	    /**
	     * 
	     * @param comboMatrix
	     * @param normalize
	     */
	    public function extractPlanes(comboMatrix:Matrix4, normalize:Boolean): Void
	    {
	    }

	    public function Frustum()
	    {
	    }

	    static public function get INSIDE(): Number
	    {
	    }

	    static public function get INTERSECT(): Number
	    {
	    }

	    static public function get OUTSIDE(): Number
	    {
	    }

	    /**
	     * 
	     * @param p
	     */
	    public function pointInFrustum(p:Vector): Number
	    {
	    }

	    /**
	     * TODO implement BSphere object and corresponding methods
	     * 
	     * @param s
	     */
	    public function sphereInFrustum(s:Object): Number
	    {
	    }

	}//end Frustum

}