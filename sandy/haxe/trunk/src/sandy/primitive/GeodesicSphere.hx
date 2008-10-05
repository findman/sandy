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

package sandy.primitive;

import sandy.core.scenegraph.Geometry3D;
import sandy.core.scenegraph.Shape3D;
import sandy.core.data.Vector;

/**
* GeodesicSphere implements octahedron-based geodesic sphere.
*
* <p>Compared to regular sphere, this primitive produces geometry with more
* evenly distributed triangles (code ported from Away3D mostly as is, with
* the exception of U/V mapping).</p>
*
* @author		makc
* @author  Niel Drummond (haXe port)
*
* @see http://en.wikipedia.org/wiki/Geodesic_dome
* @see http://en.wikipedia.org/wiki/Octahedron
*/
class GeodesicSphere extends Shape3D, implements Primitive3D {
	 
	private var radius_in:Float;
	private var fractures_in:Int;
	
	/**
	* Creates a GeodesicSphere primitive.
	*
	* @param p_sName	A string identifier for this object.
	* @param p_nRadius	Sphere radius.
	* @param p_nFractures	Tesselation quality.
	*/
	public function new ( p_sName:String=null, p_nRadius : Float = 100.0, p_nFractures : Int = 2)
	{
			super (p_sName);

			radius_in = p_nRadius;
			fractures_in = Std.int(Math.max (2, p_nFractures));

			geometry = generate ();
	}
	
	/**
	* @private
	*/
	public function generate ( ?arguments:Array<Dynamic> ):Geometry3D
	{
		var l_oGeometry3D:Geometry3D = new Geometry3D();

		// Set up variables for keeping track of the vertices, faces, and texture coords.
		var nVertices:Int = 0, nFaces:Int = 0;
		var aPacificFaces:Array<Array<Int>> = [], aVertexNormals:Array<Vector> = [];
		
		// Set up variables for keeping track of the number of iterations and the angles
		var iVerts:UInt = fractures_in + 1, jVerts:UInt;
		var j:UInt, Theta:Float=0.0, Phi:Float=0.0, ThetaDel:Float, PhiDel:Float;
		var cosTheta:Float, sinTheta:Float, cosPhi:Float, sinPhi:Float;

		// Although original code used quite clever diamond projection, let's change it to
		// equirectangular just to see how it performs compared to standard Sphere - makc

		var Pd4:Float = Math.PI / 4, cosPd4:Float = Math.cos(Pd4), sinPd4:Float = Math.sin(Pd4), PIInv:Float = 1/Math.PI;
		var R_00:Float = cosPd4, R_01:Float = -sinPd4, R_10:Float = sinPd4, R_11:Float = cosPd4;

		PhiDel = Math.PI / ( 2 * iVerts);

		Phi += PhiDel;

		// Build vertices for the sphere progressing in rings around the sphere
		var i:Int, q:Int, aI:Array<Int> = [];
		for (q in 1...(iVerts-1)) aI.push (q);
		var q = iVerts -1;
		while ( q > 0) {aI.push (q); q--;}

		for (q in 0...aI.length) {
			i = aI[q]; j = 0; jVerts = i*4;
			Theta = 0;
			ThetaDel = 2* Math.PI / jVerts;
			cosPhi = Math.cos( Phi );
			sinPhi = Math.sin( Phi );
			for( j in j...jVerts )
			{
				cosTheta = Math.cos( Theta );
				sinTheta = Math.sin( Theta );

				l_oGeometry3D.setVertex (nVertices, cosTheta * sinPhi * radius_in, cosPhi * radius_in, sinTheta * sinPhi * radius_in);
				l_oGeometry3D.setVertexNormal (nVertices, cosTheta * sinPhi, cosPhi, sinTheta * sinPhi);
				l_oGeometry3D.setUVCoords (nVertices, Theta * PIInv * 0.5, Phi * PIInv); nVertices++;

				Theta += ThetaDel;
			}
			Phi += PhiDel;
		}
		
		// Four triangles meet at every pole, so we make 8 polar vertices to reduce polar distortions
		for (i in 0...8)
		{
			l_oGeometry3D.setVertex (nVertices + i, 0, (i < 4) ? radius_in : -radius_in, 0);
			l_oGeometry3D.setVertexNormal (nVertices + i, 0, (i < 4) ? 1 : -1, 0);
			l_oGeometry3D.setUVCoords (nVertices + i, 0.25 * (i%4 + 0.5), (i < 4) ? 0 : 1);
		}

		// Build the faces for the sphere
		// Build the upper four sections
		var k:UInt, L_Ind_s:UInt, U_Ind_s:UInt, U_Ind_e:UInt, L_Ind_e:UInt, L_Ind:UInt, U_Ind:UInt;
		var isUpTri:Bool, Pt0:UInt, Pt1:UInt, Pt2:UInt, tPt:UInt, triInd:UInt, tris:UInt;
		tris = 1;
		L_Ind_s = 0; L_Ind_e = 0;
		for( i in 0...iVerts ){
			U_Ind_s = L_Ind_s;
			U_Ind_e = L_Ind_e;
			if( i == 0 ) L_Ind_s++;
			L_Ind_s += 4*i;
			L_Ind_e += 4*(i+1);
			U_Ind = U_Ind_s;
			L_Ind = L_Ind_s;
			for( k in 0...4 ){
				isUpTri = true;
				for( triInd in 0...tris ){
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
						if( U_Ind > U_Ind_e ) {
							// pacific problem - correct vertex does not exist
							aPacificFaces.push (
								(Pt2 % 2 == 0) ?
								[ Pt2 -1, Pt0 -1, U_Ind_s -1 ] :
								[ Pt0 -1, Pt2 -1, U_Ind_s -1 ]);
							continue;
						}
						Pt1 = U_Ind;
						isUpTri = true;
					}

					// use extra vertices for pole
					if (Pt0 == 0)
					{
						Pt0 = Pt1 + nVertices;
						if (Pt1 == 4) {
							// pacific problem at North pole
							aPacificFaces.push ([ Pt0 -1, Pt1 -1, Pt2 -1 ]);
							continue;
						}
					}

					l_oGeometry3D.setFaceVertexIds (nFaces, [Pt0 -1, Pt1 -1, Pt2 -1]);
					l_oGeometry3D.setFaceUVCoordsIds (nFaces, [Pt0 -1, Pt1 -1, Pt2 -1]); nFaces++;
				}
			}
			tris += 2;
		}
		U_Ind_s = L_Ind_s; U_Ind_e = L_Ind_e;
		// Build the lower four sections
		 
