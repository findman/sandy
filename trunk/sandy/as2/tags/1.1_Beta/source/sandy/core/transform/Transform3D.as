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

import sandy.core.data.Matrix4;
import sandy.core.data.Vector;
import sandy.core.transform.ITransform3D;
import sandy.core.transform.TransformType;
import sandy.math.Matrix4Math;
import sandy.math.VectorMath;

import com.bourre.events.EventType;
import com.bourre.events.EventBroadcaster;

/**
* Transform3D
* This class helps you to create some transformations to apply to a transformGroup. This way you will be able
* to transform a whole group of objects, to create the effect you want.
* @author		Thomas Pfeiffer - kiroukou
* @since		1.0
* @version		1.0
* @date 		20.05.2006
*/
class sandy.core.transform.Transform3D extends EventBroadcaster implements ITransform3D 
{
	/**
	 * The World3D rendering Event. It's the event broadcasted every time the world is rendered
	 */
	public static var onUpdateEVENT:EventType = new EventType( 'onUpdate' );
	
	/**
	 * Create a new Transform3D instance. An identity matrix is created by default, and the transform type is NONE.
	 */
	public function Transform3D ( Void )
	{
		super( this );
		_m = Matrix4.createIdentity();
		_type = TransformType.NONE;
	}
	
	/**
	 * Set the matrix rotation around the X axis.
	 * @param pAngle Number The angle of rotation in degree.
	 */
	public function rotX ( pAngle:Number ):Void
	{
		var angle:Number = ( pAngle + 360 ) % 360;
		_m = Matrix4Math.rotationX( angle );
		_type = TransformType.ROTATION;
		__dispatch();
	}	
	
	/**
	 * Set the matrix rotation around the Y axis.
	 * @param pAngle Number The angle of rotation in degree.
	 */
	public function rotY ( pAngle:Number ):Void
	{
		var angle:Number = ( pAngle + 360 ) % 360;
		_m = Matrix4Math.rotationY( angle );
		_type = TransformType.ROTATION;
		__dispatch();
	}
		
	/**
	 * Set the matrix rotation around the Z axis.
	 * @param pAngle Number The angle of rotation in degree.
	 */
	public function rotZ ( pAngle:Number ):Void
	{
		var angle:Number = ( pAngle + 360 ) % 360;
		_m = Matrix4Math.rotationZ( angle );
		_type = TransformType.ROTATION;
		__dispatch();
	}
			
	/**
	* Realize the euler rotation matrix thnaks to the three angles in arguments as a degree angle.
	* @param	px	Number Angle of rotation in degree around the X axis
	* @param	py 	Number Angle of rotation in degree around the Y axis 
	* @param	pz  Number Angle of rotation in degree around the Z axis
	*/
	public function rot( px:Number, py:Number, pz:Number ):Void
	{
		px = ( px + 360 ) % 360;
		py = ( py + 360 ) % 360;
		pz = ( pz + 360 ) % 360;
		//
		_m = Matrix4Math.eulerRotation( px, py, pz );
		_type = TransformType.ROTATION;;
		__dispatch();
	}

	
	/**
	* Realize the euler rotation matrix thanks to angles defined in the vector argument
	* @param	v Vector The vector containig the eurlers angles
	*/
	public function rotVector( v:Vector ):Void
	{
		rot( v.x, v.y, v.z );
		__dispatch();
	}
		
	/**
	 * Realize a rotation around a specific axis (the axis will be normalized) and from an pangle degrees.
	 * @param pAxis A 3D Vector representing the axis of rtation. This axis will be normalized inside the method.
	 * @param pAngle Number The angle of rotation in degrees.
	 */
	public function rotAxis ( pAxis:Vector, pAngle:Number ):Void
	{
		var angle:Number = ( pAngle + 360 ) % 360;
		VectorMath.normalize( pAxis );
		_m = Matrix4Math.axisRotation( pAxis.x, pAxis.y, pAxis.z, angle );
		_type = TransformType.ROTATION;
		__dispatch();
	}
	
	/**
	 * Realize a rotation around a specific axis (the axis must be normalized!) and from an pangle degrees and around a specific position.
	 * @param pAxis A 3D Vector representing the axis of rtation. Must be normalized
	 * @param ref Vector The center of rotation as a 3D point.
	 * @param pAngle Number The angle of rotation in degrees.
	 */
	public function rotAxisWithReference( axis:Vector, ref:Vector, pAngle:Number ):Void
	{
		var angle:Number = ( pAngle + 360 ) % 360;
		_m = Matrix4Math.translation ( ref.x, -ref.y, ref.z );
		_m = Matrix4Math.multiply ( _m, Matrix4Math.axisRotation( axis.x, axis.y, axis.z, angle ));
		_m = Matrix4Math.multiply ( _m, Matrix4Math.translation ( -ref.x, ref.y, -ref.z ));
		_type = TransformType.ROTATION;
		__dispatch();
	}
	
	/**
	 * Realize a scale on the X axis
	 * @param pVal Number the value of scale.
	 */
	public function scaleX ( pVal:Number ):Void
	{
		_m = Matrix4Math.scale( pVal, 0, 0 );
		_type = TransformType.SCALE;
		__dispatch();
	}
		
