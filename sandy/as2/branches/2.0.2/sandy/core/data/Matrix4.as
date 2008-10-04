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

import sandy.core.data.Vector;
import sandy.math.FastMath;
import sandy.util.NumberUtil;

/**
 * A 4x4 matrix for transformations in 3D space.
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - xdevltd
 * @since		1.0
 * @version		2.0.2
 * @date 		24.08.2007
 */
 
class sandy.core.data.Matrix4 
{
	
	/**
     * Specifies whether fast math should be used.
	 */
	public static var USE_FAST_MATH:Boolean;
		
	// we force initialization of the fast math table
	private var _fastMathInitialized:Boolean;
	
	/**
	 * Matrix4 cell.
	 *
	 * <pre>
	 * 1 0 0 0
	 * 0 0 0 0
	 * 0 0 0 0
	 * 0 0 0 0
	 * </pre>
	 */
	public var n11:Number;

	/**
	 * Matrix4 cell.
	 *
	 * <pre>
	 * 0 1 0 0
	 * 0 0 0 0
	 * 0 0 0 0
	 * 0 0 0 0
	 * </pre>
	 */
	public var n12:Number;

	/**
	 * Matrix4 cell.
	 *
	 * <pre>
	 * 0 0 1 0
	 * 0 0 0 0
	 * 0 0 0 0
	 * 0 0 0 0
	 * </pre>
	 */
	public var n13:Number;

	/**
	 * Matrix4 cell.
	 *
	 * <pre>
	 * 0 0 0 1
	 * 0 0 0 0
	 * 0 0 0 0
	 * 0 0 0 0
	 * </pre>
	 */
	public var n14:Number;

	/**
	 * Matrix4 cell.
	 *
	 * <pre>
	 * 0 0 0 0
	 * 1 0 0 0
	 * 0 0 0 0
	 * 0 0 0 0
	 * </pre>
	 */
	public var n21:Number;

	/**
	 * Matrix4 cell.
	 *
	 * <pre>
	 * 0 0 0 0
	 * 0 1 0 0
	 * 0 0 0 0
	 * 0 0 0 0
	 * </pre>
	 */
	public var n22:Number;

	/**
	 * Matrix4 cell.
	 *
	 * <pre>
	 * 0 0 0 0
	 * 0 0 1 0
	 * 0 0 0 0
	 * 0 0 0 0
	 * </pre>
	 */
	public var n23:Number;

	/**
	 * Matrix4 cell.
	 *
	 * <pre>
	 * 0 0 0 0
	 * 0 0 0 1
	 * 0 0 0 0
	 * 0 0 0 0
	 * </pre>
	 */
	public var n24:Number;

	/**
	 * Matrix4 cell.
	 *
	 * <pre>
	 * 0 0 0 0
	 * 0 0 0 0
	 * 1 0 0 0
	 * 0 0 0 0
	 * </pre>
	 */
	public var n31:Number;

	/**
	 * Matrix4 cell.
	 *
	 * <pre>
	 * 0 0 0 0
	 * 0 0 0 0
	 * 0 1 0 0
	 * 0 0 0 0
	 * </pre>
	 */
	public var n32:Number;

	/**
	 * Matrix4 cell.
	 *
	 * <pre>
	 * 0 0 0 0
	 * 0 0 0 0
	 * 0 0 1 0
	 * 0 0 0 0
	 * </pre>
	 */
	public var n33:Number;

	/**
	 * Matrix4 cell.
	 *
	 * <pre>
	 * 0 0 0 0
	 * 0 0 0 0
	 * 0 0 0 1
	 * 0 0 0 0
	 * </pre>
	 */
	public var n34:Number;

	/**
	 * Matrix4 cell.
	 *
	 * <pre>
	 * 0 0 0 0
	 * 0 0 0 0
	 * 0 0 0 0
	 * 1 0 0 0
	 * </pre>
	 */
	public var n41:Number;

	/**
	 * Matrix4 cell.
	 *
	 * <pre>
	 * 0 0 0 0
	 * 0 0 0 0
	 * 0 0 0 0
	 * 0 1 0 0
	 * </pre>
	 */
	public var n42:Number;

	/**
	 * Matrix4 cell.
	 *
	 * <pre>
	 * 0 0 0 0
	 * 0 0 0 0
	 * 0 0 0 0
	 * 0 0 1 0
	 * </pre>
	 */
	public var n43:Number;

	/**
	 * Matrix4 cell.
	 *
	 * <pre>
	 * 0 0 0 0
	 * 0 0 0 0
	 * 0 0 0 0
	 * 0 0 0 1
	 * </pre>
	 */
	public var n44:Number;

