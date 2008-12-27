//
//  CubeLoader
//
//  Created by JLM at justinfront dot net and Guy Wheeler ( milknosugar.co.uk ) 
//  6 October 2008
//

import sandy.core.Scene3D;
import sandy.core.scenegraph.Camera3D;
import sandy.core.scenegraph.Group;
import sandy.core.scenegraph.Shape3D;
import sandy.events.SandyEvent;
import sandy.parser.IParser;
import sandy.parser.Parser;
import sandy.parser.ParserEvent;
import flash.display.Sprite;
import sandy.view.ViewPort;
import flash.events.Event;
import flash.Lib;


class Dice extends Sprite
{
    
    
    private var scene:      Scene3D;
    private var camera:     Camera3D;
    private var cube:       Shape3D;
    
    
    
    public function new () 
    { 
        
        super();
        loadCollada();
        
    }
    
    
    private function loadCollada()
    {
        
        var parser: IParser = Parser.create( "../assets/dice.dae", Parser.COLLADA );
		untyped( parser.addEventListener( ParserEvent.FAIL, onError ) );
        untyped( parser.addEventListener( ParserEvent.INIT, create3d ) );
        parser.parse();
        
    }
    
    
    private function onError( pEvt: ParserEvent ) : Void 
    {
        
        trace("|!! loading error !!!");
        trace("check you have the dice.jpg, dice.dae and dice.swf all in the same directory");
        
    }
    
    
    private function create3d( pEvt: ParserEvent ) : Void
    {
        
        camera = new Camera3D( 0, 0, -10);
        camera.viewport = new ViewPort( 320, 240 );
        
        var root:   Group = pEvt.group;
        
        cube = cast( root.children[ 0 ], Shape3D );
        
        cube.enableBackFaceCulling = true;
        
        // modify lighting of material here??
        
        scene = new Scene3D( "scene", this, camera, root );
        
        addEventListener( Event.ENTER_FRAME, enterFrameHandler );
        
        Lib.current.stage.addChild( this );
        
    }
    
    
    private function enterFrameHandler( event : Event ) : Void
    {
        
        scene.render();
        cube.pan  += 1;
        cube.tilt += 1.1;
        cube.roll += 1.2;
        
    }
    
    
    static function main() 
    {
        
        new Dice();
        
    }
    
}
