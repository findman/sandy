
package sandy.core.scenegraph
{
	import sandy.bounds.BBox;
	import sandy.core.data.haxe.TypedDictionary;
	import sandy.core.data.Matrix4;
	import sandy.view.CullingState;
	import sandy.view.Frustum;	

	/**
	 * The TransformGroup class is used to create transform group.
	 *
	 * <p>It represents a node in the object tree of the world.<br/>
	 * Transformations performed on this group are applied to all its children.</p>
	 * <p>The class is final, i.e. it can not be subclassed.
	 *
	 * @author		Thomas Pfeiffer - kiroukou
	 * @version		3.1
	 * @date 		26.07.2007
	 */
	public class TransformGroup extends ATransformable
	{
		/**
		 * Creates a transform group.
		 *
		 * @param  p_sName	A string identifier for this object
		 */
		public function TransformGroup( p_sName:String = "" )
		{
			super( p_sName );
			this.m_dChildBounds = new TypedDictionary();
		}


		/**
		 * Tests this node against the camera frustum to get its visibility.
		 *
		 * <p>If this node and its children are not within the frustum,
		 * the node is set to cull and it would not be displayed.<p/>
		 * <p>The method also updates the bounding volumes to make the more accurate culling system possible.<br/>
		 * First the bounding sphere is updated, and if intersecting,
		 * the bounding box is updated to perform the more precise culling.</p>
		 * <p><b>[MANDATORY] The update method must be called first!</b></p>
		 *
		 * @param p_oScene The current scene
		 * @param p_oFrustum	The frustum of the current camera
		 * @param p_oViewMatrix	The view martix of the curren camera
		 * @param p_bChanged
		 */
		public override function cull( p_oFrustum:Frustum, p_oViewMatrix:Matrix4, p_bChanged:Boolean ):void
		{
			// TODO
			// Parse the children, take their bounding volume and merge it with the current node recurssively.
			// After that call the super cull method to get the correct cull value.
			if( visible == false )
			{
				culled = CullingState.OUTSIDE;
			}
			else
			{
			    const lChanged:Boolean = p_bChanged || changed;
			    for each( var l_oNode:Node in children )
			    {
			        l_oNode.cull( p_oFrustum, p_oViewMatrix, lChanged );
			    }
			}
		}

		public function clone( p_sName:String ):TransformGroup
		{
			var l_oGroup:TransformGroup = new TransformGroup( p_sName );
			
			for each( var l_oNode:* in children )
			{
				if( l_oNode is Shape3D || l_oNode is Group || l_oNode is TransformGroup )
				{
					l_oGroup.addChild( l_oNode.clone( p_sName+"_"+l_oNode.name ) );
				} 
			}
			
			return l_oGroup;
		}
		
		/**
		 * Returns a string representation of the TransformGroup.
		 *
		 * @return	The fully qualified name.
		 */
		public override function toString():String
		{
			return "sandy.core.scenegraph.TransformGroup :["+name+"]";
		}

		// haxe stuff below -------------------------------------------------------------
		public var trackBounds : Boolean;
		protected var m_dChildBounds : TypedDictionary;
		protected var m_bUpdatingBounds : Boolean;
		public override function addChild(p_oChild : sandy.core.scenegraph.Node) : void {
			super.addChild(p_oChild);
			this.updateChildBoundsCache(p_oChild);
		}
		
		public override function destroy() : void {
			super.destroy();
			{ var $it : * = this.m_dChildBounds.iterator();
			while( $it.hasNext() ) { var k : sandy.core.scenegraph.Node = $it.next();
			this.m_dChildBounds._delete(k);
			}}
			this.m_dChildBounds = null;
		}
		
		public override function onChildBoundsChanged(child : sandy.core.scenegraph.Node) : void {
			if(this.m_bUpdatingBounds) return;
			this.updateChildBoundsCache(child);
			this.boundingBox.reset();
			{ var $it : * = this.m_dChildBounds.iterator();
			while( $it.hasNext() ) { var key : sandy.core.scenegraph.Node = $it.next();
			this.boundingBox.merge(this.m_dChildBounds.get(key));
			}}
			this.boundingSphere.resetFromBox(this.boundingBox);
			if(this.parent/*__getParent()*/ != null) this.parent/*__getParent()*/.onChildBoundsChanged(this);
		}
		
		public override function removeChild(p_oNode : sandy.core.scenegraph.Node) : sandy.core.scenegraph.Node {
			var rv : sandy.core.scenegraph.Node = super.removeChild(p_oNode);
			this.m_dChildBounds._delete(p_oNode);
			return rv;
		}
		
		public override function removeChildByName(p_sName : String) : sandy.core.scenegraph.Node {
			var rv : sandy.core.scenegraph.Node = super.removeChildByName(p_sName);
			if(rv != null) this.m_dChildBounds._delete(rv);
			return rv;
		}
		
		public override function updateBoundingVolumes() : void {
			this.m_bUpdatingBounds = true;
			this.boundingBox.reset();
			{
				var _g : int = 0, _g1 : Array = this.children;
				while(_g < _g1.length) {
					var child : sandy.core.scenegraph.Node = _g1[_g];
					++_g;
					child.updateBoundingVolumes();
					this.boundingBox.merge(this.updateChildBoundsCache(child));
				}
			}
			this.boundingSphere.resetFromBox(this.boundingBox);
			this.m_bUpdatingBounds = false;
		}
		
		protected function updateChildBoundsCache(child : sandy.core.scenegraph.Node) : sandy.bounds.BBox {
			var box : sandy.bounds.BBox = this.m_dChildBounds.get(child);
			if(box == null) {
				box = new sandy.bounds.BBox();
				this.m_dChildBounds.set(child,box);
			}
			box.copy(child.boundingBox);
			return box;
		}
	}
}
