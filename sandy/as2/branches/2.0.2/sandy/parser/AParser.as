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
import com.bourre.events.EventType;
import com.bourre.events.IEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.commands.Delegate;

import sandy.events.Event;
import sandy.core.scenegraph.Group;
import sandy.materials.Appearance;
import sandy.materials.ColorMaterial;
import sandy.materials.attributes.*;
import sandy.parser.*;


/**
 * ABSTRACT CLASS - super class for all parser objects.
 *
 * <p>This class should not be directly instatiated, but sub classed.<br/>
 * The AParser class is responsible for creating the root Group, loading files
 * and handling the corresponding events.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		Floris van Veen - Floris
 * @since		3.0
 * @version		2.0
 * @date 		15.06.2008
 */
class sandy.parser.AParser implements IParser
{
	
	//private static var m_eProgress:ParserEvent = new ParserEvent( ParserEvent.PROGRESS );
	//as2 private var works as the as3 protected var
	private var m_oGroup:Group;
	private var m_oFile:String;
	private var m_oFileLoader:LoadVars;
	private var m_nScale:Number;
	public static var m_oStandardAppearance:Appearance;
	private var m_sUrl:String;
	private var m_sHTTPError:Number;

	/**
 	* Add a listener for a specific event.
 	* @param t EventType The type of event we want to register
 	* @param o The object listener
 	*/
	public function addEventListener( t:EventType, o ):Void 
	{
		_oEB.addEventListener.apply( _oEB, arguments );
	}		
	
	public static var _oEB:EventBroadcaster = new EventBroadcaster( AParser );
	
	/**
	 * Creates a parser object. Creates a root Group, default appearance
	 * and sets up an URLLoader.
	 *
	 * @param p_sFile		Must be either a text string containing the location
	 * 						to a file or an embedded object
	 * @param p_nScale		The scale amount
	 */
	public function AParser( p_sFile, p_nScale:Number )
	{
		super( this );
		m_oGroup = new Group('parser');
		m_nScale = p_nScale;
		if( typeof(p_sFile) == "string" )
		{
			m_sUrl = p_sFile;
			m_oFileLoader = new LoadVars();
		}
		else
		{
			m_oFile = p_sFile;
		}
			var standardAppearance:Appearance = new Appearance( new ColorMaterial( 0xFF0000, 0 ) );
	}
	/**
	 * Set the standard appearance for all the parsed objects.
	 *
	 * @param p_oAppearance		The standard appearance
	 */
	public function setStandardAppearance( p_oAppearance:Appearance ):Void
	{
		m_oStandardAppearance = p_oAppearance;
	}
	
	/**
	* Called when httpStatus is recieved.
	*
	* @param	httpStatus		Number of the httpStatus
	*/
	private function _io_error( err:Number ):Void
	{
   		if( err < 200 or err > 299 ) 
		{
			m_sHTTPError = err;
   		}
 	}
		
	 /**
	 * This method is called when all files are intialized.
	 *
	 * @param success		Boolean, success by loading
	 */
	private function parseData( success:Boolean )
	{		
		if( success and success != null )
		{
			m_oFile = m_oFileLoader.toString();
		}
		else 
		{
			_oEB.removeEventListener( ParserEvent.FAIL );
			_oEB.removeEventListener( ParserEvent.INIT );
			var event:ParserEvent = new ParserEvent( ParserEvent.FAIL );
			if( m_sHTTPError != null ) event.message += m_sHTTPError + ' while opening url ' + m_sUrl; 
			else { event.message = "Error: the filename is incorrect";  }
			_oEB.broadcastEvent.apply( event ); 

		}			
	}
		
	
    /**
     * Load the file that needs to be parsed. When done, call the parseData method.
     */
    public function parse():Void
	{
		if( typeof( m_sUrl ) == "string" )
		{
			m_oFileLoader = new LoadVars();
			// Events and their functions
			m_oFileLoader.onLoad = Delegate.create( this, parseData );
			m_oFileLoader.onHTTPStatus = Delegate.create( this, _io_error ); 
			// Start loading
			m_oFileLoader.load( m_sUrl );			
		}
		else
		{
			parseData();
			//m_sUrl is no string
		}
	}
}

