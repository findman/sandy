/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author Thomas Pfeiffer
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

import sandy.core.data.Vector;
import sandy.core.data.Vertex;
import sandy.core.data.UVCoord;

/**
 * @author  	Thomas Pfeiffer - kiroukou
 * @author		Floris - xdevltd
 * @version		2.0.2
 */
	
class sandy.core.data.Pool 
{
	
	private var m_nSize:Number = 300;
	private var m_aVertices:Array = new Array();
	private var m_nIdVertice:Number = 0;
	
	private var m_aUV:Array = new Array();
	private var m_nIdUV:Number = 0;
		
	private var m_aVectors:Array = new Array();
	private var m_nIdVector:Number = 0;
		
	private static var INSTANCE:Pool;

	public static function getInstance() : Pool
	{
		if( INSTANCE == null ) INSTANCE = new Pool();
		return INSTANCE;
	}

	public function Pool() 
	{
		for( var i:Number = 0; i < m_nSize; i++ )
		{
			m_aVertices[ int( i ) ] = new Vertex();
			m_aUV[ int( i ) ] = new UVCoord();
			m_aVectors[ int( i ) ] = new Vector();
		}
	}
		
	public function init() : Void
	{
		m_nIdVertice = m_nIdUV = m_nIdVector = 0;
	}
		
	public function get nextVertex() : Vertex
	{
		if( m_nIdVertice >= m_aVertices.length )
			m_aVertices[ m_aVertices.length ] = new Vertex();
		// --
		var l_oV:Vertex = m_aVertices[ int( m_nIdVertice++ ) ];
		l_oV.projected = false;
		l_oV.transformed = false;
		return l_oV;
	}
		
	public function get nextUV() : UVCoord
	{ 
		if( m_nIdUV >= m_aUV.length )
			m_aUV[ m_aUV.length ] = new UVCoord();
		// --
		return m_aUV[ int( m_nIdUV++ ) ];
	}
		
	public function get nextVector():Vector
	{
		if( m_nIdVector >= m_aVectors.length )
			m_aVectors[ m_aVectors.length ] = new Vector();
		// --
		return m_aVectors[ int( m_nIdVector++ ) ];
	}
	
}