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
package com.candyspace.puremvc.core
{

	import uk.co.bdoran.util.FillClip;
	import com.candyspace.puremvc.facade.IAppFacade;
	import com.candyspace.puremvc.facade.AppFacade;

	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.geom.Rectangle;
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
	public class AbstractEntryPointLogic extends Sprite
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		protected var _background:Sprite;
		protected var _facade:IAppFacade;
		protected var _settings:Settings;
		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function AbstractEntryPointLogic()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//public function 

		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		protected function init(e:Event):void
		{
			
			trace(this.stage.loaderInfo.parameters.baseURL);
			
			 // first thing that needs to be initialized is the notifications class
			initNotifications();
			
			// first thing that needs to be initialized is the notifications class
			initSettings();
			
			
			_settings.parameters = this.stage.loaderInfo.parameters;
			trace(_settings.parameters);
			
			initCustomSettings();
			

			// second mandatory thing is the initialization of the lowest Facade class
			_facade = initFacade();
			trace("------", _facade, initFacade());
			// start the application
			_facade.registerApplication(this);

			initValidators();

			// _facade.validator = _rootValidator;

			facadeInitialized();
			
			// layers should have been set at the subclass facadeInitialized before hand
			_facade.initApplicationLayers();

			// do the custom views initializations from the facade first
			_facade.initCustomViews();
			// do the custom views initializations
			initCustomViews();

			// do the custom initializations

			// initialize the facade custom commands
			_facade.initCustomCommands();

			// initialize the custom commands
			initCustomCommands();

			// initialize the custom mediators
			// var viewsQueue:ViewsInitQueue = GameFacade.getInstance().viewsQueue;

			// initialize the custom mediators - facade first
			_facade.initCustomMediators();

			// do the custom mediators initializations
			initCustomMediators();
			
			// [c]
			_facade.initCustomProxies();
			initCustomProxies();

			// anchor point for the initialization of other resources
			initOtherResources();

			// start the application
			_facade.init();
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		private function setupStage():void
		{
			// stage.align = StageAlign.TOP_LEFT;
			// stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			// stage.scaleMode = StageScaleMode.NO_SCALE;
			stageResizeHandler();
		}

		private function stageResizeHandler(event:Event = null):void
		{
			fillStage();
			setSourceRect();
			// var orientation : String = AppConstants.ORIENTATION_PORTRAIT;
			// orientation = stage.stageWidth > stage.stageHeight ? OrientationChangedEvent.LANDSCAPE : OrientationChangedEvent.PORTRAIT;
			// dispatchEvent( new OrientationChangedEvent( orientation ) );
		}

		private function setSourceRect():void
		{
			if (stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE || stage.displayState == StageDisplayState.FULL_SCREEN)
			{
				stage.fullScreenSourceRect = null;
				stage.displayState = StageDisplayState.NORMAL;
				stage.fullScreenSourceRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
		}

		protected function fillStage():void
		{
			if ( !_background )
			{
				_background = new Sprite();
				addChild(_background);
			}
			_background.graphics.clear();
			FillClip.fillClipWithClipDimentions(_background, stage);
		}

		// --------------------------------------
		// Methods - Abstract
		// --------------------------------------
		
		/*
		 * sets parameters settings property with the url query vars
		 */
		protected function initSettings():void
		{
			throw new Error("implement initSettings method in your application entry class :: [ApplicationSettings].instance");
            
		}
		protected function initValidators():void
		{
			// _rootValidator = new RootValidator();
			//            
			//            //  add the common validators
			// _rootValidator.addValidator(new ErrorValidator());
			// _rootValidator.addValidator(new WarningValidator());
			// _rootValidator.addValidator(new PingValidator());
			//            
			//            //  create and register the data validator
			// _dataValidator = new DataValidator();
			// _rootValidator.addValidator(_dataValidator);
			// _dataValidator.addValidator(new IDValidator());
		}
		
		protected function initCustomSettings():void
		{
			
		}

		/**
		 * Method used to instantiate the lowest facade class.
		 * 
		 * @return The instance of the facade.
		 */
		protected function initFacade():IAppFacade
		{
			/*
			throw new Error(
			getQualifiedClassName(this) + "::initFacade - Please initialize the facade class that"
			+ " is situated at the bottom of the 'Facade' class hierarchy.\n\n"
			+ "Example: if the current game is Roulette3D, call R3DFacade.getInstance(), if the class"
			+ " exists, or RFacade.getInstance(), if this is the lowest class from the hierarchy.\n"
			);
			 */
			return AppFacade.getInstance();
		}

		protected function facadeInitialized():void
		{
		}

		/**
		 * Abstract method - can be overridden in the sub-classes in otder to add the custom commands.
		 */
		protected function initCustomCommands():void
		{
		}

		/**
		 * Abstract method - can be overridden in the sub-classes in otder to add the custom mediators.
		 */
		protected function initCustomMediators():void
		{
		}

		/**
		 * Abstract method - can be overridden in the sub-classes in otder to add / replace the custom views.
		 */
		protected function initCustomViews():void
		{
		}
		/**
		 * 
		 * Abstract method - can be overridden in the sub-classes in otder to add / replace the custom proxies.
		 */
		protected function initCustomProxies():void
		{
		}

		/**
		 * Abstract method - can be used to initialize other important resources, before starting the
		 * application.
		 */
		protected function initOtherResources():void
		{
		}
		
		// --------------------------------------
		// Methods - Protected
		// --------------------------------------
		/**
         * Method used to force the sub-classes to initialize the lowest level notifications class.
         */
        protected function initNotifications():Notifications
        {
            throw new Error(
                                getQualifiedClassName(this) + "::initNotifications - Please initialize the notifications class that"
                                + " is situated at the bottom of the 'Notifications' class hierarchy.\n\n"
                                + "Example: if the current game is Roulette3D, call R3DNotifications.instance, if the class"
                                + " exists, or RNotifications.instance, if this is the lowest class from the hierarchy.\n"
                           );
            return Notifications.instance;
        }
		// --------------------------------------
		// Event handlers - Overriden
		// --------------------------------------
		// --------------------------------------
		// Event handlers
		// --------------------------------------
	}
}
