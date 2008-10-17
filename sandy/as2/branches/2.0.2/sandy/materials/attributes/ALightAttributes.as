/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author or authors.
Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 ( the "License" );
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

import flash.geom.ColorTransform;

import sandy.core.SandyFlags;
import sandy.core.Scene3D;
import sandy.core.data.Matrix4;
import sandy.core.data.Polygon;
import sandy.core.data.Vector;
import sandy.core.scenegraph.Shape3D;
import sandy.core.scenegraph.Sprite2D;
import sandy.events.SandyEvent;
import sandy.materials.Material;
import sandy.materials.attributes.IAttributes;

/**
 * ABSTRACT CLASS - super class for all light attributes.
 *
 * <p>This class should not be directly instatiated, but sub classed.<br/>
 * The ALightAttributes class implements Blinn flavor of Phong reflection model.</p>
 *
 * @author		makc
 * @author		(porting) Floris - xdevltd
 * @version		2.0.2
 * @date 		13.12.2007
 */
	 
class sandy.materials.attributes.ALightAttributes implements IAttributes
{
	
	/**
	 * Defines the vectors m_oH, m_oCurrentL, m_oCurrentV, m_oCurrentH and the map _scenes.
	 */
	public function ALightAttributes() 
	{
		m_oH = new Vector();
		m_oCurrentL = new Vector();
		m_oCurrentV = new Vector();
		m_oCurrentH = new Vector;
		_scenes = new Map();
	}
	
	/**
	 * Ambient reflection factor.
	 *
	 * <p>Note that since geometry of sprites is unknown, this is going to
	 * be the only lighting setting affecting them, so you would typically
	 * need to set it to bigger value than you would for shapes.</p>
	 * @default 0.3
	 */
	public function get ambient() : Number
	{
		return _ambient;
	}

	/**
	 * @private
	 */
	public function set ambient( p_nAmbient:Number ) : Void
	{
		_ambient = p_nAmbient; onPropertyChange();
	}

	/**
	 * Diffuse reflection factor.
	 * @default 1.0
	 */
	public function get diffuse () : Number
	{
		return _diffuse;
	}

	/**
	 * @private
	 */
	public function set diffuse( p_nDiffuse:Number ) : Void
	{
		_diffuse = p_nDiffuse; onPropertyChange();
	}

	/**
	 * Specular reflection factor.
	 * @default 0.0
	 */
	public function get specular() : Number
	{
		return _specular;
	}

	/**
	 * @private
	 */
	public function set specular( p_nSpecular:Number ) : Void
	{
		_specular = p_nSpecular; onPropertyChange();
	}

	/**
	 * Specular exponent.
	 * @default 5.0
	 */
	public function get gloss() : Number
	{
		return _gloss;
	}

	/**
	 * @private
	 */
	public function set gloss( p_nGloss:Number ) : Void
	{
		_gloss = p_nGloss; onPropertyChange();
	}

	/**
	 * Override this to respond to property changes.
	 * @private
	 */
	private function onPropertyChange() : Void
	{
		;
	}

	/**
	 * Latest light power.
	 * @private
	 */
	private var m_nI:Number;

	/**
	 * Latest light direction vector.
	 * @private
	 */
	private var m_oL:Vector;

	/**
	 * Latest camera direction vector.
	 * @private
	 */
	private var m_oV:Vector;

	/**
	 * Latest Blinn halfway vector between camera and light.
	 * @private
	 */
	private var m_oH:Vector;   

	/**
	 * Calculates the reflection for given normal.
	 * @private
	 */
	private function calculate( p_oNormal:Vector, p_bFrontside:Boolean, p_bIgnoreSpecular:Boolean ) : Number
	{
		var l_n:Number = p_bFrontside ? -1:1;
		var l_k:Number = l_n * m_oCurrentL.dot( p_oNormal ); if( l_k < 0 ) l_k = 0; l_k = _ambient + _diffuse * l_k;
		if( !p_bIgnoreSpecular && ( specular > 0 ) )
		{
			var l_s:Number = l_n * m_oCurrentH.dot( p_oNormal ); if( l_s < 0 ) l_s = 0;
			l_k += _specular * Math.pow( l_s, _gloss );
		}
		return l_k * m_nI;
	}

	/**
	 * @private
	 */
	private var m_oCurrentL:Vector;  
	/**
	 * @private
	 */
	private var m_oCurrentV:Vector; 
	/**
	 * @private
	 */
	private var m_oCurrentH:Vector;
	/**
	 * @private
	 */
	private var m_oCurrentShape:Shape3D;

