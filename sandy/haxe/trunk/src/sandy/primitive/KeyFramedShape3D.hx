
package sandy.primitive;

import sandy.animation.Tag;
import sandy.core.data.Point3D;
import sandy.core.data.Vertex;
import sandy.core.data.UVCoord;
import sandy.core.scenegraph.Geometry3D;
import sandy.core.scenegraph.Shape3D;
import sandy.materials.Appearance;
import sandy.primitive.Primitive3D;

import flash.utils.ByteArray;
import flash.utils.Endian;

import sandy.HaxeTypes;

/**
* Base class for shapes that are frame based animations.
* includes classes like MD2 and MD3
* @author Russell Weir (madrok)
* @author makc
**/
class KeyFramedShape3D extends Shape3D,
	implements sandy.animation.IKeyFramed,
	implements Primitive3D
{
	/**
	* Frames map. This maps frame names to frame numbers. For many
	* model exported from 3d software, the frames may all be named
	* the same. Sandy does not rely on this hash, it may be used
	* to store arbitrary name->frame mapping.
	*/
	public var frames:Hash<Int>;
	public var frame (__getFrame,__setFrame):Float;
	public var nFrames(__getNFrames,null):Int;
	public var nVertices(__getNVertices,null):Int;


	/**
	* Creates KeyFramedShape3D primitive.
	*
	* @param p_sName Shape instance name.
	* @param data MD2 binary data.
	* @param scale Adjusts model scale.
	*/
	public function new( p_sName:String="", data:Bytes=null, scale:Float=1.0, p_oAppearance:Appearance=null, p_bUseSingleContainer:Bool=true) {
		v = new Point3D ();
		w = new Point3D ();
		frames = new Hash();
		vertices = [];
		scaling = scale;

		super(p_sName, null, p_oAppearance, p_bUseSingleContainer);

		frame = 0;
		if(data != null)
			geometry = generate ([data]);
	}

	/**
	* Appends frame copy to animation.
	* You can use this to rearrange an animation at runtime, create transitions, etc.
	*
	* @return number of created frame.
	*/
	public function appendFrameCopy (frameNumber:Int):Int
	{
		var rv:Int = -1;
		if(vertices.length > 0) {
			var f:Array<Point3D> = vertices [frameNumber];
			if (f == null) {
				return -1;
			} else {
				num_frames++;
				return vertices.push (f.slice (0)) -1;
			}
		}
		return rv;
	}

	public override function clone( ?p_sName:String = "", ?p_bKeepTransform:Bool=false ):Shape3D
	{
		var l_oClone:KeyFramedShape3D = new KeyFramedShape3D( p_sName, null, scaling, appearance, m_bUseSingleContainer );
		// --
		l_oClone.geometry = geometry.clone();
		// --
		if( p_bKeepTransform == true ) l_oClone.matrix.copy( this.matrix );
		// --
		l_oClone.useSingleContainer = this.useSingleContainer;
		// --
		l_oClone.appearance = this.appearance;
		// --
		var vc = new Array<Array<Point3D>>();
		for(i in 0...vertices.length) {
			var vr = new Array<Point3D>();
			vc[i] = vr;
			for(j in 0...vertices[i].length)
				vr[j] = vertices[i][j].clone();
		}
		l_oClone.vertices = vc;
		// --
		l_oClone.num_frames = num_frames;
		l_oClone.num_vertices = num_vertices;
		l_oClone.m_nCurFrame = 0;

		return l_oClone;
	}

	/**
	* Replaces specified frame with other key or interpolated frame.
	* @todo interpolate origins and rotations from tags hash
	*/
	public function replaceFrame (destFrame:Int, sourceFrame:Float):Void
	{
		var sfi = Std.int(sourceFrame);
		var f0:Array<Point3D> = [];

		if(vertices.length > 0) {
			// interpolation frames
			var f1:Array<Point3D> = vertices [sfi % num_frames];
			var f2:Array<Point3D> = vertices [(sfi + 1) % num_frames];

			// interpolation coef-s
			var c2:Float = sourceFrame - sfi, c1:Float = 1. - c2;

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
	}


	private function __getFrame ():Float { return m_nCurFrame; }

	/**
	* @private (setter)
	*/
	private function __setFrame (value:Float):Float
	{
		m_nCurFrame = value;

		if(vertices.length == 0)
			return value;

		// interpolation frames
		var f1:Array<Point3D> = vertices [Std.int(m_nCurFrame) % num_frames];
		var f2:Array<Point3D> = vertices [(Std.int(m_nCurFrame) + 1) % num_frames];

		// interpolation coef-s
		var c2:Float = m_nCurFrame - Std.int(m_nCurFrame), c1:Float = 1 - c2;

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
			w.crossWith (v); w.normalize ();
			l_oPoly.normal.x = w.x; l_oPoly.normal.y = w.y; l_oPoly.normal.z = w.z;
		}

		changed = true;
		return value;
	}

	private function __getNFrames():Int { return num_frames; }
	private function __getNVertices():Int { return vertices.length; }

	/**
	* Generates the geometry.
	*
	* @return The geometry object.
	*/
	public function generate<T>(?arguments:Array<T>):Geometry3D
	{
		return new Geometry3D();
	}

	/**
		Reads a C style null terminated string from an input buffer,
		consuming all of <code>count</code> bytes.
		@param data Input bytes
		@param count Bytes to consume
		@return String not including any bytes from a 0 on.
	**/
	public static function readCString(data:ByteArray, count:Int, ?breakOnNull:Bool) {
		var rv = "";
		var append = true;
		for (i in 0...count)
		{
			var c = data.readUnsignedByte ();
			if(c == 0) {
				append = false;
				if(breakOnNull)
					return rv;
				continue;
			}
			if(append)
				rv += String.fromCharCode(c);
		}
		return rv;
	}

	private var num_frames:Int; // total number of frames in animation
	private var num_vertices:Int;
	private var vertices:Array<Array<Point3D>>; // vertices list for every frame

	private var m_nCurFrame:Float; // animation "time" (frame number)
	private var scaling:Float;

	// vars for quick normal computation
	private var v:Point3D;
	private var w:Point3D;

}