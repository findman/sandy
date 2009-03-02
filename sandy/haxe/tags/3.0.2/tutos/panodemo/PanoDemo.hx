import flash.display.Bitmap;
import flash.display.Sprite;
import flash.display.StageDisplayState;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.ui.Keyboard;
import flash.Lib;

import sandy.core.World3D;
import sandy.core.scenegraph.Camera3D;
import sandy.core.scenegraph.Group;
import sandy.events.QueueEvent;
import sandy.events.SandyEvent;
import sandy.materials.Appearance;
import sandy.materials.BitmapMaterial;
import sandy.primitive.SkyBox;
import sandy.util.LoaderQueue;
import sandy.util.NumberUtil;
import sandy.materials.Material;

class PanoDemo extends Sprite
{
	public function new():Void
	{
		world = World3D.getInstance();
		running = false;
	 keyPressed = new Array();
	 queue = new LoaderQueue();

		super();

		init();
		Lib.current.stage.addChild(this);
	}
	
	private var world:World3D;
	private var shape:SkyBox;
	private var planeNames:Array<String>;
	private var running:Bool;
	private var keyPressed:Array<Bool>;
	private var queue:LoaderQueue;
	private var camera:Camera3D;
	
	public function init():Void
	{
		world.container = this;
		world.root = createScene();
		camera = world.camera = new Camera3D( 640, 500 );
		world.camera.fov = 60;
		planeNames = [ "GOLD44", "GOLD22" , "GOLD66", "GOLD55","GOLD11" , "GOLD33" ];			
		world.root.addChild( world.camera );
		// --
		loadImages();	
	}
	
	public function __onKeyDown(e:KeyboardEvent):Void
	{
           keyPressed[e.keyCode] = true;
           if( e.keyCode == Keyboard.SPACE )
           	stage.displayState = StageDisplayState.FULL_SCREEN;
       }

       public function __onKeyUp(e:KeyboardEvent):Void
       {
          keyPressed[e.keyCode] = false;
       }
	
	private function clickHandler( p_oEvt:Event ):Void
	{
		running = !running;
	}
	
	//  -- Loading images
	private function loadImages():Void
	{
		// --
		for ( i in 0...6)
		{
			queue.add( planeNames[i], new URLRequest("../assets/golden/"+planeNames[i]+".jpg") );
		}
		// --
		queue.addEventListener(SandyEvent.QUEUE_COMPLETE, loadComplete );
		queue.start();
	}
	
	private function getMaterial( p_nId:UInt ):Material
	{
		var l_nPrecision:UInt = 10;
		var l_oMat:BitmapMaterial = new BitmapMaterial( Reflect.field( queue.data.get(planeNames[p_nId]), "bitmapData" ), null, l_nPrecision );
		l_oMat.repeat = true;
		l_oMat.maxRecurssionDepth = 6;
		return l_oMat;
	}
	
	private function loadComplete( event:QueueEvent ):Void 
	{			
		shape.front.appearance = new Appearance( getMaterial(1) );
		shape.back.appearance = new Appearance( getMaterial(0) );
		shape.left.appearance = new Appearance( getMaterial(4) );
		shape.right.appearance = new Appearance( getMaterial(5) );
		shape.top.appearance = new Appearance( getMaterial(3) );
		shape.bottom.appearance = new Appearance(  getMaterial(2) );				
		// --
		
		shape.front.enableClipping = true;
		shape.back.enableClipping = true;
		shape.left.enableClipping = true;
		shape.right.enableClipping = true;
		shape.top.enableClipping = true;
		shape.bottom.enableClipping = true;
		
		/*
		shape.front.enableNearClipping = true;
		shape.back.enableNearClipping = true;
		shape.left.enableNearClipping = true;
		shape.right.enableNearClipping = true;
		shape.top.enableNearClipping = true;
		shape.bottom.enableNearClipping = true;
		*/
		// --
		stage.addEventListener(MouseEvent.CLICK, clickHandler);
		addEventListener( Event.ENTER_FRAME, enterFrameHandler );
		// --		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, __onKeyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, __onKeyUp);
		// --
		running = true;		
	}
	
	// Create the root Group and the object tree 
	private function createScene():Group
	{
		var root:Group = new Group("root");
		shape = new SkyBox( "pano", 300, 1, 1 );
		root.addChild( shape );
		return root;
	}
	var frame:Null<Int>;

	private function enterFrameHandler( event : Event ) : Void
	{
			if ( frame == null ) frame = 0;
		if( running )
		{
				var lon = Math.PI * ( stage.stageWidth/2 - this.mouseX ) / (stage.stageWidth/2);
				var lat = Math.PI * ( stage.stageHeight/2 - this.mouseY ) / stage.stageHeight;

				// standard sphere with swapped z and y
				var x = Math.cos(lon) * Math.cos(lat);
				var z = Math.sin(lon) * Math.cos(lat);
				var y = Math.sin(lat);

				camera.lookAt (x, y, z);

				//trace ("lat=" + Math.round(180 * lat / Math.PI) + ", lon=" + Math.round(180 * lon / Math.PI) +
				//				": rotateX/Y/Z are " +
				//   Math.round (camera.rotateX) + ", " +
				//   Math.round (camera.rotateY) + ", " +
				//   Math.round (camera.rotateZ) + " (rounded)");

		frame++;

			world.render();
			flash.Lib.trace(Std.string( Math.floor( frame/(Lib.getTimer()) *1000 ) ) + 'fps');

		}
	}
	static function main () {
			new PanoDemo();
	}
}

