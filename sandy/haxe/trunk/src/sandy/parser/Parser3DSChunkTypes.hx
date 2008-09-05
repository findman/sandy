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

/**
 * Static class that defines the chunks offsets of 3DS file.
 *
 * @author		Thomas Pfeiffer - kiroukou
 * @author Niel Drummond - haXe port 
 * 
 * 
 * 
 */
class Parser3DSChunkTypes
{
	 //>------ primary chunk

	 public static var MAIN3DS       :UInt = 0x4D4D;

	 public static var EDIT3DS       :UInt = 0x3D3D;  // this is the start of the editor config
	 public static var KEYF3DS       :UInt = 0xB000;  // this is the start of the keyframer config

	 //>------ sub defines of EDIT3DS

	 public static var EDIT_MATERIAL :UInt = 0xAFFF;
	 public static var EDIT_CONFIG1  :UInt = 0x0100;
	 public static var EDIT_CONFIG2  :UInt = 0x3E3D;
	 public static var EDIT_VIEW_P1  :UInt = 0x7012;
	 public static var EDIT_VIEW_P2  :UInt = 0x7011;
	 public static var EDIT_VIEW_P3  :UInt = 0x7020;
	 public static var EDIT_VIEW1    :UInt = 0x7001;
	 public static var EDIT_BACKGR   :UInt = 0x1200;
	 public static var EDIT_AMBIENT  :UInt = 0x2100;
	 public static var EDIT_OBJECT   :UInt = 0x4000;

	 public static var EDIT_UNKNW01  :UInt = 0x1100;
	 public static var EDIT_UNKNW02  :UInt = 0x1201;
	 public static var EDIT_UNKNW03  :UInt = 0x1300;
	 public static var EDIT_UNKNW04  :UInt = 0x1400;
	 public static var EDIT_UNKNW05  :UInt = 0x1420;
	 public static var EDIT_UNKNW06  :UInt = 0x1450;
	 public static var EDIT_UNKNW07  :UInt = 0x1500;
	 public static var EDIT_UNKNW08  :UInt = 0x2200;
	 public static var EDIT_UNKNW09  :UInt = 0x2201;
	 public static var EDIT_UNKNW10  :UInt = 0x2210;
	 public static var EDIT_UNKNW11  :UInt = 0x2300;
	 public static var EDIT_UNKNW12  :UInt = 0x2302;
	 public static var EDIT_UNKNW13  :UInt = 0x3000;
	 public static var EDIT_UNKNW14  :UInt = 0xAFFF;

	 //>------ sub defines of EDIT_OBJECT
	 public static var OBJ_TRIMESH   :UInt = 0x4100;
	 public static var OBJ_LIGHT     :UInt = 0x4600;
	 public static var OBJ_CAMERA    :UInt = 0x4700;

	 public static var OBJ_UNKNWN01  :UInt = 0x4010;
	 public static var OBJ_UNKNWN02  :UInt = 0x4012; //>>---- Could be shadow

	 //>------ sub defines of OBJ_CAMERA
	 public static var CAM_UNKNWN01  :UInt = 0x4710;
	 public static var CAM_UNKNWN02  :UInt = 0x4720;

	 //>------ sub defines of OBJ_LIGHT
	 public static var LIT_OFF       :UInt = 0x4620;
	 public static var LIT_SPOT      :UInt = 0x4610;
	 public static var LIT_UNKNWN01  :UInt = 0x465A;

	 //>------ sub defines of OBJ_TRIMESH
	 public static var TRI_VERTEXL   :UInt = 0x4110;
	 public static var TRI_FACEL2    :UInt = 0x4111;
	 public static var TRI_FACEL1    :UInt = 0x4120;
	 public static var TRI_TEXCOORD  :UInt = 0x4140;	// DAS 11-26-04
	 public static var TRI_SMOOTH    :UInt = 0x4150;
	 public static var TRI_LOCAL     :UInt = 0x4160;
	 public static var TRI_VISIBLE   :UInt = 0x4165;


	 //>>------ sub defs of KEYF3DS

	 public static var KEYF_UNKNWN01 	:UInt = 0xB009;
	 public static var KEYF_UNKNWN02 	:UInt = 0xB00A;
	 public static var KEYF_FRAMES   	:UInt = 0xB008;
	 public static var KEYF_OBJDES   	:UInt = 0xB002;

	 //>>------ FRAMES INFO
	 public static var NODE_ID   		:UInt = 0xB030;
	 public static var NODE_HDR   	:UInt = 0xB010;
	 public static var PIVOT   		:UInt = 0xB013;
	 public static var POS_TRACK_TAG	:UInt = 0xB020;
	 public static var ROT_TRACK_TAG	:UInt = 0xB021;
	 public static var SCL_TRACK_TAG	:UInt = 0xB022;

	 //>>------  these define the different color chunk types
	 public static var COL_RGB  :UInt = 0x0010;
	 public static var COL_TRU  :UInt = 0x0011;
	 public static var COL_UNK  :UInt = 0x0013;

	 //>>------ defines for viewport chunks

	 public static var TOP           :UInt = 0x0001;
	 public static var BOTTOM        :UInt = 0x0002;
	 public static var LEFT          :UInt = 0x0003;
	 public static var RIGHT         :UInt = 0x0004;
	 public static var FRONT         :UInt = 0x0005;
	 public static var BACK          :UInt = 0x0006;
	 public static var USER          :UInt = 0x0007;
	 public static var CAMERA        :UInt = 0x0008; // :UInt = 0xFFFF is the actual code read from file
	 public static var LIGHT         :UInt = 0x0009;
	 public static var DISABLED      :UInt = 0x0010;
	 public static var BOGUS         :UInt = 0x0011;
}

