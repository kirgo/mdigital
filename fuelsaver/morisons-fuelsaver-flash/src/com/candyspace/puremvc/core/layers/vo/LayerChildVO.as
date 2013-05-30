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
package com.candyspace.puremvc.core.layers.vo
{
	/**
	 * @author Carlos D. Rodriguez
	 */

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * @author George Prichici 
	 */
	public class LayerChildVO
	{
		private var _child:DisplayObject;

		/**
		 * The display object that will be added to the layer.
		 */
		public function get child():DisplayObject
		{
			return _child;
		}

		private var _wrapper:DisplayObjectContainer;

		/**
		 * The display object container.
		 * If the child is a not IVisualElement then it needs a wrapper to be 
		 * added to the IVisualElementContainer.
		 * If the wrapper is not null, then the wrapper will be added/removed 
		 * to/from it's parent.
		 */
		public function get wrapper():DisplayObjectContainer
		{
			return _wrapper;
		}

		private var _mask:DisplayObject;

		/**
		 * The mask object.
		 */
		public function get mask():DisplayObject
		{
			return _mask;
		}

		private var _removeChildOnClick:Boolean;

		/**
		 * If the user clicks on the mask, then the mask and the child will be 
		 * automatically removed.
		 */
		public function get removeChildOnClick():Boolean
		{
			return _removeChildOnClick;
		}

		public function LayerChildVO(childObj:DisplayObject, wrapperObj:DisplayObjectContainer = null, maskObj:DisplayObject = null, removeOnClick:Boolean = false)
		{
			_child = childObj;
			_wrapper = wrapperObj;
			_mask = maskObj;
			_removeChildOnClick = removeOnClick;
		}

		public function toString():String
		{
			return "LayerChildVO child: " + child + " hasMask: " + Boolean(mask) + " remove child on mask click: " + removeChildOnClick + " has wrapper: " + Boolean(wrapper);
		}
	}
}
