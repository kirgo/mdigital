// // ////////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // ////////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.view.menu
{

	import flash.display.StageAspectRatio;
	import flash.utils.getQualifiedClassName;
	import com.candyspace.puremvc.view.AbstractView;
	import com.candyspace.puremvc.view.IView;

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
	public class MenuView extends AbstractView implements IView
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		protected var _toast:IView;
		public function get toast():IView { return _toast; }
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function MenuView(name:String, displayObjectClassRef:Class, orientation:String = StageAspectRatio.ANY)
		{
			super(name, displayObjectClassRef, null,  orientation)
		}
		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		override protected function addSubViews():void
		{
			trace("initialazing menu subviews....");
			//addSubView( new ToastView("toastView", Toast));
			
			_toast = new ToastView("toastView", Toast);
			addSubView(_toast);
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