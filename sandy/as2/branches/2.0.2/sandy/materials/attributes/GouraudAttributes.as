﻿/*
# ***** BEGIN LICENSE BLOCK *****
Copyright the original author or authors.
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

import flash.geom.Matrix;
	
import sandy.core.Scene3D;
import sandy.core.data.Polygon;
import sandy.core.data.Vector;
import sandy.core.data.Vertex;
import sandy.materials.Material;
import sandy.materials.attributes.ALightAttributes;

/**
 * Realize a Gouraud shading on a material.
 *
 * <p>To make this material attribute use by the Material object, the material must have :myMAterial.lighteningEnable = true.<br />
 * This attributes contains some parameters</p>
 * 
 * @author		Thomas Pfeiffer - kiroukou
 * @author		Makc for the effect improvment 
 * @author		(porting) Floris - xdevltd
 * @version		2.0.2
 * @date 		13.11.2007
 */
 
class sandy.materials.attributes.GouraudAttributes extends ALightAttributes
{

	/**
	 * Flag for lightening mode.
	 * <p>If true, the lit objects use full light range from black to white. If false ( the default ) they just range from black to their normal appearance.</p>
	 */
	public function get useBright() : Boolean
	{
		return _useBright;
	}
		
	/**
	 * @private
	 */
	public function set useBright( p_bUseBright:Boolean ) : Void
	{
		_useBright = p_bUseBright; makeLightMap();
	}

	private function makeLightMap() : Void
	{
		m_aColors = _useBright ? [ 0, 0, 0xFFFFFF, 0xFFFFFF ] : [ 0, 0 ];
		m_aAlphas = _useBright ? [ 1, 0, 0, 1 ] : [ 1, 0 ];
		m_aRatios = _useBright ? [ 0, 127, 127, 255 ] : [ 0, 255 ];
	}

	/**
	 * Create the GouraudAttribute object.
	 * @param p_bBright The brightness ( value for useBright ).
	 * @param p_nAmbient The ambient light value. A value between O and 1 is expected.
	 */
	public function GouraudAttributes( p_bBright:Boolean, p_nAmbient:Number )
	{
		useBright = p_bBright||false;
		ambient = Math.min( Math.max( p_nAmbient||0.0, 0 ), 1 );
		//-- define some vars
		m1 = new Matrix;
		m2 = new Matrix;
	}

	private var v0L:Number, v1L:Number, v2L:Number;
	private var m1:Matrix;
	private var m2:Matrix;
	private var m_oVertex:Vertex;

	/**
	 * @private
	 */
	public function draw( p_oMovieClip:MovieClip, p_oPolygon:Polygon, p_oMaterial:Material, p_oScene:Scene3D ) : Void
	{
		super.draw( p_oMovieClip, p_oPolygon, p_oMaterial, p_oScene );

		if( !p_oMaterial.lightingEnable ) return;
		
		// get vertices
		var l_aPoints:Array = ( p_oPolygon.isClipped ) ? p_oPolygon.cvertices : p_oPolygon.vertices;
		// calculate light per vertex
		var l_bVisible:Boolean = p_oPolygon.visible;
		var l_nAmbient:Number = ambient;

		var v0L:Number = calculate( Vertex( p_oPolygon.vertexNormals[ 0 ] ).getVector(), l_bVisible ); if( v0L < l_nAmbient ) v0L = l_nAmbient; else if( v0L > 1 ) v0L = 1;
		var v1L:Number = calculate( Vertex( p_oPolygon.vertexNormals[ 1 ] ).getVector(), l_bVisible ); if( v1L < l_nAmbient ) v1L = l_nAmbient; else if( v1L > 1 ) v1L = 1;
		var v2L:Number = calculate( Vertex( p_oPolygon.vertexNormals[ 2 ] ).getVector(), l_bVisible ); if( v2L < l_nAmbient ) v2L = l_nAmbient; else if( v2L > 1 ) v2L = 1;
		// affine mapping
		var v0:Number, v1:Number, v2:Number,
			u0:Number, u1:Number, u2:Number, tmp:Number;

		v0 = -100; v1 = 0; v2 = 100;

		u0 = ( v0L - 0.5 ) * ( 32768 * 0.05 );
		u1 = ( v1L - 0.5 ) * ( 32768 * 0.05 );
		u2 = ( v2L - 0.5 ) * ( 32768 * 0.05 );

		m2.tx = Vertex( l_aPoints[ 0 ] ).sx; m2.ty = Vertex( l_aPoints[ 0 ] ).sy;

		// we have 3276.8 pixels per 256 colors ( ~0.07 colors per pixel )
		if( ( int( u0 * 0.1 ) == int( u1 * 0.1 ) ) && ( int( u1 * 0.1 ) == int( u2 * 0.1 ) ) )
		{
			// this is solid color case - so fill accordingly
			p_oMovieClip.lineStyle();
			if( _useBright ) 
				p_oMovieClip.beginFill( ( v0L < 0.5 ) ? 0 : 0xFFFFFF, ( v0L < 0.5 ) ? ( 1 - 2 * v0L ) : ( 2 * v0L - 1 ) );
			else
				p_oMovieClip.beginFill( 0, 1 - v0L );
			p_oMovieClip.moveTo( m2.tx, m2.ty );
			for( m_oVertex in l_aPoints )
			{
				p_oMovieClip.lineTo( l_aPoints[ m_oVertex ].sx, l_aPoints[ m_oVertex ].sy );
			}
			p_oMovieClip.endFill();
			return;
		}
				
		// in one line?
		if( ( u2 - u1 ) * ( u1 - u0 ) > 0 )
		{
			tmp = v1; v1 = v2; v2 = tmp;
		}

		// prepare matrix
		m1.a = u1 - u0; m1.b = v1 - v0;
		m1.c = u2 - u0; m1.d = v2 - v0;
		m1.tx = u0; m1.ty = v0;
		m1.invert();

		m2.a = Vertex( l_aPoints[ 1 ] ).sx - m2.tx; m2.b = Vertex( l_aPoints[ 1 ] ).sy - m2.ty;
		m2.c = Vertex( l_aPoints[ 2 ] ).sx - m2.tx; m2.d = Vertex( l_aPoints[ 2 ] ).sy - m2.ty;
		m1.concat( m2 );
		// draw the map
		p_oMovieClip.lineStyle();
		/*if( p_oPolygon.id == 259 )
			p_oGraphics.lineStyle( 1, 0xFF0000 );*/
		p_oMovieClip.beginGradientFill( "linear", m_aColors, m_aAlphas, m_aRatios, m1 );
		p_oMovieClip.moveTo( m2.tx, m2.ty );
		for( m_oVertex in l_aPoints )
		{
			p_oMovieClip.lineTo( l_aPoints[ m_oVertex ].sx, l_aPoints[ m_oVertex ].sy );
		}
		p_oMovieClip.endFill();
	}

	private var _useBright:Boolean = true;

	private var m_aColors:Array;
	private var m_aAlphas:Array;
	private var m_aRatios:Array;
	
}