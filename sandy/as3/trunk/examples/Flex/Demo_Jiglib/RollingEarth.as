package
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import jiglib.geometry.JSphere;
	import jiglib.math.JNumber3D;
	import jiglib.physics.RigidBody;
	import jiglib.plugin.sandy3d.Sandy3DMesh;
	import jiglib.plugin.sandy3d.Sandy3DPhysics;
	
	import sandy.core.data.Point3D;
	import sandy.core.scenegraph.*;
	import sandy.materials.Appearance;
	import sandy.materials.ColorMaterial;
	import sandy.materials.WireFrameMaterial;
	import sandy.primitive.Box;
	import sandy.primitive.Sphere;
	import sandy.view.BasicView;
	
	/**
	 * Simple Papervision3D + JigLibFlash example 
	 * @author Reynaldo a.k.a. reyco1
	 * 
	 */	
	[SWF(width="900", height="700", backgroundColor="#000000", frameRate="20")]
	
	public class RollingEarth extends BasicView
	{
		[Embed(source="assets/earthTexture512x256.jpg")]
		public var EarthTexture:Class;
		
		private var physics:Sandy3DPhysics;
		private var sphereObject:Sphere;
		private var physicsObject:RigidBody;		
		private var keyRight:Boolean = false;
		private var keyLeft:Boolean = false;
		private var keyForward:Boolean = false;
		private var keyReverse:Boolean = false;
		private var keyUp:Boolean = false;		
		private var moveForce:Number = 10;		
		
		public function RollingEarth()
		{
			
			// Initialize the Papervision3D BasicView
			super();
			init( stage.stageWidth, stage.stageHeight );
			useRenderingCache = false;
			
			// Initialize the Papervision3D physics plugin
			physics = new Sandy3DPhysics(scene, 1);
						
			addKeyboardListeners();
			
			setCamera();
			createFloor();
			createSphere();	
			createBoxes();		
			render();
		}
		
		private function addKeyboardListeners():void
		{
			stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownHandler );
			stage.addEventListener( KeyboardEvent.KEY_UP, keyUpHandler );
		}
		
		
		private function setCamera():void
		{
			var l_oCam:SpringCamera3D = new SpringCamera3D(stage.stageWidth, stage.stageHeight, 45, 1, 10000);
			l_oCam.mass = 10;
			l_oCam.damping = 10;
			l_oCam.stiffness = 1;
				
			l_oCam.lookOffset = new Point3D( 0, 20, 30 );
			l_oCam.positionOffset = new Point3D( 0, 100, -1500 );
			
			camera.remove();
			scene.camera = l_oCam;
			camera = l_oCam;
			scene.root.addChild( camera );
		}
		
		
		private var cameraTarget:Shape3D;
		private function createSphere():void
		{
			var earthMaterial:Appearance = makeBitmapAppearance( Bitmap( new EarthTexture() ).bitmapData );
			//earthMaterial.frotiled = true;
			//earthMaterial.frontMaterial.smooth = true;
			
			sphereObject = new Sphere('sphere', 100, 13, 11);
			sphereObject.appearance = earthMaterial;
			scene.root.addChild(sphereObject);
			
			physicsObject = new JSphere(new Sandy3DMesh(sphereObject), 100);
			physicsObject.y = 200;
			physicsObject.restitution = 3;
			physicsObject.mass = 1
			physics.addBody(physicsObject);
			
			cameraTarget = new Box("target", 1, 1, 1, "tri", 1);
			cameraTarget.x = sphereObject.x;
			cameraTarget.y = sphereObject.y;
			cameraTarget.z = sphereObject.z;
			scene.root.addChild(cameraTarget);
			
			SpringCamera3D(camera).target = cameraTarget;
		}
		
		private function createBoxes():void
		{
			var randomBox:RigidBody;
			var material:Appearance = new Appearance(new ColorMaterial( 0x77ee77 ));

			for(var a:Number = 0; a<10; a++)
			{
				randomBox = physics.createCube("cube_"+a, material, 100, 100, 100);
				randomBox.z = 1000;
				randomBox.y = a*100 + 55;
				randomBox.mass = .2;
			}
		}
		
		private function createFloor():void
		{
			physics.createGround( "floor", new Appearance(new WireFrameMaterial(2, 0xFFFFFF, 0)), 1800, 0);
		}
		
		private function keyDownHandler(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.UP:
					keyForward = true;
					keyReverse = false;
					break;
	
				case Keyboard.DOWN:
					keyReverse = true;
					keyForward = false;
					break;
	
				case Keyboard.LEFT:
					keyLeft = true;
					keyRight = false;
					break;
	
				case Keyboard.RIGHT:
					keyRight = true;
					keyLeft = false;
					break;
				case Keyboard.SPACE:
				    keyUp = true;
					break;
			}
		}
		
		private function keyUpHandler(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.UP:
					keyForward = false;
					break;
	
				case Keyboard.DOWN:
					keyReverse = false;
					break;
	
				case Keyboard.LEFT:
					keyLeft = false;
					break;
	
				case Keyboard.RIGHT:
					keyRight = false;
					break;
				case Keyboard.SPACE:
				    keyUp=false;
			}
		}
		
		override public function simpleRender(event:Event = null):void
		{
			if(keyLeft)
			{
				physicsObject.addWorldForce(new JNumber3D(-moveForce, 0, 0), physicsObject.currentState.position);
			}
			if(keyRight)
			{
				physicsObject.addWorldForce(new JNumber3D(moveForce, 0, 0), physicsObject.currentState.position);
			}
			if(keyForward)
			{
				physicsObject.addWorldForce(new JNumber3D(0, 0, moveForce), physicsObject.currentState.position);
			}
			if(keyReverse)
			{
				physicsObject.addWorldForce(new JNumber3D(0, 0, -moveForce), physicsObject.currentState.position);
			}
			if(keyUp)
			{
				physicsObject.addWorldForce(new JNumber3D(0, moveForce, 0), physicsObject.currentState.position);
			}
			
			cameraTarget.x = sphereObject.x;
			cameraTarget.y = sphereObject.y;
			cameraTarget.z = sphereObject.z;
			physics.step();
			super.simpleRender(event);
		}
		
	}
}