	/**
	 * Creates a new 4x4 matrix. The default is an identity matrix.
	 *
	 * @example The examples below shows the results of calling the constructor with and without parameters. 
	 * <listing version="3.0">
	 * var m:Matrix4 = new Matrix4();
	 * </listing>
	 *
	 * <pre>
	 * 1 0 0 0
	 * 0 1 0 0
	 * 0 0 1 0
	 * 0 0 0 1
	 * </pre>
	 *
	 * <listing version="3.0">
	 * var m:Matrix4 = new Matrix4( 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 );
	 * </listing>
	 *
	 * <pre>
	 * 1  2  3  4
	 * 5  6  7  8
	 * 9  10 11 12
	 * 13 14 15 16
	 * </pre>
	 *
	 * @param pn11	Matrix cell n11.
	 * @param pn12	Matrix cell n12.
	 * @param pn13	Matrix cell n13.
	 * @param pn14	Matrix cell n14.
	 * @param pn21	Matrix cell n21.
	 * @param pn22	Matrix cell n22.
	 * @param pn23	Matrix cell n23.
	 * @param pn24	Matrix cell n24.
	 * @param pn31	Matrix cell n31.
	 * @param pn32	Matrix cell n32.
	 * @param pn33	Matrix cell n33.
	 * @param pn34	Matrix cell n34.
	 * @param pn41	Matrix cell n41.
	 * @param pn42	Matrix cell n42.
	 * @param pn43	Matrix cell n43.
	 * @param pn44	Matrix cell n44.
	 */
	
	public function Matrix4( pn11:Number, pn12:Number, pn13:Number, pn14:Number,
							 pn21:Number, pn22:Number, pn23:Number, pn24:Number,
							 pn31:Number, pn32:Number, pn33:Number, pn34:Number,
							 pn41:Number, pn42:Number, pn43:Number, pn44:Number )
	{
		n11 = pn11||1 ; n12 = pn12||0 ; n13 = pn13||0 ; n14 = pn14||0 ;
		n21 = pn21||0 ; n22 = pn22||1 ; n23 = pn23||0 ; n24 = pn24||0 ;
		n31 = pn31||0 ; n32 = pn32||0 ; n33 = pn33||1 ; n34 = pn34||0 ;
		n41 = pn41||0 ; n42 = pn42||0 ; n43 = pn43||0 ; n44 = pn44||1 ;
		
		USE_FAST_MATH = false;
	}
	
	/**
	 * Makes this matrix into a zero matrix.
	 *
	 * <p>Below is a representation of a zero matrix:</p>
	 *
	 * <pre>
	 * 0 0 0 0
	 * 0 0 0 0
	 * 0 0 0 0
	 * 0 0 0 0
	 * </pre>
	 *
	 * @return	The zero matrix.
	 */
	public function zero() : Void
	{
		n11 = 0 ; n12 = 0 ; n13 = 0 ; n14 = 0;
		n21 = 0 ; n22 = 0 ; n23 = 0 ; n24 = 0;
		n31 = 0 ; n32 = 0 ; n33 = 0 ; n34 = 0;
		n41 = 0 ; n42 = 0 ; n43 = 0 ; n44 = 0;
	}

	/**
	 * Makes this matrix into an identity matrix.
	 *
	 * <p>Below is a representation of a identity matrix:</p>
	 *
	 * <pre>
	 * 1 0 0 0
	 * 0 1 0 0
	 * 0 0 1 0
	 * 0 0 0 1
	 * </pre>
	 *
	 * @return	The identity matrix.
	 */
	public function identity() : Void
	{
		n11 = 1; n12 = 0; n13 = 0; n14 = 0;
		n21 = 0; n22 = 1; n23 = 0; n24 = 0;
		n31 = 0; n32 = 0; n33 = 1; n34 = 0;
		n41 = 0; n42 = 0; n43 = 0; n44 = 1;
	}

	
	/**
	 * Returns a new Matrix4 object that is a clone of the original instance. 
	 * 
	 * @return A new Matrix4 object that is identical to the original. 
	 */	
	public function clone() : Matrix4
	{
		return new Matrix4( n11, n12, n13, n14,
                            n21, n22, n23, n24,
							n31, n32, n33, n34,
							n41, n42, n43, n44 );
	}

	/**
	 * Makes this matrix a copy of a passed in matrix.
	 *
	 * <p>All elements of the argument matrix are copied into this matrix.</p>
	 *
	 * @param m1	The matrix to copy.
	 */
	public function copy( m:Matrix4 ) : Void
	{
		n11 = m.n11; n12 = m.n12; n13 = m.n13; n14 = m.n14;
		n21 = m.n21; n22 = m.n22; n23 = m.n23; n24 = m.n24;
		n31 = m.n31; n32 = m.n32; n33 = m.n33; n34 = m.n34;
		n41 = m.n41; n42 = m.n42; n43 = m.n43; n44 = m.n44;
	}

