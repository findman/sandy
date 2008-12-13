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


package sandy.parser;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import sandy.core.scenegraph.Group;
import sandy.parser.AParser;
import sandy.parser.IParser;
import sandy.parser.ParserEvent;

 /**
    * ParserStack utility class
    * <p>An utility class that acts as a parser stack. You can a set of parser objects, and it process to the laoding/parsing automatially and sequentially..</p>
    *
    * @author      Thomas Pfeiffer - kiroukou
    * @author Niel Drummond - haXe port  
    * 
    */
class ParserStack extends EventDispatcher
{
	public static var PROGRESS:String = "parserstack_progress";
	public static var ERROR:String = "parserstack_error";
	public static var COMPLETE:String = "parserstack_complete";
	
	private var m_oMap:Hash<IParser>;
	private var m_oNameMap:Dictionary;
	private var m_oGroupMap:Hash<Group>;
	private var m_oParser:AParser;
	private var m_nId:Int;
	private var m_aList:Array<IParser>;

	public function new()
	{
	 m_oMap = new Hash<IParser>();
	 m_oNameMap = new Dictionary(true);
	 m_oGroupMap = new Hash<Group>();
		m_nId = 0;
	 m_aList = new Array();
		progress = 0;

		super();
	}
	
	public function clear():Void
	{
		m_aList.splice(0,m_aList.length);
		for( elt in m_oMap.keys() )
		{
			m_oMap.remove( elt );
		}
	}
	
	/**
	 * Retrieve the parser you stored by the associated name.
	 * If no parser with that name is found, null is returned
	 */
	public function getParserByName( p_sName:String ):IParser
	{
		return m_oMap.get( p_sName );
	}
	
	/**
	 * Get the parser group object associated with the parser name.
	 * Returns null if no parser is associated with that name
	 */
	public function getGroupByName( p_sName:String ):Group
	{
		return m_oGroupMap.get( p_sName );
	}
	/**
	 * Add a parser to the list.
	 * @param p_sName the parser name to reference with
	 * @param p_oParser The parser instance
	 */
	public function add(  p_sName:String, p_oParser:IParser  ):Void
	{
		m_aList.push( p_oParser );
		m_oMap.set( p_sName, p_oParser );
		untyped { m_oNameMap[p_oParser] = p_sName; }
	}
	
	/**
	 * Launch the loading/parsing process
	 */
	public function start():Void
	{
		m_nId = 0;
		goNext();
	}
	
	private function goNext( pEvt:ParserEvent = null ):Void
	{
		if( m_aList.length == m_nId )
		{
			m_oGroupMap.set( untyped( m_oNameMap[ m_oParser ] ), pEvt.group ); 
			m_oParser.removeEventListener( ParserEvent.PROGRESS, onProgress );
			m_oParser.removeEventListener( ParserEvent.FAIL, onFail );
			m_oParser.removeEventListener( ParserEvent.INIT, goNext );//END
			
			onFinish( pEvt );
		}
		else
		{
			if( m_oParser != null )
			{
				m_oGroupMap.set( untyped( m_oNameMap[ m_oParser ] ), pEvt.group ); 
				m_oParser.removeEventListener( ParserEvent.PROGRESS, onProgress );
				m_oParser.removeEventListener( ParserEvent.FAIL, onFail );
				m_oParser.removeEventListener( ParserEvent.INIT, goNext );
			}
			untyped{ m_oParser = m_aList[ m_nId ]; }
			m_oParser.addEventListener( ParserEvent.PROGRESS, onProgress );
			m_oParser.addEventListener( ParserEvent.FAIL, onFail );
			m_oParser.addEventListener( ParserEvent.INIT, goNext );
			m_nId++;
			m_oParser.parse();
		}
	}

	private function onProgress( p_oEvent:ParserEvent ):Void
	{
		progress = (m_nId/(m_aList.length-1))*100 + p_oEvent.percent;
		dispatchEvent( new Event( PROGRESS ) );
	}
	
	private function onFail( p_oEvent:ParserEvent ):Void
	{
		dispatchEvent( new Event( ERROR ) );
	}
	
	private function onFinish( p_oEvent:ParserEvent ):Void
	{
		dispatchEvent( new Event( COMPLETE ) );
	}
	
	/**
	 * Public progress percent var.
	 * It gives the percentage of the loading/parsing status of the different parsers.
	 */
	public var progress:Float;
}

