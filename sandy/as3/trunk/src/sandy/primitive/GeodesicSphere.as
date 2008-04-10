﻿/*
 * Copyright 2007 (c) Gabriel Putnam
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

package sandy.primitive
{
//	import sandy.core.data.Vertex;
	import sandy.core.data.UVCoord;
	import sandy.core.scenegraph.Geometry3D;
	import sandy.core.scenegraph.Shape3D;
	
	/**
	* GeodesicSphere implements dome, a kind of sphere tesselation with evenly distributed triangles.
	*
	* <p>This primitive is ported from Away3D as is (with the exception of U/V mapping).</p>
	*
	* @author		makc
	* @version		3.0.3
	* @date 		10.04.2008
	*
	* @see http://en.wikipedia.org/wiki/Geodesic_dome
	*/
	public class GeodesicSphere extends Shape3D implements Primitive3D {
		 
		private var radius_in:Number;
        private var fractures_in:int;
		
		/**
		* Creates a GeodesicSphere primitive.
		*
		* @param p_sName	A string identifier for this object.
		* @param p_nRadius	Sphere radius.
		* @param p_nFractures	Tesselation quality.
		*/
		public function GeodesicSphere ( p_sName:String=null, p_nRadius : Number = 100, p_nFractures : Number = 2)
        {
            super (p_sName);

			radius_in = p_nRadius;
            fractures_in = Math.max (2, p_nFractures);
			 
			geometry = generate ();
		}
		
		/**
		* @private
		*/
		public function generate (... arguments):Geometry3D
		{
			var l_oGeometry3D:Geometry3D = new Geometry3D();

			// Set up variables for keeping track of the vertices, faces, and texture coords.
			var nVertices:int = 0, nFaces:int = 0;
			
			// Set up variables for keeping track of the number of iterations and the angles
			var iVerts:uint = fractures_in + 1, jVerts:uint;
			var j:uint, Theta:Number=0, Phi:Number=0, ThetaDel:Number, PhiDel:Number;
			var cosTheta:Number, sinTheta:Number, rcosPhi:Number, rsinPhi:Number;

			// Although original code used quite clever diamond projection, let's change it to
			// equirectangular just to see how it performs compared to standard Sphere - makc

			var Pd4:Number = Math.PI / 4, cosPd4:Number = Math.cos(Pd4), sinPd4:Number = Math.sin(Pd4), PIInv:Number = 1/Math.PI;
			var R_00:Number = cosPd4, R_01:Number = -sinPd4, R_10:Number = sinPd4, R_11:Number = cosPd4;

			PhiDel = Math.PI / ( 2 * iVerts);
			// Build the top vertex
			l_oGeometry3D.setVertex (nVertices, 0, radius_in, 0);
			l_oGeometry3D.setUVCoords (nVertices, 0.5, 0); nVertices++;
			Phi += PhiDel;
			// Build the tops worth of vertices for the sphere progressing in rings around the sphere
			var i:int;
			
			for( i = 1 ; i <= iVerts; i++ ){
				j = 0;
				jVerts = i*4;
				Theta = 0;
				ThetaDel = 2* Math.PI / jVerts;
				rcosPhi = Math.cos( Phi ) * radius_in;
				rsinPhi = Math.sin( Phi ) * radius_in;
				for( j; j < jVerts; j++ ){
					
					// some code removed here, may result in useles vars above.

					cosTheta = Math.cos( Theta );
					sinTheta = Math.sin( Theta );

					l_oGeometry3D.setVertex (nVertices, cosTheta * rsinPhi, rcosPhi, sinTheta * rsinPhi);
					l_oGeometry3D.setUVCoords (nVertices, Theta * PIInv * 0.5, Phi * PIInv); nVertices++;

					Theta += ThetaDel;
				}
				Phi += PhiDel;
			}
			// Build the bottom worth of vertices for the sphere.
			i = iVerts-1;
			for( i; i >0; i-- ){
				j = 0;
				jVerts = i*4;
				Theta = 0;
				ThetaDel = 2* Math.PI / jVerts;
				rcosPhi = Math.cos( Phi ) * radius_in;
				rsinPhi = Math.sin( Phi ) * radius_in;
				for( j; j < jVerts; j++ ){
					cosTheta = Math.cos( Theta );
					sinTheta = Math.sin( Theta );
					l_oGeometry3D.setVertex (nVertices, cosTheta * rsinPhi, rcosPhi, sinTheta * rsinPhi);
					l_oGeometry3D.setUVCoords (nVertices, Theta * PIInv * 0.5, Phi * PIInv); nVertices++;
					Theta += ThetaDel;
				}
				Phi += PhiDel;
			}
			
			// Build the last vertice
			l_oGeometry3D.setVertex (nVertices, 0, -radius_in, 0);
			l_oGeometry3D.setUVCoords (nVertices, 0.5, 1); nVertices++;

			// Build the faces for the sphere
			// Build the upper four sections
			var k:uint, L_Ind_s:uint, U_Ind_s:uint, U_Ind_e:uint, L_Ind_e:uint, L_Ind:uint, U_Ind:uint;
			var isUpTri:Boolean, Pt0:uint, Pt1:uint, Pt2:uint, tPt:uint, triInd:uint, tris:uint;
			tris = 1;
			L_Ind_s = 0; L_Ind_e = 0;
			for( i = 0; i < iVerts; i++ ){
				U_Ind_s = L_Ind_s;
				U_Ind_e = L_Ind_e;
				if( i == 0 ) L_Ind_s++;
				L_Ind_s += 4*i;
				L_Ind_e += 4*(i+1);
				U_Ind = U_Ind_s;
				L_Ind = L_Ind_s;
				for( k = 0; k < 4; k++ ){
					isUpTri = true;
					for( triInd = 0; triInd < tris; triInd++ ){
						if( isUpTri ){
							Pt0 = U_Ind;
							Pt1 = L_Ind;
							L_Ind++;
							if( L_Ind > L_Ind_e ) L_Ind = L_Ind_s;
							Pt2 = L_Ind;
							isUpTri = false;
						} else {
							Pt0 = L_Ind;
							Pt2 = U_Ind;
							U_Ind++;
							if( U_Ind > U_Ind_e ) U_Ind = U_Ind_s;
							Pt1 = U_Ind;
							isUpTri = true;
						}
						l_oGeometry3D.setFaceVertexIds (nFaces, Pt0, Pt1, Pt2);
						l_oGeometry3D.setFaceUVCoordsIds (nFaces, Pt0, Pt1, Pt2); nFaces++;
					}
				}
				tris += 2;
			}
			U_Ind_s = L_Ind_s; U_Ind_e = L_Ind_e;
			// Build the lower four sections
			 
			for( i = iVerts-1; i >= 0; i-- ){
				L_Ind_s = U_Ind_s; L_Ind_e = U_Ind_e; U_Ind_s = L_Ind_s + 4*(i+1); U_Ind_e = L_Ind_e + 4*i;
				if( i == 0 ) U_Ind_e++;
				tris -= 2;
				U_Ind = U_Ind_s;
				L_Ind = L_Ind_s;
				for( k = 0; k < 4; k++ ){
					isUpTri = true;
					for( triInd = 0; triInd < tris; triInd++ ){
						if( isUpTri ){
							Pt0 = U_Ind;
							Pt1 = L_Ind;
							L_Ind++;
							if( L_Ind > L_Ind_e ) L_Ind = L_Ind_s;
							Pt2 = L_Ind;
							isUpTri = false;
						} else {
							Pt0 = L_Ind;
							Pt2 = U_Ind;
							U_Ind++;
							if( U_Ind > U_Ind_e ) U_Ind = U_Ind_s;
							Pt1 = U_Ind;
							isUpTri = true;
						}
						l_oGeometry3D.setFaceVertexIds (nFaces, Pt0, Pt2, Pt1);
						l_oGeometry3D.setFaceUVCoordsIds (nFaces, Pt0, Pt2, Pt1); nFaces++;
					}
				}
			}
			return l_oGeometry3D;
		}
	}
}