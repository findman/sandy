
package sandy.animation;

import sandy.HaxeTypes;

/**
 * Interface for items that are key framed, Key frames have geometry for
 * specific frames, with any in-between frames being interpolated by
 * Sandy.
 *
 * @author		Russell Weir (madrok)
 * @date		03.21.2009
 * @version		3.2
 **/
interface IKeyFramed {
	/**
	* Frame number. You can tween this value to play key framed animation.
	*/
	public var frame (__getFrame,__setFrame):Float;

	/**
	* Number of frames available in animation
	**/
	public var frameCount(__getFrameCount,null):Int;

	/**
	* If set, the boundingBox and sphere will be updated on
	* each frame change. This involves an interpolation of the
	* bounds between frames, and if set to off, the bounds will
	* be based on the closest whole frame. Default is false (off).
	**/
	public var updateBoundsPerFrame(__getUpdateBoundsPerFrame,__setUpdateBoundsPerFrame):Bool;

	/**
	* Appends frame copy to animation.
	* You can use this to rearrange an animation at runtime, create transitions, etc.
	*
	* @return number of created frame.
	*/
	public function appendFrameCopy (frameNumber:Int):Int;

	/**
	* Replaces specified frame with other key or interpolated frame.
	*/
	public function replaceFrame (destFrame:Int, sourceFrame:Float):Void;

}
