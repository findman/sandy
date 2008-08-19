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

package sandy.materials;

import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.filters.ColorMatrixFilter;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

import sandy.core.Scene3D;
import sandy.core.data.Polygon;
import sandy.core.data.Vertex;
import sandy.core.data.UVCoord;
import sandy.materials.attributes.MaterialAttributes;
import sandy.util.NumberUtil;

/**
 * Displays a bitmap on the faces of a 3D shape..
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author		Xavier Martin - zeflasher - transparency managment
 * @author		Makc for first renderRect implementation
 * @author		James Dahl - optimization in renderRec method
 * @author Niel Drummond - haXe port 
 * 
 * 
 */
class BitmapMaterial extends Material
{

	/**
	 * This property enable smooth bitmap rendering when set to true.
	 * The default value is set to false to have the best performance first.
	 * Enable this property have a performance impact, use it warefully
	 */
	public var smooth:Null<Bool>;

	/**
	 * Precision of the bitmap mapping.
	 * This material uses an affine linear mapping. It results in a lack of accuracy at rendering time when the surface to draw is too big.
	 * An usual solution is to augment the number of polygon, but the performance cost can be quite big.
	 * An other solution is to change this property value. The lower to more accurate the perspective correction is.
	 * To disable the perspective correction, set this property to zero, which is also the default value
	 * If you use the precision to solve the distortion issue, you can reduce the primitives quality (execpt if you are experimenting some sorting issues)
	 */
	public var precision:Null<Int>;

	/**
	 * Maximum  recurssion depth when using precision > 1 (which enables the perspective correction).
	 * The bigger the number is, the more accurate the result will be.
	 * Try to change this value to fits your needs to obtain the best performance.
	 */
	public var maxRecurssionDepth:Null<Int>;
	
	/**
	 * Creates a new BitmapMaterial.
	 * <p>Please note that we ue internally a copy of the constructor bitmapdata. Thatea mns in case you need to access this bitmapdata, you can't just use the same reference
	 * but you shall use the BitmapMaterial#texture getter property to make it work.</p>
	 * @param p_oTexture 	The bitmapdata for this material
	 * @param p_oAttr	The attributes for this material
	 * @param p_nPrecision The precision of this material. Using a precision with 0 makes the material behave as before. Then 1 as precision is very high and requires a lot of computation but proceed a the best perpective mapping correction. Bigger values are less CPU intensive but also less accurate. Usually a value of 5 is enough.
	 */
	public function new( ?p_oTexture:BitmapData, ?p_oAttr:MaterialAttributes, ?p_nPrecision:Null<Int> )
	{
	 smooth = false;
	 precision = 0;
	 maxRecurssionDepth = 5;
		
  map = new Matrix();
	 m_nRecLevel = 0;
	 m_oPoint = new Point();
	 matrix = new Matrix();
	 m_oTiling = new Point( 1, 1 );
	 m_oOffset = new Point( 0, 0 );

		if( p_nPrecision == null) p_nPrecision = 0;

		super(p_oAttr);
		// --
		m_oType = MaterialType.BITMAP;
		// --
		var temp:BitmapData = new BitmapData( p_oTexture.width, p_oTexture.height, true, 0 );
		temp.draw( p_oTexture );
		texture = temp;
		// --
		m_oCmf = new ColorMatrixFilter();
		m_oPolygonMatrixMap = new Array();
		precision = p_nPrecision;
	}

	/**
	 * Renders this material on the face it dresses
	 *
	 * @param p_oScene		The current scene
	 * @param p_oPolygon	The face to be rendered
	 * @param p_mcContainer	The container to draw on
	 */
	public override function renderPolygon( p_oScene:Scene3D, p_oPolygon:Polygon, p_mcContainer:Sprite ):Void
	{
       	if( m_oTexture == null ) return;
       	// --
		var l_points:Array<Vertex>, l_uv:Array<UVCoord>;
		// --
		polygon = p_oPolygon;
       	graphics = p_mcContainer.graphics;
		// --
		m_nRecLevel = 0;
		// --
		if( polygon.isClipped )
		{
			l_points = p_oPolygon.cvertices.slice(0);
			l_uv = p_oPolygon.caUVCoord.slice(0);
			_tesselatePolygon( l_points, l_uv );
		}
		else if( polygon.vertices.length > 3 )
		{
			l_points = p_oPolygon.vertices.slice(0);
			l_uv = p_oPolygon.aUVCoord.slice(0);
			_tesselatePolygon( l_points, l_uv );
		}
		else
		{
			l_points = p_oPolygon.vertices;
			l_uv = p_oPolygon.aUVCoord;
			// --
			map = cast( m_oPolygonMatrixMap[polygon.id], Matrix );
			var v0:Vertex = l_points[0];
        	var v1:Vertex = l_points[1];
        	var v2:Vertex = l_points[2];
			if( precision == 0 )
	        {
	        	renderTriangle(map.a, map.b, map.c, map.d, map.tx, map.ty, v0.sx, v0.sy, v1.sx, v1.sy, v2.sx, v2.sy );
	        }
	        else
	        {
		        renderRec(	map.a, map.b, map.c, map.d, map.tx, map.ty,
							v0.sx, v0.sy, v0.wz,
							v1.sx, v1.sy, v1.wz,
							v2.sx, v2.sy, v2.wz);
	        }
		}

		// --
		if( attributes != null )  attributes.draw( graphics, polygon, this, p_oScene ) ;
		// --
		l_points = null;
		l_uv = null;
	}

