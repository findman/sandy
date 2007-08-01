package sandy.core.scenegraph 
{
	import sandy.core.data.Matrix4;
	import sandy.core.data.Vector;
	
	/**
	 * @author thomaspfeiffer
	 */
	public class ATransformable extends Node
	{
		private var m_oMatrix:Matrix4;
	
		public function ATransformable ( p_sName:String="" )
		{
			super( p_sName );
			// --
			initFrame();
			// --
			_p 		= new Vector();
			_oScale = new Vector( 1, 1, 1 );
			_vRotation = new Vector(0,0,0);
			// --
			_vLookatDown = new Vector(0.00000000001, -1, 0);// value to avoid some colinearity problems.;
			// --
			_nRoll 	= 0;
			_nTilt 	= 0;
			_nYaw  	= 0;
			// --
			m_tmpMt = new Matrix4();
			m_oMatrix = new Matrix4();
		}
	    
	    public function initFrame():void
	    {
	    	_vSide 	= new Vector( 1, 0, 0 );
			_vUp 	= new Vector( 0, 1 ,0 );
			_vOut 	= new Vector( 0, 0, 1 );
	    }
	    
	    public function get matrix():Matrix4
	    {
	    	return m_oMatrix;
	    }
	    
	    public function set matrix( p_oMatrix:Matrix4 ):void
	    {
	    	m_oMatrix = p_oMatrix;
	    	//
	    	m_oMatrix.vectorMult3x3(_vSide);
	    	m_oMatrix.vectorMult3x3(_vUp);
	    	m_oMatrix.vectorMult3x3(_vOut);
	    }

	    
	    public override function toString():String
	    {
	    	return "sandy.core.scenegraph.ATransformable";
	    }
	    
		/**
		 * X position of the node
		 */
		public function set x( px:Number ):void
		{
			_p.x = px;
			changed = true;
		}
		
		public function get x():Number
		{
			return _p.x;
		}
		
		/**
		 * Y position of the node
		 */
		public function set y( py:Number ):void
		{
			_p.y = py;
			changed = true;
		}
		
		public function get y():Number
		{
			return _p.y;
		}
		
		/**
		 * Z position of the node
		 */
		public function set z( pz:Number ):void
		{
			_p.z = pz;
			changed = true;
		}
		
		public function get z():Number
		{
			return _p.z;
		}				
	
		public function get out():Vector
		{
			return _vOut;
		}
		public function get side():Vector
		{
			return _vSide;
		}
		
		public function get up():Vector
		{
			return _vUp;
		}
		
		/**
		 * sx correspond in the scale value in the local obejct frame axis
		 * @param p_scaleX Number the number you ant to scale your object. A value of 1 scale to the original value, 2 makes
		 * the object seems twice bigger on the X axis.
		 * NOTE : This value does not affect the camera object.
		 */
		public function set scaleX( p_scaleX:Number ):void
		{
			_oScale.x = p_scaleX;
			changed = true;
		}
					
		public function get scaleX():Number
		{
			return _oScale.x;
		}
	
		/**
		 * sy correspond in the scale value in the local obejct frame axis
		 * @param p_scaleY Number the number you ant to scale your object. A value of 1 scale to the original value, 2 makes
		 * the object seems twice bigger on the Y axis.
		 * NOTE : This value does not affect the camera object.
		 */
		public function set scaleY( p_scaleY:Number ):void
		{
			_oScale.y = p_scaleY;
			changed = true;
		}
					
		public function get scaleY():Number
		{
			return _oScale.y;
		}
		
		/**
		 * sz correspond in the scale value in the local obejct frame axis
		 * @param p_scaleZ Number the number you ant to scale your object. A value of 1 scale to the original value, 2 makes
		 * the object seems twice bigger on the Z axis.
		 * NOTE : This value does not affect the camera object.
		 */
		public function set scaleZ( p_scaleZ:Number ):void
		{
			_oScale.z = p_scaleZ;
			changed = true;
		}
					
		public function get scaleZ():Number
		{
			return _oScale.z;
		}	
	    
		/**
		 * Allow the camera to translate along its side vector. 
		 * If you imagine yourself in a game, it would be a step on your right or on your left
		 * @param	d	Number	Move the camera along its side vector
		 */
		public function moveSideways( d : Number ) : void
		{
			changed = true;
			_p.x += _vSide.x * d;
			_p.y += _vSide.y * d;
			_p.z += _vSide.z * d;
		}
		
		/**
		 * Allow the camera to translate along its up vector. 
		 * If you imagine yourself in a game, it would be a jump on the direction of your body (so not always the vertical!)
		 * @param	d	Number	Move the camera along its up vector
		 */
		public function moveUpwards( d : Number ) : void
		{
			changed = true;
			_p.x += _vUp.x * d;
			_p.y += _vUp.y * d;
			_p.z += _vUp.z * d;
		}
		
		/**
		 * Allow the camera to translate along its view vector. 
		 * If you imagine yourself in a game, it would be a step in the direction you look at. If you look the sky
		 * you will translate upwards ! So be careful with its use.
		 * @param	d	Number	Move the camera along its viw vector
		 */
		public function moveForward( d : Number ) : void
		{
			changed = true;
			_p.x += _vOut.x * d;
			_p.y += _vOut.y * d;
			_p.z += _vOut.z * d;
		}
	 
		/**
		 * Allow the camera to translate horizontally
		 * If you imagine yourself in a game, it would be a step in the direction you look at but without changing 
		 * your altitude.
		 * @param	d	Number	Move the camera horizontally
		 */	
		public function moveHorizontally( d:Number ) : void
		{
			changed = true;
			_p.x += _vOut.x * d;
			_p.z += _vOut.z * d;	
		}
		
		/**
		 * Allow the camera to translate vertically
		 * If you imagine yourself in a game, it would be a jump strictly vertical.
		 * @param	d	Number	Move the camera vertically
		 */	
		public function moveVertically( d:Number ) : void
		{
			changed = true;
			_p.y += d;	
		}
		
		 /**
		 * Allow the camera to translate lateraly
		 * If you imagine yourself in a game, it would be a step on the right with a positiv parameter and to the left
		 * with a negative parameter
		 * @param	d	Number	Move the camera lateraly
		 */	
		public function moveLateraly( d:Number ) : void
		{
			changed = true;
			_p.x += d;	
		}
			
		/**
		* Translate the camera from it's actual position with the offset values pased in parameters
		* 
		* @param px x offset that will be added to the x coordinate of the camera
		* @param py y offset that will be added to the y coordinate position of the camera
		* @param pz z offset that will be added to the z coordinate position of the camera
		*/
		public function translate( px:Number, py:Number, pz:Number ) : void
		{
			changed = true;
			_p.x += px;
			_p.y += py;
			_p.z += pz;	
		}
		
		
		/**
		 * Rotate the camera around a specific axis by an angle passed in parameter
		 * NOTE : The axis will be normalized automatically.
		 * @param	ax	Number	The x coordinate of the axis
		 * @param	ay	Number	The y coordinate of the axis
		 * @param	az	Number	The z coordinate of the axis
		 * @param	nAngle	Number	The amount of rotation. This angle is in degrees.
		 */
		public function rotateAxis( ax : Number, ay : Number, az : Number, nAngle : Number ):void
		{
			changed = true;
			nAngle = (nAngle + 360)%360;
			var n:Number = Math.sqrt( ax*ax + ay*ay + az*az );
			// --
			m_tmpMt.axisRotation( ax/n, ay/n, az/n, nAngle );
			//
			m_tmpMt.vectorMult3x3(_vSide);
	    	m_tmpMt.vectorMult3x3(_vUp);
	    	m_tmpMt.vectorMult3x3(_vOut);
		}
	 
	
		public function set target( p_oTarget:Vector ):void
		{
			lookAt( p_oTarget.x, p_oTarget.y, p_oTarget.z) ;
		}
		
		/**
		 * Make the camera look at a specific position. Useful to follow a moving object or a static object while the camera is moving.
		 * @param	px	Number	The x position to look at
		 * @param	py	Number	The y position to look at
		 * @param	pz	Number	The z position to look at
		 */
		public function lookAt( px:Number, py:Number, pz:Number ):void
		{
			changed = true;
			//
			_vOut.x = px; _vOut.y = py; _vOut.z = pz;
			//
			_vOut.sub( _p );
			_vOut.normalize();
			// -- the vOut vector should not be colinear with the reference down vector!
			_vSide = null;
			_vSide = _vOut.cross( _vLookatDown );
			_vSide.normalize();
			//
			_vUp = null;
			_vUp = _vOut.cross(_vSide );
			_vUp.normalize();
		}
	 
		/**
		 * RotateX - Rotation around the global X axis of the camera frame
		 * @param nAngle Number The angle of rotation in degree.
		 * @return void
		 */
		public function set rotateX ( nAngle:Number ):void
		{
			var l_nAngle:Number = (nAngle - _vRotation.x);
			if(l_nAngle == 0 ) return;
			changed = true;
			// --
			m_tmpMt.rotationX( l_nAngle );			
			m_tmpMt.vectorMult3x3(_vSide);
	    	m_tmpMt.vectorMult3x3(_vUp);
	    	m_tmpMt.vectorMult3x3(_vOut);
			// --
			_vRotation.x = nAngle;
		}
		
		public function get rotateX():Number
		{
			return _vRotation.x;
		}
		
		/**
		 * rotateY - Rotation around the global Y axis of the camera frame
		 * @param nAngle Number The angle of rotation in degree.
		 * @return void
		 */
		public function set rotateY ( nAngle:Number ):void
		{
			var l_nAngle:Number = (nAngle - _vRotation.y);
			if(l_nAngle == 0 ) return;
			changed = true;
			// --
			m_tmpMt.rotationY( l_nAngle );			
			m_tmpMt.vectorMult3x3(_vSide);
	    	m_tmpMt.vectorMult3x3(_vUp);
	    	m_tmpMt.vectorMult3x3(_vOut);
			// --
			_vRotation.y = nAngle;
		}
		
		public function get rotateY():Number
		{
			return _vRotation.y;
		}
		
		/**
		 * rotateZ - Rotation around the global Z axis of the camera frame
		 * @param nAngle Number The angle of rotation in degree between : [ -180; 180 ].
		 * @return
		 */
		public function set rotateZ ( nAngle:Number ):void
		{
			var l_nAngle:Number = (nAngle - _vRotation.z );
			if(l_nAngle == 0 ) return;
			changed = true;
			// --
			m_tmpMt.rotationZ( l_nAngle );			
			m_tmpMt.vectorMult3x3(_vSide);
	    	m_tmpMt.vectorMult3x3(_vUp);
	    	m_tmpMt.vectorMult3x3(_vOut);
			// --
			_vRotation.z = nAngle;
		}	
		
		public function get rotateZ():Number
		{
			return _vRotation.z;
		}

		/* Test but may be useful later
		private function _upateRotation():void
		{
			m_tmpMt = Matrix4Math.rotationX ( m_RotationOffset.x );
			m_tmpMt = Matrix4Math.multiply3x3( m_tmpMt, Matrix4Math.rotationY( m_RotationOffset.y ) );
			m_tmpMt = Matrix4Math.multiply3x3( m_tmpMt, Matrix4Math.rotationZ( m_RotationOffset.z ) );
			// --
			_vUp   = Matrix4Math.vectorMult3x3( m_tmpMt, _vUp  );
			_vSide = Matrix4Math.vectorMult3x3( m_tmpMt, _vSide );
			_vOut  = Matrix4Math.vectorMult3x3( m_tmpMt, _vOut );
		}
		*/
		
		/**
		 * roll - Rotation around the local Z axis of the camera frame
		 * Range from -180 to +180 where 0 means the plane is aligned with the horizon, 
		 * +180 = Full roll right and –180 = Full roll left. In both cases, when the roll is 180 and –180, 
		 * the plane is flipped on its back.
		 * @param nAngle Number The angle of rotation in degree.
		 * @return
		 */
		public function set roll ( nAngle:Number ):void
		{
			var l_nAngle:Number = (nAngle - _nRoll)
			if(l_nAngle == 0 ) return;
			changed = true;
			// --		
			m_tmpMt.axisRotation ( _vOut.x, _vOut.y, _vOut.z, l_nAngle );
			m_tmpMt.vectorMult3x3(_vSide);
	    	m_tmpMt.vectorMult3x3(_vUp);
			// --
			_nRoll = nAngle;
		}	
	
			
		/**
		 * Tilt - Rotation around the local X axis of the camera frame
		 * Range from -90 to +90 where 0 = Horizon, +90 = straight up and –90 = straight down.
		 * @param nAngle Number The angle of rotation in degree.
		 * @return void
		 */
		public function set tilt ( nAngle:Number ):void
		{
			var l_nAngle:Number = (nAngle - _nTilt);
			if(l_nAngle == 0 ) return;
			changed = true;
			// --
			m_tmpMt.axisRotation ( _vSide.x, _vSide.y, _vSide.z, l_nAngle );
			m_tmpMt.vectorMult3x3(_vOut);
	    	m_tmpMt.vectorMult3x3(_vUp);
			// --
			_nTilt = nAngle;
		}
		
		/**
		 * Pan - Rotation around the local Y axis of the camera frame
		 * Range from 0 to 360 where 0=North, 90=East, 180=South and 270=West.
		 * @param nAngle Number The angle of rotation in degree.
		 * @return void
		 */
		public function set pan ( nAngle:Number ):void
		{
			var l_nAngle:Number = (nAngle - _nYaw);
			if(l_nAngle == 0 ) return;
			changed = true;
			// --
			m_tmpMt.axisRotation ( _vUp.x, _vUp.y, _vUp.z, l_nAngle );
			m_tmpMt.vectorMult3x3(_vOut);
	    	m_tmpMt.vectorMult3x3(_vSide);
			// --
			_nYaw = nAngle;
		}
	
		/**
		 * Realize a rotation around a specific axis (the axis must be normalized!) and from an pangle degrees and around a specific position.
		 * @param pAxis A 3D Vector representing the axis of rtation. Must be normalized !!
		 * @param ref Vector The center of rotation as a 3D point.
		 * @param pAngle Number The angle of rotation in degrees.
		 */
		public function rotAxisWithReference( axis:Vector, ref:Vector, pAngle:Number ):void
		{
			var angle:Number = ( pAngle + 360 ) % 360;
			// --
			m_tmpMt.axisRotationWithReference( axis, ref, angle );
			m_tmpMt.vectorMult3x3( _vUp  );
			m_tmpMt.vectorMult3x3( _vSide);
			m_tmpMt.vectorMult3x3( _vOut );
			// --
			changed = true;
		}

		public function get roll():Number{return _nRoll;}
		
		public function get tilt():Number{return _nTilt;}
		
		public function get pan():Number{return _nYaw;}
		
		/**
		* Set the position of the camera. Basically apply a translation.
		* @param x x position of the camera
		* @param y y position of the camera
		* @param z z position of the camera
		*/
		public function setPosition( x:Number, y:Number, z:Number ):void
		{
			changed = true;
			// we must consider the screen y-axis inversion
			_p.x = x;
			_p.y = y;
			_p.z = z;	
		}
		
	
		/**
		 * This method goal is to update the node. For node's with transformation, this method shall
		 * update the transformation taking into account the matrix cache system.
		 * FIXME: Transformable nodes shall upate their transform if necessary before calling this method.
		 */
		public override function update( p_oModelMatrix:Matrix4, p_bChanged:Boolean ):void
		{
			updateTransform();
			if( p_bChanged || changed )
			{
				 if( p_oModelMatrix )
				 {
				 	_oModelCacheMatrix.copy(p_oModelMatrix);
				 	_oModelCacheMatrix.multiply4x3( m_oMatrix );
				 }
				 else
				 {
				 	_oModelCacheMatrix.copy( m_oMatrix );
				 }
			}
			//
			super.update( _oModelCacheMatrix, p_bChanged );
		}
	
	 	/**
		 * This method shall be called to update the transform matrix of the current object/node
		 * before being rendered.
		 */
		public function updateTransform():void
		{
			if( changed )
			{
				m_oMatrix.n11 = _vSide.x * _oScale.x; 
				m_oMatrix.n12 = _vUp.x; 
				m_oMatrix.n13 = _vOut.x; 
				m_oMatrix.n14 = _p.x;
				
				m_oMatrix.n21 = _vSide.y; 
				m_oMatrix.n22 = _vUp.y * _oScale.y; 
				m_oMatrix.n23 = _vOut.y; 
				m_oMatrix.n24 = _p.y;
				
				m_oMatrix.n31 = _vSide.z; 
				m_oMatrix.n32 = _vUp.z; 
				m_oMatrix.n33 = _vOut.z * _oScale.z;  
				m_oMatrix.n34 = _p.z;
				
				m_oMatrix.n41 = m_oMatrix.n42 = m_oMatrix.n43 = 0;
				m_oMatrix.n44 = 1;
			}
		}
			
		/**
		* Get the position of the element.
		* If the parameter equals "local" the function returns a vector container the position relative to the parent frame.
		* If the parameter equals "absolute" the function returns the absolute position in the world frame.
		* If the parameter equals "camera" the function returns the absolute position in the camera frame.
		* Default value is "local"
		* @return the position of the element as a Vector
		*/
		public function getPosition( p_sMode:String = "local" ):Vector
		{
			var l_oPos:Vector;
			switch( p_sMode )
			{
				case "local" 	: l_oPos = new Vector( _p.x, _p.y, _p.z ); break;
				case "camera" : l_oPos = new Vector( _oViewCacheMatrix.n14, _oViewCacheMatrix.n24, _oViewCacheMatrix.n34 ); break;
				case "absolute" 	: l_oPos = new Vector( _oModelCacheMatrix.n14, _oModelCacheMatrix.n24, _oModelCacheMatrix.n34 ); break;
				default 		: l_oPos = new Vector( _p.x, _p.y, _p.z ); break;
			}
			return l_oPos;
		}
	
		// Side Orientation Vector
		protected var _vSide:Vector;
		// view Orientation Vector
		protected var _vOut:Vector;
		// up Orientation Vector
		protected var _vUp:Vector;
		// current tilt value
		private var _nTilt:Number;
		// current yaw value
		private var _nYaw:Number;
		// current roll value
		private var _nRoll:Number;
		private var _vRotation:Vector;		
		private var _vLookatDown:Vector; // Private absolute down vector
		protected var _p:Vector;	
		protected var _oScale:Vector;
		protected var m_tmpMt:Matrix4; // temporary transform matrix used at updateTransform
	}
}