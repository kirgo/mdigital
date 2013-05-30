// // // // ////////////////////////////////////////////////////////////////////////
//
// CANDYMEDIA
// Copyright 2012 CANDYMEDIA
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // // ////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.view
{
	import flash.display.DisplayObject;



	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	// Flash
	import flash.display.DisplayObjectContainer;
	
	
	// Structure
	import com.candyspace.puremvc.view.AbstractView;
	import com.candyspace.puremvc.view.IView;
	
	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class Root extends AbstractView implements IView
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		public function get holder():DisplayObjectContainer
		{
			return _display as DisplayObjectContainer;
		}

		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function Root(name:String, displayObj:DisplayObject)
		{
			super(name, null, displayObj);
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		/**
		 * Variable and component initialization.
		 */
		override protected function initVars():void
		{
		}

		/**
		 * General listeners initialization.
		 */
		override protected function initEventListeners():void
		{
		}

		override protected function initComplete():void
		{
			super.initComplete();
		}

		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		/**
		 * Add a new layer to the application.
		 * @param	container The layer holder, that will be added to stage.
		 */
		public function addView(view:IView):void
		{
			addSimpleSubView(view);
		}

	}
}
