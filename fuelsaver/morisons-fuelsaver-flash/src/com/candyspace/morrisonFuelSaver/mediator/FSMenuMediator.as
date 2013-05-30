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
	import com.candyspace.morrisonFuelSaver.core.FSConstants;
	import com.candyspace.puremvc.facade.IAppFacade;

	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	import com.candyspace.morrisonFuelSaver.core.FSApplicationLayers;
	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSUserActions;
	import com.candyspace.morrisonFuelSaver.mediator.view.FSMenuView;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.events.ButtonActionEvent;
	import com.candyspace.puremvc.mediator.SuperMediator;
	import com.candyspace.puremvc.view.IView;

	import flash.utils.getQualifiedClassName;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class FSMenuMediator extends SuperMediator
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		/**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static function get NAME():String
		{
			return getQualifiedClassName(FSMenuMediator);
		}
		
		private function get view():FSMenuView
		{
			return viewComponent as FSMenuView;
		}
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function FSMenuMediator(viewComponent:Object = null)
		{
			super(FSMenuMediator.NAME, viewComponent);
		}
		
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------

		override public function onRegister():void
		{
			super.onRegister();
			//trace("=================  This mediator has been registered :: \t", NAME);
		}
		
		
		override protected function initializedComplete():void
		{
			var isNoMenu:String = (facade as IAppFacade).getParameter(FSConstants.NO_MENU_PARAMETER_NAME, FSConstants.NO_MENU_PARAMETER_DEFAULT_VALUE);
			if(isNoMenu == "true")
			{
				view.showMenuBar(false);
			}
			else
			{
				view.showMenuBar(true);
			}
		}
		
		override protected function addViewsStartup():void
		{
			// adds view to the display init procedure
			trace("BackgroundMediator :: addViewsStartup :: Sending Register view startup notification");
			sendNotification(Notifications.instance.REGISTER_VIEW_FOR_STARTUP,
							{
								child: view
							},
							FSApplicationLayers.instance.MENU
							);
		}
		
		override protected function initEventListener():void
		{
			super.initEventListener();
			
			view.addEventListener(ButtonActionEvent.ACTION, onViewClick);
		}

		// --------------------------------------
		// Event handlers
		// --------------------------------------
		
		private function onViewClick(event:ButtonActionEvent):void
		{
			switch (event.buttonName) 
			{ 
				case FSMenuView.LOGO_BUTTON_NAME: 
					//trace( "CALCULATOR_BUTTON_NAME" ); 
					sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.SELECT_MENU_LOGO);
					break; 			  
				case FSMenuView.CALCULATOR_BUTTON_NAME: 
					//trace( "CALCULATOR_BUTTON_NAME" ); 
					sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.SELECT_MENU_CALCULATOR);
					break; 			  
				case FSMenuView.LOCATION_BUTTON_NAME: 
					//trace( "LOCATION_BUTTON_NAME" ); 
					sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.SELECT_MENU_LOCATION);
					break; 
				case FSMenuView.REGISTRATION_BUTTON_NAME: 
					//trace( "REGISTRATION_BUTTON_NAME" ); 
					sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.SELECT_MENU_REGISTRATION);
					break; 			  
				case FSMenuView.SHARING_BUTTON_NAME: 
					//trace( "SHARING_BUTTON_NAME" ); 
					sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.SELECT_MENU_SHARING);
					break;
			}
		}
	}
}