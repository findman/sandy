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
 * @author		Floris - xdevltd :: adaption for Sandy, new functions ( child, where, searchfor ), optimalization
 * @version 	2.0.2
 * @date 		28.10.2008
 */

class sandy.util.XML2Object
{

	public var data:Object;
	
	public var xml:XML;
	
	private static var m_X2O:XML2Object;

	/**
	 * Creates a new XML2Object instance.
	 *
	 * @param  p_XML 	The XML object to convert to an object.
	 */	
	public function XML2Object( p_XML:XML )
	{			
		data = new Object();
		if( p_XML ) data = deserialize( p_XML );
	}
	
	/**
	 * Deserializes and returns the xml object.
	 *
	 * @param  p_XML 	XML object.
	 */		
	public static function deserialize( p_XML:XML ) : Object
	{
		m_X2O = new XML2Object();
		
		if( !p_XML ) return m_X2O;
		
		m_X2O.xml = p_XML;
		
		Object.prototype.toString = function() { return this.data; }
		
		return m_X2O.nodesToProperties();
	}
		
	/**
	 * @private
	 * 
	 * Converts the XMLNodes to objects with nested properties and adds them to the main branch.
	 *
	 * @param  p_oParent 		The parent of the current XMLNode.
	 * @parem  p_oPath 		The object.
	 * @parem  p_sName 		Name of the property of the path.
	 * @parem  p_nPosition 	Position in the path (array).
	 */	
	private function nodesToProperties( p_oParent:XMLNode, p_oPath:Object, p_sName:String, p_nPosition:Number ) : Object
	{
		var m_aNodes:Array;
		var m_oNode:XMLNode;
		
		var l_path:Object= ( !p_oPath ) ? this.data : p_oPath[ p_sName ];

		if( !p_oParent ) p_oParent = XMLNode( this.xml );
		
		if( p_oParent.hasChildNodes() )
		{
			m_aNodes = p_oParent.childNodes;
			if( p_nPosition ) l_path = l_path[ p_nPosition ];
			
			while( m_aNodes.length > 0 )
			{
				m_oNode = XMLNode( m_aNodes.shift() );

				if( m_oNode.nodeName )
				{
					// -- object with the properties of the node (attributes, data) and some functions
					var m_oInfo = new Object();
					// -- the attributes of the node
					m_oInfo.attributes = m_oNode.attributes;
					// -- the data, toString() function returns this property
					m_oInfo.data = sanitizeLineBreaks( m_oNode.firstChild.nodeValue ); 
					
					/**
					 * Returns the requested children.
					 *
					 * @author		Floris - xdevltd
					 *
					 * @example
					 * // -- Returns the id of the node xml_obj.nodes.testnode.attribute.id:
					 * var testnode_id:String = xml_obj.nodes.child( 'testnode.attribute.id' );
					 *
					 * @param  p_sChild 	the path to the child
					 */
					m_oInfo.child = function( p_sChild:String )
					{
						if( p_sChild.indexOf( '.' ) > -1 )
						{
							var l_aChild:Array = p_sChild.split( '.' );
							var l_path:Object = this;
							for( var n:Number = 0; n < l_aChild.length; n++ )
							{
								l_path = l_path[ l_aChild[ n ] ];
							}
						} 
						else l_path = this[ p_sChild ];
						
						return l_path;
					}
							
					/**
					 * Returns the XMLNodes where the given attribute is equal to the given value.
					 *
					 * @author		Floris - xdevltd
					 *
					 * @example
					 * // -- Returns the content of one node with the id 'material01'. Gets from that node the sid attribute.
					 * var id:String = xml_obj.nodes.where( 'attributes.id', 'material01' ).attributes.sid; 
					 *
					 * // -- In AS3 ( without XML2Object class )
					 * var id:String = the_xml.nodes( @id == 'material01' ).attributes.sid;
					 *
					 * // -- Returns an object with all the nodes with the id 'material01'.
					 * var all_nodes_with_material01:Object = xml_obj.nodes.where( 'attributes.id', 'material01' );
					 *
					 * // -- In AS3 ( without XML2Object class )
					 * var all_nodes_with_material01:XMLList = xml_obj.nodes.( @id == 'material01' );
					 *
					 * @param  p_sItem 	path to the attribute
					 * @param  p_sValue	
					 */
					m_oInfo.where = function( p_sItem:String, p_sValue:String ) : Object
					{
						var n:Number = 0;
						var l_oResult:Object = new Object();
						var l_oOutput:Object = new Object();
						for( var i in this ) 
						{
							var l_sPath:String = this[ i ].child( p_sItem );
							
							if( l_sPath == String( p_sValue ) && !isNaN( Number( i ) ) ) 
							{
								l_oResult[ n ] = this[ i ];
								n++;
							}
						}
						
						l_oOutput = l_oResult[ 0 ];
						for( var i in l_oResult ) l_oOutput[ i ] = l_oResult[ i ];
						
						l_oOutput.length = function() { return n; };
						
						return l_oOutput;
					}
					
					/**
					 * Returns the XMLNodes as Object with the given attribute. (where the given attribute != undefined)
					 *
					 * @param  p_sItem 	path to the attribute
					 */
					m_oInfo.searchfor = function( p_sItem:String ) : Object
					{
						var n = 0;
						var l_oOutput = new Object();
						var l_oResult = new Object();
						for( var i in this )
						{
							var l_sPath:String = this[ i ].child( p_sItem );
							
							if( l_sPath != undefined && isNaN( Number( i ) ) ) 
							{
								l_oResult[ n ] = this[ i ][ p_sItem ];
								n++;
							}
							
						}
						
						l_oOutput = l_oResult[ 0 ]
						for( var i in l_oResult ) l_oOutput[ i ] = l_oResult[ i ];
						
						l_oOutput.length = function() { return n; };
						
						return l_oOutput;
					}
							
					
					// -- creates the node with nested properties
					if( l_path[ m_oNode.nodeName ].__proto__ != Array.prototype )
					{
						if( l_path[ m_oNode.nodeName ] )
						{
							l_path[ m_oNode.nodeName ][ 0 ] = l_path[ m_oNode.nodeName ];
							for( var i in m_oInfo ) l_path[ m_oNode.nodeName ][ i ] = m_oInfo[ i ];
						}
						else
						{
							l_path[ m_oNode.nodeName ] = m_oInfo;
							l_path[ m_oNode.nodeName ][ 0 ] = m_oInfo;
						}
						p_nPosition = undefined;
						l_path[ m_oNode.nodeName ].length = function() { return 1 };
					} 
					else
					{
						var newObj:Object = l_path[ m_oNode.nodeName ][ 0 ]; 
						for( var i in m_oInfo ) newObj[ i ] = m_oInfo[ i ];
						var n = 0;
						for( var i in l_path[ m_oNode.nodeName ] ) 
						{
							newObj[ i ] = l_path[ m_oNode.nodeName ][ i ];
							n++;
						}
						newObj.length = function() { return n; };
						l_path[ m_oNode.nodeName ] = newObj;
						p_nPosition = l_path[ m_oNode.nodeName ].length - 1;
					}
					var m_sName:String = m_oNode.nodeName;
				}

				if( m_oNode.hasChildNodes() )
				{
					// -- repeat all with the childnodes
					this.nodesToProperties( m_oNode, l_path, m_sName, p_nPosition );
				}
				
			}
			
		}
	
		return this.data;
	}
	
	/**
	 * @private
	 * 
	 * Helper method to sanitize Windows line breaks.
	 *
	 * @param  p_sRaw	
	 */
	private function sanitizeLineBreaks( p_sRaw:String )
	{
		if( p_sRaw.indexOf( "\r\n" ) > -1 )
		{
			return p_sRaw.split( "\r\n" ).join( "\n" );
		}
		return p_sRaw;
	}
	
}