	/**
	* Draws light on shape.
	*/
	public function draw( p_oMovieClip:MovieClip, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D ) : Void
	{
		if( p_oMaterial.lightingEnable )
		{
			applyColorToDisplayObject( p_oPolygon.shape.useSingleContainer ? p_oPolygon.shape.container : p_oPolygon.container, p_oScene.light.color, 1 );

			// compute local versions of vectors
			if( m_oCurrentShape != p_oPolygon.shape )
			{
				m_oCurrentShape = p_oPolygon.shape;

				var invModelMatrix:Matrix4 = m_oCurrentShape.invModelMatrix;

				if( m_oL )
				{
					m_oCurrentL.copy( m_oL );
					invModelMatrix.vectorMult3x3( m_oCurrentL );
				}
				if( m_oV )
				{
					m_oCurrentV.copy( m_oV );
					invModelMatrix.vectorMult3x3( m_oCurrentV );
				}
				if( m_oH )
				{
					m_oCurrentH.copy( m_oH );
					invModelMatrix.vectorMult3x3( m_oCurrentH );
				}
			}
		}
	}

	/**
	* Draws light on sprite.
	*/
	public function drawOnSprite( p_oSprite:Sprite2D, p_oMaterial:Material, p_oScene:Scene3D ) : Void
	{
		if( p_oMaterial.lightingEnable )
		{
			applyColorToDisplayObject( p_oSprite.container, p_oScene.light.color,
				ambient * p_oScene.light.getNormalizedPower ()
			 );
		}
	}

	private function applyColorToDisplayObject( s:MovieClip, c:Number, b:Number ) : Void
	{
		// to avoid color darkening, we will normalize color; pitch-black is "normalized" to white
		if( ( c < 1 ) || ( c > 0xFFFFFF ) )
		{
			c = 0xFFFFFF;
		}
		var rgb_r:Number = ( 0xFF0000 & c ) >> 16;
		var rgb_g:Number = ( 0x00FF00 & c ) >> 8;
		var rgb_b:Number = ( 0x0000FF & c );

		var bY:Number = b * 1.7321 /*Math.sqrt ( 3 )*/ / Math.sqrt( rgb_r * rgb_r + rgb_g * rgb_g + rgb_b * rgb_b );
		rgb_r *= bY; rgb_g *= bY; rgb_b *= bY;
		var ct:ColorTransform = s.transform.colorTransform;
		if( ( ct.redMultiplier != rgb_r ) || ( ct.greenMultiplier != rgb_g ) || ( ct.blueMultiplier != rgb_b ) )
		{
			ct.redMultiplier = rgb_r; ct.greenMultiplier = rgb_g; ct.blueMultiplier = rgb_b;
			s.transform.colorTransform = ct;
		}
	}

	/**
	* @private
	*/
	public function begin( p_oScene:Scene3D ) : Void
	{
		// fetch light power
		m_nI = p_oScene.light.getNormalizedPower();

		// fetch light direction vector
		m_oL = p_oScene.light.getDirectionVector();

		// fetch camera vector
		m_oV = p_oScene.camera.getPosition( "absolute" ); m_oV.scale( -1 ); m_oV.normalize ();

		// compute Blinn halfway vector
		m_oH.copy( m_oL ); m_oH.add( m_oV ); m_oH.normalize();

		// clear current shape reference
		m_oCurrentShape = null;

		// init local vectors to any valid values
		m_oCurrentL.copy( m_oL ); m_oCurrentV.copy( m_oV ); m_oCurrentH.copy( m_oH );
	}

	/**
	* @private
	*/
	public function finish( p_oScene:Scene3D ) : Void
	{
		;
	}

	/**
	* @private
	*/
	public function init( p_oPolygon:Polygon ) : Void
	{
		;// to keep reference to the shapes/polygons that use this attribute
	}

	/**
	* @private
	*/
	public function unlink( p_oPolygon:Polygon ) : Void
	{
		;// to remove reference to the shapes/polygons that use this attribute
		if( m_oCurrentShape == p_oPolygon.shape )
		{
			m_oCurrentShape = null;
		}
	}

	/**
	* Flags for the attribute.
	*/
	public function get flags() : Number
	{
		return int( m_nFlags );
	}

	/**
	* @private
	*/
	private var m_nFlags:Number = 0;//SandyFlags.INVERT_MODEL_MATRIX;

	// --
	private var _ambient:Number = 0.3;
	private var _diffuse:Number = 1.0;
	private var _specular:Number = 0.0;
	private var _gloss:Number = 5.0;

	private var _scenes:Map;
	
}