	/**
	 * Multiplies this matrix by the matrix passed in as if they were 3x3 matrices.
	 *
	 * @param m2	The matrix to multiply with.
	 */
	public function multiply3x3( m2:Matrix4 ) : Void
	{
		var m111:Number = n11, m211:Number = m2.n11,
		m121:Number = n21, m221:Number = m2.n21,
		m131:Number = n31, m231:Number = m2.n31,
		m112:Number = n12, m212:Number = m2.n12,
		m122:Number = n22, m222:Number = m2.n22,
		m132:Number = n32, m232:Number = m2.n32,
		m113:Number = n13, m213:Number = m2.n13,
		m123:Number = n23, m223:Number = m2.n23,
		m133:Number = n33, m233:Number = m2.n33;

		n11 = m111 * m211 + m112 * m221 + m113 * m231;
		n12 = m111 * m212 + m112 * m222 + m113 * m232;
		n13 = m111 * m213 + m112 * m223 + m113 * m233;

		n21 = m121 * m211 + m122 * m221 + m123 * m231;
		n22 = m121 * m212 + m122 * m222 + m123 * m232;
		n23 = m121 * m213 + m122 * m223 + m123 * m233;

		n31 = m131 * m211 + m132 * m221 + m133 * m231;
		n32 = m131 * m212 + m132 * m222 + m133 * m232;
		n33 = m131 * m213 + m132 * m223 + m133 * m233;

		n14 = n24 = n34 = n41 = n42 = n43 = 0;
		n44 = 1;
	}


	/**
	 * Multiplies the upper left 3x3 sub matrix of this matrix by the passed in matrix.
	 *
	 * @param m2	The matrix to multiply with.
	 */
	public function multiply4x3( m2:Matrix4 ) : Void
	{
		var m111:Number = n11, 	m211:Number = m2.n11,
			m121:Number = n21, 	m221:Number = m2.n21,
			m131:Number = n31, 	m231:Number = m2.n31,
			m112:Number = n12, 	m212:Number = m2.n12,
			m122:Number = n22, 	m222:Number = m2.n22,
			m132:Number = n32, 	m232:Number = m2.n32,
			m113:Number = n13, 	m213:Number = m2.n13,
			m123:Number = n23, 	m223:Number = m2.n23,
			m133:Number = n33, 	m233:Number = m2.n33,
						m214:Number = m2.n14,
						m224:Number = m2.n24,
						m234:Number = m2.n34;

		n11 = m111 * m211 + m112 * m221 + m113 * m231;
		n12 = m111 * m212 + m112 * m222 + m113 * m232;
		n13 = m111 * m213 + m112 * m223 + m113 * m233;
		n14 = m214 * m111 + m224 * m112 + m234 * m113 + n14;

		n21 = m121 * m211 + m122 * m221 + m123 * m231;
		n22 = m121 * m212 + m122 * m222 + m123 * m232;
		n23 = m121 * m213 + m122 * m223 + m123 * m233;
		n24 = m214 * m121 + m224 * m122 + m234 * m123 + n24;

		n31 = m131 * m211 + m132 * m221 + m133 * m231;
		n32 = m131 * m212 + m132 * m222 + m133 * m232;
		n33 = m131 * m213 + m132 * m223 + m133 * m233;
		n34 = m214 * m131 + m224 * m132 + m234 * m133 + n34;

		n41 = n42 = n43 = 0;
		n44 = 1;
	}

	/**
	 * Multiplies this matrix by the passed in matrix.
	 *
	 * @param m2	The matrix to multiply with.
	 */
	public function multiply( m2:Matrix4 ) : Void
	{
		var m111:Number = n11, m121:Number = n21, m131:Number = n31, m141:Number = n41,
			m112:Number = n12, m122:Number = n22, m132:Number = n32, m142:Number = n42,
			m113:Number = n13, m123:Number = n23, m133:Number = n33, m143:Number = n43,
			m114:Number = n14, m124:Number = n24, m134:Number = n34, m144:Number = n44,
				
			m211:Number = m2.n11, m221:Number = m2.n21, m231:Number = m2.n31, m241:Number = m2.n41,
			m212:Number = m2.n12, m222:Number = m2.n22, m232:Number = m2.n32, m242:Number = m2.n42,
			m213:Number = m2.n13, m223:Number = m2.n23, m233:Number = m2.n33, m243:Number = m2.n43,
			m214:Number = m2.n14, m224:Number = m2.n24, m234:Number = m2.n34, m244:Number = m2.n44;

		n11 = m111 * m211 + m112 * m221 + m113 * m231 + m114 * m241;
		n12 = m111 * m212 + m112 * m222 + m113 * m232 + m114 * m242;
		n13 = m111 * m213 + m112 * m223 + m113 * m233 + m114 * m243;
		n14 = m111 * m214 + m112 * m224 + m113 * m234 + m114 * m244;

		n21 = m121 * m211 + m122 * m221 + m123 * m231 + m124 * m241;
		n22 = m121 * m212 + m122 * m222 + m123 * m232 + m124 * m242;
		n23 = m121 * m213 + m122 * m223 + m123 * m233 + m124 * m243;
		n24 = m121 * m214 + m122 * m224 + m123 * m234 + m124 * m244;

		n31 = m131 * m211 + m132 * m221 + m133 * m231 + m134 * m241;
		n32 = m131 * m212 + m132 * m222 + m133 * m232 + m134 * m242;
		n33 = m131 * m213 + m132 * m223 + m133 * m233 + m134 * m243;
		n34 = m131 * m214 + m132 * m224 + m133 * m234 + m134 * m244;

		n41 = m141 * m211 + m142 * m221 + m143 * m231 + m144 * m241;
		n42 = m141 * m212 + m142 * m222 + m143 * m232 + m144 * m242;
		n43 = m141 * m213 + m142 * m223 + m143 * m233 + m144 * m243;
		n44 = m141 * m214 + m142 * m224 + m143 * m234 + m144 * m244

	}

