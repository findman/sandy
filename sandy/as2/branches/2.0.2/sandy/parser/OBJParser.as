/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author or authors.
Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 ( the "License" );
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
	http://www.mozilla.org/MPL/MPL-1.1.html
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR COsNDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# ***** END LICENSE BLOCK *****
*/

import com.bourre.commands.Delegate;
import com.bourre.events.EventType;

import flash.display.BitmapData;

import sandy.core.scenegraph.Geometry3D;
import sandy.core.scenegraph.Group;
import sandy.core.scenegraph.Shape3D;
import sandy.materials.Appearance;
import sandy.materials.BitmapMaterial;
import sandy.materials.ColorMaterial;
import sandy.parser.AParser;
import sandy.parser.IParser;
import sandy.parser.ParserEvent;
import sandy.primitive.Line3D;
import sandy.util.BitmapUtil;

/**
 * Transforms a OBJ (WaveFront) file into Sandy geometries.
 * <p>Creates a Group as rootnode which appends all geometries it finds.</p>
 *
 * @author		Floris - xdevltd
 * @version		2.0.2
 * @date 		26.09.2008
 *
 * @example To parse an OBJ object at runtime:
 *
 * <listing version="3.0">
 *     var parser:IParser = Parser.create( "/path/to/my/objfile.obj", Parser.OBJ );
 * </listing>
 *
 * @example To parse an embedded OBJ object:
 *
 * <listing version="3.0">
 *     var parser:IParser = Parser.create( "/path/to/my/objfile.obj", Parser.OBJ );
 * </listing>
 */
 
class sandy.parser.OBJParser extends AParser implements IParser 
{
	
	private var l_oMatLib:Object = {};
	
	/**
	 * Creates a new OBJParser instance.
	 *
	 * @param p_sUrl					This can be either a String containing an URL or a
	 * 									an embedded object
	 * @param p_nScale					The scale factor
	 * @param p_sTextureExtension		Overrides texture extension. You might want to use it for models that   
	 * 									specify PSD or TGA textures. 
	 */
	public function OBJParser( p_sUrl, p_nScale:Number, p_sTextureExtension:String )
	{
		super( p_sUrl, p_nScale||1, p_sTextureExtension );
	}
	
	/**
	 * Add a listener for a specific event.
	 *
	 * @param  t	EventType The type of event we want to register
	 * @param  o	The object listener
	 */
	public function addEventListener( t:EventType, o ) : Void 
	{ 
		super.addEventListener( t, o ); 
	};
	
	/**
	 * Add a listener for a specific event.
	 *
	 * @param  t	EventType The type of event we want to register
	 * @param  o	The object listener
	 */
	public function removeEventListener( e:EventType, oL ) : Void 
	{
		super.removeEventListener( e, oL ); 
	};
	
