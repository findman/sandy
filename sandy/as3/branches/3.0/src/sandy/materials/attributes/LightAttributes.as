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

package sandy.materials.attributes
{
	import flash.display.Graphics;
	
	import sandy.core.Scene3D;
	import sandy.core.data.Polygon;
	import sandy.core.data.Vector;
	import sandy.core.data.Vertex;
	import sandy.materials.Material;
	
	/**
	 * Holds all light attribute data for a material.
	 *
	 * <p>To make this material attribute use by the Material object, the material must have :myMAterial.lighteningEnable = true.<br />
	 * This attributes contains some parameters</p>
	 * 
	 * @author		Thomas Pfeiffer - kiroukou
	 * @version		3.0
	 * @date 		26.07.2007
	 */
	public final class LightAttributes implements IAttributes
	{
		/**
		 * Flag for lightening mode.
		 * <p>If true, the lit objects use full light range from black to white.<b />
		 * If false (the default) they just range from black to their normal appearance.</p>
		 */
		public var useBright:Boolean = false;
		
		/**
		 * Level of ambient light, added to the scene if lighting is enabled.
		 */
		public var ambient:Number = 0.3;
		// --
		public var modified:Boolean;
		
		/**
		 * Creates a new LineAttributes object.
		 *
		 * @param p_bBright	- default false - The brightness
		 * @param p_nAmbient - default 0 - The ambiant light value
		 */
		public function LightAttributes( p_bBright:Boolean = false, p_nAmbient:Number = 0.3 )
		{
			useBright = p_bBright;
			ambient = p_nAmbient;
			// --
			modified = true;
		}
		
		/**
		 * Draw the attribute onto the graphics object to simulate the flat shading.
		 *  
		 * @param p_oGraphics the Graphics object to draw attributes into
		 * @param p_oPolygon the polygon which is going o be drawn
		 * @param p_oMaterial the refering material
		 * @param p_oScene the scene
		 */
		public function draw( p_oGraphics:Graphics, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D ):void
		{
			if( p_oMaterial.lightingEnable )
			{
				var l_aPoints:Array = (p_oPolygon.isClipped)?p_oPolygon.cvertices : p_oPolygon.vertices;
				var l_oNormal:Vector = p_oPolygon.normal.getVector().clone();
				p_oPolygon.shape.modelMatrix.vectorMult3x3( l_oNormal );
				// --
				var lightStrength:Number = p_oScene.light.calculate( l_oNormal ) + ambient;				
				// --
				if( useBright) 
					p_oGraphics.beginFill( (lightStrength < 0.5) ? 0 : 0xFFFFFF, (lightStrength < 0.5) ? (1-2 * lightStrength) : (2 * lightStrength - 1) );
				else 
					p_oGraphics.beginFill( 0, 1-lightStrength );
				// --
				p_oGraphics.moveTo( l_aPoints[0].sx, l_aPoints[0].sy );
				for each( var l_oVertex:Vertex in l_aPoints )
				{
					p_oGraphics.lineTo( l_oVertex.sx, l_oVertex.sy );
				}
				p_oGraphics.endFill();
				// --
				l_oNormal = null;
				l_oVertex = null;
			}
		}
	}
}
