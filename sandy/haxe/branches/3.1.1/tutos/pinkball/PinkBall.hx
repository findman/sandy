import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;

import sandy.core.Scene3D;
import sandy.core.scenegraph.Camera3D;
import sandy.core.scenegraph.Group;
import sandy.core.scenegraph.Shape3D;
import sandy.materials.Appearance;
import sandy.materials.BitmapMaterial;
import sandy.parser.IParser;
import sandy.parser.Parser;
import sandy.parser.ParserEvent;

class PinkBall extends Sprite
{
	static inline var SCREEN_WIDTH:Int = 400;
	static inline var SCREEN_HEIGHT:Int = 400;

	static inline var SCREEN_WIDTH2:Float = SCREEN_WIDTH/2;
	static inline var SCREEN_HEIGHT2:Float = SCREEN_HEIGHT/2;

	private var scene : Scene3D;
	private var camera : Camera3D;
	private var model:Shape3D;
	private var container:Sprite;
	private var nLoaded:Int;

	private var fps: CustomFPS;
	private var ball:Shape3D;

	public function new()
	{
		nLoaded = 0;

		super();

		Lib.current.stage.quality = flash.display.StageQuality.MEDIUM;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE ;
		fps = new CustomFPS();
		fps.y = 12;
		addChild( fps );
		_init();
		_createScene();
		Lib.current.stage.addChild( this );
	}

	private function _init():Void
	{		
		container = new Sprite();
		addChild(container);
		//
		camera = new Camera3D( SCREEN_WIDTH, SCREEN_HEIGHT );
		camera.z = 140;
		scene = new Scene3D( "scene", container, camera, new Group() );
		return;
	}

	private function _createScene():Void
	{
		var ballAppearance:Appearance = new Appearance( new BitmapMaterial( new Ball() ) );			
		var lParser:IParser = Parser.create( "../assets/ball.dae", Parser.COLLADA, 1 );
		untyped lParser.addEventListener( ParserEvent.INIT, _initRender );
		untyped lParser.addEventListener( ParserEvent.FAIL, _failInit );
		lParser.standardAppearance = ballAppearance;
		lParser.parse();
	}

	private function _failInit( pEvt:ParserEvent ):Void
	{
		trace("model can't get parsed");
	}

	private function _initRender( pEvt:ParserEvent ):Void
	{
		// the parser creates a group in which the parsed objects are stored.
		var lGroup:Group = pEvt.group;
		// in this case, we have only one object per file, so we can access it that way.
		// you can also retrieve the correct object directly from its name.
		var lShape:Shape3D = cast lGroup.children[0];
		scene.root.addChild( lShape );

		++nLoaded;

		if( nLoaded == 2 )
		{
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
		}
		else
		{
			lShape.y += 40;
			ball = lShape;
			//ball.useSingleContainer = false;
			//
			var planeAppearance:Appearance = new Appearance( new BitmapMaterial( new Plane() ) );
			var lParser2:IParser = Parser.create( "../assets/plane.dae", Parser.COLLADA, 1 );
			untyped lParser2.addEventListener( ParserEvent.INIT, _initRender );
			untyped lParser2.addEventListener( ParserEvent.FAIL, _failInit );
			lParser2.standardAppearance = planeAppearance;
			lParser2.parse();
		}
	}

	private function enterFrameHandler( event : Event ) : Void
	{
		camera.x += ((container.mouseX - SCREEN_WIDTH2)* 4 - camera.x) / 10;
		camera.y += ((container.mouseY - SCREEN_HEIGHT2)* 4 - camera.y) / 10;
		// --
		camera.lookAt( 0, 40, 0 );
		// --
		ball.rotateY++;
		// --
		scene.render();	
		fps.nextFrame();
	}

	static function main ()
	{
	  new PinkBall();
	}

}

class Plane extends flash.display.BitmapData {
		public function new () {
				super(0,0);
		}
}

class Ball extends flash.display.BitmapData {
		public function new () {
				super(0,0);
		}
}
