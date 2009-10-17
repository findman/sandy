package sandy.core.data {
	import sandy.math.PlaneMath;
	/**
	 * BSP tree node.
	 * @author makc
	 */
	public class BSPNode {
		public var faces:Array;
		public var plane:Plane;
		public var positive:BSPNode;
		public var negative:BSPNode;

		/**
		 * Creates BSP tree from list of faces without cutting them (hence "lazy").
		 * Faces are ordered by coplanar area.
		 */
		public static function makeLazyBSP (faces:Array, threshold:Number):BSPNode {
			var planes:Array = lazyBSPFaces2Planes (faces, threshold);
			var pobj:Object = planes.pop ();
			var node:BSPNode = new BSPNode;
			node.faces = pobj.faces;
			node.plane = pobj.plane;
			// if there are more planes, split their polygons into positive and negative sets
			if (planes.length > 0) {
				var pos:Array = [];
				var neg:Array = [];
				for each (pobj in planes) {
					var polys:Array = pobj.faces;
					for each (var poly:Polygon in polys) {
						var dist:Number = 0;
						for each (var v:Vertex in poly.vertices) {
							dist += node.plane.a * v.x + node.plane.b * v.y + node.plane.c * v.z + node.plane.d;
						}
						if (dist > 0) pos.push (poly); else neg.push (poly);
					}
				}
				if (pos.length > 0) node.positive = makeLazyBSP (pos, threshold);
				if (neg.length > 0) node.negative = makeLazyBSP (neg, threshold);
			}
			return node;
		}

		private static function lazyBSPFaces2Planes (faces:Array, threshold:Number):Array {
			var fba:Array = faces.slice ();
			fba.sortOn ("area", Array.DESCENDING | Array.NUMERIC);
			// create array of info about planes
			var planes:Array = [];
			for each (var poly:Polygon in fba) {
				var pobj:Object;
				var found:Boolean = false;
				for (var i:int = 0; i < planes.length; i++) {
					pobj = planes [i];
					var p:Plane = pobj.plane;
					// if poly is in p, store it in face list
					if ((Math.abs (p.a * poly.a.x + p.b * poly.a.y + p.c * poly.a.z + p.d) < threshold) &&
						(Math.abs (p.a * poly.normal.x + p.b * poly.normal.y + p.c * poly.normal.z) > 1 - threshold)) {
						pobj.area += poly.area; pobj.faces.push (poly); found = true; break;
					}
				}
				if (!found) {
					// new plane
					pobj = {
						area: poly.area,
						faces: [ poly ],
						plane: PlaneMath.createFromNormalAndPoint (poly.normal.getPoint3D (), poly.a.getPoint3D ())
					};
					planes.push (pobj);
				}
			}
			// sort and return
			planes.sortOn ("area", Array.NUMERIC); return planes;
		}
	}
}