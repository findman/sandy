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

package sandy.core.scenegraph;

import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;

import sandy.core.Scene3D;
import sandy.events.BubbleEvent;
import sandy.core.data.Matrix4;
import sandy.view.Frustum;

/**
 * Transform audio volume and pan relative to the Camera3D 
 * 
 * @author		Daniel Reitterer - Delta 9
 * @author Niel Drummond - haXe port 
 */
class Sound3D extends ATransformable
{
	// events
	public static var LOOP:String = "loop";
	public static var CULL_PLAY:String = "cullPlay";
	public static var CULL_STOP:String = "cullStop";
	// type
	public static var SPEECH:String = "speech";
	public static var NOISE:String = "noise";
	
	/**
	 * Max volume of the sound if camera position is at sound position
	 */
	public var soundVolume:Float;
	/**
	 * The radius of the sound
	 */
	public var soundRadius:Float;
	/**
	* If pan is true the panning of the sound is relative to the camera rotation
	 */
	public var soundPan:Bool;
	/**
	 * Maximal pan is a positive Number from 0-1 or higher
	 */
	public var maxPan:Float;
	/**
	 * If the sound contains two channels, stereo have to be set to true in order to mix left and right channels correctly
	 */
	public var stereo:Bool;
	/**
	 * If flipPan is true the left and right channels of the sound are mirrored if the camera is facing away from the sound
	 */
	public var flipPan:Bool;
	/**
	 * Type is either SPEECH or NOISE, SPEECH will start the sound at the last position if the camera enters the sphere of the sound
	 */
	public var type:String;
	/**
	 * The start time to play the audio from
	 */
	public var startTime:Float;
	/**
	 * Number of loops before the sound stops
	 */
	public var loops:Int;
	/**
	 * Start time to play the audio from if the sound loops
	 */
	public var loopStartTime:Float;
	/**
	 * Returns true if the stereo panorama is mirrored, flipPan have to be true to enable stereo flipping
	 */
	public var isFlipped (__getIsFlipped,null):Bool;
	private function __getIsFlipped ():Bool{return _isFlipped;}
	
	private var _isFlipped:Bool;
	private var _isPlaying:Bool;
	private var soundCulled:Bool;
	private var m_oSoundTransform:SoundTransform;
	private var sMode:String;
	private var urlReq:URLRequest;
	private var channelRef:SoundChannel;
	private var soundRef:Sound;
	private var lastPosition:Float;
	private var lastStopTime:Float;
	private var cPlaying:Bool;
	private var duration:Float;
	private var cLoop:Int;
	
	/**
	 *  Cached matrix corresponding to the transformation to the 0,0,0 frame system
	 */
	public static var modelMatrix:Matrix4 = new Matrix4();
	
	/**
	 * Creates a 3D sound object wich can be placed in the 3d scene. Set stereo to true if the sound source is in stereo.
	 * If stereo is true, both channels are at the same position in 3d space, but the stereo panorama is kept and mirrored if required.
	 * To create a true stereo effect, take two Sound3D instances and two mono sound sources on different locations in 3d space.
	 * 
	 * @param 	p_sName				A string identifier for this object
	 * @param	p_oSoundSource		The sound source, a String, UrlRequest, Sound or a SoundChannel object
	 * @param	p_nVolume			Volume of the sound
	 * @param	p_nMaxPan			Max pan of the sound, if zero panning is disabled
	 * @param	p_nRadius			Radius of the sound in 3d units
	 * @param	p_bStereo			If the sound contains two different channels
	 */
	public function new( ?p_sName:String, ?p_oSoundSource:Dynamic, ?p_nVolume:Float, 
							?p_nMaxPan:Float, ?p_nRadius:Float, ?p_bStereo:Bool ) 
	{

	 _isFlipped=false;
	 _isPlaying=false;
	 soundCulled=false;
	 m_oSoundTransform = new SoundTransform(1,0);
	 sMode = ""; // sound, channel or url
	 lastPosition=0;
	 lastStopTime=0;
	 cPlaying=false;
	 duration=0;
	 cLoop=0;

		if ( p_sName == null ) p_sName = "";
		if ( p_nVolume == null ) p_nVolume = 1;
		if ( p_nMaxPan == null ) p_nMaxPan = 0;
		if ( p_nRadius == null ) p_nRadius = 1;
		if ( p_bStereo == null ) p_bStereo = false;

	 soundPan=true;
	 maxPan = 1;
	 stereo = false;
	 flipPan=true;
	 type = SPEECH;
	 startTime = 0;
	 loops = 0xffffff;
	 loopStartTime=0;

		super( p_sName );
		
		soundVolume = p_nVolume;
		soundRadius = p_nRadius;
		soundSource = p_oSoundSource;
		stereo = p_bStereo;
		
		if(p_nMaxPan == 0) 
		{
			soundPan = false;
		}
		else
		{
			soundPan = true;
			maxPan = p_nMaxPan;
		}
    }
	
