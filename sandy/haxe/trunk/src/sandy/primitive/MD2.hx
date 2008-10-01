package sandy.primitive;

import flash.utils.ByteArray;
import flash.utils.Endian;

import sandy.core.scenegraph.Geometry3D;
import sandy.core.scenegraph.Shape3D;
import sandy.primitive.Primitive3D;
import sandy.core.data.Vector;
import sandy.core.data.Vertex;
import sandy.core.data.UVCoord;

/**
* MD2 primitive.
* 
* @author Philippe Ajoux (philippe.ajoux@gmail.com)
*/
class MD2 extends Shape3D, implements Primitive3D
{
	/**
	* Creates MD2 primitive.
	*
	* @param p_sName Shape instance name.
	* @param data MD2 binary data.
	* @param scale Adjusts model scale.
	*/
	public function new ( p_sName:String, data:ByteArray, scale:Int = 1 )
	{
	 frames = new Hash();

	 vertices = [];
	 v = new Vector ();
		w = new Vector ();

		super (p_sName); scaling = scale; geometry = generate ([data]); frame = 0;
		//animated = true;
	}

	/**
	* Generates the geometry for MD2. Sandy never actually calls this method,
	* but we still implement it according to Primitive3D, just in case :)
	*
	* @return The geometry object.
	*/
	public function generate (?arguments:Array<Dynamic>):Geometry3D
	{
		var i:Int, j:Int, char:Int;
		var uvs:Array<UVCoord> = [];
		var mesh:Geometry3D = new Geometry3D ();

		// okay, let's read out header 1st
		var data:ByteArray = arguments[0];
		data.endian = Endian.LITTLE_ENDIAN;

		ident = data.readInt();
		version = data.readInt();

		if (ident != 844121161 || version != 8)
			throw "Error loading MD2 file: Not a valid MD2 file/bad version";

		skinwidth = data.readInt();
		skinheight = data.readInt();
		framesize = data.readInt();
		num_skins = data.readInt();
		num_vertices = data.readInt();
		num_st = data.readInt();
		num_tris = data.readInt();
		num_glcmds = data.readInt();
		num_frames = data.readInt();
		offset_skins = data.readInt();
		offset_st = data.readInt();
		offset_tris = data.readInt();
		offset_frames = data.readInt();
		offset_glcmds = data.readInt();
		offset_end = data.readInt();

		// texture name
		data.position = offset_skins;
		texture = "";
		for (i in 0...64)
		{
			char = data.readUnsignedByte ();
			if (char == 0) break; else texture += String.fromCharCode (char);
		}

		// UV coordinates
		data.position = offset_st;
		for (i in 0...num_st)
			uvs.push (new UVCoord (data.readShort() / skinwidth, data.readShort() / skinheight ));

		// Faces
		data.position = offset_tris;
		var j = 0;
		for (i in 0...num_tris)
		{
			var a:Int = data.readUnsignedShort();
			var b:Int = data.readUnsignedShort();
			var c:Int = data.readUnsignedShort();
			var ta:Int = data.readUnsignedShort();
			var tb:Int = data.readUnsignedShort();
			var tc:Int = data.readUnsignedShort();

			// create placeholder vertices (actual coordinates are set later)
			mesh.setVertex (a, 1, 0, 0);
			mesh.setVertex (b, 0, 1, 0);
			mesh.setVertex (c, 0, 0, 1);

			mesh.setUVCoords (j, uvs [ta].u, uvs [ta].v);
			mesh.setUVCoords (j + 1, uvs [tb].u, uvs [tb].v);
			mesh.setUVCoords (j + 2, uvs [tc].u, uvs [tc].v);

			mesh.setFaceVertexIds (i, [a, b, c]);
			mesh.setFaceUVCoordsIds (i, [j, j + 1, j + 2]);
			j+=3;
		}

		// Frame animation data
		for (i in 0...num_frames)
		{
			var sx:Float = data.readFloat();
			var sy:Float = data.readFloat();
			var sz:Float = data.readFloat();
			
			var tx:Float = data.readFloat();
			var ty:Float = data.readFloat();
			var tz:Float = data.readFloat();

			// store frame names as pointers to frame numbers
			var name:String = "", wasNotZero:Bool = true;
			for (j in 0...16)
			{
				char = data.readUnsignedByte ();
				wasNotZero = wasNotZero && (char != 0);
				if (wasNotZero)
					name += String.fromCharCode (char);
			}
			frames.set(name, i);

			// store vertices for every frame
			var vi:Array<Vector> = [];
			vertices [i] = vi;
			for (j in 0...num_vertices)
			{
				var vec:Vector = new Vector ();

				// order of assignment is important here because of data reads...
				vec.x = ((sx * data.readUnsignedByte()) + tx) * scaling;
				vec.z = ((sy * data.readUnsignedByte()) + ty) * scaling;
				vec.y = ((sz * data.readUnsignedByte()) + tz) * scaling;

				vi [j] = vec;

				// ignore "vertex normal index"
				data.readUnsignedByte ();
			}
		}

		return mesh;
	}

