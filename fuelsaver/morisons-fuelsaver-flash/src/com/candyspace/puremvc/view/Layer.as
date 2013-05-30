// // // // // // ////////////////////////////////////////////////////////////////////
//
// CANDYMEDIA
// Copyright 2012 CANDYMEDIA
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // // // // ////////////////////////////////////////////////////////////////////
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
	// Structure
	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class Layer extends AbstractView implements IView
	{
		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function Layer(name:String, displayObject:DisplayObject = null)
		{
			super(name, null, displayObject);
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
	}
}
