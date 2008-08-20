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

import com.bourre.data.collections.Map;

import flash.geom.Rectangle;
	
import sandy.core.Scene3D;
import sandy.core.data.Edge3D;
import sandy.core.data.Polygon;
import sandy.core.data.Vertex;
import sandy.core.scenegraph.Sprite2D;
import sandy.materials.Material;
import sandy.materials.attributes.AAttributes;
	
/**
 * Holds all outline attributes data for a material.
 *
 * <p>Each material can have an outline attribute to outline the whole 3D shape.<br/>
 * The OutlineAttributes class stores all the information to draw this outline shape</p>
 * 
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - FFlasher
 * @version		2.0.2
 * @date 		09.09.2007
 */
	 
class sandy.materials.attributes.OutlineAttributes extends AAttributes
{

	private var SHAPE_MAP:Map;
	// --
	private var m_nThickness:Number;
	private var m_nColor:Number;
	private var m_nAlpha:Number;
	// --
	private var m_nAngleThreshold:Number = 181;
	// --
	/**
	 * Whether the attribute has been modified since it's last render.
	 */
	public var modified:Boolean;
		
	/**
	 * Creates a new OutlineAttributes object.
	 *
	 * @param p_nThickness	The line thickness.
	 * @param p_nColor		The line color.
	 * @param p_nAlpha		The alpha transparency value of the material.
	 */
	public function OutlineAttributes( p_nThickness:Number, p_nColor:Number, p_nAlpha:Number )
	{
		m_nThickness = int( p_nThickness||1 );
		m_nAlpha = p_nAlpha||1;
		m_nColor = int( p_nColor||0 );
		// --
		modified = true;
		SHAPE_MAP = new Map();
	}
		
	/**
	 * Indicates the alpha transparency value of the outline. Valid values are 0 (fully transparent) to 1 (fully opaque).
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
	 * The angle threshold. Attribute will additionally draw edges between faces that form greater angle than this value.
	 */	
	public function get angleThreshold() : Number
	{
		return m_nAngleThreshold;
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
	public function set angleThreshold( p_nValue:Number ) : Void
	{
		m_nAngleThreshold = p_nValue;
	}

	/**
	 * @private
	 */
	public function init( p_oPolygon:Polygon ) : Void
	{
		;// to keep reference to the shapes/polygons that use this attribute
		// -- attempt to create the neighboors relation between polygons
		if( SHAPE_MAP.get( p_oPolygon.shape.id ) == null )
		{
			// if this shape hasn't been registered yet, we compute its polygon relation to be able
			// to draw the outline.
			var l_aPoly:Array = p_oPolygon.shape.aPolygons;
			var a:Number = l_aPoly.length, lCount:Number = 0, i:Number, j:Number;
			var lP1:Polygon, lP2:Polygon;
			var l_aEdges:Array;
			// if any of polygons of this shape have neighbour information, do not re-calculate it
			var l_bNoInfo:Boolean = true;
			for( i = 0; i < a; i++ )
			{
				if ( l_aPoly[i].aNeighboors.length > 0 )
					l_bNoInfo = false;
			}
			if( l_bNoInfo )
			{
				for( i = 0; i < a - 1; i+=1 )
				{
					lP1 = l_aPoly[ int(i) ];
					for( j = i + 1; j < a; j++ )
					{
						lP2 = l_aPoly[ int(j) ];
						l_aEdges = lP2.aEdges;
						// --
						lCount = 0;
						// -- check if they share at least 2 vertices
						for( l_oEdge in lP1.aEdges )
							if( l_aEdges.indexOf( lP1.aEdges[l_oEdge] ) > -1 ) lCount ++;
						// --
						if( lCount > 0 )
						{
							lP1.aNeighboors.push( lP2 );
							lP2.aNeighboors.push( lP1 );
						}
					}
				}
			}
			// --
			SHAPE_MAP.put( p_oPolygon.shape.id, true );
		}
	}
	
	/**
	 * @private
	 */
	public function unlink( p_oPolygon:Polygon ) : Void
	{
		;// to remove reference to the shapes/polygons that use this attribute
		// TODO : can we free the memory of SHAPE_MAP ? Don't think so, and would it be really necessary? not sure either.
	}
	
	/**
	 * @private
	 */
	public function draw( p_oMovieClip:MovieClip, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D ) : Void
	{
		var l_oEdge:Edge3D;
		var l_oPolygon:Polygon;
		var l_bFound:Boolean;
		var l_bVisible:Boolean = p_oPolygon.visible;
		// --
		var l_oNormal:Vertex;
		var l_nDotThreshold:Number;
		if( m_nAngleThreshold < 180 )
		{
			l_oNormal = p_oPolygon.normal;
			l_nDotThreshold = Math.cos( m_nAngleThreshold * 0.017453292519943295769236907684886 /* Math.PI / 180 */ );
		}
		// --
		p_oMovieClip.lineStyle( m_nThickness, m_nColor, m_nAlpha );
		p_oMovieClip.beginFill(0);
		// --
		for( l_oEdge in p_oPolygon.aEdges )
		{
			l_bFound = false;
			l_oEdge = p_oPolygon.aEdges[l_oEdge];
			// --
			for( l_oPolygon in p_oPolygon.aNeighboors )
			{
				// aNeighboor not visible, does it share an edge?
				// if so, we draw it
				l_oPolygon = p_oPolygon.aNeighboors[l_oPolygon];
				if( l_oPolygon.aEdges.indexOf( l_oEdge ) > -1 )
				{
					if( ( l_oPolygon.visible != l_bVisible ) ||
						( ( m_nAngleThreshold < 180 ) && ( l_oNormal.dot ( l_oPolygon.normal ) < l_nDotThreshold ) ) )
					{
						p_oMovieClip.moveTo( l_oEdge.vertex1.sx, l_oEdge.vertex1.sy );
						p_oMovieClip.lineTo( l_oEdge.vertex2.sx, l_oEdge.vertex2.sy );
					}
					l_bFound = true;
				}
			}
			// -- if not shared with any neighboor, it is an extremity edge that shall be drawn
			if( l_bFound == false )
			{
				p_oMovieClip.moveTo( l_oEdge.vertex1.sx, l_oEdge.vertex1.sy );
				p_oMovieClip.lineTo( l_oEdge.vertex2.sx, l_oEdge.vertex2.sy );
			}
		}
			
		p_oMovieClip.endFill();
	}

	/**
	 * @private
	 */
	public function drawOnSprite( p_oSprite:Sprite2D, p_oMaterial:Material, p_oScene:Scene3D ) : Void
	{
		var g:MovieClip = p_oSprite.container; g.clear();
		var r:Rectangle = p_oSprite.container.getBounds( p_oSprite.container );
		g.lineStyle( m_nThickness, m_nColor, m_nAlpha ); g.drawRect( r.x, r.y, r.width, r.height );
	}
	
}