	/**
	 * Start Sound sources of type Sound or UrlRequest. 
	 * Sound sources of type SoundChannel don't support the play method
	 * @param	p_nStartTime
	 * @param	p_iLoops
	 */
	public function play (?p_nStartTime:Float, ?p_iLoops:Int, ?p_nLoopStartTime:Float, ?p_bResume:Bool) :Void 
	{
		if ( p_nStartTime == null ) p_nStartTime = -1;
		if ( p_iLoops == null ) p_iLoops = -1;
		if ( p_nLoopStartTime == null ) p_nLoopStartTime = -1;
		if ( p_bResume == null ) p_bResume = false;

		if(!_isPlaying && sMode != "channel") 
		{
			
			if(p_nStartTime != -1) lastPosition = p_nStartTime;
			if(p_iLoops != -1) loops = p_iLoops;
			if(p_nLoopStartTime != -1) loopStartTime = p_nLoopStartTime;
			
			if(!p_bResume) 
			{
				lastPosition = startTime;
				lastStopTime = flash.Lib.getTimer();
			}
			cLoop = 0;
			_isPlaying = true;
			cPlaying = false;
		}
	}
	
	/**
	 * Stop the sound source and SoundChannel
	 */
	public function stop () :Void 
	{
		if(_isPlaying && sMode != "channel") 
		{
			if(cPlaying) cStop();
			_isPlaying = false;
			cPlaying = false;
		}
	}
	
	public var currentLoop (__getCurrentLoop,null) :Int;
	private function __getCurrentLoop () :Int 
	{
		return cLoop;
	}
	
	/**
	 * Set the sound source, the sound source can be a String, URLRequest, Sound or SoundChannel object
	 */
	private function __setSoundSource (s:Dynamic) :Void 
	{
		if(Std.is(s, Sound)) 
		{
			sMode = "sound";
			soundRef = s;
			if(soundRef.length > 0) duration = soundRef.length;
		}
		else if(Std.is(s, SoundChannel))
		{
			sMode = "channel";
			_isPlaying = true;
			channelRef = s;
		}
		else if(Std.is(s, String))
		{
			sMode = "url";
			urlReq = new URLRequest(s);
		}
		else
		{
			sMode = "url";
			urlReq = s;
		}
	}
	
	/**
	 * Returns the sound source, the sound source may be a URLRequest, Sound or SoundChannel object
	 */
	public var soundSource (__getSoundSource,__setSoundSource) :Dynamic;
	private function __getSoundSource () :Dynamic
	{
		switch (sMode) 
		{
			case "sound":
				return soundRef;
			case "channel":
				return channelRef;
			case "url":
				return urlReq;
			default:
				return null;
		}
	}
	
	public var soundMode (__getSoundMode,null) :String;
	public function __getSoundMode () :String 
	{
		return sMode;
	}
	
	private function updateSoundTransform (p_oScene:Scene3D) :Void 
	{
		var gv:Matrix4 = modelMatrix;
		var rv:Matrix4 = p_oScene.camera.modelMatrix;
		var dx:Float = gv.n14 - rv.n14;
		var dy:Float = gv.n24 - rv.n24;
		var dz:Float = gv.n34 - rv.n34;
		var dist:Float = Math.sqrt(dx*dx + dy*dy + dz*dz);
		
		if(dist <= 0.001) 
		{
			m_oSoundTransform.volume = soundVolume;
			m_oSoundTransform.pan = 0;
			soundCulled = false;
		}
		else if(dist <= soundRadius) 
		{
			var pa:Float = 0;
			if(soundPan) 
			{
				var d:Float = dx*rv.n11 + dy*rv.n21 + dz*rv.n31;
				var ang:Float = Math.acos(d/dist) - Math.PI/2;
				pa = - (ang/100 * (100/(Math.PI/2))) * maxPan;
				if(pa < -1) pa = -1;
				else if(pa > 1) pa = 1;
			}
			m_oSoundTransform.volume = (soundVolume/soundRadius) * (soundRadius-dist);
			m_oSoundTransform.pan = pa;
			soundCulled = false;
		}
		else 
		{
			if(!soundCulled) 
			{
				m_oSoundTransform.volume = 0;
				m_oSoundTransform.pan = 0;
				soundCulled = true;
			}
		}
	}
	
