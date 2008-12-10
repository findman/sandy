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

/* note: Javascript tests must be run from a web server - not local file, due to
	* same-domain restrictions */

package unit;

import hxunit.TestCase;
import hxunit.Assert;
import sandy.parser.IParser;
import sandy.parser.Parser;
import sandy.parser.ColladaParser;
import sandy.parser.ParserEvent;
import sandy.core.scenegraph.Camera3D;
import sandy.core.scenegraph.Group;
import sandy.core.scenegraph.Geometry3D;
import sandy.core.scenegraph.Shape3D;
import sandy.materials.BitmapMaterial;
import sandy.materials.ColorMaterial;
#if flash
import sandy.core.scenegraph.StarField;
import sandy.core.data.Vertex;
import flash.filters.GlowFilter;
import flash.text.TextField;
#end
import sandy.core.Scene3D;
import sandy.primitive.Box;
import sandy.view.ViewPort;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flash.net.URLRequest;
import flash.net.URLLoader;
import formats.json.JSON;
import Type;

class TestParsers extends TestCase {

	public static function add ( r:hxunit.Runner ) {
				r.addCase( new TestCollada() );
	}

}

class TestCollada extends TestCase {

	public function testDice() {

			var parser: ColladaParser = Parser.create( "../assets/dice.dae", Parser.COLLADA );
			var ttl = 1000;

			var self = this;
			var root : Group = null;
			var func = function () {
					self.assertEquals( root.children.length, 1 );
					self.assertIs( root.children[0], sandy.core.scenegraph.Shape3D );
					var l_oGeom : Geometry3D = Reflect.field( root.children[0], 'm_oGeometry' );
					self.assertEquals( l_oGeom.aFacesVertexID.length, 12 );
					self.assertEquals( l_oGeom.aVertex.length, 8 );
					self.assertEquals( l_oGeom.aFacesNormals.length, 12 );
					self.assertEquals( l_oGeom.aUVCoords.length, 14 );
					self.assertIs( root.children[0].appearance.frontMaterial, BitmapMaterial );
					var l_oMat : BitmapMaterial = untyped root.children[0].appearance.frontMaterial;
					var l_oULoader : URLLoader = new URLLoader();
					l_oULoader.addEventListener( 'INIT', function ( e:Event ) {
									self.assertEquals( e.target.bitmapData, l_oMat.texture );
					} );
					l_oULoader.load( new URLRequest( '../assets/dice.jpg' ) );
			}
			var cb = asyncResponder( func, ttl );
			parser.addEventListener( ParserEvent.INIT, 
									function (pEvt) {root = pEvt.group; cb();} );

			parser.parse();

	}

	public function testMenu3() {

			var parser: ColladaParser = Parser.create( "../assets/arrow.dae", Parser.COLLADA );
			var ttl = 1000;

			var self = this;
			var root : Group = null;
			var func = function () {

					self.assertEquals( root.children.length, 2 );
					self.assertIs( root.children[0], sandy.core.scenegraph.Shape3D );
					var l_oGeom : Geometry3D = Reflect.field( root.children[0], 'm_oGeometry' );
					self.assertEquals( l_oGeom.aFacesVertexID.length, 38 );
					self.assertEquals( l_oGeom.aVertex.length, 21 );
					self.assertEquals( l_oGeom.aFacesNormals.length, 38 );
					self.assertEquals( l_oGeom.aUVCoords.length, 34 );

					self.assertIs( root.children[1].appearance.frontMaterial, BitmapMaterial );
					var l_oMat : BitmapMaterial = untyped root.children[1].appearance.frontMaterial;
					var l_oULoader : URLLoader = new URLLoader();
					l_oULoader.addEventListener( 'INIT', function ( e:Event ) {
									self.assertEquals( e.target.bitmapData, l_oMat.texture );
					} );
					l_oULoader.load( new URLRequest( '../assets/pCube1SG-pCube2.jpg' ) );

					self.assertIs( root.children[0].appearance.frontMaterial, BitmapMaterial );
					var l_oMat : BitmapMaterial = untyped root.children[1].appearance.frontMaterial;
					var l_oULoader : URLLoader = new URLLoader();
					l_oULoader.addEventListener( 'INIT', function ( e:Event ) {
									self.assertEquals( e.target.bitmapData, l_oMat.texture );
					} );
					l_oULoader.load( new URLRequest( '../assets/pCube1SG-pasted__pPlane1.jpg' ) );

			}
			var cb = asyncResponder( func, ttl );
			parser.addEventListener( ParserEvent.INIT, 
									function (pEvt) {root = pEvt.group; cb();} );

			parser.parse();

	}

}

