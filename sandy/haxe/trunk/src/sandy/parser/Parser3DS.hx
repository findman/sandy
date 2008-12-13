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

package sandy.parser;

import flash.events.Event;
#if !js
import flash.events.EventDispatcher;
import flash.events.EventPhase;
import flash.events.FocusEvent;
import flash.events.FullScreenEvent;
import flash.events.HTTPStatusEvent;
import flash.events.IEventDispatcher;
import flash.events.IMEEvent;
import flash.events.IOErrorEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.NetFilterEvent;
import flash.events.NetStatusEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.events.ShaderEvent;
import flash.events.StatusEvent;
import flash.events.SyncEvent;
import flash.events.TextEvent;
import flash.events.TimerEvent;
import flash.events.WeakFunctionClosure;
import flash.events.WeakMethodClosure;
#end
import flash.net.URLLoaderDataFormat;
import flash.utils.ByteArray;
import flash.utils.Endian;

import sandy.core.data.Matrix4;
import sandy.core.data.Quaternion;
import sandy.core.data.Vector;
import sandy.core.scenegraph.Geometry3D;
import sandy.core.scenegraph.Shape3D;
import sandy.materials.Appearance;
import sandy.materials.ColorMaterial;
import sandy.math.ColorMath;

/**
 * Transforms a 3DS file into Sandy geometries.
 * <p>Creates a Group as rootnode which appends all geometries it finds.
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * @example To parse a 3DS file at runtime:
 *
 * <listing version="3.0">
 *     var parser:IParser = Parser.create( "/path/to/my/3dsfile.3ds", Parser.3DS );
 * </listing>
 *
 */

class Parser3DS extends AParser, implements IParser
{
	private var _rot_m:Array<Matrix4>;
	private var currentObjectName:String;
	private var data:ByteArray;
	/* private var _animation:Hash<Keyframer>; */
	private var startFrame:Int;
	private var endFrame:Int;
	private var lastRotation:Quaternion;

	/**
	 * Creates a new Parser3DS instance.
	 *
	 * @param p_sUrl		A String pointing to the location of the 3DS file
	 * @param p_nScale		The scale factor
	 */
	public function new<URL>( p_sUrl:URL, p_nScale:Float )
	{
		super( p_sUrl, p_nScale );
		m_sDataFormat = URLLoaderDataFormat.BINARY;
	}

