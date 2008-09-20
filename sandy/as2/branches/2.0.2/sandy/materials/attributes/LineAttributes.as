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
import sandy.core.data.Vertex;
import sandy.materials.Material;
import sandy.materials.attributes.AAttributes;
	
/**
 * Holds all line attribute data for a material.
 *
 * <p>Some materials have line attributes to outline the faces of a 3D shape.<br/>
 * In these cases a LineAttributes object holds all line attribute data</p>
 * 
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - xdevltd
 * @version		2.0.2
 * @date 		26.07.2007
 */
	 
class sandy.materials.attributes.LineAttributes extends AAttributes
{

	private var m_nThickness:Number;
	private var m_nColor:Number;
	private var m_nAlpha:Number;

	// --
	/**
	 * Whether the attribute has been modified since it's last render.
	 */
	public var modified:Boolean;
		
	/**
	 * Creates a new LineAttributes object.
	 *
	 * @param p_nThickness	The line thickness.
	 * @param p_nColor		The line color.
	 * @param p_nAlpha		The alpha transparency value of the material.
	 */
	public function LineAttributes( p_nThickness:Number, p_nColor:Number, p_nAlpha:Number )
	{
		m_nThickness = p_nThickness||1;
		m_nAlpha = p_nAlpha||1;
		m_nColor = p_nColor||0;
		// --
		modified = true;
	}
		
	/**
	 * Indicates the alpha transparency value of the line. Valid values are 0 (fully transparent) to 1 (fully opaque).
	 *
	 * @default 1.0
	 */
	public function get alpha() : Number
	{
		return m_nAlpha;
	}
		
	/**
	 * The line color.
	 */
	public function get color() : Number
	{
		return m_nColor;
	}
		
	/**
	 * The line thickness.
	 */	
	public function get thickness() : Number
	{
		return m_nThickness;
	}
		
	/**
	 * @private
	 */
	public function set alpha( p_nValue:Number ) : Void
	{
		m_nAlpha = p_nValue; 
		modified = true;
	}
	
	/**
	 * @private
	 */
	public function set color( p_nValue:Number ) : Void
	{
		m_nColor = p_nValue; 
		modified = true;
	}

	/**
	 * @private
	 */
	public function set thickness( p_nValue:Number ) : Void
	{
		m_nThickness = p_nValue; 
		modified = true;
	}
	
	/**
	 * @private
	 */
	public function draw( p_oMovieClip:MovieClip, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D ) : Void
	{
		var l_aPoints:Array = ( p_oPolygon.isClipped ) ? p_oPolygon.cvertices : p_oPolygon.vertices;
		var l_oVertex:Vertex;
		p_oMovieClip.lineStyle( m_nThickness, m_nColor, m_nAlpha );
		// --
		p_oMovieClip.moveTo( l_aPoints[ 0 ].sx, l_aPoints[ 0 ].sy );
		var lId:Number = l_aPoints.length;
		while( l_oVertex = l_aPoints[ --lId ] )
			p_oMovieClip.lineTo( l_oVertex.sx, l_oVertex.sy );
	}
	
}