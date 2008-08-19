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

package sandy.materials;

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
 * @author Niel Drummond - haXe port 
 * 
 * 
 */
class ColorMaterial extends Material
{
	private var m_nColor:Null<Int>;
	private var m_nAlpha:Null<Float>;

	/**
	 * Creates a new ColorMaterial.
	 *
	 * @param p_nColor 	The color for this material in hexadecimal notation
	 * @param p_nAlpha	The alpha value in percent of full opacity ( 0 - 1 )
	 * @param p_oAttr	The attributes for this material
	 */
	public function new( ?p_nColor:Int, ?p_nAlpha:Float, ?p_oAttr:MaterialAttributes )
	{
		if (p_nColor == null) p_nColor = 0x00;
		if (p_nAlpha == null) p_nAlpha = 1;

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
	public override function renderPolygon( p_oScene:Scene3D, p_oPolygon:Polygon, p_mcContainer:Sprite ):Void
	{
		var l_points:Array<Vertex> = (p_oPolygon.isClipped) ? p_oPolygon.cvertices : p_oPolygon.vertices;
		if( l_points.length == 0 ) return;
		var l_oVertex:Vertex;
		var lId:Null<Int> = l_points.length;
		var l_graphics:Graphics = p_mcContainer.graphics;
		// --
		l_graphics.lineStyle();
		l_graphics.beginFill( m_nColor, m_nAlpha );
		l_graphics.moveTo( l_points[0].sx, l_points[0].sy );
		while( (l_oVertex = l_points[ --lId ]) != null )
			l_graphics.lineTo( l_oVertex.sx, l_oVertex.sy );
		l_graphics.endFill();
		// --
		if( attributes != null )  attributes.draw( l_graphics, p_oPolygon, this, p_oScene ) ;

	}

	/**
	 * @private
	 */
	public var alpha(__getAlpha,__setAlpha):Null<Float>;
	private function __getAlpha():Null<Float>
	{
		return m_nAlpha;
	}

	/**
	 * @private
	 */
	public var color(__getColor,__setColor):Null<Int>;
	private function __getColor():Null<Int>
	{
		return m_nColor;
	}


	/**
	 * The alpha value for this material ( 0 - 1 )
	 *
	 * Alpha = 0 means fully transparent, alpha = 1 fully opaque.
	 */
	private function __setAlpha(p_nValue:Null<Float>):Null<Float>
	{
		m_nAlpha = p_nValue;
		m_bModified = true;
		return p_nValue;
	}

	/**
	 * The color of this material
	 */
	private function __setColor(p_nValue:Null<Int>):Null<Int>
	{
		m_nColor = p_nValue;
		m_bModified = true;
		return p_nValue;
	}

}

