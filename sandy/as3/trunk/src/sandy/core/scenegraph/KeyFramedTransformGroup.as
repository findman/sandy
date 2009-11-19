// This class is generated from haxe branch r1141, with flash.Boot, haxe.Log references manually commented out
// and haxe types imported from sandy.core.data.haxe
package sandy.core.scenegraph {
	import sandy.animation.IKeyFramed;
	import sandy.core.scenegraph.Node;
	import sandy.core.scenegraph.AnimatedShape3D;
	//import haxe.Log;
	import sandy.core.scenegraph.TagCollection;
	import sandy.core.scenegraph.TransformGroup;
	import sandy.primitive.KeyFramedShape3D;
	//import flash.Boot;
	import sandy.core.data.haxe.*;
	public class KeyFramedTransformGroup extends sandy.core.scenegraph.TransformGroup implements sandy.animation.IKeyFramed{
		public function KeyFramedTransformGroup(p_sName : String = "") : void { //if( !flash.Boot.skip_constructor ) {
			super(p_sName);
			this.trackBounds = true;
			this.m_nCurFrame = 0;
			this.m_nFrames = 0;
			this.m_aCurrentTags = new Array();
			this.m_bEditable = true;
			this.m_bFrameUpdateBounds = false;
			this.m_bInterpolateBounds = false;
		}//}
		
		public var attachedAt : String;
		public function get currentFrameMatrices() : Array { return __getCurrentFrameMatrices(); }
		protected var $currentFrameMatrices : Array;
		public function get frame() : Number { return __getFrame(); }
		public function set frame( __v : Number ) : void { __setFrame(__v); }
		protected var $frame : Number;
		public function get frameCount() : int { return __getFrameCount(); }
		protected var $frameCount : int;
		public function get frameUpdateBounds() : Boolean { return __getFrameUpdateBounds(); }
		public function set frameUpdateBounds( __v : Boolean ) : void { __setFrameUpdateBounds(__v); }
		protected var $frameUpdateBounds : Boolean;
		public function get interpolateBounds() : Boolean { return __getInterpolateBounds(); }
		public function set interpolateBounds( __v : Boolean ) : void { __setInterpolateBounds(__v); }
		protected var $interpolateBounds : Boolean;
		public override function addChild(p_oChild : sandy.core.scenegraph.Node) : void {
			if(!Std._is(p_oChild,sandy.animation.IKeyFramed) || p_oChild == null) throw "Invalid child type";
			var kf : sandy.animation.IKeyFramed = function($this:KeyFramedTransformGroup) : sandy.animation.IKeyFramed {
				var $r : sandy.animation.IKeyFramed;
				var tmp : sandy.core.scenegraph.Node = p_oChild;
				$r = (Std._is(tmp,sandy.animation.IKeyFramed)?tmp:function($this:KeyFramedTransformGroup) : sandy.core.scenegraph.Node {
					var $r2 : sandy.core.scenegraph.Node;
					throw "Class cast error";
					return $r2;
				}($this));
				return $r;
			}(this);
			if(this.children.length == 0) {
				this.m_nFrames = kf.__getFrameCount();
			}
			if(kf.__getFrameCount() != this.m_nFrames) {
				/*haxe.Log.*/trace("IKeyFramed " + p_oChild.name + " frame count " + kf.__getFrameCount() + " incorrect. Expected " + this.m_nFrames + ". Disabling edits.",{ fileName : "KeyFramedTransformGroup.hx", lineNumber : 66, className : "sandy.core.scenegraph.KeyFramedTransformGroup", methodName : "addChild"});
				this.m_bEditable = false;
			}
			if(Std._is(p_oChild,sandy.core.scenegraph.TagCollection)) {
				super.addChild(p_oChild);
			}
			else if(Std._is(p_oChild,sandy.primitive.KeyFramedShape3D)) {
				super.addChild(p_oChild);
			}
			else if(Std._is(p_oChild,sandy.core.scenegraph.KeyFramedTransformGroup)) {
				{
					var _g : int = 0, _g1 : Array = p_oChild.children;
					while(_g < _g1.length) {
						var c : sandy.core.scenegraph.Node = _g1[_g];
						++_g;
						super.addChild(c);
					}
				}
			}
			else {
				throw "Invalid/unhandled child type";
			}
			kf.__setFrame(this.m_nCurFrame);
		}
		
		public override function clone(p_sName : String) : sandy.core.scenegraph.TransformGroup {
			var l_oGroup : sandy.core.scenegraph.KeyFramedTransformGroup = new sandy.core.scenegraph.KeyFramedTransformGroup(p_sName);
			{
				var _g : int = 0, _g1 : Array = this.children;
				while(_g < _g1.length) {
					var l_oNode : sandy.core.scenegraph.Node = _g1[_g];
					++_g;
					if(l_oNode.hasOwnProperty("clone")/*Reflect.hasField(l_oNode,"clone")*/) {
						l_oGroup.addChild(Object (l_oNode).clone(p_sName + "_" + l_oNode.name));
					}
				}
			}
			l_oGroup.m_nCurFrame = this.m_nCurFrame;
			l_oGroup.m_nFrames = this.m_nFrames;
			l_oGroup.m_bFrameUpdateBounds = this.m_bFrameUpdateBounds;
			l_oGroup.m_bInterpolateBounds = this.m_bInterpolateBounds;
			var a : Array = new Array();
			{
				var _g12 : int = 0, _g2 : int = this.m_aCurrentTags.length;
				while(_g12 < _g2) {
					var i : int = _g12++;
					var h : Hash = new Hash();
					{ var $it : * = this.m_aCurrentTags[i].keys();
					while( $it.hasNext() ) { var key : String = $it.next();
					{
						h.set(key,this.m_aCurrentTags[i].get(key).clone());
					}
					}}
					a.push(h);
				}
			}
			l_oGroup.m_aCurrentTags = a;
			l_oGroup.m_bEditable = this.m_bEditable;
			l_oGroup.__setFrame(this.__getFrame());
			return l_oGroup;
		}
		
		public function __getCurrentFrameMatrices() : Array {
			return this.m_aCurrentTags;
		}
		
		public override function toString() : String {
			return "sandy.core.scenegraph.KeyFramedTransformGroup :[" + this.name + "]";
		}
		
		public function setSkin(data : Hash) : void {
			{
				var _g : int = 0, _g1 : Array = this.children;
				while(_g < _g1.length) {
					var c : sandy.core.scenegraph.Node = _g1[_g];
					++_g;
					/*haxe.Log.*/trace(c.name,{ fileName : "KeyFramedTransformGroup.hx", lineNumber : 137, className : "sandy.core.scenegraph.KeyFramedTransformGroup", methodName : "setSkin"});
				}
			}
		}
		
		public function appendFrameCopy(frameNumber : int) : int {
			if(!this.m_bEditable) throw "Mismatched frame counts do not allow for edits";
			var rv : int = -1;
			{
				var _g : int = 0, _g1 : Array = this.children;
				while(_g < _g1.length) {
					var l_oNode : sandy.core.scenegraph.Node = _g1[_g];
					++_g;
					if(Std._is(l_oNode,sandy.animation.IKeyFramed)) {
						var kf : sandy.animation.IKeyFramed = function($this:KeyFramedTransformGroup) : sandy.animation.IKeyFramed {
							var $r : sandy.animation.IKeyFramed;
							var tmp : sandy.core.scenegraph.Node = l_oNode;
							$r = (Std._is(tmp,sandy.animation.IKeyFramed)?tmp:function($this:KeyFramedTransformGroup) : sandy.core.scenegraph.Node {
								var $r2 : sandy.core.scenegraph.Node;
								throw "Class cast error";
								return $r2;
							}($this));
							return $r;
						}(this);
						rv = kf.appendFrameCopy(frameNumber);
					}
				}
			}
			return rv;
		}
		
		public function replaceFrame(destFrame : int,sourceFrame : Number) : void {
			if(!this.m_bEditable) throw "Mismatched frame counts do not allow for edits";
			{
				var _g : int = 0, _g1 : Array = this.children;
				while(_g < _g1.length) {
					var l_oNode : sandy.core.scenegraph.Node = _g1[_g];
					++_g;
					if(Std._is(l_oNode,sandy.animation.IKeyFramed)) {
						var kf : sandy.animation.IKeyFramed = function($this:KeyFramedTransformGroup) : sandy.animation.IKeyFramed {
							var $r : sandy.animation.IKeyFramed;
							var tmp : sandy.core.scenegraph.Node = l_oNode;
							$r = (Std._is(tmp,sandy.animation.IKeyFramed)?tmp:function($this:KeyFramedTransformGroup) : sandy.core.scenegraph.Node {
								var $r2 : sandy.core.scenegraph.Node;
								throw "Class cast error";
								return $r2;
							}($this));
							return $r;
						}(this);
						kf.replaceFrame(destFrame,sourceFrame);
					}
				}
			}
		}
		
		public function __getFrame() : Number {
			return this.m_nCurFrame;
		}
		
		public function __getFrameCount() : int {
			return this.m_nFrames;
		}
		
		public function __setFrame(value : Number) : Number {
			this.m_nCurFrame = value;
			var fInt : int = Std._int(this.m_nCurFrame);
			var c1 : Number = this.m_nCurFrame - fInt;
			var c2 : Number = 1 - c1;
			this.m_aCurrentTags.splice(0,this.m_aCurrentTags.length);
			{
				var _g : int = 0, _g1 : Array = this.children;
				while(_g < _g1.length) {
					var l_oNode : sandy.core.scenegraph.Node = _g1[_g];
					++_g;
					if(Std._is(l_oNode,sandy.core.scenegraph.TagCollection)) {
						var kf : sandy.core.scenegraph.TagCollection = function($this:KeyFramedTransformGroup) : sandy.core.scenegraph.TagCollection {
							var $r : sandy.core.scenegraph.TagCollection;
							var tmp : sandy.core.scenegraph.Node = l_oNode;
							$r = (Std._is(tmp,sandy.core.scenegraph.TagCollection)?tmp:function($this:KeyFramedTransformGroup) : sandy.core.scenegraph.Node {
								var $r2 : sandy.core.scenegraph.Node;
								throw "Class cast error";
								return $r2;
							}($this));
							return $r;
						}(this);
						kf.__setFrame(this.m_nCurFrame);
						var tagMatrices : Hash = kf.getCurrentFrameTags();
						this.m_aCurrentTags.push(tagMatrices);
					}
					else if(Std._is(l_oNode,sandy.animation.IKeyFramed)) {
						var kf2 : sandy.animation.IKeyFramed = (function($this:KeyFramedTransformGroup) : sandy.animation.IKeyFramed {
							var $r3 : sandy.animation.IKeyFramed;
							var tmp2 : sandy.core.scenegraph.Node = l_oNode;
							$r3 = (Std._is(tmp2,sandy.animation.IKeyFramed)?tmp2:function($this:KeyFramedTransformGroup) : sandy.core.scenegraph.Node {
								var $r4 : sandy.core.scenegraph.Node;
								throw "Class cast error";
								return $r4;
							}($this));
							return $r3;
						})(this);
						kf2.__setFrame(this.m_nCurFrame);
					}
				}
			}
			if(this.m_aCurrentTags.length > 0) {
				if(this.hasParent() && Std._is(this.parent/*__getParent()*/,sandy.core.scenegraph.AnimatedShape3D)) {
					(function($this:KeyFramedTransformGroup) : sandy.core.scenegraph.AnimatedShape3D {
						var $r5 : sandy.core.scenegraph.AnimatedShape3D;
						var tmp3 : sandy.core.scenegraph.Node = $this.parent/*__getParent()*/;
						$r5 = (Std._is(tmp3,sandy.core.scenegraph.AnimatedShape3D)?tmp3:function($this:KeyFramedTransformGroup) : sandy.core.scenegraph.Node {
							var $r6 : sandy.core.scenegraph.Node;
							throw "Class cast error";
							return $r6;
						}($this));
						return $r5;
					})(this).onFrameChanged(this,this.m_aCurrentTags);
				}
			}
			this.changed = true;//this.__setChanged(true);
			return value;
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
						(function($this:KeyFramedTransformGroup) : sandy.animation.IKeyFramed {
							var $r : sandy.animation.IKeyFramed;
							var tmp : sandy.core.scenegraph.Node = c;
							$r = (Std._is(tmp,sandy.animation.IKeyFramed)?tmp:function($this:KeyFramedTransformGroup) : sandy.core.scenegraph.Node {
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
						(function($this:KeyFramedTransformGroup) : sandy.animation.IKeyFramed {
							var $r : sandy.animation.IKeyFramed;
							var tmp : sandy.core.scenegraph.Node = c;
							$r = (Std._is(tmp,sandy.animation.IKeyFramed)?tmp:function($this:KeyFramedTransformGroup) : sandy.core.scenegraph.Node {
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
		
		protected var m_nCurFrame : Number;
		protected var m_nFrames : int;
		protected var m_aCurrentTags : Array;
		protected var m_bFrameUpdateBounds : Boolean;
		protected var m_bInterpolateBounds : Boolean;
		protected var m_bEditable : Boolean;
	}
}
