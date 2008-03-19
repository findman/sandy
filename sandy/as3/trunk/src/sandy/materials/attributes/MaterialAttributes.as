﻿/*
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
package sandy.materials.attributes
{
	import flash.display.Graphics;
	
	import sandy.core.Scene3D;
	import sandy.core.data.Polygon;
	import sandy.core.scenegraph.Sprite2D;
	import sandy.materials.Material;
	
	/**
	 * The MaterialAttributes class is used to apply one or more attributes to a Shape3D object.
	 * 
	 * @version		3.0
	 *
	 * @see sandy.core.scenegraph.Shape3D
	 */
	public class MaterialAttributes
	{
		public var attributes:Array = new Array();
		
		/**
		 * Creates a new LightAttributes object.
		 */
		public function MaterialAttributes( ...args )
		{
			for( var i:int = 0; i < args.length; i++ )
			{
				if( args[i] is IAttributes )
				{
					attributes.push( args[i] );
				}
			}
		}

		/**
		* Allows all attributes to proceed to an initialization to know when the polyon isn't lined to the material.
		*
		* @param p_oPolygon	The polygon.
		*
		* @see #unlink()
		* @see sandy.core.data.Polygon
		*/
		public function init( p_oPolygon:Polygon ):void
		{
			for each( var l_oAttr:IAttributes in attributes )
			{
				l_oAttr.init( p_oPolygon );
			}
		}
	
		/**
		* Remove all initializations opposite of init from all attributes.
		*
		* @param p_oPolygon	The polygon.
		*
		* @see #init()
		* @see sandy.core.data.Polygon
		*/
		public function unlink( p_oPolygon:Polygon ):void
		{
			for each( var l_oAttr:IAttributes in attributes )
			{
				l_oAttr.unlink( p_oPolygon );
			}
		}
			
		/**
		* Method called before the display list rendering. This is the common place for this attribute to precompute things.
		*
		* @param p_oScene	The scene.
		*
		* @see #finish()
		* @see sandy.core.Scene3D
		*/
		public function begin( p_oScene:Scene3D ):void
		{
			for each( var l_oAttr:IAttributes in attributes )
			{
				l_oAttr.begin( p_oScene );
			}
		}
		
		/**
		* Method called right after the display list rendering. This is the place to remove and dispose memory if necessary.
		*
		* @param p_oScene	The scene.
		*
		* @see #begin()
		* @see sandy.core.Scene3D
		*/
		public function finish( p_oScene:Scene3D ):void
		{
			for each( var l_oAttr:IAttributes in attributes )
			{
				l_oAttr.finish( p_oScene );
			}
		}
		
		/**
		* Draws all attributes to the graphics object.
		*
		* @param p_oGraphics	The Graphics object to draw attributes to.
		* @param p_oPolygon		The polygon which is going to be drawn.
		* @param p_oMaterial	The refering material.
		* @param p_oScene		The scene.
		*
		* @see sandy.core.data.Polygon
		* @see sandy.materials.Material
		* @see sandy.core.Scene3D
		*/
		public function draw( p_oGraphics:Graphics, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D ):void
		{
			for each( var l_oAttr:IAttributes in attributes )
			{
				l_oAttr.draw( p_oGraphics, p_oPolygon, p_oMaterial, p_oScene );
			}
		}
		
		/**
		* Applies attributes to a sprite.
		*
		* @param p_oSprite		The Sprite2D object to draw attributes to.
		* @param p_oMaterial	The refering material.
		* @param p_oScene		The scene.
		*
		* @see sandy.core.scenegraph.Sprite2D
		* @see sandy.materials.Material
		* @see sandy.core.Scene3D
		*/
		public function drawOnSprite( p_oSprite:Sprite2D, p_oMaterial:Material, p_oScene:Scene3D ):void
		{
			for each( var l_oAttr:IAttributes in attributes )
			{
				l_oAttr.drawOnSprite( p_oSprite, p_oMaterial, p_oScene );
			}
		}

		/**
		* Returns flags for attributes.
		*
		* @see sandy.core.SandyFlags
		*/
		public function get flags():uint
		{
			var l_nFlags:uint = 0;
			for each( var l_oAttr:IAttributes in attributes )
			{
				l_nFlags |= l_oAttr.flags;
			}
			return l_nFlags;
		}
	}
}