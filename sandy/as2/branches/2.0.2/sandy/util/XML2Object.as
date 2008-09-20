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

/**
 * Converts an XML object to an object with nested properties and functions.
 *
 * Full credits to Alessandro Crugnola - http://www.sephiroth.it/file_detail.php?id=129# and Phil Powell - http://www.sillydomainname.com.
 *
 * @author		Floris - xdevltd (adaption for Sandy, new functions, optimising)
 * @version 	2.0.2
 * @date 		28.10.2008
 */

class sandy.util.XML2Object
{

	public var data:Object;
	
	public var xml:XML;
	
	private var _path:Object;
	private static var x2o:XML2Object;

	/**
	 * Creates a new XML2Object instance.
	 *
	 * @param  xml 	The XML object to convert to an object.
	 */	
	public function XML2Object( xml:XML )
	{			
		data = new Object();
		if( xml ) data = deserialize( xml );
	}
	
	/**
	 * Deserializes and returns the xml object.
	 *
	 * @param  xml 	XML object.
	 */		
	public static function deserialize( xml:XML ) : Object
	{
		x2o = new XML2Object();
		
		if( xml == null ) return x2o;
		
		x2o.xml = xml;
		
		Object.prototype.toString = function() { return this.data; }
		
		return x2o.nodesToProperties();
	}
		
	/**
	 * @private
	 * 
	 * Converts the XMLNodes to objects with nested properties and adds them to the main branch.
	 *
	 * @param  parent 		The parent of the current XMLNode.
	 * @parem  path 		The object.
	 * @parem  name 		Name of the property of the path.
	 * @parem  position 	Position in the path (array).
	 */	
	private function nodesToProperties( parent:XMLNode, path:Object, name:String, position:Number ) : Object
	{
		var nodes:Array;
		var node:XMLNode;
		
		path = ( !path ) ? this.data : path[ name ];

		if( !parent ) parent = XMLNode( this.xml );
		
		if( parent.hasChildNodes() )
		{
			nodes = parent.childNodes;
			if( position ) path = path[ position ];
			
			while( nodes.length > 0 )
			{
				node = XMLNode( nodes.shift() );

				if( node.nodeName )
				{
					var obj = new Object();
					// -- the attributes of the node
					obj.attributes = node.attributes;
					// -- the data, you can use toString() function instead
					obj.data = sanitizeLineBreaks( node.firstChild.nodeValue ); 
					
					/**
					 * Returns the requested children.
					 *
					 * @author		Floris - xdevltd
					 *
					 * @example
					 * // -- Returns the id of the node xml_obj.nodes.testnode.attribute.id:
					 * var testnode_id:String = xml_obj.nodes.child( 'testnode.attribute.id' );
					 *
					 * @param  child 	the path to the child
					 */
					obj.child = function( child:String )
					{
						if( child.indexOf( '.' ) > -1 )
						{
							var pt:Array = child.split( '.' );
							var path:Object = this;
							for( var n:Number = 0; n < pt.length; n++ )
							{
								path = path[ pt[ n ] ];
							}
						} 
						else path = this[ child ];
						
						return path;
					}
							
					
					/**
					 * Returns the XMLNodes where the given attribute is equal to the given value.
					 *
					 * @author		Floris - xdevltd
					 *
					 * @example
					 * // -- Returns the content of one node with the id 'material01'. Gets from that node the sid attribute.
					 * var id:String = xml_obj.nodes.where( 'attributes.id', 'material01', false ).attributes.sid; 
					 *
					 * // -- In AS3 ( without XML2Object class )
					 * var id:String = the_xml.nodes( @id == 'material01' ).attributes.sid;
					 *
					 * // -- Returns an object with all the nodes with the id 'material01'.
					 * var all_nodes_with_material01:Object = xml_obj.nodes.where( 'attributes.id', 'material01', true );
					 *
					 * // -- In AS3 ( without XML2Object class )
					 * var all_nodes_with_material01:XMLList = xml_obj.nodes.( @id == 'material01' );
					 *
					 * @param  item 	the attribute
					 * @param  value	
					 * @param  xmllist 	Boolean: true  = returns a list with the items where the given attribute is equal to the given value
					 *							 false = returns the content of one item where the given attribute is equal to the given value
					 */
					obj.where = function( item:String, value:String, xmllist:Boolean ) : Object
					{
						var length:Number = 0;
						var resultlist:Object = new Object();
						var outputlist:Object = new Object();
						for( var i in this ) 
						{
							var path:String = this[ i ].child( item );
							
							if( path == value && !isNaN( Number( i ) ) ) 
							{
								if( xmllist )
								{
									resultlist[ i ] = this[ i ];
									length++;
								}
								else return this[ i ];
							}
						}
						
						outputlist = resultlist[ 0 ];
						for( var i in resultlist ) outputlist[ i ] = resultlist[ i ];
						
						outputlist.length = function() { return length; };
						
						return outputlist;
					}
					
					/**
					 * Returns the XMLNodes as Array with the given attribute. (where the given attribute != undefined)
					 *
					 * @param  item 	the attribute
					 */
					obj.nodeswith = function( item:String ) : Object
					{
						var n:Number = 0;
						var length:Number = 0;
						var outputlist:Object = new Object();
						var resultlist:Object = new Object();
						for( var i in this )
						{
							var path:String = this[ i ].child( item );
							
							if( path != undefined && isNaN( Number( i ) ) ) 
							{
								resultlist[ n ] = this[ i ][ item ];
								length++;
								n++;
							}
						}
						
						outputlist = resultlist[ 0 ]
						for( var i in resultlist ) outputlist[ i ] = resultlist[ i ];
						
						outputlist.length = function() { return length; };
						
						return outputlist;
					}
							
					
					// -- creates the node with nested properties
					if( path[ node.nodeName ].__proto__ != Array.prototype )
					{
						if( path[ node.nodeName ] != undefined )
						{
							path[ node.nodeName ][ 0 ] = path[ node.nodeName ];
							for( var i in obj ) path[ node.nodeName ][ i ] = obj[ i ];
						}
						else
						{
							path[ node.nodeName ] = obj;
							path[ node.nodeName ][ 0 ] = obj;
						}
						position = undefined;
						path[ node.nodeName ].length = function() { return 1 };
					} 
					else
					{
						var newObj:Object = path[ node.nodeName ][ 0 ]; 
						for( var i in obj ) newObj[ i ] = obj[ i ];
						var n = 0;
						for( var i in path[ node.nodeName ] ) 
						{
							newObj[ i ] = path[ node.nodeName ][ i ];
							n++;
						}
						newObj.length = function() { return n; };
						path[ node.nodeName ] = newObj;
						position = path[ node.nodeName ].length - 1;
					}
					name = node.nodeName;
				}

				if( node.hasChildNodes() )
				{
					// -- repeat all with the childnodes
					this.nodesToProperties( node, path, name, position );
				}
				
			}
			
		}
	
		return this.data;
	}
	
	/**
	 * @private
	 * 
	 * Helper method to sanitize Windows line breaks.
	 */
	private function sanitizeLineBreaks( raw:String )
	{
		if( raw.indexOf( "\r\n" ) > -1 )
		{
			return raw.split( "\r\n" ).join( "\n" );
		}
		return raw;
	}
	
}