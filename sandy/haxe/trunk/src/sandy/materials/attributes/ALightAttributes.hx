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

# ***** END LICENSE BLOCK ******/

package sandy.materials.attributes;

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
import sandy.math.ColorMath;

/**
 * ABSTRACT CLASS - super class for all light attributes.
 *
 * <p> This class should not be directly instatiated, but sub classed.<br/>
 * The ALightAttributes class implements Blinn flavor of Phong reflection model.</p>
 *
 * @author		makc
 * @author Niel Drummond - haXe port 
 * 
 * 
 **/
class ALightAttributes implements IAttributes
{
	public function new () {
	 m_oH = new Vector();

	 m_nFlags = 0;
	 _ambient = 0.3;
	 _diffuse = 1.0;
	 _specular = 0.0;
	 _gloss = 5.0;
	 _scenes = new Dictionary (true);
	}
	/**
	 * Ambient reflection factor.
	 *
	 * <p>Note that since geometry of sprites is unknown, this is going to
	 * be the only lighting setting affecting them, so you would typically
	 * need to set it to bigger value than you would for shapes.</p>
	 * @default 0.3
	 */
	public var ambient (__getAmbient,__setAmbient):Float;
	private function __getAmbient ():Float
	{return _ambient;}

	/**
	 *
	 * @private
	 */
	private function __setAmbient (p_nAmbient:Float):Float
	{
		_ambient = p_nAmbient; onPropertyChange (); return p_nAmbient;
	}

	/**
	 * Diffuse reflection factor.
	 * @default 1.0
	 */
	public var diffuse (__getDiffuse,__setDiffuse):Float;
	private function __getDiffuse ():Float
	{return _diffuse;}

	/**
	 * @private
	 */
	private function __setDiffuse (p_nDiffuse:Float):Float
	{
		_diffuse = p_nDiffuse; onPropertyChange (); return p_nDiffuse;
	}

	/**
	 * Specular reflection factor.
	 * @default 0.0
	 */
	public var specular (__getSpecular,__setSpecular):Float;
	private function __getSpecular ():Float
	{return _specular;}

	/**
	 * @private
	 */
	private function __setSpecular (p_nSpecular:Float):Float
	{
		_specular = p_nSpecular; onPropertyChange (); return p_nSpecular;
	}

	/**
	 * Specular exponent.
	 * @default 5.0
	 */
	public var gloss (__getGloss,__setGloss):Float;
	private function __getGloss ():Float
	{return _gloss;}

	/**
	 * @private
	 */
	private function __setGloss (p_nGloss:Float):Float
	{
		_gloss = p_nGloss; onPropertyChange (); return p_nGloss;
	}

	/**
	 * Override this to respond to property changes.
	 */
	private function onPropertyChange ():Void
	{
	}
	
	/**
	 * Latest light power.
	 */
	private var m_nI:Float;
	
	/**
	 * Latest light direction vector.
	 */
	private var m_oL:Vector;

	/**
	 * Latest camera direction vector.
	 */
	private var m_oV:Vector;

	/**
	 * Latest Blinn halfway vector between camera and light.
	 */
	private var m_oH:Vector;

	/**
	 * Calculates the reflection for given normal.
	 */
	private function calculate (p_oNormal:Vector, p_bFrontside:Bool, ?p_bIgnoreSpecular:Bool):Float
	{
		if ( p_bIgnoreSpecular == null ) p_bIgnoreSpecular = false;

		var l_n:Int = p_bFrontside ? -1 : 1;
		var l_k:Float = ambient + diffuse * Math.max (0, l_n * m_oL.dot (p_oNormal));
		if (!p_bIgnoreSpecular && (specular > 0))
			l_k += specular * Math.pow (Math.max (0, l_n * m_oH.dot (p_oNormal)), gloss);
		return l_k * m_nI;
	}
	
	/**
	 * This method applies light color to polygon containers.
	 * Always call super.draw() when you override it.
	 */
	public function draw(p_oGraphics:Graphics, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D):Void
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
	 * This method applies light color to sprite containers.
	 * You will hardly ever need to override it.
	 */
	public function drawOnSprite( p_oSprite:Sprite2D, p_oMaterial:Material, p_oScene:Scene3D ):Void
	{
		if (p_oMaterial.lightingEnable)
		{
			applyColorToDisplayObject (p_oSprite.container, p_oScene.light.color,
				ambient * p_oScene.light.getNormalizedPower ()
			);
		}
	}

	private function applyColorToDisplayObject (s:DisplayObject, c:UInt, b:Float):Void
	{
		// to avoid color darkening, we will normalize color; pitch-black is "normalized" to white
		if ((c < 1) || (c > 0xFFFFFF)) c = 0xFFFFFF;
		var rgb:Dynamic = ColorMath.hex2rgb (c);
		var bY:Float = b * Math.sqrt (3) / Math.sqrt (rgb.r * rgb.r + rgb.g * rgb.g + rgb.b * rgb.b);
		rgb.r *= bY; rgb.g *= bY; rgb.b *= bY;
		var ct:ColorTransform = s.transform.colorTransform;
		if ((ct.redMultiplier != rgb.r) || (ct.greenMultiplier != rgb.g) || (ct.blueMultiplier != rgb.b))
		{
			ct.redMultiplier = rgb.r; ct.greenMultiplier = rgb.g; ct.blueMultiplier = rgb.b;
			s.transform.colorTransform = ct;
		}
	}

	/**
	 * Method called before the display list rendering.
	 * This is the common place for this attribute to precompute things
	 */
	public function begin( p_oScene:Scene3D ):Void
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
	 * Method called right after the display list rendering
	 * This is the place to remove and dispose memory if necessary.
	 */
	public function finish( p_oScene:Scene3D ):Void
	{
	}
	
	/**
	 * Allows to proceed to an initialization
	 * to know when the polyon isn't lined to the material, look at #unlink
	 */
	public function init( p_oPolygon:Polygon ):Void
	{
	}

	/**
	 * Remove all the initialization
	 * opposite of init
	 */
	public function unlink( p_oPolygon:Polygon ):Void
	{
	}
	
	/**
	 * Returns the specific flags of this attribute.
	 */
	public var flags(__getFlags,null):Null<UInt>;
	private function __getFlags():Null<UInt>
	{ return m_nFlags; }
	
	private var m_nFlags:Null<UInt>;
	
	// --
	private var _ambient:Float;
	private var _diffuse:Float;
	private var _specular:Float;
	private var _gloss:Float;
	
	private var _scenes:Dictionary;
}

