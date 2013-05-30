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
	import com.candyspace.morrisonFuelSaver.mediator.view.LocationResultView;
	import com.candyspace.morrisonFuelSaver.mediator.view.SingleButtonView;
	import com.candyspace.morrisonFuelSaver.model.LocationProxy;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.events.ButtonActionEvent;
	import com.candyspace.puremvc.model.services.GoogleStaticMapProxy;
	import com.candyspace.puremvc.model.services.GoogleStaticMapVO;

	import org.puremvc.as3.multicore.interfaces.INotification;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class LocationResultsMediator extends SuperOneButtonMediator
	{
		protected var locationProxy : LocationProxy;
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		/**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static function get NAME():String
		{
			return getQualifiedClassName(LocationResultsMediator);
		}
		
		public function get view():LocationResultView
		{
			return viewComponent as LocationResultView;
		}
		
		// displayed result page counter
		protected var _viewStoreCounter:int;

		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function LocationResultsMediator(viewComponent:Object = null)
		{
			super(LocationResultsMediator.NAME, viewComponent);
		}

		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		override public function onRegister():void
		{
			super.onRegister();
			//trace("=================  This mediator has been registered :: \t", NAME);
		}
		
		override protected function setInitialData():*
		{
			//counter
			locationProxy = facade.retrieveProxy(LocationProxy.NAME) as LocationProxy;

			return locationProxy.vo;
		}

		override protected function initEventListener():void
		{
			super.initEventListener();
			
			view.addEventListener("requestInitialMap", onInitialMap)
		}
		
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		
		override public function listNotificationInterests():Array
		{			
			var interests:Array = super.listNotificationInterests();

			interests.push(Notifications.instance.GOOGLE_STATIC_MAP_LOADED);

			return interests;
		}

		override public function handleNotification(notification:INotification):void
		{
			super.handleNotification(notification);
			
			switch(notification.getName())
			{
				case Notifications.instance.GOOGLE_STATIC_MAP_LOADED:
				var map:DisplayObject = notification.getBody() as DisplayObject;
				view.showNewResult(_viewStoreCounter);
				view.showMap(map);
				break;
			}	
		}

		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		
		public function getInitialMap():void
		{
			_viewStoreCounter = 0;
			
			sendMapRequest(view.stores[_viewStoreCounter].lat, view.stores[_viewStoreCounter].lon);
		}
		
		public function getNextResultMap():void
		{
			_viewStoreCounter++;
			
			if(_viewStoreCounter > 2)
			{
				_viewStoreCounter = 0;
			}
			
			sendMapRequest(view.stores[_viewStoreCounter].lat, view.stores[_viewStoreCounter].lon);
		}
		
		public function getPrevResultMap():void
		{
			_viewStoreCounter--;
			
			if(_viewStoreCounter < 0)
			{
				_viewStoreCounter = 2;
			}
			
			sendMapRequest(view.stores[_viewStoreCounter].lat, view.stores[_viewStoreCounter].lon);
		}

		public function updateResult():void
		{
			if(view.isInitialized)
			{
				view.updateDisplayData(locationProxy.vo);
			}
			else
			{
				showView();
			}
		}
		
		// --------------------------------------
		// Methods - Protected
		// --------------------------------------
		
		protected function onInitialMap(event:Event):void
		{
			getInitialMap();
		}
		
		protected function sendMapRequest(lat:String, lon:String):void
		{
			var mapVO:GoogleStaticMapVO = new GoogleStaticMapVO();
			mapVO.latitude = Number(lat);
			mapVO.longitude = Number(lon);
			sendNotification(Notifications.instance.GOOGLE_STATIC_MAP_ACTION, mapVO, GoogleStaticMapProxy.LOAD_ICON_CENTERED_MAP);
		}

		// --------------------------------------
		// Event Handler
		// --------------------------------------
		
		override protected function onViewClick(event:ButtonActionEvent):void
		{
			switch (event.buttonName) 
			{ 
				case LocationResultView.NEXT_BUTTON_NAME: 
					//trace( "NEXT_BUTTON_NAME" ); 
					getNextResultMap();
					break; 			  
				case LocationResultView.MAP_CONTAINER_NAME: 
					//trace( "NEXT_BUTTON_NAME" ); 
					sendNotification(FSNotifications.instance.USER_ACTION, view.stores[_viewStoreCounter], FSUserActions.OPEN_EXTERNAL_MAP);
					break; 			  
				case LocationResultView.PREV_BUTTON_NAME: 
					//trace( "PREV_BUTTON_NAME" ); 
					getPrevResultMap();
					break; 
				case SingleButtonView.SUBMIT_BUTTON_NAME: 
					//trace( "SUBMIT_BUTTON_NAME" ); 
					sendNotification(FSNotifications.instance.USER_ACTION, null, FSUserActions.OPEN_LOCATION);
					break; 
				default: 
					trace( "LocationResultsMediator :: add implementation for button :: " + event.buttonName);
			}
		}
	}
}