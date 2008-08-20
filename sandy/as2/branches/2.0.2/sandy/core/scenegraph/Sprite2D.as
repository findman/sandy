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
import com.bourre.commands.Delegate;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.EventType;
	
import sandy.bounds.BSphere;
import sandy.core.Scene3D;
import sandy.core.data.Matrix4;
import sandy.core.data.Vertex;
import sandy.core.scenegraph.ATransformable;
import sandy.core.scenegraph.IDisplayable;
import sandy.core.scenegraph.Camera3D;
import sandy.events.MouseEvent;
import sandy.materials.Material;
import sandy.view.CullingState;
import sandy.view.Frustum;
	
/**
 * The Sprite2D class is used to create a 2D sprite.
 *
 * <p>A Sprite2D object is used to display a static or dynamic texture in the Sandy world.<br/>
 * The sprite always shows the same side to the camera. This is useful when you want to show more
 * or less complex images, without heavy calculations of perspective distortion.</p>
 * <p>The Sprite2D has a fixed bounding sphere radius, set by default to 30.<br />
 * In case your sprite is bigger, you can adjust it to avoid any frustum culling issue</p>
 * 
 * @author		Thomas Pfeiffer - kiroukou
 * @author		(porting) Floris - FFlasher
 * @version		2.0.2
 * @date 		26.07.2007
 */
class sandy.core.scenegraph.Sprite2D extends ATransformable implements IDisplayable
{	

	// FIXME Create a Sprite as the spriteD container, 
	//and offer a method to attach a visual content as a child of the sprite
	
	/**
	 * Set this to true if you want this sprite to rotate with camera.
	 */
	public var fixedAngle:Boolean = false;

	/**
	 * When enabled, the sprite will be displayed at its graphical center.
	 * Otherwise its top left corner will be set at the computed screen position
	 */
	public var autoCenter:Boolean = true;
	
	/**
	 * When enabled, the sprite will be displayed at its bottom line.
	 * Otherwise it is positioned at its registration point (usually top left corner).
	 * This property has no effect when autoCenter is enabled.
	 */
	public var floorCenter:Boolean = false;
		
	/**
	 * Creates a Sprite2D.
	 *
	 * @param p_sName	A string identifier for this object
	 * @param p_nScale 	A number used to change the scale of the displayed object.
	 * 			In case that the object projected dimension
	 *			isn't adapted to your needs. 
	 *			Default value is 1.0 which means unchanged. 
	 * 			A value of 2.0 will make the object will double the size
	 */	
	public function Sprite2D( p_sName:String, p_oContent:MovieClip, p_nScale:Number ) 
	{
		super( p_sName||"" );
		m_oContainer = new MovieClip();
		// --
		_v = new Vertex(); _vx = new Vertex(); _vy = new Vertex();
		boundingSphere 	= new BSphere();
        boundingBox		= null;
        // --
		_nScale = p_nScale||1;
		// --
		if( p_oContent ) content = p_oContent;
		
		setBoundingSphereRadius( 30 );
	}

	/**
	 * Gives access to your content reference.
	 * The content is the exact visual object you passed to the constructor.
	 * In comparison with the container which is the container of the content (in Sandy's architecture, the container must be a Sprite),
	 * but the content can be any kind of visual object AS3 offers (MovieClip, Bitmap, Sprite etc.)
	 * WARNNIG: Be careful when manipulating the content object to not break any link with the sandy container (content.parent).
	 */
	public function get content() : MovieClip
	{
		return m_oContainer;
	}
	
	/**
	 * The DisplayObject that will used as content of this Sprite2D. 
	 * If this DisplayObject has already a screen position, it will be reseted to 0,0.
	 * If the DisplayObject has allready a parent, it will be unrelated from it automatically. (its transform matrix property is resetted to identity too).
	 * @param p_content The DisplayObject to attach to the Sprite2D#container. 
	 */
	public function set content( p_content:MovieClip ) : Void
	{
		// if( p_content.transform ) p_content.transform.matrix.identity();
		p_content.transform.matrix.identity();
		m_oContainer = p_content;
		m_nW2 = m_oContainer._width / 2;
		m_nH2 = m_oContainer._height / 2;
	}
			
	/**
	 * The container of this sprite ( canvas )
	 */
	public function get container() : MovieClip
	{
		return m_oContainer;
	}

	/**
	 * Sets the radius of bounding sphere for this sprite.
	 *
	 * @param p_nRadius	The radius
	 */
	public function setBoundingSphereRadius( p_nRadius:Number ) : Void
	{
		boundingSphere.radius = p_nRadius;
	}

