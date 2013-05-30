// //////////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// //////////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.core.layers.transitions
{


	/**
	 * @author Carlos D. Rodriguez
	 */
    
    //--------------------------------------
	// Imports
	//--------------------------------------
	
	// Flash
    import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	
    // PureMVC
	
	// Structure
	
	// Custom
    
    //--------------------------------------
	// Events
	//--------------------------------------
    
	/**
	 * Dispatched by the instance of the class that handles the layers transition
	 * (a class that implements the imo.puremvc.core.layer.transitions.ILayersTransition
	 * interface). 
	 * 
	 * This event is dispatched when the transition process starts.
	 */
	//[Event(name = "transitionStarted", type = "imo.puremvc.core.layer.ApplicationLayersEvent")]
	
	/**
	 * Dispatched by the instance of the class that handles the layers transition
	 * (a class that implements the imo.puremvc.core.layer.transitions.ILayersTransition
	 * interface). 
	 * 
	 * This event is dispatched when the transition process has finished.
	 */
	//[Event(name = "transitionComplete", type = "com.candyspace.puremvc.core.layers.ApplicationLayersEvent")]
    
	/**
	 * Dispatched by the instance of the class that handles the layers transition
	 * (a class that implements the imo.puremvc.core.layer.transitions.ILayersTransition
	 * interface). 
	 * 
	 * This event is dispatched in order to add the layer to its original depth.
	 */
	//[Event(name = "addLayerToStage", type = "com.candyspace.puremvc.core.layers.ApplicationLayersEvent")]
    
    /**
     * Dispatched by the instance of the class that handles the layers transition
     * (a class that implements the imo.puremvc.core.layer.transitions.ILayersTransition
     * interface). 
     * 
     * This event is dispatched when the layer is removed from the stage.
     */
	//[Event(name = "removeLayerFromStage", type = "com.candyspace.puremvc.core.layers.ApplicationLayersEvent")]
	
    //--------------------------------------
    // Interface
    //--------------------------------------
    
    /**
     * 
     */

    public interface ILayersTransition extends IEventDispatcher
    {
		/**
		 * Sets the layers that will be part of the transition.
		 * @param	transitionOutLayers <DisplayObject> Holds references to all the layers that will be
		 * removed from the stage.
		 * @param	transitionInLayers <DisplayObject> Holds references to all the layers that will be
		 * added to stage.
		 */
		function setLayers(transitionInLayers:Array, transitionOutLayers:Array):void;
		
		/**
		 * Get the transitionIn layers names.
		 */
		function get transitionInLayersNames():Array
		/**
		 * Set the transitionOut layers names.
		 */
		function set transitionInLayersNames(transitionInLayers:Array):void
		
		/**
		 * Get the transitionOut layers names.
		 */
		function get transitionOutLayersNames():Array
		/**
		 * Set the transitionOut layers names.
		 */
		function set transitionOutLayersNames(transitionOutLayers:Array):void
		
		/**
		 * Does the transition between the layers specified in the 'setLayers' method.
		 */
        function doTransition():void;
		
		/**
		 * Does the reversed transiton between the layers specified in the 'setLayers' method.
		 */
		function undoTransition():void;
    }
}
