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

import com.bourre.events.EventBroadcaster;

/**
 * ABSTRACT CLASS
 * <p>
 * This class is the basis of all the group and Leaf one.
 * It allows all the basic operations you might want to do about trees node.
 * </p>
 * @author		Thomas Pfeiffer - kiroukou
 * @version		1.0
 * @date 		16.05.2006
 **/
class sandy.core.group.Node extends EventBroadcaster
{
	/**
	 * Adds passed-in {@code oL} listener for receiving passed-in {@code t} event type.
	 * 
	 * <p>Take a look at example below to see all possible method call.
	 * 
	 * <p>Example
	 * <code>
	 *   var oEB : IEventDispatcher = new EventBroadcaster(this);
	 *   oEB.addEventListener( myClass.onSometingEVENT, myFirstObject);
	 *   oEB.addEventListener( myClass.onSometingElseEVENT, this, __onSomethingElse);
	 *   oEB.addEventListener( myClass.onSometingElseEVENT, this, Delegate.create(this, __onSomething) );
	 * </code>
	 * 
	 * @param t Name of the Event.
	 * @param oL Listener object.
	 */
	 /*
	public function addEventListener(t:String, oL) : Void
	{
		_oEB.addEventListener.apply( _oEB, arguments );
	}
	*/
	/**
	 * Removes passed-in {@code oL} listener that suscribed for passed-in {@code t} event.
	 * 
	 * <p>Example
	 * <code>
	 *   var oEB : IEventDispatcher = new EventBroadcaster(this);
	 *   oEB.removeEventListener( myClass.onSometingEVENT, myFirstObject);
	 *   oEB.removeEventListener( myClass.onSometingElseEVENT, this);
	 * </code>
	 * 
	 * @param t Name of the Event.
	 * @param oL Listener object.
	 */
	 /*
	public function removeEventListener(t:String, oL) : Void
	{
		_oEB.removeEventListener( t, oL );
	}
	*/

	/**
	 * Wrapper for Macromedia {@code EventDispatcher} polymorphism.
	 * 
	 * <p>Example
	 * <code>
	 *   var oEB : IEventDispatcher = new EventBroadcaster(this);
	 *   oEB.dispatchEvent( {type:'onSomething', target:this, param:12} );
	 * </code>
	 * 
	 * @param o Event object.
	 */
	 /*
	public function dispatchEvent(o:Object) : Void
	{
		_oEB.dispatchEvent.apply( _oEB, arguments );
	}
	*/
	/**
	 * Broadcasts event to suscribed listeners.
	 * 
	 * <p>Example using full Pixlib API
	 * <code>
	 *   var oEB : IEventDispatcher = new EventBroadcaster(this);
	 *   var e : IEvent = new BasicEvent( myClass.onSomeThing, this);
	 *   
	 *   oEB.addEventListener( myClass.onSomeThing, this);
	 *   oEB.broadcastEvent( e );
	 * </code>
	 * 
	 * @param e an {@link IEvent} instance
	 */
	 /*
	public function broadcastEvent(e:IEvent) : Void
	{
		_oEB.broadcastEvent.apply( _oEB, arguments );
	}
	*/	
	
	/**
	* Retuns the unique ID Number that represents the node.
	* This value is very usefull to retrieve a specific Node.
	* This method is FINAL, IT MUST NOT BE OVERLOADED.
	* @param	Void
	* @return	Number the node ID.
	*/
	public function getId( Void ):Number
	{
		return _id;
	}
		
	/**
	* Say is the node is the parent of the current node.
	* @param	n The Node you are going to test the patternity
	* @return Boolean  True is the node in argument if the father of the current one, false otherwise.
	*/
	public function isParent( n:Node ):Boolean
	{
		return (_parent == n && n != undefined);
	}
	
	/**
	* Allows you to know if this node has been modified (true value) or not (false value). 
	* Mainly usefull for the cache system.
	* @return	Boolean Value specifying the statut of the node. A true value means the node has been modified, it it should be rendered again
	*/
	public function isModified( Void ):Boolean
	{
		return _modified
	}

