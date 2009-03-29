package sandytest.core.scenegraph 
{
 	import flexunit.framework.TestSuite;
 	
 	import sandy.core.scenegraph.ATransformable;
 	import sandy.core.scenegraph.INodeOperation;
 	import sandy.core.scenegraph.Node;
 	
 	import sandytest.SandyTestCase;
 	
 	// testcase implements INodeOperation so that we can test Node.perform() method easily
 	public class NodeTest extends SandyTestCase implements INodeOperation 
 	{
  	    public function NodeTest( methodName:String ) 
  	    {
   			super( methodName );
        }
  	
  		public static function suite():TestSuite 
  		{
   			var ts:TestSuite = new TestSuite();
   		
   			// add your testcases here	
   			ts.addTest( new NodeTest( "testPerform" ) );
   			return ts;
   		}
   		
	 	// member variables for testing Node.perform() method
   		private var onEntry:String;
   		private var onExit:String;
   		
   		public function testPerform():void 
   		{
   			var a:Node = new Node("a");
   			var b:Node = new Node("b");
   			var c:Node = new Node("c");
   			var d:Node = new Node("d");
   			a.addChild(b);
   			b.addChild(c);
   			b.addChild(d);
   			
   			onEntry = onExit = "";
   			a.perform(this);
   			assertEquals("onEntry", "abcd", onEntry);
   			assertEquals("onExit", "cdba", onExit);
   		}
   		
	 	// implements INodeOperation.performOnEntry() so that we can test Node.perform() method easily
		public function performOnEntry(node:Node):void 
		{
			onEntry += node.name;	
		}
		
	 	// implements INodeOperation.performOnExit() so that we can test Node.perform() method easily
		public function performOnExit(node:Node):void
		{
			onExit += node.name;			
		}   		
  	}
}
