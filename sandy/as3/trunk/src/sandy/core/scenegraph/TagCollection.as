// This class is generated from haxe branch r1141, with flash.Boot references manually commented out
// and haxe types imported from sandy.core.data.haxe
package sandy.core.scenegraph {
	import sandy.animation.Tag;
	import sandy.animation.IKeyFramed;
	import sandy.core.data.Quaternion;
	import sandy.core.data.Matrix4;
	import sandy.core.scenegraph.Node;
	import sandy.core.data.Point3D;
	//import flash.Boot;
	import sandy.core.data.haxe.*;
	public class TagCollection extends sandy.core.scenegraph.Node implements sandy.animation.IKeyFramed{
		public function TagCollection(p_sName : String = "",p_hTags : Hash = null) : void { //if( !flash.Boot.skip_constructor ) {
			super(p_sName);
			this.m_nCurFrame = 0;
			this.m_nFrames = 0;
			this.m_hTags = new Hash();
			this.m_hMatricesCurFrame = new Hash();
			this.m_hMatricesTmp = new Hash();
			this.__setTags(p_hTags);
		}//}
		
		public function get frame() : Number { return __getFrame(); }
		public function set frame( __v : Number ) : void { __setFrame(__v); }
		protected var $frame : Number;
		public function get frameCount() : int { return __getFrameCount(); }
		protected var $frameCount : int;
		public function get tags() : Hash { return __getTags(); }
		public function set tags( __v : Hash ) : void { __setTags(__v); }
		protected var $tags : Hash;
		public function get frameUpdateBounds() : Boolean { return __getFrameUpdateBounds(); }
		public function set frameUpdateBounds( __v : Boolean ) : void { __setFrameUpdateBounds(__v); }
		protected var $frameUpdateBounds : Boolean;
		public function get interpolateBounds() : Boolean { return __getInterpolateBounds(); }
		public function set interpolateBounds( __v : Boolean ) : void { __setInterpolateBounds(__v); }
		protected var $interpolateBounds : Boolean;
		public function clone(p_sName : String) : sandy.core.scenegraph.TagCollection {
			var rv : sandy.core.scenegraph.TagCollection = new sandy.core.scenegraph.TagCollection(p_sName);
			var nh : Hash = new Hash();
			{ var $it : * = this.m_hTags.keys();
			while( $it.hasNext() ) { var key : String = $it.next();
			{
				var ar : Array = this.m_hTags.get(key);
				var na : Array = new Array();
				{
					var _g1 : int = 0, _g : int = ar.length;
					while(_g1 < _g) {
						var i : int = _g1++;
						na[i] = ar[i].clone();
					}
				}
				nh.set(key,na);
			}
			}}
			rv.__setTags(nh);
			rv.__setFrame(this.__getFrame());
			return rv;
		}
		
		public function getCurrentFrameTags() : Hash {
			return this.m_hMatricesCurFrame;
		}
		
		protected function interpolateForFrame(value : Number) : void {
			var fInt : int = Std._int(value);
			var c1 : Number = value - fInt;
			var c2 : Number = 1 - c1;
			{ var $it : * = this.m_hTags.keys();
			while( $it.hasNext() ) { var key : String = $it.next();
			{
				var ta : Array = this.m_hTags.get(key);
				var l : int = ta.length;
				var ft1 : sandy.animation.Tag = ta[fInt % l];
				var ft2 : sandy.animation.Tag = ta[(fInt + 1) % l];
				var origin1 : sandy.core.data.Point3D = ft1.origin;
				var origin2 : sandy.core.data.Point3D = ft2.origin;
				var interPos : sandy.core.data.Point3D = new sandy.core.data.Point3D();
				var interMatrix : sandy.core.data.Matrix4 = null;
				if(c1 == 0.) {
					interPos = origin1.clone();
					interMatrix = ft1.__getMatrix().clone();
				}
				else {
					interPos.x = c2 * origin1.x + c1 * origin2.x;
					interPos.y = c2 * origin1.y + c1 * origin2.y;
					interPos.z = c2 * origin1.z + c1 * origin2.z;
					var currRot : sandy.core.data.Quaternion = ft1.__getQuaternion();
					var nextRot : sandy.core.data.Quaternion = ft2.__getQuaternion();
					var interRot : sandy.core.data.Quaternion = sandy.core.data.Quaternion.slerp(currRot,nextRot,c1);
					interMatrix = interRot.getRotationMatrix();
				}
				interMatrix.n14 = interPos.x;
				interMatrix.n24 = interPos.y;
				interMatrix.n34 = interPos.z;
				this.m_hMatricesTmp.set(key,interMatrix);
			}
			}}
		}
		
		public function appendFrameCopy(frameNumber : int) : int {
			if(frameNumber < 0 || frameNumber >= this.m_nFrames) return -1;
			this.m_nFrames++;
			{ var $it : * = this.m_hTags.iterator();
			while( $it.hasNext() ) { var ar : Array = $it.next();
			{
				ar.push(ar.slice(frameNumber)[0]);
			}
			}}
			return this.m_nFrames - 1;
		}
		
		public function replaceFrame(destFrame : int,sourceFrame : Number) : void {
			this.interpolateForFrame(sourceFrame);
			{ var $it : * = this.m_hMatricesTmp.keys();
			while( $it.hasNext() ) { var key : String = $it.next();
			{
				var m : sandy.core.data.Matrix4 = this.m_hMatricesTmp.get(key);
				var o : sandy.core.data.Point3D = new sandy.core.data.Point3D(m.n14,m.n24,m.n34);
				m.n14 = 0.;
				m.n24 = 0.;
				m.n34 = 0.;
				var newTag : sandy.animation.Tag = new sandy.animation.Tag("",o,m);
				var ta : Array = this.m_hTags.get(key);
				if(ta != null) {
					ta[destFrame] = newTag;
				}
			}
			}}
		}
		
		public function __getFrame() : Number {
			return this.m_nCurFrame;
		}
		
		public function __setFrame(value : Number) : Number {
			this.m_nCurFrame = value;
			this.interpolateForFrame(value);
			var t : Hash = this.m_hMatricesTmp;
			this.m_hMatricesTmp = this.m_hMatricesCurFrame;
			this.m_hMatricesCurFrame = t;
			return value;
		}
		
		public function __getFrameCount() : int {
			return this.m_nFrames;
		}
		
		public function __getTags() : Hash {
			return this.m_hTags;
		}
		
		public function __setTags(v : Hash) : Hash {
			if(v == null) {
				this.m_nFrames = 0;
				return null;
			}
			this.m_nFrames = -1;
			{ var $it : * = v.iterator();
			while( $it.hasNext() ) { var a : Array = $it.next();
			{
				if(this.m_nFrames == -1) this.m_nFrames = a.length;
				else if(this.m_nFrames != a.length) throw "Tags must all have the same number of frames";
			}
			}}
			if(this.m_nFrames == -1) this.m_nFrames = 0;
			return this.m_hTags = v;
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
						(function($this:TagCollection) : sandy.animation.IKeyFramed {
							var $r : sandy.animation.IKeyFramed;
							var tmp : sandy.core.scenegraph.Node = c;
							$r = (Std._is(tmp,sandy.animation.IKeyFramed)?tmp:function($this:TagCollection) : sandy.core.scenegraph.Node {
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
						(function($this:TagCollection) : sandy.animation.IKeyFramed {
							var $r : sandy.animation.IKeyFramed;
							var tmp : sandy.core.scenegraph.Node = c;
							$r = (Std._is(tmp,sandy.animation.IKeyFramed)?tmp:function($this:TagCollection) : sandy.core.scenegraph.Node {
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
		
		protected var m_hTags : Hash;
		protected var m_hMatricesCurFrame : Hash;
		protected var m_hMatricesTmp : Hash;
		protected var m_nCurFrame : Number;
		protected var m_nFrames : int;
		protected var m_bFrameUpdateBounds : Boolean;
		protected var m_bInterpolateBounds : Boolean;

		// for debug
		public override function toString ():String {
			return "sandy.core.scenegraph.TagCollection :[" + this.name + "]";
		}
	}
}
