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
package sandy.materials.attributes
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.geom.ColorTransform;
	import flash.utils.Dictionary;

	import sandy.core.Scene3D;
	import sandy.core.data.Polygon;
	import sandy.core.data.Vector;
	import sandy.core.scenegraph.Sprite2D;
	import sandy.events.SandyEvent;
	import sandy.materials.Material;

	/**
	 * ABSTRACT CLASS - super class for all light attributes.
	 *
	 * <p>This class should not be directly instatiated, but sub classed.<br/>
	 * The ALightAttributes class implements Blinn flavor of Phong reflection model.</p>
	 *
	 * @author		makc
	 * @version		3.0.2
	 * @date 		13.12.2007
	 **/
	public class ALightAttributes implements IAttributes
	{
		/**
		 * Ambient reflection factor.
		 *
		 * <p>Note that since geometry of sprites is unknown, this is going to
		 * be the only lighting setting affecting them, so you would typically
		 * need to set it to bigger value than you would for shapes.</p>
		 * @default 0.3
		 */
		public function get ambient ():Number
		{
			return _ambient;
		}

		/**
		 * @private
		 */
		public function set ambient (p_nAmbient:Number):void
		{
			_ambient = p_nAmbient; onPropertyChange ();
		}

		/**
		 * Diffuse reflection factor.
		 * @default 1.0
		 */
		public function get diffuse ():Number
		{
			return _diffuse;
		}

		/**
		 * @private
		 */
		public function set diffuse (p_nDiffuse:Number):void
		{
			_diffuse = p_nDiffuse; onPropertyChange ();
		}

		/**
		 * Specular reflection factor.
		 * @default 0.0
		 */
		public function get specular ():Number
		{
			return _specular;
		}

		/**
		 * @private
		 */
		public function set specular (p_nSpecular:Number):void
		{
			_specular = p_nSpecular; onPropertyChange ();
		}

		/**
		 * Specular exponent.
		 * @default 5.0
		 */
		public function get gloss ():Number
		{
			return _gloss;
		}

		/**
		 * @private
		 */
		public function set gloss (p_nGloss:Number):void
		{
			_gloss = p_nGloss; onPropertyChange ();
		}

		/**
		 * Override this to respond to property changes.
		 * @private
		 */
		protected function onPropertyChange ():void
		{
			;
		}

		/**
		 * Latest light power.
		 * @private
		 */
		protected var m_nI:Number;

		/**
		 * Latest light direction vector.
		 * @private
		 */
		protected var m_oL:Vector;

		/**
		 * Latest camera direction vector.
		 * @private
		 */
		protected var m_oV:Vector;

		/**
		 * Latest Blinn halfway vector between camera and light.
		 * @private
		 */
		protected const m_oH:Vector = new Vector();

		/**
		 * Calculates the reflection for given normal.
		 * @private
		 */
		protected function calculate (p_oNormal:Vector, p_bFrontside:Boolean, p_bIgnoreSpecular:Boolean = false):Number
		{
			var l_n:Number = p_bFrontside ? -1 : 1;
			var l_k:Number = ambient + diffuse * Math.max (0, l_n * m_oL.dot (p_oNormal));
			if (!p_bIgnoreSpecular && (specular > 0))
			{
				l_k += specular * Math.pow (Math.max (0, l_n * m_oH.dot (p_oNormal)), gloss);
			}
			return l_k * m_nI;
		}

		/**
		* @private
		*/
		public function draw(p_oGraphics:Graphics, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D):void
		{
			if (p_oMaterial.lightingEnable)
			{
				applyColorToDisplayObject (
					p_oPolygon.shape.useSingleContainer ? p_oPolygon.shape.container : p_oPolygon.container,
					p_oScene.light.color, 1
				);
			}
		}

		/**
		* @private
		*/
		public function drawOnSprite( p_oSprite:Sprite2D, p_oMaterial:Material, p_oScene:Scene3D ):void
		{
			if (p_oMaterial.lightingEnable)
			{
				applyColorToDisplayObject (p_oSprite.container, p_oScene.light.color,
					ambient * p_oScene.light.getNormalizedPower ()
				);
			}
		}

		private function applyColorToDisplayObject (s:DisplayObject, c:uint, b:Number):void
		{
			// to avoid color darkening, we will normalize color; pitch-black is "normalized" to white
			if ((c < 1) || (c > 0xFFFFFF))
			{
				c = 0xFFFFFF;
			}
			var rgb_r:Number = (0xFF0000 & c) >> 16;
			var rgb_g:Number = (0x00FF00 & c) >> 8;
			var rgb_b:Number = (0x0000FF & c);

			const bY:Number = b * 1.7321 /*Math.sqrt (3)*/ / Math.sqrt (rgb_r * rgb_r + rgb_g * rgb_g + rgb_b * rgb_b);
			rgb_r *= bY; rgb_g *= bY; rgb_b *= bY;
			const ct:ColorTransform = s.transform.colorTransform;
			if ((ct.redMultiplier != rgb_r) || (ct.greenMultiplier != rgb_g) || (ct.blueMultiplier != rgb_b))
			{
				ct.redMultiplier = rgb_r; ct.greenMultiplier = rgb_g; ct.blueMultiplier = rgb_b;
				s.transform.colorTransform = ct;
			}
		}

		/**
		* @private
		*/
		public function begin( p_oScene:Scene3D ):void
		{
			// fetch light power
			m_nI = p_oScene.light.getNormalizedPower ();

			// fetch light direction vector
			m_oL = p_oScene.light.getDirectionVector ();

			// fetch camera vector
			m_oV = p_oScene.camera.getPosition ("absolute"); m_oV.scale (-1); m_oV.normalize ();

			// compute Blinn halfway vector
			m_oH.copy( m_oL ); m_oH.add (m_oV); m_oH.normalize ();
		}

		/**
		* @private
		*/
		public function finish( p_oScene:Scene3D ):void
		{
			;
		}

		/**
		* @private
		*/
		public function init( p_oPolygon:Polygon ):void
		{
			;// to keep reference to the shapes/polygons that use this attribute
		}

		/**
		* @private
		*/
		public function unlink( p_oPolygon:Polygon ):void
		{
			;// to remove reference to the shapes/polygons that use this attribute
		}

		/**
		* @private
		*/
		public function get flags():uint
		{
			return m_nFlags;
		}

		/**
		* @private
		*/
		protected var m_nFlags:uint = 0;

		// --
		private var _ambient:Number = 0.3;
		private var _diffuse:Number = 1.0;
		private var _specular:Number = 0.0;
		private var _gloss:Number = 5.0;

		private var _scenes:Dictionary = new Dictionary (true);
	}
}