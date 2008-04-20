/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author Thomas PFEIFFER
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

package sandy.core.sorters
{
	import sandy.core.data.Polygon;
	import sandy.core.data.Vertex;

	public class MeanDepthSorter implements IDepthSorter
	{
		public function MeanDepthSorter()
		{}
		
		public function getDepth( p_oPolygon:Polygon ):Number
		{
			if( p_oPolygon.c != null)
			{
				return 0.333*(p_oPolygon.a.wz + p_oPolygon.b.wz + p_oPolygon.c.wz);
			}
			else
			{
				return 0.5*(p_oPolygon.a.wz + p_oPolygon.b.wz);
			}
		}
		
	}
}