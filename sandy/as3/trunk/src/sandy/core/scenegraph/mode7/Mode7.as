package sandy.core.scenegraph.mode7
{
	import flash.display.BitmapData;	import flash.display.Sprite;	import flash.geom.Matrix;		import sandy.core.data.Matrix4;	import sandy.view.Frustum;	import sandy.core.scenegraph.Node;	import sandy.core.scenegraph.IDisplayable;	import sandy.core.scenegraph.Renderable;	import sandy.core.scenegraph.Camera3D;	import sandy.core.scenegraph.mode7.CameraMode7;
	public class Mode7 extends Node implements Renderable, IDisplayable
	{
		private var _width : Number;
		private var _height : Number;
		private var _container : Sprite = new Sprite();
		private var _numLines : int;
		private var _camera : CameraMode7;
		private var _fov : Number;
		private var _near : Number;
		private var _far : Number;
		private var _useCameraNearFar : Boolean;
		private var _ratioWidthHeight : Number;
		private var _altitude : Number;
		private var _camTiltRadian : Number;
		private var _horizon : Number;
		private var _traceHorizon : Boolean;
		private var _colorHorizon : int;
		private var _widthHorizon : Number;
		private var _mapOriginal : BitmapData;
		private var _scaleMap : Number;
		private var _repeatMap : Boolean;
		private var _smooth : Boolean;
		private var _centerMapMatrix : Matrix;
		private var _mapMatrix : Matrix;
		private var _lineMatrix : Matrix;
		private var _yMax : Number;
		private var _yMin : Number;
		private var _length : Number;
		private var _yMaxTilted : Number;
		private var _yMinTilted : Number;
		private var _yLength : Number;
		private var _yStep : Number;
		private var _yCurrent : Number;
		private var _zMax : Number;
		private var _zMin : Number;
		private var _zMaxTilted : Number;
		private var _zMinTilted : Number;
		private var _zLength : Number;
		private var _zStep : Number;
		private var _zCurrent : Number;
		private var _t : Number;
		private var _xAmplitude : Number;
		private var _xAmplitudePrev : Number;
		private var _xAmplitudeAvg : Number;
		private var _zAmplitude : Number;
		private var _zProj : Number;
		private var _zProjPrev : Number;
		private var _prevOK : Boolean;
		private const PI : Number = Math.PI;
		private const PIon180 : Number = PI / 180;
		private const cos : Function = Math.cos;
		private const sin : Function = Math.sin;
		private const tan : Function = Math.tan;
		public function Mode7()
		{
			_useCameraNearFar = true;
			_lineMatrix = new Matrix();
			setHorizon();
		}
		public var precision:Number = 1;
		
		// getters and setters //
		public function get smooth() : Boolean		
		{		
			return _smooth;		
		}
		public function set smooth(value : Boolean) : void	
		{		
			_smooth = value;		
		}
		public function get repeatMap() : Boolean		
		{		
			return _repeatMap;		
		}
		public function set repeatMap(value : Boolean) : void		
		{		
			_repeatMap = value;		
		}
		public function setBitmap(bmp : BitmapData, scale : Number = 1, repeatMap : Boolean = true, smooth : Boolean = false) : void
		{
			_mapOriginal = bmp;
			_scaleMap = scale;
			_repeatMap = repeatMap;
			_smooth = smooth;
			_centerMapMatrix = new Matrix();
			_centerMapMatrix.translate(-bmp.width / 2, -bmp.height / 2);
			_centerMapMatrix.scale(_scaleMap, -_scaleMap);
			_mapMatrix = new Matrix();
		}
				public function setHorizon(traceHorizon : Boolean = true, colorHorizon : int = 0x000000, horizonWidth : Number = 1) : void
		{
			_traceHorizon = traceHorizon;
			_colorHorizon = colorHorizon;
			_widthHorizon = horizonWidth;
		}
		public function getHorizon() : Number			
		{		
			return _horizon;			
		}
		public function setNearFar(fromCamera : Boolean, near : Number = 1 , far : Number = 1000 ) : void
		{
			_useCameraNearFar = fromCamera;
			if (!_useCameraNearFar)
			{
				_near = near;
				_far = far;
			}
		}				public function clear():void		{			_container.graphics.clear();		}				// The container of this object		public function get container():Sprite		{			return _container;		}		// The depth of this object		public function get depth():Number		{			return -Number.MAX_VALUE;		}
		public override function cull( p_oFrustum:Frustum, p_oViewMatrix:Matrix4, p_bChanged:Boolean ):void		{			super.cull( p_oFrustum, p_oViewMatrix, p_bChanged );			// check if we need to resize our canvas			scene.renderer.addToDisplayList( this ); 		}				public function display( p_oContainer:Sprite = null  ):void		{			_prevOK = false;			var i:int, di:int = 1, di_1:int;			for (i = 0; i <= _numLines; i += di)			{				_yCurrent = _altitude + _yMinTilted + i * _yStep;				_zCurrent = _zMinTilted + i * _zStep;								if (_yCurrent - _altitude != 0)				{					_t = -_altitude / (_yCurrent - _altitude);					if (_t >= _near)					{						_zProj = _t * _zCurrent;						_xAmplitude = _t * _ratioWidthHeight * _length;						if (_prevOK)						{							if (_t <= _far)							{								// TODO top-down order? for this is fucking backwards.								if (_xAmplitude - _xAmplitudePrev < precision) {
									i -=di; di++; continue;
								} else {
									if (di > 1) di_1 = di - 1;
								}
								_zAmplitude =  (_zProj - _zProjPrev) / di;
								_xAmplitudeAvg = ( _xAmplitude + _xAmplitudePrev) / 2;								_lineMatrix.identity();								_lineMatrix.concat(_mapMatrix);								_lineMatrix.translate(_xAmplitudeAvg / 2, (i - _height) * _zAmplitude - _zProj);								_lineMatrix.scale(_width / _xAmplitudeAvg, -1 / _zAmplitude);								_container.graphics.beginBitmapFill(_mapOriginal, _lineMatrix, _repeatMap, _smooth);								_container.graphics.drawRect(0, _height - i, _width, di);
								_container.graphics.endFill();								di = di_1;
							}							else							{								break;							}						}						_zProjPrev = _zProj;						_xAmplitudePrev = _xAmplitude;						_prevOK = true;					}				}			}						if (_traceHorizon)			{				_container.graphics.lineStyle(_widthHorizon, _colorHorizon);				_container.graphics.moveTo(0, _horizon);				_container.graphics.lineTo(_width, _horizon);			}		}				public function render( p_oCamera:Camera3D ):void		{			if( !(p_oCamera is CameraMode7) )				return;			
			_camera = p_oCamera as CameraMode7;
			_width = p_oCamera.viewport.width;
			_height = p_oCamera.viewport.height;
			_ratioWidthHeight = _width / _height;
			_numLines = _height;
			// --
			_mapMatrix.identity();
			_mapMatrix.concat(_centerMapMatrix);
			_mapMatrix.translate(-_camera.x, -_camera.z);
			_mapMatrix.rotate(-PIon180 * _camera.rotateY);
			
			_fov = PIon180 * _camera.fov;
			if (_useCameraNearFar)
			{
				_near = _camera.near;
				_far = _camera.far;
			}
			_altitude = _camera.y;
			_camTiltRadian = PIon180 * _camera.tilt;
			
			_yMax = 1 / tan((PI - _fov) / 2);
			_yMin = -_yMax;
			_length = _yMax - _yMin;
			_zMax = 1;
			_zMin = 1;
			_yMaxTilted = _zMax * sin(-_camTiltRadian) + _yMax * cos(-_camTiltRadian);
			_zMaxTilted = _zMax * cos(-_camTiltRadian) - _yMax * sin(-_camTiltRadian);
			_yMinTilted = _zMin * sin(-_camTiltRadian) + _yMin * cos(-_camTiltRadian);
			_zMinTilted = _zMin * cos(-_camTiltRadian) - _yMin * sin(-_camTiltRadian);
			_yLength = _yMaxTilted - _yMinTilted;
			_yStep = _yLength / _numLines;
			_zLength = _zMaxTilted - _zMinTilted;
			_zStep = _zLength / _numLines;
			
			if (_yMaxTilted - _yMinTilted == 0)
			{
				if (_zMinTilted < _zMaxTilted)
				{
					_horizon = Number.NEGATIVE_INFINITY;
				}
				else if (_zMinTilted > _zMaxTilted)
				{
					_horizon = Number.POSITIVE_INFINITY;
				}
			}
			else
			{
				_horizon = _height * _yMaxTilted / (_yMaxTilted - _yMinTilted);
			}
			_camera.horizon = _horizon;			
		}
	}
}

