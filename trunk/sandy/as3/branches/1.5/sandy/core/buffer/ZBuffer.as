///////////////////////////////////////////////////////////
//  ZBuffer.as
//  Macromedia ActionScript Implementation of the Class ZBuffer
//  Generated by Enterprise Architect
//  Created on:      26-VII-2006 13:46:11
//  Original author: Thomas Pfeiffer - kiroukou
///////////////////////////////////////////////////////////



package sandy.core.buffer
{
	/**
	 * Buffer of the z-depths.
	 * <p> This class is not a real Z-buffer as it is in all the real 3D engines. It
	 * handles the Z-sorting of MovieClips that's all in fact. The movieClips are
	 * drawn is the correct order to create the good depth effect. As this technic is
	 * fast but not very accurate, you may have some sorting problems when object
	 * faces are too close, or with large faces.
	 * </p>
	 * @author Thomas Pfeiffer - kiroukou
	 * @version 1.0
	 * @created 26-VII-2006 13:46:11
	 */
	public class ZBuffer
	{
	    static private var _a: Array = new Array();

	    /**
	     * Clear the current buffer.
	     * 
	     * @param Void
	     */
	    static public function dispose():void
	    {
			_a = [];
	    }

	    /**
	     * Store an Object into the buffer.
	     * <p>Currently, an object must be into this form :
	     * <code>{face:aFace, depth:zDepth}</code>.</p>
	     * 
	     * @param o    : An Object
	     */
	    static public function push(o:Object):void
	    {
	    	_a.push( o );
	    }

	    /**
	     * Sort the Array by depth, using {@link Array#NUMERIC} and {@link
	     * Array#DESCENDING}.
	     * @return	The sorted Array
	     * 
	     * @param Void
	     */
	    static public function sort():Array
	    {
		    // -- computes the sort depending on the z average of the faces
			_a.sortOn( "depth", Array.NUMERIC | Array.DESCENDING );
			return _a;
	    }
	}//end ZBuffer
}