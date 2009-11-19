// This class is generated from haxe branch r1141, with flash.Boot references manually commented out
// and haxe types imported from sandy.core.data.haxe
package sandy.primitive {
	import sandy.animation.IKeyFramed;
	import flash.utils.ByteArray;
	//import flash.Boot;
	import sandy.core.data.haxe.*;
	import sandy.core.data.Point3D;
	import sandy.core.data.Polygon;
	import sandy.primitive.Primitive3D;
	import sandy.core.scenegraph.Node;
	import sandy.bounds.BBox;
	import sandy.core.scenegraph.Shape3D;
	import sandy.materials.Appearance;
	import sandy.core.data.Vertex;
	import sandy.bounds.BSphere;
	import sandy.core.data.Matrix4;
	import sandy.view.CullingState;
	import sandy.view.Frustum;
	import sandy.core.scenegraph.Geometry3D;
	public class KeyFramedShape3D extends sandy.core.scenegraph.Shape3D implements sandy.primitive.Primitive3D, sandy.animation.IKeyFramed{
		public function KeyFramedShape3D(p_sName : String = "",data : flash.utils.ByteArray = null,scale : Number = 1.0,p_oAppearance : sandy.materials.Appearance = null,p_bUseSingleContainer : Boolean = true) : void { //if( !flash.Boot.skip_constructor ) {
			this.frames = new Hash();
			this.vertices = new Array();
			this.m_oBBoxes = new Array();
			this.m_oBSpheres = new Array();
			this.m_bFrameUpdateBounds = false;
			this.m_bInterpolateBounds = false;
			this.scaling = scale;
			super(p_sName,null,p_oAppearance,p_bUseSingleContainer);
			if(data != null) {
				geometry = this.generate(data); //this.__setGeometry(this.generate([data]));
				this.resetFrameBounds();
				this.__setFrame(0);
			}
		}//}
		
		public var frames : Hash;
		public function get frame() : Number { return __getFrame(); }
		public function set frame( __v : Number ) : void { __setFrame(__v); }
		protected var $frame : Number;
		public function get frameCount() : int { return __getFrameCount(); }
		protected var $frameCount : int;
		public function get vertexCount() : int { return __getVertexCount(); }
		protected var $vertexCount : int;
		public function get frameUpdateBounds() : Boolean { return __getFrameUpdateBounds(); }
		public function set frameUpdateBounds( __v : Boolean ) : void { __setFrameUpdateBounds(__v); }
		protected var $frameUpdateBounds : Boolean;
		public function get interpolateBounds() : Boolean { return __getInterpolateBounds(); }
		public function set interpolateBounds( __v : Boolean ) : void { __setInterpolateBounds(__v); }
		protected var $interpolateBounds : Boolean;
		public function appendFrameCopy(frameNumber : int) : int {
			var rv : int = -1;
			if(frameNumber < this.vertices.length) {
				var box : sandy.bounds.BBox = null;
				var sphere : sandy.bounds.BSphere = null;
				var f : Array = this.vertices[frameNumber];
				if(f == null) {
					return -1;
				}
				else {
					this.num_frames++;
					if(frameNumber < this.m_oBBoxes.length) box = this.m_oBBoxes[frameNumber].clone();
					if(frameNumber < this.m_oBSpheres.length) sphere = this.m_oBSpheres[frameNumber].clone();
					rv = this.vertices.push(f.slice(0)) - 1;
					if(box == null || sphere == null) {
						this.resetFrameBounds();
					}
					else {
						this.m_oBBoxes.push(box);
						this.m_oBSpheres.push(sphere);
					}
					return rv;
				}
			}
			return rv;
		}
		
		public override function clone(p_sName : String = "",p_bKeepTransform : Boolean = false) : sandy.core.scenegraph.Shape3D {
			var l_oClone : sandy.primitive.KeyFramedShape3D = new sandy.primitive.KeyFramedShape3D(p_sName,null,this.scaling,appearance/*this.__getAppearance()*/,this.m_bUseSingleContainer);
			l_oClone.geometry = this.geometry.clone ();//l_oClone.__setGeometry(this.__getGeometry().clone());
			if(p_bKeepTransform == true) l_oClone.matrix.copy (this.matrix);//l_oClone.__getMatrix().copy(this.__getMatrix());
			l_oClone.useSingleContainer = this.useSingleContainer;//l_oClone.__setUseSingleContainer(this.__getUseSingleContainer());
			l_oClone.appearance = this.appearance;//l_oClone.__setAppearance(this.__getAppearance());
			var vc : Array = new Array();
			{
				var _g1 : int = 0, _g : int = this.vertices.length;
				while(_g1 < _g) {
					var i : int = _g1++;
					var vr : Array = new Array();
					vc[i] = vr;
					{
						var _g3 : int = 0, _g2 : int = this.vertices[i].length;
						while(_g3 < _g2) {
							var j : int = _g3++;
							vr[j] = this.vertices[i][j].clone();
						}
					}
				}
			}
			l_oClone.vertices = vc;
			var boxes : Array = new Array();
			var spheres : Array = new Array();
			{
				var _g12 : int = 0, _g4 : int = this.m_oBBoxes.length;
				while(_g12 < _g4) {
					var i2 : int = _g12++;
					boxes.push(this.m_oBBoxes[i2].clone());
				}
			}
			{
				var _g13 : int = 0, _g5 : int = this.m_oBSpheres.length;
				while(_g13 < _g5) {
					var i3 : int = _g13++;
					spheres.push(this.m_oBSpheres[i3].clone());
				}
			}
			l_oClone.m_oBBoxes = boxes;
			l_oClone.m_oBSpheres = spheres;
			l_oClone.num_frames = this.num_frames;
			l_oClone.num_vertices = this.num_vertices;
			l_oClone.m_nCurFrame = this.m_nCurFrame;
			l_oClone.scaling = this.scaling;
			l_oClone.m_bFrameUpdateBounds = this.m_bFrameUpdateBounds;
			l_oClone.m_bInterpolateBounds = this.m_bInterpolateBounds;
			return l_oClone;
		}
		
		protected function interpolateFrameBounds(ratio : Number,frame1 : int,frame2 : int,toBox : sandy.bounds.BBox,toSphere : sandy.bounds.BSphere) : void {
			var c2 : Number = ratio;
			var c1 : Number = 1 - c2;
			var l_nBoxesLen : int = this.m_oBBoxes.length;
			if(l_nBoxesLen > frame1 && l_nBoxesLen > frame2) {
				var box1 : sandy.bounds.BBox = this.m_oBBoxes[frame1];
				var box2 : sandy.bounds.BBox = this.m_oBBoxes[frame2];
				if(c2 == 0.) {
					toBox.copy(box1);
				}
				else if(c2 == 1.) {
					toBox.copy(box2);
				}
				else {
					var min1 : sandy.core.data.Point3D = box1.minEdge;
					var min2 : sandy.core.data.Point3D = box2.minEdge;
					var max1 : sandy.core.data.Point3D = box1.maxEdge;
					var max2 : sandy.core.data.Point3D = box2.maxEdge;
					var edge : sandy.core.data.Point3D = toBox.minEdge;
					edge.x = min1.x * c1 + min2.x * c2;
					edge.y = min1.y * c1 + min2.y * c2;
					edge.z = min1.z * c1 + min2.z * c2;
					edge = toBox.maxEdge;
					edge.x = max1.x * c1 + max2.x * c2;
					edge.y = max1.y * c1 + max2.y * c2;
					edge.z = max1.z * c1 + max2.z * c2;
				}
			}
			var l_nSpheresLen : int = this.m_oBSpheres.length;
			if(l_nSpheresLen > frame1 && l_nSpheresLen > frame2) {
				var s1 : sandy.bounds.BSphere = this.m_oBSpheres[frame1];
				var s2 : sandy.bounds.BSphere = this.m_oBSpheres[frame2];
				if(c2 == 0.) {
					toSphere.copy(s1);
				}
				else if(c2 == 1.) {
					toSphere.copy(s2);
				}
				else {
					toSphere.radius = s1.radius * c1 + s2.radius * c2;
					toSphere.center.x = s1.center.x * c1 + s2.center.x * c2;
					toSphere.center.y = s1.center.y * c1 + s2.center.y * c2;
					toSphere.center.z = s1.center.z * c1 + s2.center.z * c2;
				}
			}
			else {
				toSphere.resetFromBox(toBox);
			}
			toBox.uptodate = false;
			toSphere.uptodate = false;
		}
		
		public function replaceFrame(destFrame : int,sourceFrame : Number) : void {
			var sfi : int = Std._int(sourceFrame);
			var f0 : Array = new Array();
			if(this.vertices.length > 0) {
				var frame1 : int = sfi % this.num_frames;
				var frame2 : int = (sfi + 1) % this.num_frames;
				var f1 : Array = this.vertices[frame1];
				var f2 : Array = this.vertices[frame2];
				var c2 : Number = sourceFrame - sfi, c1 : Number = 1. - c2;
				{
					var _g1 : int = 0, _g : int = this.num_vertices;
					while(_g1 < _g) {
						var i : int = _g1++;
						var v0 : sandy.core.data.Point3D = new sandy.core.data.Point3D();
						var v1 : sandy.core.data.Point3D = f1[i];
						var v2 : sandy.core.data.Point3D = f2[i];
						v0.x = v1.x * c1 + v2.x * c2;
						v0.y = v1.y * c1 + v2.y * c2;
						v0.z = v1.z * c1 + v2.z * c2;
						f0[i] = v0;
					}
				}
				this.vertices[destFrame] = f0;
				this.num_frames = this.vertices.length;
				var box : sandy.bounds.BBox = new sandy.bounds.BBox();
				var sphere : sandy.bounds.BSphere = new sandy.bounds.BSphere();
				this.interpolateFrameBounds(c2,frame1,frame2,box,sphere);
				this.m_oBBoxes[destFrame] = box;
				this.m_oBSpheres[destFrame] = sphere;
			}
		}
		
		protected function resetFrameBounds() : void {
			this.m_oBBoxes = new Array();
			this.m_oBSpheres = new Array();
			{
				var _g1 : int = 0, _g : int = this.num_frames;
				while(_g1 < _g) {
					var frame : int = _g1++;
					var f0 : Array = this.vertices[frame];
					var va : Array = new Array();
					{
						var _g3 : int = 0, _g2 : int = this.num_vertices;
						while(_g3 < _g2) {
							var i : int = _g3++;
							var v0 : sandy.core.data.Vertex = this.m_oGeometry.aVertex[i];
							v0.x = f0[i].x;
							v0.wx = f0[i].x;
							v0.y = f0[i].y;
							v0.wy = f0[i].y;
							v0.z = f0[i].z;
							v0.wz = f0[i].z;
							va.push(v0);
						}
					}
					var box : sandy.bounds.BBox = sandy.bounds.BBox.create(va);
					var sphere : sandy.bounds.BSphere = new sandy.bounds.BSphere();
					sphere.resetFromBox(box);
					this.m_oBBoxes[frame] = box;
					this.m_oBSpheres[frame] = sphere;
				}
			}
		}
		
		public function __getFrame() : Number {
			return this.m_nCurFrame;
		}
		
		public function __setFrame(value : Number) : Number {
			this.m_nCurFrame = value;
			changed = true;//this.__setChanged(true);
			return value;
		}
		
		public override function cull(p_oFrustum : sandy.view.Frustum,p_oViewMatrix : sandy.core.data.Matrix4,p_bChanged : Boolean) : void {
			super.cull(p_oFrustum,p_oViewMatrix,p_bChanged);
			if((this.m_nCurFrame != this.m_nOldFrame) && (this.culled != CullingState.OUTSIDE/*2*/) && (appearance/*this.__getAppearance()*/ != null)) {
				this.m_nOldFrame = this.m_nCurFrame;
				if(this.vertices.length == 0) return;
				var cfi : int = Std._int(this.m_nCurFrame);
				var frame1 : int = cfi % this.num_frames;
				var frame2 : int = (cfi + 1) % this.num_frames;
				var f1 : Array = this.vertices[frame1];
				var f2 : Array = this.vertices[frame2];
				var c2 : Number = this.m_nCurFrame - Std._int(this.m_nCurFrame), c1 : Number = 1 - c2;
				{
					var _g1 : int = 0, _g : int = this.num_vertices;
					while(_g1 < _g) {
						var i : int = _g1++;
						var v0 : sandy.core.data.Vertex = this.m_oGeometry.aVertex[i];
						var v1 : sandy.core.data.Point3D = f1[i];
						var v2 : sandy.core.data.Point3D = f2[i];
						v0.x = v1.x * c1 + v2.x * c2;
						v0.wx = v0.x;
						v0.y = v1.y * c1 + v2.y * c2;
						v0.wy = v0.y;
						v0.z = v1.z * c1 + v2.z * c2;
						v0.wz = v0.z;
					}
				}
				if(!this.animated) {
					var _g2 : int = 0, _g12 : Array = this.aPolygons;
					while(_g2 < _g12.length) {
						var l_oPoly : sandy.core.data.Polygon = _g12[_g2];
						++_g2;
						l_oPoly.updateNormal();
					}
				}
				if(this.m_bFrameUpdateBounds) {
					if(this.m_bInterpolateBounds) {
						this.interpolateFrameBounds(c2,frame1,frame2,this.boundingBox,this.boundingSphere);
					}
					else {
						var fno : int = ((c2 < 0.5)?frame1:frame2);
						if(this.m_oBBoxes.length > fno) this.boundingBox = this.m_oBBoxes[fno];
						if(this.m_oBSpheres.length > fno) this.boundingSphere = this.m_oBSpheres[fno];
						else this.boundingSphere.resetFromBox(this.boundingBox);
						this.boundingBox.uptodate = false;
						this.boundingSphere.uptodate = false;
					}
					if(this.parent/*__getParent()*/ != null) this.parent/*__getParent()*/.onChildBoundsChanged(this);
				}
			}
		}
		
		public function __getFrameCount() : int {
			return this.num_frames;
		}
		
		public function __getVertexCount() : int {
			return this.vertices.length;
		}
		
		public function generate(... arguments/*arguments : Array = null*/) : sandy.core.scenegraph.Geometry3D {
			return new sandy.core.scenegraph.Geometry3D();
		}
		
		public function __getFrameUpdateBounds() : Boolean {
			return this.m_bFrameUpdateBounds;
		}
		
		public function __setFrameUpdateBounds(v : Boolean) : Boolean {
			{
				var _g : int = 0, _g1 : Array = this.children;
				while(_g < _g1.length) {
					var c : sandy.core.scenegraph.Node = _g1[_g];
					++_g;
					if(Std._is(c,sandy.animation.IKeyFramed)) {
						(function($this:KeyFramedShape3D) : sandy.animation.IKeyFramed {
							var $r : sandy.animation.IKeyFramed;
							var tmp : sandy.core.scenegraph.Node = c;
							$r = (Std._is(tmp,sandy.animation.IKeyFramed)?tmp:function($this:KeyFramedShape3D) : sandy.core.scenegraph.Node {
								var $r2 : sandy.core.scenegraph.Node;
								throw "Class cast error";
								return $r2;
							}($this));
							return $r;
						})(this).__setFrameUpdateBounds(v);
					}
				}
			}
			return this.m_bFrameUpdateBounds = v;
		}
		
		public function __getInterpolateBounds() : Boolean {
			return this.m_bInterpolateBounds;
		}
		
		public function __setInterpolateBounds(v : Boolean) : Boolean {
			{
				var _g : int = 0, _g1 : Array = this.children;
				while(_g < _g1.length) {
					var c : sandy.core.scenegraph.Node = _g1[_g];
					++_g;
					if(Std._is(c,sandy.animation.IKeyFramed)) {
						(function($this:KeyFramedShape3D) : sandy.animation.IKeyFramed {
							var $r : sandy.animation.IKeyFramed;
							var tmp : sandy.core.scenegraph.Node = c;
							$r = (Std._is(tmp,sandy.animation.IKeyFramed)?tmp:function($this:KeyFramedShape3D) : sandy.core.scenegraph.Node {
								var $r2 : sandy.core.scenegraph.Node;
								throw "Class cast error";
								return $r2;
							}($this));
							return $r;
						})(this).__setInterpolateBounds(v);
					}
				}
			}
			return this.m_bInterpolateBounds = v;
		}
		
		protected var num_frames : int;
		protected var num_vertices : int;
		protected var m_nCurFrame : Number;
		protected var m_nOldFrame : Number;
		protected var scaling : Number;
		protected var vertices : Array;
		protected var m_oBBoxes : Array;
		protected var m_oBSpheres : Array;
		protected var m_bFrameUpdateBounds : Boolean;
		protected var m_bInterpolateBounds : Boolean;
		static public function readCString(data : flash.utils.ByteArray,count : int,breakOnNull : * = null) : String {
			var rv : String = "";
			var append : Boolean = true;
			{
				var _g : int = 0;
				while(_g < count) {
					var i : int = _g++;
					var c : uint = data.readUnsignedByte();
					if(c == 0) {
						append = false;
						if(breakOnNull) return rv;
						continue;
					}
					if(append) rv += String.fromCharCode(c);
				}
			}
			return rv;
		}
		
	}
}

