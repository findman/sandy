package  {
	import sandy.primitive.Primitive3D;
	import sandy.core.scenegraph.Geometry3D;
	import sandy.core.scenegraph.Shape3D;

	public class ThingyAVGZ extends Shape3D implements Primitive3D {
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

		public function ThingyAVGZ( p_Name:String=null ) {
			super( p_Name );
			geometry = generate();
		}

		public function generate(... arguments):Geometry3D {
			l = new Geometry3D();
			v(-1.000000,0.388373,-0.340986);
			v(1.000000,0.388373,-0.340986);
			v(-1.000000,0.333333,-1.000000);
			v(1.000000,0.333333,-1.000000);
			v(-1.000000,-0.391586,-0.340986);
			v(1.000000,-0.391586,-0.340987);
			v(-1.000000,-0.333333,-1.000000);
			v(1.000000,-0.333333,-1.000000);
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
			v(1.000000,-0.474487,0.596877);
			v(1.000000,0.466703,0.596877);
			v(-1.000000,0.466703,0.596877);
			v(-1.000000,-0.474487,0.596877);
			v(1.000000,-0.391586,-0.340987);
			v(1.000000,0.388373,-0.340986);
			v(-1.000000,0.388373,-0.340986);
			v(-1.000000,-0.391586,-0.340986);
			v(-0.344043,0.388373,-0.340986);
			v(-0.344043,0.333333,-1.000000);
			v(-0.344043,-0.391586,-0.340986);
			v(-0.344043,-0.333333,-1.000000);
			v(0.336644,0.388373,-0.340986);
			v(0.336644,0.333333,-1.000000);
			v(0.336644,-0.391586,-0.340987);
			v(0.336644,-0.333333,-1.000000);

			f24(9,10,19,18);
			f24(20,21,13,12);
			f24(17,16,28,29);
			f24(22,23,31,30);
			f24(34,32,37,36);
			f24(35,34,36,38);
			f24(33,35,38,39);
			f24(32,33,39,37);
			f24(37,39,38,36);
			f24(18,19,25,27);
			f24(18,27,26,20);
			f24(20,26,24,21);
			f24(19,21,24,25);
			f24(25,24,35,33);
			f24(25,33,32,27);
			f24(26,27,32,34);
			f24(24,26,34,35);
			f24(30,31,41,40);
			f24(31,23,42,41);
			f24(22,30,40,43);
			f24(17,29,45,44);
			f24(29,28,46,45);
			f24(28,16,47,46);
			f24(40,41,42,43);
			f24(45,46,47,44);
			f24(8,11,15,14);
			f24(8,49,50,11);
			f24(48,14,15,51);
			f24(49,8,14,48);
			f24(11,50,51,15);
			f24(49,53,54,50);
			f24(52,48,51,55);
			f24(48,52,53,49);
			f24(52,10,9,53);
			f24(50,54,55,51);
			f24(54,12,13,55);
			f24(0,56,57,2);
			f24(6,59,58,4);
			f24(56,60,61,57);
			f24(60,1,3,61);
			f24(59,63,62,58);
			f24(63,7,5,62);

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