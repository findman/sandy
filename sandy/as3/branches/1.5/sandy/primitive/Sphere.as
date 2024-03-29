///////////////////////////////////////////////////////////
//  Sphere.as
//  Macromedia ActionScript Implementation of the Class Sphere
//  Generated by Enterprise Architect
//  Created on:      26-VII-2006 13:46:09
//  Original author: Thomas Pfeiffer - kiroukou
///////////////////////////////////////////////////////////
package sandy.primitive
{
	import sandy.core.data.Vector;
	import sandy.core.data.Vertex;
	import sandy.core.face.Face;
	import sandy.core.face.QuadFace3D;
	import sandy.core.face.TriFace3D;
	import sandy.core.Object3D;
	import sandy.primitive.Primitive3D;
	/**
	* Generate a Sphere 3D coordinates. The Sphere generated is a 3D object that can be rendered by Sandy's engine.
	* You can play with the constructor's parameters to ajust it to your needs.  
	* @author		Thomas Pfeiffer - kiroukou
	* @version		1.0
	* @date 		06.08.2006 
	**/
	public class Sphere extends Object3D implements Primitive3D
	{
		//////////////////
		///PRIVATE VARS///
		//////////////////	
		private var _quality:Number ;
		private var _radius:Number ;
	
		/**
		* This is the constructor to call when you nedd to create a Sphere primitive.
		* <p>This method will create a complete object with vertex, normales, texture coords and the faces.
		*    So it allows to have a custom 3D object easily </p>
		* <p>{@code radius} represents the radius of the Sphere,  {@code quality} represent its quality (between 1 and 5), more quality is up, more faces there is</p>
		* @param 	radius 	Number
		* @param 	quality	Number
		* @param mode String represent the two available modes to generates the faces.
		* "tri" is necessary to have faces with 3 points, and "quad" for 4 points.
		*/
		public function Sphere( radius:Number=100, quality:uint=5, mode:String='tri' )
		{
			super();
			_radius 	= radius  ;
			_mode 		= mode;
			_quality 	= 4+2*quality ;
			generate();
		}
		
		/**
		* generate all is needed to construct the object. Vertex, UVCoords, Faces
		* 
		* <p>Generate the points, normales and faces of this primitive depending of tha parameters given</p>
		* <p>It can construct dynamically the object, taking care of your preferences givent in parameters. Note that for now all the faces have only three points.
		*    This point will certainly change in the future, and give to you the possibility to choose 3 or 4 points per faces</p>
		*/
		public function generate():void
		{
			var testFaces:Number = 0;
			
			_radius = _radius;
			var i:uint;
			var id:uint;
			var points:Array = new Array();
			var texture:Array = new Array();
			var faces:Array = new Array();
			var f:Face;
			//-- Variables locales
			var cos:Function = Math.cos;
			var sin:Function = Math.sin;
			var abs:Function = Math.abs;
			var pi:Number = Math.PI;
			var pi2:Number = pi/2;
			var tx:Number = 1;
			var ty:Number = 0;
			var nbptsh:Number = 0;
			var nbptsv:Number = 0;
			//-- Initialisations des variables
			var theta:Number ;
			var phi:Number ;
			var pas:Number = (2*pi/_quality);
			var pas2:Number = (2/_quality);
			//-- point de depart de la boucle phi
			var phi_deb:Number = pi2 - pas ;
			//-- point d'arrivde phi
			var phi_fin:Number = -pi2 + pas ;
	
			//-- Point du haut de la sphere
			points.push({x:0, y:_radius, z:0});
			//-- Point du bas de la sphere
			points.push({x:0, y:-_radius, z:0});
			addUVCoordinate( 0.5 , 1 );
			addUVCoordinate( 0.5 , 0 );
			//-- Technique du quadrillage pour la creation des points de la sphere. Permet de simplifier la texturation
			//Boucle pour theta
			for( theta = 0 ; theta < 2*pi; tx-=pas2/2 , theta += pas )
			{
				nbptsv ++;
				ty = 1-pas2;
				nbptsh=0;
				//Boucle pour phi
				for(phi = phi_deb ; phi>= phi_fin; ty-= pas2, phi -= pas )
				{
					nbptsh++;
					var o:Object = {};
					//Passage en sphque.
					o.x = _radius*cos(phi)*sin(theta);
					o.y = _radius*sin(phi);
					o.z = _radius*cos(phi)*cos(theta);
					//On nettoie les coords pour simplifier les calculs
					o.x = ( abs(o.x) < Number(1e-4) ) ? 0 : o.x;
					o.y = ( abs(o.y) < Number(1e-4) ) ? 0 : o.y ;
					o.z = ( abs(o.z) < Number(1e-4) ) ? 0 : o.z;
					//-- on ajoute les coords de texture
					addUVCoordinate( tx , ty );
					points.push(o);
				}	
			}
			
			//un petit coup pour les textures
			for(phi = phi_deb,ty = 1-pas2 ; phi>= phi_fin; ty-= pas2, phi -= pas )
			{
				addUVCoordinate( tx , ty );
			}
			
			var l:Number = points.length;
			for(i = 0 ; i < points.length; i++)
			{
				var v:Vertex = new Vertex(points[i].x,points[i].y,points[i].z);
				aPoints.push(v);
			}
			
			var n:Vector;
			//--Pour le sommet
			for(i = 2; i<l; i+=nbptsh)
			{
				id =((i+nbptsh) >= l) ?  ((i+nbptsh)%l+2) : ((i+nbptsh));
				//TODO checker les UV
				f = new TriFace3D(this, aPoints[0], aPoints[id], aPoints[i] );
				f.setUVCoordinates( _aUv[0], _aUv[id], _aUv[i] );
				aNormals.push ( f.createNormale () );
				addFace( f );
				testFaces++;
			}
	
			//--Pour le bas
			for(i = 1+nbptsh; i<l; i+=nbptsh)
			{
				id = ((i+nbptsh)>=l)? ((i+nbptsh)%l+2) : ((i+nbptsh));
				//TODO checker les UV
				f = new TriFace3D(this, aPoints[1], aPoints[i], aPoints[id] );
				f.setUVCoordinates( _aUv[1], _aUv[i], _aUv[id] );
				aNormals.push ( f.createNormale () );
				addFace( f );
				testFaces++;
			}
			//--Si on est sur un hedra il n'y a que les sommets
			if( l <= 6 ) return;
			//--Pour le centre
			for( i = 2; i < l-1; i += 1 )
			{
				//Si on est sur la bas de la sphere on passe
				if( (i-1)%nbptsh == 0 ) continue;
				var pt1:Number;
				var pt2:Number;
				var pt3:Number;
				var pt4:Number;
				//	1 ---- 3
				//  |      |
				//  2 ---- 4
				pt1 = i;
				pt2 = ((i+1)>=l) ? ((i+1)%l+2) : ((i+1));
				pt3 = ((i+nbptsh)>=l) ? ((i+nbptsh)%l+2) : ((i+nbptsh));
				pt4 = ((i+1+nbptsh)>=l) ? ((i+1+nbptsh)%l+2) : ((i+1+nbptsh));
				if( _mode == 'tri' )
				{
					f = new TriFace3D(this, aPoints[pt1], aPoints[pt3], aPoints[pt2] );
					f.setUVCoordinates( _aUv[i], _aUv[(i+nbptsh)], _aUv[(i+1)] );
					n = f.createNormale ();
					aNormals.push ( n  );
					addFace( f );
					testFaces++;
					
					f = new TriFace3D(this, aPoints[pt2], aPoints[pt3], aPoints[pt4] );
					f.setUVCoordinates( _aUv[i+1], _aUv[(i+nbptsh)], _aUv[(i+1+nbptsh)] );
	
					f.setNormale( n );
					addFace( f );
					testFaces++;
				}
				else if( _mode == 'quad' )
				{
					f = new QuadFace3D(this, aPoints[pt1], aPoints[pt3], aPoints[pt4], aPoints[pt2] );
					f.setUVCoordinates( _aUv[pt1], _aUv[(i+nbptsh)], _aUv[(i+1+nbptsh)] );//, _aUv[(i+1)] );
					n = f.createNormale ();
					aNormals.push ( n  );
					addFace( f );
					testFaces++;
				}
			}
			
			trace("faces: " + testFaces);
		}
		
		
		/*
		 * Mode with 3 or 4 points per face
		 */
		 private var _mode : String;
		 
	}

}