	/**
	 * Adds the passed in matrix to this matrix.
	 *
	 * <p>This passed in matrix is added to this matrix element by element:<br />
	 * <code>n11 = n11 + m2.n11</code><br />
	 * <code>n11 = n12 + m2.n12</code><br />
	 * ...</p>
	 *
	 * @param m2	The matrix to add to this matrix.
	 */
	public function addMatrix( m2:Matrix4 ) :  Void
	{
		n11 += m2.n11; 
		n12 += m2.n12; 
		n13 += m2.n13; 
		n14 += m2.n14;
		n21 += m2.n21; 
		n22 += m2.n22; 
		n23 += m2.n23; 
		n24 += m2.n24;
		n31 += m2.n31; 
		n32 += m2.n32; 
		n33 += m2.n33; 
		n34 += m2.n34;
		n41 += m2.n41; 
		n42 += m2.n42; 
		n43 += m2.n43; 
		n44 += m2.n44;
	}

	/**
	 * Multiplies a vertex with this matrix.
	 *
	 * @param pv	The vertex to be mutliplied
	 */
	public function vectorMult( pv:Vector ) : Void
	{
		var x:Number = pv.x, y:Number = pv.y, z:Number = pv.z;
		pv.x = ( x * n11 + y * n12 + z * n13 + n14 );
		pv.y = ( x * n21 + y * n22 + z * n23 + n24 );
		pv.z = ( x * n31 + y * n32 + z * n33 + n34 );
	}

	/**
	 * Creates transformation matrix from axis and translation vectors.
	 * 
	 * @param	px X axis vector.
	 * @param	py Y axis vector.
	 * @param	pz Z axis vector.
	 * @param	pt translation vector.
	 */
	public function fromVectors( px:Vector, py:Vector, pz:Vector, pt:Vector ) : Void
	{
		zero();
		n11 = px.x; n21 = px.y; n31 = px.z;
		n12 = py.x; n22 = py.y; n32 = py.z;
		n13 = pz.x; n23 = pz.y; n33 = pz.z;
		n14 = pt.x; n24 = pt.y; n34 = pt.z;
	}
	
	/**
	 * Multiplies a vector with the upper left 3x3 sub matrix of this matrix.
	 *
	 * @param pv	The vector to be multiplied.
	 */
	public function vectorMult3x3( pv:Vector ) : Void
	{
		var x:Number = pv.x, y:Number = pv.y, z:Number = pv.z;
		pv.x = ( x * n11 + y * n12 + z * n13 );
		pv.y = ( x * n21 + y * n22 + z * n23 );
		pv.z = ( x * n31 + y * n32 + z * n33 );
	}
		
	/**
	 * Makes this matrix a rotation matrix for the given angle of rotation around the x axis.
	 * 
	 * @param angle	The angle of rotation around the x axis in degrees.
	 */
	public function rotationX( angle:Number ) : Void
	{
		identity();
		//
		angle = NumberUtil.toRadian( angle );
		var c:Number = ( USE_FAST_MATH == false ) ? Math.cos( angle ) : FastMath.cos( angle );
		var s:Number = ( USE_FAST_MATH == false ) ? Math.sin( angle ) : FastMath.sin( angle );
		//
		n22 =  c;
		n23 =  -s;
		n32 = s;
		n33 =  c;
	}

	/**
	 * Makes this matrix a rotation matrix for the given angle of rotation around the y axis.
	 * 
	 * @param angle	The angle of rotation around the y axis in degrees.
	 */
	public function rotationY( angle:Number ) :  Void
	{
		identity();
		//
		angle = NumberUtil.toRadian( angle );
		var c:Number = ( USE_FAST_MATH == false ) ? Math.cos( angle ) : FastMath.cos( angle );
		var s:Number = ( USE_FAST_MATH == false ) ? Math.sin( angle ) : FastMath.sin( angle );
		// --
		n11 =  c;
		n13 = -s;
		n31 =  s;
		n33 =  c;
	}

	/**
	 * Makes this matrix a rotation matrix for the given angle of rotation around the z axis.
	 * 
	 * @param angle	The angle of rotation around the z axis in degrees.
	 */
	public function rotationZ ( angle:Number ) : Void
	{
		identity();
		//
		angle = NumberUtil.toRadian( angle );
		var c:Number = ( USE_FAST_MATH == false ) ? Math.cos( angle ) : FastMath.cos( angle );
		var s:Number = ( USE_FAST_MATH == false ) ? Math.sin( angle ) : FastMath.sin( angle );
		// --
		n11 =  c;
		n12 =  -s;
		n21 = s;
		n22 =  c;
	}