	/**
	 * The scale of this sprite.
	 *
	 * <p>Using scale, you can change the dimension of the sprite rapidly.</p>
	 */
	public function get scale() : Number
	{ 
		return _nScale; 
	}
	
	/**
	 * @private
	 */
	public function set scale( n:Number ) : Void
	{
		if( n )	_nScale = n; 
	}
		
	/**
	 * The depth to draw this sprite at.
	 * <p>[<b>ToDo</b>: Explain ]</p>
	 */
	public function get depth() : Number
	{
		return m_nDepth;
	}
		  
	/**
	 * Tests this node against the camera frustum to get its visibility.
	 *
	 * <p>If this node and its children are not within the frustum, 
	 * the node is set to cull and it would not be displayed.<p/>
	 * <p>The method also updates the bounding volumes to make the more accurate culling system possible.<br/>
	 * First the bounding sphere is updated, and if intersecting, 
	 * the bounding box is updated to perform the more precise culling.</p>
	 * <p><b>[MANDATORY] The update method must be called first!</b></p>
	 *
	 * @param p_oScene The current scene
	 * @param p_oFrustum	The frustum of the current camera
	 * @param p_oViewMatrix	The view matrix of the current camera
	 * @param p_bChanged
	 */
	public function cull( p_oScene:Scene3D, p_oFrustum:Frustum, p_oViewMatrix:Matrix4, p_bChanged:Boolean ) : Void
	{
		super.cull( p_oScene, p_oFrustum, p_oViewMatrix, p_bChanged );			
		if( visible == false )
		{
			container.visible = visible;
			return;
		}
		// --
		if( viewMatrix )
		{
			/////////////////////////
	        //// BOUNDING SPHERE ////
	        /////////////////////////
	        boundingSphere.transform( viewMatrix );
	        culled = p_oFrustum.sphereInFrustum( boundingSphere );
		}
		// --
		if( culled == CullingState.OUTSIDE ) 	
			container.visible = false;
		else if( culled == CullingState.INTERSECT ) 
		{
			if( boundingSphere.position.z <= p_oScene.camera.near ) 
				container.visible = false;
			else 
				container.visible = true;
		}
		else	
			container.visible = true;
	}
	
	/**
	 * Renders this 2D sprite
	 *
	 * @param p_oScene The current scene
	 * @param p_oCamera	The current camera
	 */
	public function render( p_oScene:Scene3D, p_oCamera:Camera3D ) : Void
	{
		if ( ( m_oMaterial != null ) && !p_oScene.materialManager.isRegistered( m_oMaterial ) )
		{
			p_oScene.materialManager.register( m_oMaterial );
		}

		_v.wx = _v.x * viewMatrix.n11 + _v.y * viewMatrix.n12 + _v.z * viewMatrix.n13 + viewMatrix.n14;
		_v.wy = _v.x * viewMatrix.n21 + _v.y * viewMatrix.n22 + _v.z * viewMatrix.n23 + viewMatrix.n24;
		_v.wz = _v.x * viewMatrix.n31 + _v.y * viewMatrix.n32 + _v.z * viewMatrix.n33 + viewMatrix.n34;

		m_nDepth = enableForcedDepth ? forcedDepth : _v.wz;

		p_oCamera.projectVertex( _v );
		p_oCamera.addToDisplayList( this );

		_vx.copy ( _v ); _vx.wx++; p_oCamera.projectVertex ( _vx );
		_vy.copy ( _v ); _vy.wy++; p_oCamera.projectVertex ( _vy );

		m_nPerspScaleX = _nScale * ( _vx.sx - _v.sx );
		m_nPerspScaleY = _nScale * ( _v.sy - _vy.sy );

		m_nRotation = Math.atan2( viewMatrix.n12, viewMatrix.n22 );
	}

	/**
	 * Clears the graphics object of this object's container.
	 *
	 * <p>The graphics that were drawn on the Graphics object is erased, 
	 * and the fill and line style settings are reset.</p>
	 */	
	public function clear() : Void
	{
		;//m_oContainer.graphics.clear();
	}
		
		
	/**
	 * Provide the classical remove behaviour, plus remove the container to the display list.
	 */
	public function remove() : Void
	{
		if( m_oContainer ) m_oContainer.removeMovieClip();
		m_oContainer.clear();
		enableEvents = false;
		if ( ( m_oMaterial != null ) && !scene.materialManager.isRegistered( m_oMaterial ) )
		{
			scene.materialManager.unregister( m_oMaterial );
		}
		super.remove();
	}
	
	/**
	 * @inheritDoc
	 */
	public function destroy() : Void
	{
		remove(); super.destroy ();
	}
		
