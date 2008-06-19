package demos
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	import sandy.core.Scene3D;
	import sandy.core.scenegraph.Camera3D;
	import sandy.core.scenegraph.Group;
	import sandy.core.scenegraph.Shape3D;
	import sandy.materials.Appearance;
	import sandy.materials.BitmapMaterial;
	import sandy.parser.IParser;
	import sandy.parser.Parser;
	import sandy.parser.ParserEvent;
	
	public final class ComparisonDemo extends Sprite
	{
		[Embed(source="assets/textures/texrin2.jpg")]
		private var Texture:Class;
		
		[Embed( source="assets/models/Rhino.ASE", mimeType="application/octet-stream" )]
		private var Rhino:Class;
		
		private var kitty:Shape3D;
		private var frame:int = 0;
		private var t:int = 0;
		private var m_oScene:Scene3D;
		private var aObjects:Array = new Array();
		
		private var debug:TextField = new TextField();
		
		public function ComparisonDemo()
		{
			super();
		}
		
		public function init():void
		{
			debug.y = 450;
			debug.width = 630;
			debug.height = 25;
			debug.border = true;
			addChild( debug );
			// --
			var lCamera:Camera3D = new Camera3D( 640, 480 );
			lCamera.z = -1500;
			m_oScene = new Scene3D( "mainScene", this, lCamera );	
			// --
			load();
		}
		
		private function _enableEvents():void
		{
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
		}
	

	  	private function _createAppearance():Appearance
	  	{
	  		var l_oBitmap:Bitmap = new Texture();
	  		var l_oMat:BitmapMaterial = new BitmapMaterial( l_oBitmap.bitmapData );
	  		return new Appearance( l_oMat );
	  	}
	  	
	  	private function load():void
	  	{
	  		var l_oParser:IParser = Parser.create( new Rhino(), Parser.ASE, 0.1 );
	  		l_oParser.standardAppearance = _createAppearance();
	  		l_oParser.addEventListener( ParserEvent.INIT, _createScene3D );
	  		l_oParser.parse();
	  	}
	  	
  		private function _createScene3D( p_oEvt:ParserEvent ):void
		{
			m_oScene.root = p_oEvt.group;
		
			var root:Group = p_oEvt.group;
			
			kitty = root.children[0];
			//kitty.useSingleContainer = false;
			//kitty.enableClipping = true;
			
			var kitty2:Shape3D = kitty.clone("kitty2");
			kitty2.x = 400;
			//kitty2.useSingleContainer = false;
			//kitty2.enableClipping = true;
			root.addChild( kitty2 );
			
			var kitty3:Shape3D = kitty.clone("kitty3");
			kitty3.x = -400;
			//kitty3.enableClipping = true;
			//kitty3.useSingleContainer = false;
			root.addChild( kitty3 );
			
			var kitty4:Shape3D = kitty.clone("kitty4");
			kitty4.y = 200;
			//kitty4.enableClipping = true;
			//kitty4.useSingleContainer = false;
			root.addChild( kitty4 );
			
			var kitty5:Shape3D = kitty.clone("kitty5");
			kitty5.y = -200;
			//kitty5.enableClipping = true;
			//kitty5.useSingleContainer = false;
			root.addChild( kitty5 );
			
			//root.useSingleContainer = false;
			
			aObjects.push( kitty, kitty2, kitty3, kitty4, kitty5 );
		
			m_oScene.root.addChild( m_oScene.camera );
			
			t = getTimer();
			_enableEvents();
		}	
		
		private function enterFrameHandler( event : Event ) : void
		{
			frame++;
			// --
			for each( var kitty:Shape3D in aObjects )
				kitty.rotateY ++;
			// --
			m_oScene.render();
			
			if( frame == 1000 )
			{
				var elapsed:int = (getTimer() - t);
				debug.text = "Rendering time for 1000 frames = "+(elapsed)+" ms";
				removeEventListener( Event.ENTER_FRAME, enterFrameHandler );
			}
		}
		
	}
}