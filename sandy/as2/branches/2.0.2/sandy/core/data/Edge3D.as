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

import sandy.core.data.Vertex;

class sandy.core.data.Edge3D
{
	
/**
 * <p>The Edge3D represent a shape3D.
 * It stores information concerning related 2 Vertex.
 * A polygon is defined by some vertex, but also by some edges. Polygons are sharing edges between them.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @since		1.0
 * @version		3.0
 * @date 		24.08.2007
 */

 
	/**
	 * [READ-ONLY]
	 * First ID of the vertex which compose the EDGE. The ID correspond to the Geometry3D aVertex list
	 */
	public var vertexId1:Number;
	/**
	 * [READ-ONLY]
	 * Second ID of the vertex which compose the EDGE. The ID correspond to the Geometry3D aVertex list
	 */
	public var vertexId2:Number;

	/**
	 * [READ-ONLY]
	 * First vertex which compose the EDGE. The ID correspond to the Geometry3D aVertex list
	 */
	public var vertex1:Vertex;
		
	/**
	 * [READ-ONLY]
	 * Second vertex which compose the EDGE. The ID correspond to the Geometry3D aVertex list
	 */
	public var vertex2:Vertex;
	
	/**
	 * Creates an Edge3D from two vertices.
	 *
	 */
	public function Edge3D( p_nVertexId1:Number, p_nVertexId2:Number )
	{
		vertexId1 = Math.round( p_nVertexId1 );
		vertexId2 = Math.round( p_nVertexId2 );
	}
	
	public function clone():Edge3D
	{
		var l_oEdge:Edge3D = new Edge3D( vertexId1, vertexId2 );
		return l_oEdge;
	}
	
}
