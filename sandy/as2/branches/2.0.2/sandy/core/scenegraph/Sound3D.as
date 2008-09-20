/*
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

import com.bourre.events.BubbleEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.EventType;

import sandy.core.Scene3D;
import sandy.core.scenegraph.ATransformable;
import sandy.core.data.Matrix4;
import sandy.view.Frustum;

/**
 * Transform audio volume and pan relative to the Camera3D 
 * 
 * @author		Daniel Reitterer - Delta 9
 * @author		(porting) Floris - xdevltd
 * @version		2.0.2
 * @date 		14.12.2007
 */
 
class sandy.core.scenegraph.Sound3D extends ATransformable
{
	
	// events
	public static var LOOP:EventType = new EventType( "loop" );
	public static var CULL_PLAY:EventType = new EventType( "cullPlay" );
	public static var CULL_STOP:EventType = new EventType( "cullStop" );
	
	// type
	public static var SPEECH:String = "speech";
	public static var NOISE:String = "noise";
	
	/**
	 * Max volume of the sound if camera position is at sound position
	 */
	public var soundVolume:Number;
	
	/**
	 * The radius of the sound
	 */
	public var soundRadius:Number;
		
	/**
	* If pan is true the panning of the sound is relative to the camera rotation
	 */
	public var soundPan:Boolean;
		
	/**
	 * Maximal pan is a positive Number from 0-1 or higher
	 */
	public var maxPan:Number;
		
	/**
	 * If the sound contains two channels, stereo have to be set to true in order to mix left and right channels correctly
	 */
	public var stereo:Boolean;
		
	/**
	 * If flipPan is true the left and right channels of the sound are mirrored if the camera is facing away from the sound
	 */
	public var flipPan:Boolean;
		
	/**
	 * Type is either SPEECH or NOISE, SPEECH will start the sound at the last position if the camera enters the sphere of the sound
	 */
	public var type:String;
		
	/**
	 * The start time to play the audio from
	 */
	public var startTime:Number;
		
	/**
	 * Number of loops before the sound stops
	 */
	public var loops:Number;
		
	/**
	 * Start time to play the audio from if the sound loops
	 */
	public var loopStartTime:Number;
	
	/**
	 * Returns true if the stereo panorama is mirrored, flipPan have to be true to enable stereo flipping
	 */
	public function get isFlipped() : Boolean
	{ 
		return _isFlipped;
	}
		