	/**
	 * Makes this matrix a rotation matrix for a rotation around a given axis.
	 *
	 * @param v 	The axis of rotation.
	 * @param angle	The angle of rotation in degrees.
	 */
	public function axisRotationVector ( v:Vector, angle:Number ) : Void
	{
		axisRotation( v.x, v.y, v.z, angle );
	}
		
	
	/**
	 * Makes this matrix a translation matrix from coordinates.
	 * 
	 * <pre>
	 * 1  0  0  0
	 * 0  1  0  0
	 * 0  0  1  0
	 * Tx Ty Tz 1
	 * </pre>
	 *
	 * @param nTx	Translation in the x direction.
	 * @param nTy	Translation in the y direction.
	 * @param nTz	Translation in the z direction.
	 */
	public function translation( nTx:Number, nTy:Number, nTz:Number ) : Void
	{
		identity()
		//
		n14 = nTx;
		n24 = nTy;
		n34 = nTz;
	}

	/**
	 * Makes this matrix a translation matrix from a vector.
	 *
	 * <pre>
	 * 1   0   0   0
	 * 0   1   0   0
	 * 0   0   1   0
	 * v.x v.y v.z 1
	 * </pre>
	 *
	 * @param v 	The translation vector.
	 */
	public function translationVector( v:Vector ) : Void
	{
		identity()
		//
		n14 = v.x;
		n24 = v.y;
		n34 = v.z;
	}

	/**
	 * Makes this matrix a scale matrix from scale components.
	 *
	 * <pre>
	 * |Sx 0  0  0|
	 * |0  Sy 0  0|
	 * |0  0  Sz 0|
	 * |0  0  0  1|
	 * </pre>
	 *
	 * @param nXScale 	x-scale.
	 * @param nYScale 	y-scale.
	 * @param nZScale	z-scale.
	 */
	public function scale( nXScale:Number, nYScale:Number, nZScale:Number ) : Void
	{
		identity()
		//
		n11 = nXScale;
		n22 = nYScale;
		n33 = nZScale;
	}

	/**
	 * Makes this matrix a scale matrix from coordinates.
	 *
	 * <pre>
	 * Sx 0  0  0
	 * 0  Sy 0  0
	 * 0  0  Sz 0
	 * 0  0  0  1
	 * </pre>
	 *
	 * @param nXScale 	x-scale.
	 * @param nYScale 	y-scale.
	 * @param nZScale	z-scale.
	 */
	public function scaleVector( v:Vector ) : Void
	{
		identity()
		//
		n11 = v.x;
		n22 = v.y;
		n33 = v.z;
	}

	/**
	* Returns the determinant of this matrix.
	*
	* @return The determinant.
	*/
	public function det() : Number
	{
		return		( n11 * n22 - n21 * n12 ) * ( n33 * n44 - n43 * n34 ) - ( n11 * n32 - n31 * n12 ) * ( n23 * n44 - n43 * n24 )
				 + 	( n11 * n42 - n41 * n12 ) * ( n23 * n34 - n33 * n24 ) + ( n21 * n32 - n31 * n22 ) * ( n13 * n44 - n43 * n14 )
				 - 	( n21 * n42 - n41 * n22 ) * ( n13 * n34 - n33 * n14 ) + ( n31 * n42 - n41 * n32 ) * ( n13 * n24 - n23 * n14 );
	}

	/**
	* Returns the determinant of the upper left 3x3 sub matrix of this matrix.
	*
	* @return The determinant.
	*/
	public function det3x3() : Number
	{
		return n11 * ( n22 * n33 - n23 * n32 ) + n21 * ( n32 * n13 - n12 * n33 ) + n31 * ( n12 * n23 - n22 * n13 );
	}

	/**
	 * Returns the trace of the matrix.
	 *
	 * <p>The trace value is the sum of the element on the diagonal of the matrix.</p>
	 *
	 * @return The trace value.
	 */
	public function getTrace() : Number
	{
		return n11 + n22 + n33 + n44;
	}
	
