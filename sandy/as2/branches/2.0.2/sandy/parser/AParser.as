/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author or authors.
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
import com.bourre.commands.Delegate;

import sandy.core.scenegraph.Group;
import sandy.parser.IParser;
import sandy.parser.ParserEvent;
import sandy.materials.Appearance;
import sandy.materials.ColorMaterial;
import sandy.materials.attributes.*;

/**
 * ABSTRACT CLASS - super class for all parser objects.
 *
 * <p>This class should not be directly instatiated, but sub classed.<br/>
 * The AParser class is responsible for creating the root Group, loading files
 * and handling the corresponding events.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - FFlasher
 * @since		1.0
 * @version		2.0.2
 * @date 		26.07.2007
 */
 
class sandy.parser.AParser extends EventBroadcaster implements IParser
{
	
	//protected static var m_eProgress:ParserEvent = new ParserEvent( ParserEvent.PROGRESS );
	/**
	 * @private
	 */
	//private var m_oLoader:LoadVars = new LoadVars();
		
	/**
	 * @private
	 */
	private var m_oGroup:Group;
		
	/**
	 * @private
	 */
	private var m_oFile:XML;
						
	/**
	 * @private
	 */
	private var m_nScale:Number;
		
	/**
	 * @private
	 */
	private var m_oStandardAppearance:Appearance;

	private var m_sUrl:String;

	/**
	 * Creates a parser object. Creates a root Group, default appearance
	 * and sets up an URLLoader.
	 *
	 * @param p_sFile		Must be either a text string containing the location
	 * 						to a file or an embedded object.
	 * @param p_nScale		The scale amount.
	 */
	public function AParser( p_sFile, p_nScale:Number )
	{
		super( this );
		m_oGroup = new Group( 'parser' );
		m_nScale = p_nScale;
		if( p_sFile instanceof String )
		{
			m_sUrl = p_sFile;
			m_oFile = new XML();
		}
		else
		{
			m_oFile = p_sFile;
		}

		standardAppearance = new Appearance( new ColorMaterial( 0xFF, 100, new MaterialAttributes( new LineAttributes() ) ) );
	}

	/**
	 * Set the standard appearance for all the parsed objects.
	 *
	 * @param p_oAppearance		The standard appearance.
	 */
	public function set standardAppearance( p_oAppearance:Appearance ) : Void
	{
		m_oStandardAppearance = p_oAppearance;
	}

	/**
	 * This method is called when an I/O error occurs.
	 *
	 * @param p_nHttpStatus		The error event.
	 */
	private function _io_error( p_nHttpStatus:Number ) : Void
	{
		if( p_nHttpStatus < 200 || p_nHttpStatus > 299 ) 
		{
			dispatchEvent( new ParserEvent( ParserEvent.FAIL ) );
		}
	}

	/**
	 * @private
	 *
	 * This method is called when all files are loaded and initialized.
	 *
	 * @param s		Boolean: loaded succesfully.
	 */
	private function parseData( s:Boolean ) : Void
	{
		if( !s ) dispatchEvent( new ParserEvent( ParserEvent.FAIL ) );   
	}

	/**
	 * This method is called when all files are loaded/error message is recieved.
	 *
	 * @param str		String: error/download message.
	 */
	private function onData( str:String ) : Void
	{
		trace( 'AParser:: message while loading object ' + str );
	}
		
	/**
	 * @private
	 */
	private function dispatchInitEvent() : Void
	{
		// -- Parsing is finished
		var l_eOnInit:ParserEvent = new ParserEvent( ParserEvent.INIT );
		l_eOnInit.group = m_oGroup;			
		dispatchEvent( l_eOnInit );
	}
	
    /**
     * Load the file that needs to be parsed. When done, call the parseData method.
     */
    public function parse() : Void
	{
		if( m_sUrl instanceof String )
		{
			m_oFile = new XML();
			// Events and their functions
			m_oFile.onLoad = Delegate.create( this, parseData );
			m_oFile.onData = Delegate.create( this, onData );
			m_oFile.onHTTPStatus = Delegate.create( this, _io_error ); 
			// Start loading
			m_oFile.load( m_sUrl );
		}
		else
		{
			parseData();
		}
	}
	
}