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

import sandy.core.data.Vector;
import sandy.core.face.Face;
import sandy.core.light.Light3D;
import sandy.core.World3D;
import sandy.math.VectorMath;
import sandy.skin.Skin;
import sandy.skin.SkinType;
import sandy.skin.BasicSkin;
import sandy.util.NumberUtil;

/**
* SimpleColorSkin
*   
* @author		Thomas Pfeiffer - kiroukou
* @author		Tabin C�dric - thecaptain
* @author		Nicolas Coevoet - [ NikO ]
* @version		0.2
* @date 		12.01.2006 
**/
class sandy.skin.SimpleColorSkin extends BasicSkin implements Skin
{
	
	/**
	* Create a new SimpleColorSkin
	* 
	* @param c The color ot the line
	* @param a The alpha of the line
	*/ 
	public function SimpleColorSkin( c:Number,  a:Number )
	{
		super();
		_color 	= (isNaN(c)) ? 0x000000 : c;
		_alpha 	= (isNaN(a)) ? 100 : a;
	}

	/////////////
	// SETTERS //
	/////////////

	public function set alpha( n:Number )
	{
		_alpha = n;
		broadcastEvent( _eOnUpdate );
	}
	public function set color( n:Number )
	{
		_color = n;
		broadcastEvent( _eOnUpdate );
	}
	
	/////////////
	// GETTERS //
	/////////////	
	public function get alpha():Number
	{
		return _alpha;
	}
	public function get color():Number
	{
		return _color;
	}	

	
	/**
	 * getType, returns the type of the skin
	 * @param Void
	 * @return	The appropriate SkinType
	 */
	 public function getType ( Void ):SkinType
	 {
	 	return SkinType.SIMPLE_COLOR;
	 }
	 
	/**
	* Start the rendering of the Skin
	* @param f	The face which is being rendered
	* @param mc The mc where the face will be build.
	*/ 	
	public function begin( face:Face, mc:MovieClip ):Void
	{
		mc.filters = _filters;
		// -- 
		var col:Number = _color;
		if( _useLight )
		{
			var l:Light3D 	= World3D.getInstance().getLight();
			var vn:Vector 	= face.createNormale();
			var vl:Vector 	= l.dir;
			var lp:Number	= l.getPower()/100;
			// --
			var r:Number = ( col >> 16 )& 0xFF;
			var g:Number = ( col >> 8 ) & 0xFF;
			var b:Number = ( col ) 		& 0xFF;
			// --
			var dot:Number =  - ( VectorMath.dot( vl, vn ) );
			r = NumberUtil.constrain( r*(dot+lp), 0, 255 );
			g = NumberUtil.constrain( g*(dot+lp), 0, 255 );
			b = NumberUtil.constrain( b*(dot+lp), 0, 255 );
			// --
			col =  r << 16 | g << 8 |  b;
		}
		mc.beginFill( col, _alpha );
	}
	
	/**
	* Finish the rendering of the Skin
	* @param f	The face which is being rendered
	* @param mc The mc where the face will be build.
	*/ 	
	public function end( f:Face, mc:MovieClip ):Void
	{
		mc.endFill();
	}

	public function toString( Void ):String
	{
		return 'sandy.skin.SimpleColorSkin' ;
	}	
	
	
	private var _color:Number;
	private var _alpha:Number;
	
}
