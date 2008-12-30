$estr = function() { return js.Boot.__string_rec(this,''); }
sandy = {}
sandy.materials = {}
sandy.materials.attributes = {}
sandy.materials.attributes.IAttributes = function() { }
sandy.materials.attributes.IAttributes.__name__ = ["sandy","materials","attributes","IAttributes"];
sandy.materials.attributes.IAttributes.prototype.__getFlags = null;
sandy.materials.attributes.IAttributes.prototype.begin = null;
sandy.materials.attributes.IAttributes.prototype.draw = null;
sandy.materials.attributes.IAttributes.prototype.drawOnSprite = null;
sandy.materials.attributes.IAttributes.prototype.finish = null;
sandy.materials.attributes.IAttributes.prototype.flags = null;
sandy.materials.attributes.IAttributes.prototype.init = null;
sandy.materials.attributes.IAttributes.prototype.unlink = null;
sandy.materials.attributes.IAttributes.prototype.__class__ = sandy.materials.attributes.IAttributes;
sandy.materials.attributes.AAttributes = function(p) { if( p === $_ ) return; {
	this.m_nFlags = 0;
}}
sandy.materials.attributes.AAttributes.__name__ = ["sandy","materials","attributes","AAttributes"];
sandy.materials.attributes.AAttributes.prototype.__getFlags = function() {
	return this.m_nFlags;
}
sandy.materials.attributes.AAttributes.prototype.begin = function(p_oScene) {
	null;
}
sandy.materials.attributes.AAttributes.prototype.draw = function(p_oGraphics,p_oPolygon,p_oMaterial,p_oScene) {
	null;
}
sandy.materials.attributes.AAttributes.prototype.drawOnSprite = function(p_oSprite,p_oMaterial,p_oScene) {
	null;
}
sandy.materials.attributes.AAttributes.prototype.finish = function(p_oScene) {
	null;
}
sandy.materials.attributes.AAttributes.prototype.flags = null;
sandy.materials.attributes.AAttributes.prototype.init = function(p_oPolygon) {
	null;
}
sandy.materials.attributes.AAttributes.prototype.m_nFlags = null;
sandy.materials.attributes.AAttributes.prototype.unlink = function(p_oPolygon) {
	null;
}
sandy.materials.attributes.AAttributes.prototype.__class__ = sandy.materials.attributes.AAttributes;
sandy.materials.attributes.AAttributes.__interfaces__ = [sandy.materials.attributes.IAttributes];
sandy.materials.attributes.LineAttributes = function(p_nThickness,p_nColor,p_nAlpha) { if( p_nThickness === $_ ) return; {
	if(p_nAlpha == null) p_nAlpha = 1.0;
	if(p_nColor == null) p_nColor = 1;
	if(p_nThickness == null) p_nThickness = 1.0;
	this.m_nThickness = p_nThickness;
	this.m_nAlpha = p_nAlpha;
	this.m_nColor = p_nColor;
	this.modified = true;
	sandy.materials.attributes.AAttributes.apply(this,[]);
}}
sandy.materials.attributes.LineAttributes.__name__ = ["sandy","materials","attributes","LineAttributes"];
sandy.materials.attributes.LineAttributes.__super__ = sandy.materials.attributes.AAttributes;
for(var k in sandy.materials.attributes.AAttributes.prototype ) sandy.materials.attributes.LineAttributes.prototype[k] = sandy.materials.attributes.AAttributes.prototype[k];
sandy.materials.attributes.LineAttributes.prototype.__getAlpha = function() {
	return this.m_nAlpha;
}
sandy.materials.attributes.LineAttributes.prototype.__getColor = function() {
	return this.m_nColor;
}
sandy.materials.attributes.LineAttributes.prototype.__getThickness = function() {
	return this.m_nThickness;
}
sandy.materials.attributes.LineAttributes.prototype.__setAlpha = function(p_nValue) {
	this.m_nAlpha = p_nValue;
	this.modified = true;
	return p_nValue;
}
sandy.materials.attributes.LineAttributes.prototype.__setColor = function(p_nValue) {
	this.m_nColor = p_nValue;
	this.modified = true;
	return p_nValue;
}
sandy.materials.attributes.LineAttributes.prototype.__setThickness = function(p_nValue) {
	this.m_nThickness = p_nValue;
	this.modified = true;
	return p_nValue;
}
sandy.materials.attributes.LineAttributes.prototype.alpha = null;
sandy.materials.attributes.LineAttributes.prototype.color = null;
sandy.materials.attributes.LineAttributes.prototype.draw = function(p_oGraphics,p_oPolygon,p_oMaterial,p_oScene) {
	var l_aPoints = ((p_oPolygon.isClipped)?p_oPolygon.cvertices:p_oPolygon.vertices);
	var l_oVertex;
	p_oGraphics.lineStyle(this.m_nThickness,this.m_nColor,this.m_nAlpha);
	p_oGraphics.moveTo(l_aPoints[0].sx,l_aPoints[0].sy);
	var lId = l_aPoints.length;
	while((l_oVertex = l_aPoints[--lId]) != null) {
		p_oGraphics.lineTo(l_oVertex.sx,l_oVertex.sy);
	}
}
sandy.materials.attributes.LineAttributes.prototype.m_nAlpha = null;
sandy.materials.attributes.LineAttributes.prototype.m_nColor = null;
sandy.materials.attributes.LineAttributes.prototype.m_nThickness = null;
sandy.materials.attributes.LineAttributes.prototype.modified = null;
sandy.materials.attributes.LineAttributes.prototype.thickness = null;
sandy.materials.attributes.LineAttributes.prototype.__class__ = sandy.materials.attributes.LineAttributes;
sandy.materials.attributes.LineAttributes.__interfaces__ = [sandy.materials.attributes.IAttributes];
sandy.util = {}
sandy.util.NumberUtil = function() { }
sandy.util.NumberUtil.__name__ = ["sandy","util","NumberUtil"];
sandy.util.NumberUtil.TWO_PI = null;
sandy.util.NumberUtil.__getTWO_PI = function() {
	return sandy.util.NumberUtil.__TWO_PI;
}
sandy.util.NumberUtil.PI = null;
sandy.util.NumberUtil.__getPI = function() {
	return sandy.util.NumberUtil.__PI;
}
sandy.util.NumberUtil.HALF_PI = null;
sandy.util.NumberUtil.__getHALF_PI = function() {
	return sandy.util.NumberUtil.__HALF_PI;
}
sandy.util.NumberUtil.TO_DEGREE = null;
sandy.util.NumberUtil.__getTO_DEGREE = function() {
	return sandy.util.NumberUtil.__TO_DREGREE;
}
sandy.util.NumberUtil.TO_RADIAN = null;
sandy.util.NumberUtil.__getTO_RADIAN = function() {
	return sandy.util.NumberUtil.__TO_RADIAN;
}
sandy.util.NumberUtil.isZero = function(p_nN) {
	return Math.abs(p_nN) < sandy.util.NumberUtil.TOL;
}
sandy.util.NumberUtil.areEqual = function(p_nN,p_nM) {
	return Math.abs(p_nN - p_nM) < sandy.util.NumberUtil.TOL;
}
sandy.util.NumberUtil.toDegree = function(p_nRad) {
	return p_nRad * sandy.util.NumberUtil.__getTO_DEGREE();
}
sandy.util.NumberUtil.toRadian = function(p_nDeg) {
	return p_nDeg * sandy.util.NumberUtil.__getTO_RADIAN();
}
sandy.util.NumberUtil.constrain = function(p_nN,p_nMin,p_nMax) {
	return Math.max(Math.min(p_nN,p_nMax),p_nMin);
}
sandy.util.NumberUtil.roundTo = function(p_nN,p_nRoundToInterval) {
	if(p_nRoundToInterval == 0) {
		p_nRoundToInterval = 1;
	}
	return Math.round(p_nN / p_nRoundToInterval) * p_nRoundToInterval;
}
sandy.util.NumberUtil.prototype.__class__ = sandy.util.NumberUtil;
neash = {}
neash.net = {}
neash.net.URLRequest = function(inURL) { if( inURL === $_ ) return; {
	if(inURL != null) this.url = inURL;
}}
neash.net.URLRequest.__name__ = ["neash","net","URLRequest"];
neash.net.URLRequest.prototype.url = null;
neash.net.URLRequest.prototype.__class__ = neash.net.URLRequest;
neash.events = {}
neash.events.IEventDispatcher = function() { }
neash.events.IEventDispatcher.__name__ = ["neash","events","IEventDispatcher"];
neash.events.IEventDispatcher.prototype.RemoveByID = null;
neash.events.IEventDispatcher.prototype.addEventListener = null;
neash.events.IEventDispatcher.prototype.dispatchEvent = null;
neash.events.IEventDispatcher.prototype.hasEventListener = null;
neash.events.IEventDispatcher.prototype.removeEventListener = null;
neash.events.IEventDispatcher.prototype.willTrigger = null;
neash.events.IEventDispatcher.prototype.__class__ = neash.events.IEventDispatcher;
neash.events.EventDispatcher = function(target) { if( target === $_ ) return; {
	this.mTarget = target;
	this.mEventMap = new Hash();
}}
neash.events.EventDispatcher.__name__ = ["neash","events","EventDispatcher"];
neash.events.EventDispatcher.prototype.DumpListeners = function() {
	haxe.Log.trace(this.mEventMap,{ fileName : "EventDispatcher.hx", lineNumber : 140, className : "neash.events.EventDispatcher", methodName : "DumpListeners"});
}
neash.events.EventDispatcher.prototype.RemoveByID = function(inType,inID) {
	if(!this.mEventMap.exists(inType)) return;
	var list = this.mEventMap.get(inType);
	{
		var _g1 = 0, _g = list.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(list[i].mID == inID) {
				list.splice(i,1);
				return;
			}
		}
	}
	haxe.Log.trace("could not remove?",{ fileName : "EventDispatcher.hx", lineNumber : 129, className : "neash.events.EventDispatcher", methodName : "RemoveByID"});
}
neash.events.EventDispatcher.prototype.addEventListener = function(type,inListener,useCapture,inPriority,useWeakReference) {
	var capture = (useCapture == null?false:useCapture);
	var priority = (inPriority == null?0:inPriority);
	var list = this.mEventMap.get(type);
	if(list == null) {
		list = new Array();
		this.mEventMap.set(type,list);
	}
	var l = new neash.events.Listener(inListener,capture,priority);
	list.push(l);
	return l.mID;
}
neash.events.EventDispatcher.prototype.dispatchEvent = function(event) {
	var list = this.mEventMap.get(event.type);
	var capture = event.eventPhase == neash.events.EventPhase.CAPTURING_PHASE;
	if(list != null) {
		{
			var _g1 = 0, _g = list.length;
			while(_g1 < _g) {
				var i = _g1++;
				var listener = list[i];
				if(listener.mUseCapture == capture) {
					listener.dispatchEvent(event);
					if(event.IsCancelledNow()) return true;
				}
			}
		}
		return true;
	}
	return false;
}
neash.events.EventDispatcher.prototype.hasEventListener = function(type) {
	return this.mEventMap.exists(type);
}
neash.events.EventDispatcher.prototype.mEventMap = null;
neash.events.EventDispatcher.prototype.mTarget = null;
neash.events.EventDispatcher.prototype.removeEventListener = function(type,listener,inCapture) {
	if(!this.mEventMap.exists(type)) return;
	var list = this.mEventMap.get(type);
	var capture = (inCapture == null?false:inCapture);
	{
		var _g1 = 0, _g = list.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(list[i].Is(listener,capture)) {
				list.splice(i,1);
				return;
			}
		}
	}
}
neash.events.EventDispatcher.prototype.willTrigger = function(type) {
	return this.hasEventListener(type);
}
neash.events.EventDispatcher.prototype.__class__ = neash.events.EventDispatcher;
neash.events.EventDispatcher.__interfaces__ = [neash.events.IEventDispatcher];
neash.display = {}
neash.display.DisplayObject = function(p) { if( p === $_ ) return; {
	this.mParent = null;
	neash.events.EventDispatcher.apply(this,[]);
	this.mX = this.mY = 0;
	this.mScaleX = this.mScaleY = 1.0;
	this.alpha = 1.0;
	this.mTransformed = false;
	this.mRotation = 0.0;
	this.__swf_depth = 0;
	this.mMatrix = new canvas.geom.Matrix();
	this.mFullMatrix = new canvas.geom.Matrix();
	this.mMask = null;
	this.mMaskingObj = null;
	this.mCacheAsBitmap = false;
	this.mCachedBitmap = null;
	this.mFilteredBitmap = null;
	this.mCachedBitmapTx = 0;
	this.mCachedBitmapTy = 0;
	this.mBoundsDirty = false;
	this.mBoundsRect = new canvas.geom.Rectangle();
	this.mGraphicsBounds = null;
	this.mMaskHandle = null;
	this.mChanged = true;
	this.visible = true;
}}
neash.display.DisplayObject.__name__ = ["neash","display","DisplayObject"];
neash.display.DisplayObject.__super__ = neash.events.EventDispatcher;
for(var k in neash.events.EventDispatcher.prototype ) neash.display.DisplayObject.prototype[k] = neash.events.EventDispatcher.prototype[k];
neash.display.DisplayObject.prototype.AppendMask = function(inMask) {
	var gfx = this.GetGraphics();
	if(gfx != null) gfx.AddToMask(inMask,this.mFullMatrix);
}
neash.display.DisplayObject.prototype.AsContainer = function() {
	return null;
}
neash.display.DisplayObject.prototype.AsInteractiveObject = function() {
	return null;
}
neash.display.DisplayObject.prototype.BuildBounds = function() {
	if(this.mBoundsDirty) {
		this.mBoundsDirty = false;
		var gfx = this.GetGraphics();
		if(gfx == null) this.mBoundsRect = new canvas.geom.Rectangle(this.mFullMatrix.tx,this.mFullMatrix.ty,0,0);
		else this.mBoundsRect = gfx.GetExtent(this.mFullMatrix);
	}
}
neash.display.DisplayObject.prototype.CacheGetObj = function(inX,inY,inObj) {
	var tx = Std["int"](this.mFullMatrix.tx + this.mCachedBitmapTx + 0.5);
	var ty = Std["int"](this.mFullMatrix.ty + this.mCachedBitmapTy + 0.5);
	if(inX >= tx && inY >= ty && inX < tx + this.mCachedBitmap.getWidth() && inY < ty + this.mCachedBitmap.getHeight()) {
		var i = this.AsInteractiveObject();
		return (i == null?inObj:i);
	}
	return null;
}
neash.display.DisplayObject.prototype.ClearCache = function() {
	this.mCachedBitmap = null;
	this.mFilteredBitmap = null;
}
neash.display.DisplayObject.prototype.CreateBitmapCache = function() {
	throw "Not implemented. CreateBitmapCache.";
}
neash.display.DisplayObject.prototype.DoAdded = function(inObj) {
	if(inObj == this) {
		var evt = new neash.events.Event(neash.events.Event.ADDED,true,false);
		this.dispatchEvent(evt);
	}
	var evt = new neash.events.Event(neash.events.Event.ADDED_TO_STAGE,false,false);
	this.dispatchEvent(evt);
}
neash.display.DisplayObject.prototype.DoMouseEnter = function() {
	null;
}
neash.display.DisplayObject.prototype.DoMouseLeave = function() {
	null;
}
neash.display.DisplayObject.prototype.DoRemoved = function(inObj) {
	if(inObj == this) {
		var evt = new neash.events.Event(neash.events.Event.REMOVED,true,false);
		this.dispatchEvent(evt);
	}
	var evt = new neash.events.Event(neash.events.Event.REMOVED_FROM_STAGE,false,false);
	this.dispatchEvent(evt);
}
neash.display.DisplayObject.prototype.GetBackgroundRect = function() {
	if(this.mGraphicsBounds == null) {
		var gfx = this.GetGraphics();
		if(gfx != null) this.mGraphicsBounds = gfx.GetExtent(new canvas.geom.Matrix());
	}
	return this.mGraphicsBounds;
}
neash.display.DisplayObject.prototype.GetCacheAsBitmap = function() {
	return this.mCacheAsBitmap || (this.mFilters != null);
}
neash.display.DisplayObject.prototype.GetFilters = function() {
	var f = new Array();
	if(this.mFilters != null) {
		{
			var _g = 0, _g1 = this.mFilters;
			while(_g < _g1.length) {
				var filter = _g1[_g];
				++_g;
				f.push(filter.clone());
			}
		}
	}
	return f;
}
neash.display.DisplayObject.prototype.GetFocusObjects = function(outObjs) {
	null;
}
neash.display.DisplayObject.prototype.GetGraphics = function() {
	return null;
}
neash.display.DisplayObject.prototype.GetHeight = function() {
	this.BuildBounds();
	return this.mBoundsRect.height;
}
neash.display.DisplayObject.prototype.GetMask = function() {
	return this.mMask;
}
neash.display.DisplayObject.prototype.GetMaskHandle = function() {
	if(this.mMaskingObj == null) throw ("mask object mismatch");
	if(this.mMaskHandle == null) {
		var gfx = this.GetGraphics();
		if(gfx != null) {
			this.mMaskHandle = gfx.CreateMask(this.mFullMatrix);
		}
	}
	return this.mMaskHandle;
}
neash.display.DisplayObject.prototype.GetMatrix = function() {
	return this.mMatrix.clone();
}
neash.display.DisplayObject.prototype.GetMouseX = function() {
	return this.globalToLocal(neash.Lib.mLastMouse).x;
}
neash.display.DisplayObject.prototype.GetMouseY = function() {
	return this.globalToLocal(neash.Lib.mLastMouse).y;
}
neash.display.DisplayObject.prototype.GetObj = function(inX,inY,inObj) {
	if(!this.visible || this.mMaskingObj != null) return null;
	if(this.GetCacheAsBitmap() && this.mCachedBitmap != null) return this.CacheGetObj(inX,inY,inObj);
	var gfx = this.GetGraphics();
	if(gfx != null && gfx.hitTest(inX,inY)) {
		var i = this.AsInteractiveObject();
		return (i == null?inObj:i);
	}
	return null;
}
neash.display.DisplayObject.prototype.GetOpaqueBackground = function() {
	return this.mOpaqueBackground;
}
neash.display.DisplayObject.prototype.GetParent = function() {
	return this.mParent;
}
neash.display.DisplayObject.prototype.GetRotation = function() {
	return this.mRotation;
}
neash.display.DisplayObject.prototype.GetScaleX = function() {
	return this.mScaleX;
}
neash.display.DisplayObject.prototype.GetScaleY = function() {
	return this.mScaleY;
}
neash.display.DisplayObject.prototype.GetScrollRect = function() {
	if(this.mScrollRect == null) return null;
	return this.mScrollRect.clone();
}
neash.display.DisplayObject.prototype.GetStage = function() {
	return neash.Lib.GetStage();
}
neash.display.DisplayObject.prototype.GetTransform = function() {
	if(this._transform == null) return this._transform = new neash.geom.Transform(this);
	else return this._transform;
}
neash.display.DisplayObject.prototype.GetWidth = function() {
	this.BuildBounds();
	return this.mBoundsRect.width;
}
neash.display.DisplayObject.prototype.GetX = function() {
	return this.mX;
}
neash.display.DisplayObject.prototype.GetY = function() {
	return this.mY;
}
neash.display.DisplayObject.prototype.Render = function(inParentMask,inScrollRect,inTX,inTY) {
	var mask_handle = (inParentMask != null?inParentMask:((this.mMask != null?this.mMask.GetMaskHandle():null)));
	if(this.GetCacheAsBitmap() && this.mCachedBitmap != null) this.RenderCache(mask_handle);
	else {
		if(this.mOpaqueBackground != null) {
			var bg = this.GetBackgroundRect();
			if(bg != null) {
				var gfx = canvas.Manager.graphics;
				canvas.display.Graphics.immediateMatrix = this.mFullMatrix;
				canvas.display.Graphics.immediateMask = mask_handle;
				gfx.beginFill(this.mOpaqueBackground);
				gfx.drawRect(bg.x,bg.y,bg.width,bg.height);
				gfx.endFill();
				gfx.flush();
				canvas.display.Graphics.immediateMatrix = null;
				canvas.display.Graphics.immediateMask = null;
			}
		}
		var gfx = this.GetGraphics();
		if(gfx != null) {
			if(inScrollRect != null) {
				var m = this.mFullMatrix.clone();
				m.tx -= inTX;
				m.ty -= inTY;
				gfx.render(m,null,mask_handle,inScrollRect);
			}
			else gfx.render(this.mFullMatrix,null,mask_handle,null);
		}
	}
	return mask_handle;
}
neash.display.DisplayObject.prototype.RenderCache = function(inMaskHandle) {
	var tx = Std["int"](this.mFullMatrix.tx + this.mCachedBitmapTx + 0.5);
	var ty = Std["int"](this.mFullMatrix.ty + this.mCachedBitmapTy + 0.5);
	var gfx = canvas.Manager.graphics;
	if(this.mFilterSet != null) {
		if(this.mFilteredBitmap == null) this.mFilteredBitmap = this.mFilterSet.FilterImage(this.mCachedBitmap);
		gfx.moveTo(tx + this.mFilterSet.GetOffsetX(),ty + this.mFilterSet.GetOffsetY());
		gfx.blit(this.mFilteredBitmap);
	}
	else {
		gfx.moveTo(tx,ty);
		gfx.blit(this.mCachedBitmap);
	}
}
neash.display.DisplayObject.prototype.SetCacheAsBitmap = function(inVal) {
	this.mCacheAsBitmap = inVal;
	var c = this.GetCacheAsBitmap();
	if(!c) this.ClearCache();
	return c;
}
neash.display.DisplayObject.prototype.SetFilters = function(inFilters) {
	var f = new Array();
	{
		var _g = 0;
		while(_g < inFilters.length) {
			var filter = inFilters[_g];
			++_g;
			f.push(filter.clone());
		}
	}
	this.mFilters = f;
	this.mCacheAsBitmap = null;
	this.mFilteredBitmap = null;
	if(this.mFilters.length < 1) this.mFilterSet = null;
	else this.mFilterSet = new canvas.filters.FilterSet(this.mFilters);
	return this.GetFilters();
}
neash.display.DisplayObject.prototype.SetHeight = function(inHeight) {
	this.BuildBounds();
	var h = this.mBoundsRect.height;
	if(h <= 0) return 0;
	this.mScaleY *= inHeight / h;
	this.UpdateMatrix();
	return inHeight;
}
neash.display.DisplayObject.prototype.SetMask = function(inMask) {
	if(this.mMask != null) this.mMask.mMaskingObj = null;
	this.mMask = inMask;
	if(this.mMask != null) this.mMask.mMaskingObj = this;
	return this.mMask;
}
neash.display.DisplayObject.prototype.SetMatrix = function(inMatrix) {
	this.mMatrix = inMatrix.clone();
	this.mTransformed = true;
	return inMatrix;
}
neash.display.DisplayObject.prototype.SetOpaqueBackground = function(inBG) {
	this.mOpaqueBackground = inBG;
	return this.mOpaqueBackground;
}
neash.display.DisplayObject.prototype.SetParent = function(inParent) {
	if(this.mParent == null && inParent != null) {
		this.mParent = inParent;
		this.DoAdded(this);
	}
	else if(this.mParent != null && inParent == null) {
		this.mParent = inParent;
		this.DoRemoved(this);
	}
	else this.mParent = inParent;
}
neash.display.DisplayObject.prototype.SetRotation = function(inRotation) {
	this.mRotation = inRotation * Math.PI / 180.0;
	this.UpdateMatrix();
	return inRotation;
}
neash.display.DisplayObject.prototype.SetScaleX = function(inS) {
	this.mScaleX = inS;
	this.UpdateMatrix();
	return inS;
}
neash.display.DisplayObject.prototype.SetScaleY = function(inS) {
	this.mScaleY = inS;
	this.UpdateMatrix();
	return inS;
}
neash.display.DisplayObject.prototype.SetScrollRect = function(inRect) {
	this.mScrollRect = inRect;
	return this.GetScrollRect();
}
neash.display.DisplayObject.prototype.SetTransform = function(trans) {
	this.mTransformed = true;
	this.mMatrix = trans.GetMatrix().clone();
	return trans;
}
neash.display.DisplayObject.prototype.SetWidth = function(inWidth) {
	this.BuildBounds();
	var w = this.mBoundsRect.width;
	if(w <= 0) return 0;
	this.mScaleX *= inWidth / w;
	this.UpdateMatrix();
	return inWidth;
}
neash.display.DisplayObject.prototype.SetX = function(inX) {
	this.mX = inX;
	this.UpdateMatrix();
	return this.mX;
}
neash.display.DisplayObject.prototype.SetY = function(inY) {
	this.mY = inY;
	this.UpdateMatrix();
	return this.mY;
}
neash.display.DisplayObject.prototype.SetupRender = function(inParentMatrix) {
	var result = 0;
	var m;
	if(this.mTransformed) m = this.mMatrix.mult(inParentMatrix);
	else m = inParentMatrix;
	if(m.a != this.mFullMatrix.a || m.b != this.mFullMatrix.b || m.c != this.mFullMatrix.c || m.d != this.mFullMatrix.d) result |= neash.display.DisplayObject.NON_TRANSLATE_CHANGE;
	if(m.tx != this.mFullMatrix.tx || m.ty != this.mFullMatrix.ty) result |= neash.display.DisplayObject.TRANSLATE_CHANGE;
	var gfx = this.GetGraphics();
	if(gfx != null) {
		if(gfx.CheckChanged()) {
			result |= (neash.display.DisplayObject.NON_TRANSLATE_CHANGE | neash.display.DisplayObject.GRAPHICS_CHANGE);
			this.mGraphicsBounds = null;
		}
	}
	if((result & neash.display.DisplayObject.NON_TRANSLATE_CHANGE) != 0) this.mBoundsDirty = true;
	else if(result != 0) {
		this.mBoundsRect.x += m.tx - this.mFullMatrix.tx;
		this.mBoundsRect.y += m.ty - this.mFullMatrix.ty;
	}
	this.mFullMatrix = m;
	if(this.GetCacheAsBitmap()) {
		if(this.mCachedBitmap == null || (result & neash.display.DisplayObject.NON_TRANSLATE_CHANGE) != 0) {
			this.CreateBitmapCache();
		}
	}
	if(result != 0) this.mMaskHandle = null;
	return result;
}
neash.display.DisplayObject.prototype.UpdateMatrix = function() {
	this.mTransformed = true;
	this.mMatrix = new canvas.geom.Matrix(this.mScaleX,0.0,0.0,this.mScaleY);
	if(this.mRotation != 0.0) this.mMatrix.rotate(this.mRotation);
	this.mMatrix.tx = this.mX;
	this.mMatrix.ty = this.mY;
}
neash.display.DisplayObject.prototype.__swf_depth = null;
neash.display.DisplayObject.prototype._transform = null;
neash.display.DisplayObject.prototype.alpha = null;
neash.display.DisplayObject.prototype.cacheAsBitmap = null;
neash.display.DisplayObject.prototype.filters = null;
neash.display.DisplayObject.prototype.getBounds = function(targetCoordinateSpace) {
	return null;
}
neash.display.DisplayObject.prototype.getRect = function(targetCoordinateSpace) {
	return null;
}
neash.display.DisplayObject.prototype.globalToLocal = function(inPos) {
	return this.GetMatrix().invert().transformPoint(inPos);
}
neash.display.DisplayObject.prototype.height = null;
neash.display.DisplayObject.prototype.hitTestPoint = function(x,y,shapeFlag) {
	var bounding_box = (shapeFlag == null?true:!shapeFlag);
	return true;
}
neash.display.DisplayObject.prototype.mBoundsDirty = null;
neash.display.DisplayObject.prototype.mBoundsRect = null;
neash.display.DisplayObject.prototype.mCacheAsBitmap = null;
neash.display.DisplayObject.prototype.mCachedBitmap = null;
neash.display.DisplayObject.prototype.mCachedBitmapTx = null;
neash.display.DisplayObject.prototype.mCachedBitmapTy = null;
neash.display.DisplayObject.prototype.mChanged = null;
neash.display.DisplayObject.prototype.mFilterSet = null;
neash.display.DisplayObject.prototype.mFilteredBitmap = null;
neash.display.DisplayObject.prototype.mFilters = null;
neash.display.DisplayObject.prototype.mFullMatrix = null;
neash.display.DisplayObject.prototype.mGraphicsBounds = null;
neash.display.DisplayObject.prototype.mMask = null;
neash.display.DisplayObject.prototype.mMaskHandle = null;
neash.display.DisplayObject.prototype.mMaskingObj = null;
neash.display.DisplayObject.prototype.mMatrix = null;
neash.display.DisplayObject.prototype.mOpaqueBackground = null;
neash.display.DisplayObject.prototype.mParent = null;
neash.display.DisplayObject.prototype.mRotation = null;
neash.display.DisplayObject.prototype.mScaleX = null;
neash.display.DisplayObject.prototype.mScaleY = null;
neash.display.DisplayObject.prototype.mScrollRect = null;
neash.display.DisplayObject.prototype.mSizeDirty = null;
neash.display.DisplayObject.prototype.mTransformed = null;
neash.display.DisplayObject.prototype.mX = null;
neash.display.DisplayObject.prototype.mY = null;
neash.display.DisplayObject.prototype.mask = null;
neash.display.DisplayObject.prototype.mouseX = null;
neash.display.DisplayObject.prototype.mouseY = null;
neash.display.DisplayObject.prototype.name = null;
neash.display.DisplayObject.prototype.opaqueBackground = null;
neash.display.DisplayObject.prototype.parent = null;
neash.display.DisplayObject.prototype.rotation = null;
neash.display.DisplayObject.prototype.scaleX = null;
neash.display.DisplayObject.prototype.scaleY = null;
neash.display.DisplayObject.prototype.scrollRect = null;
neash.display.DisplayObject.prototype.stage = null;
neash.display.DisplayObject.prototype.toString = function() {
	return "DisplayObject";
}
neash.display.DisplayObject.prototype.transform = null;
neash.display.DisplayObject.prototype.visible = null;
neash.display.DisplayObject.prototype.width = null;
neash.display.DisplayObject.prototype.x = null;
neash.display.DisplayObject.prototype.y = null;
neash.display.DisplayObject.prototype.__class__ = neash.display.DisplayObject;
neash.display.DisplayObject.__interfaces__ = [neash.display.IBitmapDrawable];
neash.display.InteractiveObject = function(p) { if( p === $_ ) return; {
	neash.display.DisplayObject.apply(this,[]);
	this.tabEnabled = false;
	this.mouseEnabled = true;
	this.SetTabIndex(0);
	this.name = "InteractiveObject";
}}
neash.display.InteractiveObject.__name__ = ["neash","display","InteractiveObject"];
neash.display.InteractiveObject.__super__ = neash.display.DisplayObject;
for(var k in neash.display.DisplayObject.prototype ) neash.display.InteractiveObject.prototype[k] = neash.display.DisplayObject.prototype[k];
neash.display.InteractiveObject.prototype.AsInteractiveObject = function() {
	return this;
}
neash.display.InteractiveObject.prototype.OnFocusIn = function(inMouse) {
	null;
}
neash.display.InteractiveObject.prototype.OnFocusOut = function() {
	null;
}
neash.display.InteractiveObject.prototype.OnKey = function(inKey) {
	null;
}
neash.display.InteractiveObject.prototype.OnMouseDown = function(inX,inY) {
	null;
}
neash.display.InteractiveObject.prototype.OnMouseDrag = function(inX,inY) {
	null;
}
neash.display.InteractiveObject.prototype.OnMouseUp = function(inX,inY) {
	null;
}
neash.display.InteractiveObject.prototype.SetTabIndex = function(inIndex) {
	this.tabIndex = inIndex;
	return inIndex;
}
neash.display.InteractiveObject.prototype.mouseEnabled = null;
neash.display.InteractiveObject.prototype.tabEnabled = null;
neash.display.InteractiveObject.prototype.tabIndex = null;
neash.display.InteractiveObject.prototype.toString = function() {
	return this.name;
}
neash.display.InteractiveObject.prototype.__class__ = neash.display.InteractiveObject;
neash.display.DisplayObjectContainer = function(p) { if( p === $_ ) return; {
	this.mObjs = new Array();
	this.mouseChildren = true;
	neash.display.InteractiveObject.apply(this,[]);
	this.name = "DisplayObjectContainer";
}}
neash.display.DisplayObjectContainer.__name__ = ["neash","display","DisplayObjectContainer"];
neash.display.DisplayObjectContainer.__super__ = neash.display.InteractiveObject;
for(var k in neash.display.InteractiveObject.prototype ) neash.display.DisplayObjectContainer.prototype[k] = neash.display.InteractiveObject.prototype[k];
neash.display.DisplayObjectContainer.prototype.AppendMask = function(inMask) {
	neash.display.InteractiveObject.prototype.AppendMask.apply(this,[inMask]);
	{
		var _g = 0, _g1 = this.mObjs;
		while(_g < _g1.length) {
			var obj = _g1[_g];
			++_g;
			obj.AppendMask(inMask);
		}
	}
}
neash.display.DisplayObjectContainer.prototype.AsContainer = function() {
	return this;
}
neash.display.DisplayObjectContainer.prototype.Broadcast = function(inEvent) {
	this.dispatchEvent(inEvent);
	{
		var _g1 = 0, _g = this.mObjs.length;
		while(_g1 < _g) {
			var i = _g1++;
			var obj = this.mObjs[i];
			var container = obj.AsContainer();
			if(container != null) container.Broadcast(inEvent);
			else obj.dispatchEvent(inEvent);
		}
	}
}
neash.display.DisplayObjectContainer.prototype.DoAdded = function(inObj) {
	neash.display.InteractiveObject.prototype.DoAdded.apply(this,[inObj]);
	{
		var _g = 0, _g1 = this.mObjs;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			child.DoAdded(inObj);
		}
	}
}
neash.display.DisplayObjectContainer.prototype.DoRemoved = function(inObj) {
	neash.display.InteractiveObject.prototype.DoAdded.apply(this,[inObj]);
	{
		var _g = 0, _g1 = this.mObjs;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			child.DoRemoved(inObj);
		}
	}
}
neash.display.DisplayObjectContainer.prototype.GetBackgroundRect = function() {
	var r = neash.display.InteractiveObject.prototype.GetBackgroundRect.apply(this,[]);
	if(r != null) r = r.clone();
	{
		var _g = 0, _g1 = this.mObjs;
		while(_g < _g1.length) {
			var obj = _g1[_g];
			++_g;
			if(obj.visible) {
				var o = obj.GetBackgroundRect();
				if(o != null) {
					var trans = o.transform(obj.mMatrix);
					if(r == null || r.width == 0 || r.height == 0) r = trans;
					else if(trans.width != 0 && trans.height != 0) r.extendBounds(trans);
				}
			}
		}
	}
	return r;
}
neash.display.DisplayObjectContainer.prototype.GetFocusObjects = function(outObjs) {
	var _g = 0, _g1 = this.mObjs;
	while(_g < _g1.length) {
		var obj = _g1[_g];
		++_g;
		obj.GetFocusObjects(outObjs);
	}
}
neash.display.DisplayObjectContainer.prototype.GetMaskHandle = function() {
	if(this.mMaskHandle == null) {
		var handle = neash.display.InteractiveObject.prototype.GetMaskHandle.apply(this,[]);
		if(handle != null) {
			{
				var _g = 0, _g1 = this.mObjs;
				while(_g < _g1.length) {
					var obj = _g1[_g];
					++_g;
					obj.AppendMask(handle);
				}
			}
		}
	}
	return this.mMaskHandle;
}
neash.display.DisplayObjectContainer.prototype.GetNumChildren = function() {
	return this.mObjs.length;
}
neash.display.DisplayObjectContainer.prototype.GetObj = function(inX,inY,inObj) {
	if(!this.visible || this.mMaskingObj != null) return null;
	var l = this.mObjs.length - 1;
	{
		var _g1 = 0, _g = this.mObjs.length;
		while(_g1 < _g) {
			var i = _g1++;
			var result = this.mObjs[l - i].GetObj(inX,inY,this);
			if(result != null) return result;
		}
	}
	return neash.display.InteractiveObject.prototype.GetObj.apply(this,[inX,inY,this]);
}
neash.display.DisplayObjectContainer.prototype.Render = function(inMask,inScrollRect,inTX,inTY) {
	this.mChanged = false;
	if(!this.visible || this.mMaskingObj != null) return null;
	if(this.GetCacheAsBitmap() && this.mCachedBitmap != null) this.RenderCache();
	else {
		inMask = neash.display.InteractiveObject.prototype.Render.apply(this,[inMask,inScrollRect,inTX,inTY]);
		{
			var _g = 0, _g1 = this.mObjs;
			while(_g < _g1.length) {
				var obj = _g1[_g];
				++_g;
				if(obj.visible && obj.mMaskingObj == null) {
					var scroll = obj.mScrollRect;
					if(scroll != null) {
						var m = obj.mFullMatrix;
						var x0 = m.tx;
						var y0 = m.ty;
						var x1 = m.a * scroll.width + m.tx;
						var y1 = m.d * scroll.height + m.ty;
						var display_rect = new canvas.geom.Rectangle(x0,y0,x1 - x0,y1 - y0);
						if(inScrollRect != null) display_rect = display_rect.intersection(inScrollRect);
						if(!display_rect.isEmpty()) {
							var tx = inTX + Std["int"](scroll.x * m.a);
							var ty = inTY + Std["int"](scroll.y * m.d);
							obj.Render(inMask,display_rect,tx,ty);
						}
					}
					else obj.Render(inMask,inScrollRect,inTX,inTY);
				}
			}
		}
	}
	return inMask;
}
neash.display.DisplayObjectContainer.prototype.SetupRender = function(inParentMatrix) {
	var child_result = 0;
	{
		var _g = 0, _g1 = this.mObjs;
		while(_g < _g1.length) {
			var obj = _g1[_g];
			++_g;
			if(obj.visible) child_result |= obj.SetupRender(this.mFullMatrix);
		}
	}
	var result = 0;
	if(child_result != 0) result = (neash.display.DisplayObject.TRANSLATE_CHANGE | neash.display.DisplayObject.NON_TRANSLATE_CHANGE);
	var super_result = neash.display.InteractiveObject.prototype.SetupRender.apply(this,[inParentMatrix]);
	if(this.GetCacheAsBitmap() && (result & neash.display.DisplayObject.NON_TRANSLATE_CHANGE) != 0 && (super_result & neash.display.DisplayObject.NON_TRANSLATE_CHANGE) == 0) this.CreateBitmapCache();
	if(result != 0) this.mMaskHandle = null;
	return result | super_result;
}
neash.display.DisplayObjectContainer.prototype.addChild = function(inObject) {
	var func = function(comObj) {
		return ((inObject == comObj)?true:false);
	}
	if(!Lambda.exists(this.mObjs,func)) {
		this.mObjs.push(inObject);
		inObject.SetParent(this);
	}
}
neash.display.DisplayObjectContainer.prototype.addChildAt = function(obj,index) {
	this.mObjs.insert(index,obj);
	obj.SetParent(this);
}
neash.display.DisplayObjectContainer.prototype.contains = function(obj) {
	if(obj == this) return true;
	{
		var _g = 0, _g1 = this.mObjs;
		while(_g < _g1.length) {
			var i = _g1[_g];
			++_g;
			if(obj == i) return true;
		}
	}
	return false;
}
neash.display.DisplayObjectContainer.prototype.getChildAt = function(index) {
	return this.mObjs[index];
}
neash.display.DisplayObjectContainer.prototype.getChildByName = function(inName) {
	{
		var _g1 = 0, _g = this.mObjs.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.mObjs[i].name == inName) return this.mObjs[i];
		}
	}
	return null;
}
neash.display.DisplayObjectContainer.prototype.getChildIndex = function(child) {
	{
		var _g1 = 0, _g = this.mObjs.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.mObjs[i] == child) return i;
		}
	}
	return -1;
}
neash.display.DisplayObjectContainer.prototype.mObjs = null;
neash.display.DisplayObjectContainer.prototype.mouseChildren = null;
neash.display.DisplayObjectContainer.prototype.numChildren = null;
neash.display.DisplayObjectContainer.prototype.removeChild = function(child) {
	var _g1 = 0, _g = this.mObjs.length;
	while(_g1 < _g) {
		var i = _g1++;
		if(this.mObjs[i] == child) {
			this.mObjs[i].SetParent(null);
			this.mObjs.splice(i,1);
			break;
		}
	}
}
neash.display.DisplayObjectContainer.prototype.removeChildAt = function(inI) {
	this.mObjs[inI].SetParent(null);
	this.mObjs.splice(inI,1);
}
neash.display.DisplayObjectContainer.prototype.setChildIndex = function(child,index) {
	var s = null;
	var orig = this.getChildIndex(child);
	if(orig < 0) throw "setChildIndex : object not found.";
	if(index < orig) {
		{
			var _g = index;
			while(_g < orig) {
				var i = _g++;
				this.mObjs[i] = this.mObjs[i - 1];
			}
		}
		this.mObjs[index] = child;
	}
	else if(orig < index) {
		{
			var _g = orig;
			while(_g < index) {
				var i = _g++;
				this.mObjs[i] = this.mObjs[i + 1];
			}
		}
		this.mObjs[index] = child;
	}
}
neash.display.DisplayObjectContainer.prototype.swapChildren = function(child1,child2) {
	var c1 = -1;
	var c2 = -1;
	var swap;
	{
		var _g1 = 0, _g = this.mObjs.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.mObjs[i] == child1) c1 = i;
			else if(this.mObjs[i] == child2) c2 = i;
		}
	}
	if(c1 != -1 && c2 != -1) {
		swap = this.mObjs[c1];
		this.mObjs[c1] = this.mObjs[c2];
		this.mObjs[c2] = swap;
		swap = null;
	}
}
neash.display.DisplayObjectContainer.prototype.swapChildrenAt = function(child1,child2) {
	var swap = this.mObjs[child1];
	this.mObjs[child1] = this.mObjs[child2];
	this.mObjs[child2] = swap;
	swap = null;
}
neash.display.DisplayObjectContainer.prototype.__class__ = neash.display.DisplayObjectContainer;
neash.display.Sprite = function(p) { if( p === $_ ) return; {
	neash.display.DisplayObjectContainer.apply(this,[]);
	this.mGraphics = new canvas.display.Graphics();
	this.buttonMode = false;
	this.name = "Sprite";
}}
neash.display.Sprite.__name__ = ["neash","display","Sprite"];
neash.display.Sprite.__super__ = neash.display.DisplayObjectContainer;
for(var k in neash.display.DisplayObjectContainer.prototype ) neash.display.Sprite.prototype[k] = neash.display.DisplayObjectContainer.prototype[k];
neash.display.Sprite.prototype.GetGraphics = function() {
	return this.mGraphics;
}
neash.display.Sprite.prototype.buttonMode = null;
neash.display.Sprite.prototype.getObjectsUnderPoint = function(pPoint) {
	return null;
}
neash.display.Sprite.prototype.graphics = null;
neash.display.Sprite.prototype.localToGlobal = function(pPoint) {
	return null;
}
neash.display.Sprite.prototype.mGraphics = null;
neash.display.Sprite.prototype.startDrag = function(lockCenter,bounds) {
	neash.Lib.SetDragged(this,lockCenter,bounds);
}
neash.display.Sprite.prototype.stopDrag = function() {
	neash.Lib.SetDragged(null);
}
neash.display.Sprite.prototype.__class__ = neash.display.Sprite;
Simple = function(p) { if( p === $_ ) return; {
	neash.display.Sprite.apply(this,[]);
	neash.Lib.GetCurrent().GetStage().scaleMode = neash.display.StageScaleMode.NO_SCALE;
	this.scene = new sandy.core.Scene3D("scene",this,new sandy.core.scenegraph.Camera3D(150,150),new sandy.core.scenegraph.Group("root"));
	var q = new sandy.extrusion.data.Polygon2D([new canvas.geom.Point(-24,78),new canvas.geom.Point(42,78),new canvas.geom.Point(73,46),new canvas.geom.Point(73,-10),new canvas.geom.Point(65,-17),new canvas.geom.Point(58,-10),new canvas.geom.Point(57,45),new canvas.geom.Point(41,62),new canvas.geom.Point(-23,63),new canvas.geom.Point(-39,45),new canvas.geom.Point(-40,-8),new canvas.geom.Point(-23,-24),new canvas.geom.Point(40,-24),new canvas.geom.Point(32,-19),new canvas.geom.Point(48,-2),new canvas.geom.Point(58,-10),new canvas.geom.Point(65,-17),new canvas.geom.Point(81,-33),new canvas.geom.Point(65,-50),new canvas.geom.Point(49,-34),new canvas.geom.Point(41,-42),new canvas.geom.Point(-23,-43),new canvas.geom.Point(-57,-11),new canvas.geom.Point(-56,47)]);
	var m0 = new sandy.core.data.Matrix4();
	m0.identity();
	var m1 = new sandy.core.data.Matrix4();
	m1.translation(0,0,50);
	var matrices = [m0,m1];
	this.ext = new sandy.extrusion.Extrusion("q",q,matrices);
	this.scene.root.addChild(this.ext);
	this.ext.__setAppearance(new sandy.materials.Appearance(new sandy.materials.ColorMaterial(16756480,1,new sandy.materials.attributes.MaterialAttributes([new sandy.materials.attributes.LightAttributes(false,0.3)]))));
	this.ext.__getAppearance().__getFrontMaterial().lightingEnable = true;
	neash.Lib.GetCurrent().GetStage().addEventListener(neash.events.Event.ENTER_FRAME,$closure(this,"render"));
}}
Simple.__name__ = ["Simple"];
Simple.__super__ = neash.display.Sprite;
for(var k in neash.display.Sprite.prototype ) Simple.prototype[k] = neash.display.Sprite.prototype[k];
Simple.main = function() {
	haxe.Firebug.redirectTraces();
	neash.Lib.Init("Container",400,400);
	neash.Lib.Run();
	neash.Lib.GetCurrent().addChild(new Simple());
}
Simple.prototype.ext = null;
Simple.prototype.render = function(e) {
	{
		var _g = this.ext;
		_g.__setRotateY(_g.__getRotateY() + 3);
	}
	this.scene.render();
}
Simple.prototype.scene = null;
Simple.prototype.__class__ = Simple;
neash.display.StageScaleMode = { __ename__ : ["neash","display","StageScaleMode"], __constructs__ : ["SHOW_ALL","NO_SCALE","NO_BORDER","EXACT_FIT"] }
neash.display.StageScaleMode.EXACT_FIT = ["EXACT_FIT",3];
neash.display.StageScaleMode.EXACT_FIT.toString = $estr;
neash.display.StageScaleMode.EXACT_FIT.__enum__ = neash.display.StageScaleMode;
neash.display.StageScaleMode.NO_BORDER = ["NO_BORDER",2];
neash.display.StageScaleMode.NO_BORDER.toString = $estr;
neash.display.StageScaleMode.NO_BORDER.__enum__ = neash.display.StageScaleMode;
neash.display.StageScaleMode.NO_SCALE = ["NO_SCALE",1];
neash.display.StageScaleMode.NO_SCALE.toString = $estr;
neash.display.StageScaleMode.NO_SCALE.__enum__ = neash.display.StageScaleMode;
neash.display.StageScaleMode.SHOW_ALL = ["SHOW_ALL",0];
neash.display.StageScaleMode.SHOW_ALL.toString = $estr;
neash.display.StageScaleMode.SHOW_ALL.__enum__ = neash.display.StageScaleMode;
sandy.core = {}
sandy.core.scenegraph = {}
sandy.core.scenegraph.IDisplayable = function() { }
sandy.core.scenegraph.IDisplayable.__name__ = ["sandy","core","scenegraph","IDisplayable"];
sandy.core.scenegraph.IDisplayable.prototype.__getContainer = null;
sandy.core.scenegraph.IDisplayable.prototype.__getDepth = null;
sandy.core.scenegraph.IDisplayable.prototype.__setDepth = null;
sandy.core.scenegraph.IDisplayable.prototype.clear = null;
sandy.core.scenegraph.IDisplayable.prototype.container = null;
sandy.core.scenegraph.IDisplayable.prototype.depth = null;
sandy.core.scenegraph.IDisplayable.prototype.display = null;
sandy.core.scenegraph.IDisplayable.prototype.__class__ = sandy.core.scenegraph.IDisplayable;
sandy.events = {}
sandy.events.EventBroadcaster = function(p) { if( p === $_ ) return; {
	this.mEventMap = new Hash();
}}
sandy.events.EventBroadcaster.__name__ = ["sandy","events","EventBroadcaster"];
sandy.events.EventBroadcaster.prototype.addEventListener = function(type,listener) {
	var list = this.mEventMap.get(type);
	if(list == null) {
		list = new Array();
		this.mEventMap.set(type,list);
	}
	var l = new sandy.events.EventListener(listener);
	{
		var _g1 = 0, _g = list.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(list[i].mID == l.mID) return false;
		}
	}
	list.push(l);
	return true;
}
sandy.events.EventBroadcaster.prototype.broadcastEvent = function(event) {
	var list = this.mEventMap.get(event.type);
	if(list != null) {
		{
			var _g1 = 0, _g = list.length;
			while(_g1 < _g) {
				var i = _g1++;
				var listener = list[i];
				listener.dispatchEvent(event);
			}
		}
	}
}
sandy.events.EventBroadcaster.prototype.hasEventListener = function(type) {
	return this.mEventMap.exists(type);
}
sandy.events.EventBroadcaster.prototype.mEventMap = null;
sandy.events.EventBroadcaster.prototype.removeEventListener = function(type,listener) {
	if(!this.mEventMap.exists(type)) return false;
	var list = this.mEventMap.get(type);
	{
		var _g1 = 0, _g = list.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(list[i].Is(listener)) {
				list.splice(i,1);
				return true;
			}
		}
	}
	return false;
}
sandy.events.EventBroadcaster.prototype.__class__ = sandy.events.EventBroadcaster;
sandy.events.BubbleEventBroadcaster = function(p) { if( p === $_ ) return; {
	this.m_oParent = null;
	sandy.events.EventBroadcaster.apply(this,[]);
}}
sandy.events.BubbleEventBroadcaster.__name__ = ["sandy","events","BubbleEventBroadcaster"];
sandy.events.BubbleEventBroadcaster.__super__ = sandy.events.EventBroadcaster;
for(var k in sandy.events.EventBroadcaster.prototype ) sandy.events.BubbleEventBroadcaster.prototype[k] = sandy.events.EventBroadcaster.prototype[k];
sandy.events.BubbleEventBroadcaster.prototype.__getParent = function() {
	return this.m_oParent;
}
sandy.events.BubbleEventBroadcaster.prototype.__setParent = function(pEB) {
	this.m_oParent = pEB;
	return pEB;
}
sandy.events.BubbleEventBroadcaster.prototype.addChild = function(child) {
	child.__setParent(this);
}
sandy.events.BubbleEventBroadcaster.prototype.broadcastEvent = function(e) {
	if(Std["is"](e,sandy.events.BubbleEvent)) {
		sandy.events.EventBroadcaster.prototype.broadcastEvent.apply(this,[e]);
		if(this.__getParent() != null) {
			this.__getParent().broadcastEvent(e);
		}
	}
	else {
		this.__getParent().broadcastEvent(e);
	}
}
sandy.events.BubbleEventBroadcaster.prototype.m_oParent = null;
sandy.events.BubbleEventBroadcaster.prototype.parent = null;
sandy.events.BubbleEventBroadcaster.prototype.removeChild = function(child) {
	null;
}
sandy.events.BubbleEventBroadcaster.prototype.__class__ = sandy.events.BubbleEventBroadcaster;
sandy.materials.attributes.MaterialAttributes = function(args) { if( args === $_ ) return; {
	if(args == null) args = new Array();
	this.attributes = new Array();
	{
		var _g = 0;
		while(_g < args.length) {
			var attr = args[_g];
			++_g;
			if(Std["is"](attr,sandy.materials.attributes.IAttributes)) {
				this.attributes.push(attr);
			}
		}
	}
}}
sandy.materials.attributes.MaterialAttributes.__name__ = ["sandy","materials","attributes","MaterialAttributes"];
sandy.materials.attributes.MaterialAttributes.prototype.__getFlags = function() {
	var l_nFlags = 0;
	{
		var _g = 0, _g1 = this.attributes;
		while(_g < _g1.length) {
			var l_oAttr = _g1[_g];
			++_g;
			l_nFlags |= l_oAttr.__getFlags();
		}
	}
	return l_nFlags;
}
sandy.materials.attributes.MaterialAttributes.prototype.attributes = null;
sandy.materials.attributes.MaterialAttributes.prototype.begin = function(p_oScene) {
	var _g = 0, _g1 = this.attributes;
	while(_g < _g1.length) {
		var l_oAttr = _g1[_g];
		++_g;
		l_oAttr.begin(p_oScene);
	}
}
sandy.materials.attributes.MaterialAttributes.prototype.draw = function(p_oGraphics,p_oPolygon,p_oMaterial,p_oScene) {
	var _g = 0, _g1 = this.attributes;
	while(_g < _g1.length) {
		var l_oAttr = _g1[_g];
		++_g;
		l_oAttr.draw(p_oGraphics,p_oPolygon,p_oMaterial,p_oScene);
	}
}
sandy.materials.attributes.MaterialAttributes.prototype.drawOnSprite = function(p_oSprite,p_oMaterial,p_oScene) {
	var _g = 0, _g1 = this.attributes;
	while(_g < _g1.length) {
		var l_oAttr = _g1[_g];
		++_g;
		l_oAttr.drawOnSprite(p_oSprite,p_oMaterial,p_oScene);
	}
}
sandy.materials.attributes.MaterialAttributes.prototype.finish = function(p_oScene) {
	var _g = 0, _g1 = this.attributes;
	while(_g < _g1.length) {
		var l_oAttr = _g1[_g];
		++_g;
		l_oAttr.finish(p_oScene);
	}
}
sandy.materials.attributes.MaterialAttributes.prototype.flags = null;
sandy.materials.attributes.MaterialAttributes.prototype.init = function(p_oPolygon) {
	var _g = 0, _g1 = this.attributes;
	while(_g < _g1.length) {
		var l_oAttr = _g1[_g];
		++_g;
		l_oAttr.init(p_oPolygon);
	}
}
sandy.materials.attributes.MaterialAttributes.prototype.unlink = function(p_oPolygon) {
	var _g = 0, _g1 = this.attributes;
	while(_g < _g1.length) {
		var l_oAttr = _g1[_g];
		++_g;
		l_oAttr.unlink(p_oPolygon);
	}
}
sandy.materials.attributes.MaterialAttributes.prototype.__class__ = sandy.materials.attributes.MaterialAttributes;
List = function(p) { if( p === $_ ) return; {
	this.length = 0;
}}
List.__name__ = ["List"];
List.prototype.add = function(item) {
	var x = [item];
	if(this.h == null) this.h = x;
	else this.q[1] = x;
	this.q = x;
	this.length++;
}
List.prototype.clear = function() {
	this.h = null;
	this.q = null;
	this.length = 0;
}
List.prototype.filter = function(f) {
	var l2 = new List();
	var l = this.h;
	while(l != null) {
		var v = l[0];
		l = l[1];
		if(f(v)) l2.add(v);
	}
	return l2;
}
List.prototype.first = function() {
	return (this.h == null?null:this.h[0]);
}
List.prototype.h = null;
List.prototype.isEmpty = function() {
	return (this.h == null);
}
List.prototype.iterator = function() {
	return { h : this.h, hasNext : function() {
		return (this.h != null);
	}, next : function() {
		if(this.h == null) return null;
		var x = this.h[0];
		this.h = this.h[1];
		return x;
	}}
}
List.prototype.join = function(sep) {
	var s = new StringBuf();
	var first = true;
	var l = this.h;
	while(l != null) {
		if(first) first = false;
		else s.b += sep;
		s.b += l[0];
		l = l[1];
	}
	return s.b;
}
List.prototype.last = function() {
	return (this.q == null?null:this.q[0]);
}
List.prototype.length = null;
List.prototype.map = function(f) {
	var b = new List();
	var l = this.h;
	while(l != null) {
		var v = l[0];
		l = l[1];
		b.add(f(v));
	}
	return b;
}
List.prototype.pop = function() {
	if(this.h == null) return null;
	var x = this.h[0];
	this.h = this.h[1];
	if(this.h == null) this.q = null;
	this.length--;
	return x;
}
List.prototype.push = function(item) {
	var x = [item,this.h];
	this.h = x;
	if(this.q == null) this.q = x;
	this.length++;
}
List.prototype.q = null;
List.prototype.remove = function(v) {
	var prev = null;
	var l = this.h;
	while(l != null) {
		if(l[0] == v) {
			if(prev == null) this.h = l[1];
			else prev[1] = l[1];
			if(this.q == l) this.q = prev;
			this.length--;
			return true;
		}
		prev = l;
		l = l[1];
	}
	return false;
}
List.prototype.toString = function() {
	var s = new StringBuf();
	var first = true;
	var l = this.h;
	s.b += "{";
	while(l != null) {
		if(first) first = false;
		else s.b += ", ";
		s.b += l[0];
		l = l[1];
	}
	s.b += "}";
	return s.b;
}
List.prototype.__class__ = List;
neash.utils = {}
neash.utils.Uncompress = function() { }
neash.utils.Uncompress.__name__ = ["neash","utils","Uncompress"];
neash.utils.Uncompress.ConvertStream = function(inStream,inSize) {
	return null;
}
neash.utils.Uncompress.Run = function(inBytes) {
	return null;
}
neash.utils.Uncompress.prototype.__class__ = neash.utils.Uncompress;
sandy.core.scenegraph.Node = function(p_sName) { if( p_sName === $_ ) return; {
	this.id = sandy.core.scenegraph.Node._ID_++;
	this.culled = sandy.view.CullingState.OUTSIDE;
	this.visible = true;
	this.scene = null;
	this.children = new Array();
	this.modelMatrix = new sandy.core.data.Matrix4();
	this.viewMatrix = new sandy.core.data.Matrix4();
	this.changed = false;
	p_sName = ((p_sName != null)?p_sName:"");
	this.__setParent(null);
	if(p_sName != null) this.name = p_sName;
	else this.name = Std.string(this.id);
	this.changed = true;
	this.m_oEB = new sandy.events.BubbleEventBroadcaster();
	this.culled = sandy.view.CullingState.INSIDE;
}}
sandy.core.scenegraph.Node.__name__ = ["sandy","core","scenegraph","Node"];
sandy.core.scenegraph.Node.prototype.__getAppearance = function() {
	return null;
}
sandy.core.scenegraph.Node.prototype.__getBroadcaster = function() {
	return this.m_oEB;
}
sandy.core.scenegraph.Node.prototype.__getEnableBackFaceCulling = function() {
	return false;
}
sandy.core.scenegraph.Node.prototype.__getEnableEvents = function() {
	return false;
}
sandy.core.scenegraph.Node.prototype.__getEnableInteractivity = function() {
	return false;
}
sandy.core.scenegraph.Node.prototype.__getParent = function() {
	return this._parent;
}
sandy.core.scenegraph.Node.prototype.__getUseSingleContainer = function() {
	return false;
}
sandy.core.scenegraph.Node.prototype.__setAppearance = function(p_oApp) {
	{
		var _g = 0, _g1 = this.children;
		while(_g < _g1.length) {
			var l_oNode = _g1[_g];
			++_g;
			l_oNode.__setAppearance(p_oApp);
		}
	}
	return p_oApp;
}
sandy.core.scenegraph.Node.prototype.__setEnableBackFaceCulling = function(b) {
	{
		var _g = 0, _g1 = this.children;
		while(_g < _g1.length) {
			var l_onode = _g1[_g];
			++_g;
			l_onode.__setEnableBackFaceCulling(b);
		}
	}
	return b;
}
sandy.core.scenegraph.Node.prototype.__setEnableEvents = function(b) {
	{
		var _g = 0, _g1 = this.children;
		while(_g < _g1.length) {
			var l_oNode = _g1[_g];
			++_g;
			l_oNode.__setEnableEvents(b);
		}
	}
	return b;
}
sandy.core.scenegraph.Node.prototype.__setEnableInteractivity = function(p_bState) {
	{
		var _g = 0, _g1 = this.children;
		while(_g < _g1.length) {
			var l_oNode = _g1[_g];
			++_g;
			l_oNode.__setEnableInteractivity(p_bState);
		}
	}
	return p_bState;
}
sandy.core.scenegraph.Node.prototype.__setParent = function(p_oNode) {
	if(p_oNode != null) {
		this._parent = p_oNode;
		this.changed = true;
	}
	return p_oNode;
}
sandy.core.scenegraph.Node.prototype.__setUseSingleContainer = function(p_bUseSingleContainer) {
	{
		var _g = 0, _g1 = this.children;
		while(_g < _g1.length) {
			var l_oNode = _g1[_g];
			++_g;
			l_oNode.__setUseSingleContainer(p_bUseSingleContainer);
		}
	}
	return p_bUseSingleContainer;
}
sandy.core.scenegraph.Node.prototype._parent = null;
sandy.core.scenegraph.Node.prototype.addChild = function(p_oChild) {
	if(p_oChild.__getParent() != null) {
		p_oChild.__getParent().removeChildByName(p_oChild.name);
	}
	p_oChild.__setParent(this);
	this.changed = true;
	this.children.push(p_oChild);
	if(p_oChild.__getBroadcaster() != null) this.m_oEB.addChild(p_oChild.__getBroadcaster());
}
sandy.core.scenegraph.Node.prototype.addEventListener = function(p_sEvt,p_oL) {
	$closure(this.m_oEB,"addEventListener").apply(p_sEvt,[p_sEvt,p_oL]);
}
sandy.core.scenegraph.Node.prototype.appearance = null;
sandy.core.scenegraph.Node.prototype.boundingBox = null;
sandy.core.scenegraph.Node.prototype.boundingSphere = null;
sandy.core.scenegraph.Node.prototype.broadcaster = null;
sandy.core.scenegraph.Node.prototype.changed = null;
sandy.core.scenegraph.Node.prototype.children = null;
sandy.core.scenegraph.Node.prototype.cull = function(p_oScene,p_oFrustum,p_oViewMatrix,p_bChanged) {
	if(this.visible == false) {
		this.culled = sandy.view.CullingState.OUTSIDE;
	}
	else {
		if(p_bChanged || this.changed) {
			this.viewMatrix.copy(p_oViewMatrix);
			this.viewMatrix.multiply4x3(this.modelMatrix);
		}
	}
}
sandy.core.scenegraph.Node.prototype.culled = null;
sandy.core.scenegraph.Node.prototype.destroy = function() {
	if(this.hasParent() == true) this.__getParent().removeChildByName(this.name);
	var l_aTmp = this.children;
	{
		var _g = 0;
		while(_g < l_aTmp.length) {
			var lNode = l_aTmp[_g];
			++_g;
			lNode.destroy();
		}
	}
	this.children.splice(0,this.children.length);
	this.m_oEB = null;
}
sandy.core.scenegraph.Node.prototype.enableBackFaceCulling = null;
sandy.core.scenegraph.Node.prototype.enableEvents = null;
sandy.core.scenegraph.Node.prototype.enableInteractivity = null;
sandy.core.scenegraph.Node.prototype.getChildByName = function(p_sName,p_bRecurs) {
	var l_oNode, l_oNode2;
	p_bRecurs = ((p_bRecurs)?p_bRecurs:false);
	{
		var _g = 0, _g1 = this.children;
		while(_g < _g1.length) {
			var l_oNode1 = _g1[_g];
			++_g;
			if(l_oNode1.name == p_sName) {
				return l_oNode1;
			}
		}
	}
	if(p_bRecurs) {
		var node = null;
		{
			var _g = 0, _g1 = this.children;
			while(_g < _g1.length) {
				var l_oNode1 = _g1[_g];
				++_g;
				node = l_oNode1.getChildByName(p_sName,p_bRecurs);
				if(node != null) {
					return node;
				}
			}
		}
	}
	return null;
}
sandy.core.scenegraph.Node.prototype.hasParent = function() {
	return (this._parent != null);
}
sandy.core.scenegraph.Node.prototype.id = null;
sandy.core.scenegraph.Node.prototype.isParent = function(p_oNode) {
	return (this._parent == p_oNode && p_oNode != null);
}
sandy.core.scenegraph.Node.prototype.m_oEB = null;
sandy.core.scenegraph.Node.prototype.modelMatrix = null;
sandy.core.scenegraph.Node.prototype.name = null;
sandy.core.scenegraph.Node.prototype.parent = null;
sandy.core.scenegraph.Node.prototype.remove = function() {
	this.__getParent().removeChildByName(this.name);
	var l_aTmp = this.children;
	{
		var _g = 0;
		while(_g < l_aTmp.length) {
			var lNode = l_aTmp[_g];
			++_g;
			this.__getParent().addChild(lNode);
		}
	}
	this.children.splice(0,this.children.length);
	this.m_oEB = null;
	this.changed = true;
}
sandy.core.scenegraph.Node.prototype.removeChildByName = function(p_sName) {
	var found = false;
	var i = 0;
	var l = this.children.length;
	while(i < l && !found) {
		if(this.children[i].name == p_sName) {
			this.__getBroadcaster().removeChild(this.children[i].__getBroadcaster());
			this.children.splice(i,1);
			this.changed = true;
			found = true;
		}
		i++;
	}
	return found;
}
sandy.core.scenegraph.Node.prototype.removeEventListener = function(p_sEvt,p_oL) {
	this.m_oEB.removeEventListener(p_sEvt,p_oL);
}
sandy.core.scenegraph.Node.prototype.render = function(p_oScene,p_oCamera) {
	null;
}
sandy.core.scenegraph.Node.prototype.scene = null;
sandy.core.scenegraph.Node.prototype.swapParent = function(p_oNewParent) {
	if(this.__getParent().removeChildByName(this.name)) p_oNewParent.addChild(this);
}
sandy.core.scenegraph.Node.prototype.toString = function() {
	return "sandy.core.scenegraph.Node";
}
sandy.core.scenegraph.Node.prototype.update = function(p_oScene,p_oModelMatrix,p_bChanged) {
	this.scene = p_oScene;
	if(this.boundingBox != null) this.boundingBox.uptodate = false;
	if(this.boundingSphere != null) this.boundingSphere.uptodate = false;
	this.changed = this.changed || p_bChanged;
	var l_oNode;
	{
		var _g = 0, _g1 = this.children;
		while(_g < _g1.length) {
			var l_oNode1 = _g1[_g];
			++_g;
			l_oNode1.update(p_oScene,p_oModelMatrix,this.changed);
		}
	}
}
sandy.core.scenegraph.Node.prototype.useSingleContainer = null;
sandy.core.scenegraph.Node.prototype.viewMatrix = null;
sandy.core.scenegraph.Node.prototype.visible = null;
sandy.core.scenegraph.Node.prototype.__class__ = sandy.core.scenegraph.Node;
sandy.core.scenegraph.ATransformable = function(p_sName) { if( p_sName === $_ ) return; {
	p_sName = ((p_sName != null)?p_sName:"");
	sandy.core.scenegraph.Node.apply(this,[p_sName]);
	this.disable = false;
	this.m_oPreviousOffsetRotation = new sandy.core.data.Vector();
	this.initFrame();
	this._p = new sandy.core.data.Vector();
	this._oScale = new sandy.core.data.Vector(1,1,1);
	this._vRotation = new sandy.core.data.Vector(0,0,0);
	this._vLookatDown = new sandy.core.data.Vector(0.00000000001,-1,0);
	this._nRoll = 0;
	this._nTilt = 0;
	this._nYaw = 0;
	this.m_tmpMt = new sandy.core.data.Matrix4();
	this.m_oMatrix = new sandy.core.data.Matrix4();
}}
sandy.core.scenegraph.ATransformable.__name__ = ["sandy","core","scenegraph","ATransformable"];
sandy.core.scenegraph.ATransformable.__super__ = sandy.core.scenegraph.Node;
for(var k in sandy.core.scenegraph.Node.prototype ) sandy.core.scenegraph.ATransformable.prototype[k] = sandy.core.scenegraph.Node.prototype[k];
sandy.core.scenegraph.ATransformable.prototype.__getMatrix = function() {
	return this.m_oMatrix;
}
sandy.core.scenegraph.ATransformable.prototype.__getOut = function() {
	return this._vOut;
}
sandy.core.scenegraph.ATransformable.prototype.__getPan = function() {
	return this._nYaw;
}
sandy.core.scenegraph.ATransformable.prototype.__getRoll = function() {
	return this._nRoll;
}
sandy.core.scenegraph.ATransformable.prototype.__getRotateX = function() {
	return this._vRotation.x;
}
sandy.core.scenegraph.ATransformable.prototype.__getRotateY = function() {
	return this._vRotation.y;
}
sandy.core.scenegraph.ATransformable.prototype.__getRotateZ = function() {
	return this._vRotation.z;
}
sandy.core.scenegraph.ATransformable.prototype.__getScaleX = function() {
	return this._oScale.x;
}
sandy.core.scenegraph.ATransformable.prototype.__getScaleY = function() {
	return this._oScale.y;
}
sandy.core.scenegraph.ATransformable.prototype.__getScaleZ = function() {
	return this._oScale.z;
}
sandy.core.scenegraph.ATransformable.prototype.__getSide = function() {
	return this._vSide;
}
sandy.core.scenegraph.ATransformable.prototype.__getTilt = function() {
	return this._nTilt;
}
sandy.core.scenegraph.ATransformable.prototype.__getUp = function() {
	return this._vUp;
}
sandy.core.scenegraph.ATransformable.prototype.__getX = function() {
	return this._p.x;
}
sandy.core.scenegraph.ATransformable.prototype.__getY = function() {
	return this._p.y;
}
sandy.core.scenegraph.ATransformable.prototype.__getZ = function() {
	return this._p.z;
}
sandy.core.scenegraph.ATransformable.prototype.__setMatrix = function(p_oMatrix) {
	this.m_oMatrix = p_oMatrix;
	this.m_oMatrix.vectorMult3x3(this._vSide);
	this.m_oMatrix.vectorMult3x3(this._vUp);
	this.m_oMatrix.vectorMult3x3(this._vOut);
	this._vSide.normalize();
	this._vUp.normalize();
	this._vOut.normalize();
	this._p.x = p_oMatrix.n14;
	this._p.y = p_oMatrix.n24;
	this._p.z = p_oMatrix.n34;
	return p_oMatrix;
}
sandy.core.scenegraph.ATransformable.prototype.__setPan = function(p_nAngle) {
	var l_nAngle = (p_nAngle - this._nYaw);
	if(l_nAngle == 0) return p_nAngle;
	this.changed = true;
	this.m_tmpMt.axisRotation(this._vUp.x,this._vUp.y,this._vUp.z,l_nAngle);
	this.m_tmpMt.vectorMult3x3(this._vOut);
	this.m_tmpMt.vectorMult3x3(this._vSide);
	this._nYaw = p_nAngle;
	return p_nAngle;
}
sandy.core.scenegraph.ATransformable.prototype.__setRoll = function(p_nAngle) {
	var l_nAngle = (p_nAngle - this._nRoll);
	if(l_nAngle == 0) return p_nAngle;
	this.changed = true;
	this.m_tmpMt.axisRotation(this._vOut.x,this._vOut.y,this._vOut.z,l_nAngle);
	this.m_tmpMt.vectorMult3x3(this._vSide);
	this.m_tmpMt.vectorMult3x3(this._vUp);
	this._nRoll = p_nAngle;
	return p_nAngle;
}
sandy.core.scenegraph.ATransformable.prototype.__setRotateX = function(p_nAngle) {
	var l_nAngle = (p_nAngle - this._vRotation.x);
	if(l_nAngle == 0) return p_nAngle;
	this.changed = true;
	this.m_tmpMt.rotationX(l_nAngle);
	this.m_tmpMt.vectorMult3x3(this._vSide);
	this.m_tmpMt.vectorMult3x3(this._vUp);
	this.m_tmpMt.vectorMult3x3(this._vOut);
	this._vRotation.x = p_nAngle;
	return p_nAngle;
}
sandy.core.scenegraph.ATransformable.prototype.__setRotateY = function(p_nAngle) {
	var l_nAngle = (p_nAngle - this._vRotation.y);
	if(l_nAngle == 0) return p_nAngle;
	this.changed = true;
	this.m_tmpMt.rotationY(l_nAngle);
	this.m_tmpMt.vectorMult3x3(this._vSide);
	this.m_tmpMt.vectorMult3x3(this._vUp);
	this.m_tmpMt.vectorMult3x3(this._vOut);
	this._vRotation.y = p_nAngle;
	return p_nAngle;
}
sandy.core.scenegraph.ATransformable.prototype.__setRotateZ = function(p_nAngle) {
	var l_nAngle = (p_nAngle - this._vRotation.z);
	if(l_nAngle == 0) return p_nAngle;
	this.changed = true;
	this.m_tmpMt.rotationZ(l_nAngle);
	this.m_tmpMt.vectorMult3x3(this._vSide);
	this.m_tmpMt.vectorMult3x3(this._vUp);
	this.m_tmpMt.vectorMult3x3(this._vOut);
	this._vRotation.z = p_nAngle;
	return p_nAngle;
}
sandy.core.scenegraph.ATransformable.prototype.__setScaleX = function(p_nScaleX) {
	this._oScale.x = p_nScaleX;
	this.changed = true;
	return p_nScaleX;
}
sandy.core.scenegraph.ATransformable.prototype.__setScaleY = function(p_scaleY) {
	this._oScale.y = p_scaleY;
	this.changed = true;
	return p_scaleY;
}
sandy.core.scenegraph.ATransformable.prototype.__setScaleZ = function(p_scaleZ) {
	this._oScale.z = p_scaleZ;
	this.changed = true;
	return p_scaleZ;
}
sandy.core.scenegraph.ATransformable.prototype.__setTarget = function(p_oTarget) {
	this.lookAt(p_oTarget.x,p_oTarget.y,p_oTarget.z);
	return p_oTarget;
}
sandy.core.scenegraph.ATransformable.prototype.__setTilt = function(p_nAngle) {
	var l_nAngle = (p_nAngle - this._nTilt);
	if(l_nAngle == 0) return p_nAngle;
	this.changed = true;
	this.m_tmpMt.axisRotation(this._vSide.x,this._vSide.y,this._vSide.z,l_nAngle);
	this.m_tmpMt.vectorMult3x3(this._vOut);
	this.m_tmpMt.vectorMult3x3(this._vUp);
	this._nTilt = p_nAngle;
	return p_nAngle;
}
sandy.core.scenegraph.ATransformable.prototype.__setX = function(p_nX) {
	this._p.x = p_nX;
	this.changed = true;
	return p_nX;
}
sandy.core.scenegraph.ATransformable.prototype.__setY = function(p_nY) {
	this._p.y = p_nY;
	this.changed = true;
	return p_nY;
}
sandy.core.scenegraph.ATransformable.prototype.__setZ = function(p_nZ) {
	this._p.z = p_nZ;
	this.changed = true;
	return p_nZ;
}
sandy.core.scenegraph.ATransformable.prototype._nRoll = null;
sandy.core.scenegraph.ATransformable.prototype._nTilt = null;
sandy.core.scenegraph.ATransformable.prototype._nYaw = null;
sandy.core.scenegraph.ATransformable.prototype._oScale = null;
sandy.core.scenegraph.ATransformable.prototype._p = null;
sandy.core.scenegraph.ATransformable.prototype._vLookatDown = null;
sandy.core.scenegraph.ATransformable.prototype._vOut = null;
sandy.core.scenegraph.ATransformable.prototype._vRotation = null;
sandy.core.scenegraph.ATransformable.prototype._vSide = null;
sandy.core.scenegraph.ATransformable.prototype._vUp = null;
sandy.core.scenegraph.ATransformable.prototype.disable = null;
sandy.core.scenegraph.ATransformable.prototype.getPosition = function(p_sMode) {
	var l_oPos;
	p_sMode = ((p_sMode != null)?p_sMode:"local");
	switch(p_sMode) {
	case "local":{
		l_oPos = new sandy.core.data.Vector(this._p.x,this._p.y,this._p.z);
	}break;
	case "camera":{
		l_oPos = new sandy.core.data.Vector(this.viewMatrix.n14,this.viewMatrix.n24,this.viewMatrix.n34);
	}break;
	case "absolute":{
		l_oPos = new sandy.core.data.Vector(this.modelMatrix.n14,this.modelMatrix.n24,this.modelMatrix.n34);
	}break;
	default:{
		l_oPos = new sandy.core.data.Vector(this._p.x,this._p.y,this._p.z);
	}break;
	}
	return l_oPos;
}
sandy.core.scenegraph.ATransformable.prototype.initFrame = function() {
	this._vSide = new sandy.core.data.Vector(1,0,0);
	this._vUp = new sandy.core.data.Vector(0,1,0);
	this._vOut = new sandy.core.data.Vector(0,0,1);
}
sandy.core.scenegraph.ATransformable.prototype.lookAt = function(p_nX,p_nY,p_nZ) {
	this.changed = true;
	this._vOut.x = p_nX;
	this._vOut.y = p_nY;
	this._vOut.z = p_nZ;
	this._vOut.sub(this._p);
	this._vOut.normalize();
	this._vSide = null;
	this._vSide = this._vOut.cross(this._vLookatDown);
	this._vSide.normalize();
	this._vUp = null;
	this._vUp = this._vOut.cross(this._vSide);
	this._vUp.normalize();
}
sandy.core.scenegraph.ATransformable.prototype.m_oMatrix = null;
sandy.core.scenegraph.ATransformable.prototype.m_oPreviousOffsetRotation = null;
sandy.core.scenegraph.ATransformable.prototype.m_tmpMt = null;
sandy.core.scenegraph.ATransformable.prototype.matrix = null;
sandy.core.scenegraph.ATransformable.prototype.moveForward = function(p_nD) {
	this.changed = true;
	this._p.x += this._vOut.x * p_nD;
	this._p.y += this._vOut.y * p_nD;
	this._p.z += this._vOut.z * p_nD;
}
sandy.core.scenegraph.ATransformable.prototype.moveHorizontally = function(p_nD) {
	this.changed = true;
	this._p.x += this._vOut.x * p_nD;
	this._p.z += this._vOut.z * p_nD;
}
sandy.core.scenegraph.ATransformable.prototype.moveLateraly = function(p_nD) {
	this.changed = true;
	this._p.x += p_nD;
}
sandy.core.scenegraph.ATransformable.prototype.moveSideways = function(p_nD) {
	this.changed = true;
	this._p.x += this._vSide.x * p_nD;
	this._p.y += this._vSide.y * p_nD;
	this._p.z += this._vSide.z * p_nD;
}
sandy.core.scenegraph.ATransformable.prototype.moveUpwards = function(p_nD) {
	this.changed = true;
	this._p.x += this._vUp.x * p_nD;
	this._p.y += this._vUp.y * p_nD;
	this._p.z += this._vUp.z * p_nD;
}
sandy.core.scenegraph.ATransformable.prototype.moveVertically = function(p_nD) {
	this.changed = true;
	this._p.y += p_nD;
}
sandy.core.scenegraph.ATransformable.prototype.out = null;
sandy.core.scenegraph.ATransformable.prototype.pan = null;
sandy.core.scenegraph.ATransformable.prototype.roll = null;
sandy.core.scenegraph.ATransformable.prototype.rotateAxis = function(p_nX,p_nY,p_nZ,p_nAngle) {
	this.changed = true;
	p_nAngle = (p_nAngle + 360) % 360;
	var n = Math.sqrt(p_nX * p_nX + p_nY * p_nY + p_nZ * p_nZ);
	this.m_tmpMt.axisRotation(p_nX / n,p_nY / n,p_nZ / n,p_nAngle);
	this.m_tmpMt.vectorMult3x3(this._vSide);
	this.m_tmpMt.vectorMult3x3(this._vUp);
	this.m_tmpMt.vectorMult3x3(this._vOut);
}
sandy.core.scenegraph.ATransformable.prototype.rotateX = null;
sandy.core.scenegraph.ATransformable.prototype.rotateY = null;
sandy.core.scenegraph.ATransformable.prototype.rotateZ = null;
sandy.core.scenegraph.ATransformable.prototype.scaleX = null;
sandy.core.scenegraph.ATransformable.prototype.scaleY = null;
sandy.core.scenegraph.ATransformable.prototype.scaleZ = null;
sandy.core.scenegraph.ATransformable.prototype.setPosition = function(p_nX,p_nY,p_nZ) {
	this.changed = true;
	this._p.x = p_nX;
	this._p.y = p_nY;
	this._p.z = p_nZ;
}
sandy.core.scenegraph.ATransformable.prototype.side = null;
sandy.core.scenegraph.ATransformable.prototype.target = null;
sandy.core.scenegraph.ATransformable.prototype.tilt = null;
sandy.core.scenegraph.ATransformable.prototype.toString = function() {
	return "sandy.core.scenegraph.ATransformable";
}
sandy.core.scenegraph.ATransformable.prototype.translate = function(p_nX,p_nY,p_nZ) {
	this.changed = true;
	this._p.x += p_nX;
	this._p.y += p_nY;
	this._p.z += p_nZ;
}
sandy.core.scenegraph.ATransformable.prototype.up = null;
sandy.core.scenegraph.ATransformable.prototype.update = function(p_oScene,p_oModelMatrix,p_bChanged) {
	this.updateTransform();
	if(p_bChanged || this.changed) {
		if(p_oModelMatrix != null && !this.disable) {
			this.modelMatrix.copy(p_oModelMatrix);
			this.modelMatrix.multiply4x3(this.m_oMatrix);
		}
		else {
			this.modelMatrix.copy(this.m_oMatrix);
		}
	}
	sandy.core.scenegraph.Node.prototype.update.apply(this,[p_oScene,this.modelMatrix,p_bChanged]);
}
sandy.core.scenegraph.ATransformable.prototype.updateTransform = function() {
	if(this.changed) {
		this.m_oMatrix.n11 = this._vSide.x * this._oScale.x;
		this.m_oMatrix.n12 = this._vUp.x * this._oScale.y;
		this.m_oMatrix.n13 = this._vOut.x * this._oScale.z;
		this.m_oMatrix.n14 = this._p.x;
		this.m_oMatrix.n21 = this._vSide.y * this._oScale.x;
		this.m_oMatrix.n22 = this._vUp.y * this._oScale.y;
		this.m_oMatrix.n23 = this._vOut.y * this._oScale.z;
		this.m_oMatrix.n24 = this._p.y;
		this.m_oMatrix.n31 = this._vSide.z * this._oScale.x;
		this.m_oMatrix.n32 = this._vUp.z * this._oScale.y;
		this.m_oMatrix.n33 = this._vOut.z * this._oScale.z;
		this.m_oMatrix.n34 = this._p.z;
	}
}
sandy.core.scenegraph.ATransformable.prototype.x = null;
sandy.core.scenegraph.ATransformable.prototype.y = null;
sandy.core.scenegraph.ATransformable.prototype.z = null;
sandy.core.scenegraph.ATransformable.prototype.__class__ = sandy.core.scenegraph.ATransformable;
neash.text = {}
neash.text.FontInstanceMode = { __ename__ : ["neash","text","FontInstanceMode"], __constructs__ : ["fimSolid"] }
neash.text.FontInstanceMode.fimSolid = ["fimSolid",0];
neash.text.FontInstanceMode.fimSolid.toString = $estr;
neash.text.FontInstanceMode.fimSolid.__enum__ = neash.text.FontInstanceMode;
Hash = function(p) { if( p === $_ ) return; {
	this.h = {}
	if(this.h.__proto__ != null) {
		this.h.__proto__ = null;
		delete(this.h.__proto__);
	}
	else null;
}}
Hash.__name__ = ["Hash"];
Hash.prototype.exists = function(key) {
	try {
		key = "$" + key;
		return this.hasOwnProperty.call(this.h,key);
	}
	catch( $e0 ) {
		{
			var e = $e0;
			{
				
				for(var i in this.h)
					if( i == key ) return true;
			;
				return false;
			}
		}
	}
}
Hash.prototype.get = function(key) {
	return this.h["$" + key];
}
Hash.prototype.h = null;
Hash.prototype.iterator = function() {
	return { ref : this.h, it : this.keys(), hasNext : function() {
		return this.it.hasNext();
	}, next : function() {
		var i = this.it.next();
		return this.ref["$" + i];
	}}
}
Hash.prototype.keys = function() {
	var a = new Array();
	
			for(var i in this.h)
				a.push(i.substr(1));
		;
	return a.iterator();
}
Hash.prototype.remove = function(key) {
	if(!this.exists(key)) return false;
	delete(this.h["$" + key]);
	return true;
}
Hash.prototype.set = function(key,value) {
	this.h["$" + key] = value;
}
Hash.prototype.toString = function() {
	var s = new StringBuf();
	s.b += "{";
	var it = this.keys();
	{ var $it1 = it;
	while( $it1.hasNext() ) { var i = $it1.next();
	{
		s.b += i;
		s.b += " => ";
		s.b += Std.string(this.get(i));
		if(it.hasNext()) s.b += ", ";
	}
	}}
	s.b += "}";
	return s.b;
}
Hash.prototype.__class__ = Hash;
neash.text.FontInstance = function(inFont,inHeight) { if( inFont === $_ ) return; {
	this.mFont = inFont;
	this.mHeight = inHeight;
	this.mTryFreeType = true;
}}
neash.text.FontInstance.__name__ = ["neash","text","FontInstance"];
neash.text.FontInstance.CreateSolid = function(inFace,inHeight,inColour,inAlpha) {
	var id = "SOLID:" + inFace + ":" + inHeight + ":" + inColour + ":" + inAlpha;
	var f = neash.text.FontInstance.mSolidFonts.get(id);
	if(f != null) return f;
	var font = neash.text.FontManager.GetFont(inFace,inHeight);
	if(font == null) return null;
	f = new neash.text.FontInstance(font,inHeight);
	f.SetSolid(inColour,inAlpha);
	neash.text.FontInstance.mSolidFonts.set(id,f);
	return f;
}
neash.text.FontInstance.prototype.GetAdvance = function(inChar) {
	return this.mFont.GetAdvance(inChar);
}
neash.text.FontInstance.prototype.GetFace = function() {
	return this.mFont.GetName();
}
neash.text.FontInstance.prototype.GetHeight = function() {
	return this.mHeight;
}
neash.text.FontInstance.prototype.RenderChar = function(inGraphics,inGlyph,inX,inY) {
	inGraphics.lineStyle();
	inGraphics.beginFill(this.mColour,this.mAlpha);
	return this.mFont.Render(inGraphics,inGlyph,inX,inY,this.mTryFreeType);
}
neash.text.FontInstance.prototype.SetSolid = function(inCol,inAlpha) {
	this.mColour = inCol;
	this.mAlpha = inAlpha;
	this.mMode = neash.text.FontInstanceMode.fimSolid;
}
neash.text.FontInstance.prototype.height = null;
neash.text.FontInstance.prototype.mAlpha = null;
neash.text.FontInstance.prototype.mColour = null;
neash.text.FontInstance.prototype.mFont = null;
neash.text.FontInstance.prototype.mHeight = null;
neash.text.FontInstance.prototype.mMode = null;
neash.text.FontInstance.prototype.mTryFreeType = null;
neash.text.FontInstance.prototype.__class__ = neash.text.FontInstance;
IntIter = function(min,max) { if( min === $_ ) return; {
	this.min = min;
	this.max = max;
}}
IntIter.__name__ = ["IntIter"];
IntIter.prototype.hasNext = function() {
	return this.min < this.max;
}
IntIter.prototype.max = null;
IntIter.prototype.min = null;
IntIter.prototype.next = function() {
	return this.min++;
}
IntIter.prototype.__class__ = IntIter;
neash.display.Loader = function(p) { if( p === $_ ) return; {
	neash.display.DisplayObjectContainer.apply(this,[]);
	this.contentLoaderInfo = new neash.display.LoaderInfo();
}}
neash.display.Loader.__name__ = ["neash","display","Loader"];
neash.display.Loader.__super__ = neash.display.DisplayObjectContainer;
for(var k in neash.display.DisplayObjectContainer.prototype ) neash.display.Loader.prototype[k] = neash.display.DisplayObjectContainer.prototype[k];
neash.display.Loader.prototype.content = null;
neash.display.Loader.prototype.contentLoaderInfo = null;
neash.display.Loader.prototype.load = function(request) {
	this.mImage = new canvas.display.BitmapData(0,0);
	this.mImage.LoadFromFile(request.url,this.contentLoaderInfo);
	this.content = new neash.display.Bitmap(this.mImage);
	if(this.mShape == null) {
		this.mShape = new neash.display.Shape();
		this.addChild(this.mShape);
	}
	else this.mShape.GetGraphics().clear();
}
neash.display.Loader.prototype.mImage = null;
neash.display.Loader.prototype.mShape = null;
neash.display.Loader.prototype.__class__ = neash.display.Loader;
neash.events.Listener = function(inListener,inUseCapture,inPriority) { if( inListener === $_ ) return; {
	this.mListner = inListener;
	this.mUseCapture = inUseCapture;
	this.mPriority = inPriority;
	this.mID = neash.events.Listener.sIDs++;
}}
neash.events.Listener.__name__ = ["neash","events","Listener"];
neash.events.Listener.prototype.Is = function(inListener,inCapture) {
	return Reflect.compareMethods($closure(this,"mListner"),inListener) && this.mUseCapture == inCapture;
}
neash.events.Listener.prototype.dispatchEvent = function(event) {
	this.mListner(event);
}
neash.events.Listener.prototype.mID = null;
neash.events.Listener.prototype.mListner = null;
neash.events.Listener.prototype.mPriority = null;
neash.events.Listener.prototype.mUseCapture = null;
neash.events.Listener.prototype.__class__ = neash.events.Listener;
canvas = {}
canvas.filters = {}
canvas.filters.FilterSet = function(inFilters) { if( inFilters === $_ ) return; {
	this.mOffset = new canvas.geom.Point();
}}
canvas.filters.FilterSet.__name__ = ["canvas","filters","FilterSet"];
canvas.filters.FilterSet.prototype.FilterImage = function(inImage) {
	throw "Not implemented. FilterImage.";
	return null;
}
canvas.filters.FilterSet.prototype.GetOffsetX = function() {
	return Std["int"](this.mOffset.x);
}
canvas.filters.FilterSet.prototype.GetOffsetY = function() {
	return Std["int"](this.mOffset.y);
}
canvas.filters.FilterSet.prototype.mHandle = null;
canvas.filters.FilterSet.prototype.mOffset = null;
canvas.filters.FilterSet.prototype.__class__ = canvas.filters.FilterSet;
neash.display.StageQuality = function() { }
neash.display.StageQuality.__name__ = ["neash","display","StageQuality"];
neash.display.StageQuality.prototype.__class__ = neash.display.StageQuality;
IntHash = function(p) { if( p === $_ ) return; {
	this.h = {}
	if(this.h.__proto__ != null) {
		this.h.__proto__ = null;
		delete(this.h.__proto__);
	}
	else null;
}}
IntHash.__name__ = ["IntHash"];
IntHash.prototype.exists = function(key) {
	return this.h[key] != null;
}
IntHash.prototype.get = function(key) {
	return this.h[key];
}
IntHash.prototype.h = null;
IntHash.prototype.iterator = function() {
	return { ref : this.h, it : this.keys(), hasNext : function() {
		return this.it.hasNext();
	}, next : function() {
		var i = this.it.next();
		return this.ref[i];
	}}
}
IntHash.prototype.keys = function() {
	var a = new Array();
	
			for( x in this.h )
				a.push(x);
		;
	return a.iterator();
}
IntHash.prototype.remove = function(key) {
	if(this.h[key] == null) return false;
	delete(this.h[key]);
	return true;
}
IntHash.prototype.set = function(key,value) {
	this.h[key] = value;
}
IntHash.prototype.toString = function() {
	var s = new StringBuf();
	s.b += "{";
	var it = this.keys();
	{ var $it2 = it;
	while( $it2.hasNext() ) { var i = $it2.next();
	{
		s.b += i;
		s.b += " => ";
		s.b += Std.string(this.get(i));
		if(it.hasNext()) s.b += ", ";
	}
	}}
	s.b += "}";
	return s.b;
}
IntHash.prototype.__class__ = IntHash;
neash.text.Font = function() { }
neash.text.Font.__name__ = ["neash","text","Font"];
neash.text.Font.prototype.CanRenderOutline = null;
neash.text.Font.prototype.CanRenderSolid = null;
neash.text.Font.prototype.GetAdvance = null;
neash.text.Font.prototype.GetAscent = null;
neash.text.Font.prototype.GetDescent = null;
neash.text.Font.prototype.GetHeight = null;
neash.text.Font.prototype.GetLeading = null;
neash.text.Font.prototype.GetName = null;
neash.text.Font.prototype.Render = null;
neash.text.Font.prototype.__class__ = neash.text.Font;
neash.text.NativeFont = function(inFace,inHeight) { if( inFace === $_ ) return; {
	this.mName = inFace;
	this.mHeight = inHeight;
}}
neash.text.NativeFont.__name__ = ["neash","text","NativeFont"];
neash.text.NativeFont.prototype.CanRenderOutline = function() {
	return false;
}
neash.text.NativeFont.prototype.CanRenderSolid = function() {
	return true;
}
neash.text.NativeFont.prototype.GetAdvance = function(inGlyph) {
	return this.mHeight;
}
neash.text.NativeFont.prototype.GetAscent = function() {
	return Std["int"](this.mHeight * 0.8);
}
neash.text.NativeFont.prototype.GetDescent = function() {
	return Std["int"](this.mHeight * 0.1);
}
neash.text.NativeFont.prototype.GetHeight = function() {
	return this.mHeight;
}
neash.text.NativeFont.prototype.GetLeading = function() {
	return 0;
}
neash.text.NativeFont.prototype.GetName = function() {
	return this.mName;
}
neash.text.NativeFont.prototype.Ok = function() {
	return false;
}
neash.text.NativeFont.prototype.Render = function(inGfx,inChar,inX,inY,inOutline) {
	return 0;
}
neash.text.NativeFont.prototype.mHeight = null;
neash.text.NativeFont.prototype.mName = null;
neash.text.NativeFont.prototype.__class__ = neash.text.NativeFont;
neash.text.NativeFont.__interfaces__ = [neash.text.Font];
canvas.EventType = { __ename__ : ["canvas","EventType"], __constructs__ : ["et_noevent","et_active","et_keydown","et_keyup","et_mousemove","et_mousebutton_down","et_mousebutton_up","et_joystickmove","et_joystickball","et_joystickhat","et_joystickbutton","et_resize","et_quit","et_user","et_syswm"] }
canvas.EventType.et_active = ["et_active",1];
canvas.EventType.et_active.toString = $estr;
canvas.EventType.et_active.__enum__ = canvas.EventType;
canvas.EventType.et_joystickball = ["et_joystickball",8];
canvas.EventType.et_joystickball.toString = $estr;
canvas.EventType.et_joystickball.__enum__ = canvas.EventType;
canvas.EventType.et_joystickbutton = ["et_joystickbutton",10];
canvas.EventType.et_joystickbutton.toString = $estr;
canvas.EventType.et_joystickbutton.__enum__ = canvas.EventType;
canvas.EventType.et_joystickhat = ["et_joystickhat",9];
canvas.EventType.et_joystickhat.toString = $estr;
canvas.EventType.et_joystickhat.__enum__ = canvas.EventType;
canvas.EventType.et_joystickmove = ["et_joystickmove",7];
canvas.EventType.et_joystickmove.toString = $estr;
canvas.EventType.et_joystickmove.__enum__ = canvas.EventType;
canvas.EventType.et_keydown = ["et_keydown",2];
canvas.EventType.et_keydown.toString = $estr;
canvas.EventType.et_keydown.__enum__ = canvas.EventType;
canvas.EventType.et_keyup = ["et_keyup",3];
canvas.EventType.et_keyup.toString = $estr;
canvas.EventType.et_keyup.__enum__ = canvas.EventType;
canvas.EventType.et_mousebutton_down = ["et_mousebutton_down",5];
canvas.EventType.et_mousebutton_down.toString = $estr;
canvas.EventType.et_mousebutton_down.__enum__ = canvas.EventType;
canvas.EventType.et_mousebutton_up = ["et_mousebutton_up",6];
canvas.EventType.et_mousebutton_up.toString = $estr;
canvas.EventType.et_mousebutton_up.__enum__ = canvas.EventType;
canvas.EventType.et_mousemove = ["et_mousemove",4];
canvas.EventType.et_mousemove.toString = $estr;
canvas.EventType.et_mousemove.__enum__ = canvas.EventType;
canvas.EventType.et_noevent = ["et_noevent",0];
canvas.EventType.et_noevent.toString = $estr;
canvas.EventType.et_noevent.__enum__ = canvas.EventType;
canvas.EventType.et_quit = ["et_quit",12];
canvas.EventType.et_quit.toString = $estr;
canvas.EventType.et_quit.__enum__ = canvas.EventType;
canvas.EventType.et_resize = ["et_resize",11];
canvas.EventType.et_resize.toString = $estr;
canvas.EventType.et_resize.__enum__ = canvas.EventType;
canvas.EventType.et_syswm = ["et_syswm",14];
canvas.EventType.et_syswm.toString = $estr;
canvas.EventType.et_syswm.__enum__ = canvas.EventType;
canvas.EventType.et_user = ["et_user",13];
canvas.EventType.et_user.toString = $estr;
canvas.EventType.et_user.__enum__ = canvas.EventType;
canvas.MouseEventType = { __ename__ : ["canvas","MouseEventType"], __constructs__ : ["met_Move","met_LeftUp","met_LeftDown","met_MiddleUp","met_MiddleDown","met_RightUp","met_RightDown","met_MouseWheelUp","met_MouseWheelDown"] }
canvas.MouseEventType.met_LeftDown = ["met_LeftDown",2];
canvas.MouseEventType.met_LeftDown.toString = $estr;
canvas.MouseEventType.met_LeftDown.__enum__ = canvas.MouseEventType;
canvas.MouseEventType.met_LeftUp = ["met_LeftUp",1];
canvas.MouseEventType.met_LeftUp.toString = $estr;
canvas.MouseEventType.met_LeftUp.__enum__ = canvas.MouseEventType;
canvas.MouseEventType.met_MiddleDown = ["met_MiddleDown",4];
canvas.MouseEventType.met_MiddleDown.toString = $estr;
canvas.MouseEventType.met_MiddleDown.__enum__ = canvas.MouseEventType;
canvas.MouseEventType.met_MiddleUp = ["met_MiddleUp",3];
canvas.MouseEventType.met_MiddleUp.toString = $estr;
canvas.MouseEventType.met_MiddleUp.__enum__ = canvas.MouseEventType;
canvas.MouseEventType.met_MouseWheelDown = ["met_MouseWheelDown",8];
canvas.MouseEventType.met_MouseWheelDown.toString = $estr;
canvas.MouseEventType.met_MouseWheelDown.__enum__ = canvas.MouseEventType;
canvas.MouseEventType.met_MouseWheelUp = ["met_MouseWheelUp",7];
canvas.MouseEventType.met_MouseWheelUp.toString = $estr;
canvas.MouseEventType.met_MouseWheelUp.__enum__ = canvas.MouseEventType;
canvas.MouseEventType.met_Move = ["met_Move",0];
canvas.MouseEventType.met_Move.toString = $estr;
canvas.MouseEventType.met_Move.__enum__ = canvas.MouseEventType;
canvas.MouseEventType.met_RightDown = ["met_RightDown",6];
canvas.MouseEventType.met_RightDown.toString = $estr;
canvas.MouseEventType.met_RightDown.__enum__ = canvas.MouseEventType;
canvas.MouseEventType.met_RightUp = ["met_RightUp",5];
canvas.MouseEventType.met_RightUp.toString = $estr;
canvas.MouseEventType.met_RightUp.__enum__ = canvas.MouseEventType;
neash.text.KeyCode = function() { }
neash.text.KeyCode.__name__ = ["neash","text","KeyCode"];
neash.text.KeyCode.ConvertCode = function(inNME) {
	if(inNME <= 32 || (inNME >= neash.text.KeyCode.KEY_0 && inNME <= neash.text.KeyCode.KEY_9)) return inNME;
	if(inNME >= 97 && inNME <= 122) return inNME - 97 + 65;
	if(inNME >= canvas.KeyCode.F1 && inNME <= canvas.KeyCode.F15) return inNME - canvas.KeyCode.F1 + neash.text.KeyCode.F1;
	if(inNME >= canvas.KeyCode.KP0 && inNME <= canvas.KeyCode.KP9) return inNME - canvas.KeyCode.KP0 + neash.text.KeyCode.KP0;
	switch(inNME) {
	case canvas.KeyCode.KP_PERIOD:{
		return neash.text.KeyCode.KP_PERIOD;
	}break;
	case canvas.KeyCode.KP_DIVIDE:{
		return neash.text.KeyCode.KP_DIVIDE;
	}break;
	case canvas.KeyCode.KP_MULTIPLY:{
		return neash.text.KeyCode.KP_MULTIPLY;
	}break;
	case canvas.KeyCode.KP_MINUS:{
		return neash.text.KeyCode.KP_SUBTRACT;
	}break;
	case canvas.KeyCode.KP_PLUS:{
		return neash.text.KeyCode.KP_ADD;
	}break;
	case canvas.KeyCode.KP_ENTER:{
		return neash.text.KeyCode.KP_ENTER;
	}break;
	case canvas.KeyCode.UP:{
		return neash.text.KeyCode.UP;
	}break;
	case canvas.KeyCode.DOWN:{
		return neash.text.KeyCode.DOWN;
	}break;
	case canvas.KeyCode.RIGHT:{
		return neash.text.KeyCode.RIGHT;
	}break;
	case canvas.KeyCode.LEFT:{
		return neash.text.KeyCode.LEFT;
	}break;
	case canvas.KeyCode.INSERT:{
		return neash.text.KeyCode.INSERT;
	}break;
	case canvas.KeyCode.DELETE:{
		return neash.text.KeyCode.DELETE;
	}break;
	case canvas.KeyCode.HOME:{
		return neash.text.KeyCode.HOME;
	}break;
	case canvas.KeyCode.END:{
		return neash.text.KeyCode.END;
	}break;
	case canvas.KeyCode.PAGEUP:{
		return neash.text.KeyCode.PAGEUP;
	}break;
	case canvas.KeyCode.PAGEDOWN:{
		return neash.text.KeyCode.PAGEDOWN;
	}break;
	case canvas.KeyCode.NUMLOCK:{
		return neash.text.KeyCode.NUMLOCK;
	}break;
	case canvas.KeyCode.CAPSLOCK:{
		return neash.text.KeyCode.CAPSLOCK;
	}break;
	case canvas.KeyCode.RSHIFT:{
		return neash.text.KeyCode.SHIFT;
	}break;
	case canvas.KeyCode.LSHIFT:{
		return neash.text.KeyCode.SHIFT;
	}break;
	case canvas.KeyCode.RCTRL:{
		return neash.text.KeyCode.CONTROL;
	}break;
	case canvas.KeyCode.LCTRL:{
		return neash.text.KeyCode.CONTROL;
	}break;
	}
	return 0;
}
neash.text.KeyCode.ConvertASCII = function(inNME,inShift,inControl) {
	if(inNME >= 97 && inNME <= 122 && inShift) return inNME - 97 + 65;
	else if(inNME >= 97 && inNME <= 122 && inControl) return inNME - 97 + 1;
	if(inNME < 128) return inNME;
	return 0;
}
neash.text.KeyCode.ConvertLocation = function(inNME) {
	if(inNME == canvas.KeyCode.RCTRL || inNME == canvas.KeyCode.RSHIFT) return 1;
	return 0;
}
neash.text.KeyCode.prototype.__class__ = neash.text.KeyCode;
canvas.Manager = function(width,height,title,cb) { if( width === $_ ) return; {
	canvas.Manager.__scr = js.Lib.window.document.getElementById(title);
	if(canvas.Manager.__scr == null) throw "Element with id '" + title + "' not found";
	this.mFrameCount = 0;
}}
canvas.Manager.__name__ = ["canvas","Manager"];
canvas.Manager.__scr = null;
canvas.Manager.__evt = null;
canvas.Manager.graphics = null;
canvas.Manager.draw_quality = null;
canvas.Manager.SetCursor = function(inCursor) {
	if(inCursor == 0) {
		canvas.Manager.__scr.style.cursor = "url(\"blank.cur\"), pointer";
	}
	else {
		canvas.Manager.__scr.style.cursor = "auto";
	}
}
canvas.Manager.GetMouse = function() {
	throw "Not implemented. GetMouse";
	return null;
}
canvas.Manager.mouseEvent = function(inType) {
	return { type : inType, x : canvas.Manager.SmouseX(), y : canvas.Manager.SmouseY(), shift : false, ctrl : false, alt : false, leftIsDown : canvas.Manager.mouseButtonState() != 0, middleIsDown : false, rightIsDown : false}
}
canvas.Manager.getScreen = function() {
	if(canvas.Manager.__scr == null) {
		throw "Fatal error: Neash is not initiated.";
	}
	return canvas.Manager.__scr.getContext("2d");
}
canvas.Manager.mouseButtonState = function() {
	return Reflect.field(canvas.Manager.__evt,"state");
}
canvas.Manager.SmouseX = function() {
	return Reflect.field(canvas.Manager.__evt,"x");
}
canvas.Manager.SmouseY = function() {
	return Reflect.field(canvas.Manager.__evt,"y");
}
canvas.Manager.set_draw_quality = function(inQuality) {
	throw "Not implemented. set_draw_quality. ";
	return null;
}
canvas.Manager.get_draw_quality = function() {
	throw "Not implemented. get_draw_quality.";
	return null;
}
canvas.Manager.setClipboardString = function(inString) {
	throw "Not implemented. setClipboardString.";
}
canvas.Manager.prototype.OnResize = function(inW,inH) {
	throw "Not implemented. OnResize. ";
	canvas.Manager.graphics.SetSurface(canvas.Manager.__scr);
}
canvas.Manager.prototype.clear = function(color) {
	var ctx = canvas.Manager.getScreen();
	var stage = neash.Lib.GetCurrent().GetStage();
	ctx.translate(0,0);
	ctx.fillStyle = "#" + StringTools.hex(color);
	ctx.fillRect(0,0,stage.GetStageWidth(),stage.GetStageHeight());
}
canvas.Manager.prototype.getEventType = function() {
	var returnType = canvas.EventType.et_noevent;
	switch(Reflect.field(canvas.Manager.__evt,"type")) {
	case -1:{
		returnType = canvas.EventType.et_noevent;
	}break;
	case 0:{
		returnType = canvas.EventType.et_active;
	}break;
	case 1:{
		returnType = canvas.EventType.et_keydown;
	}break;
	case 2:{
		returnType = canvas.EventType.et_keyup;
	}break;
	case 3:{
		returnType = canvas.EventType.et_mousemove;
	}break;
	case 4:{
		returnType = canvas.EventType.et_mousebutton_down;
	}break;
	case 5:{
		returnType = canvas.EventType.et_mousebutton_up;
	}break;
	case 6:{
		returnType = canvas.EventType.et_joystickmove;
	}break;
	case 7:{
		returnType = canvas.EventType.et_joystickball;
	}break;
	case 8:{
		returnType = canvas.EventType.et_joystickhat;
	}break;
	case 9:{
		returnType = canvas.EventType.et_joystickbutton;
	}break;
	case 10:{
		returnType = canvas.EventType.et_resize;
	}break;
	case 11:{
		returnType = canvas.EventType.et_quit;
	}break;
	case 12:{
		returnType = canvas.EventType.et_user;
	}break;
	case 13:{
		returnType = canvas.EventType.et_syswm;
	}break;
	}
	return returnType;
}
canvas.Manager.prototype.getNextEvent = function() {
	throw "Not implemented. getNextEvent .";
	return null;
}
canvas.Manager.prototype.keyEventCallbacks = null;
canvas.Manager.prototype.lastChar = function() {
	return Reflect.field(canvas.Manager.__evt,"char");
}
canvas.Manager.prototype.lastKey = function() {
	return Reflect.field(canvas.Manager.__evt,"key");
}
canvas.Manager.prototype.lastKeyAlt = function() {
	return Reflect.field(canvas.Manager.__evt,"alt");
}
canvas.Manager.prototype.lastKeyCtrl = function() {
	return Reflect.field(canvas.Manager.__evt,"ctrl");
}
canvas.Manager.prototype.lastKeyShift = function() {
	return Reflect.field(canvas.Manager.__evt,"shift");
}
canvas.Manager.prototype.mFrameCount = null;
canvas.Manager.prototype.mPaused = null;
canvas.Manager.prototype.mT0 = null;
canvas.Manager.prototype.mainLoopRunning = null;
canvas.Manager.prototype.mouseButton = function() {
	return Reflect.field(canvas.Manager.__evt,"button");
}
canvas.Manager.prototype.mouseClickCallbacks = null;
canvas.Manager.prototype.mouseEventCallbacks = null;
canvas.Manager.prototype.renderCallbacks = null;
canvas.Manager.prototype.timerStack = null;
canvas.Manager.prototype.tryQuitFunction = null;
canvas.Manager.prototype.updateCallbacks = null;
canvas.Manager.prototype.__class__ = canvas.Manager;
canvas.utils = {}
canvas.utils.Endian = { __ename__ : ["canvas","utils","Endian"], __constructs__ : ["BIG_ENDIAN","LITTLE_ENDIAN"] }
canvas.utils.Endian.BIG_ENDIAN = ["BIG_ENDIAN",0];
canvas.utils.Endian.BIG_ENDIAN.toString = $estr;
canvas.utils.Endian.BIG_ENDIAN.__enum__ = canvas.utils.Endian;
canvas.utils.Endian.LITTLE_ENDIAN = ["LITTLE_ENDIAN",1];
canvas.utils.Endian.LITTLE_ENDIAN.toString = $estr;
canvas.utils.Endian.LITTLE_ENDIAN.__enum__ = canvas.utils.Endian;
neash.geom = {}
neash.geom.ColorTransform = function(inRedMultiplier,inGreenMultiplier,inBlueMultiplier,inAlphaMultiplier,inRedOffset,inGreenOffset,inBlueOffset,inAlphaOffset) { if( inRedMultiplier === $_ ) return; {
	this.redMultiplier = (inRedMultiplier == null?1.0:inRedMultiplier);
	this.greenMultiplier = (inGreenMultiplier == null?1.0:inGreenMultiplier);
	this.blueMultiplier = (inBlueMultiplier == null?1.0:inBlueMultiplier);
	this.alphaMultiplier = (inAlphaMultiplier == null?1.0:inAlphaMultiplier);
	this.redOffset = (inRedOffset == null?0.0:inRedOffset);
	this.greenOffset = (inGreenOffset == null?0.0:inGreenOffset);
	this.blueOffset = (inBlueOffset == null?0.0:inBlueOffset);
	this.alphaOffset = (inAlphaOffset == null?0.0:inAlphaOffset);
	this.color = 0;
}}
neash.geom.ColorTransform.__name__ = ["neash","geom","ColorTransform"];
neash.geom.ColorTransform.prototype.alphaMultiplier = null;
neash.geom.ColorTransform.prototype.alphaOffset = null;
neash.geom.ColorTransform.prototype.blueMultiplier = null;
neash.geom.ColorTransform.prototype.blueOffset = null;
neash.geom.ColorTransform.prototype.color = null;
neash.geom.ColorTransform.prototype.concat = function(second) {
	throw "Not implemented";
}
neash.geom.ColorTransform.prototype.greenMultiplier = null;
neash.geom.ColorTransform.prototype.greenOffset = null;
neash.geom.ColorTransform.prototype.redMultiplier = null;
neash.geom.ColorTransform.prototype.redOffset = null;
neash.geom.ColorTransform.prototype.__class__ = neash.geom.ColorTransform;
StringTools = function() { }
StringTools.__name__ = ["StringTools"];
StringTools.urlEncode = function(s) {
	return encodeURIComponent(s);
}
StringTools.urlDecode = function(s) {
	return decodeURIComponent(s.split("+").join(" "));
}
StringTools.htmlEscape = function(s) {
	return s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
}
StringTools.htmlUnescape = function(s) {
	return s.split("&gt;").join(">").split("&lt;").join("<").split("&amp;").join("&");
}
StringTools.startsWith = function(s,start) {
	return (s.length >= start.length && s.substr(0,start.length) == start);
}
StringTools.endsWith = function(s,end) {
	var elen = end.length;
	var slen = s.length;
	return (slen >= elen && s.substr(slen - elen,elen) == end);
}
StringTools.isSpace = function(s,pos) {
	var c = s.charCodeAt(pos);
	return (c >= 9 && c <= 13) || c == 32;
}
StringTools.ltrim = function(s) {
	var l = s.length;
	var r = 0;
	while(r < l && StringTools.isSpace(s,r)) {
		r++;
	}
	if(r > 0) return s.substr(r,l - r);
	else return s;
}
StringTools.rtrim = function(s) {
	var l = s.length;
	var r = 0;
	while(r < l && StringTools.isSpace(s,l - r - 1)) {
		r++;
	}
	if(r > 0) {
		return s.substr(0,l - r);
	}
	else {
		return s;
	}
}
StringTools.trim = function(s) {
	return StringTools.ltrim(StringTools.rtrim(s));
}
StringTools.rpad = function(s,c,l) {
	var sl = s.length;
	var cl = c.length;
	while(sl < l) {
		if(l - sl < cl) {
			s += c.substr(0,l - sl);
			sl = l;
		}
		else {
			s += c;
			sl += cl;
		}
	}
	return s;
}
StringTools.lpad = function(s,c,l) {
	var ns = "";
	var sl = s.length;
	if(sl >= l) return s;
	var cl = c.length;
	while(sl < l) {
		if(l - sl < cl) {
			ns += c.substr(0,l - sl);
			sl = l;
		}
		else {
			ns += c;
			sl += cl;
		}
	}
	return ns + s;
}
StringTools.replace = function(s,sub,by) {
	return s.split(sub).join(by);
}
StringTools.hex = function(n,digits) {
	var neg = false;
	if(n < 0) {
		neg = true;
		n = -n;
	}
	var s = n.toString(16);
	s = s.toUpperCase();
	if(digits != null) while(s.length < digits) s = "0" + s;
	if(neg) s = "-" + s;
	return s;
}
StringTools.prototype.__class__ = StringTools;
haxe = {}
haxe.Firebug = function() { }
haxe.Firebug.__name__ = ["haxe","Firebug"];
haxe.Firebug.detect = function() {
	try {
		return console != null && console.error != null;
	}
	catch( $e3 ) {
		{
			var e = $e3;
			{
				return false;
			}
		}
	}
}
haxe.Firebug.redirectTraces = function() {
	haxe.Log.trace = $closure(haxe.Firebug,"trace");
	js.Lib.setErrorHandler($closure(haxe.Firebug,"onError"));
}
haxe.Firebug.onError = function(err,stack) {
	var buf = err + "\n";
	{
		var _g = 0;
		while(_g < stack.length) {
			var s = stack[_g];
			++_g;
			buf += "Called from " + s + "\n";
		}
	}
	haxe.Firebug.trace(buf,null);
	return true;
}
haxe.Firebug.trace = function(v,inf) {
	var type = (inf != null && inf.customParams != null?inf.customParams[0]:null);
	if(type != "warn" && type != "info" && type != "debug" && type != "error") type = (inf == null?"error":"log");
	console[type](((inf == null?"":inf.fileName + ":" + inf.lineNumber + " : ")) + Std.string(v));
}
haxe.Firebug.prototype.__class__ = haxe.Firebug;
neash.text.TextFormatAlign = function() { }
neash.text.TextFormatAlign.__name__ = ["neash","text","TextFormatAlign"];
neash.text.TextFormatAlign.prototype.__class__ = neash.text.TextFormatAlign;
haxe.io = {}
haxe.io.Bytes = function(length,b) { if( length === $_ ) return; {
	this.length = length;
	this.b = b;
}}
haxe.io.Bytes.__name__ = ["haxe","io","Bytes"];
haxe.io.Bytes.alloc = function(length) {
	var a = new Array();
	{
		var _g = 0;
		while(_g < length) {
			var i = _g++;
			a.push(0);
		}
	}
	return new haxe.io.Bytes(length,a);
}
haxe.io.Bytes.ofString = function(s) {
	var a = new Array();
	{
		var _g1 = 0, _g = s.length;
		while(_g1 < _g) {
			var i = _g1++;
			var c = s["cca"](i);
			if(c <= 127) a.push(c);
			else if(c <= 2047) {
				a.push(192 | (c >> 6));
				a.push(128 | (c & 63));
			}
			else if(c <= 65535) {
				a.push(224 | (c >> 12));
				a.push(128 | ((c >> 6) & 63));
				a.push(128 | (c & 63));
			}
			else {
				a.push(240 | (c >> 18));
				a.push(128 | ((c >> 12) & 63));
				a.push(128 | ((c >> 6) & 63));
				a.push(128 | (c & 63));
			}
		}
	}
	return new haxe.io.Bytes(a.length,a);
}
haxe.io.Bytes.ofData = function(b) {
	return new haxe.io.Bytes(b.length,b);
}
haxe.io.Bytes.prototype.b = null;
haxe.io.Bytes.prototype.blit = function(pos,src,srcpos,len) {
	if(pos < 0 || srcpos < 0 || len < 0 || pos + len > this.length || srcpos + len > src.length) throw haxe.io.Error.OutsideBounds;
	var b1 = this.b;
	var b2 = src.b;
	if(b1 == b2 && pos > srcpos) {
		var i = len;
		while(i > 0) {
			i--;
			b1[i + pos] = b2[i + srcpos];
		}
		return;
	}
	{
		var _g = 0;
		while(_g < len) {
			var i = _g++;
			b1[i + pos] = b2[i + srcpos];
		}
	}
}
haxe.io.Bytes.prototype.compare = function(other) {
	var b1 = this.b;
	var b2 = other.b;
	var len = ((this.length < other.length)?this.length:other.length);
	{
		var _g = 0;
		while(_g < len) {
			var i = _g++;
			if(b1[i] != b2[i]) return b1[i] - b2[i];
		}
	}
	return this.length - other.length;
}
haxe.io.Bytes.prototype.get = function(pos) {
	return this.b[pos];
}
haxe.io.Bytes.prototype.getData = function() {
	return this.b;
}
haxe.io.Bytes.prototype.length = null;
haxe.io.Bytes.prototype.readString = function(pos,len) {
	if(pos < 0 || len < 0 || pos + len > this.length) throw haxe.io.Error.OutsideBounds;
	var s = "";
	var b = this.b;
	var fcc = $closure(String,"fromCharCode");
	var i = pos;
	var max = pos + len;
	while(i < max) {
		var c = b[i++];
		if(c < 128) {
			if(c == 0) break;
			s += fcc(c);
		}
		else if(c < 224) s += fcc(((c & 63) << 6) | (b[i++] & 127));
		else if(c < 240) {
			var c2 = b[i++];
			s += fcc((((c & 31) << 12) | ((c2 & 127) << 6)) | (b[i++] & 127));
		}
		else {
			var c2 = b[i++];
			var c3 = b[i++];
			s += fcc(((((c & 15) << 18) | ((c2 & 127) << 12)) | ((c3 << 6) & 127)) | (b[i++] & 127));
		}
	}
	return s;
}
haxe.io.Bytes.prototype.set = function(pos,v) {
	this.b[pos] = v;
}
haxe.io.Bytes.prototype.sub = function(pos,len) {
	if(pos < 0 || len < 0 || pos + len > this.length) throw haxe.io.Error.OutsideBounds;
	return new haxe.io.Bytes(len,this.b.slice(pos,pos + len));
}
haxe.io.Bytes.prototype.toString = function() {
	return this.readString(0,this.length);
}
haxe.io.Bytes.prototype.__class__ = haxe.io.Bytes;
neash.display.StageAlign = { __ename__ : ["neash","display","StageAlign"], __constructs__ : ["TOP_RIGHT","TOP_LEFT","TOP","RIGHT","LEFT","BOTTOM_RIGHT","BOTTOM_LEFT","BOTTOM"] }
neash.display.StageAlign.BOTTOM = ["BOTTOM",7];
neash.display.StageAlign.BOTTOM.toString = $estr;
neash.display.StageAlign.BOTTOM.__enum__ = neash.display.StageAlign;
neash.display.StageAlign.BOTTOM_LEFT = ["BOTTOM_LEFT",6];
neash.display.StageAlign.BOTTOM_LEFT.toString = $estr;
neash.display.StageAlign.BOTTOM_LEFT.__enum__ = neash.display.StageAlign;
neash.display.StageAlign.BOTTOM_RIGHT = ["BOTTOM_RIGHT",5];
neash.display.StageAlign.BOTTOM_RIGHT.toString = $estr;
neash.display.StageAlign.BOTTOM_RIGHT.__enum__ = neash.display.StageAlign;
neash.display.StageAlign.LEFT = ["LEFT",4];
neash.display.StageAlign.LEFT.toString = $estr;
neash.display.StageAlign.LEFT.__enum__ = neash.display.StageAlign;
neash.display.StageAlign.RIGHT = ["RIGHT",3];
neash.display.StageAlign.RIGHT.toString = $estr;
neash.display.StageAlign.RIGHT.__enum__ = neash.display.StageAlign;
neash.display.StageAlign.TOP = ["TOP",2];
neash.display.StageAlign.TOP.toString = $estr;
neash.display.StageAlign.TOP.__enum__ = neash.display.StageAlign;
neash.display.StageAlign.TOP_LEFT = ["TOP_LEFT",1];
neash.display.StageAlign.TOP_LEFT.toString = $estr;
neash.display.StageAlign.TOP_LEFT.__enum__ = neash.display.StageAlign;
neash.display.StageAlign.TOP_RIGHT = ["TOP_RIGHT",0];
neash.display.StageAlign.TOP_RIGHT.toString = $estr;
neash.display.StageAlign.TOP_RIGHT.__enum__ = neash.display.StageAlign;
canvas.filters.BitmapFilterSet = function(inFilters) { if( inFilters === $_ ) return; {
	this.mOffset = new canvas.geom.Point();
}}
canvas.filters.BitmapFilterSet.__name__ = ["canvas","filters","BitmapFilterSet"];
canvas.filters.BitmapFilterSet.prototype.FilterImage = function(inImage) {
	throw "Not implemented. FilterImage";
	return null;
}
canvas.filters.BitmapFilterSet.prototype.GetOffsetX = function() {
	return Std["int"](this.mOffset.x);
}
canvas.filters.BitmapFilterSet.prototype.GetOffsetY = function() {
	return Std["int"](this.mOffset.y);
}
canvas.filters.BitmapFilterSet.prototype.mHandle = null;
canvas.filters.BitmapFilterSet.prototype.mOffset = null;
canvas.filters.BitmapFilterSet.prototype.__class__ = canvas.filters.BitmapFilterSet;
neash.text.TextFormat = function(in_font,in_size,in_color,in_bold,in_italic,in_underline,in_url,in_target,in_align,in_leftMargin,in_rightMargin,in_indent,in_leading) { if( in_font === $_ ) return; {
	this.font = in_font;
	this.size = in_size;
	this.color = in_color;
	this.bold = in_bold;
	this.italic = in_italic;
	this.underline = in_underline;
	this.url = in_url;
	this.target = in_target;
	this.align = in_align;
	this.leftMargin = in_leftMargin;
	this.rightMargin = in_rightMargin;
	this.indent = in_indent;
	this.leading = in_leading;
}}
neash.text.TextFormat.__name__ = ["neash","text","TextFormat"];
neash.text.TextFormat.prototype.align = null;
neash.text.TextFormat.prototype.blockIndent = null;
neash.text.TextFormat.prototype.bold = null;
neash.text.TextFormat.prototype.bullet = null;
neash.text.TextFormat.prototype.color = null;
neash.text.TextFormat.prototype.display = null;
neash.text.TextFormat.prototype.font = null;
neash.text.TextFormat.prototype.indent = null;
neash.text.TextFormat.prototype.italic = null;
neash.text.TextFormat.prototype.kerning = null;
neash.text.TextFormat.prototype.leading = null;
neash.text.TextFormat.prototype.leftMargin = null;
neash.text.TextFormat.prototype.letterSpacing = null;
neash.text.TextFormat.prototype.rightMargin = null;
neash.text.TextFormat.prototype.size = null;
neash.text.TextFormat.prototype.tabStops = null;
neash.text.TextFormat.prototype.target = null;
neash.text.TextFormat.prototype.underline = null;
neash.text.TextFormat.prototype.url = null;
neash.text.TextFormat.prototype.__class__ = neash.text.TextFormat;
canvas.utils.ByteArray = function() { }
canvas.utils.ByteArray.__name__ = ["canvas","utils","ByteArray"];
canvas.utils.ByteArray.prototype.bytesAvailable = null;
canvas.utils.ByteArray.prototype.endian = null;
canvas.utils.ByteArray.prototype.length = null;
canvas.utils.ByteArray.prototype.objectEncoding = null;
canvas.utils.ByteArray.prototype.position = null;
canvas.utils.ByteArray.prototype.readByte = function() {
	throw "Not implemented. readByte.";
	return null;
}
canvas.utils.ByteArray.prototype.readFloat = function() {
	throw "Not implemented. readFloat.";
	return null;
}
canvas.utils.ByteArray.prototype.readUnsignedByte = function() {
	throw "Not implemented. readUnsignedByte.";
	return null;
}
canvas.utils.ByteArray.prototype.readUnsignedInt = function() {
	throw "Not implemented. readUnsignedInt.";
	return null;
}
canvas.utils.ByteArray.prototype.readUnsignedShort = function() {
	throw "Not implemented. readUnsignedShort. ";
	return null;
}
canvas.utils.ByteArray.prototype.__class__ = canvas.utils.ByteArray;
sandy.core.interaction = {}
sandy.core.interaction.VirtualMouse = function(access) { if( access === $_ ) return; {
	this.lastWithinStage = true;
	neash.events.EventDispatcher.apply(this,[]);
	this.location = new canvas.geom.Point(0,0);
	this.lastLocation = this.location.clone();
}}
sandy.core.interaction.VirtualMouse.__name__ = ["sandy","core","interaction","VirtualMouse"];
sandy.core.interaction.VirtualMouse.__super__ = neash.events.EventDispatcher;
for(var k in neash.events.EventDispatcher.prototype ) sandy.core.interaction.VirtualMouse.prototype[k] = neash.events.EventDispatcher.prototype[k];
sandy.core.interaction.VirtualMouse._oI = null;
sandy.core.interaction.VirtualMouse.getInstance = function() {
	if(sandy.core.interaction.VirtualMouse._oI == null) sandy.core.interaction.VirtualMouse._oI = new sandy.core.interaction.VirtualMouse(new sandy.core.interaction.PrivateConstructorAccess());
	return sandy.core.interaction.VirtualMouse._oI;
}
sandy.core.interaction.VirtualMouse.prototype._checkLinks = function(tf) {
	var currentTargetLocal = tf.globalToLocal(this.location);
	var a = sandy.core.interaction.TextLink.getTextLinks(tf);
	var l = a.length;
	{
		var _g = 0;
		while(_g < l) {
			var i = _g++;
			if(function($this) {
				var $r;
				var tmp = (function($this) {
					var $r;
					var tmp = a[i];
					$r = (Std["is"](tmp,sandy.core.interaction.TextLink)?tmp:function($this) {
						var $r;
						throw "Class cast error";
						return $r;
					}($this));
					return $r;
				}($this)).getBounds();
				$r = (Std["is"](tmp,canvas.geom.Rectangle)?tmp:function($this) {
					var $r;
					throw "Class cast error";
					return $r;
				}($this));
				return $r;
			}(this).containsPoint(currentTargetLocal)) 1 + 1;
		}
	}
}
sandy.core.interaction.VirtualMouse.prototype._lastEvent = null;
sandy.core.interaction.VirtualMouse.prototype.interactWithTexture = function(p_oPoly,p_uvTexture,p_event) {
	var l_oMaterial = (p_oPoly.visible?p_oPoly.__getAppearance().__getFrontMaterial():p_oPoly.__getAppearance().__getBackMaterial());
	if(l_oMaterial == null) return;
	this.m_ioTarget = l_oMaterial.__getMovie();
	this.location = new canvas.geom.Point(p_uvTexture.u * l_oMaterial.__getTexture().getWidth(),p_uvTexture.v * l_oMaterial.__getTexture().getHeight());
	var objectsUnderPoint = this.m_ioTarget.getObjectsUnderPoint(this.m_ioTarget.localToGlobal(this.location));
	var currentTarget = null;
	var currentParent;
	var i = objectsUnderPoint.length;
	while(--i > -1) {
		currentParent = objectsUnderPoint[i];
		while(currentParent != null) {
			if(currentTarget != null && Std["is"](currentParent,neash.display.DisplayObjectContainer) && !function($this) {
				var $r;
				var tmp = currentParent;
				$r = (Std["is"](tmp,neash.display.DisplayObjectContainer)?tmp:function($this) {
					var $r;
					throw "Class cast error";
					return $r;
				}($this));
				return $r;
			}(this).mouseChildren) {
				currentTarget = null;
			}
			if(currentTarget == null && Std["is"](currentParent,neash.display.DisplayObjectContainer) && function($this) {
				var $r;
				var tmp = currentParent;
				$r = (Std["is"](tmp,neash.display.DisplayObjectContainer)?tmp:function($this) {
					var $r;
					throw "Class cast error";
					return $r;
				}($this));
				return $r;
			}(this).mouseEnabled) {
				currentTarget = function($this) {
					var $r;
					var tmp = currentParent;
					$r = (Std["is"](tmp,neash.display.Sprite)?tmp:function($this) {
						var $r;
						throw "Class cast error";
						return $r;
					}($this));
					return $r;
				}(this);
			}
			currentParent = currentParent.GetParent();
		}
	}
	if(currentTarget == null) {
		currentTarget = this.m_ioTarget;
	}
	if(this.m_ioOldTarget == null) currentTarget.GetStage();
	var targetLocal = p_oPoly.__getContainer().globalToLocal(this.location);
	var currentTargetLocal = currentTarget.globalToLocal(this.location);
	if(this.lastLocation.x != this.location.x || this.lastLocation.y != this.location.y) {
		var withinStage = (this.location.x >= 0 && this.location.y >= 0 && this.location.x <= p_oPoly.__getContainer().GetStage().GetStageWidth() && this.location.y <= p_oPoly.__getContainer().GetStage().GetStageHeight());
		if(!withinStage && this.lastWithinStage) {
			this._lastEvent = new neash.events.MouseEvent(neash.events.Event.MOUSE_LEAVE,false,false);
			p_oPoly.__getContainer().GetStage().dispatchEvent(this._lastEvent);
			this.dispatchEvent(this._lastEvent);
		}
		if(withinStage) {
			this._lastEvent = new neash.events.MouseEvent(neash.events.Event.MOUSE_LEAVE,false,false);
			currentTarget.dispatchEvent(this._lastEvent);
			this.dispatchEvent(this._lastEvent);
		}
		this.lastWithinStage = withinStage;
	}
	if(currentTarget != this.m_ioOldTarget) {
		this._lastEvent = new neash.events.MouseEvent(neash.events.MouseEvent.MOUSE_OUT,true,false,targetLocal.x,targetLocal.y,currentTarget,(p_event.ctrlKey),(p_event.altKey),(p_event.shiftKey),(p_event.buttonDown),(p_event.delta));
		this.m_ioTarget.dispatchEvent(this._lastEvent);
		this.dispatchEvent(this._lastEvent);
		this._lastEvent = new neash.events.MouseEvent(neash.events.MouseEvent.ROLL_OUT,false,false,targetLocal.x,targetLocal.y,currentTarget,(p_event.ctrlKey),(p_event.altKey),(p_event.shiftKey),(p_event.buttonDown),(p_event.delta));
		this.m_ioTarget.dispatchEvent(this._lastEvent);
		this.dispatchEvent(this._lastEvent);
		this._lastEvent = new neash.events.MouseEvent(neash.events.MouseEvent.MOUSE_OVER,true,false,currentTargetLocal.x,currentTargetLocal.y,this.m_ioOldTarget,(p_event.ctrlKey),(p_event.altKey),(p_event.shiftKey),(p_event.buttonDown),(p_event.delta));
		currentTarget.dispatchEvent(this._lastEvent);
		this.dispatchEvent(this._lastEvent);
		this._lastEvent = new neash.events.MouseEvent(neash.events.MouseEvent.ROLL_OVER,false,false,currentTargetLocal.x,currentTargetLocal.y,this.m_ioOldTarget,(p_event.ctrlKey),(p_event.altKey),(p_event.shiftKey),(p_event.buttonDown),(p_event.delta));
		currentTarget.dispatchEvent(this._lastEvent);
		this.dispatchEvent(this._lastEvent);
	}
	if(p_event.type == neash.events.MouseEvent.MOUSE_DOWN) {
		this._lastEvent = new neash.events.MouseEvent(neash.events.MouseEvent.MOUSE_DOWN,true,false,currentTargetLocal.x,currentTargetLocal.y,currentTarget,(p_event.ctrlKey),(p_event.altKey),(p_event.shiftKey),(p_event.buttonDown),(p_event.delta));
		currentTarget.dispatchEvent(this._lastEvent);
		this.dispatchEvent(this._lastEvent);
		this.lastDownTarget = currentTarget;
	}
	else if(p_event.type == neash.events.MouseEvent.MOUSE_UP) {
		this._lastEvent = new neash.events.MouseEvent(neash.events.MouseEvent.MOUSE_UP,true,false,currentTargetLocal.x,currentTargetLocal.y,currentTarget,(p_event.ctrlKey),(p_event.altKey),(p_event.shiftKey),(p_event.buttonDown),(p_event.delta));
		currentTarget.dispatchEvent(this._lastEvent);
		this.dispatchEvent(this._lastEvent);
	}
	else if(p_event.type == neash.events.MouseEvent.CLICK) {
		this._lastEvent = new neash.events.MouseEvent(neash.events.MouseEvent.CLICK,true,false,currentTargetLocal.x,currentTargetLocal.y,currentTarget,(p_event.ctrlKey),(p_event.altKey),(p_event.shiftKey),(p_event.buttonDown),(p_event.delta));
		currentTarget.dispatchEvent(this._lastEvent);
		this.dispatchEvent(this._lastEvent);
		this.lastDownTarget = null;
	}
	this.lastLocation = this.location.clone();
	this.m_ioOldTarget = currentTarget;
}
sandy.core.interaction.VirtualMouse.prototype.lastDownTarget = null;
sandy.core.interaction.VirtualMouse.prototype.lastLocation = null;
sandy.core.interaction.VirtualMouse.prototype.lastWithinStage = null;
sandy.core.interaction.VirtualMouse.prototype.location = null;
sandy.core.interaction.VirtualMouse.prototype.m_ioOldTarget = null;
sandy.core.interaction.VirtualMouse.prototype.m_ioTarget = null;
sandy.core.interaction.VirtualMouse.prototype.__class__ = sandy.core.interaction.VirtualMouse;
sandy.core.interaction.PrivateConstructorAccess = function(p) { if( p === $_ ) return; {
	null;
}}
sandy.core.interaction.PrivateConstructorAccess.__name__ = ["sandy","core","interaction","PrivateConstructorAccess"];
sandy.core.interaction.PrivateConstructorAccess.prototype.__class__ = sandy.core.interaction.PrivateConstructorAccess;
haxe.io.BytesBuffer = function(p) { if( p === $_ ) return; {
	this.b = new Array();
}}
haxe.io.BytesBuffer.__name__ = ["haxe","io","BytesBuffer"];
haxe.io.BytesBuffer.prototype.add = function(src) {
	var b1 = this.b;
	var b2 = src.b;
	{
		var _g1 = 0, _g = src.length;
		while(_g1 < _g) {
			var i = _g1++;
			this.b.push(b2[i]);
		}
	}
}
haxe.io.BytesBuffer.prototype.addByte = function($byte) {
	this.b.push($byte);
}
haxe.io.BytesBuffer.prototype.addBytes = function(src,pos,len) {
	if(pos < 0 || len < 0 || pos + len > src.length) throw haxe.io.Error.OutsideBounds;
	var b1 = this.b;
	var b2 = src.b;
	{
		var _g1 = pos, _g = pos + len;
		while(_g1 < _g) {
			var i = _g1++;
			this.b.push(b2[i]);
		}
	}
}
haxe.io.BytesBuffer.prototype.b = null;
haxe.io.BytesBuffer.prototype.getBytes = function() {
	var bytes = new haxe.io.Bytes(this.b.length,this.b);
	this.b = null;
	return bytes;
}
haxe.io.BytesBuffer.prototype.__class__ = haxe.io.BytesBuffer;
sandy.math = {}
sandy.math.PlaneMath = function() { }
sandy.math.PlaneMath.__name__ = ["sandy","math","PlaneMath"];
sandy.math.PlaneMath.normalizePlane = function(p_oPlane) {
	var mag;
	mag = Math.sqrt(p_oPlane.a * p_oPlane.a + p_oPlane.b * p_oPlane.b + p_oPlane.c * p_oPlane.c);
	p_oPlane.a = p_oPlane.a / mag;
	p_oPlane.b = p_oPlane.b / mag;
	p_oPlane.c = p_oPlane.c / mag;
	p_oPlane.d = p_oPlane.d / mag;
}
sandy.math.PlaneMath.distanceToPoint = function(p_oPlane,p_oPoint) {
	return p_oPlane.a * p_oPoint.x + p_oPlane.b * p_oPoint.y + p_oPlane.c * p_oPoint.z + p_oPlane.d;
}
sandy.math.PlaneMath.classifyPoint = function(p_oPlane,p_oPoint) {
	var d;
	d = sandy.math.PlaneMath.distanceToPoint(p_oPlane,p_oPoint);
	if(d < 0) return sandy.math.PlaneMath.NEGATIVE;
	if(d > 0) return sandy.math.PlaneMath.POSITIVE;
	return sandy.math.PlaneMath.ON_PLANE;
}
sandy.math.PlaneMath.computePlaneFromPoints = function(p_oPointA,p_oPointB,p_oPointC) {
	var n = sandy.math.VectorMath.cross(sandy.math.VectorMath.sub(p_oPointA,p_oPointB),sandy.math.VectorMath.sub(p_oPointA,p_oPointC));
	sandy.math.VectorMath.normalize(n);
	var d = sandy.math.VectorMath.dot(p_oPointA,n);
	return new sandy.core.data.Plane(n.x,n.y,n.z,d);
}
sandy.math.PlaneMath.createFromNormalAndPoint = function(p_oNormal,p_nPoint) {
	var p = new sandy.core.data.Plane();
	sandy.math.VectorMath.normalize(p_oNormal);
	p.a = p_oNormal.x;
	p.b = p_oNormal.y;
	p.c = p_oNormal.z;
	p.d = p_nPoint;
	sandy.math.PlaneMath.normalizePlane(p);
	return p;
}
sandy.math.PlaneMath.prototype.__class__ = sandy.math.PlaneMath;
canvas.FontHandle = function(inName,inSize) { if( inName === $_ ) return; {
	throw "Not implemented. new Fonthandle.";
}}
canvas.FontHandle.__name__ = ["canvas","FontHandle"];
canvas.FontHandle.prototype.GetFontMetrics = function() {
	throw "Not implemented. GetFontMetrics.";
	return null;
}
canvas.FontHandle.prototype.GetGlyphMetrics = function(inChar) {
	var c = (Type["typeof"](inChar) == ValueType.TInt?inChar:inChar.charCodeAt(0));
	throw "Not implemented. GetGlyphMetrics.";
	return null;
}
canvas.FontHandle.prototype.get_handle = function() {
	return this.mHandle;
}
canvas.FontHandle.prototype.handle = null;
canvas.FontHandle.prototype.mHandle = null;
canvas.FontHandle.prototype.__class__ = canvas.FontHandle;
sandy.math.IntersectionMath = function() { }
sandy.math.IntersectionMath.__name__ = ["sandy","math","IntersectionMath"];
sandy.math.IntersectionMath.intersectionBSphere = function(p_oBSphereA,p_oBSphereB) {
	var l_oVec = p_oBSphereA.position.clone();
	l_oVec.sub(p_oBSphereB.position);
	var l_nDist = p_oBSphereA.radius + p_oBSphereB.radius;
	var l_nNorm = l_oVec.getNorm();
	return (l_nNorm <= l_nDist);
}
sandy.math.IntersectionMath.intersectionLine3D = function(p_oPointA,p_oPointB,p_oPointC,p_oPointD) {
	var res = [new sandy.core.data.Vector(0.5 * (p_oPointA.x + p_oPointB.x),0.5 * (p_oPointA.y + p_oPointB.y),0.5 * (p_oPointA.z + p_oPointB.z)),new sandy.core.data.Vector(0.5 * (p_oPointC.x + p_oPointD.x),0.5 * (p_oPointC.y + p_oPointD.y),0.5 * (p_oPointC.z + p_oPointD.z))];
	var p13_x = p_oPointA.x - p_oPointC.x;
	var p13_y = p_oPointA.y - p_oPointC.y;
	var p13_z = p_oPointA.z - p_oPointC.z;
	var p43_x = p_oPointD.x - p_oPointC.x;
	var p43_y = p_oPointD.y - p_oPointC.y;
	var p43_z = p_oPointD.z - p_oPointC.z;
	if(sandy.util.NumberUtil.isZero(p43_x) && sandy.util.NumberUtil.isZero(p43_y) && sandy.util.NumberUtil.isZero(p43_z)) return res;
	var p21_x = p_oPointB.x - p_oPointA.x;
	var p21_y = p_oPointB.y - p_oPointA.y;
	var p21_z = p_oPointB.z - p_oPointA.z;
	if(sandy.util.NumberUtil.isZero(p21_x) && sandy.util.NumberUtil.isZero(p21_y) && sandy.util.NumberUtil.isZero(p21_z)) return res;
	var d1343 = p13_x * p43_x + p13_y * p43_y + p13_z * p43_z;
	var d4321 = p43_x * p21_x + p43_y * p21_y + p43_z * p21_z;
	var d1321 = p13_x * p21_x + p13_y * p21_y + p13_z * p21_z;
	var d4343 = p43_x * p43_x + p43_y * p43_y + p43_z * p43_z;
	var d2121 = p21_x * p21_x + p21_y * p21_y + p21_z * p21_z;
	var denom = d2121 * d4343 - d4321 * d4321;
	if(sandy.util.NumberUtil.isZero(denom)) return res;
	var mua = (d1343 * d4321 - d1321 * d4343) / denom;
	var mub = (d1343 + d4321 * mua) / d4343;
	return [new sandy.core.data.Vector(p_oPointA.x + mua * p21_x,p_oPointA.y + mua * p21_y,p_oPointA.z + mua * p21_z),new sandy.core.data.Vector(p_oPointC.x + mub * p43_x,p_oPointC.y + mub * p43_y,p_oPointC.z + mub * p43_z)];
}
sandy.math.IntersectionMath.intersectionLine2D = function(p_oPointA,p_oPointB,p_oPointC,p_oPointD) {
	var xA = p_oPointA.x;
	var yA = p_oPointA.y;
	var xB = p_oPointB.x;
	var yB = p_oPointB.y;
	var xC = p_oPointC.x;
	var yC = p_oPointC.y;
	var xD = p_oPointD.x;
	var yD = p_oPointD.y;
	var denom = ((yD - yC) * (xB - xA) - (xD - xC) * (yB - yA));
	var retflag = false;
	if(denom == 0) retflag = true;
	var uA = ((xD - xC) * (yA - yC) - (yD - yC) * (xA - xC));
	uA /= denom;
	return (retflag?null:new canvas.geom.Point(xA + uA * (xB - xA),yA + uA * (yB - yA)));
}
sandy.math.IntersectionMath.isPointInTriangle2D = function(p_oPoint,p_oA,p_oB,p_oC) {
	var oneOverDenom = (1 / (((p_oA.y - p_oC.y) * (p_oB.x - p_oC.x)) + ((p_oB.y - p_oC.y) * (p_oC.x - p_oA.x))));
	var b1 = (oneOverDenom * (((p_oPoint.y - p_oC.y) * (p_oB.x - p_oC.x)) + ((p_oB.y - p_oC.y) * (p_oC.x - p_oPoint.x))));
	var b2 = (oneOverDenom * (((p_oPoint.y - p_oA.y) * (p_oC.x - p_oA.x)) + ((p_oC.y - p_oA.y) * (p_oA.x - p_oPoint.x))));
	var b3 = (oneOverDenom * (((p_oPoint.y - p_oB.y) * (p_oA.x - p_oB.x)) + ((p_oA.y - p_oB.y) * (p_oB.x - p_oPoint.x))));
	return ((b1 > 0) && (b2 > 0) && (b3 > 0));
}
sandy.math.IntersectionMath.prototype.__class__ = sandy.math.IntersectionMath;
sandy.core.data = {}
sandy.core.data.Vertex = function(p_nx,p_ny,p_nz,restx,resty,restz) { if( p_nx === $_ ) return; {
	sandy.core.data.Vertex.ID = 0;
	this.id = sandy.core.data.Vertex.ID++;
	this.nbFaces = 0;
	this.aFaces = new Array();
	this.m_oWorld = new sandy.core.data.Vector();
	p_nx = ((p_nx != null)?p_nx:0);
	p_ny = ((p_ny != null)?p_ny:0);
	p_nz = ((p_nz != null)?p_nz:0);
	this.x = p_nx;
	this.y = p_ny;
	this.z = p_nz;
	this.wx = ((restx != null)?restx:this.x);
	this.wy = ((resty != null)?resty:this.y);
	this.wz = ((restz != null)?restz:this.z);
	this.sy = this.sx = 0;
}}
sandy.core.data.Vertex.__name__ = ["sandy","core","data","Vertex"];
sandy.core.data.Vertex.ID = null;
sandy.core.data.Vertex.createFromVector = function(p_v) {
	return new sandy.core.data.Vertex(p_v.x,p_v.y,p_v.z);
}
sandy.core.data.Vertex.prototype.aFaces = null;
sandy.core.data.Vertex.prototype.add = function(v) {
	this.x += v.x;
	this.y += v.y;
	this.z += v.z;
	this.wx += v.wx;
	this.wy += v.wy;
	this.wz += v.wz;
}
sandy.core.data.Vertex.prototype.clone = function() {
	var l_oV = new sandy.core.data.Vertex(this.x,this.y,this.z);
	l_oV.wx = this.wx;
	l_oV.sx = this.sx;
	l_oV.wy = this.wy;
	l_oV.sy = this.sy;
	l_oV.wz = this.wz;
	l_oV.nbFaces = this.nbFaces;
	l_oV.aFaces = this.aFaces.concat([]);
	return l_oV;
}
sandy.core.data.Vertex.prototype.clone2 = function() {
	return new sandy.core.data.Vertex(this.wx,this.wy,this.wz);
}
sandy.core.data.Vertex.prototype.copy = function(p_oVector) {
	this.x = p_oVector.x;
	this.y = p_oVector.y;
	this.z = p_oVector.z;
	this.wx = p_oVector.wx;
	this.wy = p_oVector.wy;
	this.wz = p_oVector.wz;
	this.sx = p_oVector.sx;
	this.sy = p_oVector.sy;
}
sandy.core.data.Vertex.prototype.cross = function(v) {
	return new sandy.core.data.Vertex((this.y * v.z) - (this.z * v.y),(this.z * v.x) - (this.x * v.z),(this.x * v.y) - (this.y * v.x));
}
sandy.core.data.Vertex.prototype.deserialize = function(convertFrom) {
	var tmp = convertFrom.split(",");
	if(tmp.length != 9) {
		haxe.Log.trace("Unexpected length of string to deserialize into a vector " + convertFrom,{ fileName : "Vertex.hx", lineNumber : 449, className : "sandy.core.data.Vertex", methodName : "deserialize"});
	}
	this.x = Std.parseFloat(tmp[0]);
	this.y = Std.parseFloat(tmp[1]);
	this.z = Std.parseFloat(tmp[2]);
	this.wx = Std.parseFloat(tmp[3]);
	this.wy = Std.parseFloat(tmp[4]);
	this.wz = Std.parseFloat(tmp[5]);
	this.sx = Std.parseFloat(tmp[6]);
	this.sy = Std.parseFloat(tmp[7]);
}
sandy.core.data.Vertex.prototype.dot = function(w) {
	return (this.x * w.x + this.y * w.y + this.z * w.z);
}
sandy.core.data.Vertex.prototype.equals = function(p_vertex) {
	return (p_vertex.x == this.x && p_vertex.y == this.y && p_vertex.z == this.z && p_vertex.wx == this.wx && p_vertex.wy == this.wy && p_vertex.wz == this.wz && p_vertex.sx == this.wx && p_vertex.sy == this.sy);
}
sandy.core.data.Vertex.prototype.getAngle = function(w) {
	var ncos = this.dot(w) / (this.getNorm() * w.getNorm());
	var sin2 = 1 - ncos * ncos;
	if(sin2 < 0) {
		haxe.Log.trace(" wrong " + ncos,{ fileName : "Vertex.hx", lineNumber : 372, className : "sandy.core.data.Vertex", methodName : "getAngle"});
		sin2 = 0;
	}
	return Math.atan2(Math.sqrt(sin2),ncos);
}
sandy.core.data.Vertex.prototype.getNorm = function() {
	return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
}
sandy.core.data.Vertex.prototype.getScreenPoint = function() {
	return new sandy.core.data.Vector(this.sx,this.sy,this.wz);
}
sandy.core.data.Vertex.prototype.getVector = function() {
	return new sandy.core.data.Vector(this.x,this.y,this.z);
}
sandy.core.data.Vertex.prototype.getWorldVector = function() {
	this.m_oWorld.x = this.wx;
	this.m_oWorld.y = this.wy;
	this.m_oWorld.z = this.wz;
	return this.m_oWorld;
}
sandy.core.data.Vertex.prototype.id = null;
sandy.core.data.Vertex.prototype.m_oWorld = null;
sandy.core.data.Vertex.prototype.nbFaces = null;
sandy.core.data.Vertex.prototype.negate = function() {
	this.x = -this.x;
	this.y = -this.y;
	this.z = -this.z;
	this.wx = -this.wx;
	this.wy = -this.wy;
	this.wz = -this.wz;
}
sandy.core.data.Vertex.prototype.normalize = function() {
	var norm = this.getNorm();
	if(norm == 0 || norm == 1) return;
	this.x = this.x / norm;
	this.y = this.y / norm;
	this.z = this.z / norm;
	this.wx /= norm;
	this.wy /= norm;
	this.wz /= norm;
}
sandy.core.data.Vertex.prototype.pow = function(pow) {
	this.x = Math.pow(this.x,pow);
	this.y = Math.pow(this.y,pow);
	this.z = Math.pow(this.z,pow);
	this.wx = Math.pow(this.wx,pow);
	this.wy = Math.pow(this.wy,pow);
	this.wz = Math.pow(this.wz,pow);
}
sandy.core.data.Vertex.prototype.projected = null;
sandy.core.data.Vertex.prototype.scale = function(n) {
	this.x *= n;
	this.y *= n;
	this.z *= n;
	this.wx *= n;
	this.wy *= n;
	this.wz *= n;
}
sandy.core.data.Vertex.prototype.serialize = function(decPlaces) {
	decPlaces = ((decPlaces != null)?decPlaces:0);
	if(decPlaces == 0) {
		decPlaces = .01;
	}
	return (sandy.util.NumberUtil.roundTo(this.x,decPlaces) + "," + sandy.util.NumberUtil.roundTo(this.y,decPlaces) + "," + sandy.util.NumberUtil.roundTo(this.z,decPlaces) + "," + sandy.util.NumberUtil.roundTo(this.wx,decPlaces) + "," + sandy.util.NumberUtil.roundTo(this.wy,decPlaces) + "," + sandy.util.NumberUtil.roundTo(this.wz,decPlaces) + "," + sandy.util.NumberUtil.roundTo(this.sx,decPlaces) + "," + sandy.util.NumberUtil.roundTo(this.sy,decPlaces));
}
sandy.core.data.Vertex.prototype.sub = function(v) {
	this.x -= v.x;
	this.y -= v.y;
	this.z -= v.z;
	this.wx -= v.wx;
	this.wy -= v.wy;
	this.wz -= v.wz;
}
sandy.core.data.Vertex.prototype.sx = null;
sandy.core.data.Vertex.prototype.sy = null;
sandy.core.data.Vertex.prototype.toString = function(decPlaces) {
	decPlaces = ((decPlaces != null)?decPlaces:0);
	if(decPlaces == 0) {
		decPlaces = 0.01;
	}
	return "{" + sandy.util.NumberUtil.roundTo(this.x,decPlaces) + ", " + sandy.util.NumberUtil.roundTo(this.y,decPlaces) + ", " + sandy.util.NumberUtil.roundTo(this.z,decPlaces) + ", " + sandy.util.NumberUtil.roundTo(this.wx,decPlaces) + ", " + sandy.util.NumberUtil.roundTo(this.wy,decPlaces) + ", " + sandy.util.NumberUtil.roundTo(this.wz,decPlaces) + ", " + sandy.util.NumberUtil.roundTo(this.sx,decPlaces) + ", " + sandy.util.NumberUtil.roundTo(this.sy,decPlaces) + "}";
}
sandy.core.data.Vertex.prototype.wx = null;
sandy.core.data.Vertex.prototype.wy = null;
sandy.core.data.Vertex.prototype.wz = null;
sandy.core.data.Vertex.prototype.x = null;
sandy.core.data.Vertex.prototype.y = null;
sandy.core.data.Vertex.prototype.z = null;
sandy.core.data.Vertex.prototype.__class__ = sandy.core.data.Vertex;
neash.events.Event = function(inType,inBubbles,inCancelable) { if( inType === $_ ) return; {
	this.type = inType;
	this.bubbles = (inBubbles == null?false:inBubbles);
	this.cancelable = (inCancelable == null?false:inCancelable);
	this.mIsCancelled = false;
	this.mIsCancelledNow = false;
	this.target = null;
	this.currentTarget = null;
	this.eventPhase = neash.events.EventPhase.AT_TARGET;
}}
neash.events.Event.__name__ = ["neash","events","Event"];
neash.events.Event.prototype.IsCancelled = function() {
	return this.mIsCancelled;
}
neash.events.Event.prototype.IsCancelledNow = function() {
	return this.mIsCancelledNow;
}
neash.events.Event.prototype.SetPhase = function(inPhase) {
	this.eventPhase = inPhase;
}
neash.events.Event.prototype.bubbles = null;
neash.events.Event.prototype.cancelable = null;
neash.events.Event.prototype.clone = function() {
	return new neash.events.Event(this.type,this.bubbles,this.cancelable);
}
neash.events.Event.prototype.currentTarget = null;
neash.events.Event.prototype.eventPhase = null;
neash.events.Event.prototype.mIsCancelled = null;
neash.events.Event.prototype.mIsCancelledNow = null;
neash.events.Event.prototype.stopImmediatePropagation = function() {
	if(this.cancelable) this.mIsCancelledNow = this.mIsCancelled = true;
}
neash.events.Event.prototype.stopPropagation = function() {
	if(this.cancelable) this.mIsCancelled = true;
}
neash.events.Event.prototype.target = null;
neash.events.Event.prototype.toString = function() {
	return "Event";
}
neash.events.Event.prototype.type = null;
neash.events.Event.prototype.__class__ = neash.events.Event;
neash.events.KeyboardEvent = function(type,bubbles,cancelable,inCharCode,inKeyCode,inKeyLocation,inCtrlKey,inAltKey,inShiftKey) { if( type === $_ ) return; {
	neash.events.Event.apply(this,[type,bubbles,cancelable]);
	this.keyCode = inKeyCode;
	this.keyLocation = (inKeyLocation == null?0:inKeyLocation);
	this.charCode = (inCharCode == null?0:inCharCode);
	this.shiftKey = (inShiftKey == null?false:inShiftKey);
	this.altKey = (inAltKey == null?false:inAltKey);
	this.ctrlKey = (inCtrlKey == null?false:inCtrlKey);
}}
neash.events.KeyboardEvent.__name__ = ["neash","events","KeyboardEvent"];
neash.events.KeyboardEvent.__super__ = neash.events.Event;
for(var k in neash.events.Event.prototype ) neash.events.KeyboardEvent.prototype[k] = neash.events.Event.prototype[k];
neash.events.KeyboardEvent.prototype.altKey = null;
neash.events.KeyboardEvent.prototype.charCode = null;
neash.events.KeyboardEvent.prototype.ctrlKey = null;
neash.events.KeyboardEvent.prototype.keyCode = null;
neash.events.KeyboardEvent.prototype.keyLocation = null;
neash.events.KeyboardEvent.prototype.shiftKey = null;
neash.events.KeyboardEvent.prototype.__class__ = neash.events.KeyboardEvent;
sandy.core.scenegraph.Camera3D = function(p_nWidth,p_nHeight,p_nFov,p_nNear,p_nFar) { if( p_nWidth === $_ ) return; {
	if(p_nFov == null) p_nFov = 45;
	if(p_nNear == null) p_nNear = 50;
	if(p_nFar == null) p_nFar = 10000;
	sandy.core.scenegraph.ATransformable.apply(this,[null]);
	this.invModelMatrix = new sandy.core.data.Matrix4();
	this.viewport = new sandy.view.ViewPort(640,480);
	this.frustrum = new sandy.view.Frustum();
	this._perspectiveChanged = false;
	this._mp = new sandy.core.data.Matrix4();
	this._mpInv = new sandy.core.data.Matrix4();
	this.m_aDisplayList = new Array();
	this.viewport.__setWidth(p_nWidth);
	this.viewport.__setHeight(p_nHeight);
	this._nFov = p_nFov;
	this._nFar = p_nFar;
	this._nNear = p_nNear;
	this.setPerspectiveProjection(this._nFov,this.viewport.__getRatio(),this._nNear,this._nFar);
	this.m_nOffx = this.viewport.__getWidth2();
	this.m_nOffy = this.viewport.__getHeight2();
	this.viewport.hasChanged = false;
	this.visible = false;
	this.__setZ(-300);
	this.lookAt(0,0,0);
}}
sandy.core.scenegraph.Camera3D.__name__ = ["sandy","core","scenegraph","Camera3D"];
sandy.core.scenegraph.Camera3D.__super__ = sandy.core.scenegraph.ATransformable;
for(var k in sandy.core.scenegraph.ATransformable.prototype ) sandy.core.scenegraph.Camera3D.prototype[k] = sandy.core.scenegraph.ATransformable.prototype[k];
sandy.core.scenegraph.Camera3D.prototype.__getFar = function() {
	return this._nFar;
}
sandy.core.scenegraph.Camera3D.prototype.__getFocalLength = function() {
	return this.viewport.__getHeight2() / Math.tan(this._nFov * 0.00872664626);
}
sandy.core.scenegraph.Camera3D.prototype.__getFov = function() {
	return this._nFov;
}
sandy.core.scenegraph.Camera3D.prototype.__getInvProjectionMatrix = function() {
	this._mpInv.copy(this._mp);
	this._mpInv.inverse();
	return this._mpInv;
}
sandy.core.scenegraph.Camera3D.prototype.__getNear = function() {
	return this._nNear;
}
sandy.core.scenegraph.Camera3D.prototype.__getProjectionMatrix = function() {
	return this._mp;
}
sandy.core.scenegraph.Camera3D.prototype.__setFar = function(pFar) {
	this._nFar = pFar;
	this._perspectiveChanged = true;
	return pFar;
}
sandy.core.scenegraph.Camera3D.prototype.__setFocalLength = function(f) {
	this._nFov = Math.atan2(this.viewport.__getHeight2(),f) * 114.591559;
	this._perspectiveChanged = true;
	return f;
}
sandy.core.scenegraph.Camera3D.prototype.__setFov = function(p_nFov) {
	this._nFov = p_nFov;
	this._perspectiveChanged = true;
	return p_nFov;
}
sandy.core.scenegraph.Camera3D.prototype.__setNear = function(pNear) {
	this._nNear = pNear;
	this._perspectiveChanged = true;
	return pNear;
}
sandy.core.scenegraph.Camera3D.prototype._mp = null;
sandy.core.scenegraph.Camera3D.prototype._mpInv = null;
sandy.core.scenegraph.Camera3D.prototype._nFar = null;
sandy.core.scenegraph.Camera3D.prototype._nFov = null;
sandy.core.scenegraph.Camera3D.prototype._nNear = null;
sandy.core.scenegraph.Camera3D.prototype._perspectiveChanged = null;
sandy.core.scenegraph.Camera3D.prototype.addArrayToDisplayList = function(p_aShapeArray) {
	this.m_aDisplayList = this.m_aDisplayList.concat(p_aShapeArray);
}
sandy.core.scenegraph.Camera3D.prototype.addToDisplayList = function(p_oShape) {
	if(p_oShape != null) this.m_aDisplayList[this.m_aDisplayList.length] = (p_oShape);
}
sandy.core.scenegraph.Camera3D.prototype.cull = function(p_oScene,p_oFrustum,p_oViewMatrix,p_bChanged) {
	return;
}
sandy.core.scenegraph.Camera3D.prototype.destroy = function() {
	var l_oShape;
	{
		var _g = 0, _g1 = this.m_aDisplayedList;
		while(_g < _g1.length) {
			var l_oShape1 = _g1[_g];
			++_g;
			if(l_oShape1 != null) l_oShape1.clear();
		}
	}
	{
		var _g = 0, _g1 = this.m_aDisplayList;
		while(_g < _g1.length) {
			var l_oShape1 = _g1[_g];
			++_g;
			if(l_oShape1 != null) l_oShape1.clear();
		}
	}
	this.m_aDisplayedList = null;
	this.m_aDisplayList = null;
	this.viewport = null;
	sandy.core.scenegraph.ATransformable.prototype.destroy.apply(this,[]);
}
sandy.core.scenegraph.Camera3D.prototype.far = null;
sandy.core.scenegraph.Camera3D.prototype.focalLength = null;
sandy.core.scenegraph.Camera3D.prototype.fov = null;
sandy.core.scenegraph.Camera3D.prototype.frustrum = null;
sandy.core.scenegraph.Camera3D.prototype.invModelMatrix = null;
sandy.core.scenegraph.Camera3D.prototype.invProjectionMatrix = null;
sandy.core.scenegraph.Camera3D.prototype.m_aDisplayList = null;
sandy.core.scenegraph.Camera3D.prototype.m_aDisplayedList = null;
sandy.core.scenegraph.Camera3D.prototype.m_nOffx = null;
sandy.core.scenegraph.Camera3D.prototype.m_nOffy = null;
sandy.core.scenegraph.Camera3D.prototype.mp11 = null;
sandy.core.scenegraph.Camera3D.prototype.mp12 = null;
sandy.core.scenegraph.Camera3D.prototype.mp13 = null;
sandy.core.scenegraph.Camera3D.prototype.mp14 = null;
sandy.core.scenegraph.Camera3D.prototype.mp21 = null;
sandy.core.scenegraph.Camera3D.prototype.mp22 = null;
sandy.core.scenegraph.Camera3D.prototype.mp23 = null;
sandy.core.scenegraph.Camera3D.prototype.mp24 = null;
sandy.core.scenegraph.Camera3D.prototype.mp31 = null;
sandy.core.scenegraph.Camera3D.prototype.mp32 = null;
sandy.core.scenegraph.Camera3D.prototype.mp33 = null;
sandy.core.scenegraph.Camera3D.prototype.mp34 = null;
sandy.core.scenegraph.Camera3D.prototype.mp41 = null;
sandy.core.scenegraph.Camera3D.prototype.mp42 = null;
sandy.core.scenegraph.Camera3D.prototype.mp43 = null;
sandy.core.scenegraph.Camera3D.prototype.mp44 = null;
sandy.core.scenegraph.Camera3D.prototype.near = null;
sandy.core.scenegraph.Camera3D.prototype.projectArray = function(p_oList) {
	var l_nX = this.viewport.offset.x + this.m_nOffx;
	var l_nY = this.viewport.offset.y + this.m_nOffy;
	var l_nCste;
	var l_mp11_offx = this.mp11 * this.m_nOffx;
	var l_mp22_offy = this.mp22 * this.m_nOffy;
	{
		var _g = 0;
		while(_g < p_oList.length) {
			var l_oVertex = p_oList[_g];
			++_g;
			if(!l_oVertex.projected) {
				l_nCste = 1 / l_oVertex.wz;
				l_oVertex.sx = l_nCste * l_oVertex.wx * l_mp11_offx + l_nX;
				l_oVertex.sy = -l_nCste * l_oVertex.wy * l_mp22_offy + l_nY;
				l_oVertex.projected = true;
			}
		}
	}
}
sandy.core.scenegraph.Camera3D.prototype.projectVertex = function(p_oVertex) {
	var l_nX = (this.viewport.offset.x + this.m_nOffx);
	var l_nY = (this.viewport.offset.y + this.m_nOffy);
	var l_nCste = 1 / p_oVertex.wz;
	p_oVertex.sx = l_nCste * p_oVertex.wx * this.mp11 * this.m_nOffx + l_nX;
	p_oVertex.sy = -l_nCste * p_oVertex.wy * this.mp22 * this.m_nOffy + l_nY;
}
sandy.core.scenegraph.Camera3D.prototype.projectionMatrix = null;
sandy.core.scenegraph.Camera3D.prototype.render = function(p_oScene,p_oCamera) {
	return;
}
sandy.core.scenegraph.Camera3D.prototype.renderDisplayList = function(p_oScene) {
	var l_oShape;
	if(this.m_aDisplayedList != null) {
		{
			var _g = 0, _g1 = this.m_aDisplayedList;
			while(_g < _g1.length) {
				var l_oShape1 = _g1[_g];
				++_g;
				l_oShape1.clear();
			}
		}
	}
	var l_mcContainer = p_oScene.container;
	this.m_aDisplayList.sort(function(a,b) {
		return ((a.__getDepth() > b.__getDepth())?1:(a.__getDepth() < b.__getDepth()?-1:0));
	});
	{
		var _g = 0, _g1 = this.m_aDisplayList;
		while(_g < _g1.length) {
			var l_oShape1 = _g1[_g];
			++_g;
			l_oShape1.display(p_oScene);
			l_mcContainer.addChild(l_oShape1.__getContainer());
		}
	}
	this.m_aDisplayedList = this.m_aDisplayList.splice(0,this.m_aDisplayList.length);
}
sandy.core.scenegraph.Camera3D.prototype.setPerspectiveProjection = function(p_nFovY,p_nAspectRatio,p_nZNear,p_nZFar) {
	var cotan, Q;
	this.frustrum.computePlanes(p_nAspectRatio,p_nZNear,p_nZFar,p_nFovY);
	p_nFovY = sandy.util.NumberUtil.toRadian(p_nFovY);
	cotan = 1 / Math.tan(p_nFovY / 2);
	Q = p_nZFar / (p_nZFar - p_nZNear);
	this._mp.zero();
	this._mp.n11 = cotan / p_nAspectRatio;
	this._mp.n22 = cotan;
	this._mp.n33 = Q;
	this._mp.n34 = -Q * p_nZNear;
	this._mp.n43 = 1;
	this.mp11 = this._mp.n11;
	this.mp21 = this._mp.n21;
	this.mp31 = this._mp.n31;
	this.mp41 = this._mp.n41;
	this.mp12 = this._mp.n12;
	this.mp22 = this._mp.n22;
	this.mp32 = this._mp.n32;
	this.mp42 = this._mp.n42;
	this.mp13 = this._mp.n13;
	this.mp23 = this._mp.n23;
	this.mp33 = this._mp.n33;
	this.mp43 = this._mp.n43;
	this.mp14 = this._mp.n14;
	this.mp24 = this._mp.n24;
	this.mp34 = this._mp.n34;
	this.mp44 = this._mp.n44;
	this.changed = true;
}
sandy.core.scenegraph.Camera3D.prototype.toString = function() {
	return "sandy.core.scenegraph.Camera3D";
}
sandy.core.scenegraph.Camera3D.prototype.update = function(p_oScene,p_oModelMatrix,p_bChanged) {
	if(this.viewport.hasChanged) {
		this._perspectiveChanged = true;
		this.m_nOffx = this.viewport.__getWidth2();
		this.m_nOffy = this.viewport.__getHeight2();
		if(p_oScene.__getRectClipping()) p_oScene.container.SetScrollRect(new canvas.geom.Rectangle(0,0,this.viewport.__getWidth(),this.viewport.__getHeight()));
		this.viewport.hasChanged = false;
	}
	if(this._perspectiveChanged) this.updatePerspective();
	sandy.core.scenegraph.ATransformable.prototype.update.apply(this,[p_oScene,p_oModelMatrix,p_bChanged]);
	this.invModelMatrix.n11 = this.modelMatrix.n11;
	this.invModelMatrix.n12 = this.modelMatrix.n21;
	this.invModelMatrix.n13 = this.modelMatrix.n31;
	this.invModelMatrix.n21 = this.modelMatrix.n12;
	this.invModelMatrix.n22 = this.modelMatrix.n22;
	this.invModelMatrix.n23 = this.modelMatrix.n32;
	this.invModelMatrix.n31 = this.modelMatrix.n13;
	this.invModelMatrix.n32 = this.modelMatrix.n23;
	this.invModelMatrix.n33 = this.modelMatrix.n33;
	this.invModelMatrix.n14 = -(this.modelMatrix.n11 * this.modelMatrix.n14 + this.modelMatrix.n21 * this.modelMatrix.n24 + this.modelMatrix.n31 * this.modelMatrix.n34);
	this.invModelMatrix.n24 = -(this.modelMatrix.n12 * this.modelMatrix.n14 + this.modelMatrix.n22 * this.modelMatrix.n24 + this.modelMatrix.n32 * this.modelMatrix.n34);
	this.invModelMatrix.n34 = -(this.modelMatrix.n13 * this.modelMatrix.n14 + this.modelMatrix.n23 * this.modelMatrix.n24 + this.modelMatrix.n33 * this.modelMatrix.n34);
}
sandy.core.scenegraph.Camera3D.prototype.updatePerspective = function() {
	this.setPerspectiveProjection(this._nFov,this.viewport.__getRatio(),this._nNear,this._nFar);
	this._perspectiveChanged = false;
}
sandy.core.scenegraph.Camera3D.prototype.viewport = null;
sandy.core.scenegraph.Camera3D.prototype.__class__ = sandy.core.scenegraph.Camera3D;
canvas.geom = {}
canvas.geom.Decompose = function() { }
canvas.geom.Decompose.__name__ = ["canvas","geom","Decompose"];
canvas.geom.Decompose.calcFromValues = function(r1,m1,r2,m2) {
	if(!canvas.geom.Decompose.math.isFinite(r1)) {
		return r2;
	}
	else if(!canvas.geom.Decompose.math.isFinite(r2)) {
		return r1;
	}
	else {
		m1 = canvas.geom.Decompose.math.abs(m1);
		m2 = canvas.geom.Decompose.math.abs(m2);
		return (m1 * r1 + m2 * r2) / (m1 + m2);
	}
}
canvas.geom.Decompose.decomposeSR = function(M,result) {
	var sign = canvas.geom.MatrixUtil.getScaleSign(M), a = result.angle1 = (canvas.geom.Decompose.math.atan2(M.c,M.d) + canvas.geom.Decompose.math.atan2(-sign * M.b,sign * M.a)) / 2, cos = canvas.geom.Decompose.math.cos(a), sin = canvas.geom.Decompose.math.sin(a);
	result.sx = canvas.geom.Decompose.calcFromValues(M.a / cos,cos,-M.b / sin,sin);
	result.sy = canvas.geom.Decompose.calcFromValues(M.d / cos,cos,M.c / sin,sin);
	return result;
}
canvas.geom.Decompose.decomposeRS = function(M,result) {
	var sign = canvas.geom.MatrixUtil.getScaleSign(M), a = result.angle2 = (canvas.geom.Decompose.math.atan2(sign * M.c,sign * M.a) + canvas.geom.Decompose.math.atan2(-M.b,M.d)) / 2, cos = canvas.geom.Decompose.math.cos(a), sin = canvas.geom.Decompose.math.sin(a);
	result.sx = canvas.geom.Decompose.calcFromValues(M.a / cos,cos,M.c / sin,sin);
	result.sy = canvas.geom.Decompose.calcFromValues(M.d / cos,cos,-M.b / sin,sin);
	return result;
}
canvas.geom.Decompose.singularValueDecomposition = function(matrix) {
	var M = matrix;
	var result = { dx : M.tx, dy : M.ty, sx : 1.0, sy : 1.0, angle1 : 0.0, angle2 : 0.0}
	if(canvas.geom.Decompose.eqFP(M.b,0) && canvas.geom.Decompose.eqFP(M.c,0)) {
		result.sx = M.a;
		result.sy = M.d;
		return result;
	}
	if(canvas.geom.Decompose.eqFP(M.a * M.c,-M.b * M.d)) {
		return canvas.geom.Decompose.decomposeSR(M,result);
	}
	if(canvas.geom.Decompose.eqFP(M.a * M.b,-M.c * M.d)) {
		return canvas.geom.Decompose.decomposeRS(M,result);
	}
	var MT = canvas.geom.MatrixUtil.transpose(M);
	var M_MT = canvas.geom.MatrixUtil.concat([M,MT]);
	var u = canvas.geom.Decompose.eigenValueDecomposition(M_MT);
	var MT_M = canvas.geom.MatrixUtil.concat([MT,M]);
	var v = canvas.geom.Decompose.eigenValueDecomposition(MT_M);
	var U = new canvas.geom.Matrix(u.vector1.x,u.vector2.x,u.vector1.y,u.vector2.y);
	var VT = new canvas.geom.Matrix(v.vector1.x,v.vector1.y,v.vector2.x,v.vector2.y);
	var S = canvas.geom.MatrixUtil.concat(["invert",U,M,"invert",VT]);
	canvas.geom.Decompose.decomposeSR(VT,result);
	S.a *= result.sx;
	S.d *= result.sy;
	canvas.geom.Decompose.decomposeRS(U,result);
	S.a *= result.sx;
	S.d *= result.sy;
	result.sx = S.a;
	result.sy = S.d;
	return result;
}
canvas.geom.Decompose.eigenValueDecomposition = function(matrix) {
	var m = matrix, b = -m.a - m.d, c = m.a * m.d - m.b * m.c, d = canvas.geom.Decompose.math.sqrt(b * b - 4 * c), l1 = -(b + ((b < 0?-d:d))) / 2, l2 = c / l1, vx1 = m.b / (l1 - m.a), vy1 = 1, vx2 = m.b / (l2 - m.a), vy2 = 1;
	if(canvas.geom.Decompose.math.abs(l1 - l2) <= 1e-6 * (canvas.geom.Decompose.math.abs(l1) + canvas.geom.Decompose.math.abs(l2))) {
		vx1 = 1.0;
		vy1 = 0.0;
		vx2 = 0.0;
		vy2 = 1.0;
	}
	if(!canvas.geom.Decompose.math.isFinite(vx1)) {
		vx1 = 1.0;
		vy1 = (l1 - m.a) / m.b;
		if(!canvas.geom.Decompose.math.isFinite(vy1)) {
			vx1 = (l1 - m.d) / m.c;
			vy1 = 1.0;
			if(!canvas.geom.Decompose.math.isFinite(vx1)) {
				vx1 = 1.0;
				vy1 = m.c / (l1 - m.d);
			}
		}
	}
	if(!canvas.geom.Decompose.math.isFinite(vx2)) {
		vx2 = 1.0;
		vy2 = (l2 - m.a) / m.b;
		if(!canvas.geom.Decompose.math.isFinite(vy2)) {
			vx2 = (l2 - m.d) / m.c;
			vy2 = 1.0;
			if(!canvas.geom.Decompose.math.isFinite(vx2)) {
				vx2 = 1.0;
				vy2 = m.c / (l2 - m.d);
			}
		}
	}
	var d1 = canvas.geom.Decompose.math.sqrt(vx1 * vx1 + vy1 * vy1), d2 = canvas.geom.Decompose.math.sqrt(vx2 * vx2 + vy2 * vy2);
	if(!canvas.geom.Decompose.math.isFinite(vx1 /= d1)) {
		vx1 = 0;
	}
	if(!canvas.geom.Decompose.math.isFinite(vy1 /= d1)) {
		vy1 = 0;
	}
	if(!canvas.geom.Decompose.math.isFinite(vx2 /= d2)) {
		vx2 = 0;
	}
	if(!canvas.geom.Decompose.math.isFinite(vy2 /= d2)) {
		vy2 = 0;
	}
	var eV = { value1 : l1, value2 : l2, vector1 : new canvas.geom.Point(vx1,vy1), vector2 : new canvas.geom.Point(vx2,vy2)}
	return eV;
}
canvas.geom.Decompose.eqFP = function(a,b) {
	return canvas.geom.Decompose.math.abs(a - b) <= 1e-6 * (canvas.geom.Decompose.math.abs(a) + canvas.geom.Decompose.math.abs(b));
}
canvas.geom.Decompose.prototype.__class__ = canvas.geom.Decompose;
sandy.core.scenegraph.Group = function(p_sName) { if( p_sName === $_ ) return; {
	if(p_sName == null) p_sName = "";
	sandy.core.scenegraph.Node.apply(this,[p_sName]);
}}
sandy.core.scenegraph.Group.__name__ = ["sandy","core","scenegraph","Group"];
sandy.core.scenegraph.Group.__super__ = sandy.core.scenegraph.Node;
for(var k in sandy.core.scenegraph.Node.prototype ) sandy.core.scenegraph.Group.prototype[k] = sandy.core.scenegraph.Node.prototype[k];
sandy.core.scenegraph.Group.prototype.clone = function(p_sName) {
	var l_oGroup = new sandy.core.scenegraph.Group(p_sName);
	{
		var _g = 0, _g1 = this.children;
		while(_g < _g1.length) {
			var l_oNode = _g1[_g];
			++_g;
			if(Std["is"](l_oNode,sandy.core.scenegraph.Shape3D) || Std["is"](l_oNode,sandy.core.scenegraph.Group) || Std["is"](l_oNode,sandy.core.scenegraph.TransformGroup)) {
				l_oGroup.addChild("clone".apply(l_oNode,[p_sName + "_" + l_oNode.name]));
			}
		}
	}
	return l_oGroup;
}
sandy.core.scenegraph.Group.prototype.cull = function(p_oScene,p_oFrustum,p_oViewMatrix,p_bChanged) {
	if(this.visible == false) {
		this.culled = sandy.view.CullingState.OUTSIDE;
	}
	else {
		var lChanged = p_bChanged || this.changed;
		{
			var _g = 0, _g1 = this.children;
			while(_g < _g1.length) {
				var l_oNode = _g1[_g];
				++_g;
				l_oNode.cull(p_oScene,p_oFrustum,p_oViewMatrix,lChanged);
			}
		}
	}
}
sandy.core.scenegraph.Group.prototype.render = function(p_oScene,p_oCamera) {
	var _g = 0, _g1 = this.children;
	while(_g < _g1.length) {
		var l_oNode = _g1[_g];
		++_g;
		if(l_oNode.culled != sandy.view.CullingState.OUTSIDE) l_oNode.render(p_oScene,p_oCamera);
		l_oNode.changed = false;
		l_oNode.culled = sandy.view.CullingState.INSIDE;
	}
}
sandy.core.scenegraph.Group.prototype.__class__ = sandy.core.scenegraph.Group;
sandy.extrusion = {}
sandy.extrusion.data = {}
sandy.extrusion.data.Polygon2D = function(points) { if( points === $_ ) return; {
	if(points != null) this.vertices = points.slice(0);
}}
sandy.extrusion.data.Polygon2D.__name__ = ["sandy","extrusion","data","Polygon2D"];
sandy.extrusion.data.Polygon2D.prototype.area = function() {
	var a = 0, n = this.vertices.length;
	var i;
	{
		var _g = 0;
		while(_g < n) {
			var i1 = _g++;
			a += this.vertices[i1].x * this.vertices[(i1 + 1) % n].y - this.vertices[(i1 + 1) % n].x * this.vertices[i1].y;
		}
	}
	return 0.5 * a;
}
sandy.extrusion.data.Polygon2D.prototype.bbox = function() {
	var xmin = 1e99, xmax = -1e99, ymin = xmin, ymax = xmax;
	var p;
	{
		var _g = 0, _g1 = this.vertices;
		while(_g < _g1.length) {
			var p1 = _g1[_g];
			++_g;
			if(p1.x < xmin) xmin = p1.x;
			if(p1.x > xmax) xmax = p1.x;
			if(p1.y < ymin) ymin = p1.y;
			if(p1.y > ymax) ymax = p1.y;
		}
	}
	return new canvas.geom.Rectangle(xmin,ymin,xmax - xmin,ymax - ymin);
}
sandy.extrusion.data.Polygon2D.prototype.edge2edge = function(edge1,edge2) {
	var x1 = edge1[0].x, y1 = edge1[0].y, x2 = edge1[1].x, y2 = edge1[1].y, x3 = edge2[0].x, y3 = edge2[0].y, x4 = edge2[1].x, y4 = edge2[1].y;
	var a = (x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3);
	var b = (x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3);
	var d = (y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1);
	return (d != 0) && (0 < a / d) && (a / d < 1) && (0 < b / d) && (b / d < 1);
}
sandy.extrusion.data.Polygon2D.prototype.edges = function(reorient) {
	if(reorient == null) reorient = false;
	var n = this.vertices.length;
	var r = [];
	var i;
	{
		var _g = 0;
		while(_g < n) {
			var i1 = _g++;
			r[i1] = [];
			r[i1][0] = this.vertices[i1].clone();
			r[i1][1] = this.vertices[(i1 + 1) % n].clone();
			if(reorient && ((r[i1][0].y > r[i1][1].y) || ((r[i1][0].y == r[i1][1].y) && (r[i1][0].x > r[i1][1].x)))) r[i1].reverse();
		}
	}
	return r;
}
sandy.extrusion.data.Polygon2D.prototype.hitTest = function(point,includeVertices) {
	if(includeVertices == null) includeVertices = true;
	var i;
	var n = this.vertices.length;
	{
		var _g = 0;
		while(_g < n) {
			var i1 = _g++;
			if(canvas.geom.Point.distance(this.vertices[i1],point) == 0) {
				return includeVertices;
			}
		}
	}
	var V = this.vertices.slice(0);
	V.push(V[0]);
	var crossing = 0;
	n = V.length - 1;
	{
		var _g = 0;
		while(_g < n) {
			var i1 = _g++;
			if(((V[i1].y <= point.y) && (V[i1 + 1].y > point.y)) || ((V[i1].y > point.y) && (V[i1 + 1].y <= point.y))) {
				var vt = (point.y - V[i1].y) / (V[i1 + 1].y - V[i1].y);
				if(point.x < V[i1].x + vt * (V[i1 + 1].x - V[i1].x)) {
					crossing++;
				}
			}
		}
	}
	return (crossing % 2 != 0);
}
sandy.extrusion.data.Polygon2D.prototype.removeOrphanLinks = function() {
	var ok, i, n;
	do {
		ok = true;
		n = this.vertices.length;
		{
			var _g = 0;
			while(_g < n) {
				var i1 = _g++;
				if(canvas.geom.Point.distance(this.vertices[(i1 + n - 1) % n],this.vertices[(i1 + 1) % n]) == 0) {
					this.vertices.splice((((i1 + 1) % n == 0)?0:i1),2);
					ok = false;
					break;
				}
			}
		}
	} while(!ok);
}
sandy.extrusion.data.Polygon2D.prototype.triangles = function() {
	var mesh = [];
	var edges1;
	var edges2 = this.edges();
	var rest = new sandy.extrusion.data.Polygon2D(this.vertices);
	var o = this.area();
	var i = 0;
	var j;
	var k;
	var n;
	var m;
	var ok;
	while(rest.vertices.length > 2) {
		n = rest.vertices.length;
		var tri = new sandy.extrusion.data.Polygon2D([rest.vertices[(i + n - 1) % n],rest.vertices[i],rest.vertices[(i + 1) % n]]);
		ok = false;
		if(tri.area() * o > 0) {
			edges1 = tri.edges();
			ok = true;
			m = this.vertices.length;
			{
				var _g = 0;
				while(_g < m) {
					var k1 = _g++;
					if(tri.hitTest(this.vertices[k1],false)) {
						ok = false;
						break;
					}
				}
			}
			if(ok) {
				{
					var _g = 0;
					while(_g < 3) {
						var j1 = _g++;
						var _g1 = 0;
						while(_g1 < m) {
							var k1 = _g1++;
							if(this.edge2edge(edges1[j1],edges2[k1])) {
								ok = false;
								break;
							}
						}
					}
				}
			}
		}
		if(ok) {
			mesh.push(tri);
			rest.vertices.splice(i,1);
			rest.removeOrphanLinks();
			i = 0;
		}
		else {
			i++;
			if(i > n - 1) return mesh;
		}
	}
	return mesh;
}
sandy.extrusion.data.Polygon2D.prototype.vertices = null;
sandy.extrusion.data.Polygon2D.prototype.__class__ = sandy.extrusion.data.Polygon2D;
canvas.geom.Matrix = function(in_a,in_b,in_c,in_d,in_tx,in_ty) { if( in_a === $_ ) return; {
	this.a = (in_a == null?1.0:in_a);
	this.b = (in_b == null?0.0:in_b);
	this.c = (in_c == null?0.0:in_c);
	this.d = (in_d == null?1.0:in_d);
	this.tx = (in_tx == null?0.0:in_tx);
	this.ty = (in_ty == null?0.0:in_ty);
}}
canvas.geom.Matrix.__name__ = ["canvas","geom","Matrix"];
canvas.geom.Matrix.prototype.a = null;
canvas.geom.Matrix.prototype.b = null;
canvas.geom.Matrix.prototype.c = null;
canvas.geom.Matrix.prototype.clone = function() {
	return new canvas.geom.Matrix(this.a,this.b,this.c,this.d,this.tx,this.ty);
}
canvas.geom.Matrix.prototype.concat = function(m) {
	var a1 = this.a * m.a + this.b * m.c;
	this.b = this.a * m.b + this.b * m.d;
	this.a = a1;
	var c1 = this.c * m.a + this.d * m.c;
	this.d = this.c * m.b + this.d * m.d;
	this.c = c1;
	var tx1 = this.tx * m.a + this.ty * m.c + m.tx;
	this.ty = this.tx * m.b + this.ty * m.d + m.ty;
	this.tx = tx1;
}
canvas.geom.Matrix.prototype.createGradientBox = function(in_width,in_height,rotation,in_tx,in_ty) {
	this.a = in_width / 1638.4;
	this.d = in_height / 1638.4;
	if(rotation != null && rotation != 0.0) {
		var cos = Math.cos(rotation);
		var sin = Math.sin(rotation);
		this.b = sin * this.d;
		this.c = -sin * this.a;
		this.a *= cos;
		this.d *= cos;
	}
	else {
		this.b = this.c = 0;
	}
	this.tx = (in_tx != null?in_tx + in_width / 2:in_width / 2);
	this.ty = (in_ty != null?in_ty + in_height / 2:in_height / 2);
}
canvas.geom.Matrix.prototype.d = null;
canvas.geom.Matrix.prototype.identity = function() {
	throw "Not implemented. identity.";
}
canvas.geom.Matrix.prototype.invert = function() {
	var norm = this.a * this.d - this.b * this.c;
	if(norm == 0) {
		this.a = this.b = this.c = this.d = 0;
		this.tx = -this.tx;
		this.ty = -this.ty;
	}
	else {
		norm = 1.0 / norm;
		var a1 = this.d * norm;
		this.d = this.a * norm;
		this.a = a1;
		this.b *= -norm;
		this.c *= -norm;
		var tx1 = -this.a * this.tx - this.c * this.ty;
		this.ty = -this.b * this.tx - this.d * this.ty;
		this.tx = tx1;
	}
	return this;
}
canvas.geom.Matrix.prototype.mult = function(m) {
	var result = new canvas.geom.Matrix();
	result.a = this.a * m.a + this.b * m.c;
	result.b = this.a * m.b + this.b * m.d;
	result.c = this.c * m.a + this.d * m.c;
	result.d = this.c * m.b + this.d * m.d;
	result.tx = this.tx * m.a + this.ty * m.c + m.tx;
	result.ty = this.tx * m.b + this.ty * m.d + m.ty;
	return result;
}
canvas.geom.Matrix.prototype.rotate = function(inTheta) {
	var cos = Math.cos(inTheta);
	var sin = Math.sin(inTheta);
	var a1 = this.a * cos - this.b * sin;
	this.b = this.a * sin + this.b * cos;
	this.a = a1;
	var c1 = this.c * cos - this.d * sin;
	this.d = this.c * sin + this.d * cos;
	this.c = c1;
	var tx1 = this.tx * cos - this.ty * sin;
	this.ty = this.tx * sin + this.ty * cos;
	this.tx = tx1;
}
canvas.geom.Matrix.prototype.scale = function(inSX,inSY) {
	this.a *= inSX;
	this.b *= inSY;
	this.c *= inSX;
	this.d *= inSY;
	this.tx *= inSX;
	this.ty *= inSY;
}
canvas.geom.Matrix.prototype.setRotation = function(inTheta,inScale) {
	var scale = (inScale == null?1.0:inScale);
	this.a = Math.cos(inTheta) * scale;
	this.c = Math.sin(inTheta) * scale;
	this.b = -this.c;
	this.d = this.a;
}
canvas.geom.Matrix.prototype.transformPoint = function(inPos) {
	return new canvas.geom.Point(inPos.x * this.a + inPos.y * this.c + this.tx,inPos.x * this.b + inPos.y * this.d + this.ty);
}
canvas.geom.Matrix.prototype.translate = function(inDX,inDY) {
	this.tx += inDX;
	this.ty += inDY;
}
canvas.geom.Matrix.prototype.tx = null;
canvas.geom.Matrix.prototype.ty = null;
canvas.geom.Matrix.prototype.__class__ = canvas.geom.Matrix;
neash.events.FocusEvent = function(type,bubbles,cancelable,inObject,inShiftKey,inKeyCode) { if( type === $_ ) return; {
	neash.events.Event.apply(this,[type,bubbles,cancelable]);
	this.keyCode = inKeyCode;
	this.shiftKey = (inShiftKey == null?false:inShiftKey);
	this.target = inObject;
}}
neash.events.FocusEvent.__name__ = ["neash","events","FocusEvent"];
neash.events.FocusEvent.__super__ = neash.events.Event;
for(var k in neash.events.Event.prototype ) neash.events.FocusEvent.prototype[k] = neash.events.Event.prototype[k];
neash.events.FocusEvent.prototype.keyCode = null;
neash.events.FocusEvent.prototype.relatedObject = null;
neash.events.FocusEvent.prototype.shiftKey = null;
neash.events.FocusEvent.prototype.__class__ = neash.events.FocusEvent;
neash.display.MovieClip = function(p) { if( p === $_ ) return; {
	neash.display.Sprite.apply(this,[]);
	this.enabled = true;
	this.mCurrentFrame = 0;
	this.mTotalFrames = 0;
	this.name = "MovieClip";
}}
neash.display.MovieClip.__name__ = ["neash","display","MovieClip"];
neash.display.MovieClip.__super__ = neash.display.Sprite;
for(var k in neash.display.Sprite.prototype ) neash.display.MovieClip.prototype[k] = neash.display.Sprite.prototype[k];
neash.display.MovieClip.prototype.GetCurrentFrame = function() {
	return this.mCurrentFrame;
}
neash.display.MovieClip.prototype.GetTotalFrames = function() {
	return this.mTotalFrames;
}
neash.display.MovieClip.prototype.currentFrame = null;
neash.display.MovieClip.prototype.enabled = null;
neash.display.MovieClip.prototype.framesLoaded = null;
neash.display.MovieClip.prototype.gotoAndPlay = function(frame,scene) {
	null;
}
neash.display.MovieClip.prototype.mCurrentFrame = null;
neash.display.MovieClip.prototype.mTotalFrames = null;
neash.display.MovieClip.prototype.totalFrames = null;
neash.display.MovieClip.prototype.__class__ = neash.display.MovieClip;
sandy.materials.attributes.ALightAttributes = function(p) { if( p === $_ ) return; {
	this.m_oH = new sandy.core.data.Vector();
	this.m_nFlags = 0;
	this._ambient = 0.3;
	this._diffuse = 1.0;
	this._specular = 0.0;
	this._gloss = 5.0;
	this.m_oCurrentL = new sandy.core.data.Vector();
	this.m_oCurrentV = new sandy.core.data.Vector();
	this.m_oCurrentH = new sandy.core.data.Vector();
}}
sandy.materials.attributes.ALightAttributes.__name__ = ["sandy","materials","attributes","ALightAttributes"];
sandy.materials.attributes.ALightAttributes.prototype.__getAmbient = function() {
	return this._ambient;
}
sandy.materials.attributes.ALightAttributes.prototype.__getDiffuse = function() {
	return this._diffuse;
}
sandy.materials.attributes.ALightAttributes.prototype.__getFlags = function() {
	return this.m_nFlags;
}
sandy.materials.attributes.ALightAttributes.prototype.__getGloss = function() {
	return this._gloss;
}
sandy.materials.attributes.ALightAttributes.prototype.__getSpecular = function() {
	return this._specular;
}
sandy.materials.attributes.ALightAttributes.prototype.__setAmbient = function(p_nAmbient) {
	this._ambient = p_nAmbient;
	this.onPropertyChange();
	return p_nAmbient;
}
sandy.materials.attributes.ALightAttributes.prototype.__setDiffuse = function(p_nDiffuse) {
	this._diffuse = p_nDiffuse;
	this.onPropertyChange();
	return p_nDiffuse;
}
sandy.materials.attributes.ALightAttributes.prototype.__setGloss = function(p_nGloss) {
	this._gloss = p_nGloss;
	this.onPropertyChange();
	return p_nGloss;
}
sandy.materials.attributes.ALightAttributes.prototype.__setSpecular = function(p_nSpecular) {
	this._specular = p_nSpecular;
	this.onPropertyChange();
	return p_nSpecular;
}
sandy.materials.attributes.ALightAttributes.prototype._ambient = null;
sandy.materials.attributes.ALightAttributes.prototype._diffuse = null;
sandy.materials.attributes.ALightAttributes.prototype._gloss = null;
sandy.materials.attributes.ALightAttributes.prototype._specular = null;
sandy.materials.attributes.ALightAttributes.prototype.ambient = null;
sandy.materials.attributes.ALightAttributes.prototype.applyColorToDisplayObject = function(s,c,b) {
	if((c < 1) || (c > 16777215)) {
		c = 16777215;
	}
	var rgb_r_t = (16711680 & c) >> 16;
	var rgb_g_t = (65280 & c) >> 8;
	var rgb_b_t = (255 & c);
	var bY = b * 1.7321 / Math.sqrt(rgb_r_t * rgb_r_t + rgb_g_t * rgb_g_t + rgb_b_t * rgb_b_t);
	var rgb_r = rgb_r_t * bY;
	var rgb_g = rgb_r_t * bY;
	var rgb_b = rgb_r_t * bY;
	var ct = s.GetTransform().colorTransform;
	if((ct.redMultiplier != rgb_r) || (ct.greenMultiplier != rgb_g) || (ct.blueMultiplier != rgb_b)) {
		ct.redMultiplier = rgb_r;
		ct.greenMultiplier = rgb_g;
		ct.blueMultiplier = rgb_b;
	}
}
sandy.materials.attributes.ALightAttributes.prototype.begin = function(p_oScene) {
	this.m_nI = p_oScene.__getLight().getNormalizedPower();
	this.m_oL = p_oScene.__getLight().getDirectionVector();
	this.m_oV = p_oScene.camera.getPosition("absolute");
	this.m_oV.scale(-1);
	this.m_oV.normalize();
	this.m_oH.copy(this.m_oL);
	this.m_oH.add(this.m_oV);
	this.m_oH.normalize();
	this.m_oCurrentShape = null;
	this.m_oCurrentL.copy(this.m_oL);
	this.m_oCurrentV.copy(this.m_oV);
	this.m_oCurrentH.copy(this.m_oH);
}
sandy.materials.attributes.ALightAttributes.prototype.calculate = function(p_oNormal,p_bFrontside,p_bIgnoreSpecular) {
	if(p_bIgnoreSpecular == null) p_bIgnoreSpecular = false;
	var l_n = (p_bFrontside?-1:1);
	var l_k = l_n * this.m_oCurrentL.dot(p_oNormal);
	if(l_k < 0) l_k = 0;
	l_k = this._ambient + this._diffuse * l_k;
	if(!p_bIgnoreSpecular && (this.__getSpecular() > 0)) {
		var l_s = l_n * this.m_oCurrentH.dot(p_oNormal);
		if(l_s < 0) l_s = 0;
		l_k += this._specular * Math.pow(l_s,this._gloss);
	}
	return l_k * this.m_nI;
}
sandy.materials.attributes.ALightAttributes.prototype.diffuse = null;
sandy.materials.attributes.ALightAttributes.prototype.draw = function(p_oGraphics,p_oPolygon,p_oMaterial,p_oScene) {
	if(p_oMaterial.lightingEnable) {
		this.applyColorToDisplayObject((p_oPolygon.shape.__getUseSingleContainer()?p_oPolygon.shape.__getContainer():p_oPolygon.__getContainer()),p_oScene.__getLight().__getColor(),1);
		if(this.m_oCurrentShape != p_oPolygon.shape) {
			this.m_oCurrentShape = p_oPolygon.shape;
			var invModelMatrix = this.m_oCurrentShape.invModelMatrix;
			this.m_oCurrentL.copy(this.m_oL);
			invModelMatrix.vectorMult3x3(this.m_oCurrentL);
			this.m_oCurrentV.copy(this.m_oV);
			invModelMatrix.vectorMult3x3(this.m_oCurrentV);
			this.m_oCurrentH.copy(this.m_oH);
			invModelMatrix.vectorMult3x3(this.m_oCurrentH);
		}
	}
}
sandy.materials.attributes.ALightAttributes.prototype.drawOnSprite = function(p_oSprite,p_oMaterial,p_oScene) {
	if(p_oMaterial.lightingEnable) {
		this.applyColorToDisplayObject(p_oSprite.__getContainer(),p_oScene.__getLight().__getColor(),this.__getAmbient() * p_oScene.__getLight().getNormalizedPower());
	}
}
sandy.materials.attributes.ALightAttributes.prototype.finish = function(p_oScene) {
	null;
}
sandy.materials.attributes.ALightAttributes.prototype.flags = null;
sandy.materials.attributes.ALightAttributes.prototype.gloss = null;
sandy.materials.attributes.ALightAttributes.prototype.init = function(p_oPolygon) {
	null;
}
sandy.materials.attributes.ALightAttributes.prototype.m_nFlags = null;
sandy.materials.attributes.ALightAttributes.prototype.m_nI = null;
sandy.materials.attributes.ALightAttributes.prototype.m_oCurrentH = null;
sandy.materials.attributes.ALightAttributes.prototype.m_oCurrentL = null;
sandy.materials.attributes.ALightAttributes.prototype.m_oCurrentShape = null;
sandy.materials.attributes.ALightAttributes.prototype.m_oCurrentV = null;
sandy.materials.attributes.ALightAttributes.prototype.m_oH = null;
sandy.materials.attributes.ALightAttributes.prototype.m_oL = null;
sandy.materials.attributes.ALightAttributes.prototype.m_oV = null;
sandy.materials.attributes.ALightAttributes.prototype.onPropertyChange = function() {
	null;
}
sandy.materials.attributes.ALightAttributes.prototype.specular = null;
sandy.materials.attributes.ALightAttributes.prototype.unlink = function(p_oPolygon) {
	if(this.m_oCurrentShape == p_oPolygon.shape) {
		this.m_oCurrentShape = null;
	}
}
sandy.materials.attributes.ALightAttributes.prototype.__class__ = sandy.materials.attributes.ALightAttributes;
sandy.materials.attributes.ALightAttributes.__interfaces__ = [sandy.materials.attributes.IAttributes];
sandy.materials.attributes.LightAttributes = function(p_bBright,p_nAmbient) { if( p_bBright === $_ ) return; {
	if(p_nAmbient == null) p_nAmbient = 0.3;
	if(p_bBright == null) p_bBright = false;
	sandy.materials.attributes.ALightAttributes.apply(this,[]);
	this.useBright = p_bBright;
	this.__setAmbient(sandy.util.NumberUtil.constrain(p_nAmbient,0,1));
	this.m_nFlags |= sandy.core.SandyFlags.POLYGON_NORMAL_WORLD;
}}
sandy.materials.attributes.LightAttributes.__name__ = ["sandy","materials","attributes","LightAttributes"];
sandy.materials.attributes.LightAttributes.__super__ = sandy.materials.attributes.ALightAttributes;
for(var k in sandy.materials.attributes.ALightAttributes.prototype ) sandy.materials.attributes.LightAttributes.prototype[k] = sandy.materials.attributes.ALightAttributes.prototype[k];
sandy.materials.attributes.LightAttributes.prototype.draw = function(p_oGraphics,p_oPolygon,p_oMaterial,p_oScene) {
	sandy.materials.attributes.ALightAttributes.prototype.draw.apply(this,[p_oGraphics,p_oPolygon,p_oMaterial,p_oScene]);
	if(p_oMaterial.lightingEnable) {
		var l_aPoints = ((p_oPolygon.isClipped)?p_oPolygon.cvertices:p_oPolygon.vertices);
		var l_oNormal = p_oPolygon.normal.getWorldVector();
		var lightStrength = this.calculate(l_oNormal,p_oPolygon.visible);
		if(lightStrength > 1) lightStrength = 1;
		else if(lightStrength < this.__getAmbient()) lightStrength = this.__getAmbient();
		p_oGraphics.lineStyle();
		if(this.useBright) p_oGraphics.beginFill(((lightStrength < 0.5)?0:16777215),((lightStrength < 0.5)?(1 - 2 * lightStrength):(2 * lightStrength - 1)));
		else p_oGraphics.beginFill(0,1 - lightStrength);
		p_oGraphics.moveTo(l_aPoints[0].sx,l_aPoints[0].sy);
		{
			var _g = 0;
			while(_g < l_aPoints.length) {
				var l_oVertex = l_aPoints[_g];
				++_g;
				p_oGraphics.lineTo(l_oVertex.sx,l_oVertex.sy);
			}
		}
		p_oGraphics.endFill();
		l_oNormal = null;
	}
}
sandy.materials.attributes.LightAttributes.prototype.useBright = null;
sandy.materials.attributes.LightAttributes.prototype.__class__ = sandy.materials.attributes.LightAttributes;
sandy.core.SandyFlags = function() { }
sandy.core.SandyFlags.__name__ = ["sandy","core","SandyFlags"];
sandy.core.SandyFlags.prototype.__class__ = sandy.core.SandyFlags;
sandy.materials.Material = function(p_oAttr) { if( p_oAttr === $_ ) return; {
	this.useVertexNormal = false;
	this.lightingEnable = false;
	this.repeat = true;
	this.m_nFlags = 0;
	this._useLight = false;
	this._filters = [];
	this._id = sandy.materials.Material._ID_++;
	this.attributes = ((p_oAttr == null)?new sandy.materials.attributes.MaterialAttributes():p_oAttr);
	this.m_bModified = true;
	this.m_oType = sandy.materials.MaterialType.NONE;
}}
sandy.materials.Material.__name__ = ["sandy","materials","Material"];
sandy.materials.Material.create = null;
sandy.materials.Material.prototype.__getFilters = function() {
	return this._filters;
}
sandy.materials.Material.prototype.__getFlags = function() {
	var l_nFlags = this.m_nFlags;
	l_nFlags |= this.attributes.__getFlags();
	return l_nFlags;
}
sandy.materials.Material.prototype.__getId = function() {
	return this._id;
}
sandy.materials.Material.prototype.__getModified = function() {
	return (this.m_bModified);
}
sandy.materials.Material.prototype.__getType = function() {
	return this.m_oType;
}
sandy.materials.Material.prototype.__setFilters = function(a) {
	this._filters = a;
	this.m_bModified = true;
	return a;
}
sandy.materials.Material.prototype._filters = null;
sandy.materials.Material.prototype._id = null;
sandy.materials.Material.prototype._useLight = null;
sandy.materials.Material.prototype.attributes = null;
sandy.materials.Material.prototype.begin = function(p_oScene) {
	this.attributes.begin(p_oScene);
}
sandy.materials.Material.prototype.filters = null;
sandy.materials.Material.prototype.finish = function(p_oScene) {
	this.attributes.finish(p_oScene);
}
sandy.materials.Material.prototype.flags = null;
sandy.materials.Material.prototype.id = null;
sandy.materials.Material.prototype.init = function(p_oPolygon) {
	this.attributes.init(p_oPolygon);
}
sandy.materials.Material.prototype.lightingEnable = null;
sandy.materials.Material.prototype.m_bModified = null;
sandy.materials.Material.prototype.m_nFlags = null;
sandy.materials.Material.prototype.m_oType = null;
sandy.materials.Material.prototype.modified = null;
sandy.materials.Material.prototype.renderPolygon = function(p_oScene,p_oPolygon,p_mcContainer) {
	if(this.attributes != null) {
		this.attributes.draw(p_mcContainer.GetGraphics(),p_oPolygon,this,p_oScene);
	}
}
sandy.materials.Material.prototype.renderSprite = function(p_oSprite,p_oMaterial,p_oScene) {
	if(this.attributes != null) {
		this.attributes.drawOnSprite(p_oSprite,p_oMaterial,p_oScene);
	}
}
sandy.materials.Material.prototype.repeat = null;
sandy.materials.Material.prototype.type = null;
sandy.materials.Material.prototype.unlink = function(p_oPolygon) {
	this.attributes.unlink(p_oPolygon);
}
sandy.materials.Material.prototype.useVertexNormal = null;
sandy.materials.Material.prototype.__class__ = sandy.materials.Material;
canvas.geom.MatrixUtil = function() { }
canvas.geom.MatrixUtil.__name__ = ["canvas","geom","MatrixUtil"];
canvas.geom.MatrixUtil.concat = function(args) {
	var thisMatrix;
	var resultMatrix = new canvas.geom.Matrix();
	var invertNext = false;
	{
		var _g = 0;
		while(_g < args.length) {
			var arg = args[_g];
			++_g;
			if(arg == "invert") {
				invertNext = true;
				continue;
			}
			else {
				var b = arg;
				thisMatrix = b.clone();
			}
			if(invertNext) {
				thisMatrix.invert();
				invertNext = false;
			}
			resultMatrix.concat(thisMatrix);
		}
	}
	return resultMatrix;
}
canvas.geom.MatrixUtil.compare = function(m1,m2) {
	if(m1.a != m2.a) return false;
	if(m1.b != m2.b) return false;
	if(m1.c != m2.c) return false;
	if(m1.d != m2.d) return false;
	if(m1.tx != m2.tx) return false;
	if(m1.ty != m2.ty) return false;
	return true;
}
canvas.geom.MatrixUtil.getScaleSign = function(matrix) {
	return ((matrix.a * matrix.d < 0 || matrix.b * matrix.c > 0)?-1:1);
}
canvas.geom.MatrixUtil.transpose = function(matrix) {
	return new canvas.geom.Matrix(matrix.a,matrix.c,matrix.b,matrix.d,0,0);
}
canvas.geom.MatrixUtil.prototype.__class__ = canvas.geom.MatrixUtil;
js = {}
js.Boot = function() { }
js.Boot.__name__ = ["js","Boot"];
js.Boot.__unhtml = function(s) {
	return s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
}
js.Boot.__trace = function(v,i) {
	var msg = (i != null?i.fileName + ":" + i.lineNumber + ": ":"");
	msg += js.Boot.__unhtml(js.Boot.__string_rec(v,"")) + "<br/>";
	var d = document.getElementById("haxe:trace");
	if(d == null) alert("No haxe:trace element defined\n" + msg);
	else d.innerHTML += msg;
}
js.Boot.__clear_trace = function() {
	var d = document.getElementById("haxe:trace");
	if(d != null) d.innerHTML = "";
	else null;
}
js.Boot.__closure = function(o,f) {
	var m = o[f];
	if(m == null) return null;
	var f1 = function() {
		return m.apply(o,arguments);
	}
	f1.scope = o;
	f1.method = m;
	return f1;
}
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ != null || o.__ename__ != null)) t = "object";
	switch(t) {
	case "object":{
		if(o instanceof Array) {
			if(o.__enum__ != null) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				{
					var _g1 = 2, _g = o.length;
					while(_g1 < _g) {
						var i = _g1++;
						if(i != 2) str += "," + js.Boot.__string_rec(o[i],s);
						else str += js.Boot.__string_rec(o[i],s);
					}
				}
				return str + ")";
			}
			var l = o.length;
			var i;
			var str = "[";
			s += "\t";
			{
				var _g = 0;
				while(_g < l) {
					var i1 = _g++;
					str += ((i1 > 0?",":"")) + js.Boot.__string_rec(o[i1],s);
				}
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		}
		catch( $e4 ) {
			{
				var e = $e4;
				{
					return "???";
				}
			}
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = (o.hasOwnProperty != null);
		for( var k in o ) { ;
		if(hasp && !o.hasOwnProperty(k)) continue;
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__") continue;
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	}break;
	case "function":{
		return "<function>";
	}break;
	case "string":{
		return o;
	}break;
	default:{
		return String(o);
	}break;
	}
}
js.Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0, _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js.Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js.Boot.__interfLoop(cc.__super__,cl);
}
js.Boot.__instanceof = function(o,cl) {
	try {
		if(o instanceof cl) {
			if(cl == Array) return (o.__enum__ == null);
			return true;
		}
		if(js.Boot.__interfLoop(o.__class__,cl)) return true;
	}
	catch( $e5 ) {
		{
			var e = $e5;
			{
				if(cl == null) return false;
			}
		}
	}
	switch(cl) {
	case Int:{
		return Math.ceil(o%2147483648.0) === o;
	}break;
	case Float:{
		return typeof(o) == "number";
	}break;
	case Bool:{
		return o === true || o === false;
	}break;
	case String:{
		return typeof(o) == "string";
	}break;
	case Dynamic:{
		return true;
	}break;
	default:{
		if(o == null) return false;
		return o.__enum__ == cl || (cl == Class && o.__name__ != null) || (cl == Enum && o.__ename__ != null);
	}break;
	}
}
js.Boot.__init = function() {
	js.Lib.isIE = (document.all != null && window.opera == null);
	js.Lib.isOpera = (window.opera != null);
	Array.prototype.copy = Array.prototype.slice;
	Array.prototype.insert = function(i,x) {
		this.splice(i,0,x);
	}
	Array.prototype.remove = function(obj) {
		var i = 0;
		var l = this.length;
		while(i < l) {
			if(this[i] == obj) {
				this.splice(i,1);
				return true;
			}
			i++;
		}
		return false;
	}
	Array.prototype.iterator = function() {
		return { cur : 0, arr : this, hasNext : function() {
			return this.cur < this.arr.length;
		}, next : function() {
			return this.arr[this.cur++];
		}}
	}
	var cca = String.prototype.charCodeAt;
	String.prototype.cca = cca;
	String.prototype.charCodeAt = function(i) {
		var x = cca.call(this,i);
		if(isNaN(x)) return null;
		return x;
	}
	var oldsub = String.prototype.substr;
	String.prototype.substr = function(pos,len) {
		if(pos != null && pos != 0 && len != null && len < 0) return "";
		if(len == null) len = this.length;
		if(pos < 0) {
			pos = this.length + pos;
			if(pos < 0) pos = 0;
		}
		else if(len < 0) {
			len = this.length + len - pos;
		}
		return oldsub.apply(this,[pos,len]);
	}
	$closure = js.Boot.__closure;
}
js.Boot.prototype.__class__ = js.Boot;
EReg = function(r,opt) { if( r === $_ ) return; {
	opt = opt.split("u").join("");
	this.r = new RegExp(r,opt);
}}
EReg.__name__ = ["EReg"];
EReg.prototype.customReplace = function(s,f) {
	var buf = new StringBuf();
	while(true) {
		if(!this.match(s)) break;
		buf.b += this.matchedLeft();
		buf.b += f(this);
		s = this.matchedRight();
	}
	buf.b += s;
	return buf.b;
}
EReg.prototype.match = function(s) {
	this.r.m = this.r.exec(s);
	this.r.s = s;
	this.r.l = RegExp.leftContext;
	this.r.r = RegExp.rightContext;
	return (this.r.m != null);
}
EReg.prototype.matched = function(n) {
	return (this.r.m != null && n >= 0 && n < this.r.m.length?this.r.m[n]:function($this) {
		var $r;
		throw "EReg::matched";
		return $r;
	}(this));
}
EReg.prototype.matchedLeft = function() {
	if(this.r.m == null) throw "No string matched";
	if(this.r.l == null) return this.r.s.substr(0,this.r.m.index);
	return this.r.l;
}
EReg.prototype.matchedPos = function() {
	if(this.r.m == null) throw "No string matched";
	return { pos : this.r.m.index, len : this.r.m[0].length}
}
EReg.prototype.matchedRight = function() {
	if(this.r.m == null) throw "No string matched";
	if(this.r.r == null) {
		var sz = this.r.m.index + this.r.m[0].length;
		return this.r.s.substr(sz,this.r.s.length - sz);
	}
	return this.r.r;
}
EReg.prototype.r = null;
EReg.prototype.replace = function(s,by) {
	return s.replace(this.r,by);
}
EReg.prototype.split = function(s) {
	var d = "#__delim__#";
	return s.replace(this.r,d).split(d);
}
EReg.prototype.__class__ = EReg;
js.JsXml__ = function(p) { if( p === $_ ) return; {
	null;
}}
js.JsXml__.__name__ = ["js","JsXml__"];
js.JsXml__.parse = function(str) {
	var rules = [js.JsXml__.enode,js.JsXml__.epcdata,js.JsXml__.eend,js.JsXml__.ecdata,js.JsXml__.edoctype,js.JsXml__.ecomment,js.JsXml__.eprolog];
	var nrules = rules.length;
	var current = Xml.createDocument();
	var stack = new List();
	while(str.length > 0) {
		var i = 0;
		try {
			while(i < nrules) {
				var r = rules[i];
				if(r.match(str)) {
					switch(i) {
					case 0:{
						var x = Xml.createElement(r.matched(1));
						current.addChild(x);
						str = r.matchedRight();
						while(js.JsXml__.eattribute.match(str)) {
							x.set(js.JsXml__.eattribute.matched(1),js.JsXml__.eattribute.matched(3));
							str = js.JsXml__.eattribute.matchedRight();
						}
						if(!js.JsXml__.eclose.match(str)) {
							i = nrules;
							throw "__break__";
						}
						if(js.JsXml__.eclose.matched(1) == ">") {
							stack.push(current);
							current = x;
						}
						str = js.JsXml__.eclose.matchedRight();
					}break;
					case 1:{
						var x = Xml.createPCData(r.matched(0));
						current.addChild(x);
						str = r.matchedRight();
					}break;
					case 2:{
						if(current._children != null && current._children.length == 0) {
							var e = Xml.createPCData("");
							current.addChild(e);
						}
						else null;
						if(r.matched(1) != current._nodeName || stack.isEmpty()) {
							i = nrules;
							throw "__break__";
						}
						else null;
						current = stack.pop();
						str = r.matchedRight();
					}break;
					case 3:{
						str = r.matchedRight();
						if(!js.JsXml__.ecdata_end.match(str)) throw "End of CDATA section not found";
						var x = Xml.createCData(js.JsXml__.ecdata_end.matchedLeft());
						current.addChild(x);
						str = js.JsXml__.ecdata_end.matchedRight();
					}break;
					case 4:{
						var pos = 0;
						var count = 0;
						var old = str;
						try {
							while(true) {
								if(!js.JsXml__.edoctype_elt.match(str)) throw "End of DOCTYPE section not found";
								var p = js.JsXml__.edoctype_elt.matchedPos();
								pos += p.pos + p.len;
								str = js.JsXml__.edoctype_elt.matchedRight();
								switch(js.JsXml__.edoctype_elt.matched(0)) {
								case "[":{
									count++;
								}break;
								case "]":{
									count--;
									if(count < 0) throw "Invalid ] found in DOCTYPE declaration";
								}break;
								default:{
									if(count == 0) throw "__break__";
								}break;
								}
							}
						} catch( e ) { if( e != "__break__" ) throw e; }
						var x = Xml.createDocType(old.substr(0,pos));
						current.addChild(x);
					}break;
					case 5:{
						if(!js.JsXml__.ecomment_end.match(str)) throw "Unclosed Comment";
						var p = js.JsXml__.ecomment_end.matchedPos();
						var x = Xml.createComment(str.substr(0,p.pos + p.len));
						current.addChild(x);
						str = js.JsXml__.ecomment_end.matchedRight();
					}break;
					case 6:{
						var x = Xml.createProlog(r.matched(0));
						current.addChild(x);
						str = r.matchedRight();
					}break;
					}
					throw "__break__";
				}
				i += 1;
			}
		} catch( e ) { if( e != "__break__" ) throw e; }
		if(i == nrules) {
			if(str.length > 10) throw ("Xml parse error : Unexpected " + str.substr(0,10) + "...");
			else throw ("Xml parse error : Unexpected " + str);
		}
	}
	return current;
}
js.JsXml__.createElement = function(name) {
	var r = new js.JsXml__();
	r.nodeType = Xml.Element;
	r._children = new Array();
	r._attributes = new Hash();
	r.setNodeName(name);
	return r;
}
js.JsXml__.createPCData = function(data) {
	var r = new js.JsXml__();
	r.nodeType = Xml.PCData;
	r.setNodeValue(data);
	return r;
}
js.JsXml__.createCData = function(data) {
	var r = new js.JsXml__();
	r.nodeType = Xml.CData;
	r.setNodeValue(data);
	return r;
}
js.JsXml__.createComment = function(data) {
	var r = new js.JsXml__();
	r.nodeType = Xml.Comment;
	r.setNodeValue(data);
	return r;
}
js.JsXml__.createDocType = function(data) {
	var r = new js.JsXml__();
	r.nodeType = Xml.DocType;
	r.setNodeValue(data);
	return r;
}
js.JsXml__.createProlog = function(data) {
	var r = new js.JsXml__();
	r.nodeType = Xml.Prolog;
	r.setNodeValue(data);
	return r;
}
js.JsXml__.createDocument = function() {
	var r = new js.JsXml__();
	r.nodeType = Xml.Document;
	r._children = new Array();
	return r;
}
js.JsXml__.prototype._attributes = null;
js.JsXml__.prototype._children = null;
js.JsXml__.prototype._nodeName = null;
js.JsXml__.prototype._nodeValue = null;
js.JsXml__.prototype._parent = null;
js.JsXml__.prototype.addChild = function(x) {
	if(this._children == null) throw "bad nodetype";
	if(x._parent != null) x._parent._children.remove(x);
	x._parent = this;
	this._children.push(x);
}
js.JsXml__.prototype.attributes = function() {
	if(this.nodeType != Xml.Element) throw "bad nodeType";
	return this._attributes.keys();
}
js.JsXml__.prototype.elements = function() {
	if(this._children == null) throw "bad nodetype";
	return { cur : 0, x : this._children, hasNext : function() {
		var k = this.cur;
		var l = this.x.length;
		while(k < l) {
			if(this.x[k].nodeType == Xml.Element) break;
			k += 1;
		}
		this.cur = k;
		return k < l;
	}, next : function() {
		var k = this.cur;
		var l = this.x.length;
		while(k < l) {
			var n = this.x[k];
			k += 1;
			if(n.nodeType == Xml.Element) {
				this.cur = k;
				return n;
			}
		}
		return null;
	}}
}
js.JsXml__.prototype.elementsNamed = function(name) {
	if(this._children == null) throw "bad nodetype";
	return { cur : 0, x : this._children, hasNext : function() {
		var k = this.cur;
		var l = this.x.length;
		while(k < l) {
			var n = this.x[k];
			if(n.nodeType == Xml.Element && n._nodeName == name) break;
			k++;
		}
		this.cur = k;
		return k < l;
	}, next : function() {
		var k = this.cur;
		var l = this.x.length;
		while(k < l) {
			var n = this.x[k];
			k++;
			if(n.nodeType == Xml.Element && n._nodeName == name) {
				this.cur = k;
				return n;
			}
		}
		return null;
	}}
}
js.JsXml__.prototype.exists = function(att) {
	if(this.nodeType != Xml.Element) throw "bad nodeType";
	return this._attributes.exists(att);
}
js.JsXml__.prototype.firstChild = function() {
	if(this._children == null) throw "bad nodetype";
	return this._children[0];
}
js.JsXml__.prototype.firstElement = function() {
	if(this._children == null) throw "bad nodetype";
	var cur = 0;
	var l = this._children.length;
	while(cur < l) {
		var n = this._children[cur];
		if(n.nodeType == Xml.Element) return n;
		cur++;
	}
	return null;
}
js.JsXml__.prototype.get = function(att) {
	if(this.nodeType != Xml.Element) throw "bad nodeType";
	return this._attributes.get(att);
}
js.JsXml__.prototype.getNodeName = function() {
	if(this.nodeType != Xml.Element) throw "bad nodeType";
	return this._nodeName;
}
js.JsXml__.prototype.getNodeValue = function() {
	if(this.nodeType == Xml.Element || this.nodeType == Xml.Document) throw "bad nodeType";
	return this._nodeValue;
}
js.JsXml__.prototype.getParent = function() {
	return this._parent;
}
js.JsXml__.prototype.insertChild = function(x,pos) {
	if(this._children == null) throw "bad nodetype";
	if(x._parent != null) x._parent._children.remove(x);
	x._parent = this;
	this._children.insert(pos,x);
}
js.JsXml__.prototype.iterator = function() {
	if(this._children == null) throw "bad nodetype";
	return { cur : 0, x : this._children, hasNext : function() {
		return this.cur < this.x.length;
	}, next : function() {
		return this.x[this.cur++];
	}}
}
js.JsXml__.prototype.nodeName = null;
js.JsXml__.prototype.nodeType = null;
js.JsXml__.prototype.nodeValue = null;
js.JsXml__.prototype.parent = null;
js.JsXml__.prototype.remove = function(att) {
	if(this.nodeType != Xml.Element) throw "bad nodeType";
	this._attributes.remove(att);
}
js.JsXml__.prototype.removeChild = function(x) {
	if(this._children == null) throw "bad nodetype";
	var b = this._children.remove(x);
	if(b) x._parent = null;
	return b;
}
js.JsXml__.prototype.set = function(att,value) {
	if(this.nodeType != Xml.Element) throw "bad nodeType";
	this._attributes.set(att,value);
}
js.JsXml__.prototype.setNodeName = function(n) {
	if(this.nodeType != Xml.Element) throw "bad nodeType";
	return this._nodeName = n;
}
js.JsXml__.prototype.setNodeValue = function(v) {
	if(this.nodeType == Xml.Element || this.nodeType == Xml.Document) throw "bad nodeType";
	return this._nodeValue = v;
}
js.JsXml__.prototype.toString = function() {
	if(this.nodeType == Xml.PCData) return this._nodeValue;
	if(this.nodeType == Xml.CData) return "<![CDATA[" + this._nodeValue + "]]>";
	if(this.nodeType == Xml.Comment || this.nodeType == Xml.DocType || this.nodeType == Xml.Prolog) return this._nodeValue;
	var s = new StringBuf();
	if(this.nodeType == Xml.Element) {
		s.b += "<";
		s.b += this._nodeName;
		{ var $it6 = this._attributes.keys();
		while( $it6.hasNext() ) { var k = $it6.next();
		{
			s.b += " ";
			s.b += k;
			s.b += "=\"";
			s.b += this._attributes.get(k);
			s.b += "\"";
		}
		}}
		if(this._children.length == 0) {
			s.b += "/>";
			return s.b;
		}
		s.b += ">";
	}
	{ var $it7 = this.iterator();
	while( $it7.hasNext() ) { var x = $it7.next();
	s.b += x.toString();
	}}
	if(this.nodeType == Xml.Element) {
		s.b += "</";
		s.b += this._nodeName;
		s.b += ">";
	}
	return s.b;
}
js.JsXml__.prototype.__class__ = js.JsXml__;
sandy.core.light = {}
sandy.core.light.Light3D = function(p_oD,p_nPow) { if( p_oD === $_ ) return; {
	this._dir = p_oD;
	this._dir.normalize();
	neash.events.EventDispatcher.apply(this,[]);
	this.setPower(p_nPow);
}}
sandy.core.light.Light3D.__name__ = ["sandy","core","light","Light3D"];
sandy.core.light.Light3D.__super__ = neash.events.EventDispatcher;
for(var k in neash.events.EventDispatcher.prototype ) sandy.core.light.Light3D.prototype[k] = neash.events.EventDispatcher.prototype[k];
sandy.core.light.Light3D.prototype.__getColor = function() {
	return this._color;
}
sandy.core.light.Light3D.prototype.__setColor = function(p_nColor) {
	this._color = p_nColor;
	this.dispatchEvent(new sandy.events.SandyEvent(sandy.events.SandyEvent.LIGHT_COLOR_CHANGED));
	return p_nColor;
}
sandy.core.light.Light3D.prototype._color = null;
sandy.core.light.Light3D.prototype._dir = null;
sandy.core.light.Light3D.prototype._nPower = null;
sandy.core.light.Light3D.prototype._power = null;
sandy.core.light.Light3D.prototype.calculate = function(normal) {
	var DP = this._dir.dot(normal);
	DP = -DP;
	if(DP < 0) {
		DP = 0;
	}
	return this._nPower * DP;
}
sandy.core.light.Light3D.prototype.color = null;
sandy.core.light.Light3D.prototype.destroy = function() {
	null;
}
sandy.core.light.Light3D.prototype.getDirectionVector = function() {
	return this._dir;
}
sandy.core.light.Light3D.prototype.getNormalizedPower = function() {
	return this._nPower;
}
sandy.core.light.Light3D.prototype.getPower = function() {
	return this._power;
}
sandy.core.light.Light3D.prototype.setDirection = function(x,y,z) {
	this._dir.x = x;
	this._dir.y = y;
	this._dir.z = z;
	this._dir.normalize();
	this.dispatchEvent(new sandy.events.SandyEvent(sandy.events.SandyEvent.LIGHT_UPDATED));
}
sandy.core.light.Light3D.prototype.setDirectionVector = function(pDir) {
	this._dir = pDir;
	this._dir.normalize();
	this.dispatchEvent(new sandy.events.SandyEvent(sandy.events.SandyEvent.LIGHT_UPDATED));
}
sandy.core.light.Light3D.prototype.setPower = function(p_nPow) {
	this._power = sandy.util.NumberUtil.constrain(p_nPow,0,150);
	this._nPower = this._power / 150;
	this.dispatchEvent(new sandy.events.SandyEvent(sandy.events.SandyEvent.LIGHT_UPDATED));
}
sandy.core.light.Light3D.prototype.__class__ = sandy.core.light.Light3D;
neash.swf = {}
neash.swf.Tags = function() { }
neash.swf.Tags.__name__ = ["neash","swf","Tags"];
neash.swf.Tags.string = function(i) {
	return neash.swf.Tags.tags[i];
}
neash.swf.Tags.prototype.__class__ = neash.swf.Tags;
haxe.Int32 = function() { }
haxe.Int32.__name__ = ["haxe","Int32"];
haxe.Int32.make = function(a,b) {
	return (a << 16) | b;
}
haxe.Int32.ofInt = function(x) {
	return x;
}
haxe.Int32.toInt = function(x) {
	if((((x) >> 30) & 1) != ((x) >>> 31)) throw "Overflow " + x;
	return ((x) & -1);
}
haxe.Int32.add = function(a,b) {
	return (a) + (b);
}
haxe.Int32.sub = function(a,b) {
	return (a) - (b);
}
haxe.Int32.mul = function(a,b) {
	return (a) * (b);
}
haxe.Int32.div = function(a,b) {
	return Std["int"]((a) / (b));
}
haxe.Int32.mod = function(a,b) {
	return (a) % (b);
}
haxe.Int32.shl = function(a,b) {
	return (a) << b;
}
haxe.Int32.shr = function(a,b) {
	return (a) >> b;
}
haxe.Int32.ushr = function(a,b) {
	return (a) >>> b;
}
haxe.Int32.and = function(a,b) {
	return (a) & (b);
}
haxe.Int32.or = function(a,b) {
	return (a) | (b);
}
haxe.Int32.xor = function(a,b) {
	return (a) ^ (b);
}
haxe.Int32.neg = function(a) {
	return -(a);
}
haxe.Int32.complement = function(a) {
	return ~(a);
}
haxe.Int32.compare = function(a,b) {
	return (a) - (b);
}
haxe.Int32.prototype.__class__ = haxe.Int32;
sandy.core.data.Edge3D = function(p_nVertexId1,p_nVertexId2) { if( p_nVertexId1 === $_ ) return; {
	this.vertexId1 = p_nVertexId1;
	this.vertexId2 = p_nVertexId2;
}}
sandy.core.data.Edge3D.__name__ = ["sandy","core","data","Edge3D"];
sandy.core.data.Edge3D.prototype.clone = function() {
	var l_oEdge = new sandy.core.data.Edge3D(this.vertexId1,this.vertexId2);
	return l_oEdge;
}
sandy.core.data.Edge3D.prototype.vertex1 = null;
sandy.core.data.Edge3D.prototype.vertex2 = null;
sandy.core.data.Edge3D.prototype.vertexId1 = null;
sandy.core.data.Edge3D.prototype.vertexId2 = null;
sandy.core.data.Edge3D.prototype.__class__ = sandy.core.data.Edge3D;
sandy.materials.IAlphaMaterial = function() { }
sandy.materials.IAlphaMaterial.__name__ = ["sandy","materials","IAlphaMaterial"];
sandy.materials.IAlphaMaterial.prototype.__getAlpha = null;
sandy.materials.IAlphaMaterial.prototype.__setAlpha = null;
sandy.materials.IAlphaMaterial.prototype.alpha = null;
sandy.materials.IAlphaMaterial.prototype.__class__ = sandy.materials.IAlphaMaterial;
sandy.materials.BitmapMaterial = function(p_oTexture,p_oAttr,p_nPrecision) { if( p_oTexture === $_ ) return; {
	if(p_nPrecision == null) p_nPrecision = 0;
	this.smooth = false;
	this.precision = 0;
	this.maxRecurssionDepth = 5;
	this.map = new canvas.geom.Matrix();
	this.m_nRecLevel = 0;
	this.m_oPoint = new canvas.geom.Point();
	this.matrix = new canvas.geom.Matrix();
	this.m_oTiling = new canvas.geom.Point(1,1);
	this.m_oOffset = new canvas.geom.Point(0,0);
	this.forceUpdate = false;
	this.m_nAlpha = 1.0;
	sandy.materials.Material.apply(this,[p_oAttr]);
	this.m_oType = sandy.materials.MaterialType.BITMAP;
	var temp = new canvas.display.BitmapData(p_oTexture.getWidth(),p_oTexture.getHeight(),true,0);
	temp.draw(p_oTexture);
	this.__setTexture(temp);
	this.m_oPolygonMatrixMap = new Array();
	this.precision = p_nPrecision;
}}
sandy.materials.BitmapMaterial.__name__ = ["sandy","materials","BitmapMaterial"];
sandy.materials.BitmapMaterial.__super__ = sandy.materials.Material;
for(var k in sandy.materials.Material.prototype ) sandy.materials.BitmapMaterial.prototype[k] = sandy.materials.Material.prototype[k];
sandy.materials.BitmapMaterial.prototype.__getAlpha = function() {
	return this.m_nAlpha;
}
sandy.materials.BitmapMaterial.prototype.__getTexture = function() {
	return this.m_oTexture;
}
sandy.materials.BitmapMaterial.prototype.__setAlpha = function(p_nValue) {
	this.setTransparency(p_nValue);
	this.m_nAlpha = p_nValue;
	this.m_bModified = true;
	return p_nValue;
}
sandy.materials.BitmapMaterial.prototype.__setTexture = function(p_oTexture) {
	if(p_oTexture == this.m_oTexture) {
		return null;
	}
	else {
		if(this.m_oTexture != null) this.m_oTexture.dispose();
		if(this.m_orgTexture != null) this.m_orgTexture.dispose();
	}
	var l_bReWrap = false;
	if(this.m_nHeight != p_oTexture.getHeight()) l_bReWrap = true;
	else if(this.m_nWidth != p_oTexture.getWidth()) l_bReWrap = true;
	this.m_oTexture = p_oTexture;
	this.m_orgTexture = p_oTexture.clone();
	this.m_nHeight = this.m_oTexture.getHeight();
	this.m_nWidth = this.m_oTexture.getWidth();
	this.m_nInvHeight = 1 / this.m_nHeight;
	this.m_nInvWidth = 1 / this.m_nWidth;
	if(l_bReWrap && this.m_oPolygonMatrixMap != null) {
		{
			var _g = 0, _g1 = this.m_oPolygonMatrixMap;
			while(_g < _g1.length) {
				var l_sID = _g1[_g];
				++_g;
			}
		}
	}
	return p_oTexture;
}
sandy.materials.BitmapMaterial.prototype._createTextureMatrix = function(p_aUv) {
	var u0 = (p_aUv[0].u * this.m_oTiling.x + this.m_oOffset.x) * this.m_nWidth, v0 = (p_aUv[0].v * this.m_oTiling.y + this.m_oOffset.y) * this.m_nHeight, u1 = (p_aUv[1].u * this.m_oTiling.x + this.m_oOffset.x) * this.m_nWidth, v1 = (p_aUv[1].v * this.m_oTiling.y + this.m_oOffset.y) * this.m_nHeight, u2 = (p_aUv[2].u * this.m_oTiling.x + this.m_oOffset.x) * this.m_nWidth, v2 = (p_aUv[2].v * this.m_oTiling.y + this.m_oOffset.y) * this.m_nHeight;
	if((u0 == u1 && v0 == v1) || (u0 == u2 && v0 == v2)) {
		u0 -= ((u0 > 0.05)?0.05:-0.05);
		v0 -= ((v0 > 0.07)?0.07:-0.07);
	}
	if(u2 == u1 && v2 == v1) {
		u2 -= ((u2 > 0.05)?0.04:-0.04);
		v2 -= ((v2 > 0.06)?0.06:-0.06);
	}
	var m = new canvas.geom.Matrix((u1 - u0),(v1 - v0),(u2 - u0),(v2 - v0),u0,v0);
	m.invert();
	return m;
}
sandy.materials.BitmapMaterial.prototype._tesselatePolygon = function(p_aPoints,p_aUv) {
	var l_points = p_aPoints.slice(0);
	var l_uv = p_aUv.slice(0);
	if(l_points.length > 3) {
		l_points = l_points.slice(0,3);
		l_uv = l_uv.slice(0,3);
		p_aPoints.splice(1,1);
		p_aUv.splice(1,1);
		this._tesselatePolygon(p_aPoints,p_aUv);
	}
	this.map = this._createTextureMatrix(l_uv);
	var v0 = l_points[0];
	var v1 = l_points[1];
	var v2 = l_points[2];
	if(this.precision == 0) {
		this.renderTriangle(this.map.a,this.map.b,this.map.c,this.map.d,this.map.tx,this.map.ty,v0.sx,v0.sy,v1.sx,v1.sy,v2.sx,v2.sy);
	}
	else {
		this.renderRec(this.map.a,this.map.b,this.map.c,this.map.d,this.map.tx,this.map.ty,v0.sx,v0.sy,v0.wz,v1.sx,v1.sy,v1.wz,v2.sx,v2.sy,v2.wz);
	}
	l_points = null;
	l_uv = null;
}
sandy.materials.BitmapMaterial.prototype.alpha = null;
sandy.materials.BitmapMaterial.prototype.forceUpdate = null;
sandy.materials.BitmapMaterial.prototype.graphics = null;
sandy.materials.BitmapMaterial.prototype.init = function(p_oPolygon) {
	if(p_oPolygon.vertices.length >= 3) {
		var m = null;
		if(this.m_nWidth > 0 && this.m_nHeight > 0) {
			var l_aUV = p_oPolygon.aUVCoord;
			if(l_aUV != null) {
				m = this._createTextureMatrix(l_aUV);
			}
		}
		this.m_oPolygonMatrixMap[p_oPolygon.id] = m;
	}
	sandy.materials.Material.prototype.init.apply(this,[p_oPolygon]);
}
sandy.materials.BitmapMaterial.prototype.m_nAlpha = null;
sandy.materials.BitmapMaterial.prototype.m_nHeight = null;
sandy.materials.BitmapMaterial.prototype.m_nInvHeight = null;
sandy.materials.BitmapMaterial.prototype.m_nInvWidth = null;
sandy.materials.BitmapMaterial.prototype.m_nRecLevel = null;
sandy.materials.BitmapMaterial.prototype.m_nWidth = null;
sandy.materials.BitmapMaterial.prototype.m_oCmf = null;
sandy.materials.BitmapMaterial.prototype.m_oOffset = null;
sandy.materials.BitmapMaterial.prototype.m_oPoint = null;
sandy.materials.BitmapMaterial.prototype.m_oPolygonMatrixMap = null;
sandy.materials.BitmapMaterial.prototype.m_oTexture = null;
sandy.materials.BitmapMaterial.prototype.m_oTiling = null;
sandy.materials.BitmapMaterial.prototype.m_orgTexture = null;
sandy.materials.BitmapMaterial.prototype.map = null;
sandy.materials.BitmapMaterial.prototype.matrix = null;
sandy.materials.BitmapMaterial.prototype.maxRecurssionDepth = null;
sandy.materials.BitmapMaterial.prototype.polygon = null;
sandy.materials.BitmapMaterial.prototype.precision = null;
sandy.materials.BitmapMaterial.prototype.renderPolygon = function(p_oScene,p_oPolygon,p_mcContainer) {
	if(this.m_oTexture == null) return;
	var l_points, l_uv;
	this.polygon = p_oPolygon;
	this.graphics = p_mcContainer.GetGraphics();
	this.m_nRecLevel = 0;
	if(this.polygon.isClipped) {
		l_points = p_oPolygon.cvertices.slice(0);
		l_uv = p_oPolygon.caUVCoord.slice(0);
		this._tesselatePolygon(l_points,l_uv);
	}
	else if(this.polygon.vertices.length > 3) {
		l_points = p_oPolygon.vertices.slice(0);
		l_uv = p_oPolygon.aUVCoord.slice(0);
		this._tesselatePolygon(l_points,l_uv);
	}
	else {
		l_points = p_oPolygon.vertices;
		l_uv = p_oPolygon.aUVCoord;
		this.map = this.m_oPolygonMatrixMap[this.polygon.id];
		var v0 = l_points[0];
		var v1 = l_points[1];
		var v2 = l_points[2];
		if(this.precision == 0) {
			this.renderTriangle(this.map.a,this.map.b,this.map.c,this.map.d,this.map.tx,this.map.ty,v0.sx,v0.sy,v1.sx,v1.sy,v2.sx,v2.sy);
		}
		else {
			this.renderRec(this.map.a,this.map.b,this.map.c,this.map.d,this.map.tx,this.map.ty,v0.sx,v0.sy,v0.wz,v1.sx,v1.sy,v1.wz,v2.sx,v2.sy,v2.wz);
		}
	}
	if(this.attributes != null) this.attributes.draw(this.graphics,this.polygon,this,p_oScene);
	l_points = null;
	l_uv = null;
}
sandy.materials.BitmapMaterial.prototype.renderRec = function(ta,tb,tc,td,tx,ty,ax,ay,az,bx,by,bz,cx,cy,cz) {
	this.m_nRecLevel++;
	var ta2 = ta + ta;
	var tb2 = tb + tb;
	var tc2 = tc + tc;
	var td2 = td + td;
	var tx2 = tx + tx;
	var ty2 = ty + ty;
	var mabz = 2 / (az + bz);
	var mbcz = 2 / (bz + cz);
	var mcaz = 2 / (cz + az);
	var mabx = (ax * az + bx * bz) * mabz;
	var maby = (ay * az + by * bz) * mabz;
	var mbcx = (bx * bz + cx * cz) * mbcz;
	var mbcy = (by * bz + cy * cz) * mbcz;
	var mcax = (cx * cz + ax * az) * mcaz;
	var mcay = (cy * cz + ay * az) * mcaz;
	var dabx = ax + bx - mabx;
	var daby = ay + by - maby;
	var dbcx = bx + cx - mbcx;
	var dbcy = by + cy - mbcy;
	var dcax = cx + ax - mcax;
	var dcay = cy + ay - mcay;
	var dsab = (dabx * dabx + daby * daby);
	var dsbc = (dbcx * dbcx + dbcy * dbcy);
	var dsca = (dcax * dcax + dcay * dcay);
	var mabxHalf = mabx * 0.5;
	var mabyHalf = maby * 0.5;
	var azbzHalf = (az + bz) * 0.5;
	var mcaxHalf = mcax * 0.5;
	var mcayHalf = mcay * 0.5;
	var czazHalf = (cz + az) * 0.5;
	var mbcxHalf = mbcx * 0.5;
	var mbcyHalf = mbcy * 0.5;
	var bzczHalf = (bz + cz) * 0.5;
	if((this.m_nRecLevel > this.maxRecurssionDepth) || ((dsab <= this.precision) && (dsca <= this.precision) && (dsbc <= this.precision))) {
		this.renderTriangle(ta,tb,tc,td,tx,ty,ax,ay,bx,by,cx,cy);
		this.m_nRecLevel--;
		return;
	}
	if((dsab > this.precision) && (dsca > this.precision) && (dsbc > this.precision)) {
		this.renderRec(ta2,tb2,tc2,td2,tx2,ty2,ax,ay,az,mabxHalf,mabyHalf,azbzHalf,mcaxHalf,mcayHalf,czazHalf);
		this.renderRec(ta2,tb2,tc2,td2,tx2 - 1,ty2,mabxHalf,mabyHalf,azbzHalf,bx,by,bz,mbcxHalf,mbcyHalf,bzczHalf);
		this.renderRec(ta2,tb2,tc2,td2,tx2,ty2 - 1,mcaxHalf,mcayHalf,czazHalf,mbcxHalf,mbcyHalf,bzczHalf,cx,cy,cz);
		this.renderRec(-ta2,-tb2,-tc2,-td2,-tx2 + 1,-ty2 + 1,mbcxHalf,mbcyHalf,bzczHalf,mcaxHalf,mcayHalf,czazHalf,mabxHalf,mabyHalf,azbzHalf);
		this.m_nRecLevel--;
		return;
	}
	var dmax = Math.max(dsab,Math.max(dsca,dsbc));
	if(dsab == dmax) {
		this.renderRec(ta2,tb,tc2,td,tx2,ty,ax,ay,az,mabxHalf,mabyHalf,azbzHalf,cx,cy,cz);
		this.renderRec(ta2 + tb,tb,tc2 + td,td,tx2 + ty - 1,ty,mabxHalf,mabyHalf,azbzHalf,bx,by,bz,cx,cy,cz);
		this.m_nRecLevel--;
		return;
	}
	if(dsca == dmax) {
		this.renderRec(ta,tb2,tc,td2,tx,ty2,ax,ay,az,bx,by,bz,mcaxHalf,mcayHalf,czazHalf);
		this.renderRec(ta,tb2 + ta,tc,td2 + tc,tx,ty2 + tx - 1,mcaxHalf,mcayHalf,czazHalf,bx,by,bz,cx,cy,cz);
		this.m_nRecLevel--;
		return;
	}
	this.renderRec(ta - tb,tb2,tc - td,td2,tx - ty,ty2,ax,ay,az,bx,by,bz,mbcxHalf,mbcyHalf,bzczHalf);
	this.renderRec(ta2,tb - ta,tc2,td - tc,tx2,ty - tx,ax,ay,az,mbcxHalf,mbcyHalf,bzczHalf,cx,cy,cz);
	this.m_nRecLevel--;
}
sandy.materials.BitmapMaterial.prototype.renderTriangle = function(a,b,c,d,tx,ty,v0x,v0y,v1x,v1y,v2x,v2y) {
	var a2 = v1x - v0x;
	var b2 = v1y - v0y;
	var c2 = v2x - v0x;
	var d2 = v2y - v0y;
	this.matrix.a = a * a2 + b * c2;
	this.matrix.b = a * b2 + b * d2;
	this.matrix.c = c * a2 + d * c2;
	this.matrix.d = c * b2 + d * d2;
	this.matrix.tx = tx * a2 + ty * c2 + v0x;
	this.matrix.ty = tx * b2 + ty * d2 + v0y;
	this.graphics.lineStyle();
	this.graphics.beginBitmapFill(this.m_oTexture,this.matrix,this.repeat,this.smooth);
	this.graphics.moveTo(v0x,v0y);
	this.graphics.lineTo(v1x,v1y);
	this.graphics.lineTo(v2x,v2y);
	this.graphics.endFill();
}
sandy.materials.BitmapMaterial.prototype.setTiling = function(p_nW,p_nH,p_nU,p_nV) {
	if(p_nV == null) p_nV = 0.0;
	if(p_nU == null) p_nU = 0.0;
	this.m_oTiling.x = p_nW;
	this.m_oTiling.y = p_nH;
	this.m_oOffset.x = p_nU - Math.floor(p_nU);
	this.m_oOffset.y = p_nV - Math.floor(p_nV);
	{
		var _g = 0, _g1 = this.m_oPolygonMatrixMap;
		while(_g < _g1.length) {
			var l_sID = _g1[_g];
			++_g;
		}
	}
}
sandy.materials.BitmapMaterial.prototype.setTransparency = function(p_nValue) {
	p_nValue = sandy.util.NumberUtil.constrain(p_nValue,0,1);
	if(this.m_oCmf != null) this.m_oCmf = null;
	var matrix = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,p_nValue,0];
}
sandy.materials.BitmapMaterial.prototype.smooth = null;
sandy.materials.BitmapMaterial.prototype.texture = null;
sandy.materials.BitmapMaterial.prototype.toString = function() {
	return "sandy.materials.BitmapMaterial";
}
sandy.materials.BitmapMaterial.prototype.unlink = function(p_oPolygon) {
	if(this.m_oPolygonMatrixMap[p_oPolygon.id] != null) this.m_oPolygonMatrixMap[p_oPolygon.id] = null;
	sandy.materials.Material.prototype.unlink.apply(this,[p_oPolygon]);
}
sandy.materials.BitmapMaterial.prototype.__class__ = sandy.materials.BitmapMaterial;
sandy.materials.BitmapMaterial.__interfaces__ = [sandy.materials.IAlphaMaterial];
neash.geom.Transform = function(inParent) { if( inParent === $_ ) return; {
	this.mObj = inParent;
	this.colorTransform = new neash.geom.ColorTransform();
}}
neash.geom.Transform.__name__ = ["neash","geom","Transform"];
neash.geom.Transform.prototype.GetMatrix = function() {
	return this.mObj.GetMatrix();
}
neash.geom.Transform.prototype.SetMatrix = function(inMatrix) {
	return this.mObj.SetMatrix(inMatrix);
}
neash.geom.Transform.prototype.colorTransform = null;
neash.geom.Transform.prototype.mObj = null;
neash.geom.Transform.prototype.matrix = null;
neash.geom.Transform.prototype.__class__ = neash.geom.Transform;
neash.text.TextFieldAutoSize = function(p) { if( p === $_ ) return; {
	null;
}}
neash.text.TextFieldAutoSize.__name__ = ["neash","text","TextFieldAutoSize"];
neash.text.TextFieldAutoSize.prototype.__class__ = neash.text.TextFieldAutoSize;
js.Lib = function() { }
js.Lib.__name__ = ["js","Lib"];
js.Lib.isIE = null;
js.Lib.isOpera = null;
js.Lib.document = null;
js.Lib.window = null;
js.Lib.alert = function(v) {
	alert(js.Boot.__string_rec(v,""));
}
js.Lib.eval = function(code) {
	return eval(code);
}
js.Lib.setErrorHandler = function(f) {
	js.Lib.onerror = f;
}
js.Lib.prototype.__class__ = js.Lib;
neash.swf.Font = function(inStream,inVersion) { if( inStream === $_ ) return; {
	this.mGlyphs = [];
	inStream.AlignBits();
	var has_layout = (inVersion > 1) && inStream.ReadBool();
	var has_jis = (inVersion > 1) && inStream.ReadBool();
	var small_text = (inVersion > 1) && inStream.ReadBool();
	var is_ansi = (inVersion > 1) && inStream.ReadBool();
	var wide_offsets = (inVersion > 1) && inStream.ReadBool();
	var wide_codes = (inVersion > 1) && inStream.ReadBool();
	var italic = (inVersion > 1) && inStream.ReadBool();
	var bold = (inVersion > 1) && inStream.ReadBool();
	var lang_code = ((inVersion > 1)?inStream.ReadByte():0);
	this.mName = ((inVersion > 1)?inStream.ReadPascalString():"font");
	var n;
	var s0;
	var offsets = new Array();
	var code_offset = 0;
	var v3scale = (inVersion > 2?1.0:0.05);
	if(inVersion > 1) {
		n = inStream.ReadUI16();
		s0 = inStream.BytesLeft();
		{
			var _g = 0;
			while(_g < n) {
				var i = _g++;
				offsets.push((wide_offsets?inStream.ReadInt():inStream.ReadUI16()));
			}
		}
		code_offset = (wide_offsets?inStream.ReadInt():inStream.ReadUI16());
		code_offset = s0 - code_offset;
	}
	else {
		s0 = inStream.BytesLeft();
		var o0 = inStream.ReadUI16();
		n = o0 >> 1;
		offsets.push(o0);
		{
			var _g = 1;
			while(_g < n) {
				var i = _g++;
				offsets.push(inStream.ReadUI16());
			}
		}
	}
	var access_last = this.mGlyphs[n - 1];
	inStream.AlignBits();
	{
		var _g = 0;
		while(_g < n) {
			var i = _g++;
			if(inStream.BytesLeft() != (s0 - offsets[i])) throw ("bad offset in font stream (" + inStream.BytesLeft() + "!=" + (s0 - offsets[i]) + ")");
			var moved = false;
			var pen_x = 0.0;
			var pen_y = 0.0;
			var commands = new Array();
			inStream.AlignBits();
			var fill_bits = inStream.Bits(4);
			var line_bits = inStream.Bits(4);
			while(true) {
				var edge = inStream.ReadBool();
				if(!edge) {
					var new_styles = inStream.ReadBool();
					var new_line_style = inStream.ReadBool();
					var new_fill_style1 = inStream.ReadBool();
					var new_fill_style0 = inStream.ReadBool();
					var move_to = inStream.ReadBool();
					if(new_styles || new_styles || new_fill_style1) throw ("fill style can't be changed here " + new_styles + "," + new_styles + "," + new_fill_style0);
					if(!move_to) break;
					if(!new_fill_style0 && commands.length == 0) throw ("fill style should be defined");
					var bits = inStream.Bits(5);
					pen_x = inStream.Twips(bits) * v3scale;
					pen_y = inStream.Twips(bits) * v3scale;
					var px = [pen_x];
					var py = [pen_y];
					commands.push(function(py,px) {
						return function(g,m) {
							g.moveTo(px[0] * m.a + py[0] * m.c + m.tx,px[0] * m.b + py[0] * m.d + m.ty);
						}
					}(py,px));
					if(new_fill_style0) {
						var fill_style = inStream.Bits(1);
					}
				}
				else {
					if(inStream.ReadBool()) {
						var delta_bits = inStream.Bits(4) + 2;
						if(inStream.ReadBool()) {
							pen_x += inStream.Twips(delta_bits) * v3scale;
							pen_y += inStream.Twips(delta_bits) * v3scale;
						}
						else if(inStream.ReadBool()) pen_y += inStream.Twips(delta_bits) * v3scale;
						else pen_x += inStream.Twips(delta_bits) * v3scale;
						var px = [pen_x];
						var py = [pen_y];
						commands.push(function(py,px) {
							return function(g,m) {
								g.lineTo(px[0] * m.a + py[0] * m.c + m.tx,px[0] * m.b + py[0] * m.d + m.ty);
							}
						}(py,px));
					}
					else {
						var delta_bits = inStream.Bits(4) + 2;
						var cx = [pen_x + inStream.Twips(delta_bits) * v3scale];
						var cy = [pen_y + inStream.Twips(delta_bits) * v3scale];
						var px = [cx[0] + inStream.Twips(delta_bits) * v3scale];
						var py = [cy[0] + inStream.Twips(delta_bits) * v3scale];
						pen_x = px[0];
						pen_y = py[0];
						commands.push(function(py,px,cy,cx) {
							return function(g,m) {
								g.curveTo(cx[0] * m.a + cy[0] * m.c + m.tx,cx[0] * m.b + cy[0] * m.d + m.ty,px[0] * m.a + py[0] * m.c + m.tx,px[0] * m.b + py[0] * m.d + m.ty);
							}
						}(py,px,cy,cx));
					}
				}
			}
			commands.push(function() {
				return function(g,m) {
					g.endFill();
				}
			}());
			this.mGlyphs[i] = { mCommands : commands, mAdvance : 1024.0}
		}
	}
	if(code_offset != 0) {
		inStream.AlignBits();
		if(inStream.BytesLeft() != code_offset) throw ("Code offset miscaculation");
		this.mCodeToGlyph = new Array();
		{
			var _g = 0;
			while(_g < n) {
				var i = _g++;
				var code = (wide_codes?inStream.ReadUI16():inStream.ReadByte());
				this.mCodeToGlyph[code] = this.mGlyphs[i];
			}
		}
	}
	else this.mCodeToGlyph = this.mGlyphs;
	if(has_layout) {
		this.mAscent = inStream.ReadSTwips();
		this.mDescent = inStream.ReadSTwips();
		this.mLeading = inStream.ReadSTwips();
		this.mAdvance = new Array();
		{
			var _g = 0;
			while(_g < n) {
				var i = _g++;
				this.mGlyphs[i].mAdvance = inStream.ReadSTwips();
			}
		}
	}
	else {
		this.mAscent = 800;
		this.mDescent = 224;
		this.mLeading = 0;
	}
	neash.text.FontManager.RegisterFont(this);
}}
neash.swf.Font.__name__ = ["neash","swf","Font"];
neash.swf.Font.prototype.GetAdvance = function(inChar,inNext) {
	if(this.mCodeToGlyph.length > inChar) {
		var glyph = this.mCodeToGlyph[inChar];
		if(glyph != null) return glyph.mAdvance;
	}
	return 1024.0;
}
neash.swf.Font.prototype.GetAscent = function() {
	return this.mAscent;
}
neash.swf.Font.prototype.GetDescent = function() {
	return this.mDescent;
}
neash.swf.Font.prototype.GetLeading = function() {
	return this.mLeading;
}
neash.swf.Font.prototype.GetName = function() {
	return this.mName;
}
neash.swf.Font.prototype.Ok = function() {
	return true;
}
neash.swf.Font.prototype.RenderChar = function(inGraphics,inChar,m) {
	if(this.mCodeToGlyph.length > inChar) {
		var glyph = this.mCodeToGlyph[inChar];
		if(glyph != null) {
			{
				var _g = 0, _g1 = glyph.mCommands;
				while(_g < _g1.length) {
					var c = _g1[_g];
					++_g;
					c(inGraphics,m);
				}
			}
			return glyph.mAdvance;
		}
	}
	return 0;
}
neash.swf.Font.prototype.RenderGlyph = function(inGraphics,inGlyph,m) {
	if(this.mGlyphs.length > inGlyph) {
		var commands = this.mGlyphs[inGlyph].mCommands;
		{
			var _g = 0;
			while(_g < commands.length) {
				var c = commands[_g];
				++_g;
				c(inGraphics,m);
			}
		}
	}
	else {
		haxe.Log.trace("Unsupported glyph: " + String.fromCharCode(inGlyph),{ fileName : "Font.hx", lineNumber : 265, className : "neash.swf.Font", methodName : "RenderGlyph"});
	}
}
neash.swf.Font.prototype.RestoreLineStyle = function(g) {
	null;
}
neash.swf.Font.prototype.mAdvance = null;
neash.swf.Font.prototype.mAscent = null;
neash.swf.Font.prototype.mCodeToGlyph = null;
neash.swf.Font.prototype.mDescent = null;
neash.swf.Font.prototype.mGlyphs = null;
neash.swf.Font.prototype.mLeading = null;
neash.swf.Font.prototype.mName = null;
neash.swf.Font.prototype.__class__ = neash.swf.Font;
ValueType = { __ename__ : ["ValueType"], __constructs__ : ["TNull","TInt","TFloat","TBool","TObject","TFunction","TClass","TEnum","TUnknown"] }
ValueType.TBool = ["TBool",3];
ValueType.TBool.toString = $estr;
ValueType.TBool.__enum__ = ValueType;
ValueType.TClass = function(c) { var $x = ["TClass",6,c]; $x.__enum__ = ValueType; $x.toString = $estr; return $x; }
ValueType.TEnum = function(e) { var $x = ["TEnum",7,e]; $x.__enum__ = ValueType; $x.toString = $estr; return $x; }
ValueType.TFloat = ["TFloat",2];
ValueType.TFloat.toString = $estr;
ValueType.TFloat.__enum__ = ValueType;
ValueType.TFunction = ["TFunction",5];
ValueType.TFunction.toString = $estr;
ValueType.TFunction.__enum__ = ValueType;
ValueType.TInt = ["TInt",1];
ValueType.TInt.toString = $estr;
ValueType.TInt.__enum__ = ValueType;
ValueType.TNull = ["TNull",0];
ValueType.TNull.toString = $estr;
ValueType.TNull.__enum__ = ValueType;
ValueType.TObject = ["TObject",4];
ValueType.TObject.toString = $estr;
ValueType.TObject.__enum__ = ValueType;
ValueType.TUnknown = ["TUnknown",8];
ValueType.TUnknown.toString = $estr;
ValueType.TUnknown.__enum__ = ValueType;
Type = function() { }
Type.__name__ = ["Type"];
Type.getClass = function(o) {
	if(o == null) return null;
	if(o.__enum__ != null) return null;
	return o.__class__;
}
Type.getEnum = function(o) {
	if(o == null) return null;
	return o.__enum__;
}
Type.getSuperClass = function(c) {
	return c.__super__;
}
Type.getClassName = function(c) {
	if(c == null) return null;
	var a = c.__name__;
	return a.join(".");
}
Type.getEnumName = function(e) {
	var a = e.__ename__;
	return a.join(".");
}
Type.resolveClass = function(name) {
	var cl;
	try {
		cl = eval(name);
	}
	catch( $e8 ) {
		{
			var e = $e8;
			{
				cl = null;
			}
		}
	}
	if(cl == null || cl.__name__ == null) return null;
	return cl;
}
Type.resolveEnum = function(name) {
	var e;
	try {
		e = eval(name);
	}
	catch( $e9 ) {
		{
			var err = $e9;
			{
				e = null;
			}
		}
	}
	if(e == null || e.__ename__ == null) return null;
	return e;
}
Type.createInstance = function(cl,args) {
	if(args.length <= 3) return new cl(args[0],args[1],args[2]);
	if(args.length > 8) throw "Too many arguments";
	return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7]);
}
Type.createEmptyInstance = function(cl) {
	return new cl($_);
}
Type.createEnum = function(e,constr,params) {
	var f = Reflect.field(e,constr);
	if(f == null) throw "No such constructor " + constr;
	if(Reflect.isFunction(f)) {
		if(params == null) throw "Constructor " + constr + " need parameters";
		return f.apply(e,params);
	}
	if(params != null && params.length != 0) throw "Constructor " + constr + " does not need parameters";
	return f;
}
Type.getInstanceFields = function(c) {
	var a = Reflect.fields(c.prototype);
	a.remove("__class__");
	return a;
}
Type.getClassFields = function(c) {
	var a = Reflect.fields(c);
	a.remove("__name__");
	a.remove("__interfaces__");
	a.remove("__super__");
	a.remove("prototype");
	return a;
}
Type.getEnumConstructs = function(e) {
	return e.__constructs__;
}
Type["typeof"] = function(v) {
	switch(typeof(v)) {
	case "boolean":{
		return ValueType.TBool;
	}break;
	case "string":{
		return ValueType.TClass(String);
	}break;
	case "number":{
		if(Math.ceil(v) == v % 2147483648.0) return ValueType.TInt;
		return ValueType.TFloat;
	}break;
	case "object":{
		if(v == null) return ValueType.TNull;
		var e = v.__enum__;
		if(e != null) return ValueType.TEnum(e);
		var c = v.__class__;
		if(c != null) return ValueType.TClass(c);
		return ValueType.TObject;
	}break;
	case "function":{
		if(v.__name__ != null) return ValueType.TObject;
		return ValueType.TFunction;
	}break;
	case "undefined":{
		return ValueType.TNull;
	}break;
	default:{
		return ValueType.TUnknown;
	}break;
	}
}
Type.enumEq = function(a,b) {
	if(a == b) return true;
	if(a[0] != b[0]) return false;
	{
		var _g1 = 2, _g = a.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(!Type.enumEq(a[i],b[i])) return false;
		}
	}
	var e = a.__enum__;
	if(e != b.__enum__ || e == null) return false;
	return true;
}
Type.enumConstructor = function(e) {
	return e[0];
}
Type.enumParameters = function(e) {
	return e.slice(2);
}
Type.enumIndex = function(e) {
	return e[1];
}
Type.prototype.__class__ = Type;
sandy.materials.Appearance = function(p_oFront,p_oBack) { if( p_oFront === $_ ) return; {
	this.m_oFrontMaterial = ((p_oFront != null)?p_oFront:new sandy.materials.ColorMaterial());
	this.m_oBackMaterial = ((p_oBack != null)?p_oBack:this.m_oFrontMaterial);
}}
sandy.materials.Appearance.__name__ = ["sandy","materials","Appearance"];
sandy.materials.Appearance.prototype.__getBackMaterial = function() {
	return this.m_oBackMaterial;
}
sandy.materials.Appearance.prototype.__getFlags = function() {
	var l_nFlag = this.m_oFrontMaterial.__getFlags();
	if(this.m_oFrontMaterial != this.m_oBackMaterial) {
		l_nFlag |= this.m_oBackMaterial.__getFlags();
	}
	return l_nFlag;
}
sandy.materials.Appearance.prototype.__getFrontMaterial = function() {
	return this.m_oFrontMaterial;
}
sandy.materials.Appearance.prototype.__getUseVertexNormal = function() {
	return (this.m_oBackMaterial.useVertexNormal && this.m_oFrontMaterial.useVertexNormal);
}
sandy.materials.Appearance.prototype.__setBackMaterial = function(p_oMat) {
	this.m_oBackMaterial = p_oMat;
	if(this.m_oFrontMaterial == null) {
		this.m_oFrontMaterial = p_oMat;
	}
	return p_oMat;
}
sandy.materials.Appearance.prototype.__setFrontMaterial = function(p_oMat) {
	this.m_oFrontMaterial = p_oMat;
	if(this.m_oBackMaterial == null) {
		this.m_oBackMaterial = p_oMat;
	}
	return p_oMat;
}
sandy.materials.Appearance.prototype.backMaterial = null;
sandy.materials.Appearance.prototype.flags = null;
sandy.materials.Appearance.prototype.frontMaterial = null;
sandy.materials.Appearance.prototype.m_oBackMaterial = null;
sandy.materials.Appearance.prototype.m_oFrontMaterial = null;
sandy.materials.Appearance.prototype.toString = function() {
	return "sandy.materials.Appearance";
}
sandy.materials.Appearance.prototype.useVertexNormal = null;
sandy.materials.Appearance.prototype.__class__ = sandy.materials.Appearance;
sandy.materials.WireFrameMaterial = function(p_nThickness,p_nColor,p_nAlpha,p_oAttr) { if( p_nThickness === $_ ) return; {
	if(p_nAlpha == null) p_nAlpha = 1.0;
	if(p_nColor == null) p_nColor = 0;
	if(p_nThickness == null) p_nThickness = 1;
	sandy.materials.Material.apply(this,[p_oAttr]);
	this.m_oType = sandy.materials.MaterialType.WIREFRAME;
	this.attributes.attributes.push(new sandy.materials.attributes.LineAttributes(p_nThickness,p_nColor,p_nAlpha));
}}
sandy.materials.WireFrameMaterial.__name__ = ["sandy","materials","WireFrameMaterial"];
sandy.materials.WireFrameMaterial.__super__ = sandy.materials.Material;
for(var k in sandy.materials.Material.prototype ) sandy.materials.WireFrameMaterial.prototype[k] = sandy.materials.Material.prototype[k];
sandy.materials.WireFrameMaterial.prototype.renderPolygon = function(p_oScene,p_oPolygon,p_mcContainer) {
	this.attributes.draw(p_mcContainer.GetGraphics(),p_oPolygon,this,p_oScene);
}
sandy.materials.WireFrameMaterial.prototype.__class__ = sandy.materials.WireFrameMaterial;
sandy.core.scenegraph.Shape3D = function(p_sName,p_oGeometry,p_oAppearance,p_bUseSingleContainer) { if( p_sName === $_ ) return; {
	this.aPolygons = new Array();
	this.enableNearClipping = false;
	this.enableClipping = false;
	this.enableForcedDepth = false;
	this.forcedDepth = 0;
	this.m_bEv = false;
	this.m_oGeomCenter = new sandy.core.data.Vector();
	this.m_bBackFaceCulling = true;
	this.m_bClipped = false;
	this.m_bUseSingleContainer = true;
	this.m_nDepth = 0;
	this.m_aToProject = new Array();
	this.m_aVisiblePoly = new Array();
	this.m_bMouseInteractivity = false;
	this.m_bForcedSingleContainer = false;
	this.invModelMatrix = new sandy.core.data.Matrix4();
	if(p_sName == null) p_sName = "";
	if(p_bUseSingleContainer == null) p_bUseSingleContainer = true;
	sandy.core.scenegraph.ATransformable.apply(this,[p_sName]);
	this.m_oContainer = new neash.display.Sprite();
	this.__setGeometry(p_oGeometry);
	this.m_bUseSingleContainer = !p_bUseSingleContainer;
	this.__setUseSingleContainer(p_bUseSingleContainer);
	this.__setAppearance(((p_oAppearance != null)?p_oAppearance:sandy.core.scenegraph.Shape3D.DEFAULT_APPEARANCE));
	this.updateBoundingVolumes();
}}
sandy.core.scenegraph.Shape3D.__name__ = ["sandy","core","scenegraph","Shape3D"];
sandy.core.scenegraph.Shape3D.__super__ = sandy.core.scenegraph.ATransformable;
for(var k in sandy.core.scenegraph.ATransformable.prototype ) sandy.core.scenegraph.Shape3D.prototype[k] = sandy.core.scenegraph.ATransformable.prototype[k];
sandy.core.scenegraph.Shape3D.prototype.__destroyPolygons = function() {
	if(this.aPolygons != null && this.aPolygons.length > 0) {
		var i = 0, l = this.aPolygons.length;
		while(i < l) {
			if(this.__getBroadcaster() != null) this.__getBroadcaster().removeChild(this.aPolygons[i].__getBroadcaster());
			if(this.aPolygons[i] != null) this.aPolygons[i].destroy();
			this.aPolygons[i] = null;
			i++;
		}
	}
	this.aPolygons.splice(0,this.aPolygons.length);
	this.aPolygons = null;
}
sandy.core.scenegraph.Shape3D.prototype.__generatePolygons = function(p_oGeometry) {
	var i = 0, j = 0, l = p_oGeometry.aFacesVertexID.length;
	this.aPolygons = new Array();
	{
		var _g = 0;
		while(_g < l) {
			var i1 = _g++;
			this.aPolygons[i1] = new sandy.core.data.Polygon(this,p_oGeometry,p_oGeometry.aFacesVertexID[i1],p_oGeometry.aFacesUVCoordsID[i1],i1,i1);
			if(this.m_oAppearance != null) this.aPolygons[(i1)].__setAppearance(this.m_oAppearance);
			this.__getBroadcaster().addChild(this.aPolygons[(i1)].__getBroadcaster());
		}
	}
}
sandy.core.scenegraph.Shape3D.prototype.__getAppearance = function() {
	return this.m_oAppearance;
}
sandy.core.scenegraph.Shape3D.prototype.__getContainer = function() {
	return this.m_oContainer;
}
sandy.core.scenegraph.Shape3D.prototype.__getDepth = function() {
	return this.m_nDepth;
}
sandy.core.scenegraph.Shape3D.prototype.__getEnableBackFaceCulling = function() {
	return this.m_bBackFaceCulling;
}
sandy.core.scenegraph.Shape3D.prototype.__getEnableEvents = function() {
	return false;
}
sandy.core.scenegraph.Shape3D.prototype.__getEnableInteractivity = function() {
	return this.m_bMouseInteractivity;
}
sandy.core.scenegraph.Shape3D.prototype.__getGeometry = function() {
	return this.m_oGeometry;
}
sandy.core.scenegraph.Shape3D.prototype.__getGeometryCenter = function() {
	return this.m_oGeomCenter;
}
sandy.core.scenegraph.Shape3D.prototype.__getUseSingleContainer = function() {
	return this.m_bUseSingleContainer;
}
sandy.core.scenegraph.Shape3D.prototype.__getVisiblePolygonsCount = function() {
	return this.m_nVisiblePoly;
}
sandy.core.scenegraph.Shape3D.prototype.__setAppearance = function(p_oApp) {
	this.m_oAppearance = p_oApp;
	if(this.m_oGeometry != null) {
		{
			var _g = 0, _g1 = this.aPolygons;
			while(_g < _g1.length) {
				var v = _g1[_g];
				++_g;
				v.__setAppearance(this.m_oAppearance);
			}
		}
	}
	return p_oApp;
}
sandy.core.scenegraph.Shape3D.prototype.__setDepth = function(p_nDepth) {
	return p_nDepth;
}
sandy.core.scenegraph.Shape3D.prototype.__setEnableBackFaceCulling = function(b) {
	if(b != this.m_bBackFaceCulling) {
		this.m_bBackFaceCulling = b;
		this.changed = true;
	}
	return b;
}
sandy.core.scenegraph.Shape3D.prototype.__setEnableEvents = function(b) {
	var v = null;
	if(b) {
		if(!this.m_bEv) {
			if(this.m_bUseSingleContainer == false) {
				{
					var _g = 0, _g1 = this.aPolygons;
					while(_g < _g1.length) {
						var v1 = _g1[_g];
						++_g;
						v1.__setEnableEvents(true);
					}
				}
			}
			else {
				this.m_oContainer.addEventListener(neash.events.MouseEvent.CLICK,$closure(this,"_onInteraction"));
				this.m_oContainer.addEventListener(neash.events.MouseEvent.MOUSE_UP,$closure(this,"_onInteraction"));
				this.m_oContainer.addEventListener(neash.events.MouseEvent.MOUSE_DOWN,$closure(this,"_onInteraction"));
				this.m_oContainer.addEventListener(neash.events.MouseEvent.ROLL_OVER,$closure(this,"_onInteraction"));
				this.m_oContainer.addEventListener(neash.events.MouseEvent.ROLL_OUT,$closure(this,"_onInteraction"));
				this.m_oContainer.addEventListener(neash.events.MouseEvent.DOUBLE_CLICK,$closure(this,"_onInteraction"));
				this.m_oContainer.addEventListener(neash.events.MouseEvent.MOUSE_MOVE,$closure(this,"_onInteraction"));
				this.m_oContainer.addEventListener(neash.events.MouseEvent.MOUSE_OVER,$closure(this,"_onInteraction"));
				this.m_oContainer.addEventListener(neash.events.MouseEvent.MOUSE_OUT,$closure(this,"_onInteraction"));
				this.m_oContainer.addEventListener(neash.events.MouseEvent.MOUSE_WHEEL,$closure(this,"_onInteraction"));
			}
		}
	}
	else if(!b && this.m_bEv) {
		if(this.m_bUseSingleContainer == false) {
			{
				var _g = 0, _g1 = this.aPolygons;
				while(_g < _g1.length) {
					var v1 = _g1[_g];
					++_g;
					v1.__setEnableEvents(false);
				}
			}
		}
		else {
			this.m_oContainer.removeEventListener(neash.events.MouseEvent.CLICK,$closure(this,"_onInteraction"));
			this.m_oContainer.removeEventListener(neash.events.MouseEvent.MOUSE_UP,$closure(this,"_onInteraction"));
			this.m_oContainer.removeEventListener(neash.events.MouseEvent.MOUSE_DOWN,$closure(this,"_onInteraction"));
			this.m_oContainer.removeEventListener(neash.events.MouseEvent.ROLL_OVER,$closure(this,"_onInteraction"));
			this.m_oContainer.removeEventListener(neash.events.MouseEvent.ROLL_OUT,$closure(this,"_onInteraction"));
			this.m_oContainer.removeEventListener(neash.events.MouseEvent.DOUBLE_CLICK,$closure(this,"_onInteraction"));
			this.m_oContainer.removeEventListener(neash.events.MouseEvent.MOUSE_MOVE,$closure(this,"_onInteraction"));
			this.m_oContainer.removeEventListener(neash.events.MouseEvent.MOUSE_OVER,$closure(this,"_onInteraction"));
			this.m_oContainer.removeEventListener(neash.events.MouseEvent.MOUSE_OUT,$closure(this,"_onInteraction"));
			this.m_oContainer.removeEventListener(neash.events.MouseEvent.MOUSE_WHEEL,$closure(this,"_onInteraction"));
		}
	}
	this.m_bEv = b;
	return b;
}
sandy.core.scenegraph.Shape3D.prototype.__setEnableInteractivity = function(p_bState) {
	if(p_bState != this.m_bMouseInteractivity) {
		if(p_bState) {
			if(this.m_bUseSingleContainer == true) {
				this.m_bUseSingleContainer = false;
				this.m_bForcedSingleContainer = true;
			}
		}
		else {
			if(this.m_bForcedSingleContainer == true) {
				this.__setUseSingleContainer(true);
				this.m_bForcedSingleContainer = false;
			}
		}
		{
			var _g = 0, _g1 = this.aPolygons;
			while(_g < _g1.length) {
				var l_oPolygon = _g1[_g];
				++_g;
				l_oPolygon.__setEnableInteractivity(p_bState);
			}
		}
		this.m_bMouseInteractivity = p_bState;
	}
	return p_bState;
}
sandy.core.scenegraph.Shape3D.prototype.__setGeometry = function(p_geometry) {
	if(p_geometry == null) return null;
	this.m_oGeometry = p_geometry;
	this.updateBoundingVolumes();
	this.m_oGeometry.generateFaceNormals();
	this.m_oGeometry.generateVertexNormals();
	this.__destroyPolygons();
	this.__generatePolygons(this.m_oGeometry);
	return p_geometry;
}
sandy.core.scenegraph.Shape3D.prototype.__setGeometryCenter = function(p_oGeomCenter) {
	var l_oDiff = p_oGeomCenter.clone();
	l_oDiff.sub(this.m_oGeomCenter);
	if(this.m_oGeometry != null) {
		{
			var _g = 0, _g1 = this.m_oGeometry.aVertex;
			while(_g < _g1.length) {
				var l_oVertex = _g1[_g];
				++_g;
				l_oVertex.x += l_oDiff.x;
				l_oVertex.y += l_oDiff.y;
				l_oVertex.z += l_oDiff.z;
			}
		}
	}
	this.m_oGeomCenter.copy(p_oGeomCenter);
	this.updateBoundingVolumes();
	return p_oGeomCenter;
}
sandy.core.scenegraph.Shape3D.prototype.__setUseSingleContainer = function(p_bUseSingleContainer) {
	var l_oFace;
	if(p_bUseSingleContainer == this.m_bUseSingleContainer) return p_bUseSingleContainer;
	if(p_bUseSingleContainer) {
		{
			var _g = 0, _g1 = this.aPolygons;
			while(_g < _g1.length) {
				var l_oFace1 = _g1[_g];
				++_g;
				if(l_oFace1.__getContainer().GetParent() != null) {
					l_oFace1.__getContainer().GetGraphics().clear();
					l_oFace1.__getContainer().GetParent().removeChild(l_oFace1.__getContainer());
					this.__getBroadcaster().removeChild(l_oFace1.__getBroadcaster());
				}
			}
		}
	}
	else {
		if(this.m_oContainer.GetParent() != null) {
			this.m_oContainer.GetGraphics().clear();
			this.m_oContainer.GetParent().removeChild(this.m_oContainer);
		}
		{
			var _g = 0, _g1 = this.aPolygons;
			while(_g < _g1.length) {
				var l_oFace1 = _g1[_g];
				++_g;
				this.__getBroadcaster().addChild(l_oFace1.__getBroadcaster());
				l_oFace1.__getContainer().GetGraphics().clear();
			}
		}
	}
	this.m_bUseSingleContainer = p_bUseSingleContainer;
	return p_bUseSingleContainer;
}
sandy.core.scenegraph.Shape3D.prototype._onInteraction = function(p_oEvt) {
	var l_oClick = new canvas.geom.Point(this.m_oContainer.GetMouseX(),this.m_oContainer.GetMouseY());
	var l_oA = new canvas.geom.Point(), l_oB = new canvas.geom.Point(), l_oC = new canvas.geom.Point();
	var l_oPoly;
	var l_aSId = this.aPolygons.sortOn("m_nDepth",Array.NUMERIC | Array.RETURNINDEXEDARRAY);
	var l = this.aPolygons.length, j;
	{
		var _g = 0;
		while(_g < l) {
			var j1 = _g++;
			l_oPoly = this.aPolygons[l_aSId[j1]];
			if(!l_oPoly.visible && this.m_bBackFaceCulling) continue;
			var l_nSize = l_oPoly.vertices.length;
			var l_nTriangles = l_nSize - 2;
			{
				var _g1 = 0;
				while(_g1 < l_nTriangles) {
					var i = _g1++;
					l_oA.x = l_oPoly.vertices[i].sx;
					l_oA.y = l_oPoly.vertices[i].sy;
					l_oB.x = l_oPoly.vertices[i + 1].sx;
					l_oB.y = l_oPoly.vertices[i + 1].sy;
					l_oC.x = l_oPoly.vertices[(i + 2) % l_nSize].sx;
					l_oC.y = l_oPoly.vertices[(i + 2) % l_nSize].sy;
					if(sandy.math.IntersectionMath.isPointInTriangle2D(l_oClick,l_oA,l_oB,l_oC)) {
						var l_oUV = l_oPoly.getUVFrom2D(l_oClick);
						var l_oPt3d = l_oPoly.get3DFrom2D(l_oClick);
						this.m_oEB.broadcastEvent(new sandy.events.Shape3DEvent(p_oEvt.type,this,l_oPoly,l_oUV,l_oPt3d,p_oEvt));
						return;
					}
				}
			}
		}
	}
}
sandy.core.scenegraph.Shape3D.prototype.aPolygons = null;
sandy.core.scenegraph.Shape3D.prototype.appearance = null;
sandy.core.scenegraph.Shape3D.prototype.clear = function() {
	if(this.m_oContainer != null) this.m_oContainer.GetGraphics().clear();
}
sandy.core.scenegraph.Shape3D.prototype.clone = function(p_sName,p_bKeepTransform) {
	if(p_sName == null) p_sName = "";
	if(p_bKeepTransform == null) p_bKeepTransform = false;
	var l_oClone = new sandy.core.scenegraph.Shape3D(p_sName,this.__getGeometry().clone(),this.__getAppearance(),this.m_bUseSingleContainer);
	if(p_bKeepTransform == true) l_oClone.__setMatrix(this.__getMatrix());
	return l_oClone;
}
sandy.core.scenegraph.Shape3D.prototype.container = null;
sandy.core.scenegraph.Shape3D.prototype.cull = function(p_oScene,p_oFrustum,p_oViewMatrix,p_bChanged) {
	sandy.core.scenegraph.ATransformable.prototype.cull.apply(this,[p_oScene,p_oFrustum,p_oViewMatrix,p_bChanged]);
	if(this.culled == sandy.view.Frustum.OUTSIDE) return;
	if(!this.boundingSphere.uptodate) this.boundingSphere.transform(this.viewMatrix);
	this.culled = p_oFrustum.sphereInFrustum(this.boundingSphere);
	if(this.culled == sandy.view.Frustum.INTERSECT && this.boundingBox != null) {
		if(!this.boundingBox.uptodate) this.boundingBox.transform(this.viewMatrix);
		this.culled = p_oFrustum.boxInFrustum(this.boundingBox);
	}
	this.m_bClipped = ((this.culled == sandy.view.CullingState.INTERSECT) && (this.enableClipping || this.enableNearClipping));
}
sandy.core.scenegraph.Shape3D.prototype.depth = null;
sandy.core.scenegraph.Shape3D.prototype.destroy = function() {
	this.m_oGeometry.dispose();
	this.clear();
	if(this.m_oContainer.GetParent() != null) this.m_oContainer.GetParent().removeChild(this.m_oContainer);
	if(this.m_oContainer != null) this.m_oContainer = null;
	this.__destroyPolygons();
	sandy.core.scenegraph.ATransformable.prototype.destroy.apply(this,[]);
}
sandy.core.scenegraph.Shape3D.prototype.display = function(p_oScene,p_oContainer) {
	this.m_aVisiblePoly.sort(function(a,b) {
		return (a.__getDepth() > b.__getDepth()?1:(a.__getDepth() < b.__getDepth()?-1:0));
	});
	{
		var _g = 0, _g1 = this.m_aVisiblePoly;
		while(_g < _g1.length) {
			var l_oPoly = _g1[_g];
			++_g;
			l_oPoly.display(p_oScene,this.m_oContainer);
		}
	}
}
sandy.core.scenegraph.Shape3D.prototype.enableBackFaceCulling = null;
sandy.core.scenegraph.Shape3D.prototype.enableClipping = null;
sandy.core.scenegraph.Shape3D.prototype.enableEvents = null;
sandy.core.scenegraph.Shape3D.prototype.enableForcedDepth = null;
sandy.core.scenegraph.Shape3D.prototype.enableInteractivity = null;
sandy.core.scenegraph.Shape3D.prototype.enableNearClipping = null;
sandy.core.scenegraph.Shape3D.prototype.forcedDepth = null;
sandy.core.scenegraph.Shape3D.prototype.geometry = null;
sandy.core.scenegraph.Shape3D.prototype.geometryCenter = null;
sandy.core.scenegraph.Shape3D.prototype.invModelMatrix = null;
sandy.core.scenegraph.Shape3D.prototype.m_aToProject = null;
sandy.core.scenegraph.Shape3D.prototype.m_aVisiblePoly = null;
sandy.core.scenegraph.Shape3D.prototype.m_bBackFaceCulling = null;
sandy.core.scenegraph.Shape3D.prototype.m_bClipped = null;
sandy.core.scenegraph.Shape3D.prototype.m_bEv = null;
sandy.core.scenegraph.Shape3D.prototype.m_bForcedSingleContainer = null;
sandy.core.scenegraph.Shape3D.prototype.m_bMouseInteractivity = null;
sandy.core.scenegraph.Shape3D.prototype.m_bUseSingleContainer = null;
sandy.core.scenegraph.Shape3D.prototype.m_nDepth = null;
sandy.core.scenegraph.Shape3D.prototype.m_nVisiblePoly = null;
sandy.core.scenegraph.Shape3D.prototype.m_oAppearance = null;
sandy.core.scenegraph.Shape3D.prototype.m_oContainer = null;
sandy.core.scenegraph.Shape3D.prototype.m_oGeomCenter = null;
sandy.core.scenegraph.Shape3D.prototype.m_oGeometry = null;
sandy.core.scenegraph.Shape3D.prototype.render = function(p_oScene,p_oCamera) {
	if(this.m_oAppearance == null) return;
	var m11, m21, m31, m12, m22, m32, m13, m23, m33, m14, m24, m34, x, y, z, tx, ty, tz;
	var l_nZNear = p_oCamera.__getNear(), l_aPoints = this.m_oGeometry.aVertex, l_oMatrix = this.viewMatrix, l_oFrustum = p_oCamera.frustrum, l_aVertexNormals = this.m_oGeometry.aVertexNormals, l_oVertexNormal, l_oVertex, l_oFace, l_nMinZ;
	l_oMatrix = this.viewMatrix;
	m11 = l_oMatrix.n11;
	m21 = l_oMatrix.n21;
	m31 = l_oMatrix.n31;
	m12 = l_oMatrix.n12;
	m22 = l_oMatrix.n22;
	m32 = l_oMatrix.n32;
	m13 = l_oMatrix.n13;
	m23 = l_oMatrix.n23;
	m33 = l_oMatrix.n33;
	m14 = l_oMatrix.n14;
	m24 = l_oMatrix.n24;
	m34 = l_oMatrix.n34;
	{
		var _g = 0;
		while(_g < l_aPoints.length) {
			var l_oVertex1 = l_aPoints[_g];
			++_g;
			l_oVertex1.wx = (x = l_oVertex1.x) * m11 + (y = l_oVertex1.y) * m12 + (z = l_oVertex1.z) * m13 + m14;
			l_oVertex1.wy = x * m21 + y * m22 + z * m23 + m24;
			l_oVertex1.wz = x * m31 + y * m32 + z * m33 + m34;
			l_oVertex1.projected = false;
		}
	}
	this.m_aVisiblePoly = [];
	this.m_nVisiblePoly = 0;
	this.m_nDepth = 0;
	{
		var _g = 0, _g1 = this.aPolygons;
		while(_g < _g1.length) {
			var l_oFace1 = _g1[_g];
			++_g;
			l_oFace1.isClipped = false;
			x = l_oFace1.normal.x;
			y = l_oFace1.normal.y;
			z = l_oFace1.normal.z;
			tx = x * m11 + y * m12 + z * m13;
			ty = x * m21 + y * m22 + z * m23;
			tz = x * m31 + y * m32 + z * m33;
			x = l_oFace1.a.wx * tx + l_oFace1.a.wy * ty + l_oFace1.a.wz * tz;
			l_oFace1.visible = x < 0;
			if(l_oFace1.visible || !this.m_bBackFaceCulling) {
				l_oFace1.precompute();
				l_nMinZ = l_oFace1.minZ;
				if(this.m_bClipped && this.enableClipping) {
					l_oFace1.clip(l_oFrustum);
					if(l_oFace1.cvertices.length > 2) {
						p_oCamera.projectArray(l_oFace1.cvertices);
						if(!this.enableForcedDepth) this.m_nDepth += l_oFace1.m_nDepth;
						else l_oFace1.__setDepth(this.forcedDepth);
						this.m_aVisiblePoly[(this.m_nVisiblePoly++)] = l_oFace1;
					}
				}
				else if(this.enableNearClipping && l_nMinZ < l_nZNear) {
					l_oFace1.clipFrontPlane(l_oFrustum);
					if(l_oFace1.cvertices.length > 2) {
						p_oCamera.projectArray(l_oFace1.cvertices);
						if(!this.enableForcedDepth) this.m_nDepth += l_oFace1.m_nDepth;
						else l_oFace1.__setDepth(this.forcedDepth);
						this.m_aVisiblePoly[(this.m_nVisiblePoly++)] = l_oFace1;
					}
				}
				else if(l_nMinZ >= l_nZNear) {
					p_oCamera.projectArray(l_oFace1.vertices);
					if(!this.enableForcedDepth) this.m_nDepth += l_oFace1.m_nDepth;
					else l_oFace1.__setDepth(this.forcedDepth);
					this.m_aVisiblePoly[(this.m_nVisiblePoly++)] = l_oFace1;
				}
				else continue;
				if(l_oFace1.hasAppearanceChanged) {
					if(p_oScene.materialManager.isRegistered(l_oFace1.__getAppearance().__getFrontMaterial()) == false) {
						p_oScene.materialManager.register(l_oFace1.__getAppearance().__getFrontMaterial());
					}
					if(l_oFace1.__getAppearance().__getFrontMaterial() != l_oFace1.__getAppearance().__getBackMaterial()) {
						if(p_oScene.materialManager.isRegistered(l_oFace1.__getAppearance().__getBackMaterial()) == false) {
							p_oScene.materialManager.register(l_oFace1.__getAppearance().__getBackMaterial());
						}
					}
					l_oFace1.hasAppearanceChanged = false;
				}
			}
		}
	}
	if(this.m_bUseSingleContainer) {
		if(this.enableForcedDepth) this.m_nDepth = this.forcedDepth;
		else this.m_nDepth /= this.m_aVisiblePoly.length;
		p_oCamera.addToDisplayList(this);
	}
	else {
		p_oCamera.addArrayToDisplayList((this.m_aVisiblePoly));
	}
	var l_nFlags = this.__getAppearance().__getFlags();
	if(l_nFlags == 0) return;
	var i;
	l_oMatrix = this.modelMatrix;
	m11 = l_oMatrix.n11;
	m21 = l_oMatrix.n21;
	m31 = l_oMatrix.n31;
	m12 = l_oMatrix.n12;
	m22 = l_oMatrix.n22;
	m32 = l_oMatrix.n32;
	m13 = l_oMatrix.n13;
	m23 = l_oMatrix.n23;
	m33 = l_oMatrix.n33;
	if((this.__getAppearance().__getFlags() & sandy.core.SandyFlags.POLYGON_NORMAL_WORLD) > 0) {
		{
			var _g = 0, _g1 = this.m_aVisiblePoly;
			while(_g < _g1.length) {
				var l_oPoly = _g1[_g];
				++_g;
				l_oVertex = l_oPoly.normal;
				l_oVertex.wx = (x = l_oVertex.x) * m11 + (y = l_oVertex.y) * m12 + (z = l_oVertex.z) * m13;
				l_oVertex.wy = x * m21 + y * m22 + z * m23;
				l_oVertex.wz = x * m31 + y * m32 + z * m33;
			}
		}
	}
	if((this.__getAppearance().__getFlags() & sandy.core.SandyFlags.VERTEX_NORMAL_WORLD) > 0) {
		i = this.m_oGeometry.aVertexNormals.length;
		while(--i > -1) {
			if(this.m_oGeometry.aVertex[(i)].projected) {
				l_oVertex = this.m_oGeometry.aVertexNormals[(i)];
				l_oVertex.wx = (x = l_oVertex.x) * m11 + (y = l_oVertex.y) * m12 + (z = l_oVertex.z) * m13;
				l_oVertex.wy = x * m21 + y * m22 + z * m23;
				l_oVertex.wz = x * m31 + y * m32 + z * m33;
			}
		}
	}
}
sandy.core.scenegraph.Shape3D.prototype.swapCulling = function() {
	{
		var _g = 0, _g1 = this.aPolygons;
		while(_g < _g1.length) {
			var v = _g1[_g];
			++_g;
			v.swapCulling();
		}
	}
	this.changed = true;
}
sandy.core.scenegraph.Shape3D.prototype.toString = function() {
	return "sandy.core.scenegraph.Shape3D" + " " + this.m_oGeometry.toString();
}
sandy.core.scenegraph.Shape3D.prototype.updateBoundingVolumes = function() {
	if(this.m_oGeometry != null) {
		this.boundingSphere = sandy.bounds.BSphere.create(this.m_oGeometry.aVertex);
		this.boundingBox = sandy.bounds.BBox.create(this.m_oGeometry.aVertex);
	}
}
sandy.core.scenegraph.Shape3D.prototype.useSingleContainer = null;
sandy.core.scenegraph.Shape3D.prototype.__class__ = sandy.core.scenegraph.Shape3D;
sandy.core.scenegraph.Shape3D.__interfaces__ = [sandy.core.scenegraph.IDisplayable];
canvas.geom.Point = function(inX,inY) { if( inX === $_ ) return; {
	this.x = (inX == null?0.0:inX);
	this.y = (inY == null?0.0:inY);
}}
canvas.geom.Point.__name__ = ["canvas","geom","Point"];
canvas.geom.Point.distance = function(pt1,pt2) {
	var dx = pt1.x - pt2.x;
	var dy = pt1.y - pt2.y;
	return Math.sqrt(dx * dy + dy * dy);
}
canvas.geom.Point.interpolate = function(pt1,pt2,f) {
	return new canvas.geom.Point(pt2.x + f * (pt1.x - pt2.x),pt2.y + f * (pt1.y - pt2.y));
}
canvas.geom.Point.polar = function(len,angle) {
	return new canvas.geom.Point(len * Math.cos(angle),len * Math.sin(angle));
}
canvas.geom.Point.prototype.add = function(v) {
	return new canvas.geom.Point(v.x + this.x,v.y + this.y);
}
canvas.geom.Point.prototype.clone = function() {
	return new canvas.geom.Point(this.x,this.y);
}
canvas.geom.Point.prototype.equals = function(toCompare) {
	return toCompare.x == this.x && toCompare.y == this.y;
}
canvas.geom.Point.prototype.get_length = function() {
	return Math.sqrt(this.x * this.x + this.y * this.y);
}
canvas.geom.Point.prototype.length = null;
canvas.geom.Point.prototype.normalize = function(thickness) {
	if(this.x == 0 && this.y == 0) this.x = thickness;
	else {
		var norm = thickness / Math.sqrt(this.x * this.x + this.y * this.y);
		this.x *= norm;
		this.y *= norm;
	}
}
canvas.geom.Point.prototype.offset = function(dx,dy) {
	this.x += dx;
	this.y += dy;
}
canvas.geom.Point.prototype.subtract = function(v) {
	return new canvas.geom.Point(this.x - v.x,this.y - v.y);
}
canvas.geom.Point.prototype.x = null;
canvas.geom.Point.prototype.y = null;
canvas.geom.Point.prototype.__class__ = canvas.geom.Point;
haxe.Timer = function(time_ms) { if( time_ms === $_ ) return; {
	this.id = haxe.Timer.arr.length;
	haxe.Timer.arr[this.id] = this;
	this.timerId = window.setInterval("haxe.Timer.arr[" + this.id + "].run();",time_ms);
}}
haxe.Timer.__name__ = ["haxe","Timer"];
haxe.Timer.delay = function(f,time_ms) {
	var t = new haxe.Timer(time_ms);
	t.run = function() {
		t.stop();
		f();
	}
}
haxe.Timer.stamp = function() {
	return Date.now().getTime() / 1000;
}
haxe.Timer.prototype.id = null;
haxe.Timer.prototype.run = function() {
	null;
}
haxe.Timer.prototype.stop = function() {
	if(this.id == null) return;
	window.clearInterval(this.timerId);
	haxe.Timer.arr[this.id] = null;
	if(this.id > 100 && this.id == haxe.Timer.arr.length - 1) {
		var p = this.id - 1;
		while(p >= 0 && haxe.Timer.arr[p] == null) p--;
		haxe.Timer.arr = haxe.Timer.arr.slice(0,p + 1);
	}
	this.id = null;
}
haxe.Timer.prototype.timerId = null;
haxe.Timer.prototype.__class__ = haxe.Timer;
neash.Lib = function(inName,inWidth,inHeight,inFullScreen,inResizable,cb) { if( inName === $_ ) return; {
	this.mKilled = false;
	this.mManager = new canvas.Manager(inWidth,inHeight,inName,cb);
	neash.Lib.mStage = new neash.display.Stage(inWidth,inHeight,this.mManager);
	neash.Lib.mStage.frameRate = 10;
	neash.Lib.mMainClassRoot = new neash.display.MovieClip();
	neash.Lib.mStage.addChild(neash.Lib.mMainClassRoot);
	neash.Lib.mCurrent = neash.Lib.mMainClassRoot;
	neash.Lib.mCurrent.name = "Root MovieClip";
}}
neash.Lib.__name__ = ["neash","Lib"];
neash.Lib.mMe = null;
neash.Lib.current = null;
neash.Lib.parameters = null;
neash.Lib.mStage = null;
neash.Lib.mMainClassRoot = null;
neash.Lib.mCurrent = null;
neash.Lib.mRolling = null;
neash.Lib.mDownObj = null;
neash.Lib.ShowCursor = function(inShow) {
	neash.Lib.mShowCursor = inShow;
	canvas.Manager.SetCursor((inShow?1:0));
}
neash.Lib.SetTextCursor = function(inText) {
	if(inText) canvas.Manager.SetCursor(2);
	else canvas.Manager.SetCursor((neash.Lib.mShowCursor?1:0));
}
neash.Lib.SetFrameRate = function(inRate) {
	neash.Lib.mStage.frameRate = inRate;
}
neash.Lib.GetParameters = function() {
	return null;
}
neash.Lib.GetCurrent = function() {
	return neash.Lib.mMainClassRoot;
}
neash.Lib.ShowFPS = function(inShow) {
	neash.Lib.mShowFPS = inShow == null || inShow;
}
neash.Lib.SetBackgroundColour = function(inColour) {
	neash.Lib.mStage.SetBackgroundColour(inColour);
}
neash.Lib.getTimer = function() {
	return (haxe.Timer.stamp() - neash.Lib.starttime) * 1000.0;
}
neash.Lib.GetStage = function() {
	return neash.Lib.mStage;
}
neash.Lib.FireEvents = function(inEvt,inList) {
	var l = inList.length;
	if(l == 0) return;
	inEvt.SetPhase(neash.events.EventPhase.CAPTURING_PHASE);
	{
		var _g1 = 0, _g = l - 1;
		while(_g1 < _g) {
			var i = _g1++;
			var obj = inList[i];
			inEvt.currentTarget = obj;
			obj.dispatchEvent(inEvt);
			if(inEvt.IsCancelled()) return;
		}
	}
	inEvt.SetPhase(neash.events.EventPhase.AT_TARGET);
	inEvt.currentTarget = inList[l - 1];
	inList[l - 1].dispatchEvent(inEvt);
	if(inEvt.IsCancelled()) return;
	if(inEvt.bubbles) {
		inEvt.SetPhase(neash.events.EventPhase.BUBBLING_PHASE);
		var i = l - 2;
		while(i >= 0) {
			var obj = inList[i];
			inEvt.currentTarget = obj;
			obj.dispatchEvent(inEvt);
			if(inEvt.IsCancelled()) return;
			--i;
		}
	}
}
neash.Lib.SendEventToObject = function(inEvent,inObj) {
	var objs = neash.Lib.GetAnscestors(inObj);
	objs.reverse();
	neash.Lib.FireEvents(inEvent,objs);
}
neash.Lib.GetAnscestors = function(inObj) {
	var result = [];
	while(inObj != null) {
		var interactive = inObj.AsInteractiveObject();
		if(interactive != null) result.push(interactive);
		inObj = inObj.GetParent();
	}
	result.reverse();
	return result;
}
neash.Lib.SetDragged = function(inObj,inCentre,inRect) {
	neash.Lib.mDragObject = inObj;
	neash.Lib.mDragRect = inRect;
	if(neash.Lib.mDragObject != null) {
		if(inCentre != null && inCentre) {
			neash.Lib.mDragOffsetX = -inObj.GetWidth() / 2;
			neash.Lib.mDragOffsetY = -inObj.GetHeight() / 2;
		}
		else {
			var mouse = canvas.Manager.GetMouse();
			var p = neash.Lib.mDragObject.GetParent();
			if(p != null) mouse = p.globalToLocal(mouse);
			neash.Lib.mDragOffsetX = inObj.GetX() - mouse.x;
			neash.Lib.mDragOffsetY = inObj.GetY() - mouse.y;
		}
	}
}
neash.Lib.Run = function() {
	neash.Lib.mMe.MyRun();
}
neash.Lib.Init = function(inName,inWidth,inHeight,inFullScreen,inResizable,cb) {
	neash.Lib.mMe = new neash.Lib(inName,inWidth,inHeight,inFullScreen,inResizable,cb);
}
neash.Lib.prototype.CreateMouseEvent = function(inObj,inRelatedObj,inMouse,inType) {
	var bubble = inType != neash.events.MouseEvent.ROLL_OUT && inType != neash.events.MouseEvent.ROLL_OVER;
	var pos = new canvas.geom.Point(inMouse.localX,inMouse.localY);
	if(inObj != null) pos = inObj.globalToLocal(pos);
	var result = new neash.events.MouseEvent(inType,bubble,false,inMouse.localX,inMouse.localY,inRelatedObj,inMouse.ctrlKey,inMouse.altKey,inMouse.shiftKey,inMouse.buttonDown,2);
	result.target = inObj;
	return result;
}
neash.Lib.prototype.DoMouse = function(inEvent) {
	var mouse = canvas.Manager.mouseEvent(canvas.MouseEventType.met_Move);
	neash.Lib.mLastMouse.x = mouse.x;
	neash.Lib.mLastMouse.y = mouse.y;
	if(neash.Lib.mDragObject != null) this.DragObject(mouse.x,mouse.y);
	var obj = this.GetInteractiveObjectAtPos(mouse.x,mouse.y);
	var type = ((inEvent == canvas.EventType.et_mousemove)?neash.events.MouseEvent.MOUSE_MOVE:((inEvent == canvas.EventType.et_mousebutton_up)?neash.events.MouseEvent.MOUSE_UP:((inEvent == canvas.EventType.et_mousebutton_down)?neash.events.MouseEvent.MOUSE_DOWN:"unknown")));
	var new_list = (obj != null?neash.Lib.GetAnscestors(obj):[]);
	var nl = new_list.length;
	if(obj != neash.Lib.mRolling) {
		if(neash.Lib.mRolling != null) neash.Lib.mRolling.DoMouseLeave();
		var old_list = neash.Lib.GetAnscestors(neash.Lib.mRolling);
		var ol = old_list.length;
		var common = 0;
		var stop = (ol < nl?ol:nl);
		while(common < stop && old_list[common] == new_list[common]) common++;
		if(ol > common) {
			var evt = this.CreateMouseEvent(neash.Lib.mRolling,obj,mouse,neash.events.MouseEvent.ROLL_OUT);
			{
				var _g = common;
				while(_g < ol) {
					var o = _g++;
					evt.target = old_list[o];
					old_list[o].dispatchEvent(evt);
				}
			}
		}
		if(nl > common) {
			var evt = this.CreateMouseEvent(obj,neash.Lib.mRolling,mouse,neash.events.MouseEvent.ROLL_OVER);
			{
				var _g = common;
				while(_g < nl) {
					var o = _g++;
					evt.target = new_list[o];
					new_list[o].dispatchEvent(evt);
				}
			}
		}
		neash.Lib.mRolling = obj;
		if(neash.Lib.mRolling != null) obj.DoMouseEnter();
	}
	if(inEvent == canvas.EventType.et_mousebutton_down) {
		neash.Lib.mDownObj = obj;
		if(obj != null) obj.OnMouseDown(mouse.x,mouse.y);
	}
	else if(inEvent == canvas.EventType.et_mousemove && neash.Lib.mDownObj != null) neash.Lib.mDownObj.OnMouseDrag(mouse.x,mouse.y);
	else if(inEvent == canvas.EventType.et_mousebutton_up) {
		if(neash.Lib.mDownObj != null) {
			neash.Lib.mDownObj.OnMouseUp(mouse.x,mouse.y);
			if(obj == neash.Lib.mDownObj) {
				var evt = this.CreateMouseEvent(obj,null,mouse,neash.events.MouseEvent.CLICK);
				neash.Lib.FireEvents(evt,new_list);
			}
			else {
				obj = neash.Lib.mDownObj;
				new_list = neash.Lib.GetAnscestors(obj);
			}
		}
		neash.Lib.mDownObj = null;
	}
	if(nl > 0 && (inEvent == canvas.EventType.et_mousebutton_down || inEvent == canvas.EventType.et_mousebutton_up) || inEvent == canvas.EventType.et_mousemove) {
		var evt = this.CreateMouseEvent(obj,null,mouse,type);
		neash.Lib.FireEvents(evt,new_list);
	}
}
neash.Lib.prototype.DragObject = function(inX,inY) {
	var pos = new canvas.geom.Point(inX,inY);
	var p = neash.Lib.mDragObject.GetParent();
	if(p != null) pos = p.globalToLocal(pos);
	if(neash.Lib.mDragRect != null) {
		if(pos.x < neash.Lib.mDragRect.x) pos.x = neash.Lib.mDragRect.x;
		else if(pos.x > neash.Lib.mDragRect.get_right()) pos.x = neash.Lib.mDragRect.get_right();
		if(pos.y < neash.Lib.mDragRect.y) pos.y = neash.Lib.mDragRect.y;
		else if(pos.y > neash.Lib.mDragRect.get_bottom()) pos.y = neash.Lib.mDragRect.get_bottom();
	}
	neash.Lib.mDragObject.SetX(pos.x + neash.Lib.mDragOffsetX);
	neash.Lib.mDragObject.SetY(pos.y + neash.Lib.mDragOffsetY);
}
neash.Lib.prototype.GetInteractiveObjectAtPos = function(inX,inY) {
	return neash.Lib.mStage.GetInteractiveObjectAtPos(inX,inY);
}
neash.Lib.prototype.MyRun = function() {
	this.frame = 0;
	this.setTimer();
}
neash.Lib.prototype.OnResize = function(inW,inH) {
	this.mManager.OnResize(inW,inH);
	neash.Lib.mStage.OnResize(inW,inH);
}
neash.Lib.prototype.ProcessKeys = function(code,pressed,inChar,ctrl,alt,shift) {
	switch(code) {
	case neash.text.KeyCode.ESCAPE:{
		this.mKilled = true;
	}break;
	case neash.text.KeyCode.TAB:{
		neash.Lib.mStage.TabChange((shift?-1:1),code);
	}break;
	default:{
		var event = new neash.events.KeyboardEvent((pressed?neash.events.KeyboardEvent.KEY_DOWN:neash.events.KeyboardEvent.KEY_UP),true,false,inChar,neash.text.KeyCode.ConvertCode(code),neash.text.KeyCode.ConvertLocation(code),ctrl,alt,shift);
		neash.Lib.mStage.HandleKey(event);
	}break;
	}
}
neash.Lib.prototype.frame = null;
neash.Lib.prototype.mArgs = null;
neash.Lib.prototype.mKilled = null;
neash.Lib.prototype.mManager = null;
neash.Lib.prototype.setTimer = function(time) {
	if(time == null) time = 1;
	if(this.timer != null) this.timer.stop();
	this.timer = new haxe.Timer(time);
	this.timer.run = $closure(this,"step");
}
neash.Lib.prototype.step = function() {
	this.frame++;
	if(this.frame % 2 == 0) {
		var e = new neash.events.Event(neash.events.Event.ENTER_FRAME);
		neash.Lib.mStage.dispatchEvent(e);
	}
	else {
		if(neash.Lib.mStage.mChanged) this.mManager.clear(neash.Lib.mStage.backgroundColor);
		neash.Lib.mStage.RenderAll();
	}
	this.setTimer();
}
neash.Lib.prototype.timer = null;
neash.Lib.prototype.__class__ = neash.Lib;
canvas.display = {}
canvas.display.BitmapData = function(inWidth,inHeight,inTransparent,inFillColour) { if( inWidth === $_ ) return; {
	var el = js.Lib.document.getElementById(Type.getClassName(Type.getClass(this)));
	if(el != null) {
		this.mTextureBuffer = el;
	}
	else if(inWidth < 1 || inHeight < 1) {
		this.mTextureBuffer = null;
	}
	else {
		this.mTextureBuffer = new Image();
		this.mTextureBuffer.setAttribute("width",inWidth);
		this.mTextureBuffer.setAttribute("height",inHeight);
	}
}}
canvas.display.BitmapData.__name__ = ["canvas","display","BitmapData"];
canvas.display.BitmapData.CreateFromHandle = function(inHandle) {
	var result = new canvas.display.BitmapData(0,0);
	result.mTextureBuffer = inHandle;
	return result;
}
canvas.display.BitmapData.prototype.LoadFromFile = function(inFilename,inLoader) {
	this.mTextureBuffer = new Image();
	if(inLoader != null) {
		this.mTextureBuffer.onload = function() {
			var e = new neash.events.Event(neash.events.Event.COMPLETE);
			e.target = inLoader;
			inLoader.dispatchEvent(e);
		}
	}
	this.mTextureBuffer.src = inFilename;
}
canvas.display.BitmapData.prototype.clone = function() {
	return this;
}
canvas.display.BitmapData.prototype.compare = function(inBitmapTexture) {
	if(this.mTextureBuffer == inBitmapTexture.handle()) {
		return 0;
	}
	else {
		return -1;
	}
}
canvas.display.BitmapData.prototype.destroy = function() {
	this.mTextureBuffer = null;
}
canvas.display.BitmapData.prototype.dispose = function() {
	null;
}
canvas.display.BitmapData.prototype.draw = function(source,b,c,d,e,f) {
	if(Std["is"](source,canvas.display.BitmapData)) {
		this.mTextureBuffer = source.handle();
	}
}
canvas.display.BitmapData.prototype.fillRect = function(Rectangle,Int) {
	null;
}
canvas.display.BitmapData.prototype.flushGraphics = function() {
	if(this.getGraphics() != null) this.getGraphics().flush();
}
canvas.display.BitmapData.prototype.getColorBoundsRect = function(a,b,c) {
	return new canvas.geom.Rectangle();
}
canvas.display.BitmapData.prototype.getGraphics = function() {
	if(this.graphics == null) this.graphics = new canvas.display.Graphics(this.mTextureBuffer);
	return this.graphics;
}
canvas.display.BitmapData.prototype.getHeight = function() {
	if(this.mTextureBuffer != null) {
		return this.mTextureBuffer.height;
	}
	else {
		return 0;
	}
}
canvas.display.BitmapData.prototype.getWidth = function() {
	if(this.mTextureBuffer != null) {
		return this.mTextureBuffer.width;
	}
	else {
		return 0;
	}
}
canvas.display.BitmapData.prototype.graphics = null;
canvas.display.BitmapData.prototype.handle = function() {
	return this.mTextureBuffer;
}
canvas.display.BitmapData.prototype.height = null;
canvas.display.BitmapData.prototype.mTextureBuffer = null;
canvas.display.BitmapData.prototype.rect = null;
canvas.display.BitmapData.prototype.width = null;
canvas.display.BitmapData.prototype.__class__ = canvas.display.BitmapData;
canvas.display.BitmapData.__interfaces__ = [neash.display.IBitmapDrawable];
Reflect = function() { }
Reflect.__name__ = ["Reflect"];
Reflect.hasField = function(o,field) {
	if(o.hasOwnProperty != null) return o.hasOwnProperty(field);
	var arr = Reflect.fields(o);
	{ var $it10 = arr.iterator();
	while( $it10.hasNext() ) { var t = $it10.next();
	if(t == field) return true;
	}}
	return false;
}
Reflect.field = function(o,field) {
	var v = null;
	try {
		v = o[field];
	}
	catch( $e11 ) {
		{
			var e = $e11;
			null;
		}
	}
	return v;
}
Reflect.setField = function(o,field,value) {
	o[field] = value;
}
Reflect.callMethod = function(o,func,args) {
	return func.apply(o,args);
}
Reflect.fields = function(o) {
	if(o == null) return new Array();
	var a = new Array();
	if(o.hasOwnProperty) {
		
					for(var i in o)
						if( o.hasOwnProperty(i) )
							a.push(i);
				;
	}
	else {
		var t;
		try {
			t = o.__proto__;
		}
		catch( $e12 ) {
			{
				var e = $e12;
				{
					t = null;
				}
			}
		}
		if(t != null) o.__proto__ = null;
		
					for(var i in o)
						if( i != "__proto__" )
							a.push(i);
				;
		if(t != null) o.__proto__ = t;
	}
	return a;
}
Reflect.isFunction = function(f) {
	return typeof(f) == "function" && f.__name__ == null;
}
Reflect.compare = function(a,b) {
	return ((a == b)?0:((((a) > (b))?1:-1)));
}
Reflect.compareMethods = function(f1,f2) {
	if(f1 == f2) return true;
	if(!Reflect.isFunction(f1) || !Reflect.isFunction(f2)) return false;
	return f1.scope == f2.scope && f1.method == f2.method && f1.method != null;
}
Reflect.isObject = function(v) {
	if(v == null) return false;
	var t = typeof(v);
	return (t == "string" || (t == "object" && !v.__enum__) || (t == "function" && v.__name__ != null));
}
Reflect.deleteField = function(o,f) {
	if(!Reflect.hasField(o,f)) return false;
	delete(o[f]);
	return true;
}
Reflect.copy = function(o) {
	var o2 = { }
	{
		var _g = 0, _g1 = Reflect.fields(o);
		while(_g < _g1.length) {
			var f = _g1[_g];
			++_g;
			o2[f] = Reflect.field(o,f);
		}
	}
	return o2;
}
Reflect.makeVarArgs = function(f) {
	return function() {
		var a = new Array();
		{
			var _g1 = 0, _g = arguments.length;
			while(_g1 < _g) {
				var i = _g1++;
				a.push(arguments[i]);
			}
		}
		return f(a);
	}
}
Reflect.prototype.__class__ = Reflect;
sandy.core.data.Plane = function(p_nA,p_nB,p_nC,p_nd) { if( p_nA === $_ ) return; {
	p_nA = ((p_nA != null)?p_nA:0);
	p_nB = ((p_nB != null)?p_nB:0);
	p_nC = ((p_nC != null)?p_nC:0);
	p_nd = ((p_nd != null)?p_nd:0);
	this.a = p_nA;
	this.b = p_nB;
	this.c = p_nC;
	this.d = p_nd;
}}
sandy.core.data.Plane.__name__ = ["sandy","core","data","Plane"];
sandy.core.data.Plane.prototype.a = null;
sandy.core.data.Plane.prototype.b = null;
sandy.core.data.Plane.prototype.c = null;
sandy.core.data.Plane.prototype.d = null;
sandy.core.data.Plane.prototype.toString = function() {
	return "sandy.core.data.Plane" + "(a:" + this.a + ", b:" + this.b + ", c:" + this.c + ", d:" + this.d + ")";
}
sandy.core.data.Plane.prototype.__class__ = sandy.core.data.Plane;
sandy.errors = {}
sandy.errors.SingletonError = function(p) { if( p === $_ ) return; {
	throw ("Class cannot be instantiated");
}}
sandy.errors.SingletonError.__name__ = ["sandy","errors","SingletonError"];
sandy.errors.SingletonError.prototype.__class__ = sandy.errors.SingletonError;
sandy.view = {}
sandy.view.CullingState = { __ename__ : ["sandy","view","CullingState"], __constructs__ : ["INTERSECT","INSIDE","OUTSIDE"] }
sandy.view.CullingState.INSIDE = ["INSIDE",1];
sandy.view.CullingState.INSIDE.toString = $estr;
sandy.view.CullingState.INSIDE.__enum__ = sandy.view.CullingState;
sandy.view.CullingState.INTERSECT = ["INTERSECT",0];
sandy.view.CullingState.INTERSECT.toString = $estr;
sandy.view.CullingState.INTERSECT.__enum__ = sandy.view.CullingState;
sandy.view.CullingState.OUTSIDE = ["OUTSIDE",2];
sandy.view.CullingState.OUTSIDE.toString = $estr;
sandy.view.CullingState.OUTSIDE.__enum__ = sandy.view.CullingState;
sandy.events.BubbleEvent = function(e,oT) { if( e === $_ ) return; {
	neash.events.Event.apply(this,[e,true,true]);
	this.m_oTarget = oT;
}}
sandy.events.BubbleEvent.__name__ = ["sandy","events","BubbleEvent"];
sandy.events.BubbleEvent.__super__ = neash.events.Event;
for(var k in neash.events.Event.prototype ) sandy.events.BubbleEvent.prototype[k] = neash.events.Event.prototype[k];
sandy.events.BubbleEvent.prototype.__getTarget = function() {
	return this.m_oTarget;
}
sandy.events.BubbleEvent.prototype.m_oTarget = null;
sandy.events.BubbleEvent.prototype.tgt = null;
sandy.events.BubbleEvent.prototype.toString = function() {
	return "BubbleEvent";
}
sandy.events.BubbleEvent.prototype.__class__ = sandy.events.BubbleEvent;
sandy.core.interaction.TextLink = function(p) { if( p === $_ ) return; {
	this.x = 0;
	this.y = 0;
	this.height = 0;
	this.width = 0;
}}
sandy.core.interaction.TextLink.__name__ = ["sandy","core","interaction","TextLink"];
sandy.core.interaction.TextLink.getTextLinks = function(t,force) {
	return [];
}
sandy.core.interaction.TextLink.prototype.__getCloseIndex = function() {
	return this.__iCloseIndex;
}
sandy.core.interaction.TextLink.prototype.__getHref = function() {
	return this.__sHRef;
}
sandy.core.interaction.TextLink.prototype.__getOpenIndex = function() {
	return this.__iOpenIndex;
}
sandy.core.interaction.TextLink.prototype.__getOwner = function() {
	return this.__tfOwner;
}
sandy.core.interaction.TextLink.prototype.__getTarget = function() {
	return this.__sTarget;
}
sandy.core.interaction.TextLink.prototype.__iCloseIndex = null;
sandy.core.interaction.TextLink.prototype.__iOpenIndex = null;
sandy.core.interaction.TextLink.prototype.__rBounds = null;
sandy.core.interaction.TextLink.prototype.__sHRef = null;
sandy.core.interaction.TextLink.prototype.__sTarget = null;
sandy.core.interaction.TextLink.prototype.__setCloseIndex = function(i) {
	this.__iCloseIndex = i;
	return i;
}
sandy.core.interaction.TextLink.prototype.__setHref = function(s) {
	this.__sHRef = s;
	return s;
}
sandy.core.interaction.TextLink.prototype.__setOpenIndex = function(i) {
	this.__iOpenIndex = i;
	return i;
}
sandy.core.interaction.TextLink.prototype.__setOwner = function(tf) {
	this.__tfOwner = tf;
	return tf;
}
sandy.core.interaction.TextLink.prototype.__setTarget = function(s) {
	this.__sTarget = s;
	return s;
}
sandy.core.interaction.TextLink.prototype.__tfOwner = null;
sandy.core.interaction.TextLink.prototype._init = function() {
	{
		var _g1 = 0, _g = (this.__iCloseIndex - this.__iOpenIndex);
		while(_g1 < _g) {
			var j = _g1++;
			var rectB = null;
			if(j == 0) {
				this.x = rectB.x;
				this.y = rectB.y;
			}
			this.width += rectB.width;
			this.height = (this.height < rectB.height?rectB.height:this.height);
		}
	}
	this.__rBounds = new canvas.geom.Rectangle();
	this.__rBounds.x = this.x;
	this.__rBounds.y = this.y;
	this.__rBounds.height = this.height;
	this.__rBounds.width = this.width;
}
sandy.core.interaction.TextLink.prototype.closeIndex = null;
sandy.core.interaction.TextLink.prototype.getBounds = function() {
	return this.__rBounds;
}
sandy.core.interaction.TextLink.prototype.height = null;
sandy.core.interaction.TextLink.prototype.href = null;
sandy.core.interaction.TextLink.prototype.openIndex = null;
sandy.core.interaction.TextLink.prototype.owner = null;
sandy.core.interaction.TextLink.prototype.target = null;
sandy.core.interaction.TextLink.prototype.width = null;
sandy.core.interaction.TextLink.prototype.x = null;
sandy.core.interaction.TextLink.prototype.y = null;
sandy.core.interaction.TextLink.prototype.__class__ = sandy.core.interaction.TextLink;
neash.display.PixelSnapping = { __ename__ : ["neash","display","PixelSnapping"], __constructs__ : ["NEVER","AUTO","ALWAYS"] }
neash.display.PixelSnapping.ALWAYS = ["ALWAYS",2];
neash.display.PixelSnapping.ALWAYS.toString = $estr;
neash.display.PixelSnapping.ALWAYS.__enum__ = neash.display.PixelSnapping;
neash.display.PixelSnapping.AUTO = ["AUTO",1];
neash.display.PixelSnapping.AUTO.toString = $estr;
neash.display.PixelSnapping.AUTO.__enum__ = neash.display.PixelSnapping;
neash.display.PixelSnapping.NEVER = ["NEVER",0];
neash.display.PixelSnapping.NEVER.toString = $estr;
neash.display.PixelSnapping.NEVER.__enum__ = neash.display.PixelSnapping;
sandy.core.scenegraph.Geometry3D = function(p_points) { if( p_points === $_ ) return; {
	this.EDGES_DICO = new Hash();
	this.aVertex = new Array();
	this.aFacesVertexID = new Array();
	this.aFacesUVCoordsID = new Array();
	this.aFacesNormals = new Array();
	this.aVertexNormals = new Array();
	this.aEdges = new Array();
	this.aFaceEdges = new Array();
	this.aUVCoords = new Array();
	this.m_nLastVertexId = 0;
	this.m_nLastNormalId = 0;
	this.m_nLastFaceId = 0;
	this.m_nLastFaceUVId = 0;
	this.m_nLastUVId = 0;
	this.m_nLastVertexNormalId = 0;
	this.m_aVertexFaces = new Array();
	this.init();
}}
sandy.core.scenegraph.Geometry3D.__name__ = ["sandy","core","scenegraph","Geometry3D"];
sandy.core.scenegraph.Geometry3D.prototype.EDGES_DICO = null;
sandy.core.scenegraph.Geometry3D.prototype.aEdges = null;
sandy.core.scenegraph.Geometry3D.prototype.aFaceEdges = null;
sandy.core.scenegraph.Geometry3D.prototype.aFacesNormals = null;
sandy.core.scenegraph.Geometry3D.prototype.aFacesUVCoordsID = null;
sandy.core.scenegraph.Geometry3D.prototype.aFacesVertexID = null;
sandy.core.scenegraph.Geometry3D.prototype.aUVCoords = null;
sandy.core.scenegraph.Geometry3D.prototype.aVertex = null;
sandy.core.scenegraph.Geometry3D.prototype.aVertexNormals = null;
sandy.core.scenegraph.Geometry3D.prototype.clone = function() {
	var l_result = new sandy.core.scenegraph.Geometry3D();
	var i = 0, l_oVertex;
	{
		var _g = 0, _g1 = this.aVertex;
		while(_g < _g1.length) {
			var l_oVertex1 = _g1[_g];
			++_g;
			l_result.aVertex[i] = l_oVertex1.clone();
			i++;
		}
	}
	i = 0;
	{
		var _g = 0, _g1 = this.aFacesVertexID;
		while(_g < _g1.length) {
			var a = _g1[_g];
			++_g;
			l_result.aFacesVertexID[i] = a.concat([]);
			i++;
		}
	}
	i = 0;
	{
		var _g = 0, _g1 = this.aFacesNormals;
		while(_g < _g1.length) {
			var l_oVertex1 = _g1[_g];
			++_g;
			l_result.aFacesNormals[i] = l_oVertex1.clone();
			i++;
		}
	}
	i = 0;
	{
		var _g = 0, _g1 = this.aVertexNormals;
		while(_g < _g1.length) {
			var l_oVertex1 = _g1[_g];
			++_g;
			if(l_oVertex1 != null) {
				l_result.aVertexNormals[i] = l_oVertex1.clone();
			}
			else {
				l_result.aVertexNormals[i] = null;
			}
			i++;
		}
	}
	i = 0;
	{
		var _g = 0, _g1 = this.aFacesUVCoordsID;
		while(_g < _g1.length) {
			var b = _g1[_g];
			++_g;
			l_result.aFacesUVCoordsID[i] = b.concat([]);
			i++;
		}
	}
	i = 0;
	{
		var _g = 0, _g1 = this.aUVCoords;
		while(_g < _g1.length) {
			var u = _g1[_g];
			++_g;
			l_result.aUVCoords[i] = u.clone();
			i++;
		}
	}
	i = 0;
	{
		var _g = 0, _g1 = this.aEdges;
		while(_g < _g1.length) {
			var l_oEdge = _g1[_g];
			++_g;
			l_result.aEdges[i] = l_oEdge.clone();
			i++;
		}
	}
	i = 0;
	{
		var _g = 0, _g1 = this.aFaceEdges;
		while(_g < _g1.length) {
			var l_oEdges = _g1[_g];
			++_g;
			l_result.aFaceEdges[i] = l_oEdges;
			i++;
		}
	}
	return l_result;
}
sandy.core.scenegraph.Geometry3D.prototype.dispose = function() {
	var a, l_oVertex;
	{
		var _g = 0, _g1 = this.aVertex;
		while(_g < _g1.length) {
			var l_oVertex1 = _g1[_g];
			++_g;
			l_oVertex1 = null;
		}
	}
	this.aVertex = null;
	{
		var _g = 0, _g1 = this.aFacesVertexID;
		while(_g < _g1.length) {
			var a1 = _g1[_g];
			++_g;
			a1 = null;
		}
	}
	this.aFacesVertexID = null;
	{
		var _g = 0, _g1 = this.aFacesNormals;
		while(_g < _g1.length) {
			var l_oVertex1 = _g1[_g];
			++_g;
			l_oVertex1 = null;
		}
	}
	this.aFacesNormals = null;
	{
		var _g = 0, _g1 = this.aVertexNormals;
		while(_g < _g1.length) {
			var l_oVertex1 = _g1[_g];
			++_g;
			l_oVertex1 = null;
		}
	}
	this.aVertexNormals = null;
	{
		var _g = 0, _g1 = this.aFacesUVCoordsID;
		while(_g < _g1.length) {
			var b = _g1[_g];
			++_g;
			b = null;
		}
	}
	this.aFacesUVCoordsID = null;
	{
		var _g = 0, _g1 = this.aUVCoords;
		while(_g < _g1.length) {
			var u = _g1[_g];
			++_g;
			u = null;
		}
	}
	this.aUVCoords = null;
}
sandy.core.scenegraph.Geometry3D.prototype.generateFaceNormals = function() {
	if(this.aFacesNormals.length > 0) return;
	else {
		{
			var _g = 0, _g1 = this.aFacesVertexID;
			while(_g < _g1.length) {
				var a = _g1[_g];
				++_g;
				if(a.length < 3) continue;
				var lA, lB, lC;
				lA = this.aVertex[a[0]];
				lB = this.aVertex[a[1]];
				lC = this.aVertex[a[2]];
				var lV = new sandy.core.data.Vector(lB.wx - lA.wx,lB.wy - lA.wy,lB.wz - lA.wz);
				var lW = new sandy.core.data.Vector(lB.wx - lC.wx,lB.wy - lC.wy,lB.wz - lC.wz);
				var lNormal = lV.cross(lW);
				lNormal.normalize();
				this.setFaceNormal(this.getNextFaceNormalID(),lNormal.x,lNormal.y,lNormal.z);
			}
		}
	}
}
sandy.core.scenegraph.Geometry3D.prototype.generateVertexNormals = function() {
	if(this.aVertexNormals.length > 0) return;
	else {
		var lId = 0;
		{
			var _g1 = 0, _g = this.aFacesVertexID.length;
			while(_g1 < _g) {
				var lId1 = _g1++;
				var l_aList = this.aFacesVertexID[lId1];
				var l_oNormal = this.aFacesNormals[lId1];
				if(l_oNormal == null) continue;
				if(null == this.aVertexNormals[l_aList[0]]) {
					this.m_nLastVertexNormalId++;
					this.aVertexNormals[l_aList[0]] = new sandy.core.data.Vertex();
				}
				this.aVertexNormals[l_aList[0]].add(l_oNormal);
				if(null == this.aVertexNormals[l_aList[1]]) {
					this.m_nLastVertexNormalId++;
					this.aVertexNormals[l_aList[1]] = new sandy.core.data.Vertex();
				}
				this.aVertexNormals[l_aList[1]].add(l_oNormal);
				if(null == this.aVertexNormals[l_aList[2]]) {
					this.m_nLastVertexNormalId++;
					this.aVertexNormals[l_aList[2]] = new sandy.core.data.Vertex();
				}
				this.aVertexNormals[l_aList[2]].add(l_oNormal);
				if((this.aVertex[l_aList[0]].aFaces.indexOf(lId1)) == 0) this.aVertex[l_aList[0]].aFaces.push(lId1);
				if((this.aVertex[l_aList[1]].aFaces.indexOf(lId1)) == 0) this.aVertex[l_aList[1]].aFaces.push(lId1);
				if((this.aVertex[l_aList[2]].aFaces.indexOf(lId1)) == 0) this.aVertex[l_aList[2]].aFaces.push(lId1);
				this.aVertex[l_aList[0]].nbFaces++;
				this.aVertex[l_aList[1]].nbFaces++;
				this.aVertex[l_aList[2]].nbFaces++;
			}
		}
		{
			var _g1 = 0, _g = this.aVertexNormals.length;
			while(_g1 < _g) {
				var lId1 = _g1++;
				var l_oVertex = this.aVertex[lId1];
				if(l_oVertex.nbFaces == 0) continue;
				if(l_oVertex.nbFaces > 0) this.aVertexNormals[lId1].scale(1 / l_oVertex.nbFaces);
			}
		}
	}
}
sandy.core.scenegraph.Geometry3D.prototype.getNextFaceID = function() {
	return this.m_nLastFaceId;
}
sandy.core.scenegraph.Geometry3D.prototype.getNextFaceNormalID = function() {
	return this.m_nLastNormalId;
}
sandy.core.scenegraph.Geometry3D.prototype.getNextFaceUVCoordID = function() {
	return this.m_nLastFaceUVId;
}
sandy.core.scenegraph.Geometry3D.prototype.getNextUVCoordID = function() {
	return this.m_nLastUVId;
}
sandy.core.scenegraph.Geometry3D.prototype.getNextVertexID = function() {
	return this.m_nLastVertexId;
}
sandy.core.scenegraph.Geometry3D.prototype.getNextVertexNormalID = function() {
	return this.m_nLastVertexNormalId;
}
sandy.core.scenegraph.Geometry3D.prototype.getVertexId = function(p_point) {
	var j = 0;
	{
		var _g1 = 0, _g = this.aVertex.length;
		while(_g1 < _g) {
			var j1 = _g1++;
			if(!(this.aVertex[j1] == p_point)) break;
		}
	}
	return (j == this.aVertex.length?-1:j);
}
sandy.core.scenegraph.Geometry3D.prototype.init = function() {
	null;
}
sandy.core.scenegraph.Geometry3D.prototype.isEdgeExist = function(p_nVertexId1,p_nVertexId2) {
	var lString;
	if(p_nVertexId1 < p_nVertexId2) lString = p_nVertexId1 + "_" + p_nVertexId2;
	else lString = p_nVertexId2 + "_" + p_nVertexId1;
	if(this.EDGES_DICO.get(lString) == null) return false;
	else return true;
}
sandy.core.scenegraph.Geometry3D.prototype.m_aVertexFaces = null;
sandy.core.scenegraph.Geometry3D.prototype.m_nLastFaceId = null;
sandy.core.scenegraph.Geometry3D.prototype.m_nLastFaceUVId = null;
sandy.core.scenegraph.Geometry3D.prototype.m_nLastNormalId = null;
sandy.core.scenegraph.Geometry3D.prototype.m_nLastUVId = null;
sandy.core.scenegraph.Geometry3D.prototype.m_nLastVertexId = null;
sandy.core.scenegraph.Geometry3D.prototype.m_nLastVertexNormalId = null;
sandy.core.scenegraph.Geometry3D.prototype.setFaceNormal = function(p_nNormalID,p_nX,p_nY,p_nZ) {
	if(this.aFacesNormals[p_nNormalID] != null) return -1;
	else {
		this.aFacesNormals[p_nNormalID] = new sandy.core.data.Vertex(p_nX,p_nY,p_nZ);
		return ++this.m_nLastNormalId - 1;
	}
}
sandy.core.scenegraph.Geometry3D.prototype.setFaceUVCoordsIds = function(p_nFaceID,arguments) {
	if(arguments == null) arguments = [];
	if(this.aFacesUVCoordsID[p_nFaceID] != null) {
		return -1;
	}
	else {
		var rest = (Std["is"](arguments[0],Array)?arguments[0]:arguments.splice(0,arguments.length));
		this.aFacesUVCoordsID[p_nFaceID] = rest;
		return ++this.m_nLastFaceUVId - 1;
	}
}
sandy.core.scenegraph.Geometry3D.prototype.setFaceVertexIds = function(p_nFaceID,arguments) {
	if(arguments == null) arguments = [];
	if(this.aFacesVertexID[p_nFaceID] != null) {
		return -1;
	}
	else {
		var rest = (Std["is"](arguments[0],Array)?arguments[0]:arguments.splice(0,arguments.length));
		this.aFacesVertexID[p_nFaceID] = rest;
		{
			var _g1 = 0, _g = rest.length;
			while(_g1 < _g) {
				var lId = _g1++;
				var lId1 = rest[lId];
				var lId2 = rest[(lId + 1) % rest.length];
				var lEdgeID;
				var lString;
				if(this.isEdgeExist(lId1,lId2) == false) {
					lEdgeID = this.aEdges.push(new sandy.core.data.Edge3D(lId1,lId2)) - 1;
					if(lId1 < lId2) lString = lId1 + "_" + lId2;
					else lString = lId2 + "_" + lId1;
					this.EDGES_DICO.set(lString,lEdgeID);
				}
				else {
					if(lId1 < lId2) lString = lId1 + "_" + lId2;
					else lString = lId2 + "_" + lId1;
					lEdgeID = this.EDGES_DICO.get(lString);
				}
				if(null == this.aFaceEdges[p_nFaceID]) this.aFaceEdges[p_nFaceID] = new Array();
				this.aFaceEdges[p_nFaceID].push(lEdgeID);
			}
		}
		return ++this.m_nLastFaceId - 1;
	}
}
sandy.core.scenegraph.Geometry3D.prototype.setUVCoords = function(p_nID,p_UValue,p_nVValue) {
	if(this.aUVCoords[p_nID] != null) {
		return -1;
	}
	else {
		this.aUVCoords[p_nID] = new sandy.core.data.UVCoord(p_UValue,p_nVValue);
		return ++this.m_nLastUVId - 1;
	}
}
sandy.core.scenegraph.Geometry3D.prototype.setVertex = function(p_nVertexID,p_nX,p_nY,p_nZ) {
	if(this.aVertex[p_nVertexID] != null) return -1;
	else {
		this.aVertex[p_nVertexID] = new sandy.core.data.Vertex(p_nX,p_nY,p_nZ);
		return ++this.m_nLastVertexId - 1;
	}
}
sandy.core.scenegraph.Geometry3D.prototype.setVertexNormal = function(p_nNormalID,p_nX,p_nY,p_nZ) {
	if(this.aVertexNormals[p_nNormalID] != null) return -1;
	else {
		this.aVertexNormals[p_nNormalID] = new sandy.core.data.Vertex(p_nX,p_nY,p_nZ);
		return ++this.m_nLastVertexNormalId - 1;
	}
}
sandy.core.scenegraph.Geometry3D.prototype.toString = function() {
	return "[Geometry: " + this.aFacesVertexID.length + " faces, " + this.aVertex.length + " points, " + this.aFacesNormals.length + " normals, " + this.aUVCoords.length + " uv coords]";
}
sandy.core.scenegraph.Geometry3D.prototype.__class__ = sandy.core.scenegraph.Geometry3D;
sandy.core.data.Vector = function(p_nX,p_nY,p_nZ) { if( p_nX === $_ ) return; {
	if(p_nX == null) p_nX = 0;
	if(p_nY == null) p_nY = 0;
	if(p_nZ == null) p_nZ = 0;
	this.x = p_nX;
	this.y = p_nY;
	this.z = p_nZ;
}}
sandy.core.data.Vector.__name__ = ["sandy","core","data","Vector"];
sandy.core.data.Vector.prototype.add = function(v) {
	this.x += v.x;
	this.y += v.y;
	this.z += v.z;
}
sandy.core.data.Vector.prototype.clone = function() {
	var l_oV = new sandy.core.data.Vector(this.x,this.y,this.z);
	return l_oV;
}
sandy.core.data.Vector.prototype.copy = function(p_oVector) {
	this.x = p_oVector.x;
	this.y = p_oVector.y;
	this.z = p_oVector.z;
}
sandy.core.data.Vector.prototype.cross = function(v) {
	return new sandy.core.data.Vector((this.y * v.z) - (this.z * v.y),(this.z * v.x) - (this.x * v.z),(this.x * v.y) - (this.y * v.x));
}
sandy.core.data.Vector.prototype.crossWith = function(v) {
	var cx = (this.y * v.z) - (this.z * v.y);
	var cy = (this.z * v.x) - (this.x * v.z);
	var cz = (this.x * v.y) - (this.y * v.x);
	this.x = cx;
	this.y = cy;
	this.z = cz;
}
sandy.core.data.Vector.prototype.deserialize = function(convertFrom) {
	var tmp = convertFrom.split(",");
	if(tmp.length != 3) {
		haxe.Log.trace("Unexpected length of string to deserialize into a vector " + convertFrom,{ fileName : "Vector.hx", lineNumber : 370, className : "sandy.core.data.Vector", methodName : "deserialize"});
	}
	this.x = Std.parseFloat(tmp[0]);
	this.y = Std.parseFloat(tmp[1]);
	this.z = Std.parseFloat(tmp[2]);
}
sandy.core.data.Vector.prototype.dot = function(w) {
	return (this.x * w.x + this.y * w.y + this.z * w.z);
}
sandy.core.data.Vector.prototype.equals = function(p_vector) {
	return (p_vector.x == this.x && p_vector.y == this.y && p_vector.z == this.z);
}
sandy.core.data.Vector.prototype.getAngle = function(w) {
	var n1 = this.getNorm();
	var n2 = w.getNorm();
	var denom = n1 * n2;
	if(denom == 0) {
		return 0;
	}
	else {
		var ncos = this.dot(w) / (denom);
		var sin2 = 1 - (ncos * ncos);
		if(sin2 < 0) {
			haxe.Log.trace(" wrong " + ncos,{ fileName : "Vector.hx", lineNumber : 293, className : "sandy.core.data.Vector", methodName : "getAngle"});
			sin2 = 0;
		}
		return Math.atan2(Math.sqrt(sin2),ncos);
	}
}
sandy.core.data.Vector.prototype.getMaxComponent = function() {
	return Math.max(this.x,Math.max(this.y,this.z));
}
sandy.core.data.Vector.prototype.getMinComponent = function() {
	return Math.min(this.x,Math.min(this.y,this.z));
}
sandy.core.data.Vector.prototype.getNorm = function() {
	return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
}
sandy.core.data.Vector.prototype.negate = function() {
	return new sandy.core.data.Vector(-this.x,-this.y,-this.z);
}
sandy.core.data.Vector.prototype.normalize = function() {
	var norm = this.getNorm();
	if(norm == 0 || norm == 1) return;
	this.x = this.x / norm;
	this.y = this.y / norm;
	this.z = this.z / norm;
}
sandy.core.data.Vector.prototype.pow = function(pow) {
	this.x = Math.pow(this.x,pow);
	this.y = Math.pow(this.y,pow);
	this.z = Math.pow(this.z,pow);
}
sandy.core.data.Vector.prototype.reset = function(px,py,pz) {
	if(px == null) px = 0;
	if(py == null) py = 0;
	if(pz == null) pz = 0;
	this.x = px;
	this.y = py;
	this.z = pz;
}
sandy.core.data.Vector.prototype.resetToNegativeInfinity = function() {
	this.x = this.y = this.z = Math.NEGATIVE_INFINITY;
}
sandy.core.data.Vector.prototype.resetToPositiveInfinity = function() {
	this.x = this.y = this.z = Math.POSITIVE_INFINITY;
}
sandy.core.data.Vector.prototype.scale = function(n) {
	this.x *= n;
	this.y *= n;
	this.z *= n;
}
sandy.core.data.Vector.prototype.serialize = function(decPlaces) {
	if(decPlaces == 0) {
		decPlaces = .01;
	}
	return (sandy.util.NumberUtil.roundTo(this.x,decPlaces) + "," + sandy.util.NumberUtil.roundTo(this.y,decPlaces) + "," + sandy.util.NumberUtil.roundTo(this.z,decPlaces));
}
sandy.core.data.Vector.prototype.sub = function(v) {
	this.x -= v.x;
	this.y -= v.y;
	this.z -= v.z;
}
sandy.core.data.Vector.prototype.toString = function(decPlaces) {
	if(decPlaces == 0 || decPlaces == null) {
		decPlaces = 0.01;
	}
	return "{" + sandy.util.NumberUtil.roundTo(this.x,decPlaces) + ", " + sandy.util.NumberUtil.roundTo(this.y,decPlaces) + ", " + sandy.util.NumberUtil.roundTo(this.z,decPlaces) + "}";
}
sandy.core.data.Vector.prototype.x = null;
sandy.core.data.Vector.prototype.y = null;
sandy.core.data.Vector.prototype.z = null;
sandy.core.data.Vector.prototype.__class__ = sandy.core.data.Vector;
Lambda = function() { }
Lambda.__name__ = ["Lambda"];
Lambda.array = function(it) {
	var a = new Array();
	{ var $it13 = it.iterator();
	while( $it13.hasNext() ) { var i = $it13.next();
	a.push(i);
	}}
	return a;
}
Lambda.list = function(it) {
	var l = new List();
	{ var $it14 = it.iterator();
	while( $it14.hasNext() ) { var i = $it14.next();
	l.add(i);
	}}
	return l;
}
Lambda.map = function(it,f) {
	var l = new List();
	{ var $it15 = it.iterator();
	while( $it15.hasNext() ) { var x = $it15.next();
	l.add(f(x));
	}}
	return l;
}
Lambda.mapi = function(it,f) {
	var l = new List();
	var i = 0;
	{ var $it16 = it.iterator();
	while( $it16.hasNext() ) { var x = $it16.next();
	l.add(f(i++,x));
	}}
	return l;
}
Lambda.has = function(it,elt,cmp) {
	if(cmp == null) {
		{ var $it17 = it.iterator();
		while( $it17.hasNext() ) { var x = $it17.next();
		if(x == elt) return true;
		}}
	}
	else {
		{ var $it18 = it.iterator();
		while( $it18.hasNext() ) { var x = $it18.next();
		if(cmp(x,elt)) return true;
		}}
	}
	return false;
}
Lambda.exists = function(it,f) {
	{ var $it19 = it.iterator();
	while( $it19.hasNext() ) { var x = $it19.next();
	if(f(x)) return true;
	}}
	return false;
}
Lambda.foreach = function(it,f) {
	{ var $it20 = it.iterator();
	while( $it20.hasNext() ) { var x = $it20.next();
	if(!f(x)) return false;
	}}
	return true;
}
Lambda.iter = function(it,f) {
	{ var $it21 = it.iterator();
	while( $it21.hasNext() ) { var x = $it21.next();
	f(x);
	}}
}
Lambda.filter = function(it,f) {
	var l = new List();
	{ var $it22 = it.iterator();
	while( $it22.hasNext() ) { var x = $it22.next();
	if(f(x)) l.add(x);
	}}
	return l;
}
Lambda.fold = function(it,f,first) {
	{ var $it23 = it.iterator();
	while( $it23.hasNext() ) { var x = $it23.next();
	first = f(x,first);
	}}
	return first;
}
Lambda.count = function(it) {
	var n = 0;
	{ var $it24 = it.iterator();
	while( $it24.hasNext() ) { var _ = $it24.next();
	++n;
	}}
	return n;
}
Lambda.empty = function(it) {
	return !it.iterator().hasNext();
}
Lambda.prototype.__class__ = Lambda;
sandy.materials.MovieMaterial = function(p_oMovie,p_nUpdateMS,p_oAttr,p_bRemoveTransparentBorder,p_nHeight,p_nWidth) { if( p_oMovie === $_ ) return; {
	if(p_nWidth == null) p_nWidth = 0.0;
	if(p_nHeight == null) p_nHeight = 0.0;
	if(p_bRemoveTransparentBorder == null) p_bRemoveTransparentBorder = false;
	if(p_nUpdateMS == null) p_nUpdateMS = 40;
	var w;
	var h;
	this.m_oAlpha = new neash.geom.ColorTransform();
	var tmpBmp = null;
	var rect;
	if(p_bRemoveTransparentBorder) {
		tmpBmp = new canvas.display.BitmapData(Std["int"](p_oMovie.GetWidth()),Std["int"](p_oMovie.GetHeight()),true,0);
		tmpBmp.draw(p_oMovie);
		rect = tmpBmp.getColorBoundsRect(-16777216,0,false);
		w = rect.width;
		h = rect.height;
	}
	else {
		w = (p_nWidth != 0?p_nWidth:p_oMovie.GetWidth());
		h = (p_nHeight != 0?p_nHeight:p_oMovie.GetHeight());
	}
	sandy.materials.BitmapMaterial.apply(this,[new canvas.display.BitmapData(Std["int"](w),Std["int"](h),true,0),p_oAttr]);
	this.m_oMovie = p_oMovie;
	this.m_oType = sandy.materials.MaterialType.MOVIE;
	this.m_bUpdate = true;
	this.m_oTimer = new haxe.Timer(p_nUpdateMS);
	this.m_oTimer.run();
	if(tmpBmp != null) {
		tmpBmp.dispose();
		tmpBmp = null;
	}
	rect = null;
}}
sandy.materials.MovieMaterial.__name__ = ["sandy","materials","MovieMaterial"];
sandy.materials.MovieMaterial.__super__ = sandy.materials.BitmapMaterial;
for(var k in sandy.materials.BitmapMaterial.prototype ) sandy.materials.MovieMaterial.prototype[k] = sandy.materials.BitmapMaterial.prototype[k];
sandy.materials.MovieMaterial.prototype.__getMovie = function() {
	return this.m_oMovie;
}
sandy.materials.MovieMaterial.prototype._update = function(p_eEvent) {
	if(this.m_bUpdate || this.forceUpdate) {
		this.m_oTexture.fillRect(this.m_oTexture.rect,sandy.math.ColorMath.applyAlpha(0,this.m_oAlpha.alphaMultiplier));
		this.m_oTexture.draw(this.m_oMovie,null,this.m_oAlpha,null,null,this.smooth);
	}
	this.m_bUpdate = false;
}
sandy.materials.MovieMaterial.prototype.m_bUpdate = null;
sandy.materials.MovieMaterial.prototype.m_oAlpha = null;
sandy.materials.MovieMaterial.prototype.m_oMovie = null;
sandy.materials.MovieMaterial.prototype.m_oTimer = null;
sandy.materials.MovieMaterial.prototype.movie = null;
sandy.materials.MovieMaterial.prototype.renderPolygon = function(p_oScene,p_oPolygon,p_mcContainer) {
	this.m_bUpdate = true;
	sandy.materials.BitmapMaterial.prototype.renderPolygon.apply(this,[p_oScene,p_oPolygon,p_mcContainer]);
}
sandy.materials.MovieMaterial.prototype.setTransparency = function(p_nValue) {
	this.m_oAlpha.alphaMultiplier = sandy.util.NumberUtil.constrain(p_nValue,0,1);
}
sandy.materials.MovieMaterial.prototype.start = function() {
	this.m_oTimer.run();
}
sandy.materials.MovieMaterial.prototype.stop = function() {
	this.m_oTimer.stop();
}
sandy.materials.MovieMaterial.prototype.__class__ = sandy.materials.MovieMaterial;
neash.display.Shape = function(p) { if( p === $_ ) return; {
	neash.display.DisplayObject.apply(this,[]);
	this.mGraphics = new canvas.display.Graphics();
}}
neash.display.Shape.__name__ = ["neash","display","Shape"];
neash.display.Shape.__super__ = neash.display.DisplayObject;
for(var k in neash.display.DisplayObject.prototype ) neash.display.Shape.prototype[k] = neash.display.DisplayObject.prototype[k];
neash.display.Shape.prototype.GetGraphics = function() {
	return this.mGraphics;
}
neash.display.Shape.prototype.graphics = null;
neash.display.Shape.prototype.mGraphics = null;
neash.display.Shape.prototype.__class__ = neash.display.Shape;
canvas.geom.Rectangle = function(inX,inY,inWidth,inHeight) { if( inX === $_ ) return; {
	this.x = (inX == null?0:inX);
	this.y = (inY == null?0:inY);
	this.width = (inWidth == null?0:inWidth);
	this.height = (inHeight == null?0:inHeight);
}}
canvas.geom.Rectangle.__name__ = ["canvas","geom","Rectangle"];
canvas.geom.Rectangle.prototype.bottom = null;
canvas.geom.Rectangle.prototype.bottomRight = null;
canvas.geom.Rectangle.prototype.clone = function() {
	return new canvas.geom.Rectangle(this.x,this.y,this.width,this.height);
}
canvas.geom.Rectangle.prototype.contains = function(inX,inY) {
	return inX >= this.x && inY >= this.y && inX < this.get_right() && inY < this.get_bottom();
}
canvas.geom.Rectangle.prototype.containsPoint = function(point) {
	return this.contains(point.x,point.y);
}
canvas.geom.Rectangle.prototype.containsRect = function(rect) {
	return this.contains(rect.x,rect.y) && this.containsPoint(rect.get_bottomRight());
}
canvas.geom.Rectangle.prototype.equals = function(toCompare) {
	return this.x == toCompare.x && this.y == toCompare.y && this.width == toCompare.width && this.height == toCompare.height;
}
canvas.geom.Rectangle.prototype.extendBounds = function(r) {
	var dx = this.x - r.x;
	if(dx > 0) {
		this.x -= dx;
		this.width += dx;
	}
	var dy = this.y - r.y;
	if(dy > 0) {
		this.y -= dy;
		this.height += dy;
	}
	if(r.get_right() > this.get_right()) this.set_right(r.get_right());
	if(r.get_bottom() > this.get_bottom()) this.set_bottom(r.get_bottom());
}
canvas.geom.Rectangle.prototype.get_bottom = function() {
	return this.y + this.height;
}
canvas.geom.Rectangle.prototype.get_bottomRight = function() {
	return new canvas.geom.Point(this.x + this.width,this.y + this.height);
}
canvas.geom.Rectangle.prototype.get_left = function() {
	return this.x;
}
canvas.geom.Rectangle.prototype.get_right = function() {
	return this.x + this.width;
}
canvas.geom.Rectangle.prototype.get_size = function() {
	return new canvas.geom.Point(this.width,this.height);
}
canvas.geom.Rectangle.prototype.get_top = function() {
	return this.y;
}
canvas.geom.Rectangle.prototype.get_topLeft = function() {
	return new canvas.geom.Point(this.x,this.y);
}
canvas.geom.Rectangle.prototype.height = null;
canvas.geom.Rectangle.prototype.inflate = function(dx,dy) {
	this.x -= dx;
	this.width += dx * 2;
	this.y -= dy;
	this.height += dy * 2;
}
canvas.geom.Rectangle.prototype.inflatePoint = function(point) {
	this.inflate(point.x,point.y);
}
canvas.geom.Rectangle.prototype.intersection = function(toIntersect) {
	var x0 = (this.x < toIntersect.x?toIntersect.x:this.x);
	var x1 = (this.get_right() > toIntersect.get_right()?toIntersect.get_right():this.get_right());
	if(x1 <= x0) return new canvas.geom.Rectangle();
	var y0 = (this.y < toIntersect.y?toIntersect.x:this.y);
	var y1 = (this.get_bottom() > toIntersect.get_bottom()?toIntersect.get_bottom():this.get_bottom());
	if(y1 <= y0) return new canvas.geom.Rectangle();
	return new canvas.geom.Rectangle(x0,y0,x1 - x0,y1 - y0);
}
canvas.geom.Rectangle.prototype.intersects = function(toIntersect) {
	var x0 = (this.x < toIntersect.x?toIntersect.x:this.x);
	var x1 = (this.get_right() > toIntersect.get_right()?toIntersect.get_right():this.get_right());
	if(x1 <= x0) return false;
	var y0 = (this.y < toIntersect.y?toIntersect.x:this.y);
	var y1 = (this.get_bottom() > toIntersect.get_bottom()?toIntersect.get_bottom():this.get_bottom());
	return y1 > y0;
}
canvas.geom.Rectangle.prototype.isEmpty = function() {
	return this.width == 0 && this.height == 0;
}
canvas.geom.Rectangle.prototype.left = null;
canvas.geom.Rectangle.prototype.offset = function(dx,dy) {
	this.x += dx;
	this.y += dy;
}
canvas.geom.Rectangle.prototype.offsetPoint = function(point) {
	this.x += point.x;
	this.y += point.y;
}
canvas.geom.Rectangle.prototype.right = null;
canvas.geom.Rectangle.prototype.setEmpty = function() {
	this.x = this.y = this.width = this.height = 0;
}
canvas.geom.Rectangle.prototype.set_bottom = function(b) {
	this.height = b - this.y;
	return b;
}
canvas.geom.Rectangle.prototype.set_bottomRight = function(p) {
	this.width = p.x - this.x;
	this.height = p.y - this.y;
	return p.clone();
}
canvas.geom.Rectangle.prototype.set_left = function(l) {
	this.x = l;
	return l;
}
canvas.geom.Rectangle.prototype.set_right = function(r) {
	this.width = r - this.x;
	return r;
}
canvas.geom.Rectangle.prototype.set_size = function(p) {
	this.width = p.x;
	this.height = p.y;
	return p.clone();
}
canvas.geom.Rectangle.prototype.set_top = function(t) {
	this.y = t;
	return t;
}
canvas.geom.Rectangle.prototype.set_topLeft = function(p) {
	this.x = p.x;
	this.y = p.y;
	return p.clone();
}
canvas.geom.Rectangle.prototype.size = null;
canvas.geom.Rectangle.prototype.top = null;
canvas.geom.Rectangle.prototype.topLeft = null;
canvas.geom.Rectangle.prototype.transform = function(m) {
	var tx0 = m.a * this.x + m.c * this.y;
	var tx1 = tx0;
	var ty0 = m.b * this.x + m.d * this.y;
	var ty1 = tx0;
	var tx = m.a * (this.x + this.width) + m.c * this.y;
	var ty = m.b * (this.x + this.width) + m.d * this.y;
	if(tx < tx0) tx0 = tx;
	if(ty < ty0) ty0 = ty;
	if(tx > tx1) tx1 = tx;
	if(ty > ty1) ty1 = ty;
	tx = m.a * (this.x + this.width) + m.c * (this.y + this.height);
	ty = m.b * (this.x + this.width) + m.d * (this.y + this.height);
	if(tx < tx0) tx0 = tx;
	if(ty < ty0) ty0 = ty;
	if(tx > tx1) tx1 = tx;
	if(ty > ty1) ty1 = ty;
	tx = m.a * this.x + m.c * (this.y + this.height);
	ty = m.b * this.x + m.d * (this.y + this.height);
	if(tx < tx0) tx0 = tx;
	if(ty < ty0) ty0 = ty;
	if(tx > tx1) tx1 = tx;
	if(ty > ty1) ty1 = ty;
	return new canvas.geom.Rectangle(tx0 + m.tx,ty0 + m.ty,tx1 - tx0,ty1 - ty0);
}
canvas.geom.Rectangle.prototype.union = function(toUnion) {
	var x0 = (this.x > toUnion.x?toUnion.x:this.x);
	var x1 = (this.get_right() < toUnion.get_right()?toUnion.get_right():this.get_right());
	var y0 = (this.y > toUnion.y?toUnion.x:this.y);
	var y1 = (this.get_bottom() < toUnion.get_bottom()?toUnion.get_bottom():this.get_bottom());
	return new canvas.geom.Rectangle(x0,y0,x1 - x0,y1 - y0);
}
canvas.geom.Rectangle.prototype.width = null;
canvas.geom.Rectangle.prototype.x = null;
canvas.geom.Rectangle.prototype.y = null;
canvas.geom.Rectangle.prototype.__class__ = canvas.geom.Rectangle;
haxe.io.Eof = function(p) { if( p === $_ ) return; {
	null;
}}
haxe.io.Eof.__name__ = ["haxe","io","Eof"];
haxe.io.Eof.prototype.toString = function() {
	return "Eof";
}
haxe.io.Eof.prototype.__class__ = haxe.io.Eof;
sandy.core.SceneLocator = function(access) { if( access === $_ ) return; {
	this._m = new Hash();
}}
sandy.core.SceneLocator.__name__ = ["sandy","core","SceneLocator"];
sandy.core.SceneLocator._oI = null;
sandy.core.SceneLocator.getInstance = function() {
	if(sandy.core.SceneLocator._oI == null) sandy.core.SceneLocator._oI = new sandy.core.SceneLocator(new sandy.core.PrivateConstructorAccess());
	return sandy.core.SceneLocator._oI;
}
sandy.core.SceneLocator.prototype._m = null;
sandy.core.SceneLocator.prototype.getScene = function(key) {
	if(!(this.isRegistered(key))) haxe.Log.trace("Can't locate scene instance with '" + key + "' name in " + this,{ fileName : "SceneLocator.hx", lineNumber : 69, className : "sandy.core.SceneLocator", methodName : "getScene"});
	return this._m.get(key);
}
sandy.core.SceneLocator.prototype.isRegistered = function(key) {
	return this._m.get(key) != null;
}
sandy.core.SceneLocator.prototype.registerScene = function(key,o) {
	if(this.isRegistered(key)) {
		haxe.Log.trace("scene instance is already registered with '" + key + "' name in " + this,{ fileName : "SceneLocator.hx", lineNumber : 95, className : "sandy.core.SceneLocator", methodName : "registerScene"});
		return false;
	}
	else {
		this._m.set(key,o);
		return true;
	}
}
sandy.core.SceneLocator.prototype.unregisterScene = function(key) {
	this._m.remove(key);
}
sandy.core.SceneLocator.prototype.__class__ = sandy.core.SceneLocator;
sandy.core.PrivateConstructorAccess = function(p) { if( p === $_ ) return; {
	null;
}}
sandy.core.PrivateConstructorAccess.__name__ = ["sandy","core","PrivateConstructorAccess"];
sandy.core.PrivateConstructorAccess.prototype.__class__ = sandy.core.PrivateConstructorAccess;
neash.display.Stage = function(inWidth,inHeight,inManager) { if( inWidth === $_ ) return; {
	neash.display.DisplayObjectContainer.apply(this,[]);
	this.mFocusObject = null;
	this.mManager = inManager;
	this.mWindowWidth = this.mWidth = inWidth;
	this.mWindowHeight = this.mHeight = inHeight;
	this.stageFocusRect = false;
	this.scaleMode = neash.display.StageScaleMode.SHOW_ALL;
	this.mStageMatrix = new canvas.geom.Matrix();
	this.tabEnabled = true;
	this.frameRate = 0;
	this.SetBackgroundColour(16777215);
	this.name = "Stage";
}}
neash.display.Stage.__name__ = ["neash","display","Stage"];
neash.display.Stage.__super__ = neash.display.DisplayObjectContainer;
for(var k in neash.display.DisplayObjectContainer.prototype ) neash.display.Stage.prototype[k] = neash.display.DisplayObjectContainer.prototype[k];
neash.display.Stage.prototype.DoSetFocus = function(inObj,inKeyCode) {
	if(this.mFocusObject != inObj) {
		if(this.mFocusObject != null) {
			this.mFocusObject.OnFocusOut();
			var event = new neash.events.FocusEvent(neash.events.FocusEvent.FOCUS_OUT,true,false,this.mFocusObject);
			event.relatedObject = inObj;
			neash.Lib.SendEventToObject(event,this.mFocusObject);
		}
		var old = this.mFocusObject;
		this.mFocusObject = inObj;
		if(this.mFocusObject != null) {
			this.mFocusObject.OnFocusIn(inKeyCode < 0);
			var event = new neash.events.FocusEvent(neash.events.FocusEvent.FOCUS_IN,true,false,inObj);
			event.relatedObject = old;
			neash.Lib.SendEventToObject(event,this.mFocusObject);
		}
	}
	return inObj;
}
neash.display.Stage.prototype.GetFocus = function() {
	return this.mFocusObject;
}
neash.display.Stage.prototype.GetInteractiveObjectAtPos = function(inX,inY) {
	var l = this.mObjs.length - 1;
	{
		var _g1 = 0, _g = this.mObjs.length;
		while(_g1 < _g) {
			var i = _g1++;
			var result = this.mObjs[l - i].GetObj(inX,inY,null);
			if(result != null) return result;
		}
	}
	return this;
}
neash.display.Stage.prototype.GetQuality = function() {
	var q = canvas.Manager.get_draw_quality();
	switch(q) {
	case 0:{
		return neash.display.StageQuality.LOW;
	}break;
	case 1:{
		return neash.display.StageQuality.MEDIUM;
	}break;
	case 2:{
		return neash.display.StageQuality.HIGH;
	}break;
	}
	return neash.display.StageQuality.BEST;
}
neash.display.Stage.prototype.GetStageHeight = function() {
	return this.mHeight;
}
neash.display.Stage.prototype.GetStageWidth = function() {
	return this.mWidth;
}
neash.display.Stage.prototype.HandleKey = function(inKey) {
	if(this.mFocusObject != null) {
		this.mFocusObject.OnKey(inKey);
		this.mFocusObject.dispatchEvent(inKey);
	}
	else this.dispatchEvent(inKey);
}
neash.display.Stage.prototype.OnResize = function(inW,inH) {
	this.mWindowWidth = inW;
	this.mWindowHeight = inH;
}
neash.display.Stage.prototype.RenderAll = function() {
	this.Render(null,null,0,0);
}
neash.display.Stage.prototype.SetBackgroundColour = function(col) {
	this.backgroundColor = col;
	return col;
}
neash.display.Stage.prototype.SetFocus = function(inObj) {
	return this.DoSetFocus(inObj,-1);
}
neash.display.Stage.prototype.SetQuality = function(inQuality) {
	canvas.Manager.set_draw_quality((inQuality == neash.display.StageQuality.LOW?0:1));
	return inQuality;
}
neash.display.Stage.prototype.TabChange = function(inDiff,inFromKey) {
	var tabs = new Array();
	{
		var _g1 = 0, _g = this.mObjs.length;
		while(_g1 < _g) {
			var i = _g1++;
			this.mObjs[i].GetFocusObjects(tabs);
		}
	}
	var l = tabs.length;
	if(l == 0) this.SetFocus(null);
	else {
		var found = -1;
		if(this.mFocusObject != null) {
			{
				var _g = 0;
				while(_g < l) {
					var i = _g++;
					if(tabs[i] == this.mFocusObject) {
						found = i;
						break;
					}
				}
			}
		}
		if(found < 0) this.DoSetFocus((inDiff > 0?tabs[0]:tabs[l - 1]),inFromKey);
		else this.DoSetFocus(tabs[(l + inDiff + found) % l],inFromKey);
	}
}
neash.display.Stage.prototype.align = null;
neash.display.Stage.prototype.backgroundColor = null;
neash.display.Stage.prototype.focus = null;
neash.display.Stage.prototype.frameRate = null;
neash.display.Stage.prototype.mFocusObject = null;
neash.display.Stage.prototype.mHeight = null;
neash.display.Stage.prototype.mManager = null;
neash.display.Stage.prototype.mStageMatrix = null;
neash.display.Stage.prototype.mWidth = null;
neash.display.Stage.prototype.mWindowHeight = null;
neash.display.Stage.prototype.mWindowWidth = null;
neash.display.Stage.prototype.quality = null;
neash.display.Stage.prototype.scaleMode = null;
neash.display.Stage.prototype.stageFocusRect = null;
neash.display.Stage.prototype.stageHeight = null;
neash.display.Stage.prototype.stageWidth = null;
neash.display.Stage.prototype.__class__ = neash.display.Stage;
neash.swf.ScaledFont = function(inFont,inHeight) { if( inFont === $_ ) return; {
	this.mFont = inFont;
	this.mHeight = inHeight;
	this.mScale = inHeight / 1024.0;
	this.mMatrix = new canvas.geom.Matrix();
	this.mMatrix.scale(this.mScale,this.mScale);
	this.mAscent = this.GetAscent();
}}
neash.swf.ScaledFont.__name__ = ["neash","swf","ScaledFont"];
neash.swf.ScaledFont.prototype.CanRenderOutline = function() {
	return true;
}
neash.swf.ScaledFont.prototype.CanRenderSolid = function() {
	return false;
}
neash.swf.ScaledFont.prototype.GetAdvance = function(inChar) {
	return Std["int"](this.mFont.GetAdvance(inChar) * this.mScale);
}
neash.swf.ScaledFont.prototype.GetAscent = function() {
	return Std["int"](this.mFont.GetAscent() * this.mScale);
}
neash.swf.ScaledFont.prototype.GetDescent = function() {
	return Std["int"](this.mFont.GetDescent() * this.mScale);
}
neash.swf.ScaledFont.prototype.GetHeight = function() {
	return this.mHeight;
}
neash.swf.ScaledFont.prototype.GetLeading = function() {
	return Std["int"](this.mFont.GetLeading() * this.mScale);
}
neash.swf.ScaledFont.prototype.GetName = function() {
	return this.mFont.GetName();
}
neash.swf.ScaledFont.prototype.Render = function(inGfx,inChar,inX,inY,inOutline) {
	this.mMatrix.tx = inX;
	this.mMatrix.ty = inY + this.mAscent;
	return Std["int"](this.mFont.RenderChar(inGfx,inChar,this.mMatrix) * this.mScale);
}
neash.swf.ScaledFont.prototype.mAscent = null;
neash.swf.ScaledFont.prototype.mFont = null;
neash.swf.ScaledFont.prototype.mHeight = null;
neash.swf.ScaledFont.prototype.mMatrix = null;
neash.swf.ScaledFont.prototype.mScale = null;
neash.swf.ScaledFont.prototype.__class__ = neash.swf.ScaledFont;
neash.swf.ScaledFont.__interfaces__ = [neash.text.Font];
sandy.extrusion.Extrusion = function(name,profile,sections,closeFront,closeBack) { if( name === $_ ) return; {
	if(closeBack == null) closeBack = true;
	if(closeFront == null) closeFront = true;
	sandy.core.scenegraph.Shape3D.apply(this,[]);
	var a = profile.area();
	var i;
	var j;
	var k;
	var g = new sandy.core.scenegraph.Geometry3D();
	var v = new sandy.core.data.Vector();
	var backFaceIDs = [];
	var frontFaceIDs = [], sideFaceIDs = [];
	var links = [], n = profile.vertices.length;
	{
		var _g1 = 1, _g = n + 1;
		while(_g1 < _g) {
			var i1 = _g1++;
			var _g3 = 1, _g2 = n + 1;
			while(_g3 < _g2) {
				var j1 = _g3++;
				if((canvas.geom.Point.distance(profile.vertices[i1 % n],profile.vertices[j1 - 1]) == 0) && (canvas.geom.Point.distance(profile.vertices[j1 % n],profile.vertices[i1 - 1]) == 0)) links.push(profile.vertices[i1]);
			}
		}
	}
	if(sections == null) sections = [];
	var l_sections = sections.slice(0);
	if(l_sections.length < 1) l_sections.push(new sandy.core.data.Matrix4());
	{
		var _g1 = 0, _g = l_sections.length;
		while(_g1 < _g) {
			var i1 = _g1++;
			var m = l_sections[i1];
			{
				var _g3 = 0, _g2 = n + 1;
				while(_g3 < _g2) {
					var j1 = _g3++;
					if(j1 < n) {
						v.x = profile.vertices[j1].x;
						v.y = profile.vertices[j1].y;
						v.z = 0;
						m.vectorMult(v);
						g.setVertex(j1 + i1 * n,v.x,v.y,v.z);
					}
					g.setUVCoords(j1 + i1 * (n + 1),j1 / n,i1 / (l_sections.length - 1));
				}
			}
			if(i1 > 0) {
				{
					var _g3 = 1, _g2 = n + 1;
					while(_g3 < _g2) {
						var j1 = _g3++;
						if(links.indexOf(profile.vertices[j1 % n]) < 0) {
							k = g.getNextFaceID();
							var i11 = j1 % n + i1 * n;
							var i2 = ((a > 0)?(j1 + (i1 - 1) * n - 1):(j1 + i1 * n - 1));
							var i3 = ((a > 0)?(j1 + i1 * n - 1):(j1 + (i1 - 1) * n - 1));
							var i4 = ((a > 0)?(j1 % n + (i1 - 1) * n):(j1 + (i1 - 1) * n - 1));
							var i5 = ((a > 0)?(j1 + (i1 - 1) * n - 1):(j1 % n + (i1 - 1) * n));
							g.setFaceVertexIds(k,[i11,i2,i3]);
							g.setFaceVertexIds(k + 1,[i11,i4,i5]);
							i11 = j1 + i1 * (n + 1);
							i2 = ((a > 0)?(j1 + (i1 - 1) * (n + 1) - 1):(j1 + i1 * (n + 1) - 1));
							i3 = ((a > 0)?(j1 + i1 * (n + 1) - 1):(j1 + (i1 - 1) * (n + 1) - 1));
							i4 = ((a > 0)?(j1 + (i1 - 1) * (n + 1)):(j1 + (i1 - 1) * (n + 1) - 1));
							i5 = ((a > 0)?(j1 + (i1 - 1) * (n + 1) - 1):(j1 + (i1 - 1) * (n + 1)));
							g.setFaceUVCoordsIds(k,[i11,i2,i3]);
							g.setFaceUVCoordsIds(k + 1,[i11,i4,i5]);
							sideFaceIDs.push(k);
							sideFaceIDs.push(k + 1);
						}
					}
				}
			}
		}
	}
	links = null;
	if(closeFront || closeBack) {
		var p = g.getNextUVCoordID();
		var b = profile.bbox();
		{
			var _g1 = 0, _g = profile.vertices.length;
			while(_g1 < _g) {
				var i1 = _g1++;
				g.setUVCoords(p + i1,(profile.vertices[i1].x - b.x) / b.width,(profile.vertices[i1].y - b.y) / b.height);
			}
		}
		var triangles = profile.triangles();
		var q = g.getNextVertexID() - profile.vertices.length;
		var tri;
		{
			var _g = 0;
			while(_g < triangles.length) {
				var tri1 = triangles[_g];
				++_g;
				var v1 = profile.vertices.indexOf(tri1.vertices[0]);
				var v2 = profile.vertices.indexOf(tri1.vertices[((a > 0)?1:2)]);
				var v3 = profile.vertices.indexOf(tri1.vertices[((a > 0)?2:1)]);
				if(closeFront) {
					k = g.getNextFaceID();
					g.setFaceVertexIds(k,[v1,v2,v3]);
					g.setFaceUVCoordsIds(k,[p + v1,p + v2,p + v3]);
					frontFaceIDs.push(k);
				}
				if(closeBack) {
					k = g.getNextFaceID();
					g.setFaceVertexIds(k,[q + v1,q + v3,q + v2]);
					g.setFaceUVCoordsIds(k,[p + v1,p + v3,p + v2]);
					backFaceIDs.push(k);
				}
			}
		}
	}
	this.__setGeometry(g);
	this.backFace = new sandy.core.data.PrimitiveFace(this);
	while(backFaceIDs.length > 0) this.backFace.addPolygon(backFaceIDs.pop());
	this.frontFace = new sandy.core.data.PrimitiveFace(this);
	while(frontFaceIDs.length > 0) this.frontFace.addPolygon(frontFaceIDs.pop());
	this.sideFace = new sandy.core.data.PrimitiveFace(this);
	while(sideFaceIDs.length > 0) this.sideFace.addPolygon(sideFaceIDs.pop());
}}
sandy.extrusion.Extrusion.__name__ = ["sandy","extrusion","Extrusion"];
sandy.extrusion.Extrusion.__super__ = sandy.core.scenegraph.Shape3D;
for(var k in sandy.core.scenegraph.Shape3D.prototype ) sandy.extrusion.Extrusion.prototype[k] = sandy.core.scenegraph.Shape3D.prototype[k];
sandy.extrusion.Extrusion.prototype.backFace = null;
sandy.extrusion.Extrusion.prototype.frontFace = null;
sandy.extrusion.Extrusion.prototype.sideFace = null;
sandy.extrusion.Extrusion.prototype.__class__ = sandy.extrusion.Extrusion;
sandy.core.scenegraph.Sprite2D = function(p_sName,p_oContent,p_nScale) { if( p_sName === $_ ) return; {
	this.fixedAngle = false;
	this.autoCenter = true;
	this.floorCenter = false;
	this.enableForcedDepth = false;
	this.forcedDepth = 0;
	this.m_bEv = false;
	this.m_nW2 = 0;
	this.m_nH2 = 0;
	this.m_oContainer;
	this.m_bLightingEnabled = false;
	this.m_nPerspScaleX = 0;
	this.m_nPerspScaleY = 0;
	this.m_nRotation = 0;
	if(p_sName == null) p_sName = "";
	if(p_oContent == null) p_oContent = null;
	if(p_nScale == null) p_nScale = 1;
	sandy.core.scenegraph.ATransformable.apply(this,[p_sName]);
	this.m_oContainer = new neash.display.Sprite();
	this._v = new sandy.core.data.Vertex();
	this._vx = new sandy.core.data.Vertex();
	this._vy = new sandy.core.data.Vertex();
	this.boundingSphere = new sandy.bounds.BSphere();
	this.boundingBox = null;
	this._nScale = p_nScale;
	if(p_oContent != null) this.__setContent(p_oContent);
	this.setBoundingSphereRadius(30);
}}
sandy.core.scenegraph.Sprite2D.__name__ = ["sandy","core","scenegraph","Sprite2D"];
sandy.core.scenegraph.Sprite2D.__super__ = sandy.core.scenegraph.ATransformable;
for(var k in sandy.core.scenegraph.ATransformable.prototype ) sandy.core.scenegraph.Sprite2D.prototype[k] = sandy.core.scenegraph.ATransformable.prototype[k];
sandy.core.scenegraph.Sprite2D.prototype.__getContainer = function() {
	return this.m_oContainer;
}
sandy.core.scenegraph.Sprite2D.prototype.__getDepth = function() {
	return this.m_nDepth;
}
sandy.core.scenegraph.Sprite2D.prototype.__getEnableEvents = function() {
	return this.m_bEv;
}
sandy.core.scenegraph.Sprite2D.prototype.__getMaterial = function() {
	return this.m_oMaterial;
}
sandy.core.scenegraph.Sprite2D.prototype.__getScale = function() {
	return this._nScale;
}
sandy.core.scenegraph.Sprite2D.prototype.__setContent = function(p_content) {
	p_content.GetTransform().GetMatrix().identity();
	if(this.m_oContent != null) this.m_oContainer.removeChild(this.m_oContent);
	this.m_oContent = p_content;
	this.m_oContainer.addChildAt(this.m_oContent,0);
	this.m_oContent.SetX(0);
	this.m_oContent.SetY(0);
	this.m_nW2 = this.m_oContainer.GetWidth() / 2;
	this.m_nH2 = this.m_oContainer.GetHeight() / 2;
	return p_content;
}
sandy.core.scenegraph.Sprite2D.prototype.__setDepth = function(p_nDepth) {
	return p_nDepth;
}
sandy.core.scenegraph.Sprite2D.prototype.__setEnableEvents = function(b) {
	if(b && !this.m_bEv) {
		this.m_oContainer.addEventListener(neash.events.MouseEvent.CLICK,$closure(this,"_onInteraction"));
		this.m_oContainer.addEventListener(neash.events.MouseEvent.MOUSE_UP,$closure(this,"_onInteraction"));
		this.m_oContainer.addEventListener(neash.events.MouseEvent.MOUSE_DOWN,$closure(this,"_onInteraction"));
		this.m_oContainer.addEventListener(neash.events.MouseEvent.ROLL_OVER,$closure(this,"_onInteraction"));
		this.m_oContainer.addEventListener(neash.events.MouseEvent.ROLL_OUT,$closure(this,"_onInteraction"));
		this.m_oContainer.addEventListener(neash.events.MouseEvent.DOUBLE_CLICK,$closure(this,"_onInteraction"));
		this.m_oContainer.addEventListener(neash.events.MouseEvent.MOUSE_MOVE,$closure(this,"_onInteraction"));
		this.m_oContainer.addEventListener(neash.events.MouseEvent.MOUSE_OVER,$closure(this,"_onInteraction"));
		this.m_oContainer.addEventListener(neash.events.MouseEvent.MOUSE_OUT,$closure(this,"_onInteraction"));
		this.m_oContainer.addEventListener(neash.events.MouseEvent.MOUSE_WHEEL,$closure(this,"_onInteraction"));
	}
	else if(!b && this.m_bEv) {
		this.m_oContainer.removeEventListener(neash.events.MouseEvent.CLICK,$closure(this,"_onInteraction"));
		this.m_oContainer.removeEventListener(neash.events.MouseEvent.MOUSE_UP,$closure(this,"_onInteraction"));
		this.m_oContainer.removeEventListener(neash.events.MouseEvent.MOUSE_DOWN,$closure(this,"_onInteraction"));
		this.m_oContainer.removeEventListener(neash.events.MouseEvent.ROLL_OVER,$closure(this,"_onInteraction"));
		this.m_oContainer.removeEventListener(neash.events.MouseEvent.ROLL_OUT,$closure(this,"_onInteraction"));
		this.m_oContainer.removeEventListener(neash.events.MouseEvent.DOUBLE_CLICK,$closure(this,"_onInteraction"));
		this.m_oContainer.removeEventListener(neash.events.MouseEvent.MOUSE_MOVE,$closure(this,"_onInteraction"));
		this.m_oContainer.removeEventListener(neash.events.MouseEvent.MOUSE_OVER,$closure(this,"_onInteraction"));
		this.m_oContainer.removeEventListener(neash.events.MouseEvent.MOUSE_OUT,$closure(this,"_onInteraction"));
		this.m_oContainer.removeEventListener(neash.events.MouseEvent.MOUSE_WHEEL,$closure(this,"_onInteraction"));
	}
	return b;
}
sandy.core.scenegraph.Sprite2D.prototype.__setMaterial = function(p_oMaterial) {
	this.m_oMaterial = p_oMaterial;
	return p_oMaterial;
}
sandy.core.scenegraph.Sprite2D.prototype.__setScale = function(n) {
	this._nScale = n;
	return n;
}
sandy.core.scenegraph.Sprite2D.prototype._nScale = null;
sandy.core.scenegraph.Sprite2D.prototype._onInteraction = function(p_oEvt) {
	this.m_oEB.broadcastEvent(new sandy.events.BubbleEvent(p_oEvt.type,this));
}
sandy.core.scenegraph.Sprite2D.prototype._v = null;
sandy.core.scenegraph.Sprite2D.prototype._vx = null;
sandy.core.scenegraph.Sprite2D.prototype._vy = null;
sandy.core.scenegraph.Sprite2D.prototype.autoCenter = null;
sandy.core.scenegraph.Sprite2D.prototype.clear = function() {
	null;
}
sandy.core.scenegraph.Sprite2D.prototype.container = null;
sandy.core.scenegraph.Sprite2D.prototype.content = null;
sandy.core.scenegraph.Sprite2D.prototype.cull = function(p_oScene,p_oFrustum,p_oViewMatrix,p_bChanged) {
	sandy.core.scenegraph.ATransformable.prototype.cull.apply(this,[p_oScene,p_oFrustum,p_oViewMatrix,p_bChanged]);
	if(this.viewMatrix != null) {
		this.boundingSphere.transform(this.viewMatrix);
		this.culled = p_oFrustum.sphereInFrustum(this.boundingSphere);
	}
	if(this.culled == sandy.view.CullingState.OUTSIDE) this.__getContainer().visible = false;
	else if(this.culled == sandy.view.CullingState.INTERSECT) {
		if(this.boundingSphere.position.z <= p_oScene.camera.__getNear()) this.__getContainer().visible = false;
		else this.__getContainer().visible = true;
	}
	else this.__getContainer().visible = true;
}
sandy.core.scenegraph.Sprite2D.prototype.depth = null;
sandy.core.scenegraph.Sprite2D.prototype.display = function(p_oScene,p_oContainer) {
	this.m_oContainer.SetScaleX(this.m_nPerspScaleX);
	this.m_oContainer.SetScaleY(this.m_nPerspScaleY);
	this.m_oContainer.SetX(this._v.sx - ((this.autoCenter?this.m_oContainer.GetWidth() / 2:0)));
	this.m_oContainer.SetY(this._v.sy - ((this.autoCenter?this.m_oContainer.GetHeight() / 2:0)));
	this.m_oContainer.SetY(this._v.sy - ((this.autoCenter?this.m_oContainer.GetHeight() / 2:((this.floorCenter?this.m_oContainer.GetHeight():0)))));
	if(this.fixedAngle) this.m_oContainer.SetRotation(this.m_nRotation * 180 / Math.PI);
	if(this.m_oMaterial != null) this.m_oMaterial.renderSprite(this,this.m_oMaterial,p_oScene);
}
sandy.core.scenegraph.Sprite2D.prototype.enableEvents = null;
sandy.core.scenegraph.Sprite2D.prototype.enableForcedDepth = null;
sandy.core.scenegraph.Sprite2D.prototype.fixedAngle = null;
sandy.core.scenegraph.Sprite2D.prototype.floorCenter = null;
sandy.core.scenegraph.Sprite2D.prototype.forcedDepth = null;
sandy.core.scenegraph.Sprite2D.prototype.m_bEv = null;
sandy.core.scenegraph.Sprite2D.prototype.m_bLightingEnabled = null;
sandy.core.scenegraph.Sprite2D.prototype.m_nDepth = null;
sandy.core.scenegraph.Sprite2D.prototype.m_nH2 = null;
sandy.core.scenegraph.Sprite2D.prototype.m_nPerspScaleX = null;
sandy.core.scenegraph.Sprite2D.prototype.m_nPerspScaleY = null;
sandy.core.scenegraph.Sprite2D.prototype.m_nRotation = null;
sandy.core.scenegraph.Sprite2D.prototype.m_nW2 = null;
sandy.core.scenegraph.Sprite2D.prototype.m_oContainer = null;
sandy.core.scenegraph.Sprite2D.prototype.m_oContent = null;
sandy.core.scenegraph.Sprite2D.prototype.m_oMaterial = null;
sandy.core.scenegraph.Sprite2D.prototype.material = null;
sandy.core.scenegraph.Sprite2D.prototype.remove = function() {
	if(this.m_oContainer.GetParent() != null) this.m_oContainer.GetParent().removeChild(this.m_oContainer);
	sandy.core.scenegraph.ATransformable.prototype.remove.apply(this,[]);
}
sandy.core.scenegraph.Sprite2D.prototype.render = function(p_oScene,p_oCamera) {
	if((this.m_oMaterial != null) && !p_oScene.materialManager.isRegistered(this.m_oMaterial)) {
		p_oScene.materialManager.register(this.m_oMaterial);
	}
	this._v.wx = this._v.x * this.viewMatrix.n11 + this._v.y * this.viewMatrix.n12 + this._v.z * this.viewMatrix.n13 + this.viewMatrix.n14;
	this._v.wy = this._v.x * this.viewMatrix.n21 + this._v.y * this.viewMatrix.n22 + this._v.z * this.viewMatrix.n23 + this.viewMatrix.n24;
	this._v.wz = this._v.x * this.viewMatrix.n31 + this._v.y * this.viewMatrix.n32 + this._v.z * this.viewMatrix.n33 + this.viewMatrix.n34;
	this.m_nDepth = (this.enableForcedDepth?this.forcedDepth:this._v.wz);
	p_oCamera.projectVertex(this._v);
	p_oCamera.addToDisplayList(this);
	this._vx.copy(this._v);
	this._vx.wx++;
	p_oCamera.projectVertex(this._vx);
	this._vy.copy(this._v);
	this._vy.wy++;
	p_oCamera.projectVertex(this._vy);
	this.m_nPerspScaleX = this._nScale * (this._vx.sx - this._v.sx);
	this.m_nPerspScaleY = this._nScale * (this._v.sy - this._vy.sy);
	this.m_nRotation = Math.atan2(this.viewMatrix.n12,this.viewMatrix.n22);
}
sandy.core.scenegraph.Sprite2D.prototype.scale = null;
sandy.core.scenegraph.Sprite2D.prototype.setBoundingSphereRadius = function(p_nRadius) {
	this.boundingSphere.radius = p_nRadius;
}
sandy.core.scenegraph.Sprite2D.prototype.__class__ = sandy.core.scenegraph.Sprite2D;
sandy.core.scenegraph.Sprite2D.__interfaces__ = [sandy.core.scenegraph.IDisplayable];
sandy.bounds = {}
sandy.bounds.BBox = function(p_min,p_max) { if( p_min === $_ ) return; {
	this.uptodate = false;
	this.min = ((p_min != null)?p_min:new sandy.core.data.Vector(-0.5,-0.5,-0.5));
	this.max = ((p_max != null)?p_max:new sandy.core.data.Vector(0.5,0.5,0.5));
	this.tmin = new sandy.core.data.Vector();
	this.tmax = new sandy.core.data.Vector();
	this.aCorners = new Array();
	this.aTCorners = new Array();
	this.__computeCorners(false);
}}
sandy.bounds.BBox.__name__ = ["sandy","bounds","BBox"];
sandy.bounds.BBox.create = function(p_aVertices) {
	if(p_aVertices.length == 0) return null;
	var l = p_aVertices.length;
	var l_min = new sandy.core.data.Vector();
	var l_max = new sandy.core.data.Vector();
	var lTmp = [];
	var t = p_aVertices.copy();
	t.sort(function(a,b) {
		return ((a.x > b.x)?1:(a.x < b.x?-1:0));
	});
	{
		var _g1 = 0, _g = t.length;
		while(_g1 < _g) {
			var i = _g1++;
			lTmp.push(i);
		}
	}
	l_min.x = p_aVertices[lTmp[0]].x;
	l_max.x = p_aVertices[lTmp[lTmp.length - 1]].x;
	var t1 = p_aVertices.copy();
	t1.sort(function(a,b) {
		return ((a.y > b.y)?1:(a.y < b.y?-1:0));
	});
	{
		var _g1 = 0, _g = t1.length;
		while(_g1 < _g) {
			var i = _g1++;
			lTmp.push(i);
		}
	}
	l_min.y = p_aVertices[lTmp[0]].y;
	l_max.y = p_aVertices[lTmp[lTmp.length - 1]].y;
	var t2 = p_aVertices.copy();
	t2.sort(function(a,b) {
		return ((a.z > b.z)?1:(a.z < b.z?-1:0));
	});
	{
		var _g1 = 0, _g = t2.length;
		while(_g1 < _g) {
			var i = _g1++;
			lTmp.push(i);
		}
	}
	l_min.z = p_aVertices[lTmp[0]].z;
	l_max.z = p_aVertices[lTmp[lTmp.length - 1]].z;
	return new sandy.bounds.BBox(l_min,l_max);
}
sandy.bounds.BBox.prototype.__computeCorners = function(p_bRecalcVertices) {
	p_bRecalcVertices = ((p_bRecalcVertices != null)?p_bRecalcVertices:false);
	var minx, miny, minz, maxx, maxy, maxz;
	if(p_bRecalcVertices == true) {
		minx = this.tmin.x;
		miny = this.tmin.y;
		minz = this.tmin.z;
		maxx = this.tmax.x;
		maxy = this.tmax.y;
		maxz = this.tmax.z;
	}
	else {
		minx = this.min.x;
		miny = this.min.y;
		minz = this.min.z;
		maxx = this.max.x;
		maxy = this.max.y;
		maxz = this.max.z;
	}
	this.aTCorners[0] = new sandy.core.data.Vector();
	this.aCorners[0] = new sandy.core.data.Vector((minx),(maxy),(maxz));
	this.aTCorners[1] = new sandy.core.data.Vector();
	this.aCorners[1] = new sandy.core.data.Vector((maxx),(maxy),(maxz));
	this.aTCorners[2] = new sandy.core.data.Vector();
	this.aCorners[2] = new sandy.core.data.Vector((maxx),(miny),(maxz));
	this.aTCorners[3] = new sandy.core.data.Vector();
	this.aCorners[3] = new sandy.core.data.Vector((minx),(miny),(maxz));
	this.aTCorners[4] = new sandy.core.data.Vector();
	this.aCorners[4] = new sandy.core.data.Vector((minx),(maxy),(minz));
	this.aTCorners[5] = new sandy.core.data.Vector();
	this.aCorners[5] = new sandy.core.data.Vector((maxx),(maxy),(minz));
	this.aTCorners[6] = new sandy.core.data.Vector();
	this.aCorners[6] = new sandy.core.data.Vector((maxx),(miny),(minz));
	this.aTCorners[7] = new sandy.core.data.Vector();
	this.aCorners[7] = new sandy.core.data.Vector((minx),(miny),(minz));
	return this.aCorners;
}
sandy.bounds.BBox.prototype.aCorners = null;
sandy.bounds.BBox.prototype.aTCorners = null;
sandy.bounds.BBox.prototype.clone = function() {
	var l_oBBox = new sandy.bounds.BBox();
	l_oBBox.max = this.max.clone();
	l_oBBox.min = this.min.clone();
	l_oBBox.tmax = this.tmax.clone();
	l_oBBox.tmin = this.tmin.clone();
	return l_oBBox;
}
sandy.bounds.BBox.prototype.getCenter = function() {
	return new sandy.core.data.Vector((this.max.x + this.min.x) / 2,(this.max.y + this.min.y) / 2,(this.max.z + this.min.z) / 2);
}
sandy.bounds.BBox.prototype.getSize = function() {
	return new sandy.core.data.Vector(Math.abs(this.max.x - this.min.x),Math.abs(this.max.y - this.min.y),Math.abs(this.max.z - this.min.z));
}
sandy.bounds.BBox.prototype.max = null;
sandy.bounds.BBox.prototype.min = null;
sandy.bounds.BBox.prototype.tmax = null;
sandy.bounds.BBox.prototype.tmin = null;
sandy.bounds.BBox.prototype.toString = function() {
	return "sandy.bounds.BBox";
}
sandy.bounds.BBox.prototype.transform = function(p_oMatrix) {
	this.aTCorners[0].copy(this.aCorners[0]);
	p_oMatrix.vectorMult(this.aTCorners[0]);
	this.tmin.copy(this.aTCorners[0]);
	this.tmax.copy(this.tmin);
	var lVector;
	{
		var _g = 1;
		while(_g < 8) {
			var lId = _g++;
			this.aTCorners[lId].copy(this.aCorners[lId]);
			p_oMatrix.vectorMult(this.aTCorners[lId]);
			lVector = this.aTCorners[lId];
			if(lVector.x < this.tmin.x) this.tmin.x = lVector.x;
			else if(lVector.x > this.tmax.x) this.tmax.x = lVector.x;
			if(lVector.y < this.tmin.y) this.tmin.y = lVector.y;
			else if(lVector.y > this.tmax.y) this.tmax.y = lVector.y;
			if(lVector.z < this.tmin.z) this.tmin.z = lVector.z;
			else if(lVector.z > this.tmax.z) this.tmax.z = lVector.z;
		}
	}
	this.uptodate = true;
}
sandy.bounds.BBox.prototype.uptodate = null;
sandy.bounds.BBox.prototype.__class__ = sandy.bounds.BBox;
neash.text.FontManager = function() { }
neash.text.FontManager.__name__ = ["neash","text","FontManager"];
neash.text.FontManager.GetFont = function(inFace,inHeight) {
	var id = inFace + ":" + inHeight;
	var font = neash.text.FontManager.mFontMap.get(inFace);
	if(font == null) {
		var swf_font = neash.text.FontManager.mSWFFonts.get(inFace);
		if(swf_font != null) {
			font = new neash.swf.ScaledFont(swf_font,inHeight);
		}
		else {
			var native_font = new neash.text.NativeFont(inFace,inHeight);
			if(native_font.Ok()) font = native_font;
		}
		if(font != null) neash.text.FontManager.mFontMap.set(id,font);
	}
	return font;
}
neash.text.FontManager.RegisterFont = function(inFont) {
	neash.text.FontManager.mSWFFonts.set(inFont.GetName(),inFont);
}
neash.text.FontManager.prototype.__class__ = neash.text.FontManager;
sandy.math.FastMath = function(p) { if( p === $_ ) return; {
	this.sinTable = new Array();
	this.tanTable = new Array();
	this.RAD_SLICE = sandy.math.FastMath.TWO_PI / sandy.math.FastMath.PRECISION;
}}
sandy.math.FastMath.__name__ = ["sandy","math","FastMath"];
sandy.math.FastMath._initialized = null;
sandy.math.FastMath.initialized = function() {
	if(sandy.math.FastMath._initialized == null) sandy.math.FastMath._initialized = sandy.math.FastMath.initialize();
	return true;
}
sandy.math.FastMath.initialize = function() {
	var rad = 0;
	var inst = new sandy.math.FastMath();
	{
		var _g1 = 0, _g = sandy.math.FastMath.PRECISION;
		while(_g1 < _g) {
			var i = _g1++;
			rad = i * inst.RAD_SLICE;
			inst.sinTable[i] = Math.sin(rad);
			inst.tanTable[i] = Math.tan(rad);
		}
	}
	return inst;
}
sandy.math.FastMath.radToIndex = function(radians) {
	return Std["int"](Std["int"](radians * sandy.math.FastMath.PRECISION_DIV_2PI) & (sandy.math.FastMath.PRECISION_S));
}
sandy.math.FastMath.sin = function(radians) {
	return sandy.math.FastMath._initialized.sinTable[Std["int"](sandy.math.FastMath.radToIndex(radians))];
}
sandy.math.FastMath.cos = function(radians) {
	return sandy.math.FastMath._initialized.sinTable[Std["int"](sandy.math.FastMath.radToIndex(sandy.math.FastMath.HALF_PI - radians))];
}
sandy.math.FastMath.tan = function(radians) {
	return sandy.math.FastMath._initialized.tanTable[(sandy.math.FastMath.radToIndex(radians))];
}
sandy.math.FastMath.prototype.RAD_SLICE = null;
sandy.math.FastMath.prototype.sinTable = null;
sandy.math.FastMath.prototype.tanTable = null;
sandy.math.FastMath.prototype.__class__ = sandy.math.FastMath;
StringBuf = function(p) { if( p === $_ ) return; {
	this.b = "";
}}
StringBuf.__name__ = ["StringBuf"];
StringBuf.prototype.add = function(x) {
	this.b += x;
}
StringBuf.prototype.addChar = function(c) {
	this.b += String.fromCharCode(c);
}
StringBuf.prototype.addSub = function(s,pos,len) {
	this.b += s.substr(pos,len);
}
StringBuf.prototype.b = null;
StringBuf.prototype.toString = function() {
	return this.b;
}
StringBuf.prototype.__class__ = StringBuf;
sandy.core.data.PrimitiveFace = function(p_iPrimitive) { if( p_iPrimitive === $_ ) return; {
	this.aPolygons = new Array();
	this.m_iPrimitive = p_iPrimitive;
}}
sandy.core.data.PrimitiveFace.__name__ = ["sandy","core","data","PrimitiveFace"];
sandy.core.data.PrimitiveFace.prototype.__getAppearance = function() {
	return this.m_oAppearance;
}
sandy.core.data.PrimitiveFace.prototype.__getPrimitive = function() {
	return this.m_iPrimitive;
}
sandy.core.data.PrimitiveFace.prototype.__setAppearance = function(p_oApp) {
	this.m_oAppearance = p_oApp;
	if(this.m_iPrimitive.__getGeometry() != null) {
		{
			var _g = 0, _g1 = this.aPolygons;
			while(_g < _g1.length) {
				var v = _g1[_g];
				++_g;
				v.__setAppearance(this.m_oAppearance);
			}
		}
	}
	return p_oApp;
}
sandy.core.data.PrimitiveFace.prototype.aPolygons = null;
sandy.core.data.PrimitiveFace.prototype.addPolygon = function(p_oPolyId) {
	this.aPolygons.push(this.m_iPrimitive.aPolygons[p_oPolyId]);
}
sandy.core.data.PrimitiveFace.prototype.appearance = null;
sandy.core.data.PrimitiveFace.prototype.m_iPrimitive = null;
sandy.core.data.PrimitiveFace.prototype.m_oAppearance = null;
sandy.core.data.PrimitiveFace.prototype.primitive = null;
sandy.core.data.PrimitiveFace.prototype.__class__ = sandy.core.data.PrimitiveFace;
canvas.display.JointStyle = { __ename__ : ["canvas","display","JointStyle"], __constructs__ : ["MITER","ROUND","BEVEL"] }
canvas.display.JointStyle.BEVEL = ["BEVEL",2];
canvas.display.JointStyle.BEVEL.toString = $estr;
canvas.display.JointStyle.BEVEL.__enum__ = canvas.display.JointStyle;
canvas.display.JointStyle.MITER = ["MITER",0];
canvas.display.JointStyle.MITER.toString = $estr;
canvas.display.JointStyle.MITER.__enum__ = canvas.display.JointStyle;
canvas.display.JointStyle.ROUND = ["ROUND",1];
canvas.display.JointStyle.ROUND.toString = $estr;
canvas.display.JointStyle.ROUND.__enum__ = canvas.display.JointStyle;
canvas.KeyCode = function() { }
canvas.KeyCode.__name__ = ["canvas","KeyCode"];
canvas.KeyCode.prototype.__class__ = canvas.KeyCode;
haxe.Log = function() { }
haxe.Log.__name__ = ["haxe","Log"];
haxe.Log.trace = function(v,infos) {
	js.Boot.__trace(v,infos);
}
haxe.Log.clear = function() {
	js.Boot.__clear_trace();
}
haxe.Log.prototype.__class__ = haxe.Log;
neash.display.LoaderInfo = function(target) { if( target === $_ ) return; {
	neash.events.EventDispatcher.apply(this,[target]);
}}
neash.display.LoaderInfo.__name__ = ["neash","display","LoaderInfo"];
neash.display.LoaderInfo.__super__ = neash.events.EventDispatcher;
for(var k in neash.events.EventDispatcher.prototype ) neash.display.LoaderInfo.prototype[k] = neash.events.EventDispatcher.prototype[k];
neash.display.LoaderInfo.prototype.bytes = null;
neash.display.LoaderInfo.prototype.bytesLoaded = null;
neash.display.LoaderInfo.prototype.bytesTotal = null;
neash.display.LoaderInfo.prototype.childAllowsParent = null;
neash.display.LoaderInfo.prototype.content = null;
neash.display.LoaderInfo.prototype.contentType = null;
neash.display.LoaderInfo.prototype.frameRate = null;
neash.display.LoaderInfo.prototype.height = null;
neash.display.LoaderInfo.prototype.loader = null;
neash.display.LoaderInfo.prototype.loaderURL = null;
neash.display.LoaderInfo.prototype.parameters = null;
neash.display.LoaderInfo.prototype.parentAllowsChild = null;
neash.display.LoaderInfo.prototype.sameDomain = null;
neash.display.LoaderInfo.prototype.sharedEvents = null;
neash.display.LoaderInfo.prototype.url = null;
neash.display.LoaderInfo.prototype.width = null;
neash.display.LoaderInfo.prototype.__class__ = neash.display.LoaderInfo;
canvas.display.InterpolationMethod = { __ename__ : ["canvas","display","InterpolationMethod"], __constructs__ : ["RGB","LINEAR_RGB"] }
canvas.display.InterpolationMethod.LINEAR_RGB = ["LINEAR_RGB",1];
canvas.display.InterpolationMethod.LINEAR_RGB.toString = $estr;
canvas.display.InterpolationMethod.LINEAR_RGB.__enum__ = canvas.display.InterpolationMethod;
canvas.display.InterpolationMethod.RGB = ["RGB",0];
canvas.display.InterpolationMethod.RGB.toString = $estr;
canvas.display.InterpolationMethod.RGB.__enum__ = canvas.display.InterpolationMethod;
sandy.events.Shape3DEvent = function(e,p_oShape,p_oPolygon,p_oUV,p_oPoint3d,p_oEvent) { if( e === $_ ) return; {
	sandy.events.BubbleEvent.apply(this,[e,p_oShape]);
	this.shape = p_oShape;
	this.polygon = p_oPolygon;
	this.uv = p_oUV;
	this.point = p_oPoint3d;
	this.event = p_oEvent;
}}
sandy.events.Shape3DEvent.__name__ = ["sandy","events","Shape3DEvent"];
sandy.events.Shape3DEvent.__super__ = sandy.events.BubbleEvent;
for(var k in sandy.events.BubbleEvent.prototype ) sandy.events.Shape3DEvent.prototype[k] = sandy.events.BubbleEvent.prototype[k];
sandy.events.Shape3DEvent.prototype.event = null;
sandy.events.Shape3DEvent.prototype.point = null;
sandy.events.Shape3DEvent.prototype.polygon = null;
sandy.events.Shape3DEvent.prototype.shape = null;
sandy.events.Shape3DEvent.prototype.uv = null;
sandy.events.Shape3DEvent.prototype.__class__ = sandy.events.Shape3DEvent;
canvas.display.GfxPoint = function(inX,inY,inCX,inCY,inType) { if( inX === $_ ) return; {
	this.x = inX;
	this.y = inY;
	this.cx = inCX;
	this.cy = inCY;
	this.type = inType;
}}
canvas.display.GfxPoint.__name__ = ["canvas","display","GfxPoint"];
canvas.display.GfxPoint.prototype.cx = null;
canvas.display.GfxPoint.prototype.cy = null;
canvas.display.GfxPoint.prototype.type = null;
canvas.display.GfxPoint.prototype.x = null;
canvas.display.GfxPoint.prototype.y = null;
canvas.display.GfxPoint.prototype.__class__ = canvas.display.GfxPoint;
canvas.display.LineJob = function(inGrad,inPoint_idx0,inPoint_idx1,inThickness,inAlpha,inColour,inPixel_hinting,inJoints,inCaps,inScale_mode,inMiter_limit) { if( inGrad === $_ ) return; {
	this.grad = inGrad;
	this.point_idx0 = inPoint_idx0;
	this.point_idx1 = inPoint_idx1;
	this.thickness = inThickness;
	this.alpha = inAlpha;
	this.colour = inColour;
	this.pixel_hinting = inPixel_hinting;
	this.joints = inJoints;
	this.caps = inCaps;
	this.scale_mode = inScale_mode;
	this.miter_limit = inMiter_limit;
}}
canvas.display.LineJob.__name__ = ["canvas","display","LineJob"];
canvas.display.LineJob.prototype.alpha = null;
canvas.display.LineJob.prototype.caps = null;
canvas.display.LineJob.prototype.colour = null;
canvas.display.LineJob.prototype.grad = null;
canvas.display.LineJob.prototype.joints = null;
canvas.display.LineJob.prototype.miter_limit = null;
canvas.display.LineJob.prototype.pixel_hinting = null;
canvas.display.LineJob.prototype.point_idx0 = null;
canvas.display.LineJob.prototype.point_idx1 = null;
canvas.display.LineJob.prototype.scale_mode = null;
canvas.display.LineJob.prototype.thickness = null;
canvas.display.LineJob.prototype.__class__ = canvas.display.LineJob;
canvas.display.Graphics = function(inSurface) { if( inSurface === $_ ) return; {
	this.mChanged = false;
	if(inSurface == null) {
		var ctx = canvas.Manager.getScreen();
		this.mSurface = ctx;
	}
	else {
		this.mSurface = inSurface;
	}
	this.mLastMoveID = 0;
	this.clear();
}}
canvas.display.Graphics.__name__ = ["canvas","display","Graphics"];
canvas.display.Graphics.drawableCount = null;
canvas.display.Graphics.prototype.AddDrawable = function(inDrawable) {
	if(inDrawable == null) return;
	this.mChanged = true;
	this.mDrawList.unshift(inDrawable);
}
canvas.display.Graphics.prototype.AddLineSegment = function() {
	if(this.mCurrentLine.point_idx1 > 0) {
		this.mLineJobs.push(new canvas.display.LineJob(this.mCurrentLine.grad,this.mCurrentLine.point_idx0,this.mCurrentLine.point_idx1,this.mCurrentLine.thickness,this.mCurrentLine.alpha,this.mCurrentLine.pixel_hinting,this.mCurrentLine.colour,this.mCurrentLine.joints,this.mCurrentLine.caps,this.mCurrentLine.scale_mode,this.mCurrentLine.miter_limit));
	}
	this.mCurrentLine.point_idx0 = this.mCurrentLine.point_idx1 = -1;
}
canvas.display.Graphics.prototype.AddToMask = function(ioMask,inMatrix,inSurface) {
	if(this.mDrawList.length > 0) {
		throw "Not implemented: AddToMask";
	}
}
canvas.display.Graphics.prototype.CheckChanged = function() {
	this.ClosePolygon(true);
	var result = this.mChanged;
	this.mChanged = false;
	return result;
}
canvas.display.Graphics.prototype.ClearLine = function() {
	this.mCurrentLine = new canvas.display.LineJob(null,-1,-1,0.0,0.0,0,1,canvas.display.Graphics.CORNER_ROUND,canvas.display.Graphics.END_ROUND,canvas.display.Graphics.SCALE_NORMAL,3.0);
}
canvas.display.Graphics.prototype.ClosePolygon = function(inCancelFill) {
	var l = this.mPoints.length;
	if(l > 0) {
		if(l > 1) {
			if(this.mFilling && l > 2) {
				if(this.mPoints[this.mLastMoveID].x != this.mPoints[l - 1].x || this.mPoints[this.mLastMoveID].y != this.mPoints[l - 1].y) {
					this.lineTo(this.mPoints[this.mLastMoveID].x,this.mPoints[this.mLastMoveID].y);
				}
			}
			this.AddLineSegment();
			var drawable = { points : this.mPoints, fillColour : this.mFillColour, fillAlpha : this.mFillAlpha, solidGradient : this.mSolidGradient, bitmap : this.mBitmap, lineJobs : this.mLineJobs}
			this.AddDrawable(drawable);
		}
		this.mLineJobs = [];
		this.mPoints = [];
	}
	if(inCancelFill) {
		this.mFillAlpha = 0;
		this.mSolidGradient = null;
		this.mBitmap = null;
		this.mFilling = false;
	}
}
canvas.display.Graphics.prototype.CreateGradient = function(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio) {
	var points = new Array();
	{
		var _g1 = 0, _g = colors.length;
		while(_g1 < _g) {
			var i = _g1++;
			points.push({ col : colors[i], alpha : alphas[i], ratio : ratios[i]});
		}
	}
	var flags = 0;
	if(type == canvas.display.GradientType.RADIAL) flags |= canvas.display.Graphics.RADIAL;
	if(spreadMethod == canvas.display.SpreadMethod.REPEAT) flags |= canvas.display.Graphics.REPEAT;
	else if(spreadMethod == canvas.display.SpreadMethod.REFLECT) flags |= canvas.display.Graphics.REFLECT;
	if(matrix == null) {
		matrix = new canvas.geom.Matrix();
		matrix.createGradientBox(25,25);
	}
	else matrix = matrix.clone();
	var focal = (focalPointRatio == null?0:focalPointRatio);
	return { points : points, matrix : matrix, flags : flags, focal : focal}
}
canvas.display.Graphics.prototype.CreateMask = function(inMatrix) {
	throw "Not implemented: CreateMask";
}
canvas.display.Graphics.prototype.GetExtent = function(inMatrix) {
	this.flush();
	var result = new canvas.geom.Rectangle();
	throw "Not implemented: GetExtent";
	return result;
}
canvas.display.Graphics.prototype.SetSurface = function(inSurface) {
	this.mSurface = inSurface;
}
canvas.display.Graphics.prototype.beginBitmapFill = function(bitmap,matrix,in_repeat,in_smooth) {
	this.ClosePolygon(true);
	var repeat = (in_repeat == null?true:in_repeat);
	var smooth = (in_smooth == null?false:in_smooth);
	this.mFilling = true;
	this.mSolidGradient = null;
	this.mBitmap = { texture_buffer : bitmap.handle(), matrix : (matrix == null?matrix:matrix.clone()), flags : ((repeat?canvas.display.Graphics.BMP_REPEAT:0)) | ((smooth?canvas.display.Graphics.BMP_SMOOTH:0))}
}
canvas.display.Graphics.prototype.beginFill = function(color,alpha) {
	this.ClosePolygon(true);
	this.mFillColour = color;
	this.mFillAlpha = (alpha == null?1.0:alpha);
	this.mFilling = true;
	this.mSolidGradient = null;
	this.mBitmap = null;
}
canvas.display.Graphics.prototype.beginGradientFill = function(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio) {
	this.ClosePolygon(true);
	this.mFilling = true;
	this.mBitmap = null;
	this.mSolidGradient = this.CreateGradient(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio);
}
canvas.display.Graphics.prototype.blit = function(inTexture) {
	this.ClosePolygon(true);
	var ctx = this.mSurface;
	ctx.drawImage(inTexture.handle(),this.mPenX,this.mPenY);
}
canvas.display.Graphics.prototype.clear = function() {
	this.mChanged = true;
	this.mPenX = 0.0;
	this.mPenY = 0.0;
	this.mDrawList = new Array();
	this.mPoints = [];
	this.mSolidGradient = null;
	this.mFilling = false;
	this.mFillColour = 0;
	this.mFillAlpha = 0.0;
	this.mLastMoveID = 0;
	this.ClearLine();
	this.mLineJobs = [];
}
canvas.display.Graphics.prototype.curveTo = function(inCX,inCY,inX,inY) {
	var pid = this.mPoints.length;
	if(pid == 0) {
		this.mPoints.push(new canvas.display.GfxPoint(this.mPenX,this.mPenY,0.0,0.0,canvas.display.Graphics.MOVE));
		pid++;
	}
	this.mPenX = inX;
	this.mPenY = inY;
	this.mPoints.push(new canvas.display.GfxPoint(inX,inY,inCX,inCY,canvas.display.Graphics.CURVE));
	if(this.mCurrentLine.grad != null || this.mCurrentLine.alpha > 0) {
		if(this.mCurrentLine.point_idx0 < 0) this.mCurrentLine.point_idx0 = pid - 1;
		this.mCurrentLine.point_idx1 = pid;
	}
}
canvas.display.Graphics.prototype.drawCircle = function(x,y,rad) {
	this.drawEllipse(x,y,rad,rad);
}
canvas.display.Graphics.prototype.drawEllipse = function(x,y,rx,ry) {
	this.ClosePolygon(false);
	this.moveTo(x + rx,y);
	this.curveTo(rx + x,-0.4142 * ry + y,0.7071 * rx + x,-0.7071 * ry + y);
	this.curveTo(0.4142 * rx + x,-ry + y,x,-ry + y);
	this.curveTo(-0.4142 * rx + x,-ry + y,-0.7071 * rx + x,-0.7071 * ry + y);
	this.curveTo(-rx + x,-0.4142 * ry + y,-rx + x,y);
	this.curveTo(-rx + x,0.4142 * ry + y,-0.7071 * rx + x,0.7071 * ry + y);
	this.curveTo(-0.4142 * rx + x,ry + y,x,ry + y);
	this.curveTo(0.4142 * rx + x,ry + y,0.7071 * rx + x,0.7071 * ry + y);
	this.curveTo(rx + x,0.4142 * ry + y,rx + x,y);
	this.ClosePolygon(false);
}
canvas.display.Graphics.prototype.drawRect = function(x,y,width,height) {
	this.ClosePolygon(false);
	this.moveTo(x,y);
	this.lineTo(x + width,y);
	this.lineTo(x + width,y + height);
	this.lineTo(x,y + height);
	this.lineTo(x,y);
	this.ClosePolygon(false);
}
canvas.display.Graphics.prototype.drawRoundRect = function(x,y,width,height,ellipseWidth,ellipseHeight) {
	if(ellipseHeight < 1 || ellipseHeight < 1) {
		this.drawRect(x,y,width,height);
		return;
	}
	this.ClosePolygon(false);
	this.moveTo(x,y + ellipseHeight);
	this.curveTo(x,y,x + ellipseWidth,y);
	this.lineTo(x + width - ellipseWidth,y);
	this.curveTo(x + width,y,x + width,y + ellipseWidth);
	this.lineTo(x + width,y + height - ellipseHeight);
	this.curveTo(x + width,y + height,x + width - ellipseWidth,y + height);
	this.lineTo(x + ellipseWidth,y + height);
	this.curveTo(x,y + height,x,y + height - ellipseHeight);
	this.lineTo(x,y + ellipseHeight);
	this.ClosePolygon(false);
}
canvas.display.Graphics.prototype.endFill = function() {
	this.ClosePolygon(true);
}
canvas.display.Graphics.prototype.flush = function() {
	this.ClosePolygon(true);
}
canvas.display.Graphics.prototype.hitTest = function(inX,inY) {
	{
		var _g = 0, _g1 = this.mDrawList;
		while(_g < _g1.length) {
			var obj = _g1[_g];
			++_g;
			throw "Not implemented: hitTest";
		}
	}
	return false;
}
canvas.display.Graphics.prototype.lineGradientStyle = function(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio) {
	this.mCurrentLine.grad = this.CreateGradient(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio);
}
canvas.display.Graphics.prototype.lineStyle = function(thickness,color,alpha,pixelHinting,scaleMode,caps,joints,miterLimit) {
	this.AddLineSegment();
	if(thickness == null) {
		this.ClearLine();
		return;
	}
	else {
		this.mCurrentLine.grad = null;
		this.mCurrentLine.thickness = Math.round(thickness);
		this.mCurrentLine.colour = (color == null?0:color);
		this.mCurrentLine.alpha = (alpha == null?1.0:alpha);
		this.mCurrentLine.miter_limit = (miterLimit == null?3.0:miterLimit);
		this.mCurrentLine.pixel_hinting = ((pixelHinting == null || !pixelHinting)?0:canvas.display.Graphics.PIXEL_HINTING);
	}
	if(caps != null) {
		switch(caps) {
		case canvas.display.CapsStyle.ROUND:{
			this.mCurrentLine.caps = canvas.display.Graphics.END_ROUND;
		}break;
		case canvas.display.CapsStyle.SQUARE:{
			this.mCurrentLine.caps = canvas.display.Graphics.END_SQUARE;
		}break;
		case canvas.display.CapsStyle.NONE:{
			this.mCurrentLine.caps = canvas.display.Graphics.END_NONE;
		}break;
		}
	}
	this.mCurrentLine.scale_mode = canvas.display.Graphics.SCALE_NORMAL;
	if(scaleMode != null) {
		switch(scaleMode) {
		case canvas.display.LineScaleMode.NORMAL:{
			this.mCurrentLine.scale_mode = canvas.display.Graphics.SCALE_NORMAL;
		}break;
		case canvas.display.LineScaleMode.VERTICAL:{
			this.mCurrentLine.scale_mode = canvas.display.Graphics.SCALE_VERTICAL;
		}break;
		case canvas.display.LineScaleMode.HORIZONTAL:{
			this.mCurrentLine.scale_mode = canvas.display.Graphics.SCALE_HORIZONTAL;
		}break;
		case canvas.display.LineScaleMode.NONE:{
			this.mCurrentLine.scale_mode = canvas.display.Graphics.SCALE_NONE;
		}break;
		}
	}
	this.mCurrentLine.joints = canvas.display.Graphics.CORNER_ROUND;
	if(joints != null) {
		switch(joints) {
		case canvas.display.JointStyle.ROUND:{
			this.mCurrentLine.joints = canvas.display.Graphics.CORNER_ROUND;
		}break;
		case canvas.display.JointStyle.MITER:{
			this.mCurrentLine.joints = canvas.display.Graphics.CORNER_MITER;
		}break;
		case canvas.display.JointStyle.BEVEL:{
			this.mCurrentLine.joints = canvas.display.Graphics.CORNER_BEVEL;
		}break;
		}
	}
}
canvas.display.Graphics.prototype.lineTo = function(inX,inY) {
	var pid = this.mPoints.length;
	if(pid == 0) {
		this.mPoints.push(new canvas.display.GfxPoint(this.mPenX,this.mPenY,0.0,0.0,canvas.display.Graphics.MOVE));
		pid++;
	}
	this.mPenX = inX;
	this.mPenY = inY;
	this.mPoints.push(new canvas.display.GfxPoint(this.mPenX,this.mPenY,0.0,0.0,canvas.display.Graphics.LINE));
}
canvas.display.Graphics.prototype.mBitmap = null;
canvas.display.Graphics.prototype.mChanged = null;
canvas.display.Graphics.prototype.mCurrentLine = null;
canvas.display.Graphics.prototype.mDrawList = null;
canvas.display.Graphics.prototype.mFillAlpha = null;
canvas.display.Graphics.prototype.mFillColour = null;
canvas.display.Graphics.prototype.mFilling = null;
canvas.display.Graphics.prototype.mLastMoveID = null;
canvas.display.Graphics.prototype.mLineDraws = null;
canvas.display.Graphics.prototype.mLineJobs = null;
canvas.display.Graphics.prototype.mPenX = null;
canvas.display.Graphics.prototype.mPenY = null;
canvas.display.Graphics.prototype.mPoints = null;
canvas.display.Graphics.prototype.mSolid = null;
canvas.display.Graphics.prototype.mSolidGradient = null;
canvas.display.Graphics.prototype.mSurface = null;
canvas.display.Graphics.prototype.moveTo = function(inX,inY) {
	this.mPenX = inX;
	this.mPenY = inY;
	if(!this.mFilling) {
		this.ClosePolygon(false);
	}
	else {
		this.AddLineSegment();
		this.mLastMoveID = this.mPoints.length;
		this.mPoints.push(new canvas.display.GfxPoint(this.mPenX,this.mPenY,0.0,0.0,canvas.display.Graphics.MOVE));
	}
}
canvas.display.Graphics.prototype.render = function(inMatrix,inSurface,inMaskHandle,inScrollRect) {
	this.ClosePolygon(true);
	var ctx = canvas.Manager.getScreen();
	ctx.clearRect(0,0,200,200);
	ctx.translate(inMatrix.tx,inMatrix.ty);
	{
		var _g = 0, _g1 = this.mDrawList;
		while(_g < _g1.length) {
			var d = _g1[_g];
			++_g;
			ctx.save();
			ctx.beginPath();
			{
				var _g2 = 0, _g3 = d.points;
				while(_g2 < _g3.length) {
					var p = _g3[_g2];
					++_g2;
					switch(p.type) {
					case canvas.display.Graphics.MOVE:{
						ctx.moveTo(p.x,p.y);
					}break;
					case canvas.display.Graphics.CURVE:{
						ctx.quadraticCurveTo(p.cx,p.cy,p.x,p.y);
					}break;
					default:{
						ctx.lineTo(p.x,p.y);
					}break;
					}
				}
			}
			ctx.closePath();
			var lineJob = d.lineJobs[0];
			if(lineJob != null) {
				ctx.strokeStyle = "rgba(0,0,0,1)";
				ctx.stroke();
			}
			var fillColour = d.fillColour;
			if(fillColour != 0) {
				ctx.fillStyle = "#" + StringTools.hex(fillColour,6);
				ctx.fill();
			}
			ctx.restore();
			var bitmap = d.bitmap;
			if(bitmap != null) {
				ctx.save();
				ctx.clip();
				var img = bitmap.texture_buffer;
				var matrix = bitmap.matrix;
				try {
					ctx.setTransform(matrix.a,matrix.b,matrix.c,matrix.d,matrix.tx,matrix.ty);
				}
				catch( $e25 ) {
					{
						var e = $e25;
						{
							var svd = canvas.geom.Decompose.singularValueDecomposition(matrix);
							ctx.translate(svd.dx,svd.dy);
							ctx.rotate(-svd.angle1);
							ctx.scale(svd.sx,svd.sy);
							ctx.rotate(-svd.angle2);
						}
					}
				}
				ctx.drawImage(img,0,0);
				ctx.restore();
			}
		}
	}
	ctx.translate(-inMatrix.tx,-inMatrix.ty);
}
canvas.display.Graphics.prototype.__class__ = canvas.display.Graphics;
sandy.math.ColorMath = function() { }
sandy.math.ColorMath.__name__ = ["sandy","math","ColorMath"];
sandy.math.ColorMath.applyAlpha = function(c,a) {
	var a0 = Std["int"](c / 16777216);
	return (c & 16777215) + Math.floor(a * a0) * 16777216;
}
sandy.math.ColorMath.rgb2hex = function(r,g,b) {
	return (((r << 16) | (g << 8)) | b);
}
sandy.math.ColorMath.hex2rgb = function(hex) {
	var r;
	var g;
	var b;
	r = (16711680 & hex) >> 16;
	g = (65280 & hex) >> 8;
	b = (255 & hex);
	return { r : r, g : g, b : b}
}
sandy.math.ColorMath.hex2rgbn = function(hex) {
	var r;
	var g;
	var b;
	r = (16711680 & hex) >> 16;
	g = (65280 & hex) >> 8;
	b = (255 & hex);
	return { r : r / 255, g : g / 255, b : b / 255}
}
sandy.math.ColorMath.calculateLitColour = function(col,lightStrength) {
	var r = (col >> 16) & 255;
	var g = (col >> 8) & 255;
	var b = (col) & 255;
	r *= 0.00390625;
	g *= 0.00390625;
	b *= 0.00390625;
	var min = 0.0, mid = 0.0, max = 0.0, delta = 0.0;
	var l = 0.0, s = 0.0, h = 0.0, F = 0.0, n = 0;
	var a = [r,g,b];
	a.sort(function(a1,b1) {
		return (((a1 > b1)?1:((a1 < b1)?-1:0)));
	});
	min = a[0];
	mid = a[1];
	max = a[2];
	var range = max - min;
	l = (min + max) * 0.5;
	if(l == 0) {
		s = 1;
	}
	else {
		delta = range * 0.5;
		if(l < 0.5) {
			s = delta / l;
		}
		else {
			s = delta / (1 - l);
		}
		if(range != 0) {
			while(true) {
				if(r == max) {
					if(b == min) n = 0;
					else n = 5;
					break;
				}
				if(g == max) {
					if(b == min) n = 1;
					else n = 2;
					break;
				}
				if(r == min) n = 3;
				else n = 4;
				break;
			}
			if((n % 2) == 0) {
				F = mid - min;
			}
			else {
				F = max - mid;
			}
			F = F / range;
			h = 60 * (n + F);
		}
	}
	if(lightStrength < 0.5) {
		delta = s * lightStrength;
	}
	else {
		delta = s * (1 - lightStrength);
	}
	min = lightStrength - delta;
	max = lightStrength + delta;
	n = Math.floor(h / 60);
	F = (h - n * 60) * delta / 30;
	n %= 6;
	var mu = min + F;
	var md = max - F;
	switch(n) {
	case 0:{
		r = max;
		g = mu;
		b = min;
	}break;
	case 1:{
		r = md;
		g = max;
		b = min;
	}break;
	case 2:{
		r = min;
		g = max;
		b = mu;
	}break;
	case 3:{
		r = min;
		g = md;
		b = max;
	}break;
	case 4:{
		r = mu;
		g = min;
		b = max;
	}break;
	case 5:{
		r = max;
		g = min;
		b = md;
	}break;
	}
	return ((Std["int"](r * 256) << 16 | Std["int"](g * 256) << 8) | Std["int"](b * 256));
}
sandy.math.ColorMath.prototype.__class__ = sandy.math.ColorMath;
haxe.xml = {}
haxe.xml.Filter = { __ename__ : ["haxe","xml","Filter"], __constructs__ : ["FInt","FBool","FEnum","FReg"] }
haxe.xml.Filter.FBool = ["FBool",1];
haxe.xml.Filter.FBool.toString = $estr;
haxe.xml.Filter.FBool.__enum__ = haxe.xml.Filter;
haxe.xml.Filter.FEnum = function(values) { var $x = ["FEnum",2,values]; $x.__enum__ = haxe.xml.Filter; $x.toString = $estr; return $x; }
haxe.xml.Filter.FInt = ["FInt",0];
haxe.xml.Filter.FInt.toString = $estr;
haxe.xml.Filter.FInt.__enum__ = haxe.xml.Filter;
haxe.xml.Filter.FReg = function(matcher) { var $x = ["FReg",3,matcher]; $x.__enum__ = haxe.xml.Filter; $x.toString = $estr; return $x; }
haxe.xml.Attrib = { __ename__ : ["haxe","xml","Attrib"], __constructs__ : ["Att"] }
haxe.xml.Attrib.Att = function(name,filter,defvalue) { var $x = ["Att",0,name,filter,defvalue]; $x.__enum__ = haxe.xml.Attrib; $x.toString = $estr; return $x; }
haxe.xml.Rule = { __ename__ : ["haxe","xml","Rule"], __constructs__ : ["RNode","RData","RMulti","RList","RChoice","ROptional"] }
haxe.xml.Rule.RChoice = function(choices) { var $x = ["RChoice",4,choices]; $x.__enum__ = haxe.xml.Rule; $x.toString = $estr; return $x; }
haxe.xml.Rule.RData = function(filter) { var $x = ["RData",1,filter]; $x.__enum__ = haxe.xml.Rule; $x.toString = $estr; return $x; }
haxe.xml.Rule.RList = function(rules,ordered) { var $x = ["RList",3,rules,ordered]; $x.__enum__ = haxe.xml.Rule; $x.toString = $estr; return $x; }
haxe.xml.Rule.RMulti = function(rule,atLeastOne) { var $x = ["RMulti",2,rule,atLeastOne]; $x.__enum__ = haxe.xml.Rule; $x.toString = $estr; return $x; }
haxe.xml.Rule.RNode = function(name,attribs,childs) { var $x = ["RNode",0,name,attribs,childs]; $x.__enum__ = haxe.xml.Rule; $x.toString = $estr; return $x; }
haxe.xml.Rule.ROptional = function(rule) { var $x = ["ROptional",5,rule]; $x.__enum__ = haxe.xml.Rule; $x.toString = $estr; return $x; }
haxe.xml._Check = {}
haxe.xml._Check.CheckResult = { __ename__ : ["haxe","xml","_Check","CheckResult"], __constructs__ : ["CMatch","CMissing","CExtra","CElementExpected","CDataExpected","CExtraAttrib","CMissingAttrib","CInvalidAttrib","CInvalidData","CInElement"] }
haxe.xml._Check.CheckResult.CDataExpected = function(x) { var $x = ["CDataExpected",4,x]; $x.__enum__ = haxe.xml._Check.CheckResult; $x.toString = $estr; return $x; }
haxe.xml._Check.CheckResult.CElementExpected = function(name,x) { var $x = ["CElementExpected",3,name,x]; $x.__enum__ = haxe.xml._Check.CheckResult; $x.toString = $estr; return $x; }
haxe.xml._Check.CheckResult.CExtra = function(x) { var $x = ["CExtra",2,x]; $x.__enum__ = haxe.xml._Check.CheckResult; $x.toString = $estr; return $x; }
haxe.xml._Check.CheckResult.CExtraAttrib = function(att,x) { var $x = ["CExtraAttrib",5,att,x]; $x.__enum__ = haxe.xml._Check.CheckResult; $x.toString = $estr; return $x; }
haxe.xml._Check.CheckResult.CInElement = function(x,r) { var $x = ["CInElement",9,x,r]; $x.__enum__ = haxe.xml._Check.CheckResult; $x.toString = $estr; return $x; }
haxe.xml._Check.CheckResult.CInvalidAttrib = function(att,x,f) { var $x = ["CInvalidAttrib",7,att,x,f]; $x.__enum__ = haxe.xml._Check.CheckResult; $x.toString = $estr; return $x; }
haxe.xml._Check.CheckResult.CInvalidData = function(x,f) { var $x = ["CInvalidData",8,x,f]; $x.__enum__ = haxe.xml._Check.CheckResult; $x.toString = $estr; return $x; }
haxe.xml._Check.CheckResult.CMatch = ["CMatch",0];
haxe.xml._Check.CheckResult.CMatch.toString = $estr;
haxe.xml._Check.CheckResult.CMatch.__enum__ = haxe.xml._Check.CheckResult;
haxe.xml._Check.CheckResult.CMissing = function(r) { var $x = ["CMissing",1,r]; $x.__enum__ = haxe.xml._Check.CheckResult; $x.toString = $estr; return $x; }
haxe.xml._Check.CheckResult.CMissingAttrib = function(att,x) { var $x = ["CMissingAttrib",6,att,x]; $x.__enum__ = haxe.xml._Check.CheckResult; $x.toString = $estr; return $x; }
haxe.xml.Check = function() { }
haxe.xml.Check.__name__ = ["haxe","xml","Check"];
haxe.xml.Check.isBlank = function(x) {
	return (x.nodeType == Xml.PCData && haxe.xml.Check.blanks.match(x.getNodeValue())) || x.nodeType == Xml.Comment;
}
haxe.xml.Check.filterMatch = function(s,f) {
	var $e = (f);
	switch( $e[1] ) {
	case 0:
	{
		return haxe.xml.Check.filterMatch(s,haxe.xml.Filter.FReg(new EReg("[0-9]+","")));
	}break;
	case 1:
	{
		return haxe.xml.Check.filterMatch(s,haxe.xml.Filter.FEnum(["true","false","0","1"]));
	}break;
	case 2:
	var values = $e[2];
	{
		{
			var _g = 0;
			while(_g < values.length) {
				var v = values[_g];
				++_g;
				if(s == v) return true;
			}
		}
		return false;
	}break;
	case 3:
	var r = $e[2];
	{
		return r.match(s);
	}break;
	}
}
haxe.xml.Check.isNullable = function(r) {
	var $e = (r);
	switch( $e[1] ) {
	case 2:
	var one = $e[3], r1 = $e[2];
	{
		return (one != true || haxe.xml.Check.isNullable(r1));
	}break;
	case 3:
	var rl = $e[2];
	{
		{
			var _g = 0;
			while(_g < rl.length) {
				var r1 = rl[_g];
				++_g;
				if(!haxe.xml.Check.isNullable(r1)) return false;
			}
		}
		return true;
	}break;
	case 4:
	var rl = $e[2];
	{
		{
			var _g = 0;
			while(_g < rl.length) {
				var r1 = rl[_g];
				++_g;
				if(haxe.xml.Check.isNullable(r1)) return true;
			}
		}
		return false;
	}break;
	case 1:
	{
		return false;
	}break;
	case 0:
	{
		return false;
	}break;
	case 5:
	{
		return true;
	}break;
	}
}
haxe.xml.Check.check = function(x,r) {
	var $e = (r);
	switch( $e[1] ) {
	case 0:
	var childs = $e[4], attribs = $e[3], name = $e[2];
	{
		if(x.nodeType != Xml.Element || x.getNodeName() != name) return haxe.xml._Check.CheckResult.CElementExpected(name,x);
		var attribs1 = (attribs == null?new Array():attribs.copy());
		{ var $it26 = x.attributes();
		while( $it26.hasNext() ) { var xatt = $it26.next();
		{
			var found = false;
			{
				var _g = 0;
				while(_g < attribs1.length) {
					var att = attribs1[_g];
					++_g;
					var $e = (att);
					switch( $e[1] ) {
					case 0:
					var defvalue = $e[4], filter = $e[3], name1 = $e[2];
					{
						if(xatt != name1) continue;
						if(filter != null && !haxe.xml.Check.filterMatch(x.get(xatt),filter)) return haxe.xml._Check.CheckResult.CInvalidAttrib(name1,x,filter);
						attribs1.remove(att);
						found = true;
					}break;
					}
				}
			}
			if(!found) return haxe.xml._Check.CheckResult.CExtraAttrib(xatt,x);
		}
		}}
		{
			var _g = 0;
			while(_g < attribs1.length) {
				var att = attribs1[_g];
				++_g;
				var $e = (att);
				switch( $e[1] ) {
				case 0:
				var defvalue = $e[4], name1 = $e[2];
				{
					if(defvalue == null) return haxe.xml._Check.CheckResult.CMissingAttrib(name1,x);
				}break;
				}
			}
		}
		if(childs == null) childs = haxe.xml.Rule.RList([]);
		var m = haxe.xml.Check.checkList(x.iterator(),childs);
		if(m != haxe.xml._Check.CheckResult.CMatch) return haxe.xml._Check.CheckResult.CInElement(x,m);
		{
			var _g = 0;
			while(_g < attribs1.length) {
				var att = attribs1[_g];
				++_g;
				var $e = (att);
				switch( $e[1] ) {
				case 0:
				var defvalue = $e[4], name1 = $e[2];
				{
					x.set(name1,defvalue);
				}break;
				}
			}
		}
		return haxe.xml._Check.CheckResult.CMatch;
	}break;
	case 1:
	var filter = $e[2];
	{
		if(x.nodeType != Xml.PCData && x.nodeType != Xml.CData) return haxe.xml._Check.CheckResult.CDataExpected(x);
		if(filter != null && !haxe.xml.Check.filterMatch(x.getNodeValue(),filter)) return haxe.xml._Check.CheckResult.CInvalidData(x,filter);
		return haxe.xml._Check.CheckResult.CMatch;
	}break;
	case 4:
	var choices = $e[2];
	{
		if(choices.length == 0) throw "No choice possible";
		{
			var _g = 0;
			while(_g < choices.length) {
				var c = choices[_g];
				++_g;
				if(haxe.xml.Check.check(x,c) == haxe.xml._Check.CheckResult.CMatch) return haxe.xml._Check.CheckResult.CMatch;
			}
		}
		return haxe.xml.Check.check(x,choices[0]);
	}break;
	case 5:
	var r1 = $e[2];
	{
		return haxe.xml.Check.check(x,r1);
	}break;
	default:{
		throw "Unexpected " + Std.string(r);
	}break;
	}
}
haxe.xml.Check.checkList = function(it,r) {
	var $e = (r);
	switch( $e[1] ) {
	case 3:
	var ordered = $e[3], rules = $e[2];
	{
		var rules1 = rules.copy();
		{ var $it27 = it;
		while( $it27.hasNext() ) { var x = $it27.next();
		{
			if(haxe.xml.Check.isBlank(x)) continue;
			var found = false;
			{
				var _g = 0;
				while(_g < rules1.length) {
					var r1 = rules1[_g];
					++_g;
					var m = haxe.xml.Check.checkList([x].iterator(),r1);
					if(m == haxe.xml._Check.CheckResult.CMatch) {
						found = true;
						var $e = (r1);
						switch( $e[1] ) {
						case 2:
						var one = $e[3], rsub = $e[2];
						{
							if(one) {
								var i;
								{
									var _g2 = 0, _g1 = rules1.length;
									while(_g2 < _g1) {
										var i1 = _g2++;
										if(rules1[i1] == r1) rules1[i1] = haxe.xml.Rule.RMulti(rsub);
									}
								}
							}
						}break;
						default:{
							rules1.remove(r1);
						}break;
						}
						break;
					}
					else if(ordered && !haxe.xml.Check.isNullable(r1)) return m;
				}
			}
			if(!found) return haxe.xml._Check.CheckResult.CExtra(x);
		}
		}}
		{
			var _g = 0;
			while(_g < rules1.length) {
				var r1 = rules1[_g];
				++_g;
				if(!haxe.xml.Check.isNullable(r1)) return haxe.xml._Check.CheckResult.CMissing(r1);
			}
		}
		return haxe.xml._Check.CheckResult.CMatch;
	}break;
	case 2:
	var one = $e[3], r1 = $e[2];
	{
		var found = false;
		{ var $it28 = it;
		while( $it28.hasNext() ) { var x = $it28.next();
		{
			if(haxe.xml.Check.isBlank(x)) continue;
			var m = haxe.xml.Check.checkList([x].iterator(),r1);
			if(m != haxe.xml._Check.CheckResult.CMatch) return m;
			found = true;
		}
		}}
		if(one && !found) return haxe.xml._Check.CheckResult.CMissing(r1);
		return haxe.xml._Check.CheckResult.CMatch;
	}break;
	default:{
		var found = false;
		{ var $it29 = it;
		while( $it29.hasNext() ) { var x = $it29.next();
		{
			if(haxe.xml.Check.isBlank(x)) continue;
			var m = haxe.xml.Check.check(x,r);
			if(m != haxe.xml._Check.CheckResult.CMatch) return m;
			found = true;
			break;
		}
		}}
		if(!found) {
			var $e = (r);
			switch( $e[1] ) {
			case 5:
			{
				null;
			}break;
			default:{
				return haxe.xml._Check.CheckResult.CMissing(r);
			}break;
			}
		}
		{ var $it30 = it;
		while( $it30.hasNext() ) { var x = $it30.next();
		{
			if(haxe.xml.Check.isBlank(x)) continue;
			return haxe.xml._Check.CheckResult.CExtra(x);
		}
		}}
		return haxe.xml._Check.CheckResult.CMatch;
	}break;
	}
}
haxe.xml.Check.makeWhere = function(path) {
	if(path.length == 0) return "";
	var s = "In ";
	var first = true;
	{
		var _g = 0;
		while(_g < path.length) {
			var x = path[_g];
			++_g;
			if(first) first = false;
			else s += ".";
			s += x.getNodeName();
		}
	}
	return s + ": ";
}
haxe.xml.Check.makeString = function(x) {
	if(x.nodeType == Xml.Element) return "element " + x.getNodeName();
	var s = x.getNodeValue().split("\r").join("\\r").split("\n").join("\\n").split("\t").join("\\t");
	if(s.length > 20) return s.substr(0,17) + "...";
	return s;
}
haxe.xml.Check.makeRule = function(r) {
	var $e = (r);
	switch( $e[1] ) {
	case 0:
	var name = $e[2];
	{
		return "element " + name;
	}break;
	case 1:
	{
		return "data";
	}break;
	case 2:
	var r1 = $e[2];
	{
		return haxe.xml.Check.makeRule(r1);
	}break;
	case 3:
	var rules = $e[2];
	{
		return haxe.xml.Check.makeRule(rules[0]);
	}break;
	case 4:
	var choices = $e[2];
	{
		return haxe.xml.Check.makeRule(choices[0]);
	}break;
	case 5:
	var r1 = $e[2];
	{
		return haxe.xml.Check.makeRule(r1);
	}break;
	}
}
haxe.xml.Check.makeError = function(m,path) {
	if(path == null) path = new Array();
	var $e = (m);
	switch( $e[1] ) {
	case 0:
	{
		throw "assert";
	}break;
	case 1:
	var r = $e[2];
	{
		return haxe.xml.Check.makeWhere(path) + "Missing " + haxe.xml.Check.makeRule(r);
	}break;
	case 2:
	var x = $e[2];
	{
		return haxe.xml.Check.makeWhere(path) + "Unexpected " + haxe.xml.Check.makeString(x);
	}break;
	case 3:
	var x = $e[3], name = $e[2];
	{
		return haxe.xml.Check.makeWhere(path) + haxe.xml.Check.makeString(x) + " while expected element " + name;
	}break;
	case 4:
	var x = $e[2];
	{
		return haxe.xml.Check.makeWhere(path) + haxe.xml.Check.makeString(x) + " while data expected";
	}break;
	case 5:
	var x = $e[3], att = $e[2];
	{
		path.push(x);
		return haxe.xml.Check.makeWhere(path) + "unexpected attribute " + att;
	}break;
	case 6:
	var x = $e[3], att = $e[2];
	{
		path.push(x);
		return haxe.xml.Check.makeWhere(path) + "missing required attribute " + att;
	}break;
	case 7:
	var f = $e[4], x = $e[3], att = $e[2];
	{
		path.push(x);
		return haxe.xml.Check.makeWhere(path) + "invalid attribute value for " + att;
	}break;
	case 8:
	var f = $e[3], x = $e[2];
	{
		return haxe.xml.Check.makeWhere(path) + "invalid data format for " + haxe.xml.Check.makeString(x);
	}break;
	case 9:
	var m1 = $e[3], x = $e[2];
	{
		path.push(x);
		return haxe.xml.Check.makeError(m1,path);
	}break;
	}
}
haxe.xml.Check.checkNode = function(x,r) {
	var m = haxe.xml.Check.checkList([x].iterator(),r);
	if(m == haxe.xml._Check.CheckResult.CMatch) return;
	throw haxe.xml.Check.makeError(m);
}
haxe.xml.Check.checkDocument = function(x,r) {
	if(x.nodeType != Xml.Document) throw "Document expected";
	var m = haxe.xml.Check.checkList(x.iterator(),r);
	if(m == haxe.xml._Check.CheckResult.CMatch) return;
	throw haxe.xml.Check.makeError(m);
}
haxe.xml.Check.prototype.__class__ = haxe.xml.Check;
neash.swf.SWFStream = function(inStream) { if( inStream === $_ ) return; {
	this.mStream = inStream;
	var sig = String.fromCharCode(this.mStream.readUnsignedByte()) + String.fromCharCode(this.mStream.readUnsignedByte()) + String.fromCharCode(this.mStream.readUnsignedByte());
	var ver = this.mStream.readUnsignedByte();
	if(sig != "FWS" && sig != "CWS") throw "Invalid signature";
	if(ver > 9) throw ("unknown swf version");
	this.mVersion = ver;
	var length = inStream.readInt();
	if(sig == "CWS") {
		this.mStream = neash.utils.Uncompress.ConvertStream(this.mStream);
	}
	this.mBitPos = 0;
	this.mByteBuf = 0;
	this.mTagRead = 0;
}}
neash.swf.SWFStream.__name__ = ["neash","swf","SWFStream"];
neash.swf.SWFStream.prototype.AlignBits = function() {
	this.mBitPos = 0;
}
neash.swf.SWFStream.prototype.BeginTag = function() {
	var data = this.mStream.readUnsignedShort();
	var tag = data >> 6;
	var length = data & 63;
	if(tag >= neash.swf.Tags.LAST) return 0;
	if(length == 63) length = this.mStream.readUnsignedInt();
	this.mTagSize = length;
	this.mTagRead = 0;
	return tag;
}
neash.swf.SWFStream.prototype.Bits = function(inBits,inSigned) {
	var sign_bit = inBits - 1;
	var result = 0;
	var left = inBits;
	while(left != 0) {
		if(this.mBitPos == 0) {
			this.mByteBuf = this.mStream.readUnsignedByte();
			this.mTagRead++;
			this.mBitPos = 8;
		}
		while(this.mBitPos > 0 && left > 0) {
			result = ((result << 1) | ((this.mByteBuf >> 7) & 1));
			this.mBitPos--;
			left--;
			this.mByteBuf <<= 1;
		}
	}
	if(inSigned != null && inSigned) {
		var mask = (1 << sign_bit);
		if((result & mask) != 0) result -= (1 << inBits);
	}
	return result;
}
neash.swf.SWFStream.prototype.BytesLeft = function() {
	return this.mTagSize - this.mTagRead;
}
neash.swf.SWFStream.prototype.EndTag = function() {
	var read = this.mTagRead;
	var size = this.mTagSize;
	if(read > size) throw "tag read overflow";
	while(read < size) {
		this.mStream.readUnsignedByte();
		read++;
	}
}
neash.swf.SWFStream.prototype.Fixed = function(inBits) {
	return this.Bits(inBits,true) / 65536.0;
}
neash.swf.SWFStream.prototype.FrameRate = function() {
	return this.mStream.readUnsignedShort() / 256.0;
}
neash.swf.SWFStream.prototype.Frames = function() {
	return this.mStream.readUnsignedShort();
}
neash.swf.SWFStream.prototype.GetVersion = function() {
	return this.mVersion;
}
neash.swf.SWFStream.prototype.PopTag = function() {
	this.mTagRead = this.mPushTagSize;
	this.mTagSize = this.mPushTagSize;
}
neash.swf.SWFStream.prototype.PushTag = function() {
	this.mPushTagRead = this.mTagRead;
	this.mPushTagSize = this.mTagSize;
}
neash.swf.SWFStream.prototype.ReadAlign = function() {
	var a = this.ReadByte();
	switch(a) {
	case 0:{
		return neash.text.TextFormatAlign.LEFT;
	}break;
	case 1:{
		return neash.text.TextFormatAlign.RIGHT;
	}break;
	case 2:{
		return neash.text.TextFormatAlign.CENTER;
	}break;
	case 3:{
		return neash.text.TextFormatAlign.JUSTIFY;
	}break;
	}
	return neash.text.TextFormatAlign.LEFT;
}
neash.swf.SWFStream.prototype.ReadArraySize = function(inExtended) {
	this.mTagRead++;
	var result = this.mStream.readUnsignedByte();
	if(inExtended && result == 255) {
		this.mTagRead += 2;
		result = this.mStream.readUnsignedShort();
	}
	return result;
}
neash.swf.SWFStream.prototype.ReadBool = function() {
	return this.Bits(1) == 1;
}
neash.swf.SWFStream.prototype.ReadByte = function() {
	this.mTagRead++;
	return this.mStream.readUnsignedByte();
}
neash.swf.SWFStream.prototype.ReadBytes = function(inSize) {
	var buffer = this.mStream.readBytes(inSize);
	this.mTagRead += inSize;
	return buffer;
}
neash.swf.SWFStream.prototype.ReadCapsStyle = function() {
	switch(this.Bits(2)) {
	case 0:{
		return canvas.display.CapsStyle.ROUND;
	}break;
	case 1:{
		return canvas.display.CapsStyle.NONE;
	}break;
	case 2:{
		return canvas.display.CapsStyle.SQUARE;
	}break;
	}
	return canvas.display.CapsStyle.ROUND;
}
neash.swf.SWFStream.prototype.ReadColorTransform = function() {
	var result = new neash.geom.ColorTransform();
	var has_add = this.ReadBool();
	var has_mult = this.ReadBool();
	var bits = this.Bits(4);
	if(has_mult) {
		result.redMultiplier = this.Bits(bits,true);
		result.greenMultiplier = this.Bits(bits,true);
		result.blueMultiplier = this.Bits(bits,true);
	}
	if(has_add) {
		result.redOffset = this.Bits(bits,true);
		result.greenOffset = this.Bits(bits,true);
		result.blueOffset = this.Bits(bits,true);
	}
	return result;
}
neash.swf.SWFStream.prototype.ReadDepth = function() {
	this.mTagRead += 2;
	return this.mStream.readUnsignedShort();
}
neash.swf.SWFStream.prototype.ReadID = function() {
	this.mTagRead += 2;
	return this.mStream.readUnsignedShort();
}
neash.swf.SWFStream.prototype.ReadInt = function() {
	this.mTagRead += 4;
	return this.mStream.readInt();
}
neash.swf.SWFStream.prototype.ReadInterpolationMethod = function() {
	switch(this.Bits(2)) {
	case 0:{
		return canvas.display.InterpolationMethod.RGB;
	}break;
	case 1:{
		return canvas.display.InterpolationMethod.LINEAR_RGB;
	}break;
	}
	return canvas.display.InterpolationMethod.RGB;
}
neash.swf.SWFStream.prototype.ReadJoinStyle = function() {
	switch(this.Bits(2)) {
	case 0:{
		return canvas.display.JointStyle.ROUND;
	}break;
	case 1:{
		return canvas.display.JointStyle.BEVEL;
	}break;
	case 2:{
		return canvas.display.JointStyle.MITER;
	}break;
	}
	return canvas.display.JointStyle.ROUND;
}
neash.swf.SWFStream.prototype.ReadMatrix = function() {
	var result = new canvas.geom.Matrix();
	this.AlignBits();
	var has_scale = this.ReadBool();
	var scale_bits = (has_scale?this.Bits(5):0);
	result.a = (has_scale?this.Fixed(scale_bits):1.0);
	result.d = (has_scale?this.Fixed(scale_bits):1.0);
	var has_rotate = this.ReadBool();
	var rotate_bits = (has_rotate?this.Bits(5):0);
	result.b = (has_rotate?this.Fixed(rotate_bits):0.0);
	result.c = (has_rotate?this.Fixed(rotate_bits):0.0);
	var trans_bits = this.Bits(5);
	result.tx = this.Twips(trans_bits);
	result.ty = this.Twips(trans_bits);
	return result;
}
neash.swf.SWFStream.prototype.ReadPascalString = function() {
	var len = this.ReadByte();
	var result = "";
	{
		var _g = 0;
		while(_g < len) {
			var i = _g++;
			var c = this.ReadByte();
			if(c > 0) result += String.fromCharCode(c);
		}
	}
	return result;
}
neash.swf.SWFStream.prototype.ReadRGB = function() {
	this.mTagRead += 3;
	var r = this.mStream.readUnsignedByte();
	var g = this.mStream.readUnsignedByte();
	var b = this.mStream.readUnsignedByte();
	return ((r << 16) | (g << 8)) | b;
}
neash.swf.SWFStream.prototype.ReadRect = function() {
	this.AlignBits();
	var bits = this.Bits(5);
	var x0 = this.Twips(bits);
	var x1 = this.Twips(bits);
	var y0 = this.Twips(bits);
	var y1 = this.Twips(bits);
	return new canvas.geom.Rectangle(x0,y0,(x1 - x0),(y1 - y0));
}
neash.swf.SWFStream.prototype.ReadSI16 = function() {
	this.mTagRead += 2;
	return this.mStream.readShort();
}
neash.swf.SWFStream.prototype.ReadSTwips = function() {
	return this.ReadSI16() * 0.05;
}
neash.swf.SWFStream.prototype.ReadScaleMode = function() {
	switch(this.Bits(2)) {
	case 0:{
		return canvas.display.LineScaleMode.NORMAL;
	}break;
	case 1:{
		return canvas.display.LineScaleMode.HORIZONTAL;
	}break;
	case 2:{
		return canvas.display.LineScaleMode.VERTICAL;
	}break;
	case 3:{
		return canvas.display.LineScaleMode.NONE;
	}break;
	}
	return canvas.display.LineScaleMode.NORMAL;
}
neash.swf.SWFStream.prototype.ReadSpreadMethod = function() {
	switch(this.Bits(2)) {
	case 0:{
		return canvas.display.SpreadMethod.PAD;
	}break;
	case 1:{
		return canvas.display.SpreadMethod.REFLECT;
	}break;
	case 2:{
		return canvas.display.SpreadMethod.REPEAT;
	}break;
	case 3:{
		return canvas.display.SpreadMethod.PAD;
	}break;
	}
	return canvas.display.SpreadMethod.REPEAT;
}
neash.swf.SWFStream.prototype.ReadString = function() {
	var result = "";
	while(true) {
		var r = this.ReadByte();
		if(r == 0) return result;
		result += String.fromCharCode(r);
	}
	return result;
}
neash.swf.SWFStream.prototype.ReadUI16 = function() {
	this.mTagRead += 2;
	return this.mStream.readUnsignedShort();
}
neash.swf.SWFStream.prototype.ReadUTwips = function() {
	return this.ReadUI16() * 0.05;
}
neash.swf.SWFStream.prototype.Twips = function(inBits) {
	var val = this.Bits(inBits,true);
	return val * 0.05;
}
neash.swf.SWFStream.prototype.close = function() {
	this.mStream = null;
}
neash.swf.SWFStream.prototype.mBitPos = null;
neash.swf.SWFStream.prototype.mByteBuf = null;
neash.swf.SWFStream.prototype.mPushTagRead = null;
neash.swf.SWFStream.prototype.mPushTagSize = null;
neash.swf.SWFStream.prototype.mStream = null;
neash.swf.SWFStream.prototype.mTagRead = null;
neash.swf.SWFStream.prototype.mTagSize = null;
neash.swf.SWFStream.prototype.mVersion = null;
neash.swf.SWFStream.prototype.__class__ = neash.swf.SWFStream;
sandy.materials.ColorMaterial = function(p_nColor,p_nAlpha,p_oAttr) { if( p_nColor === $_ ) return; {
	if(p_nAlpha == null) p_nAlpha = 1.0;
	if(p_nColor == null) p_nColor = 0;
	sandy.materials.Material.apply(this,[p_oAttr]);
	this.m_oType = sandy.materials.MaterialType.COLOR;
	this.m_nColor = p_nColor;
	this.m_nAlpha = p_nAlpha;
}}
sandy.materials.ColorMaterial.__name__ = ["sandy","materials","ColorMaterial"];
sandy.materials.ColorMaterial.__super__ = sandy.materials.Material;
for(var k in sandy.materials.Material.prototype ) sandy.materials.ColorMaterial.prototype[k] = sandy.materials.Material.prototype[k];
sandy.materials.ColorMaterial.prototype.__getAlpha = function() {
	return this.m_nAlpha;
}
sandy.materials.ColorMaterial.prototype.__getColor = function() {
	return this.m_nColor;
}
sandy.materials.ColorMaterial.prototype.__setAlpha = function(p_nValue) {
	this.m_nAlpha = p_nValue;
	this.m_bModified = true;
	return p_nValue;
}
sandy.materials.ColorMaterial.prototype.__setColor = function(p_nValue) {
	this.m_nColor = p_nValue;
	this.m_bModified = true;
	return p_nValue;
}
sandy.materials.ColorMaterial.prototype.alpha = null;
sandy.materials.ColorMaterial.prototype.color = null;
sandy.materials.ColorMaterial.prototype.m_nAlpha = null;
sandy.materials.ColorMaterial.prototype.m_nColor = null;
sandy.materials.ColorMaterial.prototype.renderPolygon = function(p_oScene,p_oPolygon,p_mcContainer) {
	var l_points = ((p_oPolygon.isClipped)?p_oPolygon.cvertices:p_oPolygon.vertices);
	if(l_points.length == 0) return;
	var l_oVertex;
	var lId = l_points.length;
	var l_graphics = p_mcContainer.GetGraphics();
	l_graphics.lineStyle();
	l_graphics.beginFill(this.m_nColor,this.m_nAlpha);
	l_graphics.moveTo(l_points[0].sx,l_points[0].sy);
	while((l_oVertex = l_points[--lId]) != null) l_graphics.lineTo(l_oVertex.sx,l_oVertex.sy);
	l_graphics.endFill();
	if(this.attributes != null) this.attributes.draw(l_graphics,p_oPolygon,this,p_oScene);
}
sandy.materials.ColorMaterial.prototype.__class__ = sandy.materials.ColorMaterial;
sandy.materials.ColorMaterial.__interfaces__ = [sandy.materials.IAlphaMaterial];
sandy.view.Frustum = function(p) { if( p === $_ ) return; {
	this.aPlanes = new Array();
	this.aPoints = new Array();
	this.aNormals = new Array();
	this.aConstants = new Array();
}}
sandy.view.Frustum.__name__ = ["sandy","view","Frustum"];
sandy.view.Frustum.prototype.aConstants = null;
sandy.view.Frustum.prototype.aNormals = null;
sandy.view.Frustum.prototype.aPlanes = null;
sandy.view.Frustum.prototype.aPoints = null;
sandy.view.Frustum.prototype.boxInFrustum = function(box) {
	var result = sandy.view.Frustum.INSIDE;
	var out, iin, lDist;
	{
		var _g = 0, _g1 = this.aPlanes;
		while(_g < _g1.length) {
			var plane = _g1[_g];
			++_g;
			out = 0;
			iin = 0;
			{
				var _g2 = 0, _g3 = box.aTCorners;
				while(_g2 < _g3.length) {
					var v = _g3[_g2];
					++_g2;
					lDist = plane.a * v.x + plane.b * v.y + plane.c * v.z + plane.d;
					if(lDist < 0) {
						out++;
					}
					else {
						iin++;
					}
					if(iin > 0 && out > 0) {
						break;
					}
				}
			}
			if(iin == 0) {
				return sandy.view.Frustum.OUTSIDE;
			}
			else if(out > 0) {
				return sandy.view.Frustum.INTERSECT;
			}
		}
	}
	return result;
}
sandy.view.Frustum.prototype.clipFrontPlane = function(p_aCvert,p_aUVCoords) {
	if(p_aCvert.length <= 2) return;
	this.clipPolygon(this.aPlanes[0],p_aCvert,p_aUVCoords);
}
sandy.view.Frustum.prototype.clipFrustum = function(p_aCvert,p_aUVCoords) {
	if(p_aCvert.length <= 2) return;
	this.clipPolygon(this.aPlanes[0],p_aCvert,p_aUVCoords);
	if(p_aCvert.length <= 2) return;
	this.clipPolygon(this.aPlanes[3],p_aCvert,p_aUVCoords);
	if(p_aCvert.length <= 2) return;
	this.clipPolygon(this.aPlanes[2],p_aCvert,p_aUVCoords);
	if(p_aCvert.length <= 2) return;
	this.clipPolygon(this.aPlanes[5],p_aCvert,p_aUVCoords);
	if(p_aCvert.length <= 2) return;
	this.clipPolygon(this.aPlanes[4],p_aCvert,p_aUVCoords);
}
sandy.view.Frustum.prototype.clipLineFrontPlane = function(p_aCvert) {
	var l_oPlane = this.aPlanes[0];
	var tmp = p_aCvert.splice(0,p_aCvert.length);
	var v0 = tmp[0];
	var v1 = tmp[1];
	var l_nDist0 = l_oPlane.a * v0.wx + l_oPlane.b * v0.wy + l_oPlane.c * v0.wz + l_oPlane.d;
	var l_nDist1 = l_oPlane.a * v1.wx + l_oPlane.b * v1.wy + l_oPlane.c * v1.wz + l_oPlane.d;
	var d = 0;
	var t = new sandy.core.data.Vertex();
	if(l_nDist0 < 0 && l_nDist1 >= 0) {
		d = l_nDist0 / (l_nDist0 - l_nDist1);
		t.wx = (v0.wx + (v1.wx - v0.wx) * d);
		t.wy = (v0.wy + (v1.wy - v0.wy) * d);
		t.wz = (v0.wz + (v1.wz - v0.wz) * d);
		p_aCvert.push(t);
		p_aCvert.push(v1);
	}
	else if(l_nDist1 < 0 && l_nDist0 >= 0) {
		d = l_nDist0 / (l_nDist0 - l_nDist1);
		t.wx = (v0.wx + (v1.wx - v0.wx) * d);
		t.wy = (v0.wy + (v1.wy - v0.wy) * d);
		t.wz = (v0.wz + (v1.wz - v0.wz) * d);
		p_aCvert.push(v0);
		p_aCvert.push(t);
	}
	else if(l_nDist1 < 0 && l_nDist0 < 0) {
		p_aCvert = null;
	}
	else if(l_nDist1 > 0 && l_nDist0 > 0) {
		p_aCvert.push(v0);
		p_aCvert.push(v1);
	}
}
sandy.view.Frustum.prototype.clipPolygon = function(p_oPlane,p_aCvert,p_aUVCoords) {
	var allin = true, allout = true;
	var v;
	var i, l = p_aCvert.length, lDist;
	var aDist = new Array();
	{
		var _g = 0;
		while(_g < p_aCvert.length) {
			var v1 = p_aCvert[_g];
			++_g;
			lDist = p_oPlane.a * v1.wx + p_oPlane.b * v1.wy + p_oPlane.c * v1.wz + p_oPlane.d;
			if(lDist < 0) allin = false;
			if(lDist >= 0) allout = false;
			aDist.push(lDist);
		}
	}
	if(allin) {
		return;
	}
	else if(allout) {
		p_aCvert.splice(0,p_aCvert.length);
		p_aUVCoords.splice(0,p_aUVCoords.length);
		return;
	}
	var tmp = p_aCvert.splice(0,p_aCvert.length);
	var l_aTmpUv = p_aUVCoords.splice(0,p_aUVCoords.length);
	var l_oUV1 = l_aTmpUv[0], l_oUV2 = null, l_oUVTmp = null;
	var v1 = tmp[0], v2 = null, t = null;
	var d, dist2, dist1 = aDist[0];
	var clipped = false, inside = (dist1 >= 0);
	var curv = 0;
	{
		var _g1 = 1, _g = (l + 1);
		while(_g1 < _g) {
			var i1 = _g1++;
			v2 = tmp[i1 % l];
			l_oUV2 = l_aTmpUv[i1 % l];
			dist2 = aDist[i1 % l];
			if(inside && (dist2 >= 0)) {
				p_aCvert.push(v2);
				p_aUVCoords.push(l_oUV2);
			}
			else if((!inside) && (dist2 >= 0)) {
				clipped = inside = true;
				t = new sandy.core.data.Vertex();
				d = dist1 / (dist1 - dist2);
				t.wx = (v1.wx + (v2.wx - v1.wx) * d);
				t.wy = (v1.wy + (v2.wy - v1.wy) * d);
				t.wz = (v1.wz + (v2.wz - v1.wz) * d);
				p_aCvert.push(t);
				p_aCvert.push(v2);
				l_oUVTmp = new sandy.core.data.UVCoord();
				l_oUVTmp.u = (l_oUV1.u + (l_oUV2.u - l_oUV1.u) * d);
				l_oUVTmp.v = (l_oUV1.v + (l_oUV2.v - l_oUV1.v) * d);
				p_aUVCoords.push(l_oUVTmp);
				p_aUVCoords.push(l_oUV2);
			}
			else if(inside && (dist2 < 0)) {
				clipped = true;
				inside = false;
				t = new sandy.core.data.Vertex();
				d = dist1 / (dist1 - dist2);
				t.wx = (v1.wx + (v2.wx - v1.wx) * d);
				t.wy = (v1.wy + (v2.wy - v1.wy) * d);
				t.wz = (v1.wz + (v2.wz - v1.wz) * d);
				l_oUVTmp = new sandy.core.data.UVCoord();
				l_oUVTmp.u = (l_oUV1.u + (l_oUV2.u - l_oUV1.u) * d);
				l_oUVTmp.v = (l_oUV1.v + (l_oUV2.v - l_oUV1.v) * d);
				p_aUVCoords.push(l_oUVTmp);
				p_aCvert.push(t);
			}
			else {
				clipped = true;
			}
			v1 = v2;
			dist1 = dist2;
			l_oUV1 = l_oUV2;
		}
	}
	aDist = null;
}
sandy.view.Frustum.prototype.computePlanes = function(p_nAspect,p_nNear,p_nFar,p_nFov) {
	var lRadAngle = sandy.util.NumberUtil.toRadian(p_nFov);
	var tang = Math.tan(lRadAngle * 0.5);
	var yNear = -tang * p_nNear;
	var xNear = yNear * p_nAspect;
	var yFar = yNear * p_nFar / p_nNear;
	var xFar = xNear * p_nFar / p_nNear;
	p_nNear = -p_nNear;
	p_nFar = -p_nFar;
	var p = this.aPoints;
	p[0] = new sandy.core.data.Vector(xNear,yNear,p_nNear);
	p[1] = new sandy.core.data.Vector(xNear,-yNear,p_nNear);
	p[2] = new sandy.core.data.Vector(-xNear,-yNear,p_nNear);
	p[3] = new sandy.core.data.Vector(-xNear,yNear,p_nNear);
	p[4] = new sandy.core.data.Vector(xFar,yFar,p_nFar);
	p[5] = new sandy.core.data.Vector(xFar,-yFar,p_nFar);
	p[6] = new sandy.core.data.Vector(-xFar,-yFar,p_nFar);
	p[7] = new sandy.core.data.Vector(-xFar,yFar,p_nFar);
	this.aPlanes[3] = sandy.math.PlaneMath.computePlaneFromPoints(p[2],p[3],p[6]);
	this.aPlanes[2] = sandy.math.PlaneMath.computePlaneFromPoints(p[0],p[1],p[4]);
	this.aPlanes[4] = sandy.math.PlaneMath.computePlaneFromPoints(p[0],p[7],p[3]);
	this.aPlanes[5] = sandy.math.PlaneMath.computePlaneFromPoints(p[1],p[2],p[5]);
	this.aPlanes[0] = sandy.math.PlaneMath.computePlaneFromPoints(p[0],p[2],p[1]);
	this.aPlanes[1] = sandy.math.PlaneMath.computePlaneFromPoints(p[4],p[5],p[6]);
	{
		var _g = 0;
		while(_g < 6) {
			var i = _g++;
			sandy.math.PlaneMath.normalizePlane(this.aPlanes[i]);
		}
	}
}
sandy.view.Frustum.prototype.extractPlanes = function(comboMatrix,normalize) {
	this.aPlanes[0].a = comboMatrix.n14 + comboMatrix.n11;
	this.aPlanes[0].b = comboMatrix.n24 + comboMatrix.n21;
	this.aPlanes[0].c = comboMatrix.n34 + comboMatrix.n31;
	this.aPlanes[0].d = comboMatrix.n44 + comboMatrix.n41;
	this.aPlanes[1].a = comboMatrix.n14 - comboMatrix.n11;
	this.aPlanes[1].b = comboMatrix.n24 - comboMatrix.n21;
	this.aPlanes[1].c = comboMatrix.n34 - comboMatrix.n31;
	this.aPlanes[1].d = comboMatrix.n44 - comboMatrix.n41;
	this.aPlanes[2].a = comboMatrix.n14 - comboMatrix.n12;
	this.aPlanes[2].b = comboMatrix.n24 - comboMatrix.n22;
	this.aPlanes[2].c = comboMatrix.n34 - comboMatrix.n32;
	this.aPlanes[2].d = comboMatrix.n44 - comboMatrix.n42;
	this.aPlanes[3].a = comboMatrix.n14 + comboMatrix.n12;
	this.aPlanes[3].b = comboMatrix.n24 + comboMatrix.n22;
	this.aPlanes[3].c = comboMatrix.n34 + comboMatrix.n32;
	this.aPlanes[3].d = comboMatrix.n44 + comboMatrix.n42;
	this.aPlanes[4].a = comboMatrix.n13;
	this.aPlanes[4].b = comboMatrix.n23;
	this.aPlanes[4].c = comboMatrix.n33;
	this.aPlanes[4].d = comboMatrix.n43;
	this.aPlanes[5].a = comboMatrix.n14 - comboMatrix.n13;
	this.aPlanes[5].b = comboMatrix.n24 - comboMatrix.n23;
	this.aPlanes[5].c = comboMatrix.n34 - comboMatrix.n33;
	this.aPlanes[5].d = comboMatrix.n44 - comboMatrix.n43;
	if(normalize == true) {
		sandy.math.PlaneMath.normalizePlane(this.aPlanes[0]);
		sandy.math.PlaneMath.normalizePlane(this.aPlanes[1]);
		sandy.math.PlaneMath.normalizePlane(this.aPlanes[2]);
		sandy.math.PlaneMath.normalizePlane(this.aPlanes[3]);
		sandy.math.PlaneMath.normalizePlane(this.aPlanes[4]);
		sandy.math.PlaneMath.normalizePlane(this.aPlanes[5]);
	}
}
sandy.view.Frustum.prototype.pointInFrustum = function(p_oPoint) {
	{
		var _g = 0, _g1 = this.aPlanes;
		while(_g < _g1.length) {
			var plane = _g1[_g];
			++_g;
			if(sandy.math.PlaneMath.classifyPoint(plane,p_oPoint) == sandy.math.PlaneMath.NEGATIVE) {
				return sandy.view.Frustum.OUTSIDE;
			}
		}
	}
	return sandy.view.Frustum.INSIDE;
}
sandy.view.Frustum.prototype.sphereInFrustum = function(p_oS) {
	var d = 0, c = 0;
	var x = p_oS.position.x, y = p_oS.position.y, z = p_oS.position.z, radius = p_oS.radius;
	{
		var _g = 0, _g1 = this.aPlanes;
		while(_g < _g1.length) {
			var plane = _g1[_g];
			++_g;
			d = plane.a * x + plane.b * y + plane.c * z + plane.d;
			if(d <= -radius) {
				return sandy.view.Frustum.OUTSIDE;
			}
			if(d > radius) {
				c++;
			}
		}
	}
	return ((c == 6)?sandy.view.Frustum.INSIDE:sandy.view.Frustum.INTERSECT);
}
sandy.view.Frustum.prototype.__class__ = sandy.view.Frustum;
sandy.events.SandyEvent = function(type,bubbles,cancelable) { if( type === $_ ) return; {
	if(bubbles == null) bubbles = false;
	if(cancelable == null) cancelable = false;
	neash.events.Event.apply(this,[type,bubbles,cancelable]);
}}
sandy.events.SandyEvent.__name__ = ["sandy","events","SandyEvent"];
sandy.events.SandyEvent.__super__ = neash.events.Event;
for(var k in neash.events.Event.prototype ) sandy.events.SandyEvent.prototype[k] = neash.events.Event.prototype[k];
sandy.events.SandyEvent.prototype.clone = function() {
	return new sandy.events.SandyEvent(this.type,this.bubbles,this.cancelable);
}
sandy.events.SandyEvent.prototype.__class__ = sandy.events.SandyEvent;
Std = function() { }
Std.__name__ = ["Std"];
Std["is"] = function(v,t) {
	return js.Boot.__instanceof(v,t);
}
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
}
Std["int"] = function(x) {
	if(x < 0) return Math.ceil(x);
	return Math.floor(x);
}
Std.parseInt = function(x) {
	var v = parseInt(x);
	if(Math.isNaN(v)) return null;
	return v;
}
Std.parseFloat = function(x) {
	return parseFloat(x);
}
Std.random = function(x) {
	return Math.floor(Math.random() * x);
}
Std.prototype.__class__ = Std;
sandy.bounds.BSphere = function(p) { if( p === $_ ) return; {
	this.uptodate = false;
	this.center = new sandy.core.data.Vector();
	this.radius = 1;
	this.position = new sandy.core.data.Vector();
}}
sandy.bounds.BSphere.__name__ = ["sandy","bounds","BSphere"];
sandy.bounds.BSphere.create = function(p_aVertices) {
	var l_sphere = new sandy.bounds.BSphere();
	l_sphere.compute(p_aVertices);
	return l_sphere;
}
sandy.bounds.BSphere.prototype.center = null;
sandy.bounds.BSphere.prototype.compute = function(p_aVertices) {
	if(p_aVertices.length == 0) return;
	var x, y, z, d, i = 0, j = 0, l = p_aVertices.length;
	var p1 = p_aVertices[0].clone();
	var p2 = p_aVertices[0].clone();
	var dmax = 0;
	var pA, pB;
	while(i < l) {
		j = i + 1;
		while(j < l) {
			pA = p_aVertices[i];
			pB = p_aVertices[j];
			x = pB.x - pA.x;
			y = pB.y - pA.y;
			z = pB.z - pA.z;
			d = x * x + y * y + z * z;
			if(d > dmax) {
				dmax = d;
				p1.copy(pA);
				p2.copy(pB);
			}
			j += 1;
		}
		i += 1;
	}
	this.center = new sandy.core.data.Vector((p1.x + p2.x) / 2,(p1.y + p2.y) / 2,(p1.z + p2.z) / 2);
	this.radius = Math.sqrt(dmax) / 2;
}
sandy.bounds.BSphere.prototype.computeRadius = function(p_aPoints) {
	var x, y, z, d, dmax = 0;
	var i = 0, l = p_aPoints.length;
	while(i < l) {
		x = p_aPoints[(i)].x - this.center.x;
		y = p_aPoints[(i)].x - this.center.x;
		z = p_aPoints[(i)].x - this.center.x;
		d = x * x + y * y + z * z;
		if(d > dmax) dmax = d;
		i++;
	}
	return Math.sqrt(dmax);
}
sandy.bounds.BSphere.prototype.distance = function(p_oPoint) {
	var x = p_oPoint.x - this.center.x;
	var y = p_oPoint.y - this.center.y;
	var z = p_oPoint.z - this.center.z;
	return Math.sqrt(x * x + y * y + z * z) - this.radius;
}
sandy.bounds.BSphere.prototype.pointsOutofSphere = function(p_aPoints) {
	var r = new Array();
	var i = 0, l = p_aPoints.length;
	while(i < l) {
		if(this.distance(p_aPoints[(i)]) > 0) {
			r.push(p_aPoints[(i)]);
		}
		i++;
	}
	return r;
}
sandy.bounds.BSphere.prototype.position = null;
sandy.bounds.BSphere.prototype.radius = null;
sandy.bounds.BSphere.prototype.toString = function() {
	return "sandy.bounds.BSphere (center : " + this.center + ", radius : " + this.radius + ")";
}
sandy.bounds.BSphere.prototype.transform = function(p_oMatrix) {
	this.position.copy(this.center);
	p_oMatrix.vectorMult(this.position);
	this.uptodate = true;
}
sandy.bounds.BSphere.prototype.uptodate = null;
sandy.bounds.BSphere.prototype.__class__ = sandy.bounds.BSphere;
haxe.FastCell = function(elt,next) { if( elt === $_ ) return; {
	this.elt = elt;
	this.next = next;
}}
haxe.FastCell.__name__ = ["haxe","FastCell"];
haxe.FastCell.prototype.elt = null;
haxe.FastCell.prototype.next = null;
haxe.FastCell.prototype.__class__ = haxe.FastCell;
haxe.FastList = function(p) { if( p === $_ ) return; {
	null;
}}
haxe.FastList.__name__ = ["haxe","FastList"];
haxe.FastList.prototype.add = function(item) {
	this.head = new haxe.FastCell(item,this.head);
}
haxe.FastList.prototype.first = function() {
	return (this.head == null?null:this.head.elt);
}
haxe.FastList.prototype.head = null;
haxe.FastList.prototype.isEmpty = function() {
	return (this.head == null);
}
haxe.FastList.prototype.iterator = function() {
	var l = this.head;
	return { hasNext : function() {
		return l != null;
	}, next : function() {
		var k = l;
		l = k.next;
		return k.elt;
	}}
}
haxe.FastList.prototype.pop = function() {
	var k = this.head;
	if(k == null) return null;
	else {
		this.head = k.next;
		return k.elt;
	}
}
haxe.FastList.prototype.remove = function(v) {
	var prev = null;
	var l = this.head;
	while(l != null) {
		if(l.elt == v) {
			if(prev == null) this.head = l.next;
			else prev.next = l.next;
			break;
		}
		prev = l;
		l = l.next;
	}
	return (l != null);
}
haxe.FastList.prototype.toString = function() {
	var a = new Array();
	var l = this.head;
	while(l != null) {
		a.push(l.elt);
		l = l.next;
	}
	return "{" + a.join(",") + "}";
}
haxe.FastList.prototype.__class__ = haxe.FastList;
sandy.core.data.UVCoord = function(p_nU,p_nV) { if( p_nU === $_ ) return; {
	p_nU = ((p_nU != null)?p_nU:0);
	p_nV = ((p_nV != null)?p_nV:0);
	this.u = p_nU;
	this.v = p_nV;
}}
sandy.core.data.UVCoord.__name__ = ["sandy","core","data","UVCoord"];
sandy.core.data.UVCoord.prototype.add = function(p_oUV) {
	this.u += p_oUV.u;
	this.v += p_oUV.v;
}
sandy.core.data.UVCoord.prototype.clone = function() {
	return new sandy.core.data.UVCoord(this.u,this.v);
}
sandy.core.data.UVCoord.prototype.copy = function(p_oUV) {
	this.u = p_oUV.u;
	this.v = p_oUV.v;
}
sandy.core.data.UVCoord.prototype.length = function() {
	return Math.sqrt(this.u * this.u + this.v * this.v);
}
sandy.core.data.UVCoord.prototype.normalize = function() {
	var l_nLength = this.length();
	this.u /= l_nLength;
	this.v /= l_nLength;
}
sandy.core.data.UVCoord.prototype.scale = function(p_nFactor) {
	this.u *= p_nFactor;
	this.v *= p_nFactor;
}
sandy.core.data.UVCoord.prototype.sub = function(p_oUV) {
	this.u -= p_oUV.u;
	this.v -= p_oUV.v;
}
sandy.core.data.UVCoord.prototype.toString = function() {
	return "sandy.core.data.UVCoord" + "(u:" + this.u + ", v:" + this.v + ")";
}
sandy.core.data.UVCoord.prototype.u = null;
sandy.core.data.UVCoord.prototype.v = null;
sandy.core.data.UVCoord.prototype.__class__ = sandy.core.data.UVCoord;
sandy.core.data.Polygon = function(p_oOwner,p_geometry,p_aVertexID,p_aUVCoordsID,p_nFaceNormalID,p_nEdgesID) { if( p_oOwner === $_ ) return; {
	this.id = sandy.core.data.Polygon._ID_++;
	this.isClipped = false;
	this.aNeighboors = new Array();
	this.hasAppearanceChanged = false;
	this.m_oEB = new sandy.events.BubbleEventBroadcaster();
	this.mouseEvents = false;
	this.mouseInteractivity = false;
	if(p_aUVCoordsID == null) p_aUVCoordsID = [];
	p_nFaceNormalID = ((p_nFaceNormalID != null)?p_nFaceNormalID:0);
	p_nEdgesID = ((p_nEdgesID != null)?p_nEdgesID:0);
	this.shape = p_oOwner;
	this.m_oGeometry = p_geometry;
	this.__update(p_aVertexID,p_aUVCoordsID,p_nFaceNormalID,p_nEdgesID);
	this.m_oContainer = new neash.display.Sprite();
	sandy.core.data.Polygon.POLYGON_MAP.set(this.id,this);
}}
sandy.core.data.Polygon.__name__ = ["sandy","core","data","Polygon"];
sandy.core.data.Polygon.prototype.__getAppearance = function() {
	return this.m_oAppearance;
}
sandy.core.data.Polygon.prototype.__getBroadcaster = function() {
	return this.m_oEB;
}
sandy.core.data.Polygon.prototype.__getContainer = function() {
	return this.m_oContainer;
}
sandy.core.data.Polygon.prototype.__getDepth = function() {
	return this.m_nDepth;
}
sandy.core.data.Polygon.prototype.__getEnableEvents = function() {
	return this.mouseEvents;
}
sandy.core.data.Polygon.prototype.__getEnableInteractivity = function() {
	return this.mouseInteractivity;
}
sandy.core.data.Polygon.prototype.__setAppearance = function(p_oApp) {
	if(this.scene != null) {
		if(this.scene.materialManager.isRegistered(this.m_oAppearance.__getFrontMaterial())) this.scene.materialManager.unregister(this.m_oAppearance.__getFrontMaterial());
		if(this.scene.materialManager.isRegistered(this.m_oAppearance.__getBackMaterial())) this.scene.materialManager.unregister(this.m_oAppearance.__getBackMaterial());
	}
	if(this.m_oAppearance != null) {
		p_oApp.__getFrontMaterial().unlink(this);
		if(p_oApp.__getBackMaterial() != p_oApp.__getFrontMaterial()) p_oApp.__getBackMaterial().unlink(this);
	}
	this.m_oAppearance = p_oApp;
	p_oApp.__getFrontMaterial().init(this);
	if(p_oApp.__getBackMaterial() != p_oApp.__getFrontMaterial()) p_oApp.__getBackMaterial().init(this);
	this.hasAppearanceChanged = true;
	return p_oApp;
}
sandy.core.data.Polygon.prototype.__setDepth = function(p_nDepth) {
	this.m_nDepth = p_nDepth;
	return p_nDepth;
}
sandy.core.data.Polygon.prototype.__setEnableEvents = function(b) {
	if(b && !this.mouseEvents) {
		this.__getContainer().addEventListener(neash.events.MouseEvent.CLICK,$closure(this,"_onInteraction"));
		this.__getContainer().addEventListener(neash.events.MouseEvent.MOUSE_UP,$closure(this,"_onInteraction"));
		this.__getContainer().addEventListener(neash.events.MouseEvent.MOUSE_DOWN,$closure(this,"_onInteraction"));
		this.__getContainer().addEventListener(neash.events.MouseEvent.ROLL_OVER,$closure(this,"_onInteraction"));
		this.__getContainer().addEventListener(neash.events.MouseEvent.ROLL_OUT,$closure(this,"_onInteraction"));
		this.__getContainer().addEventListener(neash.events.MouseEvent.DOUBLE_CLICK,$closure(this,"_onInteraction"));
		this.__getContainer().addEventListener(neash.events.MouseEvent.MOUSE_MOVE,$closure(this,"_onInteraction"));
		this.__getContainer().addEventListener(neash.events.MouseEvent.MOUSE_OVER,$closure(this,"_onInteraction"));
		this.__getContainer().addEventListener(neash.events.MouseEvent.MOUSE_OUT,$closure(this,"_onInteraction"));
		this.__getContainer().addEventListener(neash.events.MouseEvent.MOUSE_WHEEL,$closure(this,"_onInteraction"));
	}
	else if(!b && this.mouseEvents) {
		this.__getContainer().removeEventListener(neash.events.MouseEvent.CLICK,$closure(this,"_onInteraction"));
		this.__getContainer().removeEventListener(neash.events.MouseEvent.MOUSE_UP,$closure(this,"_onInteraction"));
		this.__getContainer().removeEventListener(neash.events.MouseEvent.MOUSE_DOWN,$closure(this,"_onInteraction"));
		this.__getContainer().removeEventListener(neash.events.MouseEvent.ROLL_OVER,$closure(this,"_onInteraction"));
		this.__getContainer().removeEventListener(neash.events.MouseEvent.ROLL_OUT,$closure(this,"_onInteraction"));
		this.__getContainer().removeEventListener(neash.events.MouseEvent.DOUBLE_CLICK,$closure(this,"_onInteraction"));
		this.__getContainer().removeEventListener(neash.events.MouseEvent.MOUSE_MOVE,$closure(this,"_onInteraction"));
		this.__getContainer().removeEventListener(neash.events.MouseEvent.MOUSE_OVER,$closure(this,"_onInteraction"));
		this.__getContainer().removeEventListener(neash.events.MouseEvent.MOUSE_OUT,$closure(this,"_onInteraction"));
		this.__getContainer().removeEventListener(neash.events.MouseEvent.MOUSE_WHEEL,$closure(this,"_onInteraction"));
	}
	this.mouseEvents = b;
	return b;
}
sandy.core.data.Polygon.prototype.__setEnableInteractivity = function(p_bState) {
	if(p_bState != this.mouseInteractivity) {
		if(p_bState) {
			this.__getContainer().addEventListener(neash.events.MouseEvent.ROLL_OVER,$closure(this,"_startMouseInteraction"),false);
			this.__getContainer().addEventListener(neash.events.MouseEvent.ROLL_OUT,$closure(this,"_stopMouseInteraction"),false);
		}
		else {
			this._stopMouseInteraction();
		}
		this.mouseInteractivity = p_bState;
	}
	return p_bState;
}
sandy.core.data.Polygon.prototype.__update = function(p_aVertexID,p_aUVCoordsID,p_nFaceNormalID,p_nEdgeListID) {
	var i = 0, l;
	this.vertexNormals = new Array();
	this.vertices = new Array();
	{
		var _g = 0;
		while(_g < p_aVertexID.length) {
			var o = p_aVertexID[_g];
			++_g;
			this.vertices[i] = this.m_oGeometry.aVertex[p_aVertexID[i]];
			this.vertexNormals[i] = this.m_oGeometry.aVertexNormals[p_aVertexID[i]];
			i++;
		}
	}
	this.a = this.vertices[0];
	this.b = this.vertices[1];
	this.c = this.vertices[2];
	if(p_aUVCoordsID != null) {
		var l_nMinU = Math.POSITIVE_INFINITY, l_nMinV = Math.POSITIVE_INFINITY, l_nMaxU = Math.NEGATIVE_INFINITY, l_nMaxV = Math.NEGATIVE_INFINITY;
		this.aUVCoord = new Array();
		i = 0;
		{
			var _g = 0;
			while(_g < p_aUVCoordsID.length) {
				var p = p_aUVCoordsID[_g];
				++_g;
				var l_oUV = this.m_oGeometry.aUVCoords[p_aUVCoordsID[i]];
				this.aUVCoord[i] = l_oUV;
				if(l_oUV.u < l_nMinU) l_nMinU = l_oUV.u;
				else if(l_oUV.u > l_nMaxU) l_nMaxU = l_oUV.u;
				if(l_oUV.v < l_nMinV) l_nMinV = l_oUV.v;
				else if(l_oUV.v > l_nMaxV) l_nMaxV = l_oUV.v;
				i++;
			}
		}
		this.uvBounds = new canvas.geom.Rectangle(l_nMinU,l_nMinV,l_nMaxU - l_nMinU,l_nMaxV - l_nMinV);
	}
	this.normal = this.m_oGeometry.aFacesNormals[p_nFaceNormalID];
	if(this.normal == null) {
		var l_oNormal = this.createNormal();
		var l_nID = this.m_oGeometry.setFaceNormal(this.m_oGeometry.getNextFaceNormalID(),l_oNormal.x,l_oNormal.y,l_oNormal.z);
		this.normal = this.m_oGeometry.aFacesNormals[l_nID];
	}
	this.aEdges = new Array();
	{
		var _g = 0, _g1 = this.m_oGeometry.aFaceEdges[p_nEdgeListID];
		while(_g < _g1.length) {
			var l_nEdgeId = _g1[_g];
			++_g;
			var l_oEdge = this.m_oGeometry.aEdges[l_nEdgeId];
			l_oEdge.vertex1 = this.m_oGeometry.aVertex[l_oEdge.vertexId1];
			l_oEdge.vertex2 = this.m_oGeometry.aVertex[l_oEdge.vertexId2];
			this.aEdges.push(l_oEdge);
		}
	}
}
sandy.core.data.Polygon.prototype._onInteraction = function(p_oEvt) {
	var l_oClick = new canvas.geom.Point(this.m_oContainer.GetMouseX(),this.m_oContainer.GetMouseY());
	var l_oUV = this.getUVFrom2D(l_oClick);
	var l_oPt3d = this.get3DFrom2D(l_oClick);
	this.m_oEB.broadcastEvent(new sandy.events.Shape3DEvent(p_oEvt.type,this.shape,this,l_oUV,l_oPt3d,p_oEvt));
}
sandy.core.data.Polygon.prototype._onTextureInteraction = function(p_oEvt) {
	if(p_oEvt == null || !(Std["is"](p_oEvt,neash.events.MouseEvent))) p_oEvt = new neash.events.MouseEvent(neash.events.MouseEvent.MOUSE_MOVE,true,false,0,0,null,false,false,false,false,0);
	var pt2D = new canvas.geom.Point(this.scene.container.GetMouseX(),this.scene.container.GetMouseY());
	var uv = this.getUVFrom2D(pt2D);
	sandy.core.interaction.VirtualMouse.getInstance().interactWithTexture(this,uv,p_oEvt);
	this._onInteraction(p_oEvt);
}
sandy.core.data.Polygon.prototype._startMouseInteraction = function(e) {
	this.__getContainer().addEventListener(neash.events.MouseEvent.CLICK,$closure(this,"_onTextureInteraction"));
	this.__getContainer().addEventListener(neash.events.MouseEvent.MOUSE_UP,$closure(this,"_onTextureInteraction"));
	this.__getContainer().addEventListener(neash.events.MouseEvent.MOUSE_DOWN,$closure(this,"_onTextureInteraction"));
	this.__getContainer().addEventListener(neash.events.MouseEvent.DOUBLE_CLICK,$closure(this,"_onTextureInteraction"));
	this.__getContainer().addEventListener(neash.events.MouseEvent.MOUSE_MOVE,$closure(this,"_onTextureInteraction"));
	this.__getContainer().addEventListener(neash.events.MouseEvent.MOUSE_OVER,$closure(this,"_onTextureInteraction"));
	this.__getContainer().addEventListener(neash.events.MouseEvent.MOUSE_OUT,$closure(this,"_onTextureInteraction"));
	this.__getContainer().addEventListener(neash.events.MouseEvent.MOUSE_WHEEL,$closure(this,"_onTextureInteraction"));
	this.__getContainer().addEventListener(neash.events.KeyboardEvent.KEY_DOWN,$closure(this,"_onTextureInteraction"));
	this.__getContainer().addEventListener(neash.events.KeyboardEvent.KEY_UP,$closure(this,"_onTextureInteraction"));
	this.m_oContainer.addEventListener(neash.events.Event.ENTER_FRAME,$closure(this,"_onTextureInteraction"));
}
sandy.core.data.Polygon.prototype._stopMouseInteraction = function(e) {
	this.__getContainer().removeEventListener(neash.events.MouseEvent.CLICK,$closure(this,"_onTextureInteraction"));
	this.__getContainer().removeEventListener(neash.events.MouseEvent.MOUSE_UP,$closure(this,"_onTextureInteraction"));
	this.__getContainer().removeEventListener(neash.events.MouseEvent.MOUSE_DOWN,$closure(this,"_onTextureInteraction"));
	this.__getContainer().removeEventListener(neash.events.MouseEvent.DOUBLE_CLICK,$closure(this,"_onTextureInteraction"));
	this.__getContainer().removeEventListener(neash.events.MouseEvent.MOUSE_MOVE,$closure(this,"_onTextureInteraction"));
	this.__getContainer().removeEventListener(neash.events.MouseEvent.MOUSE_OVER,$closure(this,"_onTextureInteraction"));
	this.__getContainer().removeEventListener(neash.events.MouseEvent.MOUSE_OUT,$closure(this,"_onTextureInteraction"));
	this.__getContainer().removeEventListener(neash.events.MouseEvent.MOUSE_WHEEL,$closure(this,"_onTextureInteraction"));
	this.m_oContainer.removeEventListener(neash.events.Event.ENTER_FRAME,$closure(this,"_onTextureInteraction"));
	this.__getContainer().removeEventListener(neash.events.KeyboardEvent.KEY_DOWN,$closure(this,"_onTextureInteraction"));
	this.__getContainer().removeEventListener(neash.events.KeyboardEvent.KEY_UP,$closure(this,"_onTextureInteraction"));
}
sandy.core.data.Polygon.prototype.a = null;
sandy.core.data.Polygon.prototype.aEdges = null;
sandy.core.data.Polygon.prototype.aNeighboors = null;
sandy.core.data.Polygon.prototype.aUVCoord = null;
sandy.core.data.Polygon.prototype.addEventListener = function(p_sEvent,oL,arguments) {
	this.m_oEB.apply($closure(this.m_oEB,"addEventListener"),arguments);
}
sandy.core.data.Polygon.prototype.appearance = null;
sandy.core.data.Polygon.prototype.b = null;
sandy.core.data.Polygon.prototype.broadcaster = null;
sandy.core.data.Polygon.prototype.c = null;
sandy.core.data.Polygon.prototype.caUVCoord = null;
sandy.core.data.Polygon.prototype.clear = function() {
	this.m_oContainer.GetGraphics().clear();
}
sandy.core.data.Polygon.prototype.clip = function(p_oFrustum) {
	this.isClipped = true;
	if(this.vertices.length < 3) {
		this.clipFrontPlane(p_oFrustum);
	}
	else {
		this.cvertices = null;
		this.caUVCoord = null;
		this.cvertices = this.vertices.concat([]);
		this.caUVCoord = this.aUVCoord.concat([]);
		p_oFrustum.clipFrustum(this.cvertices,this.caUVCoord);
	}
	return this.cvertices;
}
sandy.core.data.Polygon.prototype.clipFrontPlane = function(p_oFrustum) {
	this.isClipped = true;
	this.cvertices = null;
	this.cvertices = this.vertices.concat([]);
	if(this.vertices.length < 3) {
		p_oFrustum.clipLineFrontPlane(this.cvertices);
	}
	else {
		this.caUVCoord = null;
		this.caUVCoord = this.aUVCoord.concat([]);
		p_oFrustum.clipFrontPlane(this.cvertices,this.caUVCoord);
	}
	return this.cvertices;
}
sandy.core.data.Polygon.prototype.container = null;
sandy.core.data.Polygon.prototype.createNormal = function() {
	if(this.vertices.length > 2) {
		var v, w;
		var a = this.vertices[0], b = this.vertices[1], c = this.vertices[2];
		v = new sandy.core.data.Vector(b.wx - a.wx,b.wy - a.wy,b.wz - a.wz);
		w = new sandy.core.data.Vector(b.wx - c.wx,b.wy - c.wy,b.wz - c.wz);
		var l_normal = sandy.math.VectorMath.cross(v,w);
		sandy.math.VectorMath.normalize(l_normal);
		return l_normal;
	}
	else {
		return new sandy.core.data.Vector();
	}
}
sandy.core.data.Polygon.prototype.cvertices = null;
sandy.core.data.Polygon.prototype.depth = null;
sandy.core.data.Polygon.prototype.destroy = function() {
	this.clear();
	if(this.m_oContainer.GetParent() != null) this.m_oContainer.GetParent().removeChild(this.m_oContainer);
	if(this.m_oContainer != null) this.m_oContainer = null;
	this.cvertices = null;
	this.vertices = null;
	this.m_oEB = null;
	sandy.core.data.Polygon.POLYGON_MAP.set(this.id,null);
}
sandy.core.data.Polygon.prototype.display = function(p_oScene,p_oContainer) {
	this.scene = p_oScene;
	var lCont = ((p_oContainer != null)?p_oContainer:this.m_oContainer);
	if(this.visible) {
		this.m_oAppearance.__getFrontMaterial().renderPolygon(p_oScene,this,lCont);
	}
	else {
		this.m_oAppearance.__getBackMaterial().renderPolygon(p_oScene,this,lCont);
	}
}
sandy.core.data.Polygon.prototype.enableEvents = null;
sandy.core.data.Polygon.prototype.enableInteractivity = null;
sandy.core.data.Polygon.prototype.get3DFrom2D = function(p_oScreenPoint) {
	var m1 = new canvas.geom.Matrix(this.vertices[1].sx - this.vertices[0].sx,this.vertices[2].sx - this.vertices[0].sx,this.vertices[1].sy - this.vertices[0].sy,this.vertices[2].sy - this.vertices[0].sy,0,0);
	m1.invert();
	var capA = m1.a * (p_oScreenPoint.x - this.vertices[0].sx) + m1.b * (p_oScreenPoint.y - this.vertices[0].sy);
	var capB = m1.c * (p_oScreenPoint.x - this.vertices[0].sx) + m1.d * (p_oScreenPoint.y - this.vertices[0].sy);
	var l_oPoint = new sandy.core.data.Vector(this.vertices[0].x + capA * (this.vertices[1].x - this.vertices[0].x) + capB * (this.vertices[2].x - this.vertices[0].x),this.vertices[0].y + capA * (this.vertices[1].y - this.vertices[0].y) + capB * (this.vertices[2].y - this.vertices[0].y),this.vertices[0].z + capA * (this.vertices[1].z - this.vertices[0].z) + capB * (this.vertices[2].z - this.vertices[0].z));
	this.shape.__getMatrix().vectorMult(l_oPoint);
	return l_oPoint;
}
sandy.core.data.Polygon.prototype.getUVFrom2D = function(p_oScreenPoint) {
	var p0 = new canvas.geom.Point(this.vertices[0].sx,this.vertices[0].sy);
	var p1 = new canvas.geom.Point(this.vertices[1].sx,this.vertices[1].sy);
	var p2 = new canvas.geom.Point(this.vertices[2].sx,this.vertices[2].sy);
	var u0 = this.aUVCoord[0];
	var u1 = this.aUVCoord[1];
	var u2 = this.aUVCoord[2];
	var v01 = new canvas.geom.Point(p1.x - p0.x,p1.y - p0.y);
	var vn01 = v01.clone();
	vn01.normalize(1);
	var v02 = new canvas.geom.Point(p2.x - p0.x,p2.y - p0.y);
	var vn02 = v02.clone();
	vn02.normalize(1);
	var v4 = new canvas.geom.Point(p_oScreenPoint.x - v01.x,p_oScreenPoint.y - v01.y);
	var l_oInter = sandy.math.IntersectionMath.intersectionLine2D(p0,p2,p_oScreenPoint,v4);
	var vi02 = new canvas.geom.Point(l_oInter.x - p0.x,l_oInter.y - p0.y);
	var vi01 = new canvas.geom.Point(p_oScreenPoint.x - l_oInter.x,p_oScreenPoint.y - l_oInter.y);
	var d1 = vi01.get_length() / v01.get_length();
	var d2 = vi02.get_length() / v02.get_length();
	return new sandy.core.data.UVCoord(u0.u + d1 * (u1.u - u0.u) + d2 * (u2.u - u0.u),u0.v + d1 * (u1.v - u0.v) + d2 * (u2.v - u0.v));
}
sandy.core.data.Polygon.prototype.hasAppearanceChanged = null;
sandy.core.data.Polygon.prototype.id = null;
sandy.core.data.Polygon.prototype.isClipped = null;
sandy.core.data.Polygon.prototype.m_aUVCoords = null;
sandy.core.data.Polygon.prototype.m_nDepth = null;
sandy.core.data.Polygon.prototype.m_oAppearance = null;
sandy.core.data.Polygon.prototype.m_oContainer = null;
sandy.core.data.Polygon.prototype.m_oEB = null;
sandy.core.data.Polygon.prototype.m_oGeometry = null;
sandy.core.data.Polygon.prototype.minZ = null;
sandy.core.data.Polygon.prototype.mouseEvents = null;
sandy.core.data.Polygon.prototype.mouseInteractivity = null;
sandy.core.data.Polygon.prototype.normal = null;
sandy.core.data.Polygon.prototype.precompute = function() {
	this.minZ = this.a.wz;
	if(this.b.wz < this.minZ) this.minZ = this.b.wz;
	if(this.c != null) {
		if(this.c.wz < this.minZ) this.minZ = this.c.wz;
		this.m_nDepth = 0.333 * (this.a.wz + this.b.wz + this.c.wz);
	}
	else {
		this.m_nDepth = 0.5 * (this.a.wz + this.b.wz);
	}
}
sandy.core.data.Polygon.prototype.removeEventListener = function(p_sEvent,oL) {
	this.m_oEB.removeEventListener(p_sEvent,oL);
}
sandy.core.data.Polygon.prototype.scene = null;
sandy.core.data.Polygon.prototype.shape = null;
sandy.core.data.Polygon.prototype.swapCulling = function() {
	this.normal.negate();
}
sandy.core.data.Polygon.prototype.toString = function() {
	return "sandy.core.data.Polygon::id=" + this.id + " [Points: " + this.vertices.length + "]";
}
sandy.core.data.Polygon.prototype.uvBounds = null;
sandy.core.data.Polygon.prototype.vertexNormals = null;
sandy.core.data.Polygon.prototype.vertices = null;
sandy.core.data.Polygon.prototype.visible = null;
sandy.core.data.Polygon.prototype.__class__ = sandy.core.data.Polygon;
sandy.core.data.Polygon.__interfaces__ = [sandy.core.scenegraph.IDisplayable];
sandy.core.scenegraph.TransformGroup = function(p_sName) { if( p_sName === $_ ) return; {
	if(p_sName == null) p_sName = "";
	sandy.core.scenegraph.ATransformable.apply(this,[p_sName]);
}}
sandy.core.scenegraph.TransformGroup.__name__ = ["sandy","core","scenegraph","TransformGroup"];
sandy.core.scenegraph.TransformGroup.__super__ = sandy.core.scenegraph.ATransformable;
for(var k in sandy.core.scenegraph.ATransformable.prototype ) sandy.core.scenegraph.TransformGroup.prototype[k] = sandy.core.scenegraph.ATransformable.prototype[k];
sandy.core.scenegraph.TransformGroup.prototype.clone = function(p_sName) {
	var l_oGroup = new sandy.core.scenegraph.TransformGroup(p_sName);
	{
		var _g = 0, _g1 = this.children;
		while(_g < _g1.length) {
			var l_oNode = _g1[_g];
			++_g;
			if(Std["is"](l_oNode,sandy.core.scenegraph.Shape3D) || Std["is"](l_oNode,sandy.core.scenegraph.Group) || Std["is"](l_oNode,sandy.core.scenegraph.TransformGroup)) {
				l_oGroup.addChild("clone".apply(l_oNode,[p_sName + "_" + l_oNode.name]));
			}
		}
	}
	return l_oGroup;
}
sandy.core.scenegraph.TransformGroup.prototype.cull = function(p_oScene,p_oFrustum,p_oViewMatrix,p_bChanged) {
	if(this.visible == false) {
		this.culled = sandy.view.CullingState.OUTSIDE;
	}
	else {
		var lChanged = p_bChanged || this.changed;
		{
			var _g = 0, _g1 = this.children;
			while(_g < _g1.length) {
				var l_oNode = _g1[_g];
				++_g;
				l_oNode.cull(p_oScene,p_oFrustum,p_oViewMatrix,lChanged);
			}
		}
	}
}
sandy.core.scenegraph.TransformGroup.prototype.render = function(p_oScene,p_oCamera) {
	var _g = 0, _g1 = this.children;
	while(_g < _g1.length) {
		var l_oNode = _g1[_g];
		++_g;
		if(l_oNode.culled != sandy.view.CullingState.OUTSIDE) l_oNode.render(p_oScene,p_oCamera);
		l_oNode.changed = false;
		l_oNode.culled = sandy.view.CullingState.INSIDE;
	}
}
sandy.core.scenegraph.TransformGroup.prototype.toString = function() {
	return "sandy.core.scenegraph.TransformGroup";
}
sandy.core.scenegraph.TransformGroup.prototype.__class__ = sandy.core.scenegraph.TransformGroup;
canvas.display.LineScaleMode = { __ename__ : ["canvas","display","LineScaleMode"], __constructs__ : ["HORIZONTAL","NONE","NORMAL","VERTICAL"] }
canvas.display.LineScaleMode.HORIZONTAL = ["HORIZONTAL",0];
canvas.display.LineScaleMode.HORIZONTAL.toString = $estr;
canvas.display.LineScaleMode.HORIZONTAL.__enum__ = canvas.display.LineScaleMode;
canvas.display.LineScaleMode.NONE = ["NONE",1];
canvas.display.LineScaleMode.NONE.toString = $estr;
canvas.display.LineScaleMode.NONE.__enum__ = canvas.display.LineScaleMode;
canvas.display.LineScaleMode.NORMAL = ["NORMAL",2];
canvas.display.LineScaleMode.NORMAL.toString = $estr;
canvas.display.LineScaleMode.NORMAL.__enum__ = canvas.display.LineScaleMode;
canvas.display.LineScaleMode.VERTICAL = ["VERTICAL",3];
canvas.display.LineScaleMode.VERTICAL.toString = $estr;
canvas.display.LineScaleMode.VERTICAL.__enum__ = canvas.display.LineScaleMode;
canvas.display.SpreadMethod = { __ename__ : ["canvas","display","SpreadMethod"], __constructs__ : ["REPEAT","REFLECT","PAD"] }
canvas.display.SpreadMethod.PAD = ["PAD",2];
canvas.display.SpreadMethod.PAD.toString = $estr;
canvas.display.SpreadMethod.PAD.__enum__ = canvas.display.SpreadMethod;
canvas.display.SpreadMethod.REFLECT = ["REFLECT",1];
canvas.display.SpreadMethod.REFLECT.toString = $estr;
canvas.display.SpreadMethod.REFLECT.__enum__ = canvas.display.SpreadMethod;
canvas.display.SpreadMethod.REPEAT = ["REPEAT",0];
canvas.display.SpreadMethod.REPEAT.toString = $estr;
canvas.display.SpreadMethod.REPEAT.__enum__ = canvas.display.SpreadMethod;
sandy.materials.MaterialManager = function(p) { if( p === $_ ) return; {
	this.m_aList = new Array();
}}
sandy.materials.MaterialManager.__name__ = ["sandy","materials","MaterialManager"];
sandy.materials.MaterialManager.prototype.begin = function(p_oScene) {
	var _g = 0, _g1 = this.m_aList;
	while(_g < _g1.length) {
		var l_oMaterial = _g1[_g];
		++_g;
		l_oMaterial.begin(p_oScene);
	}
}
sandy.materials.MaterialManager.prototype.finish = function(p_oScene) {
	var _g = 0, _g1 = this.m_aList;
	while(_g < _g1.length) {
		var l_oMaterial = _g1[_g];
		++_g;
		l_oMaterial.finish(p_oScene);
	}
}
sandy.materials.MaterialManager.prototype.isRegistered = function(p_oMaterial) {
	{
		var _g1 = 0, _g = this.m_aList.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.m_aList[i] == p_oMaterial) {
				return true;
			}
		}
	}
	return false;
}
sandy.materials.MaterialManager.prototype.m_aList = null;
sandy.materials.MaterialManager.prototype.register = function(p_oMaterial) {
	this.m_aList.push(p_oMaterial);
}
sandy.materials.MaterialManager.prototype.unregister = function(p_oMaterial) {
	var _g1 = 0, _g = this.m_aList.length;
	while(_g1 < _g) {
		var i = _g1++;
		if(this.m_aList[i] == p_oMaterial) {
			this.m_aList.splice(i,1);
			return;
		}
	}
}
sandy.materials.MaterialManager.prototype.__class__ = sandy.materials.MaterialManager;
haxe.io.Error = { __ename__ : ["haxe","io","Error"], __constructs__ : ["Blocked","Overflow","OutsideBounds","Custom"] }
haxe.io.Error.Blocked = ["Blocked",0];
haxe.io.Error.Blocked.toString = $estr;
haxe.io.Error.Blocked.__enum__ = haxe.io.Error;
haxe.io.Error.Custom = function(e) { var $x = ["Custom",3,e]; $x.__enum__ = haxe.io.Error; $x.toString = $estr; return $x; }
haxe.io.Error.OutsideBounds = ["OutsideBounds",2];
haxe.io.Error.OutsideBounds.toString = $estr;
haxe.io.Error.OutsideBounds.__enum__ = haxe.io.Error;
haxe.io.Error.Overflow = ["Overflow",1];
haxe.io.Error.Overflow.toString = $estr;
haxe.io.Error.Overflow.__enum__ = haxe.io.Error;
sandy.math.VectorMath = function() { }
sandy.math.VectorMath.__name__ = ["sandy","math","VectorMath"];
sandy.math.VectorMath.getNorm = function(p_oV) {
	return Math.sqrt(p_oV.x * p_oV.x + p_oV.y * p_oV.y + p_oV.z * p_oV.z);
}
sandy.math.VectorMath.negate = function(p_oV) {
	return new sandy.core.data.Vector(-p_oV.x,-p_oV.y,-p_oV.z);
}
sandy.math.VectorMath.addVector = function(p_oV,p_oW) {
	return new sandy.core.data.Vector(p_oV.x + p_oW.x,p_oV.y + p_oW.y,p_oV.z + p_oW.z);
}
sandy.math.VectorMath.sub = function(p_oV,p_oW) {
	return new sandy.core.data.Vector(p_oV.x - p_oW.x,p_oV.y - p_oW.y,p_oV.z - p_oW.z);
}
sandy.math.VectorMath.pow = function(p_oV,p_nExp) {
	return new sandy.core.data.Vector(Math.pow(p_oV.x,p_nExp),Math.pow(p_oV.y,p_nExp),Math.pow(p_oV.z,p_nExp));
}
sandy.math.VectorMath.scale = function(p_oV,n) {
	return new sandy.core.data.Vector(p_oV.x * n,p_oV.y * n,p_oV.z * n);
}
sandy.math.VectorMath.dot = function(p_oV,p_oW) {
	return (p_oV.x * p_oW.x + p_oV.y * p_oW.y + p_oW.z * p_oV.z);
}
sandy.math.VectorMath.cross = function(p_oW,p_oV) {
	return new sandy.core.data.Vector((p_oW.y * p_oV.z) - (p_oW.z * p_oV.y),(p_oW.z * p_oV.x) - (p_oW.x * p_oV.z),(p_oW.x * p_oV.y) - (p_oW.y * p_oV.x));
}
sandy.math.VectorMath.normalize = function(p_oV) {
	var norm = Math.sqrt(p_oV.x * p_oV.x + p_oV.y * p_oV.y + p_oV.z * p_oV.z);
	if(norm == 0 || norm == 1) {
		return false;
	}
	else {
		p_oV.x /= norm;
		p_oV.y /= norm;
		p_oV.z /= norm;
		return true;
	}
}
sandy.math.VectorMath.getAngle = function(p_oV,p_oW) {
	var ncos = sandy.math.VectorMath.dot(p_oV,p_oW) / (Math.sqrt(p_oV.x * p_oV.x + p_oV.y * p_oV.y + p_oV.z * p_oV.z) * Math.sqrt(p_oW.x * p_oW.x + p_oW.y * p_oW.y + p_oW.z * p_oW.z));
	var sin2 = 1 - ncos * ncos;
	if(sin2 < 0) {
		haxe.Log.trace(" wrong " + ncos,{ fileName : "VectorMath.hx", lineNumber : 177, className : "sandy.math.VectorMath", methodName : "getAngle"});
		sin2 = 0;
	}
	return Math.atan2(Math.sqrt(sin2),ncos);
}
sandy.math.VectorMath.sphrand = function(inner,outer) {
	var v = new sandy.core.data.Vector(Math.random() - .5,Math.random() - .5,Math.random() - .5);
	v.normalize();
	var r = Math.random();
	r = (outer - inner) * r + inner;
	v.scale(r);
	return v;
}
sandy.math.VectorMath.clone = function(p_oV) {
	return new sandy.core.data.Vector(p_oV.x,p_oV.y,p_oV.z);
}
sandy.math.VectorMath.prototype.__class__ = sandy.math.VectorMath;
neash.events.MouseEvent = function(type,bubbles,cancelable,in_localX,in_localY,in_relatedObject,in_ctrlKey,in_altKey,in_shiftKey,in_buttonDown,in_delta) { if( type === $_ ) return; {
	neash.events.Event.apply(this,[type,bubbles,cancelable]);
	this.shiftKey = (in_shiftKey == null?false:in_shiftKey);
	this.altKey = (in_altKey == null?false:in_altKey);
	this.ctrlKey = (in_ctrlKey == null?false:in_ctrlKey);
	bubbles = (in_buttonDown == null?false:in_buttonDown);
	this.relatedObject = in_relatedObject;
	this.delta = (in_delta == null?0:in_delta);
	this.localX = (in_localX == null?0:in_localX);
	this.localY = (in_localY == null?0:in_localY);
	this.buttonDown = (in_buttonDown == null?false:in_buttonDown);
}}
neash.events.MouseEvent.__name__ = ["neash","events","MouseEvent"];
neash.events.MouseEvent.__super__ = neash.events.Event;
for(var k in neash.events.Event.prototype ) neash.events.MouseEvent.prototype[k] = neash.events.Event.prototype[k];
neash.events.MouseEvent.prototype.GetMouseX = function() {
	return canvas.Manager.SmouseX();
}
neash.events.MouseEvent.prototype.GetMouseY = function() {
	return canvas.Manager.SmouseY();
}
neash.events.MouseEvent.prototype.altKey = null;
neash.events.MouseEvent.prototype.buttonDown = null;
neash.events.MouseEvent.prototype.ctrlKey = null;
neash.events.MouseEvent.prototype.delta = null;
neash.events.MouseEvent.prototype.localX = null;
neash.events.MouseEvent.prototype.localY = null;
neash.events.MouseEvent.prototype.relatedObject = null;
neash.events.MouseEvent.prototype.shiftKey = null;
neash.events.MouseEvent.prototype.stageX = null;
neash.events.MouseEvent.prototype.stageY = null;
neash.events.MouseEvent.prototype.updateAfterEvent = function() {
	null;
}
neash.events.MouseEvent.prototype.__class__ = neash.events.MouseEvent;
canvas.display.GradientType = { __ename__ : ["canvas","display","GradientType"], __constructs__ : ["RADIAL","LINEAR"] }
canvas.display.GradientType.LINEAR = ["LINEAR",1];
canvas.display.GradientType.LINEAR.toString = $estr;
canvas.display.GradientType.LINEAR.__enum__ = canvas.display.GradientType;
canvas.display.GradientType.RADIAL = ["RADIAL",0];
canvas.display.GradientType.RADIAL.toString = $estr;
canvas.display.GradientType.RADIAL.__enum__ = canvas.display.GradientType;
sandy.events.EventListener = function(inListener) { if( inListener === $_ ) return; {
	this.mListner = inListener;
	this.mID = sandy.events.EventListener.sIDs++;
}}
sandy.events.EventListener.__name__ = ["sandy","events","EventListener"];
sandy.events.EventListener.prototype.Is = function(inListener) {
	return Reflect.compareMethods($closure(this,"mListner"),inListener);
}
sandy.events.EventListener.prototype.dispatchEvent = function(event) {
	this.mListner(event);
}
sandy.events.EventListener.prototype.mID = null;
sandy.events.EventListener.prototype.mListner = null;
sandy.events.EventListener.prototype.__class__ = sandy.events.EventListener;
sandy.materials.MaterialType = { __ename__ : ["sandy","materials","MaterialType"], __constructs__ : ["NONE","COLOR","WIREFRAME","BITMAP","MOVIE","VIDEO","OUTLINE"] }
sandy.materials.MaterialType.BITMAP = ["BITMAP",3];
sandy.materials.MaterialType.BITMAP.toString = $estr;
sandy.materials.MaterialType.BITMAP.__enum__ = sandy.materials.MaterialType;
sandy.materials.MaterialType.COLOR = ["COLOR",1];
sandy.materials.MaterialType.COLOR.toString = $estr;
sandy.materials.MaterialType.COLOR.__enum__ = sandy.materials.MaterialType;
sandy.materials.MaterialType.MOVIE = ["MOVIE",4];
sandy.materials.MaterialType.MOVIE.toString = $estr;
sandy.materials.MaterialType.MOVIE.__enum__ = sandy.materials.MaterialType;
sandy.materials.MaterialType.NONE = ["NONE",0];
sandy.materials.MaterialType.NONE.toString = $estr;
sandy.materials.MaterialType.NONE.__enum__ = sandy.materials.MaterialType;
sandy.materials.MaterialType.OUTLINE = ["OUTLINE",6];
sandy.materials.MaterialType.OUTLINE.toString = $estr;
sandy.materials.MaterialType.OUTLINE.__enum__ = sandy.materials.MaterialType;
sandy.materials.MaterialType.VIDEO = ["VIDEO",5];
sandy.materials.MaterialType.VIDEO.toString = $estr;
sandy.materials.MaterialType.VIDEO.__enum__ = sandy.materials.MaterialType;
sandy.materials.MaterialType.WIREFRAME = ["WIREFRAME",2];
sandy.materials.MaterialType.WIREFRAME.toString = $estr;
sandy.materials.MaterialType.WIREFRAME.__enum__ = sandy.materials.MaterialType;
canvas.filters.BitmapFilter = function(inType) { if( inType === $_ ) return; {
	this.mType = inType;
}}
canvas.filters.BitmapFilter.__name__ = ["canvas","filters","BitmapFilter"];
canvas.filters.BitmapFilter.prototype.clone = function() {
	return null;
}
canvas.filters.BitmapFilter.prototype.mType = null;
canvas.filters.BitmapFilter.prototype.__class__ = canvas.filters.BitmapFilter;
sandy.util.ArrayUtil = function() { }
sandy.util.ArrayUtil.__name__ = ["sandy","util","ArrayUtil"];
sandy.util.ArrayUtil.indexOf = function(value,array) {
	return array.indexOf(value);
}
sandy.util.ArrayUtil.prototype.__class__ = sandy.util.ArrayUtil;
canvas.text = {}
canvas.text.TextField = function(p) { if( p === $_ ) return; {
	neash.display.InteractiveObject.apply(this,[]);
	this.mChanged = true;
	this.mHTMLMode = false;
	this.multiline = false;
	this.mGraphics = new canvas.display.Graphics();
	this.mCaretGfx = js.Lib.document.createElement("div");
	var scr = canvas.Manager.__scr;
	scr.parentNode.appendChild(this.mCaretGfx);
	this.mCaretGfx.style.position = "absolute";
	this.mOffsetTop = scr.offsetTop;
	this.mOffsetLeft = scr.offsetLeft;
	var ctx = canvas.Manager.getScreen();
	this.mCaretGfx.style.left = Std.string(scr.offsetLeft);
	this.mCaretGfx.style.top = Std.string(scr.offsetTop);
	this.mCaretGfx.style.lineHeight = "20px";
	this.mFace = canvas.text.TextField.mDefaultFont;
	this.mAlign = neash.text.TextFormatAlign.LEFT;
	this.defaultTextFormat = new neash.text.TextFormat();
	this.mSelStart = -1;
	this.mSelEnd = -1;
	this.mScrollH = 0;
	this.mScrollV = 1;
	this.mType = neash.text.TextFieldType.DYNAMIC;
	this.SetAutoSize(neash.text.TextFieldAutoSize.NONE);
	this.mTextHeight = 12;
	this.mHTMLText = " ";
	this.mText = " ";
	this.mTextColour = 0;
	this.tabEnabled = false;
	this.mFace = canvas.text.TextField.mDefaultFont;
	this.mTryFreeType = true;
	this.selectable = true;
	this.mInsertPos = 0;
	this.mInput = false;
	this.mDownChar = 0;
	this.mSelectDrag = -1;
	this.SetBorderColor(0);
	this.SetBorder(false);
	this.SetBackgroundColor(16777215);
	this.SetBackground(false);
}}
canvas.text.TextField.__name__ = ["canvas","text","TextField"];
canvas.text.TextField.__super__ = neash.display.InteractiveObject;
for(var k in neash.display.InteractiveObject.prototype ) canvas.text.TextField.prototype[k] = neash.display.InteractiveObject.prototype[k];
canvas.text.TextField.prototype.CheckChanged = function() {
	var result = this.mChanged;
	this.mChanged = false;
	return result;
}
canvas.text.TextField.prototype.ConvertHTMLToText = function(inUnSetHTML) {
	var reg = new EReg("</?[^>]*>","");
	this.mText = reg.replace(this.mHTMLText,"");
	if(inUnSetHTML) {
		this.mHTMLMode = false;
	}
}
canvas.text.TextField.prototype.GetHTMLText = function() {
	return this.mHTMLText;
}
canvas.text.TextField.prototype.GetHeight = function() {
	return this.mHeight;
}
canvas.text.TextField.prototype.GetText = function() {
	if(this.mHTMLMode) this.ConvertHTMLToText(false);
	return this.mText;
}
canvas.text.TextField.prototype.GetTextColour = function() {
	return this.mTextColour;
}
canvas.text.TextField.prototype.GetType = function() {
	return this.mType;
}
canvas.text.TextField.prototype.GetWidth = function() {
	return this.mWidth;
}
canvas.text.TextField.prototype.Render = function(inMask,inScrollRect,inTX,inTY) {
	this.mGraphics.clear();
	if(this.mCaretGfx.innerHTML != this.mHTMLText && this.CheckChanged()) {
		this.mCaretGfx.innerHTML = this.mHTMLText;
		this.mCaretGfx.style.left = Std.string(this.mX + this.mOffsetLeft + inTX) + "px";
		this.mCaretGfx.style.top = Std.string(this.mY + this.mOffsetTop + inTY) + "px";
		if(this.mWidth != null && this.autoSize == neash.text.TextFieldAutoSize.NONE) this.mCaretGfx.style.width = Std.string(this.mWidth) + "px";
		if(this.mHeight != null && this.autoSize == neash.text.TextFieldAutoSize.NONE) {
			this.mCaretGfx.style.lineHeight = Std.string(this.mHeight) + "px";
		}
		this.mCaretGfx.style.fontFamily = this.mFace;
		this.mCaretGfx.style.textAlign = this.mAlign;
		this.mCaretGfx.style.fontSize = Std.string(this.mTextHeight) + "px";
		this.mCaretGfx.style.color = this.mTextColour;
		if(this.border) this.mCaretGfx.style.border = "solid 1px #" + StringTools.lpad(StringTools.hex(this.borderColor),"0",6);
		if(this.background) this.mCaretGfx.style.backgroundColor = "#" + StringTools.lpad(StringTools.hex(this.backgroundColor),"0",6);
	}
}
canvas.text.TextField.prototype.SetAutoSize = function(inAutoSize) {
	this.mChanged = true;
	this.autoSize = inAutoSize;
	return inAutoSize;
}
canvas.text.TextField.prototype.SetBackground = function(inBack) {
	this.mChanged = true;
	this.background = inBack;
	return inBack;
}
canvas.text.TextField.prototype.SetBackgroundColor = function(inCol) {
	this.mChanged = true;
	this.backgroundColor = inCol;
	return inCol;
}
canvas.text.TextField.prototype.SetBorder = function(inBorder) {
	this.mChanged = true;
	this.border = inBorder;
	return inBorder;
}
canvas.text.TextField.prototype.SetBorderColor = function(inBorderCol) {
	this.mChanged = true;
	this.borderColor = inBorderCol;
	return inBorderCol;
}
canvas.text.TextField.prototype.SetHTMLText = function(inHTMLText) {
	this.mChanged = true;
	this.mHTMLText = inHTMLText;
	this.mHTMLMode = true;
	if(this.mInput) this.ConvertHTMLToText(true);
	return this.mHTMLText;
}
canvas.text.TextField.prototype.SetHeight = function(inHeight) {
	this.mChanged = true;
	if(inHeight != this.mHeight) {
		this.mHeight = inHeight;
	}
	return this.mHeight;
}
canvas.text.TextField.prototype.SetText = function(inText) {
	this.mText = inText;
	this.mHTMLText = inText;
	this.mHTMLMode = false;
	return this.mText;
}
canvas.text.TextField.prototype.SetTextColour = function(inCol) {
	this.mTextColour = inCol;
	return inCol;
}
canvas.text.TextField.prototype.SetType = function(inType) {
	this.mChanged = true;
	this.mType = inType;
	this.mInput = this.mType == neash.text.TextFieldType.INPUT;
	if(this.mInput && this.mHTMLMode) this.ConvertHTMLToText(true);
	this.tabEnabled = this.GetType() == neash.text.TextFieldType.INPUT;
	return inType;
}
canvas.text.TextField.prototype.SetWidth = function(inWidth) {
	this.mChanged = true;
	if(inWidth != this.mWidth) {
		this.mWidth = inWidth;
	}
	return this.mWidth;
}
canvas.text.TextField.prototype.SetWordWrap = function(inWordWrap) {
	this.mChanged = true;
	this.wordWrap = inWordWrap;
	return this.wordWrap;
}
canvas.text.TextField.prototype.antiAliasType = null;
canvas.text.TextField.prototype.autoSize = null;
canvas.text.TextField.prototype.background = null;
canvas.text.TextField.prototype.backgroundColor = null;
canvas.text.TextField.prototype.border = null;
canvas.text.TextField.prototype.borderColor = null;
canvas.text.TextField.prototype.caretIndex = null;
canvas.text.TextField.prototype.defaultTextFormat = null;
canvas.text.TextField.prototype.displayAsPassword = null;
canvas.text.TextField.prototype.embedFonts = null;
canvas.text.TextField.prototype.getTextFormat = function(beginIndex,endIndex) {
	return new neash.text.TextFormat();
}
canvas.text.TextField.prototype.gridFitType = null;
canvas.text.TextField.prototype.htmlText = null;
canvas.text.TextField.prototype.length = null;
canvas.text.TextField.prototype.mAlign = null;
canvas.text.TextField.prototype.mCaretGfx = null;
canvas.text.TextField.prototype.mDownChar = null;
canvas.text.TextField.prototype.mFace = null;
canvas.text.TextField.prototype.mGraphics = null;
canvas.text.TextField.prototype.mHTMLMode = null;
canvas.text.TextField.prototype.mHTMLText = null;
canvas.text.TextField.prototype.mHeight = null;
canvas.text.TextField.prototype.mInput = null;
canvas.text.TextField.prototype.mInsertPos = null;
canvas.text.TextField.prototype.mOffsetLeft = null;
canvas.text.TextField.prototype.mOffsetTop = null;
canvas.text.TextField.prototype.mScrollH = null;
canvas.text.TextField.prototype.mScrollV = null;
canvas.text.TextField.prototype.mSelEnd = null;
canvas.text.TextField.prototype.mSelStart = null;
canvas.text.TextField.prototype.mSelectDrag = null;
canvas.text.TextField.prototype.mSelectionAnchor = null;
canvas.text.TextField.prototype.mSelectionAnchored = null;
canvas.text.TextField.prototype.mText = null;
canvas.text.TextField.prototype.mTextColour = null;
canvas.text.TextField.prototype.mTextHeight = null;
canvas.text.TextField.prototype.mTryFreeType = null;
canvas.text.TextField.prototype.mType = null;
canvas.text.TextField.prototype.mWidth = null;
canvas.text.TextField.prototype.maxChars = null;
canvas.text.TextField.prototype.multiline = null;
canvas.text.TextField.prototype.restrict = null;
canvas.text.TextField.prototype.selectable = null;
canvas.text.TextField.prototype.selectionBeginIndex = null;
canvas.text.TextField.prototype.selectionEndIndex = null;
canvas.text.TextField.prototype.setSelection = function(beginIndex,endIndex) {
	null;
}
canvas.text.TextField.prototype.setTextFormat = function(inFmt) {
	this.mChanged = true;
	if(inFmt.font != null) this.mFace = inFmt.font;
	if(inFmt.size != null) this.mTextHeight = inFmt.size;
	if(inFmt.align != null) this.mAlign = inFmt.align;
	if(inFmt.color != null) this.mTextColour = inFmt.color;
}
canvas.text.TextField.prototype.sharpness = null;
canvas.text.TextField.prototype.text = null;
canvas.text.TextField.prototype.textColor = null;
canvas.text.TextField.prototype.type = null;
canvas.text.TextField.prototype.wordWrap = null;
canvas.text.TextField.prototype.__class__ = canvas.text.TextField;
neash.display.Bitmap = function(inBitmapData,inPixelSnapping,inSmoothing) { if( inBitmapData === $_ ) return; {
	neash.display.DisplayObject.apply(this,[]);
	this.bitmapData = inBitmapData;
	this.pixelSnapping = inPixelSnapping;
	this.smoothing = inSmoothing;
}}
neash.display.Bitmap.__name__ = ["neash","display","Bitmap"];
neash.display.Bitmap.__super__ = neash.display.DisplayObject;
for(var k in neash.display.DisplayObject.prototype ) neash.display.Bitmap.prototype[k] = neash.display.DisplayObject.prototype[k];
neash.display.Bitmap.prototype.bitmapData = null;
neash.display.Bitmap.prototype.pixelSnapping = null;
neash.display.Bitmap.prototype.smoothing = null;
neash.display.Bitmap.prototype.__class__ = neash.display.Bitmap;
neash.events.EventPhase = function() { }
neash.events.EventPhase.__name__ = ["neash","events","EventPhase"];
neash.events.EventPhase.prototype.__class__ = neash.events.EventPhase;
neash.text.TextFieldType = function(p) { if( p === $_ ) return; {
	null;
}}
neash.text.TextFieldType.__name__ = ["neash","text","TextFieldType"];
neash.text.TextFieldType.prototype.__class__ = neash.text.TextFieldType;
sandy.core.Scene3D = function(p_sName,p_oContainer,p_oCamera,p_oRootNode) { if( p_sName === $_ ) return; {
	this.materialManager = new sandy.materials.MaterialManager();
	this.m_bRectClipped = true;
	neash.events.EventDispatcher.apply(this,[]);
	if(sandy.core.SceneLocator.getInstance().registerScene(p_sName,this)) {
		this.container = p_oContainer;
		this.camera = p_oCamera;
		this.root = p_oRootNode;
		if(this.root != null && this.camera != null) {
			this.root.addChild(this.camera);
		}
	}
	this.m_sName = p_sName;
	this._light = new sandy.core.light.Light3D(new sandy.core.data.Vector(0,0,1),100);
}}
sandy.core.Scene3D.__name__ = ["sandy","core","Scene3D"];
sandy.core.Scene3D.__super__ = neash.events.EventDispatcher;
for(var k in neash.events.EventDispatcher.prototype ) sandy.core.Scene3D.prototype[k] = neash.events.EventDispatcher.prototype[k];
sandy.core.Scene3D.prototype.__getLight = function() {
	return this._light;
}
sandy.core.Scene3D.prototype.__getName = function() {
	return this.m_sName;
}
sandy.core.Scene3D.prototype.__getRectClipping = function() {
	return this.m_bRectClipped;
}
sandy.core.Scene3D.prototype.__setLight = function(l) {
	if(this._light != null) {
		this._light.destroy();
	}
	this._light = l;
	this.dispatchEvent(new sandy.events.SandyEvent(sandy.events.SandyEvent.LIGHT_ADDED));
	return l;
}
sandy.core.Scene3D.prototype.__setRectClipping = function(p_bEnableClipping) {
	this.m_bRectClipped = p_bEnableClipping;
	if(this.camera != null) {
		this.camera.viewport.hasChanged = true;
	}
	return p_bEnableClipping;
}
sandy.core.Scene3D.prototype._light = null;
sandy.core.Scene3D.prototype.camera = null;
sandy.core.Scene3D.prototype.container = null;
sandy.core.Scene3D.prototype.dispose = function() {
	sandy.core.SceneLocator.getInstance().unregisterScene(this.m_sName);
	this.root.destroy();
	if(this.root != null) {
		this.root = null;
	}
	if(this.camera != null) {
		this.camera = null;
	}
	if(this._light != null) {
		this._light = null;
	}
	return true;
}
sandy.core.Scene3D.prototype.light = null;
sandy.core.Scene3D.prototype.m_bRectClipped = null;
sandy.core.Scene3D.prototype.m_sName = null;
sandy.core.Scene3D.prototype.materialManager = null;
sandy.core.Scene3D.prototype.name = null;
sandy.core.Scene3D.prototype.rectClipping = null;
sandy.core.Scene3D.prototype.render = function(p_oEvt) {
	if(this.root != null && this.camera != null && this.container != null) {
		this.dispatchEvent(new sandy.events.SandyEvent(sandy.events.SandyEvent.SCENE_UPDATE));
		this.root.update(this,null,false);
		this.dispatchEvent(new sandy.events.SandyEvent(sandy.events.SandyEvent.SCENE_CULL));
		this.root.cull(this,this.camera.frustrum,this.camera.invModelMatrix,this.camera.changed);
		this.dispatchEvent(new sandy.events.SandyEvent(sandy.events.SandyEvent.SCENE_RENDER));
		this.root.render(this,this.camera);
		this.dispatchEvent(new sandy.events.SandyEvent(sandy.events.SandyEvent.SCENE_RENDER_DISPLAYLIST));
		this.materialManager.begin(this);
		this.camera.renderDisplayList(this);
		this.materialManager.finish(this);
	}
}
sandy.core.Scene3D.prototype.root = null;
sandy.core.Scene3D.prototype.__class__ = sandy.core.Scene3D;
sandy.view.ViewPort = function(p_nW,p_nH) { if( p_nW === $_ ) return; {
	this.hasChanged = false;
	this.m_nW = 0;
	this.m_nW2 = 0;
	this.m_nH = 0;
	this.m_nH2 = 0;
	this.m_nRatio = 0;
	this.offset = new canvas.geom.Point();
	this.__setWidth(p_nW);
	this.__setHeight(p_nH);
}}
sandy.view.ViewPort.__name__ = ["sandy","view","ViewPort"];
sandy.view.ViewPort.prototype.__getHeight = function() {
	return this.m_nH;
}
sandy.view.ViewPort.prototype.__getHeight2 = function() {
	return this.m_nH2;
}
sandy.view.ViewPort.prototype.__getRatio = function() {
	return this.m_nRatio;
}
sandy.view.ViewPort.prototype.__getWidth = function() {
	return this.m_nW;
}
sandy.view.ViewPort.prototype.__getWidth2 = function() {
	return this.m_nW2;
}
sandy.view.ViewPort.prototype.__setHeight = function(p_nValue) {
	this.m_nH = p_nValue;
	this.update();
	return p_nValue;
}
sandy.view.ViewPort.prototype.__setWidth = function(p_nValue) {
	this.m_nW = p_nValue;
	this.update();
	return p_nValue;
}
sandy.view.ViewPort.prototype.hasChanged = null;
sandy.view.ViewPort.prototype.height = null;
sandy.view.ViewPort.prototype.height2 = null;
sandy.view.ViewPort.prototype.m_nH = null;
sandy.view.ViewPort.prototype.m_nH2 = null;
sandy.view.ViewPort.prototype.m_nRatio = null;
sandy.view.ViewPort.prototype.m_nW = null;
sandy.view.ViewPort.prototype.m_nW2 = null;
sandy.view.ViewPort.prototype.offset = null;
sandy.view.ViewPort.prototype.ratio = null;
sandy.view.ViewPort.prototype.update = function() {
	this.m_nW2 = this.m_nW >> 1;
	this.m_nH2 = this.m_nH >> 1;
	this.m_nRatio = ((this.m_nH != 0)?this.m_nW / this.m_nH:0);
	this.hasChanged = true;
}
sandy.view.ViewPort.prototype.width = null;
sandy.view.ViewPort.prototype.width2 = null;
sandy.view.ViewPort.prototype.__class__ = sandy.view.ViewPort;
haxe.io.Input = function() { }
haxe.io.Input.__name__ = ["haxe","io","Input"];
haxe.io.Input.prototype.bigEndian = null;
haxe.io.Input.prototype.close = function() {
	null;
}
haxe.io.Input.prototype.read = function(nbytes) {
	var s = haxe.io.Bytes.alloc(nbytes);
	var p = 0;
	while(nbytes > 0) {
		var k = this.readBytes(s,p,nbytes);
		if(k == 0) throw haxe.io.Error.Blocked;
		p += k;
		nbytes -= k;
	}
	return s;
}
haxe.io.Input.prototype.readAll = function(bufsize) {
	if(bufsize == null) bufsize = (1 << 14);
	var buf = haxe.io.Bytes.alloc(bufsize);
	var total = new haxe.io.BytesBuffer();
	try {
		while(true) {
			var len = this.readBytes(buf,0,bufsize);
			if(len == 0) throw haxe.io.Error.Blocked;
			total.addBytes(buf,0,len);
		}
	}
	catch( $e31 ) {
		if( js.Boot.__instanceof($e31,haxe.io.Eof) ) {
			var e = $e31;
			null;
		} else throw($e31);
	}
	return total.getBytes();
}
haxe.io.Input.prototype.readByte = function() {
	return function($this) {
		var $r;
		throw "Not implemented";
		return $r;
	}(this);
}
haxe.io.Input.prototype.readBytes = function(s,pos,len) {
	var k = len;
	var b = s.b;
	if(pos < 0 || len < 0 || pos + len > s.length) throw haxe.io.Error.OutsideBounds;
	while(k > 0) {
		b[pos] = this.readByte();
		pos++;
		k--;
	}
	return len;
}
haxe.io.Input.prototype.readDouble = function() {
	throw "Not implemented";
	return 0;
}
haxe.io.Input.prototype.readFloat = function() {
	throw "Not implemented";
	return 0;
}
haxe.io.Input.prototype.readFullBytes = function(s,pos,len) {
	while(len > 0) {
		var k = this.readBytes(s,pos,len);
		pos += k;
		len -= k;
	}
}
haxe.io.Input.prototype.readInt16 = function() {
	var ch1 = this.readByte();
	var ch2 = this.readByte();
	var n = (this.bigEndian?ch2 | (ch1 << 8):ch1 | (ch2 << 8));
	if((n & 32768) != 0) return n - 65536;
	return n;
}
haxe.io.Input.prototype.readInt24 = function() {
	var ch1 = this.readByte();
	var ch2 = this.readByte();
	var ch3 = this.readByte();
	var n = (this.bigEndian?(ch3 | (ch2 << 8)) | (ch1 << 16):(ch1 | (ch2 << 8)) | (ch3 << 16));
	if((n & 8388608) != 0) return n - 16777216;
	return n;
}
haxe.io.Input.prototype.readInt31 = function() {
	var ch1, ch2, ch3, ch4;
	if(this.bigEndian) {
		ch4 = this.readByte();
		ch3 = this.readByte();
		ch2 = this.readByte();
		ch1 = this.readByte();
	}
	else {
		ch1 = this.readByte();
		ch2 = this.readByte();
		ch3 = this.readByte();
		ch4 = this.readByte();
	}
	if(((ch4 & 128) == 0) != ((ch4 & 64) == 0)) throw haxe.io.Error.Overflow;
	return ((ch1 | (ch2 << 8)) | (ch3 << 16)) | (ch4 << 24);
}
haxe.io.Input.prototype.readInt32 = function() {
	var ch1 = this.readByte();
	var ch2 = this.readByte();
	var ch3 = this.readByte();
	var ch4 = this.readByte();
	return (this.bigEndian?(((ch1 << 8) | ch2) << 16) | ((ch3 << 8) | ch4):(((ch4 << 8) | ch3) << 16) | ((ch2 << 8) | ch1));
}
haxe.io.Input.prototype.readInt8 = function() {
	var n = this.readByte();
	if(n >= 128) return n - 256;
	return n;
}
haxe.io.Input.prototype.readLine = function() {
	var buf = new StringBuf();
	var last;
	var s;
	try {
		while((last = this.readByte()) != 10) buf.b += String.fromCharCode(last);
		s = buf.b;
		if(s.charCodeAt(s.length - 1) == 13) s = s.substr(0,-1);
	}
	catch( $e32 ) {
		if( js.Boot.__instanceof($e32,haxe.io.Eof) ) {
			var e = $e32;
			{
				s = buf.b;
				if(s.length == 0) throw (e);
			}
		} else throw($e32);
	}
	return s;
}
haxe.io.Input.prototype.readString = function(len) {
	var b = haxe.io.Bytes.alloc(len);
	this.readFullBytes(b,0,len);
	return b.toString();
}
haxe.io.Input.prototype.readUInt16 = function() {
	var ch1 = this.readByte();
	var ch2 = this.readByte();
	return (this.bigEndian?ch2 | (ch1 << 8):ch1 | (ch2 << 8));
}
haxe.io.Input.prototype.readUInt24 = function() {
	var ch1 = this.readByte();
	var ch2 = this.readByte();
	var ch3 = this.readByte();
	return (this.bigEndian?(ch3 | (ch2 << 8)) | (ch1 << 16):(ch1 | (ch2 << 8)) | (ch3 << 16));
}
haxe.io.Input.prototype.readUInt30 = function() {
	var ch1 = this.readByte();
	var ch2 = this.readByte();
	var ch3 = this.readByte();
	var ch4 = this.readByte();
	if(((this.bigEndian?ch1:ch4)) >= 64) throw haxe.io.Error.Overflow;
	return (this.bigEndian?((ch4 | (ch3 << 8)) | (ch2 << 16)) | (ch1 << 24):((ch1 | (ch2 << 8)) | (ch3 << 16)) | (ch4 << 24));
}
haxe.io.Input.prototype.readUntil = function(end) {
	var buf = new StringBuf();
	var last;
	while((last = this.readByte()) != end) buf.b += String.fromCharCode(last);
	return buf.b;
}
haxe.io.Input.prototype.setEndian = function(b) {
	this.bigEndian = b;
	return b;
}
haxe.io.Input.prototype.__class__ = haxe.io.Input;
neash.utils.IDataInput = function(inInput) { if( inInput === $_ ) return; {
	this.mInput = inInput;
}}
neash.utils.IDataInput.__name__ = ["neash","utils","IDataInput"];
neash.utils.IDataInput.prototype.close = function() {
	this.mInput.close();
}
neash.utils.IDataInput.prototype.mInput = null;
neash.utils.IDataInput.prototype.readAll = function(bufsize) {
	return this.mInput.readAll(bufsize);
}
neash.utils.IDataInput.prototype.readBoolean = function() {
	return this.mInput.readInt8() != 0;
}
neash.utils.IDataInput.prototype.readByte = function() {
	return this.mInput.readByte();
}
neash.utils.IDataInput.prototype.readBytes = function(inLen) {
	return this.mInput.read(inLen);
}
neash.utils.IDataInput.prototype.readDouble = function() {
	return this.mInput.readDouble();
}
neash.utils.IDataInput.prototype.readFloat = function() {
	return this.mInput.readFloat();
}
neash.utils.IDataInput.prototype.readInt = function() {
	return haxe.Int32.toInt(this.mInput.readInt32());
}
neash.utils.IDataInput.prototype.readShort = function() {
	return this.mInput.readInt16();
}
neash.utils.IDataInput.prototype.readUTFBytes = function(length) {
	return this.mInput.read(length);
}
neash.utils.IDataInput.prototype.readUnsignedByte = function() {
	return this.mInput.readByte();
}
neash.utils.IDataInput.prototype.readUnsignedInt = function() {
	return haxe.Int32.toInt(this.mInput.readInt32());
}
neash.utils.IDataInput.prototype.readUnsignedShort = function() {
	return this.mInput.readUInt16();
}
neash.utils.IDataInput.prototype.__class__ = neash.utils.IDataInput;
canvas.display.CapsStyle = { __ename__ : ["canvas","display","CapsStyle"], __constructs__ : ["NONE","ROUND","SQUARE"] }
canvas.display.CapsStyle.NONE = ["NONE",0];
canvas.display.CapsStyle.NONE.toString = $estr;
canvas.display.CapsStyle.NONE.__enum__ = canvas.display.CapsStyle;
canvas.display.CapsStyle.ROUND = ["ROUND",1];
canvas.display.CapsStyle.ROUND.toString = $estr;
canvas.display.CapsStyle.ROUND.__enum__ = canvas.display.CapsStyle;
canvas.display.CapsStyle.SQUARE = ["SQUARE",2];
canvas.display.CapsStyle.SQUARE.toString = $estr;
canvas.display.CapsStyle.SQUARE.__enum__ = canvas.display.CapsStyle;
sandy.core.data.Matrix4 = function(pn11,pn12,pn13,pn14,pn21,pn22,pn23,pn24,pn31,pn32,pn33,pn34,pn41,pn42,pn43,pn44) { if( pn11 === $_ ) return; {
	sandy.core.data.Matrix4.USE_FAST_MATH = false;
	this._fastMathInitialized = sandy.math.FastMath.initialized();
	if(pn11 == null) pn11 = 1;
	if(pn12 == null) pn12 = 0;
	if(pn13 == null) pn13 = 0;
	if(pn14 == null) pn14 = 0;
	if(pn21 == null) pn21 = 0;
	if(pn22 == null) pn22 = 1;
	if(pn23 == null) pn23 = 0;
	if(pn24 == null) pn24 = 0;
	if(pn31 == null) pn31 = 0;
	if(pn32 == null) pn32 = 0;
	if(pn33 == null) pn33 = 1;
	if(pn34 == null) pn34 = 0;
	if(pn41 == null) pn41 = 0;
	if(pn42 == null) pn42 = 0;
	if(pn43 == null) pn43 = 0;
	if(pn44 == null) pn44 = 1;
	this.n11 = pn11;
	this.n12 = pn12;
	this.n13 = pn13;
	this.n14 = pn14;
	this.n21 = pn21;
	this.n22 = pn22;
	this.n23 = pn23;
	this.n24 = pn24;
	this.n31 = pn31;
	this.n32 = pn32;
	this.n33 = pn33;
	this.n34 = pn34;
	this.n41 = pn41;
	this.n42 = pn42;
	this.n43 = pn43;
	this.n44 = pn44;
}}
sandy.core.data.Matrix4.__name__ = ["sandy","core","data","Matrix4"];
sandy.core.data.Matrix4.getEulerAngles = function(t) {
	var lAngleY = Math.asin(t.n13);
	var lCos = Math.cos(lAngleY);
	var lTrx, lTry, lAngleX, lAngleZ;
	if(Math.abs(lCos) > 0.005) {
		lTrx = t.n33 / lCos;
		lTry = -t.n22 / lCos;
		lAngleX = Math.atan2(lTry,lTrx);
		lTrx = t.n11 / lCos;
		lTry = -t.n12 / lCos;
		lAngleZ = Math.atan2(lTry,lTrx);
	}
	else {
		lAngleX = 0;
		lTrx = t.n22;
		lTry = t.n21;
		lAngleZ = Math.atan2(lTry,lTrx);
	}
	if(lAngleX < 0) lAngleX += 360;
	if(lAngleY < 0) lAngleY += 360;
	if(lAngleZ < 0) lAngleZ += 360;
	return new sandy.core.data.Vector(lAngleX,lAngleY,lAngleZ);
}
sandy.core.data.Matrix4.prototype._fastMathInitialized = null;
sandy.core.data.Matrix4.prototype.addMatrix = function(m2) {
	this.n11 += m2.n11;
	this.n12 += m2.n12;
	this.n13 += m2.n13;
	this.n14 += m2.n14;
	this.n21 += m2.n21;
	this.n22 += m2.n22;
	this.n23 += m2.n23;
	this.n24 += m2.n24;
	this.n31 += m2.n31;
	this.n32 += m2.n32;
	this.n33 += m2.n33;
	this.n34 += m2.n34;
	this.n41 += m2.n41;
	this.n42 += m2.n42;
	this.n43 += m2.n43;
	this.n44 += m2.n44;
}
sandy.core.data.Matrix4.prototype.axisRotation = function(u,v,w,angle) {
	this.identity();
	angle = sandy.util.NumberUtil.toRadian(angle);
	var c = ((sandy.core.data.Matrix4.USE_FAST_MATH == false)?Math.cos(angle):sandy.math.FastMath.cos(angle));
	var s = ((sandy.core.data.Matrix4.USE_FAST_MATH == false)?Math.sin(angle):sandy.math.FastMath.sin(angle));
	var scos = 1 - c;
	var suv = u * v * scos;
	var svw = v * w * scos;
	var suw = u * w * scos;
	var sw = s * w;
	var sv = s * v;
	var su = s * u;
	this.n11 = c + u * u * scos;
	this.n12 = -sw + suv;
	this.n13 = sv + suw;
	this.n21 = sw + suv;
	this.n22 = c + v * v * scos;
	this.n23 = -su + svw;
	this.n31 = -sv + suw;
	this.n32 = su + svw;
	this.n33 = c + w * w * scos;
}
sandy.core.data.Matrix4.prototype.axisRotationVector = function(v,angle) {
	this.axisRotation(v.x,v.y,v.z,angle);
}
sandy.core.data.Matrix4.prototype.axisRotationWithReference = function(axis,ref,pAngle) {
	var tmp = new sandy.core.data.Matrix4();
	var angle = (pAngle + 360) % 360;
	this.translation(ref.x,ref.y,ref.z);
	tmp.axisRotation(axis.x,axis.y,axis.z,angle);
	this.multiply(tmp);
	tmp.translation(-ref.x,-ref.y,-ref.z);
	this.multiply(tmp);
	tmp = null;
}
sandy.core.data.Matrix4.prototype.clone = function() {
	return new sandy.core.data.Matrix4(this.n11,this.n12,this.n13,this.n14,this.n21,this.n22,this.n23,this.n24,this.n31,this.n32,this.n33,this.n34,this.n41,this.n42,this.n43,this.n44);
}
sandy.core.data.Matrix4.prototype.copy = function(m) {
	this.n11 = m.n11;
	this.n12 = m.n12;
	this.n13 = m.n13;
	this.n14 = m.n14;
	this.n21 = m.n21;
	this.n22 = m.n22;
	this.n23 = m.n23;
	this.n24 = m.n24;
	this.n31 = m.n31;
	this.n32 = m.n32;
	this.n33 = m.n33;
	this.n34 = m.n34;
	this.n41 = m.n41;
	this.n42 = m.n42;
	this.n43 = m.n43;
	this.n44 = m.n44;
}
sandy.core.data.Matrix4.prototype.det = function() {
	return (this.n11 * this.n22 - this.n21 * this.n12) * (this.n33 * this.n44 - this.n43 * this.n34) - (this.n11 * this.n32 - this.n31 * this.n12) * (this.n23 * this.n44 - this.n43 * this.n24) + (this.n11 * this.n42 - this.n41 * this.n12) * (this.n23 * this.n34 - this.n33 * this.n24) + (this.n21 * this.n32 - this.n31 * this.n22) * (this.n13 * this.n44 - this.n43 * this.n14) - (this.n21 * this.n42 - this.n41 * this.n22) * (this.n13 * this.n34 - this.n33 * this.n14) + (this.n31 * this.n42 - this.n41 * this.n32) * (this.n13 * this.n24 - this.n23 * this.n14);
}
sandy.core.data.Matrix4.prototype.det3x3 = function() {
	return this.n11 * (this.n22 * this.n33 - this.n23 * this.n32) + this.n21 * (this.n32 * this.n13 - this.n12 * this.n33) + this.n31 * (this.n12 * this.n23 - this.n22 * this.n13);
}
sandy.core.data.Matrix4.prototype.eulerRotation = function(ax,ay,az) {
	this.identity();
	ax = sandy.util.NumberUtil.toRadian(ax);
	ay = sandy.util.NumberUtil.toRadian(ay);
	az = sandy.util.NumberUtil.toRadian(az);
	var a = ((sandy.core.data.Matrix4.USE_FAST_MATH == false)?Math.cos(ax):sandy.math.FastMath.cos(ax));
	var b = ((sandy.core.data.Matrix4.USE_FAST_MATH == false)?Math.sin(ax):sandy.math.FastMath.sin(ax));
	var c = ((sandy.core.data.Matrix4.USE_FAST_MATH == false)?Math.cos(ay):sandy.math.FastMath.cos(ay));
	var d = ((sandy.core.data.Matrix4.USE_FAST_MATH == false)?Math.sin(ay):sandy.math.FastMath.sin(ay));
	var e = ((sandy.core.data.Matrix4.USE_FAST_MATH == false)?Math.cos(az):sandy.math.FastMath.cos(az));
	var f = ((sandy.core.data.Matrix4.USE_FAST_MATH == false)?Math.sin(az):sandy.math.FastMath.sin(az));
	var ad = a * d;
	var bd = b * d;
	this.n11 = c * e;
	this.n12 = -c * f;
	this.n13 = -d;
	this.n21 = -bd * e + a * f;
	this.n22 = -bd * f + a * e;
	this.n23 = -b * c;
	this.n31 = ad * e + b * f;
	this.n32 = -ad * f + b * e;
	this.n33 = a * c;
}
sandy.core.data.Matrix4.prototype.fromVectors = function(px,py,pz,pt) {
	this.zero();
	this.n11 = px.x;
	this.n21 = px.y;
	this.n31 = px.z;
	this.n12 = py.x;
	this.n22 = py.y;
	this.n32 = py.z;
	this.n13 = pz.x;
	this.n23 = pz.y;
	this.n33 = pz.z;
	this.n14 = pt.x;
	this.n24 = pt.y;
	this.n34 = pt.z;
}
sandy.core.data.Matrix4.prototype.getTrace = function() {
	return this.n11 + this.n22 + this.n33 + this.n44;
}
sandy.core.data.Matrix4.prototype.getTranslation = function() {
	return new sandy.core.data.Vector(this.n14,this.n24,this.n34);
}
sandy.core.data.Matrix4.prototype.identity = function() {
	this.n11 = 1;
	this.n12 = 0;
	this.n13 = 0;
	this.n14 = 0;
	this.n21 = 0;
	this.n22 = 1;
	this.n23 = 0;
	this.n24 = 0;
	this.n31 = 0;
	this.n32 = 0;
	this.n33 = 1;
	this.n34 = 0;
	this.n41 = 0;
	this.n42 = 0;
	this.n43 = 0;
	this.n44 = 1;
}
sandy.core.data.Matrix4.prototype.inverse = function() {
	var d = this.det();
	if(Math.abs(d) >= 0.001) {
		d = 1 / d;
		var m11 = this.n11, m21 = this.n21, m31 = this.n31, m41 = this.n41, m12 = this.n12, m22 = this.n22, m32 = this.n32, m42 = this.n42, m13 = this.n13, m23 = this.n23, m33 = this.n33, m43 = this.n43, m14 = this.n14, m24 = this.n24, m34 = this.n34, m44 = this.n44;
		this.n11 = d * (m22 * (m33 * m44 - m43 * m34) - m32 * (m23 * m44 - m43 * m24) + m42 * (m23 * m34 - m33 * m24));
		this.n12 = -d * (m12 * (m33 * m44 - m43 * m34) - m32 * (m13 * m44 - m43 * m14) + m42 * (m13 * m34 - m33 * m14));
		this.n13 = d * (m12 * (m23 * m44 - m43 * m24) - m22 * (m13 * m44 - m43 * m14) + m42 * (m13 * m24 - m23 * m14));
		this.n14 = -d * (m12 * (m23 * m34 - m33 * m24) - m22 * (m13 * m34 - m33 * m14) + m32 * (m13 * m24 - m23 * m14));
		this.n21 = -d * (m21 * (m33 * m44 - m43 * m34) - m31 * (m23 * m44 - m43 * m24) + m41 * (m23 * m34 - m33 * m24));
		this.n22 = d * (m11 * (m33 * m44 - m43 * m34) - m31 * (m13 * m44 - m43 * m14) + m41 * (m13 * m34 - m33 * m14));
		this.n23 = -d * (m11 * (m23 * m44 - m43 * m24) - m21 * (m13 * m44 - m43 * m14) + m41 * (m13 * m24 - m23 * m14));
		this.n24 = d * (m11 * (m23 * m34 - m33 * m24) - m21 * (m13 * m34 - m33 * m14) + m31 * (m13 * m24 - m23 * m14));
		this.n31 = d * (m21 * (m32 * m44 - m42 * m34) - m31 * (m22 * m44 - m42 * m24) + m41 * (m22 * m34 - m32 * m24));
		this.n32 = -d * (m11 * (m32 * m44 - m42 * m34) - m31 * (m12 * m44 - m42 * m14) + m41 * (m12 * m34 - m32 * m14));
		this.n33 = d * (m11 * (m22 * m44 - m42 * m24) - m21 * (m12 * m44 - m42 * m14) + m41 * (m12 * m24 - m22 * m14));
		this.n34 = -d * (m11 * (m22 * m34 - m32 * m24) - m21 * (m12 * m34 - m32 * m14) + m31 * (m12 * m24 - m22 * m14));
		this.n41 = -d * (m21 * (m32 * m43 - m42 * m33) - m31 * (m22 * m43 - m42 * m23) + m41 * (m22 * m33 - m32 * m23));
		this.n42 = d * (m11 * (m32 * m43 - m42 * m33) - m31 * (m12 * m43 - m42 * m13) + m41 * (m12 * m33 - m32 * m13));
		this.n43 = -d * (m11 * (m22 * m43 - m42 * m23) - m21 * (m12 * m43 - m42 * m13) + m41 * (m12 * m23 - m22 * m13));
		this.n44 = d * (m11 * (m22 * m33 - m32 * m23) - m21 * (m12 * m33 - m32 * m13) + m31 * (m12 * m23 - m22 * m13));
	}
}
sandy.core.data.Matrix4.prototype.multiply = function(m2) {
	var m111 = this.n11, m121 = this.n21, m131 = this.n31, m141 = this.n41, m112 = this.n12, m122 = this.n22, m132 = this.n32, m142 = this.n42, m113 = this.n13, m123 = this.n23, m133 = this.n33, m143 = this.n43, m114 = this.n14, m124 = this.n24, m134 = this.n34, m144 = this.n44, m211 = m2.n11, m221 = m2.n21, m231 = m2.n31, m241 = m2.n41, m212 = m2.n12, m222 = m2.n22, m232 = m2.n32, m242 = m2.n42, m213 = m2.n13, m223 = m2.n23, m233 = m2.n33, m243 = m2.n43, m214 = m2.n14, m224 = m2.n24, m234 = m2.n34, m244 = m2.n44;
	this.n11 = m111 * m211 + m112 * m221 + m113 * m231 + m114 * m241;
	this.n12 = m111 * m212 + m112 * m222 + m113 * m232 + m114 * m242;
	this.n13 = m111 * m213 + m112 * m223 + m113 * m233 + m114 * m243;
	this.n14 = m111 * m214 + m112 * m224 + m113 * m234 + m114 * m244;
	this.n21 = m121 * m211 + m122 * m221 + m123 * m231 + m124 * m241;
	this.n22 = m121 * m212 + m122 * m222 + m123 * m232 + m124 * m242;
	this.n23 = m121 * m213 + m122 * m223 + m123 * m233 + m124 * m243;
	this.n24 = m121 * m214 + m122 * m224 + m123 * m234 + m124 * m244;
	this.n31 = m131 * m211 + m132 * m221 + m133 * m231 + m134 * m241;
	this.n32 = m131 * m212 + m132 * m222 + m133 * m232 + m134 * m242;
	this.n33 = m131 * m213 + m132 * m223 + m133 * m233 + m134 * m243;
	this.n34 = m131 * m214 + m132 * m224 + m133 * m234 + m134 * m244;
	this.n41 = m141 * m211 + m142 * m221 + m143 * m231 + m144 * m241;
	this.n42 = m141 * m212 + m142 * m222 + m143 * m232 + m144 * m242;
	this.n43 = m141 * m213 + m142 * m223 + m143 * m233 + m144 * m243;
	this.n44 = m141 * m214 + m142 * m224 + m143 * m234 + m144 * m244;
}
sandy.core.data.Matrix4.prototype.multiply3x3 = function(m2) {
	var m111 = this.n11, m211 = m2.n11, m121 = this.n21, m221 = m2.n21, m131 = this.n31, m231 = m2.n31, m112 = this.n12, m212 = m2.n12, m122 = this.n22, m222 = m2.n22, m132 = this.n32, m232 = m2.n32, m113 = this.n13, m213 = m2.n13, m123 = this.n23, m223 = m2.n23, m133 = this.n33, m233 = m2.n33;
	this.n11 = m111 * m211 + m112 * m221 + m113 * m231;
	this.n12 = m111 * m212 + m112 * m222 + m113 * m232;
	this.n13 = m111 * m213 + m112 * m223 + m113 * m233;
	this.n21 = m121 * m211 + m122 * m221 + m123 * m231;
	this.n22 = m121 * m212 + m122 * m222 + m123 * m232;
	this.n23 = m121 * m213 + m122 * m223 + m123 * m233;
	this.n31 = m131 * m211 + m132 * m221 + m133 * m231;
	this.n32 = m131 * m212 + m132 * m222 + m133 * m232;
	this.n33 = m131 * m213 + m132 * m223 + m133 * m233;
	this.n14 = this.n24 = this.n34 = this.n41 = this.n42 = this.n43 = 0;
	this.n44 = 1;
}
sandy.core.data.Matrix4.prototype.multiply4x3 = function(m2) {
	var m111 = this.n11, m211 = m2.n11, m121 = this.n21, m221 = m2.n21, m131 = this.n31, m231 = m2.n31, m112 = this.n12, m212 = m2.n12, m122 = this.n22, m222 = m2.n22, m132 = this.n32, m232 = m2.n32, m113 = this.n13, m213 = m2.n13, m123 = this.n23, m223 = m2.n23, m133 = this.n33, m233 = m2.n33, m214 = m2.n14, m224 = m2.n24, m234 = m2.n34;
	this.n11 = m111 * m211 + m112 * m221 + m113 * m231;
	this.n12 = m111 * m212 + m112 * m222 + m113 * m232;
	this.n13 = m111 * m213 + m112 * m223 + m113 * m233;
	this.n14 = m214 * m111 + m224 * m112 + m234 * m113 + this.n14;
	this.n21 = m121 * m211 + m122 * m221 + m123 * m231;
	this.n22 = m121 * m212 + m122 * m222 + m123 * m232;
	this.n23 = m121 * m213 + m122 * m223 + m123 * m233;
	this.n24 = m214 * m121 + m224 * m122 + m234 * m123 + this.n24;
	this.n31 = m131 * m211 + m132 * m221 + m133 * m231;
	this.n32 = m131 * m212 + m132 * m222 + m133 * m232;
	this.n33 = m131 * m213 + m132 * m223 + m133 * m233;
	this.n34 = m214 * m131 + m224 * m132 + m234 * m133 + this.n34;
	this.n41 = this.n42 = this.n43 = 0;
	this.n44 = 1;
}
sandy.core.data.Matrix4.prototype.n11 = null;
sandy.core.data.Matrix4.prototype.n12 = null;
sandy.core.data.Matrix4.prototype.n13 = null;
sandy.core.data.Matrix4.prototype.n14 = null;
sandy.core.data.Matrix4.prototype.n21 = null;
sandy.core.data.Matrix4.prototype.n22 = null;
sandy.core.data.Matrix4.prototype.n23 = null;
sandy.core.data.Matrix4.prototype.n24 = null;
sandy.core.data.Matrix4.prototype.n31 = null;
sandy.core.data.Matrix4.prototype.n32 = null;
sandy.core.data.Matrix4.prototype.n33 = null;
sandy.core.data.Matrix4.prototype.n34 = null;
sandy.core.data.Matrix4.prototype.n41 = null;
sandy.core.data.Matrix4.prototype.n42 = null;
sandy.core.data.Matrix4.prototype.n43 = null;
sandy.core.data.Matrix4.prototype.n44 = null;
sandy.core.data.Matrix4.prototype.rotationX = function(angle) {
	this.identity();
	angle = sandy.util.NumberUtil.toRadian(angle);
	var c = ((sandy.core.data.Matrix4.USE_FAST_MATH == false)?Math.cos(angle):sandy.math.FastMath.cos(angle));
	var s = ((sandy.core.data.Matrix4.USE_FAST_MATH == false)?Math.sin(angle):sandy.math.FastMath.sin(angle));
	this.n22 = c;
	this.n23 = -s;
	this.n32 = s;
	this.n33 = c;
}
sandy.core.data.Matrix4.prototype.rotationY = function(angle) {
	this.identity();
	angle = sandy.util.NumberUtil.toRadian(angle);
	var c = ((sandy.core.data.Matrix4.USE_FAST_MATH == false)?Math.cos(angle):sandy.math.FastMath.cos(angle));
	var s = ((sandy.core.data.Matrix4.USE_FAST_MATH == false)?Math.sin(angle):sandy.math.FastMath.sin(angle));
	this.n11 = c;
	this.n13 = -s;
	this.n31 = s;
	this.n33 = c;
}
sandy.core.data.Matrix4.prototype.rotationZ = function(angle) {
	this.identity();
	angle = sandy.util.NumberUtil.toRadian(angle);
	var c = ((sandy.core.data.Matrix4.USE_FAST_MATH == false)?Math.cos(angle):sandy.math.FastMath.cos(angle));
	var s = ((sandy.core.data.Matrix4.USE_FAST_MATH == false)?Math.sin(angle):sandy.math.FastMath.sin(angle));
	this.n11 = c;
	this.n12 = -s;
	this.n21 = s;
	this.n22 = c;
}
sandy.core.data.Matrix4.prototype.scale = function(nXScale,nYScale,nZScale) {
	this.identity();
	this.n11 = nXScale;
	this.n22 = nYScale;
	this.n33 = nZScale;
}
sandy.core.data.Matrix4.prototype.scaleVector = function(v) {
	this.identity();
	this.n11 = v.x;
	this.n22 = v.y;
	this.n33 = v.z;
}
sandy.core.data.Matrix4.prototype.toString = function() {
	var s = "sandy.core.data.Matrix4" + "\n (";
	s += this.n11 + "\t" + this.n12 + "\t" + this.n13 + "\t" + this.n14 + "\n";
	s += this.n21 + "\t" + this.n22 + "\t" + this.n23 + "\t" + this.n24 + "\n";
	s += this.n31 + "\t" + this.n32 + "\t" + this.n33 + "\t" + this.n34 + "\n";
	s += this.n41 + "\t" + this.n42 + "\t" + this.n43 + "\t" + this.n44 + "\n)";
	return s;
}
sandy.core.data.Matrix4.prototype.translation = function(nTx,nTy,nTz) {
	this.identity();
	this.n14 = nTx;
	this.n24 = nTy;
	this.n34 = nTz;
}
sandy.core.data.Matrix4.prototype.translationVector = function(v) {
	this.identity();
	this.n14 = v.x;
	this.n24 = v.y;
	this.n34 = v.z;
}
sandy.core.data.Matrix4.prototype.vectorMult = function(pv) {
	var x = pv.x, y = pv.y, z = pv.z;
	pv.x = (x * this.n11 + y * this.n12 + z * this.n13 + this.n14);
	pv.y = (x * this.n21 + y * this.n22 + z * this.n23 + this.n24);
	pv.z = (x * this.n31 + y * this.n32 + z * this.n33 + this.n34);
}
sandy.core.data.Matrix4.prototype.vectorMult3x3 = function(pv) {
	var x = pv.x, y = pv.y, z = pv.z;
	pv.x = (x * this.n11 + y * this.n12 + z * this.n13);
	pv.y = (x * this.n21 + y * this.n22 + z * this.n23);
	pv.z = (x * this.n31 + y * this.n32 + z * this.n33);
}
sandy.core.data.Matrix4.prototype.zero = function() {
	this.n11 = 0;
	this.n12 = 0;
	this.n13 = 0;
	this.n14 = 0;
	this.n21 = 0;
	this.n22 = 0;
	this.n23 = 0;
	this.n24 = 0;
	this.n31 = 0;
	this.n32 = 0;
	this.n33 = 0;
	this.n34 = 0;
	this.n41 = 0;
	this.n42 = 0;
	this.n43 = 0;
	this.n44 = 0;
}
sandy.core.data.Matrix4.prototype.__class__ = sandy.core.data.Matrix4;
$Main = function() { }
$Main.__name__ = ["@Main"];
$Main.prototype.__class__ = $Main;
$_ = {}
js.Boot.__res = {}
js.Boot.__init();
{
	Math.NaN = Number["NaN"];
	Math.NEGATIVE_INFINITY = Number["NEGATIVE_INFINITY"];
	Math.POSITIVE_INFINITY = Number["POSITIVE_INFINITY"];
	Math.isFinite = function(i) {
		return isFinite(i);
	}
	Math.isNaN = function(i) {
		return isNaN(i);
	}
	Math.__name__ = ["Math"];
}
{
	js.Lib.document = document;
	js.Lib.window = window;
	onerror = function(msg,url,line) {
		var f = js.Lib.onerror;
		if( f == null )
			return false;
		return f(msg,[url+":"+line]);
	}
}
{
	Date.now = function() {
		return new Date();
	}
	Date.fromTime = function(t) {
		var d = new Date();
		d["setTime"](t);
		return d;
	}
	Date.fromString = function(s) {
		switch(s.length) {
		case 8:{
			var k = s.split(":");
			var d = new Date();
			d["setTime"](0);
			d["setUTCHours"](k[0]);
			d["setUTCMinutes"](k[1]);
			d["setUTCSeconds"](k[2]);
			return d;
		}break;
		case 10:{
			var k = s.split("-");
			return new Date(k[0],k[1] - 1,k[2],0,0,0);
		}break;
		case 19:{
			var k = s.split(" ");
			var y = k[0].split("-");
			var t = k[1].split(":");
			return new Date(y[0],y[1] - 1,y[2],t[0],t[1],t[2]);
		}break;
		default:{
			throw "Invalid date format : " + s;
		}break;
		}
	}
	Date.prototype["toString"] = function() {
		var date = this;
		var m = date.getMonth() + 1;
		var d = date.getDate();
		var h = date.getHours();
		var mi = date.getMinutes();
		var s = date.getSeconds();
		return date.getFullYear() + "-" + ((m < 10?"0" + m:"" + m)) + "-" + ((d < 10?"0" + d:"" + d)) + " " + ((h < 10?"0" + h:"" + h)) + ":" + ((mi < 10?"0" + mi:"" + mi)) + ":" + ((s < 10?"0" + s:"" + s));
	}
	Date.prototype.__class__ = Date;
	Date.__name__ = ["Date"];
}
{
	String.prototype.__class__ = String;
	String.__name__ = ["String"];
	Array.prototype.__class__ = Array;
	Array.__name__ = ["Array"];
	Int = { __name__ : ["Int"]}
	Dynamic = { __name__ : ["Dynamic"]}
	Float = Number;
	Float.__name__ = ["Float"];
	Bool = { __ename__ : ["Bool"]}
	Class = { __name__ : ["Class"]}
	Enum = { }
	Void = { __ename__ : ["Void"]}
}
{
	Xml = js.JsXml__;
	Xml.__name__ = ["Xml"];
	Xml.Element = "element";
	Xml.PCData = "pcdata";
	Xml.CData = "cdata";
	Xml.Comment = "comment";
	Xml.DocType = "doctype";
	Xml.Prolog = "prolog";
	Xml.Document = "document";
}
sandy.util.NumberUtil.__TWO_PI = 2 * Math.PI;
sandy.util.NumberUtil.__PI = Math.PI;
sandy.util.NumberUtil.__HALF_PI = 0.5 * Math.PI;
sandy.util.NumberUtil.__TO_DREGREE = 180 / Math.PI;
sandy.util.NumberUtil.__TO_RADIAN = Math.PI / 180;
sandy.util.NumberUtil.TOL = 0.00001;
neash.display.DisplayObject.TRANSLATE_CHANGE = 1;
neash.display.DisplayObject.NON_TRANSLATE_CHANGE = 2;
neash.display.DisplayObject.GRAPHICS_CHANGE = 4;
sandy.core.scenegraph.Node._ID_ = 0;
neash.text.FontInstance.mSolidFonts = new Hash();
neash.events.Listener.sIDs = 1;
neash.display.StageQuality.BEST = "best";
neash.display.StageQuality.HIGH = "high";
neash.display.StageQuality.MEDIUM = "medium";
neash.display.StageQuality.LOW = "low";
neash.text.KeyCode.KEY_0 = 48;
neash.text.KeyCode.KEY_1 = 49;
neash.text.KeyCode.KEY_2 = 50;
neash.text.KeyCode.KEY_3 = 51;
neash.text.KeyCode.KEY_4 = 52;
neash.text.KeyCode.KEY_5 = 53;
neash.text.KeyCode.KEY_6 = 54;
neash.text.KeyCode.KEY_7 = 55;
neash.text.KeyCode.KEY_8 = 56;
neash.text.KeyCode.KEY_9 = 57;
neash.text.KeyCode.A = 65;
neash.text.KeyCode.B = 66;
neash.text.KeyCode.C = 67;
neash.text.KeyCode.D = 68;
neash.text.KeyCode.E = 69;
neash.text.KeyCode.F = 70;
neash.text.KeyCode.G = 71;
neash.text.KeyCode.H = 72;
neash.text.KeyCode.I = 73;
neash.text.KeyCode.J = 74;
neash.text.KeyCode.K = 75;
neash.text.KeyCode.L = 76;
neash.text.KeyCode.M = 77;
neash.text.KeyCode.N = 78;
neash.text.KeyCode.O = 79;
neash.text.KeyCode.P = 80;
neash.text.KeyCode.Q = 81;
neash.text.KeyCode.R = 82;
neash.text.KeyCode.S = 83;
neash.text.KeyCode.T = 84;
neash.text.KeyCode.U = 85;
neash.text.KeyCode.V = 86;
neash.text.KeyCode.W = 87;
neash.text.KeyCode.X = 88;
neash.text.KeyCode.Y = 89;
neash.text.KeyCode.Z = 90;
neash.text.KeyCode.KP0 = 96;
neash.text.KeyCode.KP1 = 97;
neash.text.KeyCode.KP2 = 98;
neash.text.KeyCode.KP3 = 99;
neash.text.KeyCode.KP4 = 100;
neash.text.KeyCode.KP5 = 101;
neash.text.KeyCode.KP6 = 102;
neash.text.KeyCode.KP7 = 103;
neash.text.KeyCode.KP8 = 104;
neash.text.KeyCode.KP9 = 105;
neash.text.KeyCode.KP_MULTIPLY = 106;
neash.text.KeyCode.KP_ADD = 107;
neash.text.KeyCode.KP_ENTER = 108;
neash.text.KeyCode.KP_SUBTRACT = 109;
neash.text.KeyCode.KP_PERIOD = 110;
neash.text.KeyCode.KP_DIVIDE = 111;
neash.text.KeyCode.F1 = 112;
neash.text.KeyCode.F2 = 113;
neash.text.KeyCode.F3 = 114;
neash.text.KeyCode.F4 = 115;
neash.text.KeyCode.F5 = 116;
neash.text.KeyCode.F6 = 117;
neash.text.KeyCode.F7 = 118;
neash.text.KeyCode.F8 = 119;
neash.text.KeyCode.F9 = 120;
neash.text.KeyCode.F11 = 122;
neash.text.KeyCode.F12 = 123;
neash.text.KeyCode.F13 = 124;
neash.text.KeyCode.F14 = 125;
neash.text.KeyCode.F15 = 126;
neash.text.KeyCode.BACKSPACE = 8;
neash.text.KeyCode.TAB = 9;
neash.text.KeyCode.ENTER = 13;
neash.text.KeyCode.SHIFT = 16;
neash.text.KeyCode.CONTROL = 17;
neash.text.KeyCode.CAPSLOCK = 18;
neash.text.KeyCode.ESCAPE = 27;
neash.text.KeyCode.SPACE = 32;
neash.text.KeyCode.PAGEUP = 33;
neash.text.KeyCode.PAGEDOWN = 34;
neash.text.KeyCode.END = 35;
neash.text.KeyCode.HOME = 36;
neash.text.KeyCode.LEFT = 37;
neash.text.KeyCode.RIGHT = 38;
neash.text.KeyCode.UP = 39;
neash.text.KeyCode.DOWN = 40;
neash.text.KeyCode.INSERT = 45;
neash.text.KeyCode.DELETE = 46;
neash.text.KeyCode.NUMLOCK = 144;
neash.text.KeyCode.BREAK = 19;
canvas.Manager.closeKey = 27;
canvas.Manager.pauseUpdates = neash.text.KeyCode.F11;
canvas.Manager.toggleQuality = neash.text.KeyCode.F12;
canvas.Manager.FULLSCREEN = 1;
canvas.Manager.OPENGL = 2;
canvas.Manager.RESIZABLE = 4;
canvas.Manager.CURSOR_NONE = 0;
canvas.Manager.CURSOR_NORMAL = 1;
canvas.Manager.CURSOR_TEXT = 2;
neash.text.TextFormatAlign.LEFT = "left";
neash.text.TextFormatAlign.RIGHT = "right";
neash.text.TextFormatAlign.CENTER = "center";
neash.text.TextFormatAlign.JUSTIFY = "justify";
sandy.math.PlaneMath.NEGATIVE = -1;
sandy.math.PlaneMath.ON_PLANE = 0;
sandy.math.PlaneMath.POSITIVE = 1;
neash.events.Event.ACTIVATE = "activate";
neash.events.Event.ADDED = "added";
neash.events.Event.ADDED_TO_STAGE = "addedToStage";
neash.events.Event.CANCEL = "cancel";
neash.events.Event.CHANGE = "change";
neash.events.Event.CLOSE = "close";
neash.events.Event.COMPLETE = "complete";
neash.events.Event.CONNECT = "connect";
neash.events.Event.DEACTIVATE = "deactivate";
neash.events.Event.ENTER_FRAME = "enterFrame";
neash.events.Event.ID3 = "id3";
neash.events.Event.INIT = "init";
neash.events.Event.MOUSE_LEAVE = "mouseLeave";
neash.events.Event.OPEN = "open";
neash.events.Event.REMOVED = "removed";
neash.events.Event.REMOVED_FROM_STAGE = "removedFromStage";
neash.events.Event.RENDER = "render";
neash.events.Event.RESIZE = "resize";
neash.events.Event.SCROLL = "scroll";
neash.events.Event.SELECT = "select";
neash.events.Event.SOUND_COMPLETE = "soundComplete";
neash.events.Event.TAB_CHILDREN_CHANGE = "tabChildrenChange";
neash.events.Event.TAB_ENABLED_CHANGE = "tabEnabledChange";
neash.events.Event.TAB_INDEX_CHANGE = "tabIndexChange";
neash.events.Event.UNLOAD = "unload";
neash.events.KeyboardEvent.KEY_DOWN = "KEY_DOWN";
neash.events.KeyboardEvent.KEY_UP = "KEY_UP";
canvas.geom.Decompose.math = Math;
sandy.core.scenegraph.Group.children = new Array();
neash.events.FocusEvent.FOCUS_IN = "FOCUS_IN";
neash.events.FocusEvent.FOCUS_OUT = "FOCUS_OUT";
neash.events.FocusEvent.KEY_FOCUS_CHANGE = "KEY_FOCUS_CHANGE";
neash.events.FocusEvent.MOUSE_FOCUS_CHANGE = "MOUSE_FOCUS_CHANGE";
sandy.core.SandyFlags.POLYGON_NORMAL_WORLD = 1;
sandy.core.SandyFlags.VERTEX_NORMAL_WORLD = 2;
sandy.materials.Material._ID_ = 0;
canvas.geom.MatrixUtil.INVERT = "invert";
js.JsXml__.enode = new EReg("^<([a-zA-Z0-9:_-]+)","");
js.JsXml__.ecdata = new EReg("^<!\\[CDATA\\[","i");
js.JsXml__.edoctype = new EReg("^<!DOCTYPE","i");
js.JsXml__.eend = new EReg("^</([a-zA-Z0-9:_-]+)>","");
js.JsXml__.epcdata = new EReg("^[^<]+","");
js.JsXml__.ecomment = new EReg("^<!--","");
js.JsXml__.eprolog = new EReg("^<\\?[^\\?]+\\?>","");
js.JsXml__.eattribute = new EReg("^\\s*([a-zA-Z0-9:_-]+)\\s*=\\s*([\"'])([^\\2]*?)\\2","");
js.JsXml__.eclose = new EReg("^[ \\r\\n\\t]*(>|(/>))","");
js.JsXml__.ecdata_end = new EReg("\\]\\]>","");
js.JsXml__.edoctype_elt = new EReg("[\\[|\\]>]","");
js.JsXml__.ecomment_end = new EReg("-->","");
sandy.core.light.Light3D.MAX_POWER = 150;
neash.swf.Tags.End = 0;
neash.swf.Tags.ShowFrame = 1;
neash.swf.Tags.DefineShape = 2;
neash.swf.Tags.FreeCharacter = 3;
neash.swf.Tags.PlaceObject = 4;
neash.swf.Tags.RemoveObject = 5;
neash.swf.Tags.DefineBits = 6;
neash.swf.Tags.DefineButton = 7;
neash.swf.Tags.JPEGTables = 8;
neash.swf.Tags.SetBackgroundColor = 9;
neash.swf.Tags.DefineFont = 10;
neash.swf.Tags.DefineText = 11;
neash.swf.Tags.DoAction = 12;
neash.swf.Tags.DefineFontInfo = 13;
neash.swf.Tags.DefineSound = 14;
neash.swf.Tags.StartSound = 15;
neash.swf.Tags.StopSound = 16;
neash.swf.Tags.DefineButtonSound = 17;
neash.swf.Tags.SoundStreamHead = 18;
neash.swf.Tags.SoundStreamBlock = 19;
neash.swf.Tags.DefineBitsLossless = 20;
neash.swf.Tags.DefineBitsJPEG2 = 21;
neash.swf.Tags.DefineShape2 = 22;
neash.swf.Tags.DefineButtonCxform = 23;
neash.swf.Tags.Protect = 24;
neash.swf.Tags.PathsArePostScript = 25;
neash.swf.Tags.PlaceObject2 = 26;
neash.swf.Tags.c27 = 27;
neash.swf.Tags.RemoveObject2 = 28;
neash.swf.Tags.SyncFrame = 29;
neash.swf.Tags.c30 = 30;
neash.swf.Tags.FreeAll = 31;
neash.swf.Tags.DefineShape3 = 32;
neash.swf.Tags.DefineText2 = 33;
neash.swf.Tags.DefineButton2 = 34;
neash.swf.Tags.DefineBitsJPEG3 = 35;
neash.swf.Tags.DefineBitsLossless2 = 36;
neash.swf.Tags.DefineEditText = 37;
neash.swf.Tags.DefineVideo = 38;
neash.swf.Tags.DefineSprite = 39;
neash.swf.Tags.NameCharacter = 40;
neash.swf.Tags.ProductInfo = 41;
neash.swf.Tags.DefineTextFormat = 42;
neash.swf.Tags.FrameLabel = 43;
neash.swf.Tags.DefineBehavior = 44;
neash.swf.Tags.SoundStreamHead2 = 45;
neash.swf.Tags.DefineMorphShape = 46;
neash.swf.Tags.FrameTag = 47;
neash.swf.Tags.DefineFont2 = 48;
neash.swf.Tags.GenCommand = 49;
neash.swf.Tags.DefineCommandObj = 50;
neash.swf.Tags.CharacterSet = 51;
neash.swf.Tags.FontRef = 52;
neash.swf.Tags.DefineFunction = 53;
neash.swf.Tags.PlaceFunction = 54;
neash.swf.Tags.GenTagObject = 55;
neash.swf.Tags.ExportAssets = 56;
neash.swf.Tags.ImportAssets = 57;
neash.swf.Tags.EnableDebugger = 58;
neash.swf.Tags.DoInitAction = 59;
neash.swf.Tags.DefineVideoStream = 60;
neash.swf.Tags.VideoFrame = 61;
neash.swf.Tags.DefineFontInfo2 = 62;
neash.swf.Tags.DebugID = 63;
neash.swf.Tags.EnableDebugger2 = 64;
neash.swf.Tags.ScriptLimits = 65;
neash.swf.Tags.SetTabIndex = 66;
neash.swf.Tags.DefineShape4_hmm = 67;
neash.swf.Tags.c68 = 68;
neash.swf.Tags.FileAttributes = 69;
neash.swf.Tags.PlaceObject3 = 70;
neash.swf.Tags.ImportAssets2 = 71;
neash.swf.Tags.DoABC = 72;
neash.swf.Tags.DefineFontAlignZones = 73;
neash.swf.Tags.CSMTextSettings = 74;
neash.swf.Tags.DefineFont3 = 75;
neash.swf.Tags.SymbolClass = 76;
neash.swf.Tags.MetaData = 77;
neash.swf.Tags.DefineScalingGrid = 78;
neash.swf.Tags.c79 = 79;
neash.swf.Tags.c80 = 80;
neash.swf.Tags.c81 = 81;
neash.swf.Tags.DoABC2 = 82;
neash.swf.Tags.DefineShape4 = 83;
neash.swf.Tags.DefineMorphShape2 = 84;
neash.swf.Tags.c85 = 85;
neash.swf.Tags.DefineSceneAndFrameLabelData = 86;
neash.swf.Tags.DefineBinaryData = 87;
neash.swf.Tags.DefineFontName = 88;
neash.swf.Tags.StartSound2 = 89;
neash.swf.Tags.LAST = 90;
neash.swf.Tags.tags = ["End","ShowFrame","DefineShape","FreeCharacter","PlaceObject","RemoveObject","DefineBits","DefineButton","JPEGTables","SetBackgroundColor","DefineFont","DefineText","DoAction","DefineFontInfo","DefineSound","StartSound","StopSound","DefineButtonSound","SoundStreamHead","SoundStreamBlock","DefineBitsLossless","DefineBitsJPEG2","DefineShape2","DefineButtonCxform","Protect","PathsArePostScript","PlaceObject2","27 (invalid)","RemoveObject2","SyncFrame","30 (invalid)","FreeAll","DefineShape3","DefineText2","DefineButton2","DefineBitsJPEG3","DefineBitsLossless2","DefineEditText","DefineVideo","DefineSprite","NameCharacter","ProductInfo","DefineTextFormat","FrameLabel","DefineBehavior","SoundStreamHead2","DefineMorphShape","FrameTag","DefineFont2","GenCommand","DefineCommandObj","CharacterSet","FontRef","DefineFunction","PlaceFunction","GenTagObject","ExportAssets","ImportAssets","EnableDebugger","DoInitAction","DefineVideoStream","VideoFrame","DefineFontInfo2","DebugID","EnableDebugger2","ScriptLimits","SetTabIndex","DefineShape4","DefineMorphShape2","FileAttributes","PlaceObject3","ImportAssets2","DoABC","DefineFontAlignZones","CSMTextSettings","DefineFont3","SymbolClass","Metadata","DefineScalingGrid","79 (invalid)","80 (invalid)","81 (invalid)","DoABC2","DefineShape4","DefineMorphShape2","c85","DefineSceneAndFrameLabelData","DefineBinaryData","DefineFontName","StartSound2","LAST"];
neash.text.TextFieldAutoSize.CENTER = "CENTER";
neash.text.TextFieldAutoSize.LEFT = "LEFT";
neash.text.TextFieldAutoSize.NONE = "NONE";
neash.text.TextFieldAutoSize.RIGHT = "RIGHT";
js.Lib.onerror = null;
sandy.core.scenegraph.Shape3D.DEFAULT_MATERIAL = new sandy.materials.WireFrameMaterial();
sandy.core.scenegraph.Shape3D.DEFAULT_APPEARANCE = new sandy.materials.Appearance(sandy.core.scenegraph.Shape3D.DEFAULT_MATERIAL);
haxe.Timer.arr = new Array();
neash.Lib.mShowCursor = true;
neash.Lib.mShowFPS = false;
neash.Lib.mDragObject = null;
neash.Lib.mDragRect = null;
neash.Lib.mDragOffsetX = 0;
neash.Lib.mDragOffsetY = 0;
neash.Lib.mLastMouse = new canvas.geom.Point();
neash.Lib.starttime = haxe.Timer.stamp();
sandy.materials.MovieMaterial.DEFAULT_FILL_COLOR = 0;
neash.text.FontManager.mFontMap = new Hash();
neash.text.FontManager.mSWFFonts = new Hash();
sandy.math.FastMath.PRECISION = 131072;
sandy.math.FastMath.TWO_PI = 2 * Math.PI;
sandy.math.FastMath.HALF_PI = Math.PI / 2;
sandy.math.FastMath.PRECISION_S = sandy.math.FastMath.PRECISION - 1;
sandy.math.FastMath.PRECISION_DIV_2PI = sandy.math.FastMath.PRECISION / sandy.math.FastMath.TWO_PI;
canvas.KeyCode.UNKNOWN = 0;
canvas.KeyCode.FIRST = 0;
canvas.KeyCode.BACKSPACE = 8;
canvas.KeyCode.TAB = 9;
canvas.KeyCode.CLEAR = 12;
canvas.KeyCode.RETURN = 13;
canvas.KeyCode.PAUSE = 19;
canvas.KeyCode.ESCAPE = 27;
canvas.KeyCode.SPACE = 32;
canvas.KeyCode.EXCLAIM = 33;
canvas.KeyCode.QUOTEDBL = 34;
canvas.KeyCode.HASH = 35;
canvas.KeyCode.DOLLAR = 36;
canvas.KeyCode.AMPERSAND = 38;
canvas.KeyCode.QUOTE = 39;
canvas.KeyCode.LEFTPAREN = 40;
canvas.KeyCode.RIGHTPAREN = 41;
canvas.KeyCode.ASTERISK = 42;
canvas.KeyCode.PLUS = 43;
canvas.KeyCode.COMMA = 44;
canvas.KeyCode.MINUS = 45;
canvas.KeyCode.PERIOD = 46;
canvas.KeyCode.SLASH = 47;
canvas.KeyCode.KEY_0 = 48;
canvas.KeyCode.KEY_1 = 49;
canvas.KeyCode.KEY_2 = 50;
canvas.KeyCode.KEY_3 = 51;
canvas.KeyCode.KEY_4 = 52;
canvas.KeyCode.KEY_5 = 53;
canvas.KeyCode.KEY_6 = 54;
canvas.KeyCode.KEY_7 = 55;
canvas.KeyCode.KEY_8 = 56;
canvas.KeyCode.KEY_9 = 57;
canvas.KeyCode.COLON = 58;
canvas.KeyCode.SEMICOLON = 59;
canvas.KeyCode.LESS = 60;
canvas.KeyCode.EQUALS = 61;
canvas.KeyCode.GREATER = 62;
canvas.KeyCode.QUESTION = 63;
canvas.KeyCode.AT = 64;
canvas.KeyCode.LEFTBRACKET = 91;
canvas.KeyCode.BACKSLASH = 92;
canvas.KeyCode.RIGHTBRACKET = 93;
canvas.KeyCode.CARET = 94;
canvas.KeyCode.UNDERSCORE = 95;
canvas.KeyCode.BACKQUOTE = 96;
canvas.KeyCode.a = 97;
canvas.KeyCode.b = 98;
canvas.KeyCode.c = 99;
canvas.KeyCode.d = 100;
canvas.KeyCode.e = 101;
canvas.KeyCode.f = 102;
canvas.KeyCode.g = 103;
canvas.KeyCode.h = 104;
canvas.KeyCode.i = 105;
canvas.KeyCode.j = 106;
canvas.KeyCode.k = 107;
canvas.KeyCode.l = 108;
canvas.KeyCode.m = 109;
canvas.KeyCode.n = 110;
canvas.KeyCode.o = 111;
canvas.KeyCode.p = 112;
canvas.KeyCode.q = 113;
canvas.KeyCode.r = 114;
canvas.KeyCode.s = 115;
canvas.KeyCode.t = 116;
canvas.KeyCode.u = 117;
canvas.KeyCode.v = 118;
canvas.KeyCode.w = 119;
canvas.KeyCode.x = 120;
canvas.KeyCode.y = 121;
canvas.KeyCode.z = 122;
canvas.KeyCode.DELETE = 127;
canvas.KeyCode.WORLD_0 = 160;
canvas.KeyCode.WORLD_1 = 161;
canvas.KeyCode.WORLD_2 = 162;
canvas.KeyCode.WORLD_3 = 163;
canvas.KeyCode.WORLD_4 = 164;
canvas.KeyCode.WORLD_5 = 165;
canvas.KeyCode.WORLD_6 = 166;
canvas.KeyCode.WORLD_7 = 167;
canvas.KeyCode.WORLD_8 = 168;
canvas.KeyCode.WORLD_9 = 169;
canvas.KeyCode.WORLD_10 = 170;
canvas.KeyCode.WORLD_11 = 171;
canvas.KeyCode.WORLD_12 = 172;
canvas.KeyCode.WORLD_13 = 173;
canvas.KeyCode.WORLD_14 = 174;
canvas.KeyCode.WORLD_15 = 175;
canvas.KeyCode.WORLD_16 = 176;
canvas.KeyCode.WORLD_17 = 177;
canvas.KeyCode.WORLD_18 = 178;
canvas.KeyCode.WORLD_19 = 179;
canvas.KeyCode.WORLD_20 = 180;
canvas.KeyCode.WORLD_21 = 181;
canvas.KeyCode.WORLD_22 = 182;
canvas.KeyCode.WORLD_23 = 183;
canvas.KeyCode.WORLD_24 = 184;
canvas.KeyCode.WORLD_25 = 185;
canvas.KeyCode.WORLD_26 = 186;
canvas.KeyCode.WORLD_27 = 187;
canvas.KeyCode.WORLD_28 = 188;
canvas.KeyCode.WORLD_29 = 189;
canvas.KeyCode.WORLD_30 = 190;
canvas.KeyCode.WORLD_31 = 191;
canvas.KeyCode.WORLD_32 = 192;
canvas.KeyCode.WORLD_33 = 193;
canvas.KeyCode.WORLD_34 = 194;
canvas.KeyCode.WORLD_35 = 195;
canvas.KeyCode.WORLD_36 = 196;
canvas.KeyCode.WORLD_37 = 197;
canvas.KeyCode.WORLD_38 = 198;
canvas.KeyCode.WORLD_39 = 199;
canvas.KeyCode.WORLD_40 = 200;
canvas.KeyCode.WORLD_41 = 201;
canvas.KeyCode.WORLD_42 = 202;
canvas.KeyCode.WORLD_43 = 203;
canvas.KeyCode.WORLD_44 = 204;
canvas.KeyCode.WORLD_45 = 205;
canvas.KeyCode.WORLD_46 = 206;
canvas.KeyCode.WORLD_47 = 207;
canvas.KeyCode.WORLD_48 = 208;
canvas.KeyCode.WORLD_49 = 209;
canvas.KeyCode.WORLD_50 = 210;
canvas.KeyCode.WORLD_51 = 211;
canvas.KeyCode.WORLD_52 = 212;
canvas.KeyCode.WORLD_53 = 213;
canvas.KeyCode.WORLD_54 = 214;
canvas.KeyCode.WORLD_55 = 215;
canvas.KeyCode.WORLD_56 = 216;
canvas.KeyCode.WORLD_57 = 217;
canvas.KeyCode.WORLD_58 = 218;
canvas.KeyCode.WORLD_59 = 219;
canvas.KeyCode.WORLD_60 = 220;
canvas.KeyCode.WORLD_61 = 221;
canvas.KeyCode.WORLD_62 = 222;
canvas.KeyCode.WORLD_63 = 223;
canvas.KeyCode.WORLD_64 = 224;
canvas.KeyCode.WORLD_65 = 225;
canvas.KeyCode.WORLD_66 = 226;
canvas.KeyCode.WORLD_67 = 227;
canvas.KeyCode.WORLD_68 = 228;
canvas.KeyCode.WORLD_69 = 229;
canvas.KeyCode.WORLD_70 = 230;
canvas.KeyCode.WORLD_71 = 231;
canvas.KeyCode.WORLD_72 = 232;
canvas.KeyCode.WORLD_73 = 233;
canvas.KeyCode.WORLD_74 = 234;
canvas.KeyCode.WORLD_75 = 235;
canvas.KeyCode.WORLD_76 = 236;
canvas.KeyCode.WORLD_77 = 237;
canvas.KeyCode.WORLD_78 = 238;
canvas.KeyCode.WORLD_79 = 239;
canvas.KeyCode.WORLD_80 = 240;
canvas.KeyCode.WORLD_81 = 241;
canvas.KeyCode.WORLD_82 = 242;
canvas.KeyCode.WORLD_83 = 243;
canvas.KeyCode.WORLD_84 = 244;
canvas.KeyCode.WORLD_85 = 245;
canvas.KeyCode.WORLD_86 = 246;
canvas.KeyCode.WORLD_87 = 247;
canvas.KeyCode.WORLD_88 = 248;
canvas.KeyCode.WORLD_89 = 249;
canvas.KeyCode.WORLD_90 = 250;
canvas.KeyCode.WORLD_91 = 251;
canvas.KeyCode.WORLD_92 = 252;
canvas.KeyCode.WORLD_93 = 253;
canvas.KeyCode.WORLD_94 = 254;
canvas.KeyCode.WORLD_95 = 255;
canvas.KeyCode.KP0 = 256;
canvas.KeyCode.KP1 = 257;
canvas.KeyCode.KP2 = 258;
canvas.KeyCode.KP3 = 259;
canvas.KeyCode.KP4 = 260;
canvas.KeyCode.KP5 = 261;
canvas.KeyCode.KP6 = 262;
canvas.KeyCode.KP7 = 263;
canvas.KeyCode.KP8 = 264;
canvas.KeyCode.KP9 = 265;
canvas.KeyCode.KP_PERIOD = 266;
canvas.KeyCode.KP_DIVIDE = 267;
canvas.KeyCode.KP_MULTIPLY = 268;
canvas.KeyCode.KP_MINUS = 269;
canvas.KeyCode.KP_PLUS = 270;
canvas.KeyCode.KP_ENTER = 271;
canvas.KeyCode.KP_EQUALS = 272;
canvas.KeyCode.UP = 273;
canvas.KeyCode.DOWN = 274;
canvas.KeyCode.RIGHT = 275;
canvas.KeyCode.LEFT = 276;
canvas.KeyCode.INSERT = 277;
canvas.KeyCode.HOME = 278;
canvas.KeyCode.END = 279;
canvas.KeyCode.PAGEUP = 280;
canvas.KeyCode.PAGEDOWN = 281;
canvas.KeyCode.F1 = 282;
canvas.KeyCode.F2 = 283;
canvas.KeyCode.F3 = 284;
canvas.KeyCode.F4 = 285;
canvas.KeyCode.F5 = 286;
canvas.KeyCode.F6 = 287;
canvas.KeyCode.F7 = 288;
canvas.KeyCode.F8 = 289;
canvas.KeyCode.F9 = 290;
canvas.KeyCode.F10 = 291;
canvas.KeyCode.F11 = 292;
canvas.KeyCode.F12 = 293;
canvas.KeyCode.F13 = 294;
canvas.KeyCode.F14 = 295;
canvas.KeyCode.F15 = 296;
canvas.KeyCode.NUMLOCK = 300;
canvas.KeyCode.CAPSLOCK = 301;
canvas.KeyCode.SCROLLOCK = 302;
canvas.KeyCode.RSHIFT = 303;
canvas.KeyCode.LSHIFT = 304;
canvas.KeyCode.RCTRL = 305;
canvas.KeyCode.LCTRL = 306;
canvas.KeyCode.RALT = 307;
canvas.KeyCode.LALT = 308;
canvas.KeyCode.RMETA = 309;
canvas.KeyCode.LMETA = 310;
canvas.KeyCode.LSUPER = 311;
canvas.KeyCode.RSUPER = 312;
canvas.KeyCode.MODE = 313;
canvas.KeyCode.COMPOSE = 314;
canvas.KeyCode.HELP = 315;
canvas.KeyCode.PRINT = 316;
canvas.KeyCode.SYSREQ = 317;
canvas.KeyCode.BREAK = 318;
canvas.KeyCode.MENU = 319;
canvas.KeyCode.POWER = 320;
canvas.KeyCode.EURO = 321;
canvas.KeyCode.UNDO = 322;
canvas.display.Graphics.defaultFontName = "ARIAL.TTF";
canvas.display.Graphics.defaultFontSize = 12;
canvas.display.Graphics.immediateMatrix = null;
canvas.display.Graphics.immediateMask = null;
canvas.display.Graphics.TOP = 0;
canvas.display.Graphics.CENTER = 1;
canvas.display.Graphics.BOTTOM = 2;
canvas.display.Graphics.LEFT = 0;
canvas.display.Graphics.RIGHT = 2;
canvas.display.Graphics.RADIAL = 1;
canvas.display.Graphics.REPEAT = 2;
canvas.display.Graphics.REFLECT = 4;
canvas.display.Graphics.EDGE_MASK = 240;
canvas.display.Graphics.EDGE_CLAMP = 0;
canvas.display.Graphics.EDGE_REPEAT = 16;
canvas.display.Graphics.EDGE_UNCHECKED = 32;
canvas.display.Graphics.EDGE_REPEAT_POW2 = 48;
canvas.display.Graphics.END_NONE = 0;
canvas.display.Graphics.END_ROUND = 256;
canvas.display.Graphics.END_SQUARE = 512;
canvas.display.Graphics.END_MASK = 768;
canvas.display.Graphics.END_SHIFT = 8;
canvas.display.Graphics.CORNER_ROUND = 0;
canvas.display.Graphics.CORNER_MITER = 4096;
canvas.display.Graphics.CORNER_BEVEL = 8192;
canvas.display.Graphics.CORNER_MASK = 12288;
canvas.display.Graphics.CORNER_SHIFT = 12;
canvas.display.Graphics.PIXEL_HINTING = 16384;
canvas.display.Graphics.BMP_REPEAT = 16;
canvas.display.Graphics.BMP_SMOOTH = 65536;
canvas.display.Graphics.SCALE_NONE = 0;
canvas.display.Graphics.SCALE_VERTICAL = 1;
canvas.display.Graphics.SCALE_HORIZONTAL = 2;
canvas.display.Graphics.SCALE_NORMAL = 3;
canvas.display.Graphics.MOVE = 0;
canvas.display.Graphics.LINE = 1;
canvas.display.Graphics.CURVE = 2;
haxe.xml.Check.blanks = new EReg("^[ \\r\\n\\t]*$","");
sandy.view.Frustum.NEAR = 0;
sandy.view.Frustum.FAR = 1;
sandy.view.Frustum.RIGHT = 2;
sandy.view.Frustum.LEFT = 3;
sandy.view.Frustum.TOP = 4;
sandy.view.Frustum.BOTTOM = 5;
sandy.view.Frustum.EPSILON = 0.005;
sandy.view.Frustum.INSIDE = sandy.view.CullingState.INSIDE;
sandy.view.Frustum.OUTSIDE = sandy.view.CullingState.OUTSIDE;
sandy.view.Frustum.INTERSECT = sandy.view.CullingState.INTERSECT;
sandy.events.SandyEvent.LIGHT_ADDED = "lightAdded";
sandy.events.SandyEvent.LIGHT_UPDATED = "lightUpdated";
sandy.events.SandyEvent.LIGHT_COLOR_CHANGED = "lightColorChanged";
sandy.events.SandyEvent.SCENE_RENDER = "scene_render";
sandy.events.SandyEvent.SCENE_CULL = "scene_cull";
sandy.events.SandyEvent.SCENE_UPDATE = "scene_update";
sandy.events.SandyEvent.SCENE_RENDER_DISPLAYLIST = "scene_render_display_list";
sandy.events.SandyEvent.CONTAINER_CREATED = "containerCreated";
sandy.events.SandyEvent.QUEUE_COMPLETE = "queueComplete";
sandy.events.SandyEvent.QUEUE_LOADER_ERROR = "queueLoaderError";
sandy.core.data.Polygon._ID_ = 0;
sandy.core.data.Polygon.POLYGON_MAP = new IntHash();
neash.events.MouseEvent.CLICK = "click";
neash.events.MouseEvent.DOUBLE_CLICK = "doubleClick";
neash.events.MouseEvent.MOUSE_DOWN = "mouseDown";
neash.events.MouseEvent.MOUSE_MOVE = "mouseMove";
neash.events.MouseEvent.MOUSE_OUT = "mouseOut";
neash.events.MouseEvent.MOUSE_OVER = "mouseOver";
neash.events.MouseEvent.MOUSE_UP = "mouseUp";
neash.events.MouseEvent.MOUSE_WHEEL = "mouseWheel";
neash.events.MouseEvent.ROLL_OUT = "rollOut";
neash.events.MouseEvent.ROLL_OVER = "rollOver";
sandy.events.EventListener.sIDs = 1;
canvas.text.TextField.mDefaultFont = "Times";
canvas.text.TextField.sSelectionOwner = null;
neash.events.EventPhase.CAPTURING_PHASE = 0;
neash.events.EventPhase.AT_TARGET = 1;
neash.events.EventPhase.BUBBLING_PHASE = 2;
neash.text.TextFieldType.DYNAMIC = "DYNAMIC";
neash.text.TextFieldType.INPUT = "INPUT";
sandy.core.data.Matrix4.USE_FAST_MATH = false;
$Main.init = Simple.main();