	/**
	* Inverts this matrix.
	*/
	public function inverse() : Void
	{
		//take the determinant
		var d:Number = det();
		if( Math.abs( d ) < 0.001 )
		{
			throw new Error( "Warning: cannot invert a matrix with a null determinant." );
			return;
		}

		//We use Cramer formula, so we need to devide by the determinant. We prefer multiply by the inverse
		d = 1/d;
		var		m11:Number = n11, m21:Number = n21, m31:Number = n31, m41:Number = n41,
				m12:Number = n12, m22:Number = n22, m32:Number = n32, m42:Number = n42,
				m13:Number = n13, m23:Number = n23, m33:Number = n33, m43:Number = n43,
				m14:Number = n14, m24:Number = n24, m34:Number = n34, m44:Number = n44;
			
		n11 =  d * ( m22 * ( m33 * m44 - m43 * m34 ) - m32 * ( m23 * m44 - m43 * m24 ) + m42 * ( m23 * m34 - m33 * m24 ) );
		n12 = -d * ( m12 * ( m33 * m44 - m43 * m34 ) - m32 * ( m13 * m44 - m43 * m14 ) + m42 * ( m13 * m34 - m33 * m14 ) );
		n13 =  d * ( m12 * ( m23 * m44 - m43 * m24 ) - m22 * ( m13 * m44 - m43 * m14 ) + m42 * ( m13 * m24 - m23 * m14 ) );
		n14 = -d * ( m12 * ( m23 * m34 - m33 * m24 ) - m22 * ( m13 * m34 - m33 * m14 ) + m32 * ( m13 * m24 - m23 * m14 ) );
		n21 = -d * ( m21 * ( m33 * m44 - m43 * m34 ) - m31 * ( m23 * m44 - m43 * m24 ) + m41 * ( m23 * m34 - m33 * m24 ) );
		n22 =  d * ( m11 * ( m33 * m44 - m43 * m34 ) - m31 * ( m13 * m44 - m43 * m14 ) + m41 * ( m13 * m34 - m33 * m14 ) );
		n23 = -d * ( m11 * ( m23 * m44 - m43 * m24 ) - m21 * ( m13 * m44 - m43 * m14 ) + m41 * ( m13 * m24 - m23 * m14 ) );
		n24 =  d * ( m11 * ( m23 * m34 - m33 * m24 ) - m21 * ( m13 * m34 - m33 * m14 ) + m31 * ( m13 * m24 - m23 * m14 ) );
		n31 =  d * ( m21 * ( m32 * m44 - m42 * m34 ) - m31 * ( m22 * m44 - m42 * m24 ) + m41 * ( m22 * m34 - m32 * m24 ) );
		n32 = -d * ( m11 * ( m32 * m44 - m42 * m34 ) - m31 * ( m12 * m44 - m42 * m14 ) + m41 * ( m12 * m34 - m32 * m14 ) );
		n33 =  d * ( m11 * ( m22 * m44 - m42 * m24 ) - m21 * ( m12 * m44 - m42 * m14 ) + m41 * ( m12 * m24 - m22 * m14 ) );
		n34 = -d * ( m11 * ( m22 * m34 - m32 * m24 ) - m21 * ( m12 * m34 - m32 * m14 ) + m31 * ( m12 * m24 - m22 * m14 ) );
		n41 = -d * ( m21 * ( m32 * m43 - m42 * m33 ) - m31 * ( m22 * m43 - m42 * m23 ) + m41 * ( m22 * m33 - m32 * m23 ) );
		n42 =  d * ( m11 * ( m32 * m43 - m42 * m33 ) - m31 * ( m12 * m43 - m42 * m13 ) + m41 * ( m12 * m33 - m32 * m13 ) );
		n43 = -d * ( m11 * ( m22 * m43 - m42 * m23 ) - m21 * ( m12 * m43 - m42 * m13 ) + m41 * ( m12 * m23 - m22 * m13 ) );
		n44 =  d * ( m11 * ( m22 * m33 - m32 * m23 ) - m21 * ( m12 * m33 - m32 * m13 ) + m31 * ( m12 * m23 - m22 * m13 ) );
	}

	/**
	 * Realize a rotation around a specific axis through a specified point.
	 *
	 * <p>A rotation by a specified angle around a specified axis through a specific position ( the reference point ),
	 * is applied to this matrix.</p>
	 *
	 * @param pAxis 	A vector representing the axis of the rotation.
	 * @param ref 		The reference point.
	 * @param pAngle	The angle of rotation in degrees.
	 */
	public function axisRotationWithReference( axis:Vector, ref:Vector, pAngle:Number ) : Void
	{
		var tmp:Matrix4 = new Matrix4();
		var angle:Number = ( pAngle + 360 ) % 360;
		translation ( ref.x, ref.y, ref.z );
		tmp.axisRotation( axis.x, axis.y, axis.z, angle )
		multiply ( tmp );
		tmp.translation ( -ref.x, -ref.y, -ref.z )
		multiply ( tmp );
		tmp = null;
	}

	/**
	 * Returns a string representation of this object.
	 *
	 * @return	The fully qualified name of this object.
	 */
	public function toString() :  String
	{
		var s:String =  "sandy.core.data.Matrix4" + "\n ( ";
		s += n11 + "\t" + n12 + "\t" + n13 + "\t" + n14 + "\n";
		s += n21 + "\t" + n22 + "\t" + n23 + "\t" + n24 + "\n";
		s += n31 + "\t" + n32 + "\t" + n33 + "\t" + n34 + "\n";
		s += n41 + "\t" + n42 + "\t" + n43 + "\t" + n44 + "\n )";
		return s;
	}
		
	/**
	 * Returns a vector that contains the 3D position information.
	 * 
	 * @return A vector.
	 */
	public function getTranslation() : Vector
	{
		return new Vector( n14, n24, n34 );
	}
		
