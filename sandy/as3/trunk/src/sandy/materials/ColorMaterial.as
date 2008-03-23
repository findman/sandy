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

package sandy.materials
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	import sandy.core.Scene3D;
	import sandy.core.data.Polygon;
	import sandy.core.data.Vector;
	import sandy.core.data.Vertex;
	import sandy.materials.attributes.MaterialAttributes;
	import sandy.util.NumberUtil;

	/**
	 * Displays a color with on the faces of a 3D shape.
	 *
	 * <p>Used to show colored faces, possibly with lines at the edges of the faces.</p>
	 *
	 * @author		Thomas Pfeiffer - kiroukou
	 * @version		3.0
	 * @date 		26.07.2007
	 */
	public final class ColorMaterial extends Material implements IAlphaMaterial
	{
		private var m_nColor:Number;
		private var m_nAlpha:Number;

		/**
		 * Creates a new ColorMaterial.
		 *
		 * @param p_nColor 	The color for this material in hexadecimal notation
		 * @param p_nAlpha	The alpha value in percent of full opacity ( 0 - 1 )
		 * @param p_oAttr	The attributes for this material
		 */
		public function ColorMaterial( p_nColor:uint = 0x00, p_nAlpha:Number = 1, p_oAttr:MaterialAttributes = null )
		{
			super(p_oAttr);
			// --
			m_oType = MaterialType.COLOR;
			// --
			m_nColor = p_nColor;
			m_nAlpha = p_nAlpha;
		}

		/**
		 * Renders this material on the face it dresses
		 *
		 * @param p_oScene		The current scene
		 * @param p_oPolygon	The face to be rendered
		 * @param p_mcContainer	The container to draw on
		 */
		public override function renderPolygon( p_oScene:Scene3D, p_oPolygon:Polygon, p_mcContainer:Sprite ):void
		{
			const l_points:Array = (p_oPolygon.isClipped) ? p_oPolygon.cvertices : p_oPolygon.vertices;
			if( !l_points.length ) return;
			var l_oVertex:Vertex;
			var lId:int = l_points.length;
			var l_graphics:Graphics = p_mcContainer.graphics;
			// --
			l_graphics.lineStyle();
			l_graphics.beginFill( m_nColor, m_nAlpha );
			l_graphics.moveTo( l_points[0].sx, l_points[0].sy );
			while( l_oVertex = l_points[ --lId ] )
				l_graphics.lineTo( l_oVertex.sx, l_oVertex.sy );
			l_graphics.endFill();
			// --
			if( attributes )  attributes.draw( l_graphics, p_oPolygon, this, p_oScene ) ;

		}

		/**
		 * @private
		 */
		public function get alpha():Number
		{
			return m_nAlpha;
		}

		/**
		 * @private
		 */
		public function get color():Number
		{
			return m_nColor;
		}


		/**
		 * The alpha value for this material ( 0 - 1 )
		 *
		 * Alpha = 0 means fully transparent, alpha = 1 fully opaque.
		 */
		public function set alpha(p_nValue:Number):void
		{
			m_nAlpha = p_nValue;
			m_bModified = true;
		}

		/**
		 * The color of this material
		 */
		public function set color(p_nValue:Number):void
		{
			m_nColor = p_nValue;
			m_bModified = true;
		}

	}
}
