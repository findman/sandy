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
import sandy.materials.attributes.ALightAttributes;
	
/**
 * Realize a flat shading effect when associated to a material.
 *
 * <p>To make this material attribute use by the Material object, the material must have :myMaterial.lightingEnable = true.<br />
 * This attributes contains some parameters</p>
 * 
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - FFlasher
 * @version		2.0.2
 * @date 		26.07.2007
 */
	 
class sandy.materials.attributes.LightAttributes extends ALightAttributes
{
		
	/**
	 * Flag for lighting mode.
	 * <p>If true, the lit objects use full light range from black to white. If false (the default) they range from black to their normal appearance.</p>
	 */
	public var useBright:Boolean = false;
		
	/**
	 * Creates a new LightAttributes object.
	 *
	 * @param p_bBright		The brightness (value for useBright).
	 * @param p_nAmbient	The ambient light value. A value between O and 1 is expected.
	 */
	public function LightAttributes( p_bBright:Boolean, p_nAmbient:Number )
	{
		useBright = p_bBright||false;
		ambient = Math.min( Math.max( p_nAmbient||0.3, 0 ), 1 );
	}
	
	/**
	* @private
	*/
	public function draw( p_oMovieClip:MovieClip, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D ) : Void
	{
		super.draw( p_oMovieClip, p_oPolygon, p_oMaterial, p_oScene );

		if( p_oMaterial.lightingEnable )
		{	
			var l_aPoints:Array = ( p_oPolygon.isClipped ) ? p_oPolygon.cvertices : p_oPolygon.vertices;
			var l_oNormal:Vector = p_oPolygon.normal.getVector();
			// --
			var lightStrength:Number = calculate( l_oNormal, p_oPolygon.visible );
			if( lightStrength > 1 ) lightStrength = 1; else if( lightStrength < ambient ) lightStrength = ambient;
			// --
			p_oMovieClip.lineStyle();
			if( useBright ) 
				p_oMovieClip.beginFill( ( lightStrength < 0.5 ) ? 0 : 0xFFFFFF, ( lightStrength < 0.5 ) ? ( 1 - 2 * lightStrength ) : ( 2 * lightStrength - 1 ) );
			else 
				p_oMovieClip.beginFill( 0, 1 - lightStrength );
			// --
			p_oMovieClip.moveTo( Vertex( l_aPoints[0] ).sx, Vertex( l_aPoints[0] ).sy );
			for( l_oVertex in l_aPoints )
			{
				p_oMovieClip.lineTo( l_aPoints[l_oVertex].sx, l_aPoints[l_oVertex].sy );
			}
			p_oMovieClip.endFill();
			// --
			l_oNormal = null;
			l_oVertex = null;
		}
	}
	
}