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

import sandy.core.Scene3D;
import sandy.core.data.Polygon;
import sandy.core.scenegraph.Sprite2D;
import sandy.materials.MaterialType;
import sandy.materials.attributes.MaterialAttributes;

/**
 * The Material class is the base class for all materials.
 * 
 * <p>Since the Material object is essentially a blank material, this class can be used
 * to apply attributes without any material to a 3D object.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - xdevltd
 * @version		2.0.2
 * @date 		26.07.2007
 *
 * @see Appearance
 */
 
class sandy.materials.Material
{

	/**
	 * The attributes of this material.
	 */
	public var attributes:MaterialAttributes;
		
	/**
	 * Specify if the material use the vertex normal information.
	 * 
	 * @default false
	 */
	public var useVertexNormal:Boolean;
		
	/**
	 * Specifies if the material can receive light and have light attributes applied to it.
	 * Can be useful to rapidly disable light on the object when unneeded.
	 */
	public var lightingEnable:Boolean;
		
	/**
	 * Creates a material.
	 *
	 * <p>This constructor is never called directly - but by sub class constructors.</p>
	 * @param p_oAttr	The attributes for this material.
	 */
	public function Material( p_oAttr:MaterialAttributes )
	{
		repeat = true;
		useVertexNormal = false;
		lightingEnable  = false;
		_filters    = [];
		_useLight   = false;
		_id 	    = _ID_++;
		attributes  = ( p_oAttr == null ) ? new MaterialAttributes() : p_oAttr;
		m_bModified = true;
		m_oType     = MaterialType.NONE;
	}
	
	/**
	 * The unique id of this material.
	 */
	public function get id() : Number
	{	
		return _id;
	}
		
	/**
	 * Calls begin method of the MaterialAttributes associated with this material.
	 *
	 * @param p_oScene	The scene.
	 *
	 * @see sandy.materials.attributes.MaterialAttributes#begin()
	 */
	public function begin( p_oScene:Scene3D ) : Void
	{
		attributes.begin( p_oScene );
	}
		
	/**
	 * Calls finish method of the MaterialAttributes associated with this material.
	 *
	 * @param p_oScene	The scene.
	 *
	 * @see sandy.materials.attributes.MaterialAttributes#finish()
	 */
	public function finish( p_oScene:Scene3D ) : Void
	{
		attributes.finish( p_oScene );
	}
	
	/**
	 * Renders the polygon dress in this material.
	 *
	 * <p>Implemented by sub classes.</p>
	 *
	 * @see sandy.core.Scene3D
	 * @see sandy.core.data.Polygon
	 */
	public function renderPolygon( p_oScene:Scene3D, p_oPolygon:Polygon, p_mcContainer:MovieClip ) : Void
	{
		if( attributes )
		{
			attributes.draw( p_mcContainer, p_oPolygon, this, p_oScene );
		}
	}
		
	/**
	 * Renders the sprite dress in this material.
	 *
	 * <p>Basically only needed to apply attributes to sprites</p>
	 *
	 * @see sandy.core.scenegraph.Sprite2D
	 * @see sandy.core.Scene3D
	 */
	public function renderSprite( p_oSprite:Sprite2D, p_oMaterial:Material, p_oScene:Scene3D ) : Void
	{
		if( attributes )
		{
			attributes.drawOnSprite( p_oSprite, p_oMaterial, p_oScene );
		}
	}

	/**
	 * Calls init method of the MaterialAttributes associated with this material.
	 *
	 * @see sandy.materials.attributes.MaterialAttributes#init()
	 */
	public function init( p_oPolygon:Polygon ) : Void
	{
		attributes.init( p_oPolygon );
	}

	/**
	 * Calls unlink method of the MaterialAttributes associated with this material.
	 *
	 * @see sandy.materials.attributes.MaterialAttributes#unlink()
	 */
	public function unlink( p_oPolygon:Polygon ) : Void
	{
		attributes.unlink( p_oPolygon );
	}
		
	/**
	 * The material type of this material.
	 * 
	 * @default MaterialType.NONE
	 *
	 * @see MaterialType
	 */
	public function get type() : MaterialType
	{ 
		return m_oType; 
	}
		
	/**
	 * @private
	 */
	public function set filters( a:Array ) : Void
	{ 
		_filters = a;
		m_bModified = true;
	}
	
	/**
	 * Contains specific material flags.
	 */
	public function get flags() : Number
	{
		var l_nFlags:Number = int( m_nFlags );
		l_nFlags |= attributes.flags;
		return int( l_nFlags );
	}
	
	/**
	 * The array of filters for this material.
	 * 
	 * <p>You use this property to add an array of filters you want to apply to this material<br>
	 * To remove the filters, just assign an empty array.</p>
	 */
	public function get filters() : Array
	{ 
		return _filters; 
	}
	
	/**
	 * The modified state of this material.
	 *
	 * <p>true if this material or its line attributes were modified since last rendered, false otherwise.</p> 
	 */
	public function get modified() : Boolean
	{
		return( m_bModified );// && ( ( lineAttributes ) ? lineAttributes.modified:true ) );
	}
				
	/**
	 * The repeat property.
	 * 
	 * This affects the way textured materials are mapped for U or V out of 0-1 range.
	 */
	public var repeat:Boolean;
	
	//////////////////
	// PROPERTIES
	//////////////////
	/**
	 * DO NOT TOUCH THIS PROPERTY UNLESS YOU PERFECTLY KNOW WHAT YOU ARE DOING.
	 * this flag property contains the specific material flags.
	 *
	 * @private
	 */
	private var m_nFlags:Number = 0;
	
	/**
	 * @private
	 */
	private var m_bModified:Boolean;
	
	/**
	 * @private
	 */
	private var _useLight:Boolean = false;
		
	/**
	 * @private
	 */
	private var m_oType:MaterialType;
		
	
	private var _filters:Array;
	private var _id:Number;

	private static var _ID_:Number = 0;
	private static var create:Boolean;

}