	/**
	 * Displays this sprite.
	 *
	 * <p>display the object onto the scene.
	 * If the object has autocenter enabled, sprite center is set at screen position.
	 * Otherwise the sprite top left corner will be at that position.</p>
	 *
	 * @param p_oScene The current scene
	 * @param p_oContainer	The container to draw on
	 */
	public function display( p_oScene:Scene3D, p_oContainer:MovieClip ) : Void
	{
		m_oContainer._xscale = m_nPerspScaleX;
		m_oContainer._yscale = m_nPerspScaleY;
			
		m_oContainer.x = _v.sx - ( autoCenter ? m_oContainer._width / 2 : 0 );
		m_oContainer.y = _v.sy - ( autoCenter ? m_oContainer._height / 2 : 0 );
		
		m_oContainer.y = _v.sy - ( autoCenter ? m_oContainer._height / 2 : ( floorCenter ? m_oContainer._height : 0 ) );
		
		// --
		if ( fixedAngle ) m_oContainer.rotation = m_nRotation * 180 / Math.PI;
		// --
		if ( m_oMaterial ) m_oMaterial.renderSprite( this, m_oMaterial, p_oScene );
	}

	/**
	 * Material that the sprite will be dressed in. Use it to apply some attributes
	 * to sprite, such as light attributes.
	 */
	public function get material() : Material
	{
		return m_oMaterial;
	}

	/**
	 * @private
	 */
	public function set material( p_oMaterial:Material ) : Void
	{
		m_oMaterial = p_oMaterial;
	}

	/**
	 * Should forced depth be enable for this object?.
	 *
	 * <p>If true it is possible to force this object to be drawn at a specific depth,<br/>
	 * if false the normal Z-sorting algorithm is applied.</p>
	 * <p>When correctly used, this feature allows you to avoid some Z-sorting problems.</p>
	 */
	public var enableForcedDepth:Boolean = false;
	
	/**
	 * The forced depth for this object.
	 *
	 * <p>To make this feature work, you must enable the ForcedDepth system too.<br/>
	 * The higher the depth is, the sooner the more far the object will be represented.</p>
	 */
	public var forcedDepth:Number = 0;

	public function get enableEvents() : Boolean
	{
		return m_bEv;
	}
		
	public function set enableEvents( b:Boolean ) : Void
	{
		if( b && !m_bEv )
		{
			m_oContainer.onPress = Delegate.create( this, _onInteraction, MouseEvent.CLICK );
			m_oContainer.mouseUp = Delegate.create( this, _onInteraction, MouseEvent.MOUSE_UP ); 
			m_oContainer.mouseDown = Delegate.create( this, _onInteraction, MouseEvent.MOUSE_DOWN ); 
			m_oContainer.rollOver = Delegate.create( this, _onInteraction, MouseEvent.ROLL_OVER ); 
			m_oContainer.rollOut = Delegate.create( this, _onInteraction, MouseEvent.ROLL_OUT ); 
   		
			m_oContainer.onMouseWheel = Delegate.create( this, _onInteraction, MouseEvent.MOUSE_WHEEL ); 
			m_oContainer.mouseOut = Delegate.create( this, _onInteraction, MouseEvent.MOUSE_OUT ); 
			m_oContainer.mouseOver = Delegate.create( this, _onInteraction, MouseEvent.MOUSE_OVER ); 
			m_oContainer.mouseMove = Delegate.create( this, _onInteraction, MouseEvent.MOUSE_MOVE ); 
		}
		else if( !b && m_bEv )
		{
			m_oContainer.onPress = null;
			m_oContainer.mouseUp = null;
			m_oContainer.mouseDown = null;
			m_oContainer.rollOver = null;
			m_oContainer.rollOut = null;
   
			m_oContainer.onMouseWheel = null;
			m_oContainer.mouseOut = null;
			m_oContainer.mouseOver = null;
			m_oContainer.mouseMove = null;
		}
	}
		
	private function _onInteraction( p_oEvt:EventType ) : Void
	{
		m_oEB.broadcastEvent.apply( new BasicEvent( p_oEvt, this ) );
	}
	
	public function toString() : String
	{
		return "sandy.core.scenegraph.Sprite2D, container:" + m_oContainer;
	}
		
	private var m_bEv:Boolean = false; // The event system state (enable or not)
	
	private var m_nW2:Number = 0;
	private var m_nH2:Number = 0;
	private var m_oContainer:MovieClip;
	private var m_bLightingEnabled:Boolean = false;

	private var m_nPerspScaleX:Number = 0, m_nPerspScaleY:Number = 0;
	private var m_nRotation:Number = 0;
	private var _v:Vertex, _vx:Vertex, _vy:Vertex;
	private var m_nDepth:Number;
	private var _nScale:Number;
	private var m_oMaterial:Material;
	
}