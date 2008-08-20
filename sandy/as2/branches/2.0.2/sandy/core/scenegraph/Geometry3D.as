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

import com.bourre.data.collections.Map;

import sandy.core.data.Edge3D;
import sandy.core.data.UVCoord;
import sandy.core.data.Vector;
import sandy.core.data.Vertex;
	
	
/**
 * 	The Geometry3D class holds a complete description of the geometry of a Shape3D.
 *
 * 	It contains points, faces, normals and uv coordinates.
 * 	
 * 	NOTE: 	For best performance, Geometry should be created in offline mode,
 * 		especially all faces, as createFace() validates all points 
 * 		if these points exist in points array.
 * 
 * 	NOTE: 	This object is going to work well _ONLY_ if arrays 
 * 		wont be changed directlly [ie. push()] but _ONLY_ via accessor methods:
 * 		createFace, createFaceByIds, addFace, addFaces.
 * 		In the future we can make these Arrays PRIVATE but then the only 
 * 		way to make them safe is to deliver additionall accessors like 
 * 		getPoint(index:int), getFace(index:int) what could potentially slow 
 * 		affect performance of this structure (well, we need to test it, and 
 * 		if there is no problem, make arrays private and provide accessors for 
 * 		_SINGLE_ array's elements to make them safe ). 
 *
 * <p>[<b>ToDo</b>: Revise this and adopt tp ASDoc]</p>
 * 
 * @author	Mirek Mencel
 * @author	Thomas PFEIFFER
 * @author	(porting) Floris - FFlasher
 * @version	2.0.2
 * @date	07.04.2007
 */
class sandy.core.scenegraph.Geometry3D
{	

// ______
// PUBLIC________________________________________________________	
	
	private var EDGES_MAP:Map;
	
		
	/** Array of vertices */
	public var aVertex:Array = new Array();
	/** Array of faces composed from vertices */
	public var aFacesVertexID:Array = new Array();
	public var aFacesUVCoordsID:Array = new Array();
	/** Array ov normals */
	public var aFacesNormals:Array = new Array();
	public var aVertexNormals:Array = new Array();
	public var aEdges:Array = new Array();
	// Array of face edges
	public var aFaceEdges:Array = new Array();
	/** UV Coords for faces */
	public var aUVCoords:Array = new Array();
	private var m_nLastVertexId:Number = 0;
	private var m_nLastNormalId:Number = 0;
	private var m_nLastFaceId:Number = 0;
	private var m_nLastFaceUVId:Number = 0;
	private var m_nLastUVId:Number = 0;
	private var m_nLastVertexNormalId:Number = 0;
	private var m_aVertexFaces:Array = new Array();
// ___________
// CONSTRUCTOR___________________________________________________
	
	/**
	 * Creates a 3D geometry.
	 * 
	 * @param p_points	Not used in this version
	 */
	public function Geometry3D( p_points:Array )
	{
		EDGES_MAP = new Map();
		init();
	}
	/**
	* Not used in this version.
	*/
	public function init() : Void
	{
		;
	}
		
	/**
	 * Adds new point at the specified index of the vertex list.
	 * 
	 * @param p_nVertexID	Index at which to save the vertex
	 * @param p_nX		x coordinate of the vertex
	 * @param p_nY		y coordinate of the vertex
	 * @param p_nZ		z coordinate of the vertex
	 * @return 		The next free index or -1 it the index is already occupied		 
	 */
	public function setVertex( p_nVertexID:Number, p_nX:Number, p_nY:Number, p_nZ:Number ) : Number
	{
		if( aVertex[p_nVertexID] )
			return -1;
		else
		{ 
			aVertex[p_nVertexID] = new Vertex( p_nX, p_nY, p_nZ ); 
			return ++m_nLastVertexId - 1;  
		}
	}
	
	/**
	 * Returns the next unused vertex id.
	 *
	 * <p>this is the next free index in the verex list, and used by setVertex</p>
	 *
	 * @return 	The vertex id
	 */
	public function getNextVertexID() : Number
	{
		return m_nLastVertexId;
	}	

	/**
	 * Adds new normal at the specified index of the face normal list.
	 * 
	 * @param p_nNormalID	Index at which to save the normal
	 * @param p_nX		The x component of the normal
	 * @param p_nY		The y component of the normal
	 * @param p_nZ		The z component of the normal
	 * @return 		The next free index or -1 it the index is already occupied		 
	 */
	public function setFaceNormal( p_nNormalID:Number, p_nX:Number, p_nY:Number, p_nZ:Number ) : Number
	{
		if( aFacesNormals[p_nNormalID] )
			return -1;
		else
		{ 
			aFacesNormals[p_nNormalID] = new Vertex( p_nX, p_nY, p_nZ ); 
			return ++m_nLastNormalId - 1; 
		}
	}
	
