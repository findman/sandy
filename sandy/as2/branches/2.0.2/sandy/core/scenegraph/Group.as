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
import sandy.core.Scene3D;import sandy.core.data.Matrix4;import sandy.core.scenegraph.Node;import sandy.core.scenegraph.Shape3D;import sandy.core.scenegraph.TransformGroup;import sandy.view.CullingState;import sandy.view.Frustum;
/**
 * The Group class is used for branch nodes in the Sandy object tree.
 *
 * <p>This class is fianl, and can not be sub classed</p>
 * <p>This group binds together, but can not transform its children.<br/>
 * To transform collections of objects, you should add them to a transform group.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - xdevltd
 * @version		2.0.2
 * @date 		28.03.2006
 *
 * @see sandy.core.scenegraph.TransformGroup
 */
 
class sandy.core.scenegraph.Group extends Node
{
	
	/**
	 * Creates a branch group.
	 *
	 * @param p_sName	A string identifier for this object
	 */
	public function Group( p_sName:String )
	{		
		super( p_sName||"" );
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
	public function cull( p_oScene:Scene3D, p_oFrustum:Frustum, p_oViewMatrix:Matrix4, p_bChanged:Boolean ) : Void
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
		    var lChanged:Boolean = p_bChanged || changed;
			var l_oNode:Node;
			var i:Number = children.length;
       		for( i=0; l_oNode = children[i]; i++)
			{
		        l_oNode.cull( p_oScene, p_oFrustum, p_oViewMatrix, lChanged );
				l_oNode.changed = false;
			}
		}
	}
	
	
	public function clone( p_sName:String ) : Group
	{
		var l_oGroup:Group = new Group( p_sName );
		var l_oNode:Node;
		var i:Number = children.length;
       	for( i=0; l_oNode = children[i]; i++)
		{
			if( l_oNode instanceof Shape3D )
			{
				l_oGroup.addChild( Shape3D(l_oNode).clone( p_sName + "_" + l_oNode.name ) );
			} 
			else if( l_oNode instanceof Group )
			{
				l_oGroup.addChild( Group(l_oNode).clone( p_sName + "_" + l_oNode.name ) );
			} 
			else if( l_oNode instanceof TransformGroup )
			{
				l_oGroup.addChild( TransformGroup(l_oNode).clone( p_sName + "_" + l_oNode.name ) );
			} 
		}		
		return l_oGroup;
	}
	
	public function toString() : String
	{
		return "sandy.core.scenegraph.Group :[" + name + "]";
	}

}