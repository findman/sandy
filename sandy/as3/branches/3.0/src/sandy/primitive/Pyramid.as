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

/*
Note : This General Public License does not permit incorporating your program 
       into proprietary programs.
*/

package sandy.primitive {

	import sandy.core.data.Vertex;
	import sandy.core.face.Face;
	import sandy.core.face.QuadFace3D;
	import sandy.core.face.TriFace3D;
	import sandy.primitive.Primitive3D;
	import sandy.core.scenegraph.Shape3D;

	/**
	* Pyramid
	*
	* @author		Thomas Pfeiffer - kiroukou
	* @author		Tabin C�dric - thecaptain
	* @author		Nicolas Coevoet - [ NikO ]
	* @version		1.0
	* @date 		12.01.2006 
	**/
	public class Pyramid extends Shape3D implements Primitive3D
	{
		//////////////////
		///PRIVATE VARS///
		//////////////////	
		private var _h:Number;
		private var _lg:Number;
		private var _radius:Number ;

		/**
		* This is the constructor to call when you nedd to create a Pyramid primitive.
		* <p>This method will create a complete object with vertex, normales, texture coords and the faces.
		*    So it allows to have a custom 3D object easily </p>
		* <p>{@code h} represents the height of the Pyramid, {@code lg} represent its length(or depth) and {@code rad} its radius(or wide)</p>
		* @param h Number
		* @param lg Number
		* @param rad Number
		*/
		public function Pyramid (h:Number = 6, lg:Number = 6, rad:Number = 100 )
		{
			super ();
			_radius = rad ;
			_h = h ;
			_lg = lg ;
			generate ();
		}
		
		/**
		* generate all is needed to construct the object. Vertex, UVCoords, Faces
		* 
		* <p>Generate the points, normales and faces of this primitive depending of tha parameters given</p>
		* <p>It can construct dynamically the object, taking care of your preferences givent in parameters. Note that for now all the faces have only three points.
		*    This point will certainly change in the future, and give to you the possibility to choose 3 or 4 points per faces</p>
		*/
		public function generate() : void
		{
			var f:Face;
			//Creation des points
			_h = -_h;
			var r2:Number = _radius/2;
			var l2:Number = _lg/2;
			var h2:Number = _h/2;
			/*
			3-----2
			  \ 4  \
			   0-----1
			*/

			aPoints.push( new Vertex(-r2,0,l2) );
			aPoints.push( new Vertex( r2,0,l2) );
			aPoints.push( new Vertex( r2,0,-l2) );
			aPoints.push( new Vertex(-r2,0,-l2) );
			aPoints.push( new Vertex( 0,h2,0) );	

			addUVCoordinate (0,0.5);//0
			addUVCoordinate (0,33,0.5);//1
			addUVCoordinate (0.66,0.5);//2
			addUVCoordinate (1,0.5);//3
			addUVCoordinate (1,1);

			//Creation des faces
			//Face avant
			f = new TriFace3D(this, aPoints[0], aPoints[1], aPoints[4] );
			f.setUVCoordinates( _aUv[0], _aUv[1], _aUv[4] );
			aNormals.push ( f.createNormale () );
			addFace( f );
			//Face derriere
			f = new TriFace3D(this, aPoints[3], aPoints[2], aPoints[0] );
			f.setUVCoordinates( _aUv[3], _aUv[2], _aUv[0] );
			aNormals.push ( f.createNormale () );
			addFace( f );
			f = new TriFace3D(this, aPoints[0], aPoints[2], aPoints[1] );
			f.setUVCoordinates( _aUv[0], _aUv[2], _aUv[1] );
			aNormals.push ( f.createNormale () );
			addFace( f );
			//Face gauche
			f = new TriFace3D(this, aPoints[4], aPoints[3], aPoints[0] );
			f.setUVCoordinates( _aUv[4], _aUv[3], _aUv[0] );
			aNormals.push ( f.createNormale () );
			addFace( f );
			//Face droite
			f = new TriFace3D(this, aPoints[3], aPoints[4], aPoints[2] );
			f.setUVCoordinates( _aUv[3], _aUv[4], _aUv[2] );
			aNormals.push ( f.createNormale () );
			addFace( f );
			f = new TriFace3D(this, aPoints[4], aPoints[1], aPoints[2] );
			f.setUVCoordinates( _aUv[4], _aUv[1], _aUv[2] );
			aNormals.push ( f.createNormale () );
			addFace( f );
		}
	}
}