	/**
	 * @private
	 * Starts the parsing process
	 *
	 * @param b				Boolean: loaded succesfully.
	 */
	private function parseData( b:Boolean ) : Void
	{
		super.parseData( b );
		// --
		var lines:Array = String( m_oFile ).split( '\r\n' );
		var lineLength:Number = lines.length;
		// --
		var line:String;
		var data:String;
		var chunk:String;
		var id:Number = 0;
		var l_oGroup:Group = null;
		var l_oAppearance:Appearance = m_oStandardAppearance;
		var l_oGeometry:Geometry3D = new Geometry3D();
		var l_oShape:Shape3D = null;
		var l_sLastNodeName:String = null;
		
		while( lines.length )
		{
				// -- parsing
				var event:ParserEvent = new ParserEvent( ParserEvent.PARSING );
				event.percent = ( 100 - ( lines.length * 100 / lineLength ) );
				_oEB.dispatchEvent( event );
			
				if( id == 0 ) line = String( lines.shift() )
				// -- get the data
				data = line.substr( line.indexOf( ' ' ) );
				//-- get chunk description
				chunk = line.substr( 0, line.indexOf( ' ' ) );
				
				id = 0;
				
				switch( chunk )
				{
				
					case 'o': // New object
						if( l_oGeometry )
						{
							l_oShape = new Shape3D( l_sLastNodeName, l_oGeometry, l_oAppearance );
							m_oGroup.addChild( l_oShape );
						}
						// -- 	
						l_sLastNodeName = data;
						l_oGeometry = new Geometry3D();
						break;
				
					case 'v': // Vertex
						while( line.substring( 0, line.indexOf( ' ' ) ) == chunk )
						{
							var mvl:Array = data.split( ' ' );	
							l_oGeometry.setVertex( id, Number( mvl[ 1 ] ) * m_nScale, Number( mvl[ 2 ] ) * m_nScale, Number( mvl[ 3 ] ) * m_nScale );
							data = ( line = String( lines.shift() ) ).substr( line.indexOf( ' ' ) );
							id++;	
						}
						break;
						
					case 'f': // Polygon
						while( line.substring( 0, line.indexOf( ' ' ) ) == chunk )
						{
							var mfl:Array = data.split( ' ' );			
							var nfl:Array = new Array();
						
							for( var i:Number = 1; i < mfl.length; i++ )
							{
								if( mfl[ i ].indexOf( '/' ) > -1 ) nfl.push( mfl[ i ].split( '/' )[ 0 ] );
								else nfl.push( mfl[ i ] );
							}
							
							l_oGeometry.setFaceVertexIds( id, nfl );
							
							data = ( line = String( lines.shift() ) ).substr( line.indexOf( ' ' ) );
							id++;						
						}
						break;
					
					case 'l': // Line (extra, not important)
						while( line.substring( 0, line.indexOf( ' ' ) ) == chunk )
						{
							var mll:Array = data.split( ' ' );
							var nll:Array = new Array();
							
							for( i = 1; i < mll.length; i++ )
							{
								if( mll[ i ].indexOf( '/' ) > -1 ) nll.push( mll[ i ].split( '/' )[ 0 ] );
								else nll.push( mll[ i ] );
							}
			
							var l_oLine:Line3D = new Line3D( 'line_' + id, nll )
						
							id++;
							data = ( line = String( lines.shift() ) ).substr( line.indexOf( ' ' ) );
						}
						break;
					
					case 'vt': // Vertex texture coordinates
						while( line.substring( 0, line.indexOf( ' ' ) ) == chunk )
						{
							var mtvl:Array = data.split( ' ' );
							l_oGeometry.setUVCoords( id, Number( mtvl[ 1 ] ), 1 - Number( mtvl[ 2 ] ) );
							data = ( line = String( lines.shift() ) ).substr( line.indexOf( ' ' ) );
							id++;
						}
						break;
				
					case 'usemtl':
						if( !l_oMatLib[ data ] ) 
						{
							var m_sMainMtlLib = m_sUrl.substring( 0, m_sUrl.indexOf( '.' ) ) + '.mtl';
							loadMaterialFiles( m_sMainMtlLib ); 
							trace( 'OBJParser :: material ' + data + ' is undefined. Trying to get it from ' + m_sMainMtlLib + '...' ); 
						}
						l_oAppearance = l_oMatLib[ data ] || m_oStandardAppearance;
						break;
					
					case 'mtllib': // Material files
						var l_aMatFiles:Array = data.split( ' ' ).splice( 1 );
					
						loadMaterialFiles( l_aMatFiles );
						break;			
						
				}
		}

		// --
		l_oShape = new Shape3D( l_sLastNodeName, l_oGeometry, l_oAppearance );
		m_oGroup.addChild( l_oShape );

		// -- Parsing is finished
		dispatchInitEvent();
	}
	