	private function _tesselatePolygon ( p_aPoints:Array<Vertex>, p_aUv:Array<UVCoord> ):Void
	{
		var l_points: Array<Vertex> = p_aPoints.slice(0);
		var l_uv: Array<UVCoord> = p_aUv.slice(0);
		// --
		if( l_points.length > 3 )
		{
			l_points = l_points.slice( 0, 3 );
			l_uv = l_uv.slice( 0, 3 );
			// --
			p_aPoints.splice( 1, 1 );
			p_aUv.splice( 1, 1 );
			// --
			_tesselatePolygon( p_aPoints, p_aUv );
		}
		// --
		map = _createTextureMatrix( l_uv );
        // --
        var v0:Vertex = l_points[0];
        var v1:Vertex = l_points[1];
        var v2:Vertex = l_points[2];

        if( precision == 0 )
        {
        	renderTriangle(map.a, map.b, map.c, map.d, map.tx, map.ty, v0.sx, v0.sy, v1.sx, v1.sy, v2.sx, v2.sy );
        }
        else
        {
	        renderRec(	map.a, map.b, map.c, map.d, map.tx, map.ty,
						v0.sx, v0.sy, v0.wz,
						v1.sx, v1.sy, v1.wz,
						v2.sx, v2.sy, v2.wz);
        }
        // --
        l_points = null;
		l_uv = null;
 	}

 		private function renderRec( ta:Float, tb:Float, tc:Float, td:Float, tx:Float, ty:Float,
           ax:Float, ay:Float, az:Float, bx:Float, by:Float, bz:Float, cx:Float, cy:Float, cz:Float):Void
       {
           m_nRecLevel++;
           var ta2:Float = ta+ta;
           var tb2:Float = tb+tb;
           var tc2:Float = tc+tc;
           var td2:Float = td+td;
           var tx2:Float = tx+tx;
           var ty2:Float = ty+ty;
           var mabz:Float = 2 / (az + bz);
           var mbcz:Float = 2 / (bz + cz);
           var mcaz:Float = 2 / (cz + az);
           var mabx:Float = (ax*az + bx*bz)*mabz;
           var maby:Float = (ay*az + by*bz)*mabz;
           var mbcx:Float = (bx*bz + cx*cz)*mbcz;
           var mbcy:Float = (by*bz + cy*cz)*mbcz;
           var mcax:Float = (cx*cz + ax*az)*mcaz;
           var mcay:Float = (cy*cz + ay*az)*mcaz;
           var dabx:Float = ax + bx - mabx;
           var daby:Float = ay + by - maby;
           var dbcx:Float = bx + cx - mbcx;
           var dbcy:Float = by + cy - mbcy;
           var dcax:Float = cx + ax - mcax;
           var dcay:Float = cy + ay - mcay;
           var dsab:Float = (dabx*dabx + daby*daby);
           var dsbc:Float = (dbcx*dbcx + dbcy*dbcy);
           var dsca:Float = (dcax*dcax + dcay*dcay);
           var mabxHalf:Float = mabx*0.5;
           var mabyHalf:Float = maby*0.5;
           var azbzHalf:Float = (az+bz)*0.5;
           var mcaxHalf:Float = mcax*0.5;
           var mcayHalf:Float = mcay*0.5;
           var czazHalf:Float = (cz+az)*0.5;
           var mbcxHalf:Float = mbcx*0.5;
           var mbcyHalf:Float = mbcy*0.5;
           var bzczHalf:Float = (bz+cz)*0.5;

           if (( m_nRecLevel > maxRecurssionDepth ) || ((dsab <= precision) && (dsca <= precision) && (dsbc <= precision)))
           {
               renderTriangle(ta, tb, tc, td, tx, ty, ax, ay, bx, by, cx, cy);
               m_nRecLevel--; return;
           }

           if ((dsab > precision) && (dsca > precision) && (dsbc > precision) )
           {
               renderRec(ta2, tb2, tc2, td2, tx2, ty2,
                   ax, ay, az, mabxHalf, mabyHalf, azbzHalf, mcaxHalf, mcayHalf, czazHalf);

               renderRec(ta2, tb2, tc2, td2, tx2-1, ty2,
                   mabxHalf, mabyHalf, azbzHalf, bx, by, bz, mbcxHalf, mbcyHalf, bzczHalf);

               renderRec(ta2, tb2, tc2, td2, tx2, ty2-1,
                   mcaxHalf, mcayHalf, czazHalf, mbcxHalf, mbcyHalf, bzczHalf, cx, cy, cz);

               renderRec(-ta2, -tb2, -tc2, -td2, -tx2+1, -ty2+1,
                   mbcxHalf, mbcyHalf, bzczHalf, mcaxHalf, mcayHalf, czazHalf, mabxHalf, mabyHalf, azbzHalf);

               m_nRecLevel--; return;
           }

           var dmax:Float = Math.max(dsab, Math.max(dsca, dsbc));

           if (dsab == dmax)
           {
               renderRec(ta2, tb, tc2, td, tx2, ty,
                   ax, ay, az, mabxHalf, mabyHalf, azbzHalf, cx, cy, cz);

               renderRec(ta2+tb, tb, tc2+td, td, tx2+ty-1, ty,
                   mabxHalf, mabyHalf, azbzHalf, bx, by, bz, cx, cy, cz);

               m_nRecLevel--; return;
           }

           if (dsca == dmax)
           {
               renderRec(ta, tb2, tc, td2, tx, ty2,
                   ax, ay, az, bx, by, bz, mcaxHalf, mcayHalf, czazHalf);

               renderRec(ta, tb2 + ta, tc, td2 + tc, tx, ty2+tx-1,
                   mcaxHalf, mcayHalf, czazHalf, bx, by, bz, cx, cy, cz);

               m_nRecLevel--; return;
           }

           renderRec(ta-tb, tb2, tc-td, td2, tx-ty, ty2,
               ax, ay, az, bx, by, bz, mbcxHalf, mbcyHalf, bzczHalf);

           renderRec(ta2, tb-ta, tc2, td-tc, tx2, ty-tx,
               ax, ay, az, mbcxHalf, mbcyHalf, bzczHalf, cx, cy, cz);

           m_nRecLevel--;
       }
       

