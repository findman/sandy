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
 * Transforms an OBJ (Wavefront) file into Sandy geometries.
 * <p>Creates a Group as rootnode which appends all geometries it finds.
 *
 * @author		Floris van Veen - Floris
 * @since		1.0
 * @version		2.0
 * @date 		15.06.2008
 *
 */

class sandy.parser.OBJParser extends AParser
{
			
	/**
	 * Creates a new ASEParser instance
	 *
	 * @param p_sUrl		This can be either a String containing an URL or a
	 * 						an embedded object
	 * @param p_nScale		The scale factor
	 */
	public function OBJParser( p_sUrl, p_nScale:Number )
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
		var l_oAppearance:Appearance = null;
		var l_oGeometry:Geometry3D = null;
		var l_oShape:Shape3D = null;
		var content:String;

		var vertID:Number = 0;
		var faceID:Number = 0;
		var vtxID:Number = 0;
		
		var n:Number;

		for( n = 0; n < lineLength; n++ )
		{
			var event:ParserEvent = new ParserEvent( ParserEvent.PROGRESS );
			event.percent = ( 100 - ( lines.length * 100 / lineLength ) );
			AParser._oEB.broadcastEvent.apply( event );
		
			var line:Array = String( lines[n] ).split(' ');
			
			switch( line[0] )
			{
				case 'o': //-- new object
				{
					//var num: Number =  Number(line.split( ' ' )[1]);
					if( l_oGeometry )
					{
						l_oShape = new Shape3D( null, l_oGeometry, m_oStandardAppearance );
						m_oGroup.addChild( l_oShape );
					}
					// -
					l_oGeometry = new Geometry3D();
					break;
				}
				case 'v' : //-- vertex
					for( ; ( content = String( lines[n] ) ).indexOf( 'v' ) == 0 ; vertID++ , n++ ) 
					{
						var mvl:Array = content.split( ' ' );
						l_oGeometry.setVertex( Number( vertID ) , Number ( parseFloat( mvl[1] ) ) * m_nScale , Number( parseFloat( mvl[2] ) ) * m_nScale , Number( parseFloat( mvl[3] ) ) * m_nScale );
					}
					break;
				case 'f': //-- faces
					for( ; ( content = String( lines[n] ) ).indexOf( 'f' ) == 0 ; faceID++ , n++ ) 
					{
						var mfl:Array = content.split( ' ' );
						
						if( mfl[4] )
							l_oGeometry.setFaceVertexIds( Number( faceID ) , Number( parseInt( mfl[1].split( '/' )[0] ) ) , Number( parseInt( mfl[2].split( '/' )[0] ) ) , Number( parseInt( mfl[3].split( '/' )[0] ) ) , mfl.splice( 4 ) ); 
						else
						{ 
							l_oGeometry.setFaceVertexIds( Number( faceID ) , Number( parseInt( mfl[1].split( '/' )[0] ) ) , Number( parseInt( mfl[2].split( '/' )[0] ) ) , Number( parseInt( mfl[3].split( '/' )[0] ) ) );
						};
					}
					break;
				case 'vt': //-- vertex texture coordinates
					for( ; ( content = String( lines[n] ) ).indexOf( 'vt' ) == 0 ; vtxID++ , n++ ) 
					{
						var mtvl:Array = content.split(' ');
						l_oGeometry.setUVCoords( Number( vtxID ) , Number( parseFloat( mtvl[1] ) ) , 1 - Number( parseFloat( mtvl[2] ) ) );
					} 
					break;
			}
		}
		// --
		l_oShape = new Shape3D( null, l_oGeometry, m_oStandardAppearance );
		m_oGroup.addChild( l_oShape );
		// -- Parsing is finished
		var l_eOnInit:ParserEvent = new ParserEvent( ParserEvent.INIT );
		l_eOnInit.group = m_oGroup;
		AParser._oEB.broadcastEvent.apply( l_eOnInit );
	}
}// -- end of OBJParser class

