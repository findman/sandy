package 
{

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import jiglib.physics.RigidBody;
	import jiglib.plugin.sandy3d.Sandy3DPhysics;
	
	import sandy.core.Scene3D;
	import sandy.core.scenegraph.Camera3D;
	import sandy.core.scenegraph.Group;
	import sandy.materials.Appearance;
	import sandy.materials.WireFrameMaterial;		

	/**
	 * @author 
	 */
	[SWF(width='500', height='500', backgroundColor='0xCCCCCC', frameRate='25')]
	
	public class FallingBalls extends Sprite 
	{
		
		private var scene:Scene3D
		private var physics:Sandy3DPhysics;

		public function FallingBalls() 
		{
			stage.quality = StageQuality.LOW;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.showDefaultContextMenu = false;
			stage.stageFocusRect = false;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		public function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// --
			scene = new Scene3D("fallingBallsScene", this, new Camera3D( this.stage.stageWidth, this.stage.stageHeight ), new Group("root") );
			
			physics = new Sandy3DPhysics( scene, 1);

			for (var i:int = 0; i < 40; i++) 
			{
				var sphere:RigidBody = physics.createSphere("sphere_"+i, null, 30, 6, 6);
				sphere.x = 100 - Math.random() * 200;
				sphere.y = 700 + Math.random() * 3000;
				sphere.z = 200 - Math.random() * 100;
				// sphere.rotationX, Y & Z coming soon!
				sphere.material.restitution = 2; 
				
				// This is how to access the engine specific mesh/do3d
				physics.getMesh(sphere).appearance.frontMaterial = new WireFrameMaterial(2, 0xCCFF00);
			}
			
			var appearance:Appearance = new Appearance( new WireFrameMaterial() );
			var north:RigidBody = physics.createCube("north", appearance, 1800, 500, 1800);
			north.z = 850;
			north.y = 700;
			north.movable = false;
			
			var south:RigidBody = physics.createCube("south", appearance, 1800, 500, 1800);
			south.z = -850;
			south.y = 700;
			south.movable = false;
			
			var west:RigidBody = physics.createCube("west", appearance, 500, 1800, 1800);
			west.x = -850;
			west.y = 700;
			west.movable = false;
			
			var east:RigidBody = physics.createCube( "east", appearance, 500, 1800, 1800 );
			east.x = 850;
			east.y = 700;
			east.movable = false;

			var ground:RigidBody = physics.createGround("ground", appearance, 1800, -200);
			
			scene.camera.z = 3000;
			scene.camera.lookAt(0,0,0);

			addEventListener(Event.ENTER_FRAME, render);
			//render();
		}

		private function render(event:Event=null):void 
		{
			physics.step();
			scene.render();
		}
	}
}
