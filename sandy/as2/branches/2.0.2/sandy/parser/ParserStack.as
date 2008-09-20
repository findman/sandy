/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author or authors.
Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 ( the "License" );
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
	http://www.mozilla.org/MPL/MPL-1.1.html
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# ***** END LICENSE BLOCK *****
*/

import com.bourre.data.collections.Map;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.EventType;
	
import sandy.core.scenegraph.Group;
import sandy.parser.AParser;
import sandy.parser.IParser;
import sandy.parser.ParserEvent;
	
/**
 * Dispatched when data is received as the parsing progresses.
 *
 * @eventType sandy.parser.ParserStack.PROGRESS
 */
 [ Event( name = "parserstack_progress", type = "sandy.parser.ParserStack" ) ]
	
/**
 * Dispatched when an error occurs in the parsing process.
 *
 * @eventType sandy.parser.ParserStack.ERROR
 */
[ Event( name = "parserstack_error", type = "sandy.parser.ParserStack" ) ]
	
/**
 * Dispatched when the parsing process is complete.
 *
 * @eventType sandy.parser.ParserStack.COMPLETE
 */
[ Event( name = "parserstack_complete", type = "sandy.parser.ParserStack" ) ]
	
/**
 * ParserStack utility class.
 * <p>An utility class that acts as a parser stack. You can a set of parser objects, and it process to the loading/parsing automatially and sequentially.</p>
 *
 * @author      Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - xdevltd
 * @since       3.0
 * @version     2.0.2
 * @date        12.02.2008
 */
	
class sandy.parser.ParserStack extends EventBroadcaster
{

	/**
	 * Defines the value of the <code>type</code> property of a <code>parserstack_progress</code> event object.
     *
     * @eventType parserstack_progress
	 */
	public static var PROGRESS:EventType = new EventType( "parserstack_progress" );
		
	/**
	 * Defines the value of the <code>type</code> property of a <code>parserstack_error</code> event object.
     *
     * @eventType parserstack_error
	 */
	public static var ERROR:EventType = new EventType( "parserstack_error" );
		
	/**
	 * Defines the value of the <code>type</code> property of a <code>parserstack_complete</code> event object.
     *
     * @eventType parserstack_complete
	 */
	public static var COMPLETE:EventType = new EventType( "parserstack_complete" );
		
	private var m_oMap:Map;
	private var m_oNameMap:Map;
	private var m_oGroupMap:Map;
	private var m_oParser:AParser;
	private var m_nId:Number = 0;
	private var m_aList:Array = new Array();
	
	/**
	 * Constructor.
	 */
	public function ParserStack()
	{
		super();
		m_oMap 		= new Map();
		m_oNameMap  = new Map();
		m_oGroupMap = new Map();
	}
		
	/**
	 * Clears the stack.
	 */
	public function clear() : Void
	{
		m_aList.splice( 0 );
		/*for( var elt in m_oMap )
		{
			m_oMap.get( elt ) = null;
		}*/
	}
		
	/**
	 * Retrieve the parser you stored by the associated name.
	 * If no parser with that name is found, null is returned
	 */
	public function getParserByName( p_sName:String ) : IParser
	{
		return m_oMap.get( p_sName );
	}
	
	/**
	 * Get the parser group object associated with the parser name.
	 * Returns null if no parser is associated with that name
	 */
	public function getGroupByName( p_sName:String ) : Group
	{
		return m_oGroupMap.get( p_sName );
	}

	/**
	 * Add a parser to the list.
	 * @param p_sName the parser name to reference with
	 * @param p_oParser The parser instance
	 */
	public function add(  p_sName:String, p_oParser:IParser  ) : Void
	{
		m_aList.push( p_oParser );
		m_oMap.put( p_sName, p_oParser );
		m_oNameMap.put( p_oParser, p_sName );
	}
		
	/**
	 * Launch the loading/parsing process.
	 */
	public function start() : Void
	{
		m_nId = 0;
		goNext();
	}
		
	private function goNext( pEvt:ParserEvent ) : Void
	{
		if( m_aList.length == m_nId )
		{
			m_oGroupMap.put( m_oNameMap.get( m_oParser ), pEvt.group );
			m_oParser.removeEventListener( ParserEvent.FAIL, onFail );
			m_oParser.removeEventListener( ParserEvent.INIT, goNext );//END

			broadcastEvent( new BasicEvent( ParserStack.COMPLETE, this ) );
		}
		else
		{
			if( m_oParser )
			{
				m_oGroupMap.put( m_oNameMap.get( m_oParser ), pEvt.group );
				m_oParser.removeEventListener( ParserEvent.FAIL, onFail );
				m_oParser.removeEventListener( ParserEvent.INIT, goNext );
			}
			m_oParser = m_aList[ m_nId ];
			m_oParser.addEventListener( ParserEvent.FAIL, onFail );
			m_oParser.addEventListener( ParserEvent.INIT, goNext );
			m_oParser.parse();
			m_nId++;
		}
	}
	
	private function onFail( p_oEvent:ParserEvent ) : Void
	{
		dispatchEvent( new BasicEvent( ERROR ) );
	}
		
	private function onFinish( p_oEvent:ParserEvent ) : Void
	{
		dispatchEvent( new BasicEvent( COMPLETE ) );
	}
			
}