	/**
	 * Computes a rotation around an axis.
	 *
	 * @param u		X rotation.
	 * @param v		Y rotation.
	 * @param w		Z rotation.
	 * @param angle	The angle of rotation in degrees.
	 */
	public function axisRotation( u:Number, v:Number, w:Number, angle:Number ) : Void
	{
		identity()
		//
		angle = NumberUtil.toRadian( angle );
		// -- modification pour verifier qu'il n'y ai pas un probleme de precision avec la camera
		var c:Number = ( USE_FAST_MATH == false ) ? Math.cos( angle ) : FastMath.cos( angle );
		var s:Number = ( USE_FAST_MATH == false ) ? Math.sin( angle ) : FastMath.sin( angle );
		var scos:Number	= 1 - c ;
		// --
		var suv:Number = u * v * scos;
		var svw:Number = v * w * scos;
		var suw:Number = u * w * scos;
		var sw:Number  = s * w		 ;
		var sv:Number  = s * v		 ;
		var su:Number  = s * u 		 ;
			
		n11  =  c + u * u * scos;
		n12  = -sw + suv 	 	;
		n13  =  sv + suw	 	;

		n21  =  sw + suv 	 	;
		n22  =  c + v * v * scos;
		n23  = -su + svw	 	;
	
		n31  = -sv + suw 		;
		n32  =  su + svw 		;
		n33  =  c + w * w * scos;
	}
		
	/**
	 * Computes a rotation from the Euler angle in degrees.
	 *
	 * @param ax	The angle of rotation around the X axis in degrees.
	 * @param ay	The angle of rotation around the Y axis in degrees.
	 * @param az	The angle of rotation around the Z axis in degrees.
	 */
	public function eulerRotation( ax:Number, ay:Number, az:Number ) : Void
	{
		identity();
		// signs are changed due to left coordinate system
		ax = -NumberUtil.toRadian( ax );
		ay =  NumberUtil.toRadian( ay );
		az = -NumberUtil.toRadian( az );
		// --
		var a:Number = ( USE_FAST_MATH == false ) ? Math.cos( ax ) : FastMath.cos( ax );
		var b:Number = ( USE_FAST_MATH == false ) ? Math.sin( ax ) : FastMath.sin( ax );
		var c:Number = ( USE_FAST_MATH == false ) ? Math.cos( ay ) : FastMath.cos( ay );
		var d:Number = ( USE_FAST_MATH == false ) ? Math.sin( ay ) : FastMath.sin( ay );
		var e:Number = ( USE_FAST_MATH == false ) ? Math.cos( az ) : FastMath.cos( az );
		var f:Number = ( USE_FAST_MATH == false ) ? Math.sin( az ) : FastMath.sin( az );
		var ad:Number = a * d;
		var bd:Number = b * d;
		// signs are changed to match formulas 46 to 54 at http://mathworld.wolfram.com/EulerAngles.html
		n11 =   c  * e        ;
		n12 =   c  * f        ;
		n13 = - d             ;
		n21 =   bd * e - a * f;
		n22 =   bd * f + a * e;
		n23 =   b  * c 	 	  ;
		n31 =   ad * e + b * f;
		n32 =   ad * f - b * e;
		n33 =   a  * c        ;
	}
	
	/**
	 * Get the Euler angles from the rotation matrix.
	 *
	 * @return A vector representing the Euler angles.
	 */
	public function getEulerAngles() : Vector
	{
		// is there any point in NumberUtil.TO_DEGREE ?
		var lToDegree:Number = 57.295779513;

		// we cannot know real sign of lAngleY from n13 alone
		var lAngleY:Number = Math.asin( -this.n13 ) * lToDegree;

		var lAngleX:Number, lAngleZ:Number;

		if( !NumberUtil.isZero( Math.abs( this.n13 ) - 1 ) )
		{
			lAngleX = -Math.atan2( this.n23, this.n33 ) * lToDegree;
			lAngleZ = -Math.atan2( this.n12, this.n11 ) * lToDegree;
		}
		else
		{
			lAngleX = 0;
			lAngleZ = Math.atan2( -this.n21, this.n22 );
		}
			
		if( lAngleX < 0 ) lAngleX += 360;
		if( lAngleY < 0 ) lAngleY += 360;
		if( lAngleZ < 0 ) lAngleZ += 360;
		
		return new Vector( lAngleX, lAngleY, lAngleZ );
	}
	
	private function _givensRotation( a:Number, b:Number ) : Vector
	{
		// zeroes element corresponding to b
		// per http://en.wikipedia.org/wiki/Givens_rotation#Stable_calculation
		var s:Number, c:Number, r:Number, t:Number, u:Number;
		if( b == 0 )
		{
			c = ( a > 0 ) ? 1 : -1; s = 0; r = Math.abs( a );
		} 
		else if( a == 0 ) 
		{
			c = 0; s = ( b > 0 ) ? 1 : -1; r < Math.abs( b );
		} 
		else if( Math.abs( b ) > Math.abs( a ) )
		{
			t = a / b; u = Math.sqrt( 1 + t * t ) * ( ( b > 0 ) ? 1 : -1 );
			s = 1 / u; c = s * t; r = b * u;
		}
		else 
		{
			t = b / a; u = Math.sqrt( 1 + t * t ) * ( ( a > 0 ) ? 1 : -1 );
			c = 1 / u; s = c * t; r = a * u;
		}
		return new Vector( s, c, r );
	}

