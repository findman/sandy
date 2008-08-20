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

import flash.geom.Point;
	
/**
 * The view port represents the rendered screen.
 *
 * <p>This is the area where the view of the camera is projected.<br/>
 * It may be the whole or only a part of the stage</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - FFlasher
 * @author		James Dahl - optimization with bitwise and int type.
 * @version		2.0.2
 * @date 		26.07.2007
 */	
 
class sandy.view.ViewPort
{
	
    /**
	 * A point representing the offset to change the view port center.
	 * <p>If you set myCamera.viewport.offset.y to 100, everything drawn at the screen will be moved 100 pixels down (due to Flash vertical axis convention).</p>
	 */
	public var offset:Point;
			
	/**
	 * Flag which specifies if the view port dimension has changed.
	 */
	public var hasChanged:Boolean = false;
		
    /**
	 * Creates a new ViewPort.
	 *
	 * @param p_nW 	The width of the rendered screen.
	 * @param p_nH 	The height of the rendered screen.
	 **/
	public function ViewPort( p_nW:Number, p_nH:Number )
	{
		offset = new Point();
		width = p_nW;
		height = p_nH;
	}
	
	/**
	 * Updates the view port.
	 */
	public function update() : Void
	{
		m_nW2 = m_nW >> 1;
		m_nH2 = m_nH >> 1;
		// --
		m_nRatio = ( m_nH )? m_nW / m_nH : 0;
		// --
		hasChanged = true;
	}
		
	/**
	 * The width of the view port.
	 */
	public function get width() : Number { return int( m_nW ); }
		
	/**
	 * The height of the view port.
	 */
	public function get height() : Number { return int( m_nH ); }
		
	/**
	 * Half the width of the view port. Used to center Camera3D.
	 */
	public function get width2() : Number { return int( m_nW2 ); }
		
	/**
	 * Half the height of the view port. Used to center Camera3D.
	 */
	public function get height2() : Number { return int( m_nH2 ); }
		
	/**
	 * The width/height ratio of the view port.
	 */
	public function get ratio() : Number { return m_nRatio; }
		
	/**
	 * @private
	 */
	public function set width( p_nValue:Number ) : Void { m_nW = int( p_nValue ); update(); }
		
	/**
	 * @private
	 */
	public function set height( p_nValue:Number ) : Void { m_nH = int( p_nValue ); update(); }

	private var m_nW:Number = 0;
	private var m_nW2:Number = 0;
	private var m_nH:Number = 0;
	private var m_nH2:Number = 0;
	private var m_nRatio:Number = 0;

}