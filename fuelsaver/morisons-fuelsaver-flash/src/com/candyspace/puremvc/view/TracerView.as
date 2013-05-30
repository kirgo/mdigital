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
	import flash.text.TextField;
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
	public class TracerView extends AbstractView implements IView
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		protected var _tf:TextField;

		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function TracerView(name:String)
		{
			super(name);
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		/**
		 * Variable and component initialization.
		 */
		override protected function initVars():void
		{
			_tf = new TextField();
			displayObjectContainer.addChild(_tf);
			
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
		public function addTrace(str:String):void
		{
			if(!_tf)
			{
				initVars();
			}
			else
			{
				_tf.text += "\n" + str;
				
			}
		}
		

	}
}
