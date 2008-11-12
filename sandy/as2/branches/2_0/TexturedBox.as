import sandy.core.World3D;
import sandy.core.scenegraph.Camera3D;
import sandy.core.scenegraph.Group;
import sandy.materials.Appearance;
import sandy.materials.BitmapMaterial;
import sandy.primitive.Box;
import sandy.util.BitmapUtil;

class TexturedBox
{
	
	public function TexturedBox( mc:MovieClip )
	{
		var loader:MovieClip = mc.createEmptyMovieClip( 'texture', mc.getNextHighestDepth() );

		loadMovie( 'http://www.flashsandy.org/_media/new.png', loader );

		mc.onEnterFrame = function()
		{
			if( loader.getBytesTotal() == loader.getBytesLoaded() && loader._width > 0 )
			{
				trace( 'Texture file is loaded.' ); 
				delete this.onEnterFrame;
			
				// -- create box with texture (BitmapMaterial) you've just loaded.
				var box:Box = new Box( "myBox" );
				box.appearance = new Appearance( new BitmapMaterial( BitmapUtil.movieToBitmap( loader, true ) ) );
				loader._visible = false;
				// -- creation of the world.
				var world = World3D.getInstance();
				// -- set container
				world.container = mc;
				// -- create root
				world.root = new Group( 'root' );
				// -- add an object (box) to the scene.
				world.root.addChild( box );
				// -- create and add camera
				world.camera = new Camera3D( 550, 400 );
				world.camera.z = -300;
				world.root.addChild( world.camera );
				//trace( world.root.getChildList() );
				// -- render the world.
				world.render();
			}
		}
	}
	
}