	/**
	 * Returns the next unused normal id.
	 *
	 * <p>This is the next free index in the normal list, and used by setFaceNormal</p>
	 *
	 * @return 	The normal id
	 */
	public function getNextFaceNormalID() : Number
	{
		return m_nLastNormalId;
	}
			
	/**
	 * Add new point the specified index of the vertex normal list.
	 * 
	 * @param p_nNormalID	Index at which to save the vertex normal
	 * @param p_nX		x coordinate of the vertex normal
	 * @param p_nY		y coordinate of the vertex normal
	 * @param p_nZ		z coordinate of the vertex normal
	 * @return 		The next free index or -1 it the index is already occupied
	 */
	public function setVertexNormal( p_nNormalID:Number, p_nX:Number, p_nY:Number, p_nZ:Number ) : Number
	{
		if( aVertexNormals[p_nNormalID] )
			return -1;
		else
		{ 
			aVertexNormals[p_nNormalID] = new Vertex( p_nX, p_nY, p_nZ ); 
			return ++m_nLastVertexNormalId - 1;  
		}
	}
		
	/**
	 * Returns the next unused vertex normal id.
	 *
	 * <p>This is the next free index in the vertex normal list, and used by setVertexNormal</p>
	 *
	 * @return 	The vertex normal id
	 */
	public function getNextVertexNormalID() : Number
	{
		return m_nLastVertexNormalId;
	}
		
	/**
	 * Sets the ID's of the face vertices.
	 * 
	 * @param p_nFaceID	Id of the face
	 * @param...rest 	An array of data containing the ID's of the vertex list for the face
	 * @return 		The next free index or -1 it the index is already occupied
	 */
	public function setFaceVertexIds( p_nFaceID:Number /* Arguments */ ) : Number
	{
		if( aFacesVertexID[p_nFaceID] )
		{
			return -1;
		}
		else
		{
			var rest:Array = ( arguments[1] instanceof Array )? arguments[1]: arguments.splice(1);
			aFacesVertexID[p_nFaceID] = rest;
			var lId:Number;
			// Time to check if edges allready exist or if we shall create them
			for( lId = 0; lId < rest.length; lId++ )
			{
				var lId1:Number = rest[lId];
				var lId2:Number = rest[ ( lId+1 ) % rest.length ];
				var lEdgeID:Number;
				var lString:String;
				// --
				if( isEdgeExist( lId1, lId2 ) == false )
				{
					lEdgeID = aEdges.push( new Edge3D( lId1, lId2 ) ) - 1;
					// --
					if( lId1 < lId2 ) lString = lId1 + "_" + lId2;
					else lString = lId2 + "_" + lId1;
					// --
					EDGES_MAP.put( lString, lEdgeID );
				}
				else
				{
					if( lId1 < lId2 ) lString = lId1 + "_" + lId2;
					else lString = lId2 + "_" + lId1;
					lEdgeID = EDGES_MAP.get( lString );
				}
				
				if( null == aFaceEdges[p_nFaceID] ) aFaceEdges[p_nFaceID] = new Array();
					Array( aFaceEdges[p_nFaceID] ).push( lEdgeID );
			}
			
			return ++m_nLastFaceId - 1; 
		}
	}
		
	private function isEdgeExist( p_nVertexId1:Number, p_nVertexId2:Number ) : Boolean
	{
	var lString:String;
		// --
		if( p_nVertexId1 < p_nVertexId2 ) lString = p_nVertexId1 + "_" + p_nVertexId2;
		else lString = p_nVertexId2 + "_" + p_nVertexId1;
		// --
		if( EDGES_MAP.get( lString ) == null ) return false;
		else return true;
	}
	
	/**
	 * Returns the next unused face id.
	 *
	 * <p>This is the next free index in the faces list, and used by setFaceVertexIds</p>
	 *
	 * @return 	The index
	 */
	public function getNextFaceID() : Number
	{
		return m_nLastFaceId;
	}
		
	/**
	 * Set the ID's of face UV coordinates.
	 *
	 * @param p_nFaceID	The id of the face
	 * @param ...rest 	An array of data containing the ID's of the UV coords list for the face
	 * @return 		The next free index or -1 it the index is already occupied
	 */
	public function setFaceUVCoordsIds( p_nFaceID:Number /* Arguments */ ):Number
	{
		if( aFacesUVCoordsID[p_nFaceID] )
		{
			return -1;
		}
		else
		{
			var rest:Array = (arguments[1] instanceof Array)? arguments[1]: arguments.splice(1);
			aFacesUVCoordsID[p_nFaceID] = rest;
			return ++m_nLastFaceUVId - 1; 
		}
	}
			
