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
package com.candyspace.morrisonFuelSaver.mediator
{

	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	import com.candyspace.morrisonFuelSaver.core.FSApplicationLayers;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.mediator.SuperMediator;
	import com.candyspace.puremvc.view.IView;

	import flash.utils.getQualifiedClassName;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class BackgroundMediator extends SuperMediator
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		/**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static function get NAME():String
		{
			return getQualifiedClassName(BackgroundMediator);
		}
		
		private function get view():IView
		{
			return viewComponent as IView;
		}
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function BackgroundMediator(viewComponent:Object = null)
		{
			super(BackgroundMediator.NAME, viewComponent);
		}
		
		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			//trace("=================  This mediator has been registered :: \t", NAME);
		}
		
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		
		override protected function addViewsStartup():void
		{
			// adds view to the display init procedure
			sendNotification(Notifications.instance.REGISTER_VIEW_FOR_STARTUP,
							{
								child: view
							},
							FSApplicationLayers.instance.BACKGROUND
							);
		}
	}
}
