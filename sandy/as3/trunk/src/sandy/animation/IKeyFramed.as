// This class is generated from haxe branch r1141
// missing declarations added by hand
package sandy.animation {
	public interface IKeyFramed {
		
		function __getFrame() : Number;
		function get frame() : Number;
		function __setFrame(__v : Number ) : Number;
		function set frame( __v : Number ) : void;
		function __getFrameCount() : int;
		function get frameCount() : int;
		
		
		function appendFrameCopy(frameNumber : int) : int ;
		function replaceFrame(destFrame : int,sourceFrame : Number) : void ;
	}
}
