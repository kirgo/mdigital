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
	import com.candyspace.morrisonFuelSaver.core.FSConstants;
	import com.candyspace.puremvc.facade.IAppFacade;
	
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	import com.candyspace.controls.TwoStateEnableButtonMovieClip;
	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSUserActions;
	import com.candyspace.morrisonFuelSaver.mediator.view.SharingView;
	import com.candyspace.morrisonFuelSaver.mediator.view.SingleButtonView;
	import com.candyspace.puremvc.events.ButtonActionEvent;

	import org.puremvc.as3.multicore.interfaces.INotification;

	import flash.display.MovieClip;
	import flash.utils.getQualifiedClassName;
	
	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class SharingMediator extends SuperOneButtonMediator
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		/**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static function get NAME():String
		{
			return getQualifiedClassName(SharingMediator);
		}
		
		private function get view():SharingView
		{
			return viewComponent as SharingView;
		}

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function SharingMediator(viewComponent:Object = null)
		{
			super(SharingMediator.NAME, viewComponent);
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
					trace( "SharingMediator :: handleNotification :: add implementation for notification :: " + notification.getName() );
			}
		}
		
		
		override protected function onViewClick(event:ButtonActionEvent):void
		{
			
			switch (event.buttonName) { 
				case SharingView.FACEBOOK_FIELD_NAME:
					//trace( "SharingMediator :: onViewClick :: FACEBOOK_FIELD_NAME" ); 
					sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.OPEN_FACEBOOK);
					break; 
				case SharingView.FACEBOOK_BUTTON_NAME: 
					//trace( "SharingMediator :: onViewClick :: FACEBOOK_BUTTON_NAME" ); 
					sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.SHARE_ON_FACEBOOK);
					break; 			
				case SharingView.TWITTER_FIELD_NAME:  
					//trace( "SharingMediator :: onViewClick :: TWITTER_FIELD_NAME" ); 
					sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.OPEN_TWITTER);
					break; 
				case SharingView.TWITTER_BUTTON_NAME: 
					//trace( "SharingMediator :: onViewClick :: TWITTER_BUTTON_NAME" ); 
					sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.SHARE_ON_TWITTER);
					break; 
				case TwoStateEnableButtonMovieClip.ENABLE_BTTN_NAME: 
				case SingleButtonView.SUBMIT_BUTTON_NAME:
					//trace( "SharingMediator :: onViewClick :: SUBMIT_BUTTON_NAME" ); 
					var bttn:MovieClip = event.event.target as MovieClip;
					view.enableButton(bttn, false);
					sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.EMBED_CODE);
					break; 
				default: 
					trace( "SharingMediator :: onViewClick :: button action has been not yet defined", event.buttonName );
			}
		}
		
		// --------------------------------------
		// Methods - Protected
		// --------------------------------------
		
		protected function resetView():void
		{
			view.reset();
		}

	}
}