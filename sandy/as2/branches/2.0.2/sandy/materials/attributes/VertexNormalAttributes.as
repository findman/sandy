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
import sandy.materials.attributes.LineAttributes;
	
/**
 * Display the vertex normals of a given object.
 *
 * <p>Developed originally for a debug purpose, this class allows you to create some
 * special effects, displaying the normal of each vertex.</p>
 * 
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - FFlasher
 * @version		2.0.2
 * @date 		26.07.2007
 */
 
class sandy.materials.attributes.VertexNormalAttributes extends LineAttributes
{

	private var m_nLength:Number;
		
	/**
	 * Creates a new VertexNormalAttributes object.
	 *
	 * @param p_nLength		The length of the segment.
	 * @param p_nThickness	The line thickness.
	 * @param p_nColor		The line color.
	 * @param p_nAlpha		The alpha transparency value of the material.
	 */
	public function VertexNormalAttributes( p_nLength:Number = 10, p_nThickness:Number, p_nColor:Number, p_nAlpha:Number )
	{
		m_nLength = p_nLength||10;
		// reuse LineAttributes setters
		thickness = int( p_nThickness||1 );
		alpha = p_nAlpha||1;
		color = int( p_nColor||0 );
		// --
		modified = true;
	}
	
	/**
	 * The line length.
	 */
	public function get length() : Number
	{
		return m_nLength;
	}
		
	/**
	 * @private
	 */
	public function set length( p_nValue:Number ) : Void
	{
		m_nLength = p_nValue; 
		modified = true;
	}
		
	/**
	 * @private
	 */
	public function draw( p_oMovieClip:MovieClip, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D ) : Void
	{
		var l_aPoints:Array = p_oPolygon.vertices;
		var l_oVertex:Vertex;
		// --
		p_oMovieClip.lineStyle( thickness, color, alpha );
		p_oMovieClip.beginFill( 0 );
		// --
		var lId:Number = l_aPoints.length;
		while( l_oVertex = l_aPoints[ --lId ] )
		{
			var l_oDiff:Vector = p_oPolygon.vertexNormals[ lId ].getVector().clone();
			p_oPolygon.shape.viewMatrix.vectorMult3x3( l_oDiff );
			// --
			l_oDiff.scale( m_nLength );
			// --
			var l_oNormal:Vertex = Vertex.createFromVector( l_oDiff );
			l_oNormal.add( l_oVertex );
			// --
			p_oScene.camera.projectVertex( l_oNormal );
			// --
			p_oMovieClip.moveTo( l_oVertex.sx, l_oVertex.sy );
			p_oMovieClip.lineTo( l_oNormal.sx, l_oNormal.sy );
			// --
			l_oNormal = null;
			l_oDiff = null;
		}
		// --
		p_oMovieClip.endFill();
	}
	
	/**
	 * @private
	 */
	public function begin( p_oScene:Scene3D ) : Void
	{
		; // TODO, do the normal projection here
	}
	
}