	/**
	* Frames map. This maps frame names to frame numbers.
	*/
	public var frames:Hash<Int>;

	/**
	* Frame number. You can tween this value to play MD2 animation.
	*/
	public var frame (__getFrame,__setFrame):Int;
	private function __getFrame ():Int { return t; }

	/**
	* @private (setter)
	*/
	private function __setFrame (value:Int):Int
	{
		t = value;

		// interpolation frames
		var f1:Array<Vector> = vertices [t % num_frames];
		var f2:Array<Vector> = vertices [(t + 1) % num_frames];

		// interpolation coef-s
		var c2:Int = t - t, c1:Int = 1 - c2;

		// loop through vertices
		for (i in 0...num_vertices)
		{
			var v0:Vertex = geometry.aVertex [i];
			var v1:Vector = f1 [i];
			var v2:Vector = f2 [i];

			// interpolate
			v0.x = v1.x * c1 + v2.x * c2; v0.wx = v0.x;
			v0.y = v1.y * c1 + v2.y * c2; v0.wy = v0.y;
			v0.z = v1.z * c1 + v2.z * c2; v0.wz = v0.z;
		}

		// update face normals
		for (l_oPoly in aPolygons)
		{
			v.x = l_oPoly.b.x - l_oPoly.a.x; v.y = l_oPoly.b.y - l_oPoly.a.y; v.z = l_oPoly.b.z - l_oPoly.a.z;
			w.x = l_oPoly.b.x - l_oPoly.c.x; w.y = l_oPoly.b.y - l_oPoly.c.y; w.z = l_oPoly.b.z - l_oPoly.c.z;
			// FIXME: remove untyped 
			untyped( w.crossWith (v) ); w.normalize ();
			l_oPoly.normal.x = w.x; l_oPoly.normal.y = w.y; l_oPoly.normal.z = w.z;
		}
		return value;
	}

	/**
	* Appends frame copy to animation.
	* You can use this to rearrange an animation at runtime, create transitions, etc.
	*
	* @return number of created frame.
	*/
	public function appendFrameCopy (frameNumber:Int):Int
	{
		//var f:Array = vertices [frameNumber] as Array;
		var f:Array<Vector> = vertices [frameNumber];
		if (f == null) {
			return -1;
		} else {
			return vertices.push (f.slice (0)) -1;
		}
	}

	// animation "time" (frame number)
	private var t:Int;		

	// vertices list for every frame
	private var vertices:Array<Array<Vector>>;

	// vars for quick normal computation
	private var v:Vector;
 private var w:Vector;

	// original Philippe vars
	private var ident:Int;
	private var version:Int;
	private var skinwidth:Int;
	private var skinheight:Int;
	private var framesize:Int;
	private var num_skins:Int;
	private var num_vertices:Int;
	private var num_st:Int;
	private var num_tris:Int;
	private var num_glcmds:Int;
	private var num_frames:Int;
	private var offset_skins:Int;
	private var offset_st:Int;
	private var offset_tris:Int;
	private var offset_frames:Int;
	private var offset_glcmds:Int;
	private var offset_end:Int;
	private var scaling:Float;

	private var texture:String;

	/**
	 * Number of frames in MD2.
	 */
	public var nFrames(__getNFrames,null):Float;
	private function __getNFrames():Float { return num_frames; }

	/**
	* Texture file name.
	*/
	public var textureFileName(__getTextureFileName,null):String;
	public function __getTextureFileName():String { return texture; }
}

