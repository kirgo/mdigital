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
package com.candyspace.puremvc.core.layers
{

	import flash.display.DisplayObjectContainer;
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
	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public interface IApplicationLayers extends IEventDispatcher
	{
		
		        /**
		 * Array that holds the names of the registered layers. The position of the layers from this 
         * array is the current order of the layers.
		 */
		//function get layers():Array;
        
        /**
		 * Get the DisplayObjectContainer that is mapped to the layer supplied as a paramter.
		 * @param	layerName The name of the layer.
		 * @return The DisplayObjectContainer that is mapped to the layerName. If no layer, with the
		 * given name is found, the method will return a null object. The returned object is, in fact,
		 * a Sprite instance.
		 */
        function getHolder(layerName:String):DisplayObjectContainer;
        
        /**
		 * Get the DisplayObjectContainer that is found at the index supplied as a paramter.
		 * @param	position The index, within the layers list, at which the layer is found.
		 * @return The DisplayObjectContainer that is found at the given position. If no layer is found at
		 * the specified index, the method will return a null object. The returned object is, in fact, a
		 * Sprite instance.
		 */
		function getHolderAt(position:uint):DisplayObjectContainer;
        
        /**
         * Returns the name of the holder passed as a parameter. If the display object container reference
         * is not within the registered layers, an empty string will be returned.
         * @param	holder Reference to the display object container that whose name will be returned.
         * @return Name with which the display object container is registered in the applicationlayers array,
         * or an empty string, if the layer passed as a parameter is not registered.
         */
        //function getHolderName(holder:DisplayObjectContainer):String;
        
        /**
         * Returns an array of objects that holds the names and the references of all the layers that are 
         * situated at a lower depth index, than the holder supplied as a paramter.
         * @param	holder Display object container that is siutated over the returned array.
         * @return Array with the holders under the display object container passed as a paramter.
         */
        //function getHoldersUnder(holder:DisplayObjectContainer):Array;
        
        /**
         * Returns an array of objects that holds the names and the references of all the layers that are 
         * situated at a higher depth index, than the holder supplied as a paramter.
         * @param	holder Display object container that is siutated under the returned array.
         * @return Array with the holders under the display object container passed as a paramter.
         */
        //function getHoldersOver(holder:DisplayObjectContainer):Array;
        
        /**
		 * Add a new layer to the layers list.
		 * @param	name Name of the new layer.
		 * @param	position Position within the layers list.
		 */
		function registerLayerAt(name:String, position:uint, addToStage:Boolean = true):void;
        
        /**
		 * Add a new layer to the layers list.
		 * @param	name The name of the new layer.
		 * @param	previousLayerName The name of the layer after which the new layer will be added.
		 */
		//function registerLayerAfter(name:String, previousLayerName:String, addToStage:Boolean = true):void;
        
        /**
		 * Add a new layer to the layers list.
		 * @param	name The name of the new layer.
		 * @param	nextLayerName The name of the layer before which the new layer will be added.
		 */
		//function registerLayerBefore(name:String, nextLayerName:String, addToStage:Boolean = true):void;
        
        /**
		 * Remove a layer from the layers list.
		 * @param	position The position, within the layers list, of the layer that will be removed.
		 * @return The name of the layer that was removed, or an empty string, if the position supplied
		 * is not valid.
		 */
		//function unregisterLayerAt(position:uint, addToStage:Boolean = true):String;
        
        /**
		 * Remove a layer from the layers list.
		 * @param	name The name of the layer that will be removed.
		 * @return The name of the layer that was removed, or an empty string, if the name supplied
		 * does not exist in the layers list.
		 */
		//function unregisterLayer(name:String, addToStage:Boolean = true):String;
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