	/**
	 * Returns the next unused face UV coordinates id.
	 *
	 * <p>This is the next free index in the UV coordinate id list, and used by setFaceUVCoords</p>
	 *
	 * @return 	The index
	 */
	public function getNextFaceUVCoordID() : Number
	{
		return m_nLastFaceUVId;
	}
		
	/**
	 * Returns the index of a specified point in the vertex list.
	 *
	 * @return 	The index
	 */
	public function getVertexId( p_point:Vertex ) : Number
	{
		var j:Number;
		for( j = 0; j < aVertex.length && !(aVertex[j] == p_point);	j++);
		
		return j == aVertex.length ? -1: j;
	}
		
	/**
	 * Adds UV coordinates for single face.
	 * 
	 * [<b>ToDo</b>: Explain this ]
	 * @param p_nID		The id of the face
	 * @param p_UValue	The u component of the UV coordinate
	 * @param p_nVValue	The v component of the UV coordinate
	 * @return 		The next free index or -1 it the index is already occupied
	 */
	public function setUVCoords( p_nID:Number, p_UValue:Number, p_nVValue:Number ) : Number
	{
		if ( aUVCoords[p_nID] )
		{
			return -1;
		}
		else
		{
			aUVCoords[p_nID] = new UVCoord( p_UValue, p_nVValue );
			return ++m_nLastUVId - 1; 
		}
	}
	
	/**
	 * Returns the next unused UV coordinates id.
	 * 
	 * <p>This is the next free index in the UV coordinates list, and used by setUVCoords</p>
	 *
	 * @return 	The index
	 */
	public function getNextUVCoordID() : Number
	{
		return m_nLastUVId;
	}
	
		
	public function generateFaceNormals() : Void
	{
		if( aFacesNormals.length > 0 )  return;
		else
		{
			var a:Array;
			for( a in aFacesVertexID )
			{
				// If face is linear, as Line3D, no face normal to process
				if( a.length < 3 ) continue;
				// --
				var lA:Vertex, lB:Vertex, lC:Vertex;
				lA = aVertex[a[0]];
				lB = aVertex[a[1]];
				lC = aVertex[a[2]];
				// --
				var lV:Vector = new Vector( lB.wx - lA.wx, lB.wy - lA.wy, lB.wz - lA.wz );
				var lW:Vector = new Vector( lB.wx - lC.wx, lB.wy - lC.wy, lB.wz - lC.wz );
				// we compute de cross product
				var lNormal:Vector = lV.cross( lW );
				// we normalize the resulting vector
				lNormal.normalize();
				// --
				setFaceNormal( getNextFaceNormalID(), lNormal.x, lNormal.y, lNormal.z );
			}
		}
	}

	public function generateVertexNormals() : Void
	{
		if( aVertexNormals.length > 0 ) return;
		else
		{
			var lId:Number;
			for( lId = 0; lId < aFacesVertexID.length; lId++ )
			{
				var l_aList:Array = aFacesVertexID[ lId ];
				// -- get the normal of that face
				var l_oNormal:Vertex = aFacesNormals[ lId ];
				// for some reason, no normal has been set up here. 
				if( l_oNormal == null )
					continue;
				// -- add it to the corresponding vertex normals
				if( null == aVertexNormals[l_aList[0]] )
				{
					m_nLastVertexNormalId++;
					aVertexNormals[l_aList[0]] = new Vertex();
				}
				Vertex( aVertexNormals[l_aList[0]] ).add( l_oNormal );
				
				if( null == aVertexNormals[l_aList[1]] )
				{
					m_nLastVertexNormalId++;
					aVertexNormals[l_aList[1]] = new Vertex();
				}
				Vertex( aVertexNormals[l_aList[1]] ).add( l_oNormal );
				
				if( null == aVertexNormals[l_aList[2]] )
				{
					m_nLastVertexNormalId++;
					aVertexNormals[l_aList[2]] = new Vertex();
				}
				Vertex( aVertexNormals[l_aList[2]] ).add( l_oNormal );
				
				// -- We update the number of faces these vertex belongs to
				if( Vertex( aVertex[l_aList[0]] ).aFaces.indexOf( lId ) == 0 )
					Vertex( aVertex[l_aList[0]] ).aFaces.push( lId );
				
				if( Vertex( aVertex[l_aList[1]] ).aFaces.indexOf( lId ) == 0 )
					Vertex( aVertex[l_aList[1]] ).aFaces.push( lId );
				
				if( Vertex( aVertex[l_aList[2]] ).aFaces.indexOf( lId ) == 0 )
					Vertex( aVertex[l_aList[2]] ).aFaces.push( lId );
					
				aVertex[l_aList[0]].nbFaces++;
				aVertex[l_aList[1]].nbFaces++;
				aVertex[l_aList[2]].nbFaces++;
			}
				
			for( lId = 0; lId < aVertexNormals.length; lId++ )
			{
				var l_oVertex:Vertex = aVertex[ lId ];
				if( l_oVertex.nbFaces ) Vertex( aVertexNormals[ lId ] ).scale( 1 / l_oVertex.nbFaces );
			}
		}
	}
				
