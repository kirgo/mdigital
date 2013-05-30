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

	import org.puremvc.as3.multicore.core.View;

	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.events.ViewEvent;
	import com.candyspace.puremvc.model.StateProxy;
	import com.candyspace.puremvc.view.IView;
	import com.candyspace.puremvc.view.IViewInitVO;

	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

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
	public class SuperMediator extends Mediator implements IMediator
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		protected var _stateProxy:StateProxy;

		protected function get stateProxy():StateProxy
		{
			if (!_stateProxy)
			{
				_stateProxy = facade.retrieveProxy(StateProxy.NAME) as StateProxy;
				if (!_stateProxy)
				{
					trace(getQualifiedClassName(this) + " will not be created. Register the StateProxy first.");
				}
			}

			return _stateProxy;
		}

		/**
		 * Method used to get a reference to the view attached to the current mediator. Apart from the 
		 * viewComponent property, this getter returns a reference already casted to the view type.
		 */
		private function get view():IView
		{
			return viewComponent as IView;
		}

		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function SuperMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);

			// TODO: add INITIALISED procedure
			// init();

			initNotifications();

			// this should go into initialized() when in place
			initEventListener();
		}
		
		// hace un mes que mi tia murio. 
		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		
		
		/**
		 * Metthod called when the INIT_VIEWS notification is received. Initializes the view and the mediator.
		 */
		private function init(param:* = null):void
		{
			trace("===================", param);
			var vyoo:IView;
			if(param is ViewEvent)
			{
				vyoo = param.target as IView;
			}
			if(param is IView)
			{ 
				vyoo = param as IView;
			}
			if (!vyoo)
			{
				vyoo = view;
			}
			
			trace(">> SuperMediator :: init :: ", "view:", vyoo, "initialized:", vyoo.isInitialized);
			// if (param)
			// {
			//                // Logger.debug(getQualifiedClassName(this) + "::init");
			// trace(getQualifiedClassName(this) + "::init");
			// }
			if (vyoo)
			{
				if (vyoo.isInitialized)
				{
					initialized(vyoo);

					// send a notification to the QueueMediator, in order to let it now that the init
					// process for this mediator finished successfully
					// sendNotification(Notifications.instance.VIEW_ADDED, this);

					vyoo.removeEventListener(ViewEvent.INITIALIZED, init);
				}
				else
				{
					vyoo.addEventListener(ViewEvent.INITIALIZED, init);
					vyoo.init();
					// initView();
				}
			}
			else
			{
				initialized(vyoo);
				// sendNotification(Notifications.instance.VIEW_ADDED, this);
			}
		}

		override public function onRegister():void
		{
			super.onRegister();

			addViewsStartup();
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		override public function listNotificationInterests():Array
		{
			var interests:Array = super.listNotificationInterests();

			interests.push(Notifications.instance.INIT_VIEW);
			interests.push(Notifications.instance.INIT_DISPLAY);

			return interests;
		}

		private var _layer:String;

		override public function handleNotification(notification:INotification):void
		{
			super.handleNotification(notification);

			switch(notification.getName())
			{
				case Notifications.instance.INIT_VIEW:
					// registerToLayers();
					var noteView:IView = notification.getBody() as IView;
					trace("===========================================", " contains", noteView, ":", view.contains(noteView));
					_layer = notification.getType();
					//
					if (view.contains(noteView))
					{
						trace("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&   el aroma del mar:", noteView == view);
						init(noteView);
					}
					break;
				case Notifications.instance.INIT_DISPLAY:
					// init();
					break;
				default:
			}
		}

		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		public function updateDisplayData(vo:*, vyoo:IView = null):void
		{
			if (!vyoo)
			{
				vyoo = view;
			}
			trace(">> SuperMediator :: updateDisplayData :: data:", vo, "::");
			if (vo)
			{
				// there could be the need to add other implemention that delays next line
				vyoo.addEventListener(ViewEvent.DATA_UPDATED, onDisplayUpdateComplete);
				
				vyoo.updateDisplayData(vo);
			}
		}

		// --------------------------------------
		// Methods - Protected
		// --------------------------------------
		/**
		 * Anchor point used to init the view component. It defaults to the null init
		 */
		protected function initView():void
		{
			view.init();
		}
		
		protected function setInitialData():*
		{
			if (stateProxy && stateProxy.currentViewVo)
			{
				return stateProxy.currentViewVo
			}
			
			return null;
		}

		/**
		 * Anchor point called when the initialization process is complete
		 */
		protected function initialized(vyoo:IView):void
		{
			trace(">> SuperMediator :: initialized :: ", vyoo);
			// Logger.debug(getMediatorName() + "::initialized");
			if (setInitialData())
			{
				updateDisplayData(setInitialData(), vyoo);
			}
			else
			{
				displayUpdateComplete(vyoo);
			}
		}

		// --------------------------------------
		// Methods - Protected Abstract
		// --------------------------------------
		protected function initNotifications():void
		{
		}

		protected function addViewsStartup():void
		{
		}

		protected function initEventListener():void
		{
		}

		protected function initializedComplete():void
		{
		}

		protected function updated():void
		{
		}

		// --------------------------------------
		// Event handlers
		// --------------------------------------
		protected function onDisplayUpdateComplete(event:ViewEvent):void
		{
			var vyoo:IView = event.target as IView;
			displayUpdateComplete(vyoo);
		}

		protected function displayUpdateComplete(vyoo:IView):void
		{
			trace(">> SuperMediator :: displayUpdateComplete :: ", vyoo);
			updated();

			sendNotification(Notifications.instance.VIEW_ADDED, vyoo, _layer);
		}
	}
}
