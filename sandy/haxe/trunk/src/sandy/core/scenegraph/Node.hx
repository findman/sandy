/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author or authors.
Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
	http://www.mozilla.org/MPL/MPL-1.1.html
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# ***** END LICENSE BLOCK *****
*/

package sandy.core.scenegraph;

import flash.events.Event;
import sandy.bounds.BBox;
import sandy.bounds.BSphere;
import sandy.core.Scene3D;
import sandy.core.data.Matrix4;
import sandy.events.BubbleEventBroadcaster;
import sandy.view.CullingState;
import sandy.view.Frustum;
import sandy.materials.Appearance;

/**
 * ABSTRACT CLASS - Base class for all nodes in the object tree.
 *
 * <p>The base class for all Group and object nodes,
 * that handles all basic operations on a tree node.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 **/
class Node
{
	/**
	 * This property represent the culling state of the current node.
	 * This state is defined during the culling phasis as it refers to the position of the object against the viewing frustum.
	 */
	public var culled:CullingState;

	/**
	 * Name of this node.
	 * Of no name is specified, the unique ID of the node will be used
	 */
	public var name:String;
	
	/**
	 * The children of this node are stored inside this array.
	 * IMPORTANT: Use this property mainly as READ ONLY. To add, delete or search a specific child, you can use the specific method to do that
	 */
	public var children:Array<Node>;
	
	/**
	 *  Cached matrix corresponding to the transformation to the 0,0,0 frame system
	 */
	public var modelMatrix:Matrix4;
	
	/**
	 * Cached matrix corresponding to the transformation to the camera frame system
	 */
	public var viewMatrix:Matrix4;
	
	/**
	 * The bounding box of this node
	 * IMPORTANT: Do not modify it unless you perfectly know what you are doing
	 */
	public var boundingBox:BBox;
	
	/**
	 * The bounding sphere of this node
	 * IMPORTANT: Do not modify it unless you perfectly know what you are doing
	 */
	public var boundingSphere:BSphere;
	
	/**
	 * The unique id of this node in the node graph.
	 * <p>This value is very useful to retrieve a specific node.</p>
	 */
	public var id:Int;
	
	/**
	 * Specify the visibility of this node.
	 * If true, the node is visible, if fase, it will not be displayed.
	 */
	public var visible : Bool;

	/**
	 * Reference to the scene is it linked to.
	 * Initialized at null.
	 */
	public var scene:Scene3D;
	
	/**
	 * Creates a node in the object tree of the world.
	 *
	 * <p>This constructor should normally not be called directly, only from a sub class.</p>
	 *
	 * @param p_sName	A string identifier for this object.
	 */
	public function new( p_sName:String )
	{
		id = _ID_++;
	 culled = CullingState.OUTSIDE;
	 visible = true;
	 scene = null;

	 children = new Array();
	 modelMatrix = new Matrix4();
	 viewMatrix = new Matrix4();
	
	 changed = false;

		p_sName = (p_sName != null)?p_sName:"";

		parent = null;
		// --
		if( p_sName != null )	name = p_sName;
		else name = Std.string(id);
		// --
		changed = true;
		m_oEB = new BubbleEventBroadcaster();
		// --
		culled = CullingState.INSIDE;
	}

	/**
	 * The broadcaster
	 *
	 * <p>The broadcaster is used to send events to listeners.<br />
	 * This property is a BubbleEventBroadcaster.</p>
	 *
	 * @return The instance of the current node broadcaster.
	 */
	public var broadcaster(__getBroadcaster,null):BubbleEventBroadcaster;
	public function __getBroadcaster():BubbleEventBroadcaster
	{
		return m_oEB;
	}
	
	/**
	 * Adds a listener for the specified event.
	 *
	 * @param p_sEvt Name of the Event.
	 * @param p_oL Listener object.
	 */
	public function addEventListener<T>(p_sEvt:String, p_oL:T->Void ) : Void
	{
		Reflect.callMethod( p_sEvt, m_oEB.addEventListener, [p_sEvt,p_oL] );
		//untyped( m_oEB.addEventListener.apply(p_sEvt, [p_sEvt,p_oL]) );
	}

	/**
	 * Removes a listener for the specified event.
	 *
	 * @param p_sEvt Name of the Event.
	 * @param oL Listener object.
	 */
	public function removeEventListener(p_sEvt:String, p_oL:Event->Void) : Void
	{
		m_oEB.removeEventListener(p_sEvt, p_oL);
	}

	/**
	 * Tests if the node passed in the argument is parent of this node.
	 *
	 * @param p_oNode 	The node you are testing
	 * @return		true if the node in the argument is the parent of this node, false otherwise.
	 */
	public function isParent( p_oNode:Node ):Bool
	{
		return (_parent == p_oNode && p_oNode != null);
	}

	/**
	 * Make all the Shape3D and descendants children react to this value.
	 * @param p_bUseSingleContainer if true, the whole objects will use a container to display the geometry into, otherwise, a specific container will be given to each polygon 
	 */
 public var useSingleContainer( __getUseSingleContainer,__setUseSingleContainer ):Bool;

