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

package sandy.materials;

import flash.display.Sprite;

import sandy.core.Scene3D;
import sandy.core.data.Polygon;
import sandy.core.scenegraph.Sprite2D;
import sandy.materials.attributes.MaterialAttributes;

/**
 * Blank material - base class for all materials.
 * 
 * <p>You can use this class to apply attributes without any material to object.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 */
class Material 
{
	/**
	 * The attributes of this material.
	 */
	public var attributes:MaterialAttributes;
	
	/**
	 * Specify if the material use the vertex normal information
	 * Default value is set to false.
	 */
	public var useVertexNormal:Bool;
	
	/**
	 * Specify is the material can receive light and apply the light attributes if specified.
	 * Can be useful to disable very rapidly the light when unused.
	 * Default value : false
	 */
	public var lightingEnable:Bool;
	
	/**
	 * Creates a material.
	 *
	 * <p>This constructor is never called directly - but by sub class constructors</p>
	 * @param p_oAttr	The attributes for this material
	 */
	public function new( ?p_oAttr:MaterialAttributes )
	{
	 useVertexNormal = false;
	 lightingEnable = false;

	 repeat = true;
	 m_nFlags = 0;
	 _useLight = false;

		_filters 	= [];
		_useLight 	= false;
		_id = _ID_++;
		attributes = (p_oAttr == null) ? new MaterialAttributes() : p_oAttr;
		m_bModified = true;
		m_oType = MaterialType.NONE;
	}
	
	/**
	 * The unique id of this material
	 */
	public var id(__getId,null):Float;
	private function __getId():Float
	{	
		return _id;
	}
	
	public function begin( p_oScene:Scene3D ):Void
	{
		attributes.begin( p_oScene );
	}
	
	public function finish( p_oScene:Scene3D ):Void
	{
		attributes.finish(p_oScene );
	}
	
	/**
	 * Renders the polygon dress in this material.
	 *
	 * <p>Implemented by sub classes</p>
	 */
	public function renderPolygon( p_oScene:Scene3D, p_oPolygon:Polygon, p_mcContainer:Sprite ):Void
	{
		if( attributes != null )  attributes.draw( p_mcContainer.graphics, p_oPolygon, this, p_oScene ) ;
	}
		
	/**
	 * Renders the sprite dress in this material.
	 *
	 * <p>Basically only needed to apply attributes to sprites</p>
	 */
	public function renderSprite( p_oSprite:Sprite2D, p_oMaterial:Material, p_oScene:Scene3D ):Void
	{
		if( attributes != null )  attributes.drawOnSprite( p_oSprite, p_oMaterial, p_oScene );
	}

	/**
	 * Allows to proceed to an initialization
	 * to know when the polyon isn't lined to the material, look at #unlink
	 */
	public function init( p_oPolygon:Polygon ):Void
	{
		attributes.init( p_oPolygon );
	}

	/**
	 * Remove all the initialization
	 * opposite of init
	 */
	public function unlink( p_oPolygon:Polygon ):Void
	{
		attributes.unlink( p_oPolygon );
	}
	
	/**
	 * The material type of this material.
	 * 
	 * <p>For the default material this value is set to NONE</p>
	 */
	public var type(__getType,null):MaterialType;
	private function __getType():MaterialType
	{ 
		return m_oType; 
	}
	
	/**
	 * The array of filters for this material.
	 * 
	 * <p>You use this property to add an array of filters you want to apply to this material<br>
	 * To remove the filters, just assign an empty array.</p>
	 */
	private function __setFilters( a:Array<Dynamic> ):Array<Dynamic>
	{ 
		_filters = a; m_bModified = true;
		return a;
	}
	
	public var flags(__getFlags,null):Int;
	public function __getFlags():Int
	{
		var l_nFlags:Int = m_nFlags;
		l_nFlags |= attributes.flags;
		return l_nFlags;
	}
	/**
	 * @private
	 */
	public var filters(__getFilters,__setFilters):Array<Dynamic>;
	public function __getFilters():Array<Dynamic>
	{ 
		return _filters; 
	}
	
	/**
	 * The modified state of this material.
	 *
	 * <p>true if this material or its line attributes were modified since last rendered, false otherwise.</p> 
	 */
	public var modified(__getModified,null):Bool;
	private function __getModified():Bool
	{
		return (m_bModified);// && ((lineAttributes) ? lineAttributes.modified : true));
	}
			
	/**
	 * The repeat property.
	 * 
	 * This affects the way textured materials are mapped for U or V out of 0-1 range.
	 */
	public var repeat:Bool;
	
	//////////////////
	// PROPERTIES
	//////////////////
	/**
	 * DO NOT TOUCH THIS PROPERTY UNLESS YOU PERFECTLY KNOW WHAT YOU ARE DOING.
	 * this flag property contains the specific material flags.
	 */
	private var m_nFlags:Int;
	private var m_bModified:Bool;
	private var _filters:Array<Dynamic>;
	private var _useLight : Bool;
	private var _id:Float;
	private var m_oType:MaterialType;
	private static var _ID_:Float = 0;
}