	/**
	* Returns a clone of this Geometry3D.
	* 	
	* <p>NOTE: Because polygons also stores instance-specific data like Appearance
	* on the Geometry level, we are considering it only as a set of connections between points, 
	* so only coordinates and normals are copied in the clone process.
	* 
	* @return A copy of this geometry
	*/
	public function clone() : Geometry3D
	{
		var l_result:Geometry3D = new Geometry3D();
		var i:Number = 0, l_oVertex:Vertex;
		// Points
		for( l_oVertex in aVertex )
		{
			l_result.aVertex[i] = l_oVertex.clone();
			i++;
		}
		
		// Faces
		i = 0;
		var a:Array;
		for( a in aFacesVertexID )
		{
			l_result.aFacesVertexID[i] = a.concat();
			i++;
		}
		
		// Normals
		i = 0;
		for( l_oVertex in aFacesNormals )
		{
			l_result.aFacesNormals[i] = l_oVertex.clone();
			i++;
		}
		
		// Normals
		i = 0;
		for( l_oVertex in aVertexNormals )
		{
			l_result.aVertexNormals[i] = l_oVertex.clone();
			i++;
		}
		
		// UVs face
		i = 0;
		var b:Array;
		for( b in aFacesUVCoordsID )
		{
			l_result.aFacesUVCoordsID[i] = b.concat();
			i++;
		}
			
		// UVs coords
		i = 0;
		var u:UVCoord;
		for( u in aUVCoords )
		{
			l_result.aUVCoords[i] = u.clone();
			i++;
		}
		
		var l_oEdge:Edge3D;
		for( l_oEdge in aEdges )
		{
			l_result.aEdges[i] = l_oEdge.clone();
			i++;
		}
			
		i = 0;
		var l_oEdges:Array;
		for( l_oEdges in aFaceEdges )
		{
			l_result.aFaceEdges[i] = l_oEdges.concat();
			i++;
		}
		
		return l_result;
	}
	
		
	/**
	 * Dispose all the geometry ressources.
	 * Arrays data is removed, arrays are set to null value to make garbage collection possible
	 */
	public function dispose() : Void
	{
		var a:Array, l_oVertex:Vertex;
		// Points
		for( l_oVertex in aVertex )
		{
			l_oVertex = null;
		}
		aVertex = null;
		// Faces
		for( a in aFacesVertexID )
		{
			a = null;
		}
		aFacesVertexID = null;
		// Normals
		for( l_oVertex in aFacesNormals )
		{
			l_oVertex = null;
		}
		aFacesNormals = null;
		// Normals
		for( l_oVertex in aVertexNormals )
		{
			l_oVertex = null;
		}
		aVertexNormals = null;
		// UVs face
		var b:Array;
		for( b in aFacesUVCoordsID )
		{
			b = null;
		}
		aFacesUVCoordsID = null;
		// UVs coords
		var u:UVCoord;
		for( u in aUVCoords )
		{
			u = null;
		}	
		aUVCoords = null;		
	}
	
	/**
	 * Returns a string representation of this geometry.
	 *
	 * <p>The string contins the lengths of the arrays of data defining this geometry.</p>
	 * <p>[<b>ToDo</b>: Decide if this is the best representation ]</p>
	 *
	 * @return The string representation
	 */
	public function toString():String
	{
		return "[Geometry: " + 	aFacesVertexID.length + " faces, " + 
				aVertex.length + " points, " + 
				aFacesNormals.length + " normals, " +
				aUVCoords.length + " uv coords]";
	}
		
	/*public function debug() : Void
	{
		trace( "Faces: [" + faces.length + "] " + faces );
		trace( "Points: [" + points.length + "] " + points );
		trace( "Unique directions: [" + uniqueDirections.length + "] " + uniqueDirections );
		trace( "Normals: [" + normals.length + "] " + normals );
		trace( "UVs: [" + uv.length + "] " + uv );
	}*/
	
}

