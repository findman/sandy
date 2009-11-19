// This class is generated from haxe branch r1141, with flash.Boot and haxe.Log references manually commented out
// and haxe types imported from sandy.core.data.haxe
package sandy.core.scenegraph {
	import sandy.animation.IKeyFramed;
	import sandy.animation.Animation;
	import sandy.core.scenegraph.Node;
	import sandy.core.data.Matrix4;
	//import haxe.Log;
	import sandy.core.scenegraph.TagCollection;
	import sandy.core.scenegraph.TransformGroup;
	//import flash.Boot;
	import sandy.core.data.haxe.*;
	import sandy.primitive.KeyFramedShape3D;
	import sandy.core.scenegraph.KeyFramedTransformGroup;
	public class AnimatedShape3D extends sandy.core.scenegraph.TransformGroup {
		public function AnimatedShape3D(asPartName : String = null,p_KeyFramed : sandy.core.scenegraph.KeyFramedTransformGroup = null) : void { //if( !flash.Boot.skip_constructor ) {
			super(asPartName);
			this.trackBounds = true;
			this.m_oRoot = this;
			this.m_bIsRoot = true;
			this.m_oKeyFramedGroup = p_KeyFramed;
			this.m_hTagAttachments = new Hash();
			this.m_hParts = new Hash();
			if(p_KeyFramed != null) {
				this.addChild(p_KeyFramed);
				this.setDefaultTags(p_KeyFramed);
				this.m_hParts.set(asPartName,this);
			}
		}//}
		
		public var animations : Hash;
		public function get currentAnimation() : sandy.animation.Animation { return __getCurrentAnimation(); }
		public function set currentAnimation( __v : sandy.animation.Animation ) : void { __setCurrentAnimation(__v); }
		protected var $currentAnimation : sandy.animation.Animation;
		public function get currentAnimationTween() : * { return __getCurrentAnimationTween(); }
		public function set currentAnimationTween( __v : * ) : void { __setCurrentAnimationTween(__v); }
		protected var $currentAnimationTween : *;
		public function get tagNames() : * { return __getTagNames(); }
		protected var $tagNames : *;
		public function get tagCollections() : * { return __getTagCollections(); }
		protected var $tagCollections : *;
		public function get frameUpdateBounds() : Boolean { return __getFrameUpdateBounds(); }
		public function set frameUpdateBounds( __v : Boolean ) : void { __setFrameUpdateBounds(__v); }
		protected var $frameUpdateBounds : Boolean;
		public function get interpolateBounds() : Boolean { return __getInterpolateBounds(); }
		public function set interpolateBounds( __v : Boolean ) : void { __setInterpolateBounds(__v); }
		protected var $interpolateBounds : Boolean;
		protected var m_oRoot : sandy.core.scenegraph.AnimatedShape3D;
		protected var m_bIsRoot : Boolean;
		protected var m_oKeyFramedGroup : sandy.core.scenegraph.KeyFramedTransformGroup;
		protected var m_hTagAttachments : Hash;
		protected var m_hParts : Hash;
		protected var parentPartName : String;
		protected var attachedAt : String;
		protected var m_oCurrentAnimation : sandy.animation.Animation;
		protected var m_oCurrentAnimationTween : *;
		protected var m_oLastTagUpdateMatrix : sandy.core.data.Matrix4;
		protected function setDefaultTags(p_KeyFramed : sandy.core.scenegraph.KeyFramedTransformGroup) : void {
			this.m_hTagAttachments = new Hash();
			{ var $it : * = this.__getTagNames().iterator();
			while( $it.hasNext() ) { var t : String = $it.next();
			{
				this.m_hTagAttachments.set(t,new Array());
			}
			}}
		}
		
		public function attach(p_oChild : *,asPartName : String,toPartNamed : String = null,onTagName : String = null) : Boolean {
			var as3d : sandy.core.scenegraph.AnimatedShape3D = null;
			var kftg : sandy.core.scenegraph.KeyFramedTransformGroup = null;
			if(Std._is(p_oChild,sandy.primitive.KeyFramedShape3D)) {
				kftg = new sandy.core.scenegraph.KeyFramedTransformGroup();
				kftg.addChild(p_oChild);
			}
			else if(Std._is(p_oChild,sandy.core.scenegraph.KeyFramedTransformGroup)) {
				kftg = function($this:AnimatedShape3D) : sandy.core.scenegraph.KeyFramedTransformGroup {
					var $r : sandy.core.scenegraph.KeyFramedTransformGroup;
					var tmp : * = p_oChild;
					$r = (Std._is(tmp,sandy.core.scenegraph.KeyFramedTransformGroup)?tmp:function($this:AnimatedShape3D) : * {
						var $r2 : *;
						throw "Class cast error";
						return $r2;
					}($this));
					return $r;
				}(this);
			}
			else if(Std._is(p_oChild,sandy.core.scenegraph.AnimatedShape3D)) {
				as3d = function($this:AnimatedShape3D) : sandy.core.scenegraph.AnimatedShape3D {
					var $r3 : sandy.core.scenegraph.AnimatedShape3D;
					var tmp2 : * = p_oChild;
					$r3 = (Std._is(tmp2,sandy.core.scenegraph.AnimatedShape3D)?tmp2:function($this:AnimatedShape3D) : * {
						var $r4 : *;
						throw "Class cast error";
						return $r4;
					}($this));
					return $r3;
				}(this);
			}
			else {
				var msg : String = "Unable to attach " + /*Type.getClassName(Type.getClass(*/p_oChild/*))*/ + " to AnimatedShape3D";
				/*haxe.Log.*/trace(msg,{ fileName : "AnimatedShape3D.hx", lineNumber : 126, className : "sandy.core.scenegraph.AnimatedShape3D", methodName : "attach"});
				throw msg;
			}
			if(this.children.length == 0 && this.m_bIsRoot) {
				this.m_oKeyFramedGroup = kftg;
				this.addChild(kftg);
				this.setDefaultTags(kftg);
				this.m_hParts.set(asPartName,this);
				return true;
			}
			if(kftg != null) as3d = new sandy.core.scenegraph.AnimatedShape3D(asPartName,kftg);
			else kftg = function($this:AnimatedShape3D) : sandy.core.scenegraph.KeyFramedTransformGroup {
				var $r5 : sandy.core.scenegraph.KeyFramedTransformGroup;
				var tmp3 : sandy.core.scenegraph.Node = as3d.children[0];
				$r5 = (Std._is(tmp3,sandy.core.scenegraph.KeyFramedTransformGroup)?tmp3:function($this:AnimatedShape3D) : sandy.core.scenegraph.Node {
					var $r6 : sandy.core.scenegraph.Node;
					throw "Class cast error";
					return $r6;
				}($this));
				return $r5;
			}(this);
			if(toPartNamed == null) {
				toPartNamed = this.name;
			}
			var existingPart : sandy.core.scenegraph.AnimatedShape3D = this.m_hParts.get(toPartNamed);
			if(existingPart == null) existingPart = this.m_oRoot.m_hParts.get(toPartNamed);
			if(existingPart == null) return false;
			var existingPartTagAttachments : Hash = existingPart.m_hTagAttachments;
			var found : Boolean = false;
			if(onTagName == null) {
				var found1 : Boolean = false;
				{ var $it : * = as3d.__getTagNames().iterator();
				while( $it.hasNext() ) { var key : String = $it.next();
				{
					if(existingPartTagAttachments.exists(key)) {
						onTagName = key;
						found1 = true;
						break;
					}
				}
				}}
				if(!found1) return false;
			}
			if(!existingPartTagAttachments.exists(onTagName)) return false;
			if(!existingPart.registerPart(as3d)) return false;
			var ar : Array = existingPartTagAttachments.get(onTagName);
			{
				var _g1 : int = 0, _g : int = ar.length;
				while(_g1 < _g) {
					var i : int = _g1++;
					if(ar[i] == as3d) return true;
				}
			}
			ar.push(as3d);
			existingPart.addChild(as3d);
			as3d.attachedAt = onTagName;
			as3d.parentPartName = toPartNamed;
			kftg.attachedAt = onTagName;
			as3d.__setFrameUpdateBounds(this.m_bFrameUpdateBounds);
			as3d.__setInterpolateBounds(this.m_bInterpolateBounds);
			this.changed = true; //this.__setChanged(true);
			kftg.__setFrame(kftg.__getFrame());
			return true;
		}
		
		protected function registerPart(as3d : sandy.core.scenegraph.AnimatedShape3D) : Boolean {
			as3d.m_oRoot = this.m_oRoot;
			as3d.m_bIsRoot = false;
			var a : Array = new Array();
			var o : sandy.core.scenegraph.AnimatedShape3D = this;
			do {
				if(o.m_hParts.exists(as3d.name)) return false;
				a.push(o);
				o = function($this:AnimatedShape3D) : sandy.core.scenegraph.AnimatedShape3D {
					var $r : sandy.core.scenegraph.AnimatedShape3D;
					try {
						$r = o.parent;//__getParent();
					}
					catch( e : * ){
						$r = null;
					}
					return $r;
				}(this);
			} while(o != null && Std._is(o,sandy.core.scenegraph.AnimatedShape3D));
			a.reverse();
			{
				var _g : int = 0;
				while(_g < a.length) {
					var o1 : sandy.core.scenegraph.AnimatedShape3D = a[_g];
					++_g;
					o1.m_hParts.set(as3d.name,as3d);
				}
			}
			return true;
		}
		
		public function detach(as3d : sandy.core.scenegraph.AnimatedShape3D) : sandy.core.scenegraph.AnimatedShape3D {
			super.removeChild(as3d);
			{ var $it : * = this.m_hTagAttachments.iterator();
			while( $it.hasNext() ) { var a : Array = $it.next();
			{
				{
					var _g1 : int = 0, _g : int = a.length;
					while(_g1 < _g) {
						var i : int = _g1++;
						if(a[i] == as3d) {
							a.splice(i,1);
							break;
						}
					}
				}
			}
			}}
			as3d.attachedAt = null;
			this.updateBoundingVolumes();
			this.changed = true;// __setChanged(true);
			return as3d;
		}
		
		public function getPart(p_sName : String) : sandy.core.scenegraph.AnimatedShape3D {
			{
				var _g1 : int = 1, _g : int = this.children.length;
				while(_g1 < _g) {
					var i : int = _g1++;
					if(this.children[i].name == p_sName) return this.children[i];
				}
			}
			var p : sandy.core.scenegraph.Node = this.getChildByName(p_sName,true);
			if(p == null) return null;
			if(Std._is(p,sandy.core.scenegraph.AnimatedShape3D)) return function($this:AnimatedShape3D) : sandy.core.scenegraph.AnimatedShape3D {
				var $r : sandy.core.scenegraph.AnimatedShape3D;
				var tmp : sandy.core.scenegraph.Node = p;
				$r = (Std._is(tmp,sandy.core.scenegraph.AnimatedShape3D)?tmp:function($this:AnimatedShape3D) : sandy.core.scenegraph.Node {
					var $r2 : sandy.core.scenegraph.Node;
					throw "Class cast error";
					return $r2;
				}($this));
				return $r;
			}(this);
			return null;
		}
		
		public function onFrameChanged(p_oChild : sandy.core.scenegraph.KeyFramedTransformGroup,p_ahMatrices : Array) : void {
			{
				var _g : int = 0;
				while(_g < p_ahMatrices.length) {
					var mh : Hash = p_ahMatrices[_g];
					++_g;
					{ var $it : * = mh.keys();
					while( $it.hasNext() ) { var key : String = $it.next();
					{
						if(key == this.attachedAt) this.m_oLastTagUpdateMatrix = mh.get(key);
						var ar : Array = this.m_hTagAttachments.get(key);
						if(ar == null) continue;
						var matrix : sandy.core.data.Matrix4 = mh.get(key);
						{
							var _g1 : int = 0;
							while(_g1 < ar.length) {
								var o : sandy.core.scenegraph.AnimatedShape3D = ar[_g1];
								++_g1;
								o.applyTagMatrix(key,matrix);
							}
						}
					}
					}}
				}
			}
		}
		
		protected function applyTagMatrix(p_sTagName : String,p_oMatrix : sandy.core.data.Matrix4) : void {
			this.m_oMatrix.n11 = p_oMatrix.n11;
			this.m_oMatrix.n12 = p_oMatrix.n12;
			this.m_oMatrix.n13 = p_oMatrix.n13;
			this.m_oMatrix.n21 = p_oMatrix.n21;
			this.m_oMatrix.n22 = p_oMatrix.n22;
			this.m_oMatrix.n23 = p_oMatrix.n23;
			this.m_oMatrix.n31 = p_oMatrix.n31;
			this.m_oMatrix.n32 = p_oMatrix.n32;
			this.m_oMatrix.n33 = p_oMatrix.n33;
			if(this.attachedAt != null && this.m_oLastTagUpdateMatrix != null) this.m_oMatrix.multiply3x3(this.m_oLastTagUpdateMatrix);
			this._p.x = p_oMatrix.n14;
			this._p.y = p_oMatrix.n24;
			this._p.z = p_oMatrix.n34;
			this.changed = true;// __setChanged(true);
		}
		
		public function __getTagNames() : * {
			if(this.m_oKeyFramedGroup == null) return { iterator : function() : * {
				return { next : function() : String {
					return null;
				}, hasNext : function() : Boolean {
					return false;
				}}
			}}
			var a : Array = new Array();
			{
				var _g : int = 0, _g1 : Array = this.m_oKeyFramedGroup.children;
				while(_g < _g1.length) {
					var c : sandy.core.scenegraph.Node = _g1[_g];
					++_g;
					if(Std._is(c,sandy.core.scenegraph.TagCollection)) {
						var h : Hash = function($this:AnimatedShape3D) : sandy.core.scenegraph.TagCollection {
							var $r : sandy.core.scenegraph.TagCollection;
							var tmp : sandy.core.scenegraph.Node = c;
							$r = (Std._is(tmp,sandy.core.scenegraph.TagCollection)?tmp:function($this:AnimatedShape3D) : sandy.core.scenegraph.Node {
								var $r2 : sandy.core.scenegraph.Node;
								throw "Class cast error";
								return $r2;
							}($this));
							return $r;
						}(this).__getTags();
						{ var $it : * = h.keys();
						while( $it.hasNext() ) { var s : String = $it.next();
						a.push(s);
						}}
					}
				}
			}
			return { iterator : function() : * {
				return { idx : 0, arr : a, hasNext : function() : Boolean {
					return this.idx < this.arr.length;
				}, next : function() : String {
					return this.arr[this.idx++];
				}}
			}}
		}
		
		public function __getTagCollections() : * {
			if(this.m_oKeyFramedGroup == null) return { iterator : function() : * {
				return { next : function() : sandy.core.scenegraph.TagCollection {
					return null;
				}, hasNext : function() : Boolean {
					return false;
				}}
			}}
			var a : Array = new Array();
			{
				var _g : int = 0, _g1 : Array = this.m_oKeyFramedGroup.children;
				while(_g < _g1.length) {
					var c : sandy.core.scenegraph.Node = _g1[_g];
					++_g;
					if(Std._is(c,sandy.core.scenegraph.TagCollection)) a.push(function($this:AnimatedShape3D) : sandy.core.scenegraph.TagCollection {
						var $r : sandy.core.scenegraph.TagCollection;
						var tmp : sandy.core.scenegraph.Node = c;
						$r = (Std._is(tmp,sandy.core.scenegraph.TagCollection)?tmp:function($this:AnimatedShape3D) : sandy.core.scenegraph.Node {
							var $r2 : sandy.core.scenegraph.Node;
							throw "Class cast error";
							return $r2;
						}($this));
						return $r;
					}(this));
				}
			}
			return { iterator : function() : * {
				return { idx : 0, arr : a, hasNext : function() : Boolean {
					return this.idx < this.arr.length;
				}, next : function() : sandy.core.scenegraph.TagCollection {
					return this.arr[this.idx++];
				}}
			}}
		}
		
		public function __getCurrentAnimation() : sandy.animation.Animation {
			return this.m_oCurrentAnimation;
		}
		
		public function __setCurrentAnimation(v : sandy.animation.Animation) : sandy.animation.Animation {
			return this.m_oCurrentAnimation = v;
		}
		
		public function __getCurrentAnimationTween() : * {
			return this.m_oCurrentAnimationTween;
		}
		
		public function __setCurrentAnimationTween(v : *) : * {
			return this.m_oCurrentAnimationTween = v;
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
						(function($this:AnimatedShape3D) : sandy.animation.IKeyFramed {
							var $r : sandy.animation.IKeyFramed;
							var tmp : sandy.core.scenegraph.Node = c;
							$r = (Std._is(tmp,sandy.animation.IKeyFramed)?tmp:function($this:AnimatedShape3D) : sandy.core.scenegraph.Node {
								var $r2 : sandy.core.scenegraph.Node;
								throw "Class cast error";
								return $r2;
							}($this));
							return $r;
						})(this).__setFrameUpdateBounds(v);
					}
					else if(Std._is(c,sandy.core.scenegraph.AnimatedShape3D)) {
						(function($this:AnimatedShape3D) : sandy.animation.IKeyFramed {
							var $r3 : sandy.animation.IKeyFramed;
							var tmp2 : sandy.core.scenegraph.Node = c;
							$r3 = (Std._is(tmp2,sandy.animation.IKeyFramed)?tmp2:function($this:AnimatedShape3D) : sandy.core.scenegraph.Node {
								var $r4 : sandy.core.scenegraph.Node;
								throw "Class cast error";
								return $r4;
							}($this));
							return $r3;
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
						(function($this:AnimatedShape3D) : sandy.animation.IKeyFramed {
							var $r : sandy.animation.IKeyFramed;
							var tmp : sandy.core.scenegraph.Node = c;
							$r = (Std._is(tmp,sandy.animation.IKeyFramed)?tmp:function($this:AnimatedShape3D) : sandy.core.scenegraph.Node {
								var $r2 : sandy.core.scenegraph.Node;
								throw "Class cast error";
								return $r2;
							}($this));
							return $r;
						})(this).__setInterpolateBounds(v);
					}
					else if(Std._is(c,sandy.core.scenegraph.AnimatedShape3D)) {
						(function($this:AnimatedShape3D) : sandy.animation.IKeyFramed {
							var $r3 : sandy.animation.IKeyFramed;
							var tmp2 : sandy.core.scenegraph.Node = c;
							$r3 = (Std._is(tmp2,sandy.animation.IKeyFramed)?tmp2:function($this:AnimatedShape3D) : sandy.core.scenegraph.Node {
								var $r4 : sandy.core.scenegraph.Node;
								throw "Class cast error";
								return $r4;
							}($this));
							return $r3;
						})(this).__setInterpolateBounds(v);
					}
				}
			}
			return this.m_bInterpolateBounds = v;
		}
		
		public override function toString() : String {
			return "sandy.core.scenegraph.AnimatedShape3D :[" + this.name + "]";
		}
		
		public override function removeChildByName(p_sName : String) : sandy.core.scenegraph.Node {
			return function($this:AnimatedShape3D) : sandy.core.scenegraph.Node {
				var $r : sandy.core.scenegraph.Node;
				throw "Not implemented";
				return $r;
			}(this);
		}
		
		public override function swapParent(p_oNewParent : sandy.core.scenegraph.Node) : void {
			throw "Not implemented";
		}
		
		public override function removeChild(p_oNode : sandy.core.scenegraph.Node) : sandy.core.scenegraph.Node {
			return function($this:AnimatedShape3D) : sandy.core.scenegraph.Node {
				var $r : sandy.core.scenegraph.Node;
				throw "Not implemented";
				return $r;
			}(this);
		}
		
		public override function clone(p_sName : String) : sandy.core.scenegraph.TransformGroup {
			var l_oGroup : sandy.core.scenegraph.AnimatedShape3D = new sandy.core.scenegraph.AnimatedShape3D(p_sName,null);
			{
				var _g : int = 0, _g1 : Array = this.children;
				while(_g < _g1.length) {
					var l_oNode : sandy.core.scenegraph.Node = _g1[_g];
					++_g;
					if(Std._is(l_oNode,sandy.core.scenegraph.AnimatedShape3D)) {
						var as3d : sandy.core.scenegraph.AnimatedShape3D = function($this:AnimatedShape3D) : sandy.core.scenegraph.AnimatedShape3D {
							var $r : sandy.core.scenegraph.AnimatedShape3D;
							var tmp : sandy.core.scenegraph.Node = l_oNode;
							$r = (Std._is(tmp,sandy.core.scenegraph.AnimatedShape3D)?tmp:function($this:AnimatedShape3D) : sandy.core.scenegraph.Node {
								var $r2 : sandy.core.scenegraph.Node;
								throw "Class cast error";
								return $r2;
							}($this));
							return $r;
						}(this);
						var cl : sandy.core.scenegraph.TransformGroup = as3d.clone(as3d.name);
						l_oGroup.attach(cl,as3d.name,as3d.parentPartName,as3d.attachedAt);
					}
					else if(Std._is(l_oNode,sandy.core.scenegraph.KeyFramedTransformGroup)) {
						l_oGroup.addChild(KeyFramedTransformGroup(l_oNode).clone(l_oNode.name));
					}
				}
			}
			return l_oGroup;
		}
		
		protected var m_bFrameUpdateBounds : Boolean;
		protected var m_bInterpolateBounds : Boolean;
	}
}