	/**
	 * Realize a scale on the Y axis
	 * @param pVal Number the value of scale.
	 */
	public function scaleY ( pVal:Number ):Void
	{
		_m = Matrix4Math.scale(  0, pVal, 0 );
		_type = TransformType.SCALE;
		__dispatch();
	}
	
	/**
	 * Realize a scale on the Z axis
	 * @param pVal Number the value of scale.
	 */
	public function scaleZ ( pVal:Number ):Void
	{
		_m = Matrix4Math.scale( 0, 0, pVal );
		_type = TransformType.SCALE;
		__dispatch();
	}

	/**
	 * Realize a scale on all the directions.
	 * @param px Number the scale on the X direction
	 * @param py Number the scale on the Y direction
	 * @param pz Number the scale on the Z direction
	 */
	public function scale ( px:Number, py:Number, pz:Number ):Void
	{
		_m = Matrix4Math.scale( px, py, pz );
		_type = TransformType.SCALE;
		__dispatch();
	}
	
	/**
	 * Realize a scale on all the 3 dimensions thnaks to the 3 properties of the Vector object.
	 * @param v Vector Vector containing the scale values in the 3 axis directions.
	 */
	public function scaleVector ( v:Vector ):Void
	{
		scale( v.x, v.y, v.z );
		__dispatch();
	}
	
	/**
	 * Realize a translation on the X direction
	 * @param val Number the amount of translation
	 */
	public function translateX ( val:Number ):Void
	{
		_m = Matrix4Math.translation( val, 0, 0 );
		_type = TransformType.TRANSLATION;
		__dispatch();
	}
		
	/**
	 * Realize a translation on the Y direction
	 * @param val Number the amount of translation
	 */
	public function translateY ( val:Number ):Void
	{
		_m = Matrix4Math.translation( 0, val, 0 );
		_type = TransformType.TRANSLATION;
		__dispatch();
	}
		
	/**
	 * Realize a translation on the Z direction
	 * @param val Number the amount of translation
	 */
	public function translateZ ( val:Number ):Void
	{
		_m = Matrix4Math.translation( 0, 0, val );
		_type = TransformType.TRANSLATION;
		__dispatch();
	}
	
	/**
	 * Realize a translation on all the 3 directions
	 * @param tx Number the amount of translation in x axis
	 * @param ty Number the amount of translation in y axis
	 * @param tz Number the amount of translation in z axis
	 */
	public function translate ( tx:Number, ty:Number, tz:Number ) : Void
	{
		_m = Matrix4Math.translation( tx, -ty, tz );
		_type = TransformType.TRANSLATION;
		__dispatch();
	}
	
	/**
	 * Realize the translation on all the 3 directions thanks to the Vector object.
	 * @param v Vector Vector containing the translation values in all the 3 directions
	 */
	public function translateVector ( v:Vector ) : Void
	{
		translate( v.x, v.y, v.z );
		__dispatch();
	}
	
	
	/**
	 * Get the type of transformation you have.
	 * @return TransformType The type of transformation.
	 */		
	public function getType( Void ):TransformType 
	{
		return _type;
	}
	
	/**
	 * Get the equilavent matrix representing the transformation.
	 * @return Matrix4 the matrix representing the transformation in 3D space.
	 */
	public function getMatrix( Void ):Matrix4 
	{
		return _m;
	}
	
	/**
	* This method allows you to have a single transform3D to combine several transformations.
	* By combining some transformations, you can expect some speed improvment since the matrix multiplication will be computed only once.
	* BE CAREFULL, this feature can be very hard to use correctly, so you have to completely understand what you are doing.
	* you must also take under consideration that it is the first matrix which is multiplied by the one in argument.
	* @param	m Matrix4 The matrix you want to combine with the current transformation one.
	*/
	public function combineMatrix( m:Matrix4 ):Void
	{
		_m = Matrix4Math.multiply( _m, m );
		_type = TransformType.MIXED;
		__dispatch();
	}

	/**
	* This method allows you to have a single transform3D to combine several transformations.
	* By combining some transformations, you can expect some speed improvment since the matrix multiplication will be computed only once.
	* BE CAREFULL, this feature can be very hard to use correctly, so you have to completely understand what you are doing.
	* you must also take under consideration that it is the first matrix which is multiplied by the one in argument.
	* @param	m Transform3D The matrix you want to combine with the current transformation one.
	*/
	public function combineTransform( t:Transform3D ):Void
	{
		_m = Matrix4Math.multiply( _m, t.getMatrix() );
		_type = TransformType.MIXED;
		__dispatch();
	}
	
	private function __dispatch( Void ):Void
	{
		//broadcastEvent( new BasicEvent( Transform3D.onUpdateEVENT ) );
		setModified( true );
	}
	
	public function isModified( Void ):Boolean
	{
		return _bModified;
	}
	
	public function setModified( b:Boolean ):Void
	{
		_bModified = b;
	}

	private var _bModified:Boolean;
	private var _m:Matrix4;
	private var _type:TransformType;

}