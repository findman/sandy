
package sandy.parser;

/**
* The Parser factory class creates instances of parser classes.
* The specific parser can be specified in the create method's second parameter.
*
* @author		Thomas Pfeiffer - kiroukou
* @author		Niel Drummond - haXe port
* @author		Russell WEir - haXe port
* @version		3.1
* @date 		04.08.2007
*
* @example To parse a 3DS file at runtime:
*
* <listing version="3.1">
*     var parser:IParser = Parser.create( "/path/to/my/3dsfile.3ds", Parser.MAX_3DS );
* </listing>
*
*/
class Parser<T,ParserClass:IParser, URL: (String,Null<T>)>
{
	/**
	 * Parameter that is used to specify that the ASE (ASCII Scene Export)
	 * Parser should be used
	 */
	public inline static var ASE:String = "ASE";
	/**
	* Specifies that the MD2 (Quake II model) parser should be used.
	*/
	public inline static var MD2:String = "MD2";
	/**
	 * Parameter that is used to specify that the 3DS (3D Studio) Parser
	 * should be used
	 */
	public inline static var MAX_3DS:String = "3DS";
	/**
	 * Parameter that is used to specify that the COLLADA (COLLAborative
	 * Design Activity ) Parser should be used
	 */
	public inline static var COLLADA:String = "DAE";

	/**
	* The create method chooses which parser to use. This can be done automatically
	* by looking at the file extension or by passing the parser type String as the
	* second parameter.
	*
	* @example To parse a 3DS file at runtime:
	*
	* <listing version="3.1">
	*     var parser:IParser = Parser.create( "/path/to/my/3dsfile.3ds", Parser.3DS );
	* </listing>
	*
	* @param p_sFile			Can be either a string pointing to the location of the
	* 							file or an instance of an embedded file
	* @param p_sParserType		The parser type string
	* @param p_nScale			The scale factor
	* @param p_sTextureExtension	Overrides texture extension.
	* @return					The parser to be used
	*/
	public static function create<ParserClass,URL>( p_sFile:URL, ?p_sParserType:String, ?p_nScale:Float, ?p_sTextureExtension:String ): ParserClass
	{
        if ( p_nScale == null ) p_nScale = 1.0;

		var l_sExt:String,l_iParser:IParser = null;
		// --
		if( Std.is( p_sFile, String ) && p_sParserType == null )
		{
			l_sExt = (untyped p_sFile.split('.')).pop();
		}
		else
		{
			l_sExt = p_sParserType;
		}
		// --
		switch( l_sExt.toUpperCase() )
		{
			case ASE:
// 				l_iParser = new ASEParser( p_sFile, p_nScale, p_sTextureExtension );
			case MD2:
				l_iParser = new MD2Parser( p_sFile, p_nScale, p_sTextureExtension );
			case "OBJ":
			case COLLADA:
				l_iParser = new ColladaParser( p_sFile, p_nScale, p_sTextureExtension );
			case MAX_3DS:
				l_iParser = new Parser3DS( p_sFile, p_nScale, p_sTextureExtension );
			default:
		}
		// --
		return untyped l_iParser;
	}
}

