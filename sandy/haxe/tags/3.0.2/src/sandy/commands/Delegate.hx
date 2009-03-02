package sandy.commands;

/**
 * From LowRa library
 * @author Francis Bourre
 * @author Niel Drummond - haXe port 
 * 
 */
import flash.events.Event;

class Delegate implements Command
{
	private var _f : Dynamic;
	private var _a : Array<Event>;
	
	public static function create( method : Dynamic, ?args : Array<Dynamic> ) : Array<Event> -> Dynamic 
	{

		return function( ?rest:Array<Event> ) : Dynamic
		{
			return method.apply( null, rest != null ? (args != null ? args.concat(rest):rest) : (args != null?args:null) );
		};
	} 
	
	public function new( f : Dynamic, ?rest : Array<Event> )
	{
		if (rest == null) rest = [];
		_f = f;
		_a = rest;
	}
	
	public function getArguments() : Array<Dynamic>
	{
		return _a;
	}

	public function setArguments( rest : Array<Event> ) : Void
	{
		if ( rest.length > 0 ) _a = rest;
	}
	
	public function setArgumentsArray( a : Array<Event> ) : Void
	{
		if ( a.length > 0 ) _a = a;
	}

	public function addArguments( rest : Array<Event> ) : Void
	{
		if ( rest.length > 0 ) _a = _a.concat( rest );
	}
	
	public function addArgumentsArray( a : Array<Event> ) : Void
	{
		if ( a.length > 0 ) _a = _a.concat( a );
	}

	public function execute( ?e : Event ) : Void
	{
		var a : Array<Event> = new Array();
		if ( e != null ) a.push( e );
		
		_f.apply( null, ( _a.length > 0 ) ? a.concat( _a ) : ((a.length > 0 ) ? a : null) );
	}

	
	public function handleEvent( e : Event ) : Void
	{
		this.execute( e );
	}
	
	public function callFunction() : Dynamic
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

