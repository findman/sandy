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

package sandy.parser;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;

import sandy.core.scenegraph.Group;
import sandy.materials.Appearance;
import sandy.materials.ColorMaterial;
import sandy.materials.attributes.AAttributes;
import sandy.materials.attributes.ALightAttributes;
import sandy.materials.attributes.CelShadeAttributes;
import sandy.materials.attributes.DashedLineAttributes;
import sandy.materials.attributes.GouraudAttributes;
import sandy.materials.attributes.IAttributes;
import sandy.materials.attributes.LightAttributes;
import sandy.materials.attributes.LineAttributes;
import sandy.materials.attributes.MaterialAttributes;
import sandy.materials.attributes.MediumAttributes;
import sandy.materials.attributes.OutlineAttributes;
import sandy.materials.attributes.PhongAttributes;
import sandy.materials.attributes.PhongAttributesLightMap;
import sandy.materials.attributes.VertexNormalAttributes;
import flash.events.ProgressEvent;

/**
 * ABSTRACT CLASS - super class for all parser objects.
 *
 * <p>This class should not be directly instatiated, but sub classed.<br/>
 * The AParser class is responsible for creating the root Group, loading files
 * and handling the corresponding events.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 */
class AParser extends EventDispatcher, implements IParser
{
	private var m_oLoader:URLLoader;
	private var m_oGroup:Group;
	private var m_oFile:Dynamic;
	private var m_oFileLoader:URLLoader;
	private var m_sDataFormat:URLLoaderDataFormat;
	private var m_nScale:Float;
	private var m_oStandardAppearance : Appearance;

	private var m_sUrl:String;
	public var m_sName:String;

	/**
	 * Creates a parser object. Creates a root Group, default appearance
	 * and sets up an URLLoader.
	 *
	 * @param p_sFile		Must be either a text string containing the location
	 * 						to a file or an embedded object
	 * @param p_nScale		The scale amount
	 */
	public function new( p_sFile:Dynamic, p_nScale:Float )
	{

	    m_oLoader = new URLLoader();

		super( this );
		m_oGroup = new Group('parser');
		m_nScale = p_nScale;
		if( Std.is( p_sFile, String ) )
		{
			m_sUrl = p_sFile;
			m_oFileLoader = new URLLoader();
			m_sDataFormat = URLLoaderDataFormat.TEXT;
		}
		else
		{
			m_oFile = p_sFile;
		}

		standardAppearance = new Appearance( new ColorMaterial( 0xFF, 100, new MaterialAttributes( [new LineAttributes()] ) ) );
	}

	/**
	 * Set the standard appearance for all the parsed objects.
	 *
	 * @param p_oAppearance		The standard appearance
	 */
	public var standardAppearance( null, __setStandardAppearance ):Appearance;
	private function __setStandardAppearance( p_oAppearance:Appearance ):Appearance
	{
		m_oStandardAppearance = p_oAppearance;
        return p_oAppearance;
	}

	/**
	* Called when an I/O error occurs.
	 *
	* @param	e	The error event
	*/
	private function _io_error( e:IOErrorEvent ):Void
	{
		dispatchEvent( new ParserEvent( ParserEvent.FAIL ) );
	}

	/**
	 * This method is called when all files are loaded and initialized
	 *
	 * @param e		The event object
	 */
	private function parseData( ?e:Event ):Void
	{
		if( e != null )
		{
			m_oFileLoader = e.target; //URLLoader( e.target );
			m_oFile = m_oFileLoader.data;
		}
	}

	private function onProgress( p_oEvt:ProgressEvent ):Void
	{
		var event:ParserEvent = new ParserEvent( ParserEvent.PROGRESS );
		event.percent = 100 * p_oEvt.bytesLoaded / p_oEvt.bytesTotal;
		dispatchEvent( event );
	}
	
    /**
     * Load the file that needs to be parsed. When done, call the parseData method.
     */
    public function parse():Void
	{
		if( Std.is( m_sUrl, String ) )
		{
			// Construction d'un objet URLRequest qui encapsule le chemin d'acces
			var urlRequest:URLRequest = new URLRequest( m_sUrl );
			// Ecoute de l'evennement COMPLETE
			m_oFileLoader.addEventListener( Event.COMPLETE, parseData );
			m_oFileLoader.addEventListener( ProgressEvent.PROGRESS, onProgress );
			m_oFileLoader.addEventListener( IOErrorEvent.IO_ERROR , _io_error );
			// Lancer le chargement
			m_oFileLoader.dataFormat = m_sDataFormat;
			m_oFileLoader.load(urlRequest);
		}
		else
		{
			parseData();
		}
	}
}

