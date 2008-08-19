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

package sandy.materials.attributes;

import flash.display.Graphics;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

import sandy.core.Scene3D;
import sandy.core.data.Edge3D;
import sandy.core.data.Polygon;
import sandy.core.scenegraph.Sprite2D;
import sandy.materials.Material;

/**
 * Holds all outline attributes data for a material.
 *
 * <p>Each material can have an outline attribute to outline the whole 3D shape.<br/>
 * The OutlineAttributes class stores all the information to draw this outline shape</p>
 * 
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 */
class OutlineAttributes extends AAttributes
{
	private var SHAPE_MAP:Dictionary;
	// --
	private var m_nThickness:Int;
	private var m_nColor:Int;
	private var m_nAlpha:Float;
	// --
	public var modified:Bool;
	
	/**
	 * Creates a new OutlineAttributes object.
	 *
	 * @param p_nThickness	The line thickness - Defaoult 1
	 * @param p_nColor	The line color - Default 0 ( black )
	 * @param p_nAlpha	The alpha value in percent of full opacity ( 0 - 1 )
	 */
	public function new( ?p_nThickness:UInt, ?p_nColor:UInt, ?p_nAlpha:Float )
	{
        if ( p_nThickness == null ) p_nThickness = 1;
        if ( p_nColor == null ) p_nColor = 0;
        if ( p_nAlpha == null ) p_nAlpha = 1;

	    SHAPE_MAP = new Dictionary(true);
		m_nThickness = p_nThickness;
		m_nAlpha = p_nAlpha;
		m_nColor = p_nColor;
		// --
		super();
		modified = true;
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
	public var color(__getColor,__setColor):Int;
	private function __getColor():Int
	{
		return m_nColor;
	}
	
	/**
	 * @private
	 */
	public var thickness(__getThickness,__setThickness):Int;
	private function __getThickness():Int
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
	private function __setColor(p_nValue:Int):Int
	{
		m_nColor = p_nValue; 
		modified = true;
        return p_nValue;
	}

	/**
	 * The line thickness
	 */	
	private function __setThickness(p_nValue:Int):Int
	{
		m_nThickness = p_nValue; 
		modified = true;
        return p_nValue;
	}
	
	/**
	 * Allows to proceed to an initialization
	 * to know when the polyon isn't lined to the material, look at #unlink
	 */
	override public function init( p_oPolygon:Polygon ):Void
	{
		// to keep reference to the shapes/polygons that use this attribute
		// -- attempt to create the neighboors relation between polygons
		if( SHAPE_MAP[p_oPolygon.shape.id] == null )
		{
	        // if this shape hasn't been registered yet, we compute its polygon relation to be able
	        // to draw the outline.
	        var l_aPoly:Array<Polygon> = p_oPolygon.shape.aPolygons;
	        var a:Int = l_aPoly.length, lCount:UInt = 0, i:Int, j:Int;
	        var lP1:Polygon, lP2:Polygon;
	        var l_aEdges:Array<Edge3D>;
	        for( i in 0...(a-1) )
	        {
	        	lP1 = l_aPoly[i];
	        	for( j in (i+1)...a )
		        {
		        	lP2 = l_aPoly[j];
		        	l_aEdges = lP2.aEdges;
		        	// --
		        	lCount = 0;
		        	// -- check if they share at least 2 vertices
		        	for ( l_oEdge in lP1.aEdges )
		        		if( untyped( l_aEdges.indexOf( l_oEdge ) ) > -1 ) lCount += 1;
		        	// --
		        	if( lCount > 0 )
		        	{
		        		lP1.aNeighboors.push( lP2 );
		        		lP2.aNeighboors.push( lP1 );
		        	}
		        }
			}
			// --
			SHAPE_MAP[p_oPolygon.shape.id] = true;
		}
	}

	/**
	 * Remove all the initialization
	 * opposite of init
	 */
	override public function unlink( p_oPolygon:Polygon ):Void
	{
		// to remove reference to the shapes/polygons that use this attribute
		// TODO : can we free the memory of SHAPE_MAP ? Don't think so, and would it be really necessary? not sure either.
	}
	
	/**
	 * Draw the outline edges of the polygon into the graphics object.
	 *  
	 * @param p_oGraphics the Graphics object to draw attributes into
	 * @param p_oPolygon the polygon which is going to be drawn
	 * @param p_oMaterial the refering material
	 * @param p_oScene the scene
	 */
	override public function draw( p_oGraphics:Graphics, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D ):Void
	{
		var l_oEdge:Edge3D;
		var l_oPolygon:Polygon;
		var l_bFound:Bool;
		// --
		p_oGraphics.lineStyle( m_nThickness, m_nColor, m_nAlpha );
		p_oGraphics.beginFill(0);
		// --
		for ( l_oEdge in p_oPolygon.aEdges )
    	{
    		l_bFound = false;
    		// --
    		for ( l_oPolygon in p_oPolygon.aNeighboors )
			{
        		// aNeighboor not visible, does it share an edge?
				// if so, we draw it
				if( untyped( l_oPolygon.aEdges.indexOf( l_oEdge ) ) > -1 )
        		{
					if( l_oPolygon.visible == false )
					{
						p_oGraphics.moveTo( l_oEdge.vertex1.sx, l_oEdge.vertex1.sy );
						p_oGraphics.lineTo( l_oEdge.vertex2.sx, l_oEdge.vertex2.sy );
					}
					l_bFound = true;
				}
   			}
   			// -- if not shared with any neighboor, it is an extremity edge that shall be drawn
   			if( l_bFound == false )
   			{
	   			p_oGraphics.moveTo( l_oEdge.vertex1.sx, l_oEdge.vertex1.sy );
				p_oGraphics.lineTo( l_oEdge.vertex2.sx, l_oEdge.vertex2.sy );
   			}
		}

		p_oGraphics.endFill();
	}

	/**
	 * Outline the sprite. This has to clear any drawing done on sprite container, sorry.
	 *  
	 * @param p_oSprite the Sprite2D object to apply attributes to
	 * @param p_oScene the scene
	 */
	override public function drawOnSprite( p_oSprite:Sprite2D, p_oMaterial:Material, p_oScene:Scene3D ):Void
	{
		var g:Graphics = p_oSprite.container.graphics; g.clear ();
		var r:Rectangle = p_oSprite.container.getBounds (p_oSprite.container);
		g.lineStyle (m_nThickness, m_nColor, m_nAlpha); g.drawRect (r.x, r.y, r.width, r.height);
	}
}

