/*
# ***** BEGIN LICENSE BLOCK *****
Sandy is a software supplied by Thomas PFEIFFER
Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License");
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
import com.bourre.events.EventBroadcaster;
import com.bourre.events.EventType;
import com.bourre.events.IEvent;
import com.bourre.events.BasicEvent;

import sandy.core.scenegraph.Group;
import sandy.parser.AParser;
import sandy.parser.IParser;
import sandy.parser.ParserEvent;
	
 /**
  * ParserStack utility class
  * <p>An utility class that acts as a parser stack. You can a set of parser objects, and it process to the laoding/parsing automatially and sequentially..</p>
  *
  * @author      Thomas Pfeiffer - kiroukou
  * @author		 Floris van Veen - Floris
  * @since       3.0
  * @version     2.0
  * @date        23.07.2008
  */
class sandy.parser.ParserStack
{

	public static var PROGRESS:EventType = new EventType( 'parserstack_progress' );
	public static var ERROR:EventType = new EventType( 'parserstack_error' );
	public static var COMPLETE:EventType = new EventType( 'parserstack_complete' );
	
	private static var m_oMap:Array = new Array();
	private static var m_oNameMap:Array = new Array();
	private static var m_oGroupMap:Array = new Array();
	private var m_oParser:AParser;
	private var m_nId:Number = 0;
	private var m_aList:Array = new Array();
	
	
	/**
 	* Add a listener for a specific event.
 	* @param t EventType The type of event we want to register
 	* @param o The object listener
 	*/
	public function addEventListener( t:EventType, o ):Void 
	{
			_oEB.addEventListener.apply( _oEB, arguments );
	}		
				
	/**
	 * Broadcast event to suscribed listeners.
	 * @example<code>e.broadcastEvent( new BasicEvent(MyClass.onSomethingEVENT) );</code>
	 * @param e IEvent. Event object must implement IEvent interface.
	 */
	private static function broadcastEvent( e:IEvent ):Void 
	{
		_oEB.broadcastEvent.apply( _oEB, arguments );
	}
	
	/**
	 * Remove a listener for a specific event.
	 * @param e String The type of event we want to register
	 * @param oL The object listener
	 */
	public static function removeEventListener( e:EventType, oL ):Void 
	{
		_oEB.removeEventListener( e, oL );
	}
	
	private static var _oEB:EventBroadcaster = new EventBroadcaster( ParserStack );
	
	
	
	public function ParserStack( e:EventType, oT, np:Number, ps:String  )	
	{
		super( this );
	}
	
	public function clear():Void
	{
		m_aList.splice(0);
		m_oMap.splice(0);
		m_oNameMap.splice(0);
		m_oGroupMap.splice(0);
	}
	
	/**
	 * Retrieve the parser you stored by the associated name.
	 * If no parser with that name is found, null is returned
	 */
	public static function getParserByName( p_sName:String ):IParser
	{
		return m_oMap[ p_sName ];
	}
	
	/**
	 * Get the parser group object associated with the parser name.
	 * Returns null if no parser is associated with that name
	 */
	public static function getGroupByName( p_sName:String ):Group
	{
		return m_oGroupMap[ p_sName ];
	}
	/**
	 * Add a parser to the list.
	 * @param p_sName the parser name to reference with
	 * @param p_oParser The parser instance
	 */
	public function add(  p_sName:String, p_oParser:IParser  ):Void
	{
		m_aList.push( p_oParser );
		m_oMap[ p_sName ] = p_oParser;
		m_oNameMap[p_oParser] = p_sName;
	}
	
	/**
	 * Launch the loading/parsing process
	 */
	public function start():Void
	{
		m_nId = 0;
		goNext();
	}
	
	private function goNext( pEvt:ParserEvent ):Void
	{
		if( pEvt == undefined ) pEvt = null;
		if( m_aList.length == m_nId )
		{
				m_oGroupMap[ m_oNameMap[ m_oParser ] ] = pEvt.group;
				// fout: m_oParser = undefined, 
			//m_oGroupMap[  ] = pEvt.group;
			AParser._oEB.removeEventListener( ParserEvent.PROGRESS );
			AParser._oEB.removeEventListener( ParserEvent.INIT );
			AParser._oEB.removeEventListener( ParserEvent.FAIL );
			ParserStack.broadcastEvent( new ParserEvent( ParserStack.COMPLETE ) );
		}
		else
		{
			if( m_oParser )
			{
				m_oGroupMap[ m_oNameMap[ m_oParser ] ] = pEvt.group;
				AParser._oEB.removeEventListener( ParserEvent.PROGRESS );
				AParser._oEB.removeEventListener( ParserEvent.INIT );
				AParser._oEB.removeEventListener( ParserEvent.FAIL );
			}
			
			var m_oParser:IParser = m_aList[ m_nId ];
			m_oParser.addEventListener( ParserEvent.PROGRESS, onProgress );
			m_oParser.addEventListener( ParserEvent.FAIL, onFail );
			m_oParser.addEventListener( ParserEvent.INIT, goNext );
			m_oParser.parse();
			m_nId++;
		}
	}

	private function onProgress( p_oEvent:ParserEvent ):Void
	{
		var event:ParserEvent = new ParserEvent( ParserEvent.PROGRESS );
		event.percent = ( m_nId / ( m_aList.length - 1 ) ) * 100 + p_oEvent.percent;
		ParserStack.broadcastEvent( event );
	}
	
	private function onFail( p_oEvent:ParserEvent ):Void
	{
		ParserStack.broadcastEvent( new ParserEvent( ParserStack.ERROR ) );
	}
	

	
	/**
	 * Public progress percent var.
	 * It gives the percentage of the loading/parsing status of the different parsers.
	 */
	public var percent:Number = 0;
}
