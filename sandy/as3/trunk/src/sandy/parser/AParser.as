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
package sandy.parser
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import sandy.core.scenegraph.Group;
	import sandy.materials.Appearance;
	import sandy.materials.ColorMaterial;
	import sandy.materials.attributes.*;
	import flash.events.ProgressEvent;

	/**
	 * ABSTRACT CLASS - super class for all parser objects.
	 *
	 * <p>This class should not be directly instatiated, but sub classed.<br/>
	 * The AParser class is responsible for creating the root Group, loading files
	 * and handling the corresponding events.</p>
	 *
	 * @author		Thomas Pfeiffer - kiroukou
	 * @since		1.0
	 * @version		3.0
	 * @date 		26.07.2007
	 */
	public class AParser extends EventDispatcher implements IParser
	{
		//protected static var m_eProgress:ParserEvent = new ParserEvent( ParserEvent.PROGRESS );
		/**
		 * @private
		 */
		protected const m_oLoader:URLLoader = new URLLoader();
		
		/**
		 * @private
		 */
		protected var m_oGroup:Group;
		
		/**
		 * @private
		 */
		protected var m_oFile:Object;
		
		/**
		 * @private
		 */
		protected var m_oFileLoader:URLLoader
		
		/**
		 * @private
		 */
		protected var m_sDataFormat:String;
		
		/**
		 * @private
		 */
		protected var m_nScale:Number;
		
		/**
		 * @private
		 */
		protected var m_oStandardAppearance : Appearance;

		private var m_sUrl:String;

		/**
		 * Creates a parser object. Creates a root Group, default appearance
		 * and sets up an URLLoader.
		 *
		 * @param p_sFile		Must be either a text string containing the location
		 * 						to a file or an embedded object.
		 * @param p_nScale		The scale amount.
		 */
		public function AParser( p_sFile:*, p_nScale:Number )
		{
			super( this );
			m_oGroup = new Group('parser');
			m_nScale = p_nScale;
			if( p_sFile is String )
			{
				m_sUrl = p_sFile;
				m_oFileLoader = new URLLoader();
				m_sDataFormat = URLLoaderDataFormat.TEXT;
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
		public function set standardAppearance( p_oAppearance:Appearance ):void
		{
			m_oStandardAppearance = p_oAppearance;
		}

		/**
		* Called when an I/O error occurs.
		 *
		* @param	e	The error event.
		*/
		private function _io_error( e:IOErrorEvent ):void
		{
			dispatchEvent( new ParserEvent( ParserEvent.FAIL ) );
		}

		/**
		 * @private
		 *
		 * This method is called when all files are loaded and initialized.
		 *
		 * @param e		The event object.
		 */
		protected function parseData( e:Event=null ):void
		{
			if( e != null )
			{
				m_oFileLoader = URLLoader( e.target );
				m_oFile = m_oFileLoader.data;
			}
		}

		/**
		 * @private
		 */
		protected function onProgress( p_oEvt:ProgressEvent ):void
		{
			var event:ParserEvent = new ParserEvent( ParserEvent.PROGRESS );
			event.percent = 100 * p_oEvt.bytesLoaded / p_oEvt.bytesTotal;
			dispatchEvent( event );
		}

		/**
		 * @private
		 */
		protected function dispatchInitEvent ():void
		{
			// -- Parsing is finished
			var l_eOnInit:ParserEvent = new ParserEvent( ParserEvent.INIT );
			l_eOnInit.group = m_oGroup;
			dispatchEvent( l_eOnInit );
		}
		
	    /**
	     * Load the file that needs to be parsed. When done, call the parseData method.
	     */
	    public function parse():void
		{
			if( m_sUrl is String )
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
}
