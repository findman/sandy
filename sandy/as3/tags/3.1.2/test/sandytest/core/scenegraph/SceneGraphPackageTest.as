package sandytest.core.scenegraph 
{
	import flexunit.framework.TestSuite;
	
 	public class SceneGraphPackageTest
 	{
  		public static function suite():TestSuite 
  		{
   			var ts:TestSuite = new TestSuite();
   		
   			// add your testsuites here	
   			ts.addTest( NodeTest.suite() );
   			return ts;
   		}
  	}
}
