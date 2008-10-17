/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author or authors.
Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 ( the "License" );
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

import sandy.core.Scene3D;
import sandy.core.data.Matrix4;
import sandy.core.scenegraph.ATransformable;
import sandy.core.scenegraph.Camera3D;
import sandy.core.scenegraph.Group;
import sandy.core.scenegraph.Node;
import sandy.core.scenegraph.Shape3D;
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
 * @author		(porting) Floris - xdevltd
 * @version		2.0.2
 * @date 		16.05.2006
 */
 
class sandy.core.scenegraph.TransformGroup extends ATransformable
{
	
	/**
	 * Creates a transform group.
	 *
	 * @param  p_sName	A string identifier for this object
	 */
	public function TransformGroup( p_sName:String )
	{
		super( p_sName );
	}
	
	/**
	 * Tests this node against the camera frustum to get its visibility.
	 *
	 * <p>If this node and its children are not within the frustum,
	 * the node is set to cull and it would not be displayed.<p/>
	 * <p>The method also updates the bounding volumes to make the more accurate culling system possible.<br/>
	 * First the bounding sphere is updated, and if intersecting,
	 * the bounding box is updated to perform the more precise culling.</p>
	 * <p><b>[ MANDATORY ] The update method must be called first!</b></p>
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
		    for( l_oNode in children )
		    {
		        children[ l_oNode ].cull( p_oScene, p_oFrustum, p_oViewMatrix, lChanged );
				children[ l_oNode ].changed = false;
		    }
		}
	}
	
	public function clone( p_sName:String ) : TransformGroup
	{
		var l_oGroup:TransformGroup = new TransformGroup( p_sName );
		var l_oNode:Node;
		for( l_oNode in children )
		{
			if( children[ l_oNode ] instanceof Shape3D || children[ l_oNode ] instanceof Group || children[ l_oNode ] instanceof TransformGroup )
			{
				l_oGroup.addChild( children[ l_oNode ].clone( p_sName + "_" + children[ l_oNode ].name ) );
			} 
		}
		
		return l_oGroup;
	}
		
	/**
	 * Returns a string representation of the TransformGroup.
	 *
	 * @return	The fully qualified name.
	 */
	public function toString() : String
	{
		return "sandy.core.scenegraph.TransformGroup :[ " + name + " ]";
	}
	
}

