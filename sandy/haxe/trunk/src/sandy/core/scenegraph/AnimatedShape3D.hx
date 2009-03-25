package sandy.core.scenegraph;

import sandy.animation.Animation;
import sandy.animation.Tag;
import sandy.core.data.Matrix4;
import sandy.primitive.KeyFramedShape3D;


import sandy.HaxeTypes;

/**
* An AnimatedShape3D is a container for a single KeyFramedTransformGroup, with
* any number of AnimatedShape3D's connected on the tags available in the
* KeyFramedTransformGroup. Animations may be applied to any AnimatedShape3D
* part of the tree.
*
* To create an AnimatedShape3D, the first base node should be created from
* a KeyFramedTransformGroup which acts as the 'bottom' or base of the
* completed object. In the case of a player model, the obvious choice
* is to start with the legs. After that, attach() parts to the base
* on the tags they belong to.
*
* @author		Russell Weir (madrok)
* @date 		03.21.2009
* @version		3.2
**/
class AnimatedShape3D extends TransformGroup {
	/** Arbitrary hash of animations **/
	public var animations : Hash<Animation>;

	/** Holder for arbitrary tweener for animating shape **/
	public var currentAnimation(__getCurrentAnimation,__setCurrentAnimation) : Dynamic;

	/** An iterator for the tag names available on this shape **/
	public var tagNames(__getTagNames, null) : Iterable<String>;

	// Root node of the AnimatedShape3D
	private var m_oRoot : AnimatedShape3D;
	// is this the root, ie. has it been attached to anything
	private var m_bIsRoot : Bool;
	// This is always children[0], the sole KeyFramedTransformGroup
	private var m_oKeyFramedGroup : KeyFramedTransformGroup;
	// Tags to connected AnimatedShape3D instances
	private var m_hTagAttachments : Hash<TypedArray<AnimatedShape3D>>;
	// hash of shape parts. ie. 'legs', 'torso'
	private var m_hParts : Hash<AnimatedShape3D>;

	private var parentPartName : String;
	private var attachedAt : String;
	private var m_oCurrentAnimation : Dynamic;

	/**
	* Creates a new AnimatedShape3D
	*
	* @param asPartName name of the shape part in the whole shape.
	* @param p_KeyFramed KeyFramedTransformGroup
	**/
	public function new( asPartName:String, ?p_KeyFramed : KeyFramedTransformGroup ) {
		super(asPartName);

		m_oRoot = this;
		m_bIsRoot = true;
		m_oKeyFramedGroup = p_KeyFramed;
		// --
		m_hTagAttachments = new Hash();
		// --
		m_hParts = new Hash();
		// --
		if( p_KeyFramed != null) {
			addChildInternal(p_KeyFramed);
			setDefaultTags(p_KeyFramed);
			m_hParts.set(asPartName, this);
		}
	}

	function setDefaultTags(p_KeyFramed : KeyFramedTransformGroup) {
		m_hTagAttachments = new Hash();
		for(t in __getTagNames()) {
			m_hTagAttachments.set(t, new TypedArray());
		}
	}

	public function attach( p_oChild : Dynamic, asPartName:String, toPartNamed:String=null, onTagName : String=null ) : Bool {
		var as3d : AnimatedShape3D = null;
		var kftg : KeyFramedTransformGroup = null;

		if(Std.is(p_oChild, KeyFramedShape3D)) {
			kftg = new KeyFramedTransformGroup();
			kftg.addChild(p_oChild);
		}
		else if(Std.is(p_oChild, KeyFramedTransformGroup)) {
			kftg = cast p_oChild;
		}
		else if(Std.is(p_oChild, AnimatedShape3D)) {
			as3d = cast p_oChild;
		}
		else {
			var msg = "Unable to attach " + Type.getClassName(Type.getClass(p_oChild)) + " to AnimatedShape3D";
			trace(msg);
			throw msg;
		}

		if(children.length == 0 && m_bIsRoot) {
			m_oKeyFramedGroup = kftg;
			addChildInternal(kftg);
			setDefaultTags(kftg);
			m_hParts.set(asPartName, this);
			return true;
		}

		// Creates a new AnimatedShape3D from the KeyFramedTransformGroup
		if(kftg != null)
			as3d = new AnimatedShape3D( asPartName, kftg );
		else
			kftg = cast as3d.children[0];

		#if debug
			var dbgCheckPartIsThis = false;
		#end
		if(toPartNamed == null) {
			toPartNamed = this.name;
			#if debug dbgCheckPartIsThis = true; #end
		}

		// get part, first from this node, then check from root node
		var existingPart : AnimatedShape3D = m_hParts.get(toPartNamed);
		if(existingPart == null)
			existingPart = m_oRoot.m_hParts.get(toPartNamed);
		#if debug
			// assertion
			if(dbgCheckPartIsThis && existingPart != this)
				throw "internal error";
		#end
		if(existingPart == null)
			return false;
		var existingPartTagAttachments = existingPart.m_hTagAttachments;

		var found = false;
		// automatic tag detection/attachment
		if(onTagName == null) {
			var found = false;
			for(key in as3d.tagNames) {
				if(existingPartTagAttachments.exists(key)) {
					onTagName = key;
					found = true;
					break;
				}
			}
			if(!found) return false;
		}

		// check tag exists in target
		if(!existingPartTagAttachments.exists(onTagName))
			return false;

		// register/check if part exists already
		// sets new part's m_bIsRoot and m_oRoot properties
		if(!existingPart.registerPart(as3d))
			return false;

		// --
		var ar = existingPartTagAttachments.get(onTagName);
		for(i in 0...ar.length)
			if(ar[i] == as3d)
				return true;
		// add as3d object to tag attachment array
		ar.push(as3d);

		// add the child
		existingPart.addChildInternal( as3d );

		// --
		as3d.attachedAt = onTagName;
		as3d.parentPartName = toPartNamed;
		kftg.attachedAt = onTagName;

		changed = true;

		// triggers the onFrameChanged method of the kftg parent
		kftg.frame = kftg.frame;

		return true;
	}

