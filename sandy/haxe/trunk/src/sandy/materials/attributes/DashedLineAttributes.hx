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
import sandy.core.data.Vector;
import flash.media.Camera;
import sandy.core.scenegraph.Camera3D;

/**
 * Holds all new line style Attributes data for a material.
 *
 * 
 * @author		Max Pellizzaro
 * @author Niel Drummond - haXe port 
 * 
 * 
 */
class DashedLineAttributes extends LineAttributes
{
	 private var thisLenght:Float;
	 private var thisGap:Float;
	 
	
	/**
	 * Creates a new LineAStyleAttributes object.
	 *
	 * @param p_nThickness	The line thickness - Defaoult 1
	 * @param p_nColor	The line color - Defaoult 0 ( black )
	 * @param p_nAlpha	The alpha value in percent of full opacity ( 0 - 1 )
	 * @param p_style		The Style you want to use
	 */
	public function new( ?p_nThickness:UInt, ?p_nColor:UInt, ?p_nAlpha:Float, ?p_lenght:Float, ?p_gap:Float )
	{

        if( p_nThickness == null ) p_nThickness = 1;
        if( p_nColor == null ) p_nColor = 0;
        if ( p_nAlpha == null ) p_nAlpha = 1;
        if ( p_lenght == null ) p_lenght = 10;
        if ( p_gap == null ) p_gap = 10;

		super(p_nThickness,p_nColor,p_nAlpha);
		thisLenght = p_lenght;
		thisGap = Math.abs( p_gap );
	}
	
	
	/**
	 * Draw the edges of the polygon into the graphics object.
	 *  
	 * @param p_oGraphics the Graphics object to draw attributes into
	 * @param p_oPolygon the polygon which is going o be drawn
	 * @param p_oMaterial the refering material
	 * @param p_oScene the scene
	 *
	 */
	override public function draw( p_oGraphics:Graphics, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D ):Void
	{
		var l_aPoints:Array<Vertex> = (p_oPolygon.isClipped)?p_oPolygon.cvertices : p_oPolygon.vertices;
		var l_nLength:Int = l_aPoints.length;
		var l_oVertex:Vertex;
		p_oGraphics.lineStyle( this.thickness, this.color, this.alpha );
		// --
		p_oGraphics.beginFill(0);
					
		for( l_nId in 0...l_nLength )
		{
			var l_nNext:Int = (l_nId+1) % l_nLength;
			// --
			if(  thisGap != 0 )
			{
				dashTo(p_oGraphics, p_oScene.camera, l_aPoints[l_nId], l_aPoints[l_nNext], thisLenght, thisGap); 
			}
		  	else
		  	{
		  		p_oGraphics.moveTo( l_aPoints[l_nId].sx, l_aPoints[l_nId].sy );
		  		p_oGraphics.lineTo( l_aPoints[l_nNext].sx, l_aPoints[l_nNext].sy );
		  	}
		}
		p_oGraphics.endFill();
	}
	
       
   private function dashTo(p_oGraphics:Graphics, p_oCamera:Camera3D, p_oStart:Vertex, p_oEnd:Vertex, len:Float, gap:Float):Void 
   {
		// len = length of dash
		// gap = length of gap between dashes
		 
		// init vars
		var seglength:Float, l_oDelta:Vector, l_oCurrent:Vertex = p_oStart.clone(), l_oDeltaNorm:Float, segs:Int, cx:Float, cy:Float;
		
		// calculate the length of the dashed line
		l_oDelta = new Vector( p_oEnd.wx - p_oStart.wx, p_oEnd.wy - p_oStart.wy, p_oEnd.wz - p_oStart.wz );
		l_oDeltaNorm = l_oDelta.getNorm();
		
		var l_oDir:Vector = l_oDelta.clone();
		l_oDir.normalize();
		
		// calculate the legnth of a segment
		seglength = ( len + gap ) ;//* l_oDir.getNorm();
		
		// calculate the number of segments needed
		segs = Std.int( Math.abs( Math.floor( l_oDeltaNorm / seglength ) ) );
		
		// start the line here
		cx = p_oStart.sx;
		cy = p_oStart.sy;
		
		// loop through each seg
		for ( n in 1...(segs-1) ) 
		{
			// do interpolation
			l_oCurrent.wx += l_oDir.x * seglength;
			l_oCurrent.wy += l_oDir.y * seglength;
			l_oCurrent.wz += l_oDir.z * seglength;
			// --
			p_oGraphics.moveTo(cx,cy);
			// --- do projection
			p_oCamera.projectVertex( l_oCurrent );
			cx = l_oCurrent.sx;
			cy = l_oCurrent.sy;
			// -- do draw
			p_oGraphics.lineTo( cx, cy );
			// -- process gap
			l_oCurrent.wx += l_oDir.x * gap;
			l_oCurrent.wy += l_oDir.y * gap;
			l_oCurrent.wz += l_oDir.z * gap;
			p_oCamera.projectVertex( l_oCurrent );
			cx = l_oCurrent.sx;
			cy = l_oCurrent.sy;
		}

		l_oCurrent.wx += l_oDir.x * seglength;
		l_oCurrent.wy += l_oDir.y * seglength;
		l_oCurrent.wz += l_oDir.z * seglength;
		p_oCamera.projectVertex( l_oCurrent );
		
		l_oDelta.x = p_oEnd.wx - l_oCurrent.wx;
		l_oDelta.y = p_oEnd.wy - l_oCurrent.wy;
		l_oDelta.z = p_oEnd.wz - l_oCurrent.wz;
		
		// handle last segment as it is likely to be partial
		l_oDeltaNorm = l_oDelta.getNorm();
		if(l_oDeltaNorm>len)
		{
			// segment ends in the gap, so draw a full dash
			p_oGraphics.moveTo(cx,cy);
			// --- do projection
			cx = l_oCurrent.sx;
			cy = l_oCurrent.sy;
			p_oGraphics.lineTo( cx, cy );
		} 
		else if(l_oDeltaNorm>0) 
		{
			p_oGraphics.moveTo(cx,cy);
			// segment is shorter than dash so only draw what is needed
			p_oGraphics.lineTo( p_oEnd.sx, p_oEnd.sy );
		}
		// move the pen to the end position
		//p_oGraphics.moveTo( p_oEnd.sx, p_oEnd.sy );
   }
}

