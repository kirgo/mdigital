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
package com.candyspace.puremvc.mediator
{

	

	import com.candyspace.puremvc.view.menu.MenuView;
	import com.candyspace.puremvc.core.layers.GeneralLayers;
	import com.candyspace.puremvc.core.layers.ApplicationLayers;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.mediator.SuperMediator;
	import flash.utils.getQualifiedClassName;

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
	public class MenuMediator extends SuperMediator
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		/**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static function get NAME():String
		{
			return getQualifiedClassName(MenuMediator);
		}
		
		/**
		 * Method used to get a reference to the view attached to the current mediator. Apart from the 
		 * viewComponent property, this getter returns a reference already casted to the view type.
		 */
		private function get view():MenuView
		{
			return viewComponent as MenuView;
		}
		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function MenuMediator(viewComponent:Object = null)
		{
			super(MenuMediator.NAME, viewComponent);
		}
		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		override public function onRegister():void
		{
			super.onRegister();
			trace("=================  This mediator has been registered :: \t", NAME);
		}
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		override protected function addViewsStartup():void
		{
			// adds view to the display init procedure
			trace("MenuMediator :: addViewsStartup :: Sending Register view startup notification");
			sendNotification(Notifications.instance.REGISTER_VIEW_FOR_STARTUP,
							{
								child: view.toast
							},
							GeneralLayers.instance.MENU
							);
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
