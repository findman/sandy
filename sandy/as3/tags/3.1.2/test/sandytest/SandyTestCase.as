package sandytest
{
	import flexunit.framework.TestCase;

	public class SandyTestCase extends TestCase
	{
		public function SandyTestCase(methodName:String=null)
		{
			super(methodName);
		}
	
		protected function setObject(object:Object, value:Object):void 
		{
			for (var property:String in value) 
			{
				object[property] = value[property];
			}	
		}

		protected function assertObjectEquals(message:String, expected:Object, object:Object):void 
		{
			for (var property:String in expected) 
			{
				assertEquals(message + ", property " + property, expected[property], object[property]);
			}	
		}
		
		protected function assertObjectApproximates(message:String, expected:Object, object:Object):void 
		{
			for (var property:String in expected) 
			{
				assertApproximates(message + ", property " + property, expected[property], object[property]);
			}
		}		
		
		protected function assertApproximates(message:String, expected:Number, value:Number):void 
		{
			const epsilon:Number = 0.0001;
			var diff:Number = Math.abs(value - expected);
			var condition:Boolean = (diff < epsilon);
			assertTrue(message+ " expected " + expected + " but was "+value, condition);
		}
	}
}