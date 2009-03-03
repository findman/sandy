package sandy.primitive;

import sandy.core.scenegraph.Geometry3D;
import sandy.core.scenegraph.Shape3D;
import sandy.primitive.Primitive3D;
import sandy.core.data.Point3D;
import sandy.core.data.Vertex;
import sandy.core.data.UVCoord;

import flash.utils.ByteArray;
import flash.utils.Endian;


/**
* MD2 primitive.
*
* @author Philippe Ajoux (philippe.ajoux@gmail.com)
* @author Niel Drummond - haXe port
* @author Russell Weir - haXe port
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
	public function new ( p_sName:String, data:ByteArray, ?scale:Float = 1.0 )
	{
		frames = new Hash();
		vertices = [];
		v = new Point3D ();
		w = new Point3D ();

		super (p_sName); scaling = scale; geometry = generate ([data]); frame = 0;
		//animated = true;
	}

	public override function clone( ?p_sName:String="", ?p_bKeepTransform:Bool = false ):Shape3D
	{
		var l_oCopy:MD2 = new MD2(p_sName, m_oBinaryData, scaling);
		if( p_bKeepTransform == true ) l_oCopy.matrix = this.matrix;
		l_oCopy.useSingleContainer = this.useSingleContainer;
		l_oCopy.appearance = this.appearance;
		return l_oCopy;
	}

	private var m_oBinaryData:ByteArray;

	/**
	* Generates the geometry for MD2. Sandy never actually calls this method,
	* but we still implement it according to Primitive3D, just in case :)
	*
	* @return The geometry object.
	*/
	public function generate<T>(?arguments:Array<T>):Geometry3D
	{
		var i:Int, j:Int, char:Int;
		var uvs:Array<UVCoord> = [];
		var mesh:Geometry3D = new Geometry3D ();

		// okay, let's read out header 1st
		var data:ByteArray = cast arguments[0];
		data.endian = Endian.LITTLE_ENDIAN;
		data.position = 0;

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
			var vi:Array<Point3D> = [];
			vertices [i] = vi;
			for (j in 0...num_vertices)
			{
				var vec:Point3D = new Point3D ();

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
	public var frame (__getFrame,__setFrame):Float;
	private function __getFrame ():Float { return t; }

	/**
	* @private (setter)
	*/
	private function __setFrame (value:Float):Float
	{
		t = value;

		// interpolation frames
		var f1:Array<Point3D> = vertices [Std.int(t) % num_frames];
		var f2:Array<Point3D> = vertices [(Std.int(t) + 1) % num_frames];

		// interpolation coef-s
		var c2:Float = t - Std.int(t), c1:Float = 1 - c2;

		// loop through vertices
		for (i in 0...num_vertices)
		{
			var v0:Vertex = geometry.aVertex [i];
			var v1:Point3D = f1 [i];
			var v2:Point3D = f2 [i];

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
		var f:Array<Point3D> = vertices [frameNumber];
		if (f == null) {
			return -1;
		} else {
			return vertices.push (f.slice (0)) -1;
		}
	}

	/**
	* Replaces specified frame with other key or interpolated frame.
	*/
	public function replaceFrame (destFrame:Int, sourceFrame:Float):Void
	{
		var sfi = Std.int(sourceFrame);
		var f0:Array<Point3D> = [];

		// interpolation frames
		var f1:Array<Point3D> = vertices [sfi % num_frames];
		var f2:Array<Point3D> = vertices [(sfi + 1) % num_frames];

		// interpolation coef-s
		var c2:Float = sourceFrame - sfi, c1:Float = 1 - c2;

		// loop through vertices
		for(i in 0...num_vertices)
		{
			var v0:Point3D = new Point3D();
			var v1:Point3D = f1 [i];
			var v2:Point3D = f2 [i];

			// interpolate
			v0.x = v1.x * c1 + v2.x * c2;
			v0.y = v1.y * c1 + v2.y * c2;
			v0.z = v1.z * c1 + v2.z * c2;

			// save
			f0 [i] = v0;
		}

		vertices [destFrame] = f0;
		num_frames = vertices.length;
	}

	// animation "time" (frame number)
	private var t:Float;

	// vertices list for every frame
	private var vertices:Array<Array<Point3D>>;

	// vars for quick normal computation
	private var v:Point3D;
	private var w:Point3D;

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
	* Float of frames in MD2.
	*/
	public var nFrames(__getNFrames,null):Float;
	private function __getNFrames():Float { return num_frames; }

	/**
	* Texture file name.
	*/
	public var textureFileName(__getTextureFileName,null):String;
	public function __getTextureFileName():String { return texture; }
}

