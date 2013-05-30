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
package com.candyspace.puremvc.model.startupmanager
{

	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.core.Settings;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import org.puremvc.as3.multicore.utilities.startupmanager.interfaces.IStartupProxy;


	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// Imports
	// --------------------------------------
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class PreloaderProxy extends EntityProxy implements IStartupProxy
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC
		// GETTERS/SETTERS
		// PROTECTED
		// PRIVATE
		private var _preloader:DisplayObject;

		public function get preloader():DisplayObject
		{
			return _preloader;
		}

		private var _currentURL:String;
		// STATIC FUNCTIONS
		/**
		 * Proxy name
		 */
		public static const NAME:String = "PreloaderProxy";
		/**
		 * Resrouce name
		 */
		public static const RNAME:String = "Resource_PreloaderProxy";

		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function PreloaderProxy()
		{
			super(NAME);
		}

		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		public function load():void
		{
			_currentURL = Settings.instance.preloaderURL;
			
			trace("PreloaderProxy - Loading process started:", _currentURL);


			if (_currentURL)
			{
				var loader:Loader = new Loader();
				var request:URLRequest = new URLRequest(_currentURL);

				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onPreloaderLoaded);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onPreloaderFail);

				trace("PreloaderProxy - Start loading from URL: " + request.url);

				loader.load(request);
			}
			else
			{
				//onPreloaderLoaded(null);
			}
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		override public function onRemove():void
		{
			super.onRemove();

			_preloader = null;
			data = null;
		}

		// --------------------------------------
		// Event handlers
		// --------------------------------------
		private function onPreloaderLoading(event:ProgressEvent):void
		{
			sendNotification(Notifications.instance.PRELOADER_LOADING_FAIL, event.bytesLoaded, RNAME);
		}

		private function onPreloaderLoaded(event:Event):void
		{
			if (event)
			{
				data = LoaderInfo(event.target).content;
			}
			
			trace("PreloaderProxy - Loading process finished.\n", data);
			sendNotification(Notifications.instance.PRELOADER_LOADED, NAME, RNAME);
		}

		private function onPreloaderFail(event:IOErrorEvent):void
		{
			//error
			trace("PreloaderProxy - Loading process failed while trying to load " + _currentURL + "\n");
			sendNotification(Notifications.instance.PRELOADER_LOADING_FAIL, NAME, RNAME);
		}
	}
}