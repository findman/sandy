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
 * Converts an XML object to an object with nested properties.
 *
 * Full credits to Alessandro Crugnola - http://www.sephiroth.it/file_detail.php?id=129# and Phil Powell - http://www.sillydomainname.com.
 *
 * @author		Floris - FFlasher ( adaption for Sandy )
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
	 * @param xml		The XML object to convert to an object.
	 */	
	public function XML2Object( xml:XML )
	{			
		data = new Object();
		if( xml ) data = deserialize( xml );
	}
	
	/**
	 * Deserializes and returns the xml object.
	 *
	 * @param xml		XML object.
	 */		
	public static function deserialize( xml:XML ) : Object
	{
		x2o = new XML2Object();
		
		if( xml == null ) return x2o;
		
		x2o.xml = xml;
		
		return x2o.nodesToProperties();
	}
		
	/**
	 * @private
	 * 
	 * Converts the XMLNodes to objects with nested properties and adds them to the main branch.
	 *
	 * @param parent		The parent of the current XMLNode.
	 * @parem path			The path (object).
	 * @parem name			Name of the property of the path.
	 * @parem position		Position in the path.
	 */	
	private function nodesToProperties( parent:XMLNode, path:Object, name:String, position:Number ) : Object
	{
		var nodes:Array;
		var node:XMLNode;
		
		path = ( path == undefined ) ? this.data : path[ name ];

		if( parent == undefined ) parent = XMLNode( this.xml );
		
		if( parent.hasChildNodes() )
		{
			nodes = parent.childNodes;
			if( position != undefined ) path = path[ position ];
			
			while( nodes.length > 0 )
			{
				node = XMLNode( nodes.shift() );

				if ( node.nodeName != undefined )
				{
					var obj = new Object();
					obj.attributes = node.attributes;
					obj.data = sanitizeLineBreaks( node.firstChild.nodeValue );
					
					if( path[ node.nodeName ] != undefined )
					{

						if( path[ node.nodeName ].__proto__ == Array.prototype )
						{
							path[ node.nodeName ].push( obj );
						}
						else
						{
							var copyObj = path[ node.nodeName ];
							delete path[ node.nodeName ];
							path[ node.nodeName ] = new Array();  
							path[ node.nodeName ].push( copyObj );
							path[ node.nodeName ].push( obj );
						}
						position = path[ node.nodeName ].length - 1;
					}
					else
					{
						path[ node.nodeName ] = obj;
						position = undefined;
					}
					name = node.nodeName;
				}
				
				var id:String;
				if( ( id = node.attributes.id ) != null ) path[ id ] = obj;
				
				if( node.hasChildNodes() )
				{
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