		var i = iVerts-1;
		while( i >= 0 ){
			L_Ind_s = U_Ind_s; L_Ind_e = U_Ind_e; U_Ind_s = L_Ind_s + 4*(i+1); U_Ind_e = L_Ind_e + 4*i;
			if( i == 0 ) U_Ind_e++;
			tris -= 2;
			U_Ind = U_Ind_s;
			L_Ind = L_Ind_s;
			for( k in 0...4 ){
				isUpTri = true;
				for( triInd in 0...tris ){
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
						if( U_Ind > U_Ind_e ) {
							if (Pt2 %2 == 0)
								aPacificFaces.push ([ Pt0 -1, Pt2 -1, U_Ind_s -1 ]);
							else
								aPacificFaces.push ([ Pt0 -1, U_Ind_s -1, L_Ind_s -1 ]);
							continue;
						}
						Pt1 = U_Ind;
						isUpTri = true;
					}

					// use extra vertices for pole
					if (Pt0 == nVertices +1)
					{
						Pt0 = Pt1 + 8;
						if (Pt1 == nVertices) {
							// pacific problem at South pole
							aPacificFaces.push ([ Pt0 -1, Pt2 -1, Pt1 -1 ]);
							continue;
						}
					}

					l_oGeometry3D.setFaceVertexIds (nFaces, [Pt0 -1, Pt2 -1, Pt1 -1]);
					l_oGeometry3D.setFaceUVCoordsIds (nFaces, [Pt0 -1, Pt2 -1, Pt1 -1]); nFaces++;
				}
			}
			i--;
		}
		
		// only now we can fix pacific problem
		// (because doing so in any other way would break Gabriel code ;)
		nVertices = l_oGeometry3D.aVertex.length;
		for (i in 0...aPacificFaces.length)
		{
			for (k in 0...3)
			{
				var p:Int = aPacificFaces [i][k];
				if (l_oGeometry3D.aUVCoords [p].u == 0)
				{
					l_oGeometry3D.setVertex (nVertices,
						l_oGeometry3D.aVertex [p].x,
						l_oGeometry3D.aVertex [p].y,
						l_oGeometry3D.aVertex [p].z);
					l_oGeometry3D.setVertexNormal (nVertices,
						l_oGeometry3D.aVertexNormals [p].x,
						l_oGeometry3D.aVertexNormals [p].y,
						l_oGeometry3D.aVertexNormals [p].z);
					l_oGeometry3D.setUVCoords (nVertices, 1,
						l_oGeometry3D.aUVCoords [p].v);
					aPacificFaces [i][k] = nVertices;
					nVertices++;
				}
			}

			l_oGeometry3D.setFaceVertexIds (nFaces, [aPacificFaces [i][0], aPacificFaces [i][1], aPacificFaces [i][2]]);
			l_oGeometry3D.setFaceUVCoordsIds (nFaces, [aPacificFaces [i][0], aPacificFaces [i][1], aPacificFaces [i][2]]);

			nFaces++;
		}

		return l_oGeometry3D;
	}
}