	/**
	* Crawls up the tree of AnimatedShape3D parents to set a part
	* name to an AnimatedShape3D instance.
	*
	**/
	private function registerPart( as3d : AnimatedShape3D ) : Bool {

		as3d.m_oRoot = this.m_oRoot;
		as3d.m_bIsRoot = false;

		var a = new Array<AnimatedShape3D>();
		var o = this;
		do {
			if(o.m_hParts.exists(as3d.name))
				return false;
			a.push(o);
			o = try cast o.parent catch(e:Dynamic) null;
		} while(o != null && Std.is(o, AnimatedShape3D));

		a.reverse();
		for(o in a) {
			o.m_hParts.set(as3d.name, as3d);
		}
		return true;
	}

	/**
	* Detaches and removes a child of this transform group. All children of the node
	* provided will also be detached.
	*
	* @param p_oChild The child group to remove.
	* @throws String if p_oChild is not a child of this Node
	**/
	public function detach( as3d : AnimatedShape3D ) : AnimatedShape3D {
		super.removeChild(as3d);

		// child really should not be atttached at more than one tag
		// but all are checked here.
		for(a in m_hTagAttachments) {
			for(i in 0...a.length) {
				if(a[i] == as3d) {
					a.splice( i, 1 );
					break;
				}
			}
		}

		as3d.attachedAt = null;
		changed = true;
		return as3d;
	}

	public function getPart( p_sName : String ) : AnimatedShape3D {
		for(i in 1...children.length) {
			if(children[i].name == p_sName)
				return cast children[i];
		}
		var p = getChildByName( p_sName, true );
		if(p == null) return null;

		if( Std.is(p, AnimatedShape3D) )
			return cast p;

		return null;
	}

	/**
	* Internal: Called from each KeyFramedTransformGroup child.
	*
	* @param p_oChild Child KeyFramedTransformGroup
	* @param p_hMatrix Hash of tag names to Matrix4 for current frame of KeyFramedTransformGroup
	*/
	public function onFrameChanged(p_oChild:KeyFramedTransformGroup, p_ahMatrices : TypedArray<Hash<Matrix4>>) {
		#if debug
			if(p_oChild.parent != this)
				throw "internal error";
		#end

		for(mh in p_ahMatrices) {
			for(key in mh.keys()) {
				var ar =  m_hTagAttachments.get(key);
				if(ar == null) {
					// trace("Nothing attached at " + key);
					continue;
				}
				for(o in ar) {
					o.resetCoords();
					o.matrix = mh.get(key).clone();
				}
			}
		}
	}

	private function __getTagNames() : Iterable<String> {
		if( m_oKeyFramedGroup == null )
			return
			{
				iterator:
					function() : Iterator<String>
					{
						return {
							next : function() { return null; },
							hasNext : function() { return false; },
						}
					},
			};

		var a : TypedArray<String> = new TypedArray();
		for(c in m_oKeyFramedGroup.children) {
			if(Std.is(c, TagCollection)) {
				var h = cast(c, TagCollection).tags;
				for(s in h.keys())
					a.push(s);
			}
		}
		return
		{
			iterator:
				function() : Iterator<String>
				{
					return untyped {
						idx : 0,
						arr : a,
						hasNext : function() {
							return this.idx <
								this.arr.length;
						},
						next : function() : String {
							return this.arr[this.idx++];
						},
					}
				},
		};
	}

	private function __getCurrentAnimation() : Dynamic {
		return m_oCurrentAnimation;
	}

	private function __setCurrentAnimation(v : Dynamic) : Dynamic {
		return m_oCurrentAnimation = v;
	}

	/**
	* Returns a string representation of the TransformGroup.
	*
	* @return	The fully qualified name.
	*/
	public override function toString():String
	{
		return "sandy.core.scenegraph.AnimatedShape3D :["+name+"]";
	}

	/////////////// Node overrides ///////////////////////////
	public override function addChild( p_oChild:Node ):Void
	{
		throw "Not implemented";
	}

	public override function removeChildByName( p_sName:String ):Bool
	{
		return throw "Not implemented";
	}

	public override function swapParent( p_oNewParent:Node ):Void
	{
		throw "Not implemented";
	}

	public override function removeChild( p_oNode : Node ) : Node {
		return throw "Not implemented";
	}

	public override function clone( p_sName:String ):TransformGroup
	{
		var l_oGroup = new AnimatedShape3D( p_sName, null );

		for ( l_oNode in children )
		{
			if( Std.is(l_oNode, AnimatedShape3D) ) {
				var as3d = cast(l_oNode, AnimatedShape3D);
				var cl = as3d.clone(as3d.name);
				l_oGroup.attach( cl, as3d.name, as3d.parentPartName, as3d.attachedAt);
			}
			else if( Std.is(l_oNode, KeyFramedTransformGroup) ) {
				l_oGroup.addChildInternal( untyped l_oNode.clone( l_oNode.name ) );
		    }
		}
		return l_oGroup;
	}

	private function addChildInternal( p_oChild:Node ) {
		super.addChild( p_oChild );
	}


}