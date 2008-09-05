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
import sandy.core.data.Vertex;
import sandy.materials.Material;

/**
 * Holds all line attribute data for a material.
 *
 * <p>Some materials have line attributes to outline the faces of a 3D shape.<br/>
 * In these cases a LineAttributes object holds all line attribute data</p>
 * 
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 */
class LineAttributes extends AAttributes
{
	private var m_nThickness:Float;
	private var m_nColor:UInt;
	private var m_nAlpha:Float;
	// --
	public var modified:Bool;
	
	/**
	 * Creates a new LineAttributes object.
	 *
	 * @param p_nThickness	The line thickness - Defaoult 1
	 * @param p_nColor	The line color - Defaoult 0 ( black )
	 * @param p_nAlpha	The alpha value in percent of full opacity ( 0 - 1 )
	 */
	public function new( ?p_nThickness:Float, ?p_nColor:UInt, ?p_nAlpha:Float )
	{
		if ( p_nThickness == null ) p_nThickness = 1;
		if ( p_nColor == null ) p_nColor = 0;
		if ( p_nAlpha == null ) p_nAlpha = 1;

		m_nThickness = p_nThickness;
		m_nAlpha = p_nAlpha;
		m_nColor = p_nColor;
		// --
		modified = true;

		super();
	}
	
	/**
	 * @private
	 */
	public var alpha(__getAlpha,__setAlpha):Float;
	private function __getAlpha():Float
	{
		return m_nAlpha;
	}
	
	/**
	 * @private
	 */
	public var color(__getColor,__setColor):UInt;
	private function __getColor():UInt
	{
		return m_nColor;
	}
	
	/**
	 * @private
	 */
	public var thickness(__getThickness,__setThickness):Float;
	private function __getThickness():Float
	{
		return m_nThickness;
	}
	
	/**
	 * The alpha value for the lines ( 0 - 1 )
	 *
	 * Alpha = 0 means fully transparent, alpha = 1 fully opaque.
	 */
	private function __setAlpha(p_nValue:Float):Float
	{
		m_nAlpha = p_nValue; 
		modified = true;
		return p_nValue;
	}
	
	/**
	 * The line color
	 */
	private function __setColor(p_nValue:UInt):UInt
	{
		m_nColor = p_nValue; 
		modified = true;
		return p_nValue;
	}

	/**
	 * The line thickness
	 */	
	private function __setThickness(p_nValue:Float):Float
	{
		m_nThickness = p_nValue; 
		modified = true;
		return p_nValue;
	}

	/**
	 * Draw the edges of the polygon into the graphics object.
	 *  
	 * @param p_oGraphics the Graphics object to draw attributes into
	 * @param p_oPolygon the polygon which is going to be drawn
	 * @param p_oMaterial the referring material
	 * @param p_oScene the scene
	 */
	override public function draw( p_oGraphics:Graphics, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D ):Void
	{
		var l_aPoints:Array<Vertex> = (p_oPolygon.isClipped)?p_oPolygon.cvertices : p_oPolygon.vertices;
		var l_oVertex:Vertex;
		p_oGraphics.lineStyle( m_nThickness, m_nColor, m_nAlpha );
		// --
		p_oGraphics.moveTo( l_aPoints[0].sx, l_aPoints[0].sy );
		var lId:Int = l_aPoints.length;
		while( (l_oVertex = l_aPoints[ --lId ]) != null ) {
			p_oGraphics.lineTo( l_oVertex.sx, l_oVertex.sy );
		}
	}
}