	/**
	* Allows you to set the modified property of the node.
	* @param b Boolean true means the node is modified, and false the opposite.
	*/
	public function setModified( b:Boolean ):Void
	{
		_modified = b;
	}
	
	/**
	* Set the parent of a node
	* @param	Void
	* @return	Boolean false is nothing has been done, true if the operation succeded
	*/
	public function setParent( n:Node ):Boolean
	{
		if( undefined == n )
		{
			return false;
		}
		else
		{
			_parent = n;
			setModified( true );
			return true;
		}
	}
	
	/**
	* Returns the parent node reference
	* @param	Void
	* @return Node The parent node reference, which is null if no parents (for exemple for a root object).
	*/
	public function getParent( Void ):Node
	{
		return _parent;
	}
	
	/**
	* Allows the user to know if the current node have a parent or not.
	* @param	Void
	* @return Boolean. True is the node has a parent, False otherwise
	*/
	public function hasParent( Void ):Boolean
	{
		return (undefined != _parent);
	}	
	
	/**
	* Add a new child to this group. a basicGroup can have several childs, and when you add a child to a group, 
	* the child is automatically conencted to it's parent thanks to its parent property.
	* @param	child
	*/
	public function addChild( child:Node ): Void 
	{
		child.setParent( this );
		setModified( true );
		_aChilds.push( child );
	}	
	
	/**
	 * Returns all the childs of the current group in an array
	 * @param Void
	 * @return Array The array containing all the childs node of this group
	 */
	public function getChildList ( Void ):Array
	{
		return _aChilds;
	}
	
	/**
	* Returns the child node at the specific index.
	* @param	index Number The ID of the child you want to get
	* @return 	Node The desired Node
	*/
	public function getChild( index:Number ):Node 
	{
		return _aChilds[ index ];
	}

	/**
	* Remove the child given in arguments. Returns true if the node has been removed, and false otherwise.
	* All the children of the node you want to remove are lost. The link between them and the rest of the tree is broken.
	* They will not be rendered anymore!
	* But the object itself and his children are still in memory! If you want to free them completely, use child.destroy();
	* @param	child Node The node you want to remove.
	* @return Boolean True if the node has been removed from the list, false otherwise.
	*/
	public function removeChild( child:Node ):Boolean 
	{
		// --
		if( !child.isParent( this ) ) return false;
		var found:Boolean = false;
		// --
		for( var i:Number = 0; i < _aChilds.length && !found; i++ )
		{
			if( _aChilds[i] == child )
			{
				_aChilds.splice( i, 1 );
				setModified( true );
				found = true;
			}
		}
		return found;
	}

	/**
	 * Delete all the childs of this node, and also the datas it is actually storing.
	 * Do a recurssive call to child's destroy method.
	 */
	public function destroy() : Void 
	{
		// the unlink this node to his parent
		if( hasParent() ) _parent.removeChild( this );
		// should we kill all the childs, or just make them childs of current node parent ?
		var l:Number = _aChilds.length;
		while( --l > -1 )
		{
			_aChilds[l].destroy();
			delete _aChilds[l];	
		}
		delete _aChilds;
		_parent = null;
	}

	/**
	 * Remove the current node on the tree.
	 * It makes current node children the children of the current parent node.
	 * The interest of this paramater is that it allows you to update the World3D only once during your destroy/remove call!
	 */
	public function remove() : Void 
	{
		//
		var l:Number = _aChilds.length;
		// first we remove this node as a child of its parent
		// we do not update rigth now, but a little bit later ;)
		_parent.removeChild( this, false );
		// now we make current node children the current parent's node children
		while( --l > -1 )
		{
			_parent.addChild( _aChilds[l], false );
		}
		delete _aChilds;
		_parent = null;
		setModified( true );
	}
	
	////////////////////
	//// PRIVATE PART
	////////////////////
	private function Node() 
	{
		super( this );
		_parent = null;
		_aChilds = [];
		_id = Node._ID_++;
		setModified( true );
		// -- 
	}
	
	private static var _ID_:Number = 0;
	private var _aChilds:Array;
	private var _id:Number;
	private var _parent:Node;
	private var _modified:Boolean;
}
