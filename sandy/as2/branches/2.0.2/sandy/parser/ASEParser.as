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

import sandy.core.scenegraph.Geometry3D;
import sandy.core.scenegraph.Shape3D;
import sandy.materials.Appearance;
import sandy.parser.AParser;
import sandy.parser.IParser;
import sandy.parser.ParserEvent;

/**
 * Transforms an ASE file into Sandy geometries.
 * <p>Creates a Group as rootnode which appends all geometries it finds.
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - xdevltd
 * @since		1.0
 * @version		2.0.2
 * @date 		26.07.2007
 *
 * @example To parse an ASE file at runtime:
 *
 * <listing version="3.0">
 *     var parser:IParser = Parser.create( "/path/to/my/asefile.ase", Parser.ASE );
 * </listing>
 *
 * @example To parse an embedded ASE object:
 *
 * <listing version="3.0">
 *     var parser:IParser = Parser.create( "/path/to/my/asefile.ase", Parser.ASE );
 * </listing>
 */

class sandy.parser.ASEParser extends AParser implements IParser
{
	
	/**
	 * Creates a new ASEParser instance
	 *
	 * @param p_sUrl					This can be either a String containing an URL or a
	 * 									an embedded object
	 * @param p_nScale					The scale factor
	 * @param p_sTextureExtension		Overrides texture extension. You might want to use it for models that   
	 * 									specify PSD or TGA textures. 
	 */
	public function ASEParser( p_sUrl, p_nScale:Number, p_sTextureExtension:String )
	{
		super( p_sUrl, p_nScale||1, p_sTextureExtension );
	}

	/**
	 * @private
	 * Starts the parsing process
	 *
	 * @param e				Boolean: loaded succesfully.
	 */
	private function parseData( s:Boolean ) : Void
	{
		super.parseData( s );
		// --
		var lines:Array =  String( m_oFile ).split( '\r\n' );
		var lineLength:Number = lines.length;
		var id:Number;
		// -- local vars
		var line:String;
		var content:String;
		var chunk:String;
		var l_oAppearance:Appearance = null;
		var l_oGeometry:Geometry3D = null;
		var l_oShape:Shape3D = null;
		var l_sLastNodeName:String = null;
		// --
		var recToGet2:Array = [];   
		var m_textureNames:Array = [];  
		// --
		while( lines.length )
		{
			var event:ParserEvent = new ParserEvent( ParserEvent.PARSING );
			event.percent = ( 100 - ( lines.length * 100 / lineLength ) );
			dispatchEvent( event );
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
				case 'BITMAP':   
					// ideally, we need to load these only from *MAP_DIFFUSE { ... }   
					// *BITMAP "f:\models\mapobjects\kt_barge\kt_barge_grey.tga"   
					// *BITMAP "F:\my_stuff\3d\studentCap\workfiles\textures\studentCap_color_002.psd"   

					m_textureNames.push( line.split( '"' )[ 1 ] );   
					break;   

				case 'GEOMOBJECT':
					// we need to catch this before NODE_NAME
					if( l_oGeometry )
					{
						l_oShape = new Shape3D( l_sLastNodeName, l_oGeometry, m_oStandardAppearance );
						m_oGroup.addChild( l_oShape );
					}
					// -
					l_oGeometry = new Geometry3D();
					break;
				
				case 'NODE_NAME':
					// TODO: NODE_NAME is repeated in NODE_TM - find out why (if there can be multiple nodes, this code will break :)
					l_sLastNodeName = line.split( '"' )[ 1 ];
					break;
				
					/* case 'MESH_NUMFACES':
					{
						//var num: Number =  Number(line.split( ' ' )[1]);
						break;
					} */
				case 'MESH_VERTEX_LIST':
					while( ( content = String( lines.shift() ) ).indexOf( '}' ) < 0 )
					{
						content = content.substr( content.indexOf( '*' ) + 1 );
						var mtvl:Array = content.split( '\t' ); 
						id = parseInt( mtvl[ 0 ].substr( mtvl[ 0 ].lastIndexOf( ' ' ) ) );
						
						l_oGeometry.setUVCoords( id , Number( parseFloat( mtvl[ 1 ] ) ) , 1 - Number( parseFloat( mtvl[ 2 ] ) ) );
					}
					break;
				
				case 'MESH_FACE_LIST':
					while( ( content = String( lines.shift() ) ).indexOf( '}' ) < 0 )
					{
						content = content.substr( content.indexOf( '*' ) + 1 );						
						var mfl:Array = content.split(  '\t' )[ 0 ]; 
						var drc:Array = mfl.split( ':' );
						var con:String;		
						id = parseInt( drc[ 0 ].substr( drc[ 0 ].lastIndexOf( ' ' ) ) );
					}
					break;
					
				case 'MESH_TVERTLIST':
					while( ( content = String( lines.shift() ) ).indexOf( '}' ) < 0 )
					{
						content = content.substr( content.indexOf( '*' ) + 1 );
						var mtvl:Array = content.split( '\t' ); 
						id = parseInt( mtvl[ 0 ].substr( mtvl[ 0 ].lastIndexOf( ' ' ) ) );
						
						l_oGeometry.setUVCoords( id , Number( parseFloat( mtvl[ 1 ] ) ) , 1 - Number( parseFloat( mtvl[ 2 ] ) ) );
					}
					break;

				//TODO: there are ASE file without MESH_TFACELIST, what then
				case 'MESH_TFACELIST':
					while( ( content = String( lines.shift() ) ).indexOf( '}' ) < 0 )
					{
						content = content.substr( content.indexOf( '*' ) + 1 );
						var mtfl:Array = content.split(  '\t' ); 
						id = parseInt( mtfl[ 0 ].substr( mtfl[ 0 ].lastIndexOf( ' ' ) ) );
						
						l_oGeometry.setFaceUVCoordsIds( id , Number( parseInt( mtfl[ 1 ] ) ) , Number( parseInt( mtfl[ 2 ] ) ) , Number( parseInt( mtfl[ 3 ] ) ) );
					}
					break;
				
				case 'MATERIAL_REF':               
					// *MATERIAL_REF 0
					recToGet2.push( parseInt( line.substr( line.lastIndexOf( ' ' ) + 1 ) ) );        
					break;        

			}
		}
		// --
		l_oShape = new Shape3D( l_sLastNodeName, l_oGeometry, m_oStandardAppearance );
		m_oGroup.addChild( l_oShape );
		
		for( var i:Number = 0; i < m_oGroup.children.length; i++ )        
		{        
			applyTextureToShape( Shape3D( m_oGroup.children[ i ] ), m_textureNames[ recToGet2[ i ] ] );        
		} 
		
		// -- Parsing is finished
		dispatchInitEvent();
	}
	
}
