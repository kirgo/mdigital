// // // // ////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // // ////////////////////////////////////////////////////////////////////////
package com.candyspace.morrisonFuelSaver.mediator
{
	
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSUserActions;
	import com.candyspace.morrisonFuelSaver.mediator.view.RegistrationEntryView;
	import com.candyspace.morrisonFuelSaver.mediator.view.SingleButtonView;
	import com.candyspace.puremvc.events.ButtonActionEvent;

	import org.puremvc.as3.multicore.interfaces.INotification;

	import flash.utils.getQualifiedClassName;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class RegistrationEntryMediator extends SuperOneButtonMediator
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		/**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static function get NAME():String
		{
			return getQualifiedClassName(RegistrationEntryMediator);
		}
		
		private function get view():RegistrationEntryView
		{
			return viewComponent as RegistrationEntryView;
		}
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function RegistrationEntryMediator(viewComponent:Object = null)
		{
			super(RegistrationEntryMediator.NAME, viewComponent);
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
		
		override public function listNotificationInterests() : Array 
		{
			var interests:Array = super.listNotificationInterests();

			interests.push(FSNotifications.instance.RESET_APPLICATION);

			return interests;
		}
		
		
		override public function handleNotification(notification : INotification) : void 
		{
			super.handleNotification(notification);
			
			switch (notification.getName()) 
			{ 
				case FSNotifications.instance.RESET_APPLICATION: 
					trace( "value0 was selected" ); 
					resetView();
					break; 			  
				default: 
					trace( "RegistrationEntryMediator :: handleNotification ::" );
			}
		}

		
		override protected function onViewClick(event:ButtonActionEvent):void
		{
			switch (event.buttonName) { 
				case RegistrationEntryView.SIGN_UP_FIELD_NAME: 
					//trace( "TERMS_CONDITIONS_FIELD_NAME" ); 
					sendNotification(FSNotifications.instance.USER_ACTION, view.getEmailString(), FSUserActions.SHOW_PRIVACY_POLICY);
					
					break; 			  
				case RegistrationEntryView.TERMS_CONDITIONS_FIELD_NAME: 
					//trace( "TERMS_CONDITIONS_FIELD_NAME" ); 
					sendNotification(FSNotifications.instance.USER_ACTION, view.getEmailString(), FSUserActions.OPEN_TC);
					
					break; 			  
				case SingleButtonView.SUBMIT_BUTTON_NAME: 
					//trace( "SUBMIT_BUTTON_NAME" ); 
					sendNotification(FSNotifications.instance.USER_ACTION, view.getEmailString(), FSUserActions.SUBMIT_REGISTRATION);
					break; 
				default: 
					trace( "RegistrationEntryMediator :: add implementation for button :: " + event.buttonName );
			}
			trace(event.buttonName);
		}

		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		
		public function getEmail():String
		{
			return view.getEmailString();
		}
		
		public function getOptin():String
		{
			return String(view.getOptinValue());
		}

		// --------------------------------------
		// Methods - Public
		// --------------------------------------

		private function resetView() : void 
		{
			view.resetView();
		}
	}
}