	private function __getUseSingleContainer ():Bool
	{return false;}

	private function __setUseSingleContainer( p_bUseSingleContainer:Bool ):Bool
	{
		for ( l_oNode in children )
		{
			l_oNode.useSingleContainer = p_bUseSingleContainer;
		}
		return p_bUseSingleContainer;
	}
	
	/**
	 * Change the backface culling state to all the shapes objects in the children list
	 */
	public var enableBackFaceCulling(__getEnableBackFaceCulling,__setEnableBackFaceCulling):Bool;

	private function __getEnableBackFaceCulling( ):Bool
	{
		return false;
	}

	private function __setEnableBackFaceCulling( b:Bool ):Bool
	{
		for ( l_onode in children )
		{
			l_onode.enableBackFaceCulling = b;
		}
		return b;
	}
	
	/**
	 * Change the interactivity of all the children
	 */
	public var enableInteractivity(__getEnableInteractivity,__setEnableInteractivity):Bool;

	private function __getEnableInteractivity():Bool
	{ return false; }

	private function __setEnableInteractivity( p_bState:Bool ):Bool
	{
		for ( l_oNode in children )
		{
			l_oNode.enableInteractivity = p_bState;
		}
		return p_bState;
	}
	
	/**
	 * Enable event handling to all the children objects that can broadcast bubbling events
	 */
	public var enableEvents( __getEnableEvents, __setEnableEvents ):Bool;

	private function __getEnableEvents():Bool
	{
		return false;
	}

	private function __setEnableEvents( b:Bool ):Bool
	{
		for ( l_oNode in children )
		{
			l_oNode.enableEvents = b;
		}
		return b;
	}
	
	/**
	 * Set that appearance to all the children of that node
	 */
	public var appearance( __getAppearance, __setAppearance ):Appearance;

	private function __getAppearance():Appearance 
	{
		return null;
	}

	private function __setAppearance( p_oApp:Appearance ):Appearance
	{
		for ( l_oNode in children )
		{
			l_oNode.appearance = p_oApp;
		}
		return p_oApp;
	}
	
	/**
	 * @private
	 */
	private function __setParent( p_oNode:Node ):Node
	{
		if( p_oNode != null )
		{
			_parent = p_oNode;
			changed = true;
		}
		return p_oNode;
	}

	/**
	 * The parent node of this node.
	 *
	 * <p>The reference is null if this nod has no parent (for exemple for a root node).</p>
	 */
	public var parent( __getParent, __setParent ):Node;
	private function __getParent():Node
	{
		return _parent;
	}

	/**
	 * Tests if this node has a parent.
	 *
	 * @return 	true if this node has a parent, false otherwise.
	 */
	public function hasParent():Bool
	{
		return ( _parent != null );
	}

	/**
	 * Adds a new child to this node.
	 *
	 * <p>A node can have several children, and when you add a child to a node,
	 * it is automatically connected to the parent node through its parent property.</p>
	 *
	 * @param p_oChild	The child node to add
	 */
	public function addChild( p_oChild:Node ):Void
	{
		if( p_oChild.parent != null )
		{
			p_oChild.parent.removeChildByName( p_oChild.name );	
		}
		// --
		p_oChild.parent = this;
		changed =  true ;
		children.push( p_oChild );
		if( p_oChild.broadcaster != null ) m_oEB.addChild( p_oChild.broadcaster );
	}

	/**
	 * Returns the child node with the specified name.
	 *
	 * @param p_sName	The name of the child you want to retrieve
	 * @param p_bRecurs 	Set to true if you want to search the the children for the requested node
	 *
	 * @return		The requested node or null if no child with this name was found
	 */
	public function getChildByName( p_sName:String, ?p_bRecurs:Bool ):Node
	{
		var l_oNode:Node, l_oNode2:Node;

		p_bRecurs = (p_bRecurs)?p_bRecurs:false;

		for ( l_oNode in children )
		{
			if( l_oNode.name == p_sName )
			{
				return l_oNode;
			}
		}
		if( p_bRecurs )
		{
			var node:Node = null;
			for ( l_oNode in children )
			{
				node = l_oNode.getChildByName( p_sName, p_bRecurs );
				if( node != null )
				{
					 return node;
				}
			}
		}
		return null;
	}


	/**
	 * Moves this node to another parent node.
	 *
	 * <p>This node is removed from its current parent node, and added as a child of the specified node</p>
	 *
	 * @param p_oNewParent	The node to become parent of this node
	 */
	public function swapParent( p_oNewParent:Node ):Void
	{
		if( parent.removeChildByName( this.name ) )
			p_oNewParent.addChild( this );
	}