	private inline function renderTriangle(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float,
		v0x:Float, v0y:Float, v1x:Float, v1y:Float, v2x:Float, v2y:Float):Void
	{
		var a2:Float = v1x - v0x;
		var b2:Float = v1y - v0y;
		var c2:Float = v2x - v0x;
		var d2:Float = v2y - v0y;
		
		matrix.a = a*a2 + b*c2;
		matrix.b = a*b2 + b*d2;
		matrix.c = c*a2 + d*c2;
		matrix.d = c*b2 + d*d2;
		matrix.tx = tx*a2 + ty*c2 + v0x;
		matrix.ty = tx*b2 + ty*d2 + v0y;

		graphics.lineStyle();
		graphics.beginBitmapFill(m_oTexture, matrix, repeat, smooth);
		graphics.moveTo(v0x, v0y);
		graphics.lineTo(v1x, v1y);
		graphics.lineTo(v2x, v2y);
		graphics.endFill();
	}


	private inline function _createTextureMatrix( p_aUv:Array<Dynamic> ):Matrix
	{
		var u0: Float = (Std.parseFloat(p_aUv[0].u) * m_oTiling.x + m_oOffset.x) * m_nWidth,
			v0: Float = (Std.parseFloat(p_aUv[0].v) * m_oTiling.y + m_oOffset.y) * m_nHeight,
			u1: Float = (Std.parseFloat(p_aUv[1].u) * m_oTiling.x + m_oOffset.x) * m_nWidth,
			v1: Float = (Std.parseFloat(p_aUv[1].v) * m_oTiling.y + m_oOffset.y) * m_nHeight,
			u2: Float = (Std.parseFloat(p_aUv[2].u) * m_oTiling.x + m_oOffset.x) * m_nWidth,
			v2: Float = (Std.parseFloat(p_aUv[2].v) * m_oTiling.y + m_oOffset.y) * m_nHeight;
		// -- Fix perpendicular projections. Not sure it is really useful here since there's no texture prjection. This will certainly solve the freeze problem tho
		if( (u0 == u1 && v0 == v1) || (u0 == u2 && v0 == v2) )
		{
			u0 -= (u0 > 0.05)? 0.05 : -0.05;
			v0 -= (v0 > 0.07)? 0.07 : -0.07;
		}
		if( u2 == u1 && v2 == v1 )
		{
			u2 -= (u2 > 0.05)? 0.04 : -0.04;
			v2 -= (v2 > 0.06)? 0.06 : -0.06;
		}
		// --
		var m:Matrix = new Matrix( (u1 - u0), (v1 - v0), (u2 - u0), (v2 - v0), u0, v0 );
		m.invert();
		return m;
	}

