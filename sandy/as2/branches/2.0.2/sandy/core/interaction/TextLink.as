/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author Thomas PFEIFFER
Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
	http://www.mozilla.org/MPL/MPL-1.1.html
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# ***** END LICENSE BLOCK ******/

/**
* ...
* @author Ported by FFlasher/Floris
* @version 2.0.2
*/

import flash.geom.Rectangle;

class sandy.core.interaction.TextLink
{
	public static var textLinks : Object;
		
	public var x 				: Number;
	public var y 				: Number;
	public var height			: Number;
	public var width			: Number;
	
	private var __sHRef			: String;
	private var __sTarget		: String;
	private var __iOpenIndex	: Number;
	private var __iCloseIndex	: Number;
	private var __tfOwner		: TextField;
	private var __rBounds		: Rectangle;
		
	public function TextLink() 
	{
		x = 0;
		y = 0;
		height = 0;
		width = 0;
	}
		
/* ****************************************************************************
* PUBLIC FUNCTIONS
**************************************************************************** */		
	/**
	 * Return an array of textlinks.
	 * @param	t
	 * @return Array of textlinks.
	 */
	public static function getTextLinks( t : TextField, force : Boolean ) : Array
	{
		if ( !t.htmlText ) return null;
		if ( !textLinks ) textLinks = new Object();
		if ( textLinks[t] && !force ) return textLinks[t];
		
		textLinks[t] = new Array();
		
		var rawText 	: String = t.htmlText.split( ' ' ).join( '' );
		rawText = rawText.split( '"' ).join( "'" );
		
		var reHRef		: String =  "href='";	
		var reTarget	: String =  "target='";				
		var openA		: String = '<a';		 					
		var closeA		: String = '</a>';							
		
		var rawText:Array = rawText.split( openA );
		
		var i:Number = 0;

		// Example url: <a href = 'http://flashsandy.org' target = '_blank'>Sandy 3D</a>
		while( --rawText.length > -1 )
		{
			var link:TextLink = new TextLink();
			link.owner = t;
			textLinks[t].push( link );
			
			var href:Array = rawText[i].split( reHRef ); 
			var h:Array = href[1].split( "'" );
			link.href = h[0];								//example: http://flashsandy.org
		
			var target:Array = h[1].split( reTarget );
			var tg:Array = target[1].split( "'" );
			link.target = tg[0];							//example: _blank
					
			link._init();
			
			var lt1:Array = tg[1].split( '>' );
			var lt2:Array = lt1[1].split( closeA );
			var linkText:String = lt2[0];					//example: Sandy 3D
			
			//-- What to do with link.closeIndex and link.openIndex?
			
			i++;
		}
			
		return textLinks[t];
	}
	
	public function getBounds() : Rectangle
	{
		return __rBounds;
	}

		
/* ****************************************************************************
* GETTER && SETTER
**************************************************************************** */
	public function get owner() : TextField
	{
		return __tfOwner;
	}

	public function set owner( tf : TextField ) : Void
	{
		__tfOwner = tf;
	}	
	
	public function get target() : String
	{
		return __sTarget;
	}

	public function set target( s : String ) : Void
	{
		__sTarget = s;
	}
		
	public function get href() : String
	{
		return __sHRef;
	}

	public function set href( s : String ) : Void
	{
		__sHRef = s;
	}
		
	public function get openIndex() : Number
	{
		return int( __iOpenIndex );
	}

	public function set openIndex( i : Number ) : Void
	{
		__iOpenIndex = int( i );
	}
		
	public function get closeIndex() : Number
	{
		return int( __iCloseIndex );
	}

	public function set closeIndex( i : Number ) : Void
	{
		__iCloseIndex = int( i );
	}
		
		
/* ****************************************************************************
* PRIVATE FUNCTIONS
**************************************************************************** */
	private function _init() : Void
	{	
		for ( var j : Number = 0; j < __iCloseIndex - __iOpenIndex; j++ )
		{
			var rectB : Rectangle = __tfOwner.getCharBoundaries( openIndex + j ); //-- How to change it to AS2 code?
			if ( j == 0 ) {
				x = rectB.x;
				y = rectB.y;
			}
			width += rectB.width;
			height = height < rectB.height ? rectB.height : height ;
		}
	
		__rBounds = new Rectangle();
		__rBounds.x = x;
		__rBounds.y = y;
		__rBounds.height = height;
		__rBounds.width = width;
	}
	
}