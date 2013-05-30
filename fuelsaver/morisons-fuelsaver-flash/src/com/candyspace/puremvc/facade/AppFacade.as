// // // // // //////////////////////////////////////////////////////////////////////
//
// CANDYMEDIA
// Copyright 2012 CANDYMEDIA
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // // // // ////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.facade
{

	import com.candyspace.puremvc.core.layers.ApplicationLayers;
	import com.candyspace.puremvc.core.layers.ApplicationLayersMediator;
	import com.candyspace.puremvc.view.IView;

	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
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
	public class AppFacade extends Facade implements IAppFacade
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		private static var instance:AppFacade;

		public static function getInstance():AppFacade
		{
			if (instance == null)
			{
				instance = new AppFacade(AppFacade.MAIN_APP_KEY);
			}

			return instance as AppFacade;
		}

		// --------------------------------------
		// Properties - Private
		// --------------------------------------
		protected static var MAIN_APP_KEY:String = "mainApplication";
		
		/**
		 * Reference to the main application movie clip.
		 */
		protected var _application:DisplayObjectContainer;

		/**
		 * Reference to the main application movie clip.
		 */
		public function get application():DisplayObjectContainer
		{
			return _application as DisplayObjectContainer;
		}
		
		public function get stage():Stage
		{
			return _application.stage as Stage;
		}

		protected var _currentState:String = "";

		/**
		 * The current state of the game
		 */
		public function get currentState():String
		{
			return _currentState;
		}

		public function set currentState(value:String):void
		{
			_currentState = value;
		}

		// /**
		// * The complex IConnectionValidator used to validate the connection data
		// */
		// protected var _validator:IConnectionValidator;
		// public function get validator():IConnectionValidator
		// {
		// if (_validator == null)
		// {
		// Logger.warning("GameFacade :: The _validator was not initialized. A default validator will"
		// + " be returned.");
		// return new AbstractConnectionValidator();
		// }
		//
		// return _validator;
		// }
		// public function set validator(value:IConnectionValidator):void
		// {
		// _validator = value;
		// }
		
		/**
		 * instantiation to be done at the child facadeInitizialised()
		 */
		protected var _applicationLayers:Array = [];

		/**
		 * Returns an array the specifies the order of the applicaiton layers and if they are
		 * added, or not, to the stage on application startup.
		 */
		public function get applicationLayers():Array
		{
			return _applicationLayers;
		}

		public function set applicationLayers(value:Array):void
		{
			_applicationLayers = value;
		}

		protected var _menu:IView;
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function AppFacade(key:String)
		{
			super(key);
			trace(" INIT APP FACADE");
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
		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		public function registerApplication(applicationView:DisplayObjectContainer):void
		{
			_application = applicationView;
		}

		/**
		 * 
		 * @param	applicationView
		 */
		public function init():void
		{
			// Set the stage properties
			initView();

			// start application
			//sendNotification(Notifications.instance.STARTUP);
		}

		public function initApplicationLayers():void
		{
			registerMediator(new ApplicationLayersMediator(ApplicationLayers.instance));
		}


		public function initCustomProxies():void
		{
			
		}

		public function initCustomCommands():void
		{
			// registerCommand(Notifications.instance.REGISTER_FSM, InjectFSMCommand)

		}


		public function initCustomViews():void
		{
			
		}

		public function initCustomMediators():void
		{
			
		}

		// --------------------------------------
		// METHODS - PROTECTED
		// --------------------------------------
		protected function initView():void
		{
			
		}

		public function replaceCommand(notificationName:String, commandClassRef:Class):void
		{
			if (hasCommand(notificationName))
			{
				removeCommand(notificationName);
			}
			registerCommand(notificationName, commandClassRef);
		}
		
		public function replaceProxy(proxy:IProxy):void
		{
			var proxyName:String = getClassRef(proxy).NAME;
			
			if (hasProxy(proxyName))
			{
				removeProxy(proxyName);
			}
			registerProxy(proxy);
		}
		
		public function replaceMediator(mediator:IMediator):void
		{
			var mediatorName:String = getClassRef(mediator).NAME;
			
			if (hasMediator(mediatorName))
			{
				removeMediator(mediatorName);
			}
			registerMediator(mediator);
		}
		
		protected function getClassRef(instance:*):Class
		{
			var className:String = getQualifiedClassName( instance );
			return getDefinitionByName( className ) as Class
		}

		// --------------------------------------
		// Event handlers - Overriden
		// --------------------------------------
		// --------------------------------------
		// Event handlers
		// --------------------------------------
		protected function onAddedToStage(event:Event):void
		{
			_application.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			initView();
		}
	}
}
