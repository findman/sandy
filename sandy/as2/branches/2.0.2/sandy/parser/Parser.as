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
import sandy.parser.*;
	
/**
 * The Parser factory class creates instances of parser classes.
 * The specific parser can be specified in the create method's second parameter.
 * 
 * @author		Thomas Pfeiffer - kiroukou
 * @author		Floris van Veen - Floris
 * @version		2.0
 * @date		15.06.2008 		
 *
 * @example To parse a 3DS file at runtime:
 *
 * <listing version="2.0">
 *     var parser:IParser = Parser.create( "/path/to/my/3dsfile.3ds", Parser.3DS );
 * </listing>
 * 
 */	

class sandy.parser.Parser
{
		
	/**
	 * Parameter that is used to specify that the ASE (ASCII Scene Export)
	 * Parser should be used
	 */
	public static var ASE:String = "ASE";

	/**
	 * Parameter that is used to specify that the COLLADA (COLLAborative 
	 * Design Activity ) Parser should be used
	 */
	public static var COLLADA:String = "DAE";
	
	/**
	 * Parameter that is used to specify that the OBJ (WaveFront) 
	 * Parser should be used
	 */
	public static var OBJ:String = "OBJ";
	
	/**
	 * The create method chooses which parser to use. This can be done automatically
	 * by looking at the file extension or by passing the parser type String as the
	 * second parameter.
	 * 
	 * @example To parse a 3DS file at runtime:
	 *
	 * <listing version="2.0">
	 *     var parser:IParser = Parser.create( "/path/to/my/3dsfile.3ds", Parser.3DS );
	 * </listing>
	 * 
	 * @param p_sFile			Can be either a string pointing to the location of the
	 * 							file or an instance of an embedded file
	 * @param p_sParserType		The parser type string
	 * @param p_nScale			The scale factor
	 * @return					The parser to be used
	 */		
	 
				
	public static function create( p_sFile:String, p_sParserType:String, p_nScale:Number ):IParser
	{
		if( p_nScale == undefined ) p_nScale = 1;
			
		var l_sExt:String,l_iParser:IParser = null;
			// --
		if( typeof(p_sFile) == "string" && p_sParserType == undefined )
		{
			l_sExt = (p_sFile.split('.')).reverse()[0];
		}  
		else 
		{
			l_sExt = p_sParserType;
		}
		// --
		switch( l_sExt.toUpperCase() )
		{
			case "ASE":
				l_iParser = new ASEParser( p_sFile, p_nScale );
				break;
			case "OBJ":
				l_iParser = new OBJParser( p_sFile, p_nScale );
				break;
			/**case "DAE":													These parsers will be ported soon to the Sandy 2.0.
				l_iParser = new ColladaParser( p_sFile, p_nScale );
				break;*/
			default:
				break;
		}
		// --
		return l_iParser;
	}
}

