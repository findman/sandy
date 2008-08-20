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

import sandy.core.Scene3D;
import sandy.core.data.Polygon;
import sandy.core.data.Vector;
import sandy.core.data.Vertex;
import sandy.materials.Material;
import sandy.materials.MaterialType;
import sandy.materials.attributes.MaterialAttributes;
import sandy.util.NumberUtil;

/**
 * Displays a color with on the faces of a 3D shape.
 *
 * <p>Used to show colored faces, possibly with lines at the edges of the faces.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - FFlasher
 * @version		2.0.2
 * @date 		26.07.2007
 */
	 
class sandy.materials.ColorMaterial extends Material //implements IAlphaMaterial // problem: interface doesn't work with getters/setters
{
	
	private var m_nColor:Number;
	private var m_nAlpha:Number;

	/**
	 * Creates a new ColorMaterial.
	 *
	 * @param p_nColor 	The color for this material in hexadecimal notation.
	 * @param p_nAlpha	The alpha transparency value of the material.
	 * @param p_oAttr	The attributes for this material.
	 *
	 * @see sandy.materials.attributes.MaterialAttributes
	 */
	public function ColorMaterial( p_nColor:Number, p_nAlpha:Number, p_oAttr:MaterialAttributes )
	{
		super( p_oAttr );
		// --
		m_oType = MaterialType.COLOR;
		// --
		m_nColor = p_nColor||0x00;
		m_nAlpha = p_nAlpha||1;
	}

	/**
	 * @private
	 */
	public function renderPolygon( p_oScene:Scene3D, p_oPolygon:Polygon, p_mcContainer:MovieClip ) : Void
	{
		var l_points:Array = ( p_oPolygon.isClipped ) ? p_oPolygon.cvertices : p_oPolygon.vertices;
		if( !l_points.length ) return;
		var l_oVertex:Vertex;
		var lId:Number = l_points.length;
		// --
		p_mcContainer.lineStyle();
		p_mcContainer.beginFill( m_nColor, m_nAlpha );
		p_mcContainer.moveTo( l_points[0].sx, l_points[0].sy );
		while( l_oVertex = l_points[ --lId ] )
			p_mcContainer.lineTo( l_oVertex.sx, l_oVertex.sy );
		p_mcContainer.endFill();
		// --
		if( attributes )  attributes.draw( p_mcContainer, p_oPolygon, this, p_oScene ) ;
	}
	
	/**
	 * Indicates the alpha transparency value of the material. Valid values are 0 (fully transparent) to 1 (fully opaque).
	 *
	 * @default 1.0
	 */
	public function get alpha() : Number
	{
		return m_nAlpha;
	}

	/**
	 * The color of this material.
	 *
	 * @default 0x00
	 */
	public function get color() : Number
	{
		return m_nColor;
	}

	/**
	 * @private
	 */
	public function set alpha( p_nValue:Number ) : Void
	{
		m_nAlpha = p_nValue;
		m_bModified = true;
	}
		
	/**
	 * @private
	 */
	public function set color( p_nValue:Number ) : Void
	{
		m_nColor = p_nValue;
		m_bModified = true;
	}

}