// //////////////////////////////////////////////////////////////////////////////
//
// CANDYMEDIA
// Copyright 2012 CANDYMEDIA
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// //////////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.events
{

	import flash.events.Event;

	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	// Flash
	// PureMVC
	// Structure
	// Custom
	// --------------------------------------
	// EVENTS
	// --------------------------------------
	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class ViewEvent extends Event
	{
	// --------------------------------------
	// Properties
	// --------------------------------------
		public static const INITIALIZED:String = "ve_initialized";
		
		public static const DATA_UPDATED:String = "ve_data_updated";
		
		public static const ADDED:String = "ve_added";
		
		public static const REMOVED:String = "ve_removed";
	// --------------------------------------
	// Constructor
	// --------------------------------------
		public function ViewEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	// --------------------------------------
	// Methods - Init
	// --------------------------------------
	// --------------------------------------
	// Methods - Overriden
		// --------------------------------------
		override public function clone():Event
		{
			return new ViewEvent(type, bubbles, cancelable);
		}
	// --------------------------------------
	// Methods - Public
	// --------------------------------------
	// --------------------------------------
	// Event handlers - Overriden
	// --------------------------------------
	// --------------------------------------
	// Event handlers
	// --------------------------------------
	}
	}
