///////////////////////////////////////////////////////////
//  ObjectEvent.as
//  Macromedia ActionScript Implementation of the Class ObjectEvent
//  Generated by Enterprise Architect
//  Created on:      26-VII-2006 13:46:07
//  Original author: Thomas Pfeiffer - kiroukou
///////////////////////////////////////////////////////////
package sandy.events
{
	import flash.events.Event;
	/**
	 * @author Thomas Pfeiffer - kiroukou
	 * @version 1.0
	 * @date 	05.08.2006
	 * @created 26-VII-2006 13:46:07
	 */
	public class ObjectEvent extends Event
	{
	    /**
	     * The onPress Object Event. Broadcasted once a face of an object is clicked
	     */
	    static public const onPressEVENT:String = "onPress";
	    /**
	     * The onRollOut Object Event. Broadcasted once the mouse is out the object.
	     */
	    static public const onRollOutEVENT:String = "onRollOut";
	    /**
	     * The onRollOver Object Event. Broadcasted once the mouse is over the object.
	     */
	    static public const onRollOverEVENT:String = "onRollOver";
	    /**
	     * Constructor
	     * Extends the basic Event class from flash.events package. Set bubbling and cancelable are set to false.
	     * @param e Event type
	     */
	    public function ObjectEvent( e:String )
	    {
	    	super( e, false, false );
	    }
	}//end ObjectEvent
}