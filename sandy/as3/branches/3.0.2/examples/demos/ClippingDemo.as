package demos
{	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	import sandy.core.World3D;
	import sandy.core.data.Vector;
	import sandy.core.scenegraph.Camera3D;
	import sandy.core.scenegraph.Group;
	import sandy.core.scenegraph.Shape3D;
	import sandy.materials.Appearance;
	import sandy.materials.BitmapMaterial;
	import sandy.materials.ColorMaterial;
	import sandy.materials.attributes.*;
	import sandy.primitive.Box;
	import sandy.primitive.Cylinder;
	import sandy.primitive.Plane3D;
	import sandy.primitive.PrimitiveMode;

   	public class ClippingDemo extends Sprite
	{
		internal static const SCREEN_WIDTH:int = 800;
		internal static const SCREEN_HEIGHT:int = 700;
		
		public const radius:uint = 800;
		public const innerRadius:uint = 700;
		
		private var box:Box;
		private var world : World3D;
		private var camera : Camera3D;
		private var keyPressed:Array;
		
		[Embed(source="../assets/textures/ouem_el-ma_lake.jpg")]
		private var Texture:Class;
		
		[Embed(source="../assets/textures/may.jpg")]
		private var Texture2:Class;
		
		public function ClippingDemo()
		{
			super();
		}
		
		public function init():void
		{
			// -- INIT
			keyPressed = [];
			// -- User interface
			stage.addEventListener(KeyboardEvent.KEY_DOWN, __onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, __onKeyUp);
		
			// --
			var l_mcWorld:MovieClip = new MovieClip();
			l_mcWorld.x = (stage.stageWidth - SCREEN_WIDTH) / 2;
			l_mcWorld.y = 0;//(stage.stageHeight - SCREEN_HEIGHT) / 2;
			addChild(l_mcWorld);
			world = World3D.getInstance(); 
			world.container = l_mcWorld;
			// --
			world.camera = new Camera3D( SCREEN_WIDTH, SCREEN_HEIGHT );
			world.camera.y = 80;
			world.camera.z = -innerRadius;
			// -- create scen
			var g:Group = new Group("root");

			var lPlane:Plane3D = new Plane3D( "myPlane", 1500, 1500, 2, 2, Plane3D.ZX_ALIGNED, PrimitiveMode.TRI );
			//lPlane.swapCulling();
			//lPlane.enableBackFaceCulling = false;
			lPlane.enableClipping = true;
			lPlane.appearance = new Appearance( new ColorMaterial( 0xd27e02, 1) );
			lPlane.enableForcedDepth = true;
			lPlane.forcedDepth = 5000000;
			
			var cylinder:Shape3D = new Cylinder( "myCylinder", radius, 600, 15, 8, radius, true, true);
			cylinder.swapCulling();
			cylinder.enableClipping = true;
			cylinder.useSingleContainer = false;
			cylinder.y = 200;
			
			box = new Box( "box", 150, 150, 150, "tri", 2 );
			box.y = 100;
			box.enableBackFaceCulling = false;
			box.enableClipping = true;

			
			var pic:Bitmap = new Texture();
			var pic2:Bitmap = new Texture2();
			
			var lAppearance:Appearance = new Appearance( new BitmapMaterial( pic2.bitmapData ) ,
											 			 new BitmapMaterial( pic.bitmapData ) );
			
			box.appearance = lAppearance;
			//(box.appearance.frontMaterial as ColorMaterial).lightingEnable = true;
			lPlane.appearance = new Appearance( new ColorMaterial() );
			
			cylinder.appearance = new Appearance( new BitmapMaterial( pic2.bitmapData, new MaterialAttributes( new LineAttributes() ) ) );
			
			// --			
			g.addChild( lPlane ); 
			g.addChild( cylinder );
			g.addChild( box );
			
			world.root = g;
			world.root.addChild( world.camera );
			// --
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
			
			return;
		}


		public function __onKeyDown(e:KeyboardEvent):void
		{
            keyPressed[e.keyCode]=true;
        }

        public function __onKeyUp(e:KeyboardEvent):void
        {
           keyPressed[e.keyCode]=false;
        }
  
		private function enterFrameHandler( event : Event ) : void
		{
			var cam:Camera3D = world.camera;
			var oldPos:Vector = cam.getPosition();
			// --
			if( keyPressed[Keyboard.RIGHT] ) 
			{   
			    cam.rotateY -= 5;
			}
			if( keyPressed[Keyboard.LEFT] )     
			{
			    cam.rotateY += 5;
			}		
			if( keyPressed[Keyboard.UP] )
			{ 
			    cam.moveForward( 15 );
			}
			if( keyPressed[Keyboard.DOWN] )
			{ 
			    cam.moveForward( -15 );
			}

			if( cam.getPosition().getNorm() > innerRadius )
				cam.setPosition( oldPos.x, oldPos.y, oldPos.z );
			
			box.rotateX += 1;
			world.render();
	
		}
	}
}

