package demos
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import sandy.core.Scene3D;
	import sandy.core.data.Vector;
	import sandy.core.scenegraph.ATransformable;
	import sandy.core.scenegraph.Camera3D;
	import sandy.core.scenegraph.Group;
	import sandy.core.scenegraph.Shape3D;
	import sandy.materials.Appearance;
	import sandy.materials.BitmapMaterial;
	import sandy.materials.ColorMaterial;
	import sandy.materials.attributes.MaterialAttributes;
	import sandy.materials.attributes.OutlineAttributes;
	import sandy.parser.IParser;
	import sandy.parser.Parser;
	import sandy.parser.ParserEvent;
	import sandy.primitive.Sphere;
	
	public final class LightDemo extends Sprite
	{
		[Embed(source="../assets/texrin2.jpg")]
		private var Texture:Class;
		
		public function LightDemo()
		{
			super();
		}
		
		private var m_oSphere:Sphere;
		private var m_oScene:Scene3D;
		private var keyPressed:Array = new Array();
		
		public function init():void
		{
			var lCamera:Camera3D = new Camera3D( 640, 480 );
			lCamera.z = -400;
			lCamera.y = 40;
			m_oScene = new Scene3D( "mainScene", this, lCamera );	
			// --
			load();
		}
		
		private function _enableEvents():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, __onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, __onKeyUp);
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
		}
	
	
		public function __onKeyDown(e:KeyboardEvent):void
		{
            keyPressed[e.keyCode]=true;
        }

        public function __onKeyUp(e:KeyboardEvent):void
        {
           keyPressed[e.keyCode]=false;
        }
  
  		private function _createMaterialAttributes():MaterialAttributes
  		{
  			return new MaterialAttributes( /*new GouraudAttributes(true, 0.3), */new OutlineAttributes(3, 0xFF, 1 ) );
  		}
  		
	  	private function _createAppearance():Appearance
	  	{
	  		var l_oBitmap:Bitmap = new Texture();
	  		var l_oMat:BitmapMaterial = new BitmapMaterial( l_oBitmap.bitmapData, _createMaterialAttributes() );
	  		l_oMat.lightingEnable = true;
	  		return new Appearance( l_oMat );
	  	}
	  	
	  	private function load():void
	  	{
	  		var l_oParser:IParser = Parser.create( "../assets/Rhino.ASE", null, 0.03 );
	  		l_oParser.standardAppearance = _createAppearance();
	  		l_oParser.addEventListener( ParserEvent.INIT, _createScene3D );
	  		l_oParser.parse();
	  	}
	  	
  		private function _createScene3D( p_oEvt:ParserEvent ):void
		{
			//m_oScene.root = p_oEvt.group;
			m_oScene.root = new Group();
			m_oSphere = new Sphere("mySphere", 30 );
			m_oSphere.x = 200;
			m_oSphere.geometryCenter = new Vector( 50, 0, 0 );
			var l_oSphereMaterial:ColorMaterial = new ColorMaterial( 0xFF0000, 1, _createMaterialAttributes() );
			l_oSphereMaterial.lightingEnable = true;
			m_oSphere.appearance = new Appearance( l_oSphereMaterial  );
			m_oScene.root.addChild( m_oSphere );
			
			m_oScene.root.addChild( m_oScene.camera );
			
			_enableEvents();
		}	
		
		private function enterFrameHandler( event : Event ) : void
		{
			var cam:Camera3D = m_oScene.camera;
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
			    cam.moveVertically( 10 );
			}
			if( keyPressed[Keyboard.DOWN] )
			{ 
			    cam.moveVertically( -10 );
			}
			// --
			for each( var l_oObject:ATransformable in m_oScene.root.children )
			{
				if( l_oObject is Shape3D )
				{
					l_oObject.rotateY ++;
				}
			}
			// --
			m_oScene.render();
		}
		
	}
}