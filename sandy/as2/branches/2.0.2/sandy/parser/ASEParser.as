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
import com.bourre.events.IEvent;

import sandy.core.scenegraph.Geometry3D;
import sandy.core.scenegraph.Shape3D;
import sandy.materials.Appearance;
import sandy.parser.*;

/**
 * Transforms an ASE file into Sandy geometries.
 * <p>Creates a Group as rootnode which appends all geometries it finds.
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		Floris van Veen - Floris
 * @since		1.0
 * @version		2.0
 * @date 		15.06.2008
 *
 */

class sandy.parser.ASEParser extends AParser
{
						
	/**
	 * Creates a new ASEParser instance
	 *
	 * @param p_sUrl		This can be either a String containing an URL or a
	 * 						an embedded object
	 * @param p_nScale		The scale factor
	 */
	public function ASEParser( p_sUrl, p_nScale:Number )
	{
		super( p_sUrl, p_nScale );
	}

	/**
	 * Starts the parsing process
	 *
	 * @param e				The Event object
	 */
	private function parseData( success:Boolean ):Void
	{
		super.parseData( success );
		// --
		var lines:Array = unescape( m_oFile ).split( '\r\n' );
		var lineLength:Number = lines.length;
		var id:Number;
		// -- local vars
		var line:String;
		var content:String;
		var chunk:String;
		var l_oAppearance:Appearance = null;
		var l_oGeometry:Geometry3D = null;
		var l_oShape:Shape3D = null;
		// --
		while( lines.length )
		{
			var event:ParserEvent = new ParserEvent( ParserEvent.PROGRESS );
			event.percent = ( 100 - ( lines.length * 100 / lineLength ) );
			AParser._oEB.broadcastEvent.apply( event );
			//-- parsing
			line = String( lines.shift() );
			//-- clear white space from begin
			line = line.substr( line.indexOf( '*' ) + 1 );
			//-- clear closing brackets
			if( line.indexOf( '}' ) >= 0 ) line = '';
			//-- get chunk description
			chunk = line.substr( 0, line.indexOf( ' ' ) );
			//--
			switch( chunk )
			{
				case 'MESH_NUMFACES':
				{
					//var num: Number =  Number(line.split( ' ' )[1]);
					if( l_oGeometry )
					{
						trace( 'yes' );
						l_oShape = new Shape3D( null, l_oGeometry, m_oStandardAppearance );
						m_oGroup.addChild( l_oShape );
					}
					// -
					l_oGeometry = new Geometry3D();
					break;
				}
				case 'MESH_VERTEX_LIST' :
					while ( ( content = String( lines.shift() ) ).indexOf( '}' ) < 0 ) 
					{
						content = content.substr( content.indexOf( '*' ) + 1 );
						var mvl:Array = content.split( '\t' );
						id = parseInt( mvl[0].substr( mvl[0].lastIndexOf( ' ' ) ) );
						
						l_oGeometry.setVertex( Number( id ) , Number ( parseFloat( mvl[1] ) ) * m_nScale , Number( parseFloat( mvl[3] ) ) * m_nScale , Number( parseFloat( mvl[2] ) ) * m_nScale );
					}
					break;
				case 'MESH_FACE_LIST':
					while( ( content = String( lines.shift() ) ).indexOf( '}' ) < 0 )
					{
						content = content.substr( content.indexOf( '*' ) + 1 );						
						var mfl: Array = content.split(  '\t' )[0]; // ignore: [MESH_SMOOTHING,MESH_MTLID]
						var drc: Array = mfl.split( ':' ); // separate here
						var con: String;		
						id = parseInt( drc[0].substr( drc[0].lastIndexOf( ' ' ) ) );
						
						l_oGeometry.setFaceVertexIds( Number( id ) , Number( parseInt( con.substr( 0, ( con = drc[2] ).lastIndexOf( ' ' ) ) ) ) , Number( parseInt( con.substr( 0, ( con = drc[3] ).lastIndexOf( ' ' ) ) ) ) , Number( parseInt( con.substr( 0, ( con = drc[4] ).lastIndexOf( ' ' ) ) ) ) );
						

					}
					break;
				case 'MESH_TVERTLIST':
					while( ( content = String( lines.shift() ) ).indexOf( '}' ) < 0 )
					{
						content = content.substr( content.indexOf( '*' ) + 1 );
						var mtvl: Array = content.split( '\t' ); // separate here
						id = parseInt( mtvl[0].substr( mtvl[0].lastIndexOf( ' ' ) ) );
						
						l_oGeometry.setUVCoords( Number( id ) , Number( parseFloat( mtvl[1] ) ) , 1 - Number( parseFloat( mtvl[2] ) ) );
					} 
					break;
				case 'MESH_TFACELIST':
					while( ( content = String( lines.shift() ) ).indexOf( '}' ) < 0 )
					{
						content = content.substr( content.indexOf( '*' ) + 1 );
						var mtfl: Array = content.split(  '\t' ); // separate here
						id = parseInt( mtfl[0].substr( mtfl[0].lastIndexOf( ' ' ) ) );
						
						l_oGeometry.setFaceUVCoordsIds( Number( id ) , Number( parseInt( mtfl[1] ) ) , Number( parseInt( mtfl[2] ) ) , Number( parseInt( mtfl[3] ) ) );
												
					}
					break;
			}
		}
		// --
		l_oShape = new Shape3D( null , l_oGeometry, m_oStandardAppearance );
		m_oGroup.addChild( l_oShape );
		// -- Parsing is finished
		var l_eOnInit:ParserEvent = new ParserEvent( ParserEvent.INIT );
		l_eOnInit.group = m_oGroup;
		AParser._oEB.broadcastEvent.apply( l_eOnInit );
	}
}// -- end of ASEParser class

