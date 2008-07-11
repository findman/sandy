package sandy.commands
{

	/**
	 * From LowRa library
	 * @author Francis Bourre
	 * @author Bruce Epstein - modified create() for backward compatibility, and renamed existing version to createAppend()
	 * @version 1.0.1
	 */
	import flash.events.Event;
	
	public class Delegate 
		implements Command
	{
		private var _f : Function;
		private var _a : Array;
		
		public static function createAppend( method : Function, ... args ) : Function 
		{
			return function( ... rest ) : *
			{
				return method.apply( null, rest.length>0? (args.length>0?args.concat(rest):rest) : (args.length>0?args:null) );
			};
		} 
		
		// Put the extra args at the beginning of the arguments list, as did com.bourre.commands.Delegate.create(), instead of at the end.
		public static function create( method : Function, ... args ) : Function 
		{
			return function( ... rest ) : *
			{
				return method.apply( null, rest.length>0? (args.length>0?rest.concat(args):rest) : (args.length>0?args:null) );
			};
		} 
		
		public function Delegate( f : Function, ... rest )
		{
			_f = f;
			_a = rest;
		}
		
		public function getArguments() : Array
		{
			return _a;
		}

		public function setArguments( ... rest ) : void
		{
			if ( rest.length > 0 ) _a = rest;
		}
		
		public function setArgumentsArray( a : Array ) : void
		{
			if ( a.length > 0 ) _a = a;
		}

		public function addArguments( ... rest ) : void
		{
			if ( rest.length > 0 ) _a = _a.concat( rest );
		}
		
		public function addArgumentsArray( a : Array ) : void
		{
			if ( a.length > 0 ) _a = _a.concat( a );
		}

		public function execute( e : Event = null ) : void
		{
			var a : Array = new Array();
			if ( e != null ) a.push( e );
			
			_f.apply( null, ( _a.length > 0 ) ? a.concat( _a ) : ((a.length > 0 ) ? a : null) );
		}
	
		
		public function handleEvent( e : Event ) : void
		{
			this.execute( e );
		}
		
		public function callFunction() : *
		{
			return _f.apply( null, _a );
		}
		
		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance
		 */
		public function toString() : String 
		{
			return "sandy.commands.Delegate";
		}
	}
}