	/**
	 * Get the Euler angles from any matrix. This method performs QR decomposition of the matrix
	 * in order to extract rotation information. For best performance, use getEulerAngles method
	 * for rotation matrices.
	 *
	 * @return A vector representing the Euler angles.
	 */ 
	/* --- Removed until the bugs are removed.
	
	public function getEulerAnglesQR() : Vector
	{
		// QR decomposition using Givens rotations: we compute Q^T = G3 * G2 * G1
		// this means, I think, that Q = G1^T * G2^T * G3^T, and Givens to Euler
		// correspondence is ax: G1^T, ay: G2^T, az: G3^T
		var ax:Number, ay:Number, az:Number, s:Number, c:Number, v:Vector;

		// G1: http://mathworld.wolfram.com/EulerAngles.html eq. 45
		v = _givensRotation( n22, n32 );
		s = v.x; c = v.y; ax = -Math.atan2( s, c );
		var G1:Matrix4 = new Matrix4();
		G1.n22 =  c; G1.n23 = s;
		G1.n32 = -s; G1.n33 = c;
		G1.multiply( this ); // G1 <- G1 * A

		// G2: http://mathworld.wolfram.com/EulerAngles.html eq. 44, changed to get stable Y
		v = _givensRotation( G1.n11, G1.n31 );
		s = v.x; c = v.y; ay = +Math.atan2( s, c );
		var G2:Matrix4 = new Matrix4();
		G2.n11 =  c; G2.n13 = +s;
		G2.n31 = -s; G2.n33 =  c;
		G2.multiply( G1 ); // G2 <- G2 * G1 * A

		// G3: http://mathworld.wolfram.com/EulerAngles.html eq. 43
		v = _givensRotation( G2.n11, G2.n21 );
		s = v.x; c = v.y; az = -Math.atan2( s, c );
		var G3:Matrix4 = new Matrix4();
		G3.n11 =  c; G3.n12 = s;
		G3.n21 = -s; G3.n22 = c;
		G3.multiply( G2 ); // G3 <- G3 * G2 * G1 * A, residual matrix R
		trace( G3 );
		G1 = null; G2 = null; G3 = null;

		// is there any point in NumberUtil.TO_DEGREE ?
		var lToDegree:Number = 57.295779513;
		ax *= -lToDegree;
		ay *=  lToDegree;
		az *= -lToDegree;

		if( ax < 0 ) ax += 360;
		if( ay < 0 ) ay += 360;
		if( az < 0 ) az += 360;
			
		return new Vector( ax, ay, az );
	}
	
	/**
	 * Get a string representation of the {@code Matrix4} in a format useful for XML output.
	 *
	 * @return	A serialized String representing the {@code Matrix4}.
	 */
	public function serialize( d:Number ) : String
	{
		if( !d ) d = .000001;
		var round:Function = NumberUtil.roundTo;
		var s:String = new String( "" );
		s += round( n11, d ) + "," + round( n12, d ) + "," + round( n13, d ) + "," + round( n14, d ) + ",";
		s += round( n21, d ) + "," + round( n22, d ) + "," + round( n23, d ) + "," + round( n24, d ) + ",";
		s += round( n31, d ) + "," + round( n32, d ) + "," + round( n33, d ) + "," + round( n34, d ) + ",";
		s += round( n41, d ) + "," + round( n42, d ) + "," + round( n43, d ) + "," + round( n44, d );
		return s;
	}
		
	/**
	 * Convert a string representation in a {@code Matrix4}; useful for XML input
	 *
	 * @return	A {@code Matrix4} equivalent to the input string
	 */
	public static function deserialize( convertFrom:String ) : Matrix4
	{
		//trace ( "Matrix4.Deserialize convertFrom " + convertFrom );
				
		var tmp:Array = convertFrom.split( "," );
		if( tmp.length != 16 ) {
			trace ( "Unexpected length of string to deserialize into a matrix4 " + convertFrom );
		}
		for( var i:Number = 0; i < tmp.length; i++ ) {
			tmp[ i ] = Number( tmp[ i ] );
		}
		var temp2:Matrix4 = new Matrix4 ( tmp[ 0 ], tmp[ 1 ], tmp[ 2 ], tmp[ 3 ], tmp[ 4 ], tmp[ 5 ], tmp[ 6 ], tmp[ 7 ],
										  tmp[ 8 ], tmp[ 9 ], tmp[ 10 ], tmp[ 11 ], tmp[ 12 ], tmp[ 13 ], tmp[ 14 ], tmp[ 15 ] );
		//trace ( "temp2 in Matrix4.deserialize is " + temp2 );
		return temp2;
	}
		
}
