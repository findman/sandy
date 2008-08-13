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
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;

import sandy.materials.MaterialType;

// FIXME - perhaps SkinEvent class should be renamed to MaterialsEvent 
// (was Object3D.as, which is obsolete, the last class to use SkinEvent?)

/**
 * @author 		Thomas Pfeiffer - kiroukou
 * @author		Bruce Epstein	- zeusprod
 * @since		1.0
 * @version		2.0
 * @date 		07.05.2007
 */
class sandy.events.SkinEvent extends BasicEvent 
{
	public static var UPDATE:EventType = new EventType('onUpdateEVENT');
	
	public function SkinEvent(e : EventType, oT, type:MaterialType ) 
	{
		super( e, oT );
		_type = type;
	}
	
	public function getSkinType( Void ):MaterialType
	{
		return getMaterialType();
	}
	
	public function getMaterialType( Void ):MaterialType
	{
		return _type;
	}
	
	private var _type:MaterialType;
}