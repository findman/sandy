package sandytest.core
{
	import flexunit.framework.TestSuite;
	
	import sandytest.core.scenegraph.SceneGraphPackageTest;
	
	public class CorePackageTest
	{
  		public static function suite():TestSuite 
  		{
   			var ts:TestSuite = new TestSuite();
   		
   			// add your testsuites here	
   			ts.addTest( SceneGraphPackageTest.suite() );
   			return ts;
   		}
	}
}
