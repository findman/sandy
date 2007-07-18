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

package sandy.core.data 
{
	/**
	* Matrix with 4 lines & 4 columns.
	*  
	* @author		Thomas Pfeiffer - kiroukou
	* @version		1.0
	* @date 		28.03.2006
	*/
	public final class Matrix4 
	{
		/**
		 * {@code Matrix4} cell.
		 * <p><code>1 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 0 </code></p>
		 */
		public var n11:Number;
		
		/**
		 * {@code Matrix4} cell.
		 * <p><code>0 1 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 0 </code></p>
		 */
		public var n12:Number;
		
		/**
		 * {@code Matrix4} cell.
		 * <p><code>0 0 1 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 0 </code></p>
		 */
		public var n13:Number;
		
		/**
		 * {@code Matrix4} cell.
		 * <p><code>0 0 0 1 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 0 </code></p>
		 */
		public var n14:Number;
		
		/**
		 * {@code Matrix4} cell.
		 * <p><code>0 0 0 0 <br>
		 *          1 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 0 </code></p>
		 */
		public var n21:Number;
		
		/**
		 * {@code Matrix4} cell.
		 * <p><code>0 0 0 0 <br>
		 *          0 1 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 0 </code></p>
		 */
		public var n22:Number;
		
		/**
		 * {@code Matrix4} cell.
		 * <p><code>0 0 0 0 <br>
		 *          0 0 1 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 0 </code></p>
		 */
		public var n23:Number;
		
		/**
		 * {@code Matrix4} cell.
		 * <p><code>0 0 0 0 <br>
		 *          0 0 0 1 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 0 </code></p>
		 */
		public var n24:Number;
		
		/**
		 * {@code Matrix4} cell.
		 * <p><code>0 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          1 0 0 0 <br>
		 *          0 0 0 0 </code></p>
		 */
		public var n31:Number;
		
		/**
		 * {@code Matrix4} cell.
		 * <p><code>0 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 1 0 0 <br>
		 *          0 0 0 0 </code></p>
		 */
		public var n32:Number;
		
		/**
		 * {@code Matrix4} cell.
		 * <p><code>0 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 1 0 <br>
		 *          0 0 0 0 </code></p>
		 */
		public var n33:Number;
		
		/**
		 * {@code Matrix4} cell.
		 * <p><code>0 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 1 <br>
		 *          0 0 0 0 </code></p>
		 */
		public var n34:Number;
		
		/**
		 * {@code Matrix4} cell.
		 * <p><code>0 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          1 0 0 0 </code></p>
		 */
		public var n41:Number;
		
		/**
		 * {@code Matrix4} cell.
		 * <p><code>0 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 1 0 0 </code></p>
		 */
		public var n42:Number;
		
		/**
		 * {@code Matrix4} cell.
		 * <p><code>0 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 1 0 </code></p>
		 */
		public var n43:Number;
		
		/**
		 * {@code Matrix4} cell.
		 * <p><code>0 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 0 <br>
		 *          0 0 0 1 </code></p>
		 */
		public var n44:Number;
		
		/**
		 * Create a new {@code Matrix4}.
		 * <p>If 16 arguments are passed to the constructor, it will
		 * create a {@code Matrix4} with the values. In the other case,
		 * a identity {@code Matrix4} is created.</p>
		 * <code>var m:Matrix4 = new Matrix4();</code><br>
		 * <code>1 0 0 0 <br>
		 *       0 1 0 0 <br>
		 *       0 0 1 0 <br>
		 *       0 0 0 1 </code><br><br>
		 * <code>var m:Matrix4 = new Matrix4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 
		 * 13, 14, 15, 16);</code><br>
		 * <code>1  2  3  4 <br>
		 *       5  6  7  8 <br>
		 *       9  10 11 12 <br>
		 *       13 14 15 16 </code>
		 */	
		public function Matrix4(pn11:Number=1, pn12:Number=0 , pn13:Number=0 , pn14:Number=0,
								pn21:Number=0, pn22:Number=1 , pn23:Number=0 , pn24:Number=0,
								pn31:Number=0, pn32:Number=0 , pn33:Number=1 , pn34:Number=0,
								pn41:Number=0, pn42:Number=0 , pn43:Number=0 , pn44:Number=1 ) 
		{
			n11 = pn11 ; n12 = pn12 ; n13 = pn13 ; n14 = pn14 ;
			n21 = pn21 ; n22 =pn22 ; n23 = pn23 ; n24 = pn24 ;
			n31 = pn31 ; n32 = pn32 ; n33 = pn33; n34 = pn34;
			n41 = pn41; n42 = pn42; n43 = pn43; n44 = pn44;
		}
		
		/**
		* Create a new Identity Matrix4.
		* <p>An Identity Matrix4 is represented like that :</p>
		* <code>1 0 0 0 <br>
		*       0 1 0 0 <br>
		*       0 0 1 0 <br>
		*       0 0 0 1 </code>
		* 
		* @return	The new Identity Matrix4
		*/
		public static function createIdentity():Matrix4
		{
			return new Matrix4();
		}

		/**
		* Create a new Zero Matrix4.	
		* <p>An zero Matrix4 is represented like that :</p>
		* <code>0 0 0 0 <br>
		*       0 0 0 0 <br>
		*       0 0 0 0 <br>
		*       0 0 0 0 </code>
		* 
		* @return	The new Identity Matrix4
		*/
		public static function createZero():Matrix4
		{
			return new Matrix4( 0, 0, 0, 0,
								0, 0, 0, 0,
								0, 0, 0, 0, 
								0, 0, 0, 0);
		}
		
		/**
		 * Get a string representation of the {@code Matrix4}.
		 *
		 * @return	A String representing the {@code Matrix4}.
		 */
		public function toString(): String
		{
			var s:String =  "sandy.core.data.Matrix4" + "\n (";
			s += n11+"\t"+n12+"\t"+n13+"\t"+n14+"\n";
			s += n21+"\t"+n22+"\t"+n23+"\t"+n24+"\n";
			s += n31+"\t"+n32+"\t"+n33+"\t"+n34+"\n";
			s += n41+"\t"+n42+"\t"+n43+"\t"+n44+"\n)";
			return s;
		}
	}
}