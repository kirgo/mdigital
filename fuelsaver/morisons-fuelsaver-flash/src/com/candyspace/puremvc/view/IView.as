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
package com.candyspace.puremvc.view
{

	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;

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
	/**
	 * Dispatched when the view components has been initialised
	 * @eventType imo.events.ViewEvent.INITIALIZED
	 */
	[Event(name="ve_initialized", type="imo.events.ViewEvent")] 
	
	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Interface Comment
	 */
	public interface IView extends IEventDispatcher
	{
		function get name():String;
		
		// TODO change vo for interface
		//function init(displayObject:DisplayObject = null, viewVO:ViewInitVO = null):void;
		function init(viewVO:IViewInitVO = null):void;
		
		function get isInitialized():Boolean;
		
		  /**
         * Returns a reference to the actual display object wrapped in the 
         * IView instance
         */
		function get display():DisplayObject;
		
		function updateDisplayData(vo:*):void;
		
		
		function destroyDisplay():void;
		
		function contains(view:IView):Boolean;
		// --------------------------------------
		// Properties
		// --------------------------------------
		// --------------------------------------
		// Constructor
		// --------------------------------------
		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
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