	private function matFileLoaded( b:Boolean ) : Void
	{
		var l_sLastMtl:String = null, l_sPrevLastMtl:String = null;
		var mat:Object = {};
		
		if( b )
		{
			mat.lines = String( this ).split( '\r\n' );
						
			while( mat.lines.length )
			{
				mat.line = String( mat.lines.shift() );
				// -- get the data
				mat.data = mat.line.substr( mat.line.indexOf( ' ' ) );
				//-- get chunk description
				mat.chunk = mat.line.substr( 0, mat.line.indexOf( ' ' ) );
						
				switch( mat.chunk )
				{
					case 'newmtl':
						if( l_oMatLib[ l_sLastMtl ].texture )
						{
							var mcLoader:MovieClipLoader = new MovieClipLoader();

							var obj:Object = new Object();

							obj.onLoadComplete = function( target:MovieClip ) 
							{
								l_oMatLib[ l_sPrevLastMtl ] = new Appearance( new BitmapMaterial( BitmapUtil.movieToBitmap( target, true ) ) );
							}

							mcLoader.addListener( obj );


							mcLoader.loadClip( l_oMatLib[ l_sLastMtl ].texture, this.createEmptyMovieClip( "texture", this.getNextHighestDepth() ) );
											
						}
						else if( l_oMatLib[ l_sLastMtl ].color && l_oMatLib[ l_sLastMtl ].alpha )
						{
							l_oMatLib[ l_sLastMtl ] = new Appearance( new ColorMaterial( l_oMatLib[ l_sLastMtl ].color, l_oMatLib[ l_sLastMtl ].alpha ) );
						}
						l_sLastMtl = mat.data;
						l_oMatLib[ mat.data ] = new Object();
						break;
							
					case 'Kd':
						var c:Array = mat.data.split( ' ' );
						l_oMatLib[ l_sLastMtl ].color = Number( parseInt( c[ 1 ] ) ) * 255 << 16 | Number( parseInt( c[ 2 ] ) ) * 255 << 8 | Number( parseInt( c[ 3 ] ) ) * 255;
						break;
									
					case 'Tr':
						l_oMatLib[ l_sLastMtl ].alpha = Number( parseInt( mat.data ) ) * 100;
						break;
								
					case 'map_Ka':
						// 
						var l_sTexture:String = changeExt( mat.data.split( ' ' )[ mat.data.split( ' ' ).length ] );
						var l_sExt:String;
										
						if( ( l_sExt = l_sTexture.substring( l_sTexture.lastIndexOf( '.' ) ).toLowerCase() ) != 'jpeg' && l_sExt != 'png' && l_sExt != 'gif' )
						{
							trace( 'OBJParser :: cannot load texture file "' + l_sTexture + '" with this extension: .' + l_sExt + '... Convert your texture files (to .jpeg, .png or .gif) and use the texture extension parameter in the Parser.create function.' );
						}
						else l_oMatLib[ l_sLastMtl ].texture = l_sTexture;
									
						break;
							
				}
					
			}
				
		}
		else
		{
			trace( 'OBJParser :: cannot load the material library (.mtl) file "' + m_aFiles[ n ] + '"' );
			
		}

		n++;
		if( m_aFiles[ n ].split( ' ' ).join( '' ).length > 0 ) 
		{
			l_oFile.load( m_aFiles[ n ] );
			l_oFile.onLoad = Delegate.create( this, matFileLoaded );
		} 
		else 
		{
			// all matlibs in the array are loaded
		}
	}
	
	/**
	 * Loads the material (.mtl) files and adds the materials to the object l_oMatLib.
	 */
	private function loadMaterialFiles( /* Arguments */ )
	{
		l_oFile = new XML();	
		n = 0;
		
		if( arguments[ 0 ] instanceof Array ) m_aFiles = arguments[ 0 ];
		else m_aFiles = arguments;
		
		l_oFile.load( m_aFiles[ n ] );
		
		l_oFile.onLoad = Delegate.create( this, matFileLoaded );
		
	}
	
	private var m_aFiles:Array;
	private var l_oFile:XML;
	private var n:Number;

}