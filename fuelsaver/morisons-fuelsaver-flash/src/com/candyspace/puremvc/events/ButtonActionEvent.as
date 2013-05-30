// // ////////////////////////////////////////////////////////////////////////////
//
// CANDYMEDIA
// Copyright 2012 CANDYMEDIA
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // ////////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.events
{
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	import flash.events.Event;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class ButtonActionEvent extends Event
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		public static const ACTION:String = "vae_action";
		
		public var event:Event;
		
		public var buttonName:String;

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function ButtonActionEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		override public function clone():Event
		{
			return new ButtonActionEvent(type, bubbles, cancelable);
		}
	}
}
