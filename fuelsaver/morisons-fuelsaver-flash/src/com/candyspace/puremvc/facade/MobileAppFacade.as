// // ////////////////////////////////////////////////////////////////////////////
//
// CANDYMEDIA
// Copyright 2012 CANDYMEDIA
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // //////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.facade
{

	import com.candyspace.puremvc.controller.OrientationChangedCommand;
	import com.candyspace.puremvc.controller.startup.ApplicationStartupCommand;
	import com.candyspace.puremvc.controller.startup.CheckNetworkCommand;
	import com.candyspace.puremvc.controller.startup.ClearAllDataAndExitMacroCommand;
	import com.candyspace.puremvc.controller.startup.ClearLocalPersistenceDataCommand;
	import com.candyspace.puremvc.controller.startup.GetDevicePropertiesCommand;
	import com.candyspace.puremvc.controller.startup.RetrieveGeolocationDataCommand;
	import com.candyspace.puremvc.controller.startup.RetrievePersistenceDataCommand;
	import com.candyspace.puremvc.controller.startup.SaveLocalPersistenceDataCommand;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.core.layers.ApplicationLayers;
	import com.candyspace.puremvc.core.layers.ApplicationLayersMediator;
	import com.candyspace.puremvc.core.layers.GeneralLayers;
	import com.candyspace.puremvc.mediator.MenuMediator;
	import com.candyspace.puremvc.mediator.StageMediator;
	import com.candyspace.puremvc.model.NetworkMonitorProxy;
	import com.candyspace.puremvc.model.StateProxy;
	import com.candyspace.puremvc.view.IView;
	import com.candyspace.puremvc.view.menu.MenuView;

	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	

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
	public class MobileAppFacade extends AppFacade
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		private static var instance:MobileAppFacade;
		public static function getInstance():MobileAppFacade
		{
			if (instance == null)
			{
				instance = new MobileAppFacade(MobileAppFacade.MAIN_APP_KEY);
			}

			return instance as MobileAppFacade;
		}

		// --------------------------------------
		// Properties - Private
		// --------------------------------------
		protected static var MAIN_APP_KEY:String = "mainMobileApplication";
		
		

		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function MobileAppFacade(key:String)
		{
			super(key);
			initVars();
		}

		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		private function initVars():void
		{
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------

		/**
		 * 
		 * @param	applicationView
		 */
		override public function init():void
		{
			// Set the stage properties
			initView();

			
			
			// start application
			sendNotification(Notifications.instance.STARTUP);
		}
		


		override public function initCustomProxies():void
		{
			super.initCustomProxies();
			
			//registerProxy(new ConnectionProxy());
			
			registerProxy(new StateProxy());
			
			registerProxy(new NetworkMonitorProxy());
			
			//facade.registerProxy( new TrackingProxy() );
			
			
			// .... no needed or already in used
			
//			facade.registerProxy( new FeedsProxy() );
//			
//			var app : ITVMobilePlayer = notification.getBody() as ITVMobilePlayer;
//			
//			var stateProxy : StateProxy = new StateProxy(app);
//			
//			facade.registerProxy( stateProxy );
//			
//			
//			facade.registerProxy( new NetworkMonitorProxy() );
//			
//			facade.registerProxy( new LastWatchedProxy() );
//
//            facade.registerProxy(new PinServiceProxy());
//
//            facade.registerProxy(new EmailService());
		}

		override public function initCustomCommands():void
		{
			super.initCustomCommands();
			
			registerCommand(Notifications.instance.STARTUP, ApplicationStartupCommand);
			
			registerCommand(Notifications.instance.GET_DEVICE_PROPERTIES, GetDevicePropertiesCommand);
			
			registerCommand(Notifications.instance.CHECK_NETWORK_STATUS, CheckNetworkCommand);
			
			registerCommand(Notifications.instance.RETRIEVE_PERSISTENCE_DATA, RetrievePersistenceDataCommand);
			
			registerCommand(Notifications.instance.SAVE_PERSISTENCE_DATA, SaveLocalPersistenceDataCommand);
			
			registerCommand(Notifications.instance.CLEAR_LOCAL_PERSISTENCE_DATA, ClearLocalPersistenceDataCommand);

			registerCommand(Notifications.instance.EXIT_APPLICATION, ClearLocalPersistenceDataCommand);

			registerCommand(Notifications.instance.EXIT_AND_CLEAR_DATA_APPLICATION, ClearAllDataAndExitMacroCommand);

			
			
			
			registerCommand(Notifications.instance.RETRIEVE_GEOLOCATION_DATA, RetrieveGeolocationDataCommand);
			
			//registerCommand(Notifications.instance.REGISTER_FSM, InjectFSMCommand)
			
			
			
			registerCommand(Notifications.instance.ORIENTATION_CHANGED, OrientationChangedCommand);
			
			///////////////////////////////////////////////////////////////////
			/*
			facade.registerCommand(Notifications.REQUEST_PIN , SendEmailRemainderCommand);
            facade.registerCommand(Notifications.LOCATION_LOOKUP_REQUEST, LocationLookupCommand);
			facade.registerCommand(Notifications.CHECK_PERSISTANCE_FILE, CheckPersistenceDataCommand);
			facade.registerCommand(Notifications.SHOW_POSTCODE_VIEW, ShowPostcodeViewCommand);
			facade.registerCommand(Notifications.INIT_PROCESS_COMPLETE , RequestMasterFeedCommand);
			facade.registerCommand(Notifications.MASTER_FEED_LOAD_SUCCESSFUL,CheckAndShowUpdateMessageCommand);
			facade.registerCommand(Notifications.INITIALIZE_VIEW,InitializeViewCommand);
			facade.registerCommand(Notifications.REQUEST_FEED_INJECTION, RequestFeedInjectionCommand);
			facade.registerCommand(Notifications.SHOW_PROGRAMME_DETAIL, ShowProgrammeDetailCommand);
			facade.registerCommand(Notifications.ORIENTATION_CHANGED,OrientationChangedCommand);
			facade.registerCommand(Notifications.LOAD_VIEW,LoadViewCommand);
			facade.registerCommand(Notifications.PERFORM_SEARCH,SearchCommand);
			facade.registerCommand(Notifications.SHOW_POPUP,ShowPopupCommand);
			facade.registerCommand(Notifications.CREATE_LANDSCAPE_CAROUSEL_ITEMS, CreateLandscapeCarouselItemsCommand);
			facade.registerCommand(Notifications.PROCESS_LANDSCAPE_VIEW_ITEM, ProcessLandscapeViewItemCommand);
			facade.registerCommand(Notifications.PERFORM_LETTER_LOOKUP, LetterLookupCommand);
			facade.registerCommand(Notifications.PLAY_VIDEO, PlayVideoCommand);
			facade.registerCommand(Notifications.GO_BACK, GoBackCommand);
			facade.registerCommand(Notifications.TERMINATE_VIDEO_PLAYER, TerminateVideoPlayerCommand);
			facade.registerCommand(Notifications.APP_ACTIVATED, ApplicationActivatedCommand);
			facade.registerCommand(Notifications.APP_DEACTIVATED, ApplicationDeactivatedCommand);
			facade.registerCommand(Notifications.NETWORK_CONNECTION_CHANGED,NetworkConnectionChangedCommand);
			facade.registerCommand(Notifications.POPUP_DISMISSED,PopupDismissedCommand);
			facade.registerCommand(Notifications.REQUEST_NEW_VIDEO_PLAYER,RequestNewVideoPlayerCommand);
			facade.registerCommand(Notifications.SEND_EMAIL_ADDRESS,SendEmailAddressCommand);
			facade.registerCommand(Notifications.LOAD_LAST_WATCHED,LoadLastWatchedCommand);
			facade.registerCommand(Notifications.CLEAR_LAST_WATCHED,ClearLastWatchedCommand);
			facade.registerCommand(Notifications.SAVE_PIN,SavePinCommand);
			facade.registerCommand(Notifications.CHECK_CONNECTION, CheckConnectionCommand);
			facade.registerCommand(Notifications.CLEAR_ALL_DATA, ClearAllDataCommand);
			
			
			facade.registerCommand(Notifications.UPDATE_VIEW_DATA, UpdateViewDataCommand);
			
			
			
			facade.registerCommand(Notifications.INIT_TRACKING, InitialiseTrackingCommand );
			facade.registerCommand(Notifications.TRACK_ACTION, TrackActionCommand);
			facade.registerCommand(Notifications.TRACK_PAGE, TrackPageCommand );
			facade.registerCommand(Notifications.TRACK_PERSISTENT_PAGE, TrackPersistentPageCommand );
			 */
			///////////////////////////////////////////////////////////////////
		}
		

		override public function initCustomViews():void
		{
			super.initCustomViews();
			
			_menu = new MenuView("menuView", Sprite);
			
		}
		
		override public function initCustomMediators():void
		{
			super.initCustomMediators();
			
			registerMediator(new StageMediator(StageMediator.NAME, stage));
			registerMediator(new MenuMediator(_menu));
		}
		// --------------------------------------
		// Methods - PROTECTED
		// --------------------------------------
		override protected function initView():void
		{
			if (stage)
			{
				stage.align = StageAlign.TOP_LEFT;
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
				stage.scaleMode = StageScaleMode.NO_SCALE;
			}
			else
			{
				_application.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}

			// net menu
			// var menu:ContextMenu = new ContextMenu();
			
			// hide items
			// menu.hideBuiltInItems();
		}

		// --------------------------------------
		// METHODS - PRIVATE
		// --------------------------------------
		
		// --------------------------------------
		// Event handlers - Overriden
		// --------------------------------------
		// --------------------------------------
		// Event handlers
		// --------------------------------------
	}
}
