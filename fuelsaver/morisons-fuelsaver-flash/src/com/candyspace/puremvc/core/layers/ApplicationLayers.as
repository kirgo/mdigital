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

	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import flash.utils.getQualifiedClassName;
	import flash.events.EventDispatcher;

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
	public class ApplicationLayers extends EventDispatcher implements IApplicationLayers
	{
		// --------------------------------------
		// Properties - STATIC PUBLIC
		// --------------------------------------
		/**
		 * Reference to the only instance of this class from the application.
		 */
		private static var _instance:ApplicationLayers;

		/**
		 * Returns the only instance of this class from the application.
		 */
		public static function  get instance():ApplicationLayers
		{
			if (!_instance)
			{
				_instance = new ApplicationLayers();
			}

			return _instance;
		}
		
		//--------------------------------------
		// Properties - PUBLIC
		//--------------------------------------
		
		/**
		 * Defines the order of the layers.
		 */
		private var _layers:Array;
		/**
		 * Get the current order of the layers.
		 */
		public function get layers():Array
		{
			return _layers;
		}		
		
        /**
		 * Array of objects. Has the following properties:
		 * 		- name: The name of the layer;
		 * 		- containter: The DisplayObjectContainer that will hold the display objects.
		 */
		private var _holders:Array;

		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function ApplicationLayers()
        {
			if (_instance)
			{
				throw new Error(
									getQualifiedClassName(this) + "::constructor - cannot instantiate class. Please use "
									+ getQualifiedClassName(this) + ".instance in order to access the instance."
							   );
			}
			
			_instance = this;
			
			init();
		}
		
		//--------------------------------------
		// Methods - INIT
		//--------------------------------------
		
		/**
		 * Initialize the holders array.
		 */
		private function init():void
		{
			// initialize the holders
			_holders = [];
            _layers = [];
		}
		
		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		// --------------------------------------
		// Methods - Public
		// --------------------------------------

		/**
		 * Get the DisplayObjectContainer that is mapped to the layer supplied as a paramter.
		 * @param	layerName The name of the layer.
		 * @return The DisplayObjectContainer that is mapped to the layerName. If no layer, with the
		 * given name is found, the method will return a null object. The returned object is, in fact,
		 * a Sprite instance.
		 */
		public function getHolder(layerName:String):DisplayObjectContainer
		{
			var displayObjectContainer:DisplayObjectContainer = null;
			
			var position:int = _layers.indexOf(layerName);
			if (position != -1)
			{
				displayObjectContainer = Object(_holders[position]).container;
			}
			
			return displayObjectContainer;
		}
		
				/**
		 * Get the DisplayObjectContainer that is found at the index supplied as a paramter.
		 * @param	position The index, within the layers list, at which the layer is found.
		 * @return The DisplayObjectContainer that is found at the given position. If no layer is found at
		 * the specified index, the method will return a null object. The returned object is, in fact, a
		 * Sprite instance.
		 */
		public function getHolderAt(position:uint):DisplayObjectContainer
		{
			var displayObjectContainer:DisplayObjectContainer = null;
			
			if (position < _layers.length)
			{
				displayObjectContainer = Object(_holders[position]).container;
			}
			
			return displayObjectContainer;
		}
				
		/**
		 * Add a new layer to the layers list.
		 * @param	name Name of the new layer.
		 * @param	position Position within the layers list.
		 */
		public function registerLayerAt(name:String, position:uint, addToStage:Boolean = true):void
		{
			if (position > _layers.length)
			{
				position = _layers.length;
			}
			
			// add the layer to the layers list
			_layers.splice(position, 0, name);
			// also add to the holders
			_holders.splice(position, 0, createHolderObject(name));
            if (addToStage)
            {
                var displayObjectContainer:DisplayObjectContainer = DisplayObjectContainer(_holders[position].container);
                // dispatch an event, so that the listeners will be informed that a new layer was added
                dispatchEvent(new ApplicationLayersEvent(ApplicationLayersEvent.ADD_LAYER, _layers, displayObjectContainer, name));
            }
		}
		
		//--------------------------------------
		// Methods - PRIVATE
		//--------------------------------------
		
		/**
		 * Creates a holder object.
		 * @param	name Name of the layer.
		 * @return The newly created object. Contains the following properties:
		 * 		- name: The name of the layer;
		 * 		- container: A sprite that has the same name as the layer.
		 */
		private function createHolderObject(name:String):Object
		{
			//var displayObjectContainer:Group = new Group();
			var displayObjectContainer:DisplayObjectContainer = new Sprite();
			displayObjectContainer.name = name;
			
			return { 
						name: name, 
						container: displayObjectContainer 
				   };
		}
		
		/**
         * Returns the name of the holder passed as a parameter. If the display object container reference
         * is not within the registered layers, an empty string will be returned.
         * @param	holder Reference to the display object container that whose name will be returned.
         * @return Name with which the display object container is registered in the applicationlayers array,
         * or an empty string, if the layer passed as a parameter is not registered.
         */
        public function getHolderName(holder:DisplayObjectContainer):String
        {
            var holderName:String = "";
            
            var len:uint = _holders.length;
            for (var i:int = 0; i < len; i++) 
            {
                if (Object(_holders[i]).container == holder)
                {
                    holderName = Object(_holders[i]).name;
                    break;
                }
            }
            
            return holderName;
        }
		
		/**
         * Returns an array of objects that holds the names and the references of all the layers that are 
         * situated at a lower depth index, than the holder supplied as a paramter.
         * @param	holder Display object container that is siutated over the returned array.
         * @return Array with the holders under the display object container passed as a paramter. If the
         * holder supplied as a paramter is not registered, 'null' is returned.
         */
        public function getHoldersUnder(holder:DisplayObjectContainer):Array
        {
            var arr:Array = null;
            
            if (getHolderName(holder) != "")
            {
                var len:int = getHolderIndex(holder);
                
                if (len > -1)
                {
                    arr = [];
                    for (var i:int = 0; i < len; i++)
                    {
                        // a new object is created with the same properties just to be sure that
                        // the original object will not be altered in the instance that uses the
                        // values returned by this method
                        arr.push(
                                    {
                                        name: Object(_holders[i]).name,
                                        container: Object(_holders[i]).container
                                    }
                                );
                    }
                }
            }
            
            return arr;
        }
		
		/**
         * Returns the index of the holder within the _holders array.
         * @param	holder Display object container whose index will be returned.
         * @return The index of the current holder within the _holders array, or '-1' if
         * the holder is not registered. 
         */
        private function getHolderIndex(holder:DisplayObjectContainer):int
        {
            var index:int = -1;
            
            if (getHolderName(holder) != "")
            {
                var len:uint = _holders.length;
                for (var i:int = 0; i < len; i++) 
                {
                    if (Object(_holders[i]).container == holder)
                    {
                        index = i;
                        break;
                    }
                }
            }
            
            return index;
        }
		
		// --------------------------------------
		// Event handlers - Overriden
		// --------------------------------------
		// --------------------------------------
		// Event handlers
		// --------------------------------------
	}
}