	/**
	 * Removes the child node with the specified name.
	 *
	 * <p>All children of the node you want to remove are lost.<br/>
	 * The link between them and the rest of the tree is broken, and they will not be rendered anymore!</p>
	 * <p>The object itself and its children are still in memory!<br/>
	 * If you want to free them completely, call child.destroy()</p>
	 *
	 * @param p_sName	The name of the node you want to remove.
	 * @return 		true if the node was removed from node tree, false otherwise.
	 */
	public function removeChildByName( p_sName:String ):Bool
	{
		var found:Bool = false;
		var i:Int = 0;
		var l:Int = children.length;
		while( i < l && !found )
		{
			if( children[i].name == p_sName  )
			{
				broadcaster.removeChild( children[i].broadcaster );
				children.splice( i, 1 );
				changed = true;
				found = true;
			}
			i++;
		}

		return found;
	}


	/**
	 * Delete this node and all its child nodes.
	 *
	 * <p>This node nad all its child nodes are deleted, including all data they are storing.<br/>
	 * The method makes recursive calls to the destroy method of the child nodes.
	 */
	public function destroy():Void
	{
		// the unlink this node to his parent
		if( hasParent() == true ) parent.removeChildByName( name );

		// should we kill all the childs, or just make them childs of current node parent ?
		//var l_aTmp:Array = children.concat();
		var l_aTmp:Array<Node> = children;
		for ( lNode in l_aTmp )
		{
			lNode.destroy();
		}
		children.splice(0,children.length);
		m_oEB = null;
	}

	/**
	 * Removes this node from the node tree, saving its child nodes.
	 *
	 * <p>NOTE that remove method only remove the current node and NOT its children!<br />
	 * To remove the current node and all its children please refer to the destroy method.</p>
	 * <p>The child nodes of this node becomes child nodes of this node's parent.</p>
	 */
	public function remove() :Void
	{
		// first we remove this node as a child of its parent
		// we do not update rigth now, but a little bit later ;)
		parent.removeChildByName( name );
		
		// now we make current node children the current parent's node children
		//var l_aTmp:Array = children.concat();
		var l_aTmp:Array<Node> = children;
		for ( lNode in l_aTmp )
		{
			parent.addChild( lNode );
		}
		children.splice(0,children.length);
		m_oEB = null;
		changed = true;
	}

	/**
	 * Updates this node.
	 *
	 * <p>For a node with transformation, this method update the transformation taking into account the matrix cache system.</p>
	 *
	 * @param p_oScene The current scene
	 * @param p_oModelMatrix
	 * @param p_bChanged
	 */
	public function update( p_oScene:Scene3D, p_oModelMatrix:Matrix4, p_bChanged:Bool ):Void
	{
		scene = p_oScene;
		// --
		if( boundingBox != null )
			boundingBox.uptodate = false;
		if( boundingSphere != null ) 
			boundingSphere.uptodate = false;
		
		/* Shall be overriden */
		changed = changed || p_bChanged;
		var l_oNode:Node;
		for ( l_oNode in children )
		{
			l_oNode.update( p_oScene, p_oModelMatrix, changed );
		}
	
	}


	/**
	 * Tests this node against the frustum volume to get its visibility.
	 *
	 * <p>If the node and its children aren't in the frustum, the node is set to cull
	 * and will not be displayed.<br/>
	 * <p>The method also updates the bounding volumes, to make a more accurate culling system possible.<br/>
	 * First the bounding sphere is updated, and if intersecting, the bounding box is updated to perform a more
	 * precise culling.</p>
	 * <p><b>[MANDATORY] The update method must be called first!</b></p>
	 *
	 * @param p_oScene	The current scene
	 * @param p_oFrustum	The frustum of the current camera
	 * @param p_oViewMatrix	<b>[ToDo: explain]</b>
	 * @param p_bChanged	<b>[ToDo: explain]</b>
	 *
	 */
	public function cull( p_oScene:Scene3D, p_oFrustum:Null<Frustum>, p_oViewMatrix:Matrix4, p_bChanged:Bool ):Void
	{
		if( visible == false )
		{
			culled = CullingState.OUTSIDE;
		}
		else
		{
			if( p_bChanged || changed )
			{
				viewMatrix.copy( p_oViewMatrix );
				viewMatrix.multiply4x3( modelMatrix );
			}
		}
	}
	
	/**
	 * Renders this node.
	 *
	 * <p>Overridden in sub classes</p>
	 *
	 * @param  p_oScene		The current scene
	 * @param  p_oCamera	The camera of the world
	 */
	public function render( p_oScene:Scene3D, p_oCamera:Camera3D ):Void
	{
		/* TO OVERRIDE */
	}

	/**
	 * Returns a string representation of this object
	 *
	 * @return	The fully qualified name of this class
	 */
	public function toString():String
	{
		return "sandy.core.scenegraph.Node";
	}

	////////////////////
	//// PRIVATE PART
	////////////////////
	private static var _ID_:Int = 0;
	private var _parent:Node;
	private var m_oEB:BubbleEventBroadcaster;
	/**
	 * This property set the cache status of the current node.
	 * IMPORTANT Currently this property isn't used!
	 */
	public var changed:Bool;
}

