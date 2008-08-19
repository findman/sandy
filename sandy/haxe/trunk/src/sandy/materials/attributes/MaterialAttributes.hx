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

# ***** END LICENSE BLOCK *****
*/


package sandy.materials.attributes;

import flash.display.Graphics;

import sandy.core.Scene3D;
import sandy.core.data.Polygon;
import sandy.core.scenegraph.Sprite2D;
import sandy.materials.Material;

class MaterialAttributes
{
	public var attributes:Array<IAttributes>;
	
	public function new( ?args:Array<Dynamic> )
	{
	 if ( args == null ) args = new Array();
		
	 attributes = new Array();

		for( i in 0...args.length )
		{
			if( Std.is( args[i], IAttributes ) )
				attributes.push( args[i] );
		}
	}

	/**
	 * Allows to proceed to an initialization
	 * to know when the polyon isn't lined to the material, look at #unlink
	 */
	public function init( p_oPolygon:Polygon ):Void
	{
		for( l_oAttr in attributes )
			l_oAttr.init( p_oPolygon );
	}

	/**
	 * Remove all the initialization
	 * opposite of init
	 */
	public function unlink( p_oPolygon:Polygon ):Void
	{
		for( l_oAttr in attributes )
			l_oAttr.unlink( p_oPolygon );
	}
		
	public function begin( p_oScene:Scene3D ):Void
	{
		for( l_oAttr in attributes )
			l_oAttr.begin( p_oScene );
	}
	
	public function finish( p_oScene:Scene3D ):Void
	{
		for( l_oAttr in attributes )
			l_oAttr.finish( p_oScene );
	}
	
	public function draw( p_oGraphics:Graphics, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D ):Void
	{
		for( l_oAttr in attributes )
			l_oAttr.draw( p_oGraphics, p_oPolygon, p_oMaterial, p_oScene );
	}
	
	public function drawOnSprite( p_oSprite:Sprite2D, p_oMaterial:Material, p_oScene:Scene3D ):Void
	{
		for( l_oAttr in attributes )
			l_oAttr.drawOnSprite( p_oSprite, p_oMaterial, p_oScene );
	}

	public var flags(__getFlags,null):Null<Int>;
	private function __getFlags():Null<Int>
	{
		var l_nFlags:Null<Int> = 0;
		for( l_oAttr in attributes )
			l_nFlags |= l_oAttr.flags;
		return l_nFlags;
	}
}

