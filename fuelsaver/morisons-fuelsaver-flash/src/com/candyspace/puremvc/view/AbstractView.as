// // // // // // ////////////////////////////////////////////////////////////////////
//
// CANDYMEDIA
// Copyright 2012 CANDYMEDIA
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // // // // ////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.view
{

	import com.candyspace.puremvc.events.ViewEvent;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;

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
	public class AbstractView extends EventDispatcher implements IView
	{
		// --------------------------------------
		// Properties - PUBLIC
		// --------------------------------------
		private var _name:String;

		/**
		 * The name for the AbstractView instance
		 */
		public function get name():String
		{
			return _name;
		}
		
		protected var _vo:*;


		protected var _display:DisplayObject;

		/**
		 * The display component associated with the AbstractView instance
		 */
		public function get display():DisplayObject
		{
			return _display;
		}
		
		protected var _displayClassRef:Class;
		/**
		 * The display component class associated with the AbstractView instance
		 */
		public function get displayClassRef():Class
		{
			return _displayClassRef;
		}
		
		protected var _displayInstanceName:String;
		/**
		 * The display component class associated with the AbstractView instance
		 */
		public function get displayInstanceName():String
		{
			return _displayInstanceName;
		}
		
		/**
		 *  orientation where the view should be display
		 */
		protected var _allowedOrientation:String;
		public function get orientation():String
		{
			return _allowedOrientation;
		}

		private var _isInitialized:Boolean = false;

		/**
		 * Current view instance intialisation state
		 * @return Boolean
		 */
		public function get isInitialized():Boolean
		{
			return _isInitialized;
		}
		
		private var _isUpdated:Boolean = false;

		/**
		 * Current view instance intialisation state
		 * @return Boolean
		 */
		public function get isUpdated():Boolean
		{
			return _isUpdated;
		}
		
		

		/**
		 * Method called when you want to go through the current view 
		 * and the sub views and apply a certain action
		 */
		 // TODO: ====== IMPLEMENT VISITOR:: good application for resize on rotation
		 /*
		public function accept(visitor:IVisitor):void
		{
			visitor.visit(this);

			for (var i:int = 0; i < _views.length; i++)
			{
				_views[i].accept(visitor);
			}
		}
		 */

		// --------------------------------------
		// Properties - PRIVATE
		// --------------------------------------
		/**
		 * The subview components
		 */
		private var _views:Vector.<IView>;
		/**
		 * The number of subview components that have been initialized
		 */
		private var _initializedViewsCnt:uint = 0;
		/**
		 * The number of subview components that have been updated
		 */
		private var _updatedViewsCnt:uint = 0;

		private var _initializedSubViewsNames:Vector.<String> = new Vector.<String>();
		
		private var _updatedSubViewsNames:Vector.<String> = new Vector.<String>();
		
		// --------------------------------------
		// Properties - PROTECTED
		// --------------------------------------
		
		protected var SHOW_SUB_VIEWS_INIT:Boolean = false;
		
		protected function get displayObjectContainer():DisplayObjectContainer
		{
			return _display as DisplayObjectContainer;
		}
		
		private var _viewVO:IViewInitVO;
		protected function get viewVO():IViewInitVO { return _viewVO; }

		// --------------------------------------
		// CONSTRUCTOR
		// -------------------------------------
		public function AbstractView(name:String, displayObjectClassRef:Class = null, displayObject:DisplayObject = null,  orientation:String = "any", addToStageAtStarup:Boolean = true)
		{
			_name = name;
			_display = displayObject;
			_displayClassRef = displayObjectClassRef;
			_allowedOrientation = orientation;
			
			_views = new Vector.<IView>();
			// add subview here
			addSubViews();
		}

		/**
		 * The initialization of the display component for the AbstractView instance
		 * @param	display:DisplayObject - can miss if the AbstractView instance creates 
		 * an actionscript drawn component
		 * @param	params:Array - additional params
		 */
		public function init(viewVO:IViewInitVO = null):void
		{
			/*
			if (!_settingsAdaptor || !_translationAdaptor)
			{
			Logger.error("AbstractView " + name + " -> Please use AbstractView.initSettings(ISettingsParser, ITranslationParser)!");
			}
			 */
			trace('>> AbstractView :: init :: display:', _display, "classRef:", _displayClassRef);
			_viewVO = viewVO;

			if (!_display)
			{
				if (!_displayClassRef)
				{
					_display = initDisplay();
					makeInit();
				}
				else
				{
					_display = new _displayClassRef();
					_display.addEventListener(Event.FRAME_CONSTRUCTED, onFrameContructed);
				}
			}
			else
			{
				initializationComplete();
			}
		}
		
		public function updateDisplayData(vo:*):void
		{
			_vo = vo;
			
			updateDisplay();
			
			
			// TODO implementation
			/**
			 * wait for subviews fr
			 */
			if (_views.length > 0)
			{
				for (var i:int = 0; i < _views.length; i++)
				{
					_updatedSubViewsNames.push(_views[i]);
					_views[i].addEventListener(ViewEvent.DATA_UPDATED, onSubViewUpdated);
					_views[i].updateDisplayData(vo);
				}
			}
			else
			{
				updateProcessComplete();
			}
			 
		}
		
		public function contains(view:IView):Boolean
		{
			var currentView:IView;
			
			if(this == view)
			{
				return true;
			}
			for (var i:int = 0; i < _views.length; i++) 
			{
				currentView = _views[i] as IView;
				if(currentView == view)
				{
					return true;
				}
			}
			
			return false;
		}

		// --------------------------------------
		// Methods - INIT
		// --------------------------------------
		private function onFrameContructed(event:Event):void
		{
			trace("AbstractView :: onFrameConstructed ::", event.target);
			_display.removeEventListener(Event.FRAME_CONSTRUCTED, onFrameContructed);

			makeInit();
		}

		
		private function makeInit():void
		{
			initSubViews(_viewVO);
			
			initVars();
			
			if(display)
			{
				//display.addEventListener(ViewEvent.REMOVED, onRemovedDisplay)
			}
			
			initEventListeners();

			try
			{
				displayObjectContainer.tabChildren = false;
				displayObjectContainer.tabEnabled = false;
				displayObjectContainer.tabIndex = -1;
			}
			catch (error:Error)
			{
			}

			// If not subviews have been added, dispatch the initialized event
			if (_views.length == 0)
			{
				initializationComplete();
			}

		}

		/**
		 * Method called after all the initialization conditions have been met
		 */
		/**
		 * Add all of the initial subviews used by the current view component
		 */
		private function initSubViews(viewVO:IViewInitVO):void
		{
			for (var i:int = 0; i < _views.length; i++) 
			{
				_initializedSubViewsNames.push(_views[i].name);
				_views[i].addEventListener(ViewEvent.INITIALIZED, onSubViewInitialized);
				_views[i].init(viewVO);				
			}			
		}
		
		private function initializationComplete():void
		{
			_isInitialized = true;
			initComplete();

			dispatchEvent(new ViewEvent(ViewEvent.INITIALIZED));
		}
		
		/**
		 * Method called after all the update conditions have been met
		 */
		protected function updateProcessComplete():void
		{
			//_isUpdated = true;
			updateComplete();

			dispatchEvent(new ViewEvent(ViewEvent.DATA_UPDATED));
		}

		// --------------------------------------
		// Methods - ABSTRACT
		// --------------------------------------
		/**
		 * Add all of the initial subviews used by the current view component
		 */
		protected function addSubViews():void
		{
		}
		
		/**
		 * Variable and component initialization.
		 */
		protected function initVars():void
		{
		}

		/**
		 * General listeners initialization.
		 */
		protected function initEventListeners():void
		{
			
		}

		

		/**
		 * Method called after all the subviews have been initialized
		 * OR if no subviews are defined, after initVars() and initEventListeners()
		 */
		protected function initComplete():void
		{
			// Logger.info("AbstractView -> initComplete: " + name + " " + getQualifiedClassName(this));
		}
		
		/**
		 * Method called after all the subviews have been updated
		 * OR if no subviews are defined, after initVars() and initEventListeners()
		 */
		protected function updateDisplay():void
		{
			
		}
		
		protected function updateComplete():void
		{
			// Logger.info("AbstractView -> initComplete: " + name + " " + getQualifiedClassName(this));
		}
		

		// --------------------------------------
		// Methods - PROTECTED
		// --------------------------------------
		/**
		 * Adds a new view subcomponent to the _views Vector
		 * 
		 * @param	view The sub view to be added.
		 * 
		 * @return The component that was just added in the sub views list.
		 */
		protected function addSubView(view:IView):IView
		{
			addSimpleSubView(view);

			//view.addEventListener(ViewEvent.INITIALIZED, onSubViewInitialized);

			return view;
		}

		/**
		 * Adds a sub-view at runtime and calls the 'init' method immediately.
		 * 
		 * @param	view The sub view that will be added.
		 * @param	viewDisplay 
		 * @param	params Additional params that may be needed in the 
		 * 
		 * @return The component that was just added in the sub views list.
		 */
		protected function addRuntimeSubView(view:IView, viewDisplay:DisplayObject = null, viewVO:IViewInitVO = null):IView
		{
			addSubView(view);

			//view.init(viewVO);

			return view;
		}
		
		/**
         * Adds a simple sub-view at runtime without making any changes to it
         * @param	view
         */
        protected function addSimpleSubView(view:IView):void
        {
            _views.push(view);
			_initializedSubViewsNames.push(view.name);
        }

		/**
		 * In case that no display object is supplied in the constructor,
		 * override this function to return the desired instance for the
		 * custom AbstractView implementation
		 * @return
		 */
		protected function initDisplay():DisplayObject
		{
			return new Sprite();
		}

		/**
		 * Returns a simple reference to the DisplayObjectUtil helper class
		 */
		/*
		protected function get util():DisplayObjectUtil
		{
			return DisplayObjectUtil.instance;
		}
		*/

		// --------------------------------------
		// Methods - HANDLERS
		// --------------------------------------
		/**
		 * Handler counting the number of sub-components that have been initialized
		 * When the value reaches the _views.length, it will dispatch the 
		 * ViewEvent.INITIALIZED event
		 * @param	event
		 */
		private function onSubViewInitialized(event:ViewEvent):void
		{
			_initializedViewsCnt++;

			if (_initializedViewsCnt == _views.length)
			{
				for (var i:int = 0; i < _views.length; i++)
				{
					_views[i].removeEventListener(ViewEvent.INITIALIZED, onSubViewInitialized);
				}

				if (!_isInitialized)
				{
					initializationComplete();
				}
			}

			var j:int;
			var item:String;
			for (j = 0; j < _initializedSubViewsNames.length; j++)
			{
				item = _initializedSubViewsNames[j];
				if (item == event.currentTarget.name)
				{
					_initializedSubViewsNames.splice(j, 1);
					break;
				}
			}

			if (SHOW_SUB_VIEWS_INIT)
			{
				trace("\n-----------------\nSub view " + event.currentTarget.name + " initialized.\nRemaining subviews to init: " + _initializedSubViewsNames + "\n-----------------");
			}
		}
		
		/**
		 * Handler counting the number of sub-components that have been initialized
		 * When the value reaches the _views.length, it will dispatch the 
		 * ViewEvent.INITIALIZED event
		 * @param	event
		 */
		private function onSubViewUpdated(event:ViewEvent):void
		{
			_updatedViewsCnt++;

			if (_updatedViewsCnt == _views.length)
			{
				for (var i:int = 0; i < _views.length; i++)
				{
					_views[i].removeEventListener(ViewEvent.DATA_UPDATED, onSubViewInitialized);
				}

				
				updateProcessComplete();
				
				if (!isUpdated)
				{
				}
			}

			var j:int;
			var item:String;
			for (j = 0; j < _updatedSubViewsNames.length; j++)
			{
				item = _updatedSubViewsNames[j];
				if (item == event.currentTarget.name)
				{
					_updatedSubViewsNames.splice(j, 1);
					break;
				}
			}

			if (SHOW_SUB_VIEWS_INIT)
			{
				trace("\n-----------------\nSub view " + event.currentTarget.name + " updated.\nRemaining subviews to init: " + _updatedSubViewsNames + "n-----------------");
			}
		}

		public function destroyDisplay():void
		{
		}
		
		private function onRemovedDisplay(event:ViewEvent):void
		{
			//_display = null;
			//_isInitialized = false;
			//_isUpdated = false;
			trace("AbstractView :: remove display");
			trace("AbstractView :: remove display");
		}
		

		
	}
}
