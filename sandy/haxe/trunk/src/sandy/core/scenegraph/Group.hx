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

import sandy.core.Scene3D;
import sandy.core.data.Matrix4;
import sandy.view.CullingState;
import sandy.view.Frustum;

/**
 * The Group class is used for branch nodes in the Sandy object tree.
 *
 * <p>This class is fianl, and can not be sub classed</p>
 * <p>This group binds together, but can not transform its children.<br/>
 * To transform collections of objects, you should add them to a transform group.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 *
 * @see sandy.core.scenegraph.TransformGroup
 */
class Group extends Node
{
	/**
	 * The children of this node are stored inside this array.
	 * IMPORTANT: Use this property mainly as READ ONLY. To add, delete or search a specific child, you can use the specific method to do that
	 */
	public static var children:Array<Node> = new Array();

	/**
	 * Creates a branch group.
	 *
	 * @param p_sName	A string identifier for this object
	 */
	public function new( ?p_sName:String )
	{
		if (p_sName == null) p_sName = "";
		super( p_sName );
	}

	/**
	 * Tests this node against the camera frustum to get its visibility.
	 *
	 * <p>If this node and its children are not within the frustum,
	 * the node is culled and will not be displayed.<p/>
	 * <p>This method also updates the bounding volumes to make the more accurate culling system possible.<br/>
	 * First the bounding sphere is updated, and if intersecting,
	 * the bounding box is updated to perform the more precise culling.</p>
	 * <p><b>[MANDATORY] The update method must be called first!</b></p>
	 *
	 * @param p_oScene The current scene
	 * @param p_oFrustum	The frustum of the current camera
	 * @param p_oViewMatrix	The view martix of the curren camera
	 * @param p_bChanged
	 */
	public override function cull( p_oScene:Scene3D, p_oFrustum:Frustum, p_oViewMatrix:Matrix4, p_bChanged:Bool ):Void
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
		    var lChanged:Bool = p_bChanged || changed;
		    for ( l_oNode in children )
		        l_oNode.cull( p_oScene, p_oFrustum, p_oViewMatrix, lChanged );
		}
		// --
		//super.cull( p_oFrustum, p_oViewMatrix, p_bChanged );
	}
	
	/**
	 * Renders all children of this group.
	 *
	 * @param p_oScene The current scene
	 * @param p_oCamera	The current camera
	 */
	public override function render( p_oScene:Scene3D, p_oCamera:Camera3D ):Void
	{
		for ( l_oNode in children )
		{
		    if( l_oNode.culled != CullingState.OUTSIDE )
		    	l_oNode.render( p_oScene, p_oCamera );
		    // --
		    l_oNode.changed = false; // default value is set to not changed.
		    l_oNode.culled = CullingState.INSIDE; // Default value is inside.
		}
	}
	
	
	public function clone( p_sName:String ):Group
	{
		var l_oGroup:Group = new Group( p_sName );
		
		for ( l_oNode in children )
		{
			if( Std.is(l_oNode, Shape3D) || Std.is(l_oNode, Group) || Std.is(l_oNode, TransformGroup) )
			{
				l_oGroup.addChild( l_oNode.clone(  p_sName+"_"+l_oNode.name ) );
			} 
		}
		
		return l_oGroup;
	}
}