	private var _isFlipped:Boolean = false;
	private var _isPlaying:Boolean = false;
	private var soundCulled:Boolean = false;
	private var sMode:String = ""; // sound, channel or url
	private var urlReq:String;
	//private var channelRef:SoundChannel;  Flash 8 has no SoundChannel class
	private var soundRef:Sound;
	private var lastPosition:Number = 0;
	private var lastStopTime:Number = 0;
	private var cPlaying:Boolean = false;
	private var duration:Number = 0;
	private var cLoop:Number = 0;
	
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
	public function Sound3D( p_sName:String , p_oSoundSource, p_nVolume:Number, 
							p_nMaxPan:Number, p_nRadius:Number, p_bStereo:Boolean ) 
	{
		super( p_sName||"" );
		
		soundPan = true;
		maxPan = 1;
		stereo = false;
		flipPan = true;
		type = SPEECH;
		startTime = 0;
		loops = 0xffffff;
		loopStartTime = 0;
		
		soundVolume = p_nVolume||1;
		soundRadius = p_nRadius||1;
		soundSource = p_oSoundSource;
		stereo = p_bStereo||false;
		p_nMaxPan = p_nMaxPan||0;
		
		if( p_nMaxPan == 0 ) 
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
	public function play( p_nStartTime:Number, p_iLoops:Number, p_nLoopStartTime:Number, p_bResume:Boolean ) : Void 
	{
		if( !_isPlaying ) 
		{
			if( p_nStartTime != -1 and p_nStartTime ) lastPosition = p_nStartTime;
			if( p_iLoops != -1 and p_iLoops ) loops = p_iLoops;
			if( p_nLoopStartTime != -1 and p_nLoopStartTime ) loopStartTime = p_nLoopStartTime;
			
			if( !p_bResume ) 
			{
				lastPosition = startTime;
				lastStopTime = getTimer();
			}
			cLoop = 0;
			_isPlaying = true;
			cPlaying = false;
		}
	}
	
	/**
	 * Stop the sound source and SoundChannel
	 */
	public function stop() : Void 
	{
		if( _isPlaying && sMode != "channel" ) 
		{
			if( cPlaying ) cStop();
			_isPlaying = false;
			cPlaying = false;
		}
	}
	
	public function get currentLoop () : Number 
	{
		return int( cLoop );
	}
	
	/**
	 * Set the sound source, the sound source can be a String, URLRequest, Sound or SoundChannel object
	 */
	public function set soundSource( s ) : Void 
	{
		if( s instanceof Sound ) 
		{
			sMode = "sound";
			soundRef = Sound( s );
			if( soundRef.duration > 0 ) duration = soundRef.duration;
		}
		else if( s instanceof String ) 
		{
			sMode = "url";
			urlReq = s;
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
	public function get soundSource() 
	{
		return soundRef;
	}
	
	public function get soundMode() : String 
	{
		return sMode;
	}
		
	private function updateSoundTransform( p_oScene:Scene3D ) : Void 
	{
		var gv:Matrix4 = modelMatrix;
		var rv:Matrix4 = p_oScene.camera.modelMatrix;
		var dx:Number = gv.n14 - rv.n14;
		var dy:Number = gv.n24 - rv.n24;
		var dz:Number = gv.n34 - rv.n34;
		var dist:Number = Math.sqrt( dx * dx + dy * dy + dz * dz );
		
		if( dist <= 0.001 ) 
		{
			soundRef.setVolume( soundVolume );
			soundRef.setPan( 0 );
			soundCulled = false;
		}
		else if( dist <= soundRadius ) 
		{
			var pa:Number = 0;
			if( soundPan ) 
			{
				var d:Number = dx * rv.n11 + dy * rv.n21 + dz * rv.n31;
				var ang:Number = Math.acos( d / dist ) - Math.PI / 2;
				pa = - ( ang / 100 * ( 100 / ( Math.PI / 2 ) ) ) * maxPan;
				if( pa < -1 ) pa = -1;
				else if( pa > 1 ) pa = 1;
			}
			soundRef.setVolume( ( soundVolume / soundRadius ) * ( soundRadius - dist ) );
			soundRef.setPan( pa );
			soundCulled = false;
		}
		else 
		{
			if( !soundCulled ) 
			{
				soundRef.setVolume( 0 );
				soundRef.setPan( 0 );
				soundCulled = true;
			}
		}
	}
	
	/**
	 * The updateSoundChannelTransform function isn't ported, because AS2 doesn't have a SoundChannel class. 
	 */
		
	private function soundCompleteHandler( e:EventType ) : Void 
	{
		if( cLoop < loops ) 
		{
			cLoop++;
			cPlaying = false;
			lastPosition = loopStartTime;
			lastStopTime = getTimer();
			cPlay();
			m_oEB.broadcastEvent( new BubbleEvent( LOOP, this ) );
		}
		else
		{
			if( sMode != "channel" ) 
			{
				_isPlaying = false;
				
				cStop();
			}
		}
	}
		
	private function completeHandler( e:EventType ) : Void 
	{
		duration = soundRef.duration;
	}
	
	/**
	 * Play the sound if the camera enters the culling sphere with the sound radius.
	 * This method should not be called if mode is "channel"
	 * 
	 * @param	isUrl true if thr urlReq should be loaded
	 */
	private function cPlay( isUrl:Boolean ) : Void 
	{
		if( !cPlaying ) 
		{
			
			cPlaying = true;
			
			if( soundRef != null ) soundRef.stop();
			
			if( isUrl ) 
			{
				soundRef = new Sound();
				soundRef.onLoad = completeHandler;
				soundRef.loadSound( urlReq );
			}
				
			if( type == SPEECH ) 
			{
				var len:Number = duration;
				var time:Number = startTime;
				
				if( len > 0 ) 
				{
					time = lastPosition + ( getTimer() - lastStopTime );
					if( time > len ) 
					{
						var fn:Number = time / len;
						var f:Number = int( fn );
						cLoop += f;
						if( cLoop > loops ) 
						{
							stop();
							return;
						}
						time = fn - f == 0 ? len : time - ( len * f );
					}
				}
				soundRef.start( time, 0 );
			}
			else
			{
				soundRef.start( startTime, 0 );
			}
		}
	}
		
	private function cStop( isUrl:Boolean ) : Void 
	{
		if( cPlaying ) 
		{
			cPlaying = false;
			
			lastPosition = soundRef.position;
			lastStopTime = getTimer();
			soundRef.stop();
			soundRef.onSoundComplete = null;
		}
	}
	
	public function cull( p_oScene:Scene3D, p_oFrustum:Frustum, p_oViewMatrix:Matrix4, p_bChanged:Boolean ) : Void 
	{
		if( _isPlaying ) 
		{
			updateSoundTransform( p_oScene );
			
			var isUrl:Boolean = sMode == "url";
			
			if( isUrl||sMode == "sound" ) 
			{
				if( !soundCulled ) 
				{
					if( !cPlaying ) 
					{
						cPlay( isUrl );
						m_oEB.broadcastEvent( new BubbleEvent( CULL_PLAY, this ) );
					}
				}
				else
				{
					if( cPlaying ) 
					{
						cStop( isUrl );
						m_oEB.broadcastEvent( new BubbleEvent( CULL_STOP, this ) );
					}
				}
			}
			
		}
	}
	
	public function toString() : String 
	{
		return "sandy.core.scenegraph.Sound3D";
	}
	
}