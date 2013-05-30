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
package com.candyspace.puremvc.core.layers
{

	import flash.display.DisplayObjectContainer;
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
	 * Class comment
	 */
	public class ApplicationLayersEvent extends Event
	{
		// --------------------------------------
		// Properties - STATIC PUBLIC
		// --------------------------------------
		/**
		 * Dispatched when the order of the layers has been changed.
		 */
		public static const ORDER_CHANGE:String = "orderChange";
		/**
		 * Dispatched when a layer was added to the layers list.
		 */
		public static const ADD_LAYER:String = "addLayer";
		/**
		 * Dispatched when a layer was removed from the layers list.
		 */
		public static const REMOVE_LAYER:String = "removeLayer";
		/**
		 * Dispatched by the instance of the class that handles the layers transition
		 * (a class that implements the imo.puremvc.core.layer.transitions.ILayersTransition
		 * interface). 
		 * 
		 * This event is dispatched when the transition process starts.
		 */
		public static const TRANSITION_STARTED:String = "transitionStarted";
		/**
		 * Dispatched by the instance of the class that handles the layers transition
		 * (a class that implements the imo.puremvc.core.layer.transitions.ILayersTransition
		 * interface). 
		 * 
		 * This event is dispatched in order to add the layer to its original depth.
		 */
		public static const ADD_LAYER_TO_STAGE:String = "addLayerToStage";
		/**
		 * Dispatched by the instance of the class that handles the layers transition
		 * (a class that implements the imo.puremvc.core.layer.transitions.ILayersTransition
		 * interface). 
		 * 
		 * This event is dispatched when the layer is removed from the stage.
		 */
		public static const REMOVE_LAYER_FROM_STAGE:String = "removeLayerFromStage";
		/**
		 * Dispatched by the instance of the class that handles the layers transition
		 * (a class that implements the imo.puremvc.core.layer.transitions.ILayersTransition
		 * interface). 
		 * 
		 * This event is dispatched when the transition process has finished.
		 */
		public static const TRANSITION_COMPLETE:String = "transitionComplete";
		// --------------------------------------
		// Properties - PUBLIC
		// --------------------------------------
		private var _layersOrder:Array;

		/**
		 * Get the current order of the layers.
		 */
		public function get layersOrder():Array
		{
			return _layersOrder;
		}

		private var _layerHolder:DisplayObjectContainer;

		/**
		 * Get the holder of the layer that has generated the event. 
		 */
		public function get layerHolder():DisplayObjectContainer
		{
			return _layerHolder;
		}

		private var _layerName:String;

		/**
		 * Get the name of the layer that has generated the event. 
		 */
		public function get layerName():String
		{
			return _layerName;
		}

		private var _layer:DisplayObjectContainer;

		/**
		 * Get the reference to the layer that has generated the event.
		 */
		public function get layer():DisplayObjectContainer
		{
			return _layer;
		}

		// --------------------------------------
		// CONSTRUCTOR
		// --------------------------------------
		public function ApplicationLayersEvent(type:String, layersOrder:Array = null, layerHolder:DisplayObjectContainer = null, layerName:String = "", layer:DisplayObjectContainer = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);

			_layersOrder = layersOrder;
			_layerHolder = layerHolder;
			_layerName = layerName;
			_layer = layer;
		}

		// --------------------------------------
		// Methods - OVERRIDDEN
		// --------------------------------------
		public override function clone():Event
		{
			return new ApplicationLayersEvent(type, layersOrder, layerHolder, layerName, layer, bubbles, cancelable);
		}

		public override function toString():String
		{
			return formatToString("ApplicationLayersEvent", "layersOrder", "layerHolder", "layerName", "layer", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}
