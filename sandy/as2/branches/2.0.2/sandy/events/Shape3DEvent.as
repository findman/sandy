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

import com.bourre.events.BubbleEvent;
import com.bourre.events.EventType;	
	
import sandy.core.scenegraph.Shape3D;
import sandy.core.data.Polygon;
import sandy.core.data.UVCoord;
import sandy.core.data.Vector;

/**
 * This class represents the type of events broadcasted by shapes objects.
 * It gives some useful information about the clicked object such as the polygon clicked, and real 3D position of the point under mouse, the UV coordinate under mouse.
 * It allows some advanced interaction with the object and its texture.
 *
 * @author	(porting) Floris - xdevltd
 * @version 2.0.2
 *
 * @see sandy.core.scenegraph.Shape3D
 */
 
class sandy.events.Shape3DEvent extends BubbleEvent
{
	
	/**
	 * A reference to the object which has been clicked.
	 *
     * @see sandy.core.scenegraph.Scene3D
	 */
	public var shape:Shape3D;

	/**
	 * Polygon that has been clicked.
	 *
     * @see sandy.core.data.Polygon
	 */
	public var polygon:Polygon;

	/**
	 * Real UV coordinate of the point under the mouse click position.
	 *
     * @see sandy.core.data.UVCoord
	 */
	public var uv:UVCoord;

	/**
	 * Real 3D position of the point under mouse click position.
	 *
     * @see sandy.core.data.Vector
	 */
	public var point:Vector;
	
	/**
	 * Original Flash event instance.
	 */
	public var event:EventType;
	
	/**
	 * Constructs a new Shape3DEvent instance.
	 *
	 * <p>Example
	 * <code>
	 *   var e:Shape3DEvent = new Shape3DEvent(MyClass.onSomething, theShapeReference, thePolygonReference, theUVCoord, theReal3DIntersectionPoint);
	 * </code>
	 *
	 * @param e				A name for the event.
	 * @param p_oShape		The Shape3D object reference
	 * @param p_oPolygon	The Polygon object reference
	 * @param p_oUV			The UVCoord object which corresponds to the UVCoord under mouse position
	 * @param p_oPoint3d	The Vector object which is the real 3D position under the mouse position
	 * @param p_oEvent		The original Flash event instance
	 *
     * @see sandy.core.scenegraph.Scene3D
     * @see sandy.core.data.Polygon
     * @see sandy.core.data.UVCoord
     * @see sandy.core.data.Vector
	 */
	public function Shape3DEvent( p_oEvent:EventType, p_oShape:Shape3D, p_oPolygon:Polygon, p_oUV:UVCoord, p_oPoint3d:Vector )
	{
		super( p_oEvent, p_oShape );
		shape = p_oShape;
		polygon = p_oPolygon;
		uv = p_oUV;
		point = p_oPoint3d;
		event = p_oEvent;
	}
	
}
