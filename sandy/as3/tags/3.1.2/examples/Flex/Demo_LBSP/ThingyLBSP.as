package  {
	import sandy.primitive.Primitive3D;
	import sandy.core.scenegraph.Geometry3D;
	import sandy.core.scenegraph.Shape3D;

	public class ThingyLBSP extends Shape3D implements Primitive3D {
		private var l:Geometry3D;

		private function f(v1:Number,v2:Number,v3:Number,uv00:Number,uv01:Number,uv10:Number,uv11:Number,uv20:Number,uv21:Number,normX:Number,normY:Number,normZ:Number):void {
			var uv1:Number = l.getNextUVCoordID();
			var uv2:Number = uv1 + 1;
			var uv3:Number = uv2 + 1;

			l.setUVCoords(uv1,uv00,1-uv01);
			l.setUVCoords(uv2,uv10,1-uv11);
			l.setUVCoords(uv3,uv20,1-uv21);

			l.setFaceVertexIds(l.getNextFaceID(), v1,v2,v3);
			l.setFaceUVCoordsIds(l.getNextFaceUVCoordID(), uv1,uv2,uv3);
			l.setFaceNormal(l.getNextFaceNormalID(), normX,normZ,normY);
		}

		private function f4(v1:Number,v2:Number,v3:Number,v4:Number,uv00:Number,uv01:Number,uv10:Number,uv11:Number,uv20:Number,uv21:Number,uv30:Number,uv31:Number,normX:Number,normY:Number,normZ:Number):void {
			var uv1:Number = l.getNextUVCoordID();
			var uv2:Number = uv1 + 1;
			var uv3:Number = uv2 + 1;
			var uv4:Number = uv3 + 1;

			l.setUVCoords(uv1,uv00,1-uv01);
			l.setUVCoords(uv2,uv10,1-uv11);
			l.setUVCoords(uv3,uv20,1-uv21);
			l.setUVCoords(uv4,uv30,1-uv31);

			l.setFaceVertexIds(l.getNextFaceID(),v1,v2,v3,v4);
			l.setFaceUVCoordsIds(l.getNextFaceUVCoordID(),uv1,uv2,uv3,uv4);
			l.setFaceNormal(l.getNextFaceNormalID(),normX,normZ,normY);
		}

		private function f2(v1:Number,v2:Number,v3:Number):void {
			l.setFaceVertexIds(l.getNextFaceID(), v1,v2,v3);
		}

		private function f24(v1:Number,v2:Number,v3:Number,v4:Number):void {
			l.setFaceVertexIds(l.getNextFaceID(), v1,v2,v3,v4);
		}

		private function v(vx:Number,vy:Number,vz:Number):void {
			l.setVertex(l.getNextVertexID(),vx,/* edit */-vy,vz);
		}

		public function ThingyLBSP( p_Name:String=null ) {
			super( p_Name );
			geometry = generate();
		}

		public function generate(... arguments):Geometry3D {
			l = new Geometry3D();
			v(1.000000,0.500972,1.007194);
			v(1.000000,0.333333,-1.000000);
			v(1.000000,-0.333333,-1.000000);
			v(-1.000000,0.500972,1.007194);
			v(-1.000000,0.333333,-1.000000);
			v(-1.000000,-0.333333,-1.000000);
			v(1.000000,-0.510757,1.007193);
			v(-1.000000,-0.510757,1.007194);
			v(1.000000,0.333333,0.606014);
			v(1.000000,-0.333333,0.606014);
			v(0.333333,0.333333,-1.000000);
			v(0.333333,-0.333333,-1.000000);
			v(-0.333334,0.333333,-1.000000);
			v(-0.333334,-0.333333,-1.000000);
			v(-1.000000,0.333333,0.606014);
			v(-1.000000,-0.333333,0.606014);
			v(-0.333334,-0.334111,-0.333333);
			v(0.333333,-0.333333,-0.334111);
			v(-0.333333,0.334111,-0.333333);
			v(0.333333,0.334111,-0.333333);
			v(1.495717,0.333333,0.606014);
			v(1.495717,-0.333333,0.606013);
			v(-1.488318,0.333333,0.606014);
			v(-1.488318,-0.333333,0.606014);
			v(0.111111,0.111111,-0.334111);
			v(0.111111,-0.111111,-0.334111);
			v(-0.111111,0.111111,-0.334111);
			v(-0.111111,-0.111111,-0.334111);
			v(-0.111111,0.111111,-1.195669);
			v(0.111111,0.111111,-1.195669);
			v(-0.111112,-0.111111,-1.195669);
			v(0.111111,-0.111111,-1.195669);
			v(-1.488318,0.333333,1.007194);
			v(-1.488318,-0.333333,1.007194);
			v(-1.000000,-0.333333,1.007194);
			v(-1.000000,0.333333,1.007194);
			v(1.000000,-0.333333,1.007193);
			v(1.495717,-0.333333,1.007193);
			v(1.495717,0.333333,1.007193);
			v(1.000000,0.333333,1.007193);
			v(-0.111111,0.111111,-1.002573);
			v(-0.111112,-0.111111,-1.002573);
			v(0.111111,-0.111111,-1.002573);
			v(0.111111,0.111111,-1.002573);

			f24(1,2,11,10);
			f24(12,13,5,4);
			f24(9,8,20,21);
			f24(14,15,23,22);
			f24(0,1,4,3);
			f24(2,6,7,5);
			f24(29,31,30,28);
			f24(10,11,17,19);
			f24(10,19,18,12);
			f24(12,18,16,13);
			f24(11,13,16,17);
			f24(17,16,27,25);
			f24(17,25,24,19);
			f24(18,19,24,26);
			f24(16,18,26,27);
			f24(0,6,2,1);
			f24(3,4,5,7);
			f24(22,23,33,32);
			f24(23,15,34,33);
			f24(14,22,32,35);
			f24(9,21,37,36);
			f24(21,20,38,37);
			f24(20,8,39,38);
			f24(32,33,34,35);
			f24(37,38,39,36);
			f24(0,3,7,6);
			f24(24,43,40,26);
			f24(43,29,28,40);
			f24(26,40,41,27);
			f24(40,28,30,41);
			f24(27,41,42,25);
			f24(41,30,31,42);
			f24(25,42,43,24);
			f24(42,31,29,43);

			this.x = 0.000000;
			this.y = 0.000000;
			this.z = 0.000000;

			this.rotateX = 0.000000;
			this.rotateY = 0.000000;
			this.rotateZ = 0.000000;

			this.scaleX = 1.000000;
			this.scaleY = 1.000000;
			this.scaleZ = 1.000000;
			return (l);
		}
	}
}