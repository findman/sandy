package org.aswing.dnd;

extern class DirectlyRemoveMotion implements DropMotion {
	function new() : Void;
	function forceStop() : Void;
	function startMotionAndLaterRemove(dragInitiator : org.aswing.Component, dragObject : flash.display.Sprite) : Void;
}
