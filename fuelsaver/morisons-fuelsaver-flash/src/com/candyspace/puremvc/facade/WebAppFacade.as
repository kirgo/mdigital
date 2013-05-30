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

	import flash.display.Sprite;
	import uk.co.bdoran.util.FillClip;
	import com.candyspace.puremvc.controller.startupmanager.RemovePreloaderCommand;
	import com.candyspace.puremvc.controller.startup.web.WAViewsInitializedCommand;
	import com.candyspace.puremvc.controller.startup.web.LoadingCompleteCommand;
	import com.candyspace.puremvc.controller.services.GoogleStaticMapController;
	import org.puremvc.as3.multicore.utilities.startupmanager.controller.StartupResourceLoadedCommand;
	import org.puremvc.as3.multicore.utilities.startupmanager.controller.StartupResourceFailedCommand;
	import com.candyspace.puremvc.controller.startupmanager.ShowPreloaderCommand;
	import flash.events.Event;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import com.candyspace.puremvc.controller.startupmanager.PreloadCommand;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
	import com.candyspace.puremvc.core.Notifications;
	

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
	public class WebAppFacade extends AppFacade
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		private static var instance:WebAppFacade;
		public static function getInstance():WebAppFacade
		{
			if (instance == null)
			{
				instance = new WebAppFacade(WebAppFacade.MAIN_APP_KEY);
			}

			return instance as WebAppFacade;
		}

		// --------------------------------------
		// Properties - Private
		// --------------------------------------
		public static var MAIN_APP_KEY:String = "mainWebApplication";
		
		

		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function WebAppFacade(key:String)
		{
			trace(" INIT WebAppFacade FACADE");
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
			sendNotification(Notifications.instance.PRELOAD_APPLICATION);
		}
		


		override public function initCustomProxies():void
		{
			super.initCustomProxies();
			
		}

		override public function initCustomCommands():void
		{
			super.initCustomCommands();
			
			registerCommand(Notifications.instance.PRELOAD_APPLICATION, PreloadCommand);
			
			registerCommand(Notifications.instance.PRELOADER_LOADED, ShowPreloaderCommand);
			
			registerCommand(Notifications.instance.XML_RESOURCE_LOADED, StartupResourceLoadedCommand);
			
			registerCommand(Notifications.instance.SKIN_LOADED, StartupResourceLoadedCommand);		
				
			
			//Hopefully none of these notifications will occur
            registerCommand(Notifications.instance.PRELOADER_LOADING_FAIL, StartupResourceFailedCommand);
			registerCommand(Notifications.instance.SKIN_LOADING_FAIL, StartupResourceFailedCommand);
			registerCommand(Notifications.instance.XML_RESOURCE_LOADING_FAIL, StartupResourceFailedCommand);
			
			registerCommand(Notifications.instance.LOADING_COMPLETE, LoadingCompleteCommand);
			
			registerCommand(Notifications.instance.REMOVE_PRELOADER, RemovePreloaderCommand);
			
			registerCommand(Notifications.instance.VIEWS_INITIALIZED, WAViewsInitializedCommand);
			
			
			
			
			
			
			
			
			// services
			registerCommand(Notifications.instance.GOOGLE_STATIC_MAP_ACTION, GoogleStaticMapController);
			
			
		}
		

		override public function initCustomViews():void
		{
			super.initCustomViews();
			
			//_menu = new MenuView("menuView", Sprite);
			
		}
		
		override public function initCustomMediators():void
		{
			super.initCustomMediators();
			
			//registerMediator(new MenuMediator(_menu));
		}
		// --------------------------------------
		// Methods - Public
		// --------------------------------------

		// --------------------------------------
		// METHODS - PROTECTED
		// --------------------------------------
		override protected function initView():void
		{
			
			if (stage)
			{
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
				//fillStage();
			}
            else
            {
                _application.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            }
		}
		
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		var _background:Sprite;
		protected function fillStage():void
		{
			if ( !_background )
			{
				_background = new Sprite();
				stage.addChild(_background);
			}
			_background.graphics.clear();
			FillClip.fillClipWithClipDimentions(_background, stage);
		}
		
		// --------------------------------------
		// Event handlers
		// --------------------------------------
	}
}
