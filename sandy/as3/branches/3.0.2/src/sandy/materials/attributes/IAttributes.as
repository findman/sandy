/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author THOMAS PFEIFFER
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
	import sandy.core.scenegraph.Sprite2D;
	import sandy.materials.Material;
	
	/**
	 * Interface for all the elements that represent a material attribute property.
	 * This interface is really important to make the attributes thing really flexible and make users extends it.
	 * 
	 * @param p_oGraphics the Graphics object to draw attributes into
	 * @param p_oPolygon the polygon which is going o be drawn
	 * @param p_oMaterial the refering material
	 * @param p_oScene the scene
	 */
	public interface IAttributes
	{
		function draw( p_oGraphics:Graphics, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D ):void;

		function drawOnSprite( p_oSprite:Sprite2D, p_oMaterial:Material, p_oScene:Scene3D ):void;
		
		function init( p_oPolygon:Polygon ):void;
	
		function unlink( p_oPolygon:Polygon ):void;
		
		function begin( p_oScene:Scene3D ):void;
		
		function finish( p_oScene:Scene3D ):void;	
		
		function get flags():uint;	
	}
}