	/**
	 * The texture ( bitmap ) of this material
	 */
	public var texture(__getTexture,__setTexture):Null<BitmapData>;
	private function __getTexture():BitmapData
	{
		return m_oTexture;
	}

	/**
	 * @private
	 */
	private function __setTexture( p_oTexture:BitmapData ):Null<BitmapData>
	{
		if( p_oTexture == m_oTexture )
		{
			return null;
		}
		else
		{
			if( m_oTexture != null ) m_oTexture.dispose();
			if( m_orgTexture != null ) m_orgTexture.dispose();
		}
		// --
		var l_bReWrap:Null<Bool> = false;
		if( m_nHeight != p_oTexture.height) l_bReWrap = true;
		else if( m_nWidth != p_oTexture.width) l_bReWrap = true;
		// --
		m_oTexture = p_oTexture;
		m_orgTexture = p_oTexture.clone();
		
		m_nHeight = m_oTexture.height;
		m_nWidth = m_oTexture.width;
		m_nInvHeight = 1/m_nHeight;
		m_nInvWidth = 1/m_nWidth;
		// -- We reinitialize the precomputed matrix
		if( l_bReWrap && m_oPolygonMatrixMap != null )
		{
			for( l_sID in m_oPolygonMatrixMap )
			{
				var l_oPoly:Polygon = Polygon.POLYGON_MAP.get( l_sID ) ;
				init( l_oPoly );
			}
		}
		return p_oTexture;
	}

	/**
	 * Sets texture tiling and optional offset. Tiling is applied first.
	 */
	public function setTiling( p_nW:Float, p_nH:Float, ?p_nU:Float, ?p_nV:Float ):Void
	{
		m_oTiling.x = p_nW;
		m_oTiling.y = p_nH;
		// --
		m_oOffset.x = p_nU;
		m_oOffset.y = p_nV;
		// --

		if( p_nU == null) p_nU = 0;
		if ( p_nV == null) p_nV = 0;

		for( l_sID in m_oPolygonMatrixMap )
		{
			var l_oPoly:Polygon = Polygon.POLYGON_MAP.get( l_sID );
			init( l_oPoly );
		}
	}
	

	/**
	 * Changes the transparency of the texture.
	 *
	 * <p>The passed value is the percentage of opacity.</p>
	 *
	 * @param p_nValue 	A value between 0 and 1. (automatically constrained)
	 */
	public function setTransparency( p_nValue:Float ):Void
	{
		p_nValue = NumberUtil.constrain( p_nValue, 0, 1 );
		if( m_oCmf != null ) m_oCmf = null;
		var matrix:Array<Float> = [	1, 0, 0, 0, 0,
						    	0, 1, 0, 0, 0,
						    	0, 0, 1, 0, 0,
						    	0, 0, 0, p_nValue, 0];

		m_oCmf = new ColorMatrixFilter( matrix );
		texture.applyFilter( m_orgTexture, texture.rect, m_oPoint, m_oCmf );
	}

	public override function unlink( p_oPolygon:Polygon ):Void
	{
		if( m_oPolygonMatrixMap[p_oPolygon.id] != null )
			m_oPolygonMatrixMap[p_oPolygon.id] = null;
		// --
		super.unlink( p_oPolygon );
	}
	/**
	 * Initiates this material.
	 *
	 * @param p_oPolygon	The face dressed by this material
	 */
	public override function init( p_oPolygon:Polygon ):Void
	{
		if( p_oPolygon.vertices.length >= 3 )
		{
			var m:Matrix = null;
			// --
			if( m_nWidth > 0 && m_nHeight > 0 )
			{
				var l_aUV:Array<UVCoord> = p_oPolygon.aUVCoord;
				if( l_aUV != null )
				{
					m = _createTextureMatrix( l_aUV );
				}
			}
			// --
			m_oPolygonMatrixMap[p_oPolygon.id] = m;
		}
		// --
		super.init( p_oPolygon );
	}

	public function toString():String
	{
		return 'sandy.materials.BitmapMaterial' ;
	}

	var polygon:Polygon;
 var graphics:Graphics;
 var map:Matrix;

	private var m_oTexture:BitmapData;
	private var m_orgTexture:BitmapData;
	private var m_nHeight:Null<Float>;
	private var m_nWidth:Null<Float>;
	private var m_nInvHeight:Null<Float>;
	private var m_nInvWidth:Null<Float>;

	private var m_nRecLevel:Null<Int>;
	private var m_oPolygonMatrixMap:Array<Dynamic>;
	private var m_oPoint:Point;
	private var m_oCmf:ColorMatrixFilter;
	private var matrix:Matrix;
	private var m_oTiling:Point;
	private var m_oOffset:Point;
}

