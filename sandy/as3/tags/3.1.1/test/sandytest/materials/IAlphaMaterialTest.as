package sandytest.materials 
{
 	import flash.display.BitmapData;
 	import flash.display.Sprite;
 	import flash.media.Video;
 	
 	import flexunit.framework.TestSuite;
 	
 	import sandy.materials.BitmapMaterial;
 	import sandy.materials.ColorMaterial;
 	import sandy.materials.IAlphaMaterial;
 	import sandy.materials.MovieMaterial;
 	import sandy.materials.VideoMaterial;
 	
 	import sandytest.SandyTestCase;
 	
 	public class IAlphaMaterialTest extends SandyTestCase 
 	{
  	    public function IAlphaMaterialTest( methodName:String ) 
  	    {
   			super( methodName );
        }
  	
  		public static function suite():TestSuite 
  		{
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new IAlphaMaterialTest( "testSetAlpha" ) );
   			return ts;
   		}
   		
   		public function testSetAlpha():void 
   		{
			var alphaMaterial:IAlphaMaterial = null;
			
			alphaMaterial = new ColorMaterial;
			alphaMaterial.alpha = 0.1;
			assertEquals("alpha of colorMaterial", 0.1, alphaMaterial.alpha);
			
			alphaMaterial = new MovieMaterial(new Sprite, 40, null, false, 32, 32);
			alphaMaterial.alpha = 0.2;
			assertEquals("alpha of movieMaterial", 0.2, alphaMaterial.alpha);			
			
			alphaMaterial = new VideoMaterial(new Video);
			alphaMaterial.alpha = 0.3;
			assertEquals("alpha of videoMaterial", 0.3, alphaMaterial.alpha);			
			
			alphaMaterial = new BitmapMaterial(new BitmapData(32, 32));
			alphaMaterial.alpha = 0.4;
			assertEquals("alpha of bitmapMaterial", 0.4, alphaMaterial.alpha);			
   		}
  	}
}
