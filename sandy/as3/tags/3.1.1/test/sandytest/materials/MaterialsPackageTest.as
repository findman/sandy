package sandytest.materials
{
	import flexunit.framework.TestSuite;
	
	public class MaterialsPackageTest
	{
  		public static function suite():TestSuite 
  		{
   			var ts:TestSuite = new TestSuite();
   		
   			// add your testsuites here	
   			ts.addTest( IAlphaMaterialTest.suite() );
   			return ts;
   		}
	}
}