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

package sandy.core.data;


/**
 * <p>The Edge3D represent a shape3D.
 * It stores information concerning related 2 Vertex.
 * A polygon is defined by some vertex, but also by some edges. Polygons are sharing edges between them.</p>
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 * 
 */
class Edge3D
{
	/**
	 * [READ-ONLY]
	 * First ID of the vertex which compose the EDGE. The ID correspond to the Geometry3D aVertex list
	 */
	public var vertexId1:Int;
	/**
	 * [READ-ONLY]
	 * Second ID of the vertex which compose the EDGE. The ID correspond to the Geometry3D aVertex list
	 */
	public var vertexId2:Int;

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
	public function new( p_nVertexId1:Int, p_nVertexId2:Int )
	{
		vertexId1 = p_nVertexId1;
		vertexId2 = p_nVertexId2;
	}
	
	public function clone():Edge3D
	{
		var l_oEdge:Edge3D = new Edge3D( vertexId1, vertexId2 );
		return l_oEdge;
	}
	
}