	// updates the sound channel and also set stereo panning in sound transform
	private function updateChannelRef (p_oScene:Scene3D) :Void 
	{
		
		if(stereo) 
		{
			
			var span:Float = m_oSoundTransform.pan;
			var pa:Float;
			
			if(span<0) 
			{
				pa = (span < -1) ? 1:-span;
				m_oSoundTransform.leftToLeft = 1;
				m_oSoundTransform.leftToRight = 0;
				m_oSoundTransform.rightToLeft = pa;
				m_oSoundTransform.rightToRight = 1-pa;
			}
			else
			{
				pa = (span > 1 ? 1:span);
				m_oSoundTransform.leftToLeft = 1-pa;
				m_oSoundTransform.leftToRight = pa;
				m_oSoundTransform.rightToLeft = 0;
				m_oSoundTransform.rightToRight = 1;
			}
			
			if(flipPan) 
			{
				
				var x2:Float = modelMatrix.n11;
				var y2:Float = modelMatrix.n21;
				var z2:Float = modelMatrix.n31;
				
				var gv:Matrix4 = p_oScene.camera.modelMatrix;
				var mz:Float = -(x2*gv.n11 + y2*gv.n21 + z2*gv.n31);
				
				if(mz > 0) 
				{
					
					var l2l:Float = m_oSoundTransform.leftToLeft;
					var l2r:Float = m_oSoundTransform.leftToRight;
					var r2l:Float = m_oSoundTransform.rightToLeft;
					var r2r:Float = m_oSoundTransform.rightToRight;
					
					m_oSoundTransform.leftToLeft = l2l+(l2r-l2l)*mz;
					m_oSoundTransform.leftToRight = l2r+(l2l-l2r)*mz;
					m_oSoundTransform.rightToLeft = r2l+(r2r-r2l)*mz;
					m_oSoundTransform.rightToRight = r2r+(r2l-r2r)*mz;
					_isFlipped = true;
				}
				else
				{
					_isFlipped = false;
				}
			}
		}
		
		channelRef.soundTransform = m_oSoundTransform;
	}
	
	private function soundCompleteHandler (e:Event) :Void 
	{
		if(cLoop < loops) 
		{
			cLoop++;
			cPlaying = false;
			lastPosition = loopStartTime;
			lastStopTime = flash.Lib.getTimer();
			cPlay();
			m_oEB.broadcastEvent( new BubbleEvent( LOOP, this ) );
		}
		else
		{
			if(sMode != "channel") 
			{
				_isPlaying = false;
				
				cStop();
			}
		}
	}
	
	private function completeHandler (e:Event) :Void 
	{
		duration = soundRef.length;
	}
	
	/**
	 * Play the sound if the camera enters the culling sphere with the sound radius.
	 * This method should not be called if mode is "channel"
	 * 
	 * @param	isUrl true if thr urlReq should be loaded
	 */
	private function cPlay (?isUrl:Bool) :Void 
	{
		if (isUrl == null) isUrl = false;

		if(!cPlaying) 
		{
			
			cPlaying = true;
			
			if(channelRef != null) channelRef.stop();
			
			if(isUrl) 
			{
				soundRef = new Sound();
				soundRef.addEventListener(Event.COMPLETE, completeHandler);
				soundRef.load(urlReq);
			}
			
			if(type == SPEECH) 
			{
				var len:Float = duration;
				var time:Float = startTime;
				
				if(len > 0) 
				{
					time = lastPosition + (flash.Lib.getTimer()-lastStopTime);
					if(time > len) 
					{
						var fn:Float = time/len;
						var f:Int = Std.int(fn);
						cLoop += f;
						if(cLoop>loops) 
						{
							stop();
							return;
						}
						time = fn-f == 0 ? len : time - (len*f);
					}
				}
				channelRef = soundRef.play(time, 0);
			}
			else
			{
				channelRef = soundRef.play(startTime, 0);
			}
			if(!channelRef.hasEventListener(Event.SOUND_COMPLETE))
				channelRef.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler, false, 0, true);
		}
	}
	
	private function cStop (?isUrl:Bool) :Void 
	{
		if (isUrl == null) isUrl = false;

		if(cPlaying) 
		{
			cPlaying = false;
			if(channelRef != null) 
			{
				lastPosition = channelRef.position;
				lastStopTime = flash.Lib.getTimer();
				channelRef.stop();
				channelRef.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			}
		}
	}
	
	public override function cull (p_oScene:Scene3D, p_oFrustum:Frustum, p_oViewMatrix:Matrix4, p_bChanged:Bool) :Void 
	{
		
		if(_isPlaying) 
		{
			
			updateSoundTransform(p_oScene);
			
			var isUrl:Bool = sMode == "url";
			
			if(isUrl || sMode == "sound") 
			{
				if(!soundCulled) 
				{
					if(!cPlaying) 
					{
						cPlay(isUrl);
						m_oEB.broadcastEvent( new BubbleEvent( CULL_PLAY, this ) );
					}
				}
				else
				{
					if(cPlaying) 
					{
						cStop(isUrl);
						m_oEB.broadcastEvent( new BubbleEvent( CULL_STOP, this ) );
					}
				}
			}
			
			updateChannelRef(p_oScene);
		}
	}
	
	public var soundChannel (__getSoundChannel,null) :SoundChannel;
	public function __getSoundChannel () :SoundChannel 
	{
		return channelRef;
	}
	
	public override function toString () :String 
	{
		return "sandy.core.scenegraph.Sound3D";
	}
	
}