	/**
	 * Starts the parsing process
	 * @param e				The Event object
	 */
   private override function parseData( ?e:Event ):Void
	{
		super.parseData( e );
		// --
		if (m_oFileLoader != null)
			data = m_oFileLoader.data;
		else
			data = cast m_oFile;
		data.endian = Endian.LITTLE_ENDIAN;
		// --
		var currentObjectName:String = null;
		var _rot_m:Array<Matrix4> = new Array();
		/* var ad:Array = new Array(); */
		var pi180:Float = 180 / Math.PI;
		// --
		var l_oAppearance:Appearance = m_oStandardAppearance;
		var l_oGeometry:Geometry3D = null;
		var l_oShape:Shape3D = null;
		var l_oMatrix:Matrix4 = null;
		// --
		var x:Float, y:Float, z:Float;
		var l_qty:Int;
		// --
		while( data.bytesAvailable > 0 )
		{
			var id:Int = data.readUnsignedShort();
			var l_chunk_length:Int = data.readUnsignedInt();

			switch( id )
			{
				case Parser3DSChunkTypes.MAIN3DS:

			    case Parser3DSChunkTypes.EDIT3DS:

			   	case Parser3DSChunkTypes.KEYF3DS:

			    case Parser3DSChunkTypes.EDIT_OBJECT:

			    	if( l_oGeometry != null )
					{
				        l_oShape = new Shape3D( currentObjectName, l_oGeometry, l_oAppearance );
				        if( l_oMatrix != null ) _applyMatrixToShape( l_oShape, l_oMatrix );
						m_oGroup.addChild( l_oShape );
				    }
				    // --
				    var str:String = readString();
				    currentObjectName = str;
				    l_oGeometry = new Geometry3D();

				case Parser3DSChunkTypes.OBJ_TRIMESH:

         		 case Parser3DSChunkTypes.TRI_VERTEXL:        //vertices

		            l_qty = data.readUnsignedShort();
		            for (i in 0...l_qty)
		            {
		            	x = data.readFloat();
		            	z = data.readFloat();
		            	y = data.readFloat();
		            	l_oGeometry.setVertex( i, x*m_nScale, y*m_nScale, z*m_nScale );
		            }

		         case Parser3DSChunkTypes.TRI_TEXCOORD:		// texture coords

			      //  trace("0x4140  texture coords");
		            l_qty = data.readUnsignedShort();
		            for (i in 0...l_qty)
		            {
		            	var u:Float = data.readFloat();
		            	var v:Float = data.readFloat();
		            	l_oGeometry.setUVCoords( i, u, 1-v );
		            }

		         case Parser3DSChunkTypes.TRI_FACEL1:		// faces

					//trace("0x4120  faces");
		            l_qty = data.readUnsignedShort();
		            for (i in  0...l_qty)
		            {
		            	var vertex_a:Int = data.readUnsignedShort();
		            	var vertex_b:Int = data.readUnsignedShort();
		            	var vertex_c:Int = data.readUnsignedShort();

		            	var faceId:Int = data.readUnsignedShort(); // TODO what is that? value is 3 or 6 ?....
		            	l_oGeometry.setFaceVertexIds(i, [vertex_a, vertex_b, vertex_c] );
		            	l_oGeometry.setFaceUVCoordsIds(i, [vertex_a, vertex_b, vertex_c] );
		            }

		         case Parser3DSChunkTypes.TRI_LOCAL:		//ParseLocalCoordinateSystem
		         	//trace("0x4160 TRI_LOCAL");

		         	var localX:Vector = readVector();
		         	var localZ:Vector = readVector();
		         	var localY:Vector = readVector();
		         	var origin:Vector = readVector();


		         	l_oMatrix = new Matrix4(	localX.x, localX.y, localX.z, origin.x,
		         								localY.x, localY.y, localY.z, origin.y,
		         								localZ.x, localZ.y, localZ.z, origin.z,
								         		0,0,0,1 );

		         case Parser3DSChunkTypes.OBJ_LIGHT:		//Lights

		         case Parser3DSChunkTypes.LIT_SPOT:			//Light Spot

		         case Parser3DSChunkTypes.COL_TRU:			//RGB color

		         case Parser3DSChunkTypes.COL_RGB:			//RGB color

		         case Parser3DSChunkTypes.OBJ_CAMERA:		//Cameras

		         // animation
		         case Parser3DSChunkTypes.KEYF_FRAMES:

		         case Parser3DSChunkTypes.KEYF_OBJDES:

		         case Parser3DSChunkTypes.NODE_ID:

		         case Parser3DSChunkTypes.NODE_HDR:

		         case Parser3DSChunkTypes.PIVOT:

		         case Parser3DSChunkTypes.POS_TRACK_TAG:

		         case Parser3DSChunkTypes.ROT_TRACK_TAG:

		         case Parser3DSChunkTypes.SCL_TRACK_TAG:
		            
		         default:
		            data.position += l_chunk_length-6;
		 	}
		}
		// --
		l_oShape = new Shape3D( currentObjectName, l_oGeometry, l_oAppearance);
		// FIXME: the following line needs commenting in haXe and works... CHECK
		//if( l_oMatrix != null ) _applyMatrixToShape( l_oShape, l_oMatrix );
		m_oGroup.addChild( l_oShape );
		// -- Parsing is finished
		var l_eOnInit:ParserEvent = new ParserEvent( ParserEvent.INIT );
		l_eOnInit.group = m_oGroup;
		dispatchEvent( l_eOnInit );
	}

	private function _applyMatrixToShape( p_oShape:Shape3D, p_oMatrix:Matrix4 ):Void
	{
		p_oShape.matrix = p_oMatrix;
	}

	/**
	 * Reads a vector from a ByteArray
	 *
	 * @return	A vector containing the x, y, z values
	 */
	private function readVector():Vector
	{
		var x:Float = data.readFloat();
		var y:Float = data.readFloat();
		var z:Float = data.readFloat();
		return new Vector(x, z, y);
	}

	/**
	 * Reads a byte from a ByteArray
	 *
	 * @return 	A byte
	 */
	private function readByte():Int
	{
		return data.readByte();
	}

	/**
	 * Reads a character (unsigned byte) from a ByteArray
	 *
	 * @return A character
	 */
	private function readChar():Int
	{
		return data.readUnsignedByte();
	}

	/**
	 * Reads an integer from a ByteArray
	 *
	 * @return	An integer
	 */
	private function readInt():Int
	{
			var temp:Int = readChar();
			return ( temp | (readChar() << 8));
	}

	/**
	 * Reads a string from a ByteArray
	 *
	 * @return 	A String
	 */
	private function readString():String
	{
			var name:String = "";
			var ch:Int;
			while((ch = readChar()) != 0)
			{
				if (ch == 0)
				{
					break;
				}
				name += String.fromCharCode(ch);
			}
			return name;
	}
}

