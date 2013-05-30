// //////////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// //////////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.model.startupmanager
{

	import flash.display.LoaderInfo;
	import com.candyspace.puremvc.core.Settings;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.model.startupmanager.EntityProxy;

	import org.puremvc.as3.multicore.utilities.startupmanager.interfaces.IStartupProxy;

	/**
	 * @author Carlos D. Rodriguez
	 */
		
	//--------------------------------------
    // IMPORTS
    //--------------------------------------
	
	// flash classes
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
    import flash.system.Security;
    import flash.system.SecurityDomain;
    import flash.text.Font;
    import flash.utils.Dictionary;
	
	// pmvc classes

	
	// structure classes

    
    //--------------------------------------
    // CLASS
    //--------------------------------------
	
    /**
    * This class holds the loading logic. It does not, however, load the preloader, just 
	* the other assets.
	* 
	* In order to get the total bytes count of all the assets, it executes a fake load,
	* for all the assets, until the first ProgressEvent.PROGRESS instance is received,
	* for each asset. It then stops the fake load. After all the fake loads are completed
	* it starts the real load for all the assets.
	* 
	* The fake load enables the percent that is shown to the user to be accurate. However
	* the fake load does not increase the load time, because the loaded bits of the assets
	* are kept in the cache, so they are loaded only once.
    */
    
	public class SkinProxy extends EntityProxy implements IStartupProxy
    {
		//--------------------------------------
		// Properties - PUBLIC
		//--------------------------------------
		
		/**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static const NAME:String = "SkinProxy";
		
		/**
		 * Returns the name with which this resource is mapped in the StartupResourceProxy.
		 */
		public static const RNAME:String = "Resource_SkinProxy";
        
		//--------------------------------------
		// Properties - PRIVATE
		//--------------------------------------
		/**
		 * skin swf file url
		 */
		 private var _skinURL:String;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function SkinProxy()
        {
			super(NAME);
		}
		
		//--------------------------------------
		// Methods - PUBLIC
		//--------------------------------------
		
		/**
		 * Start loading skin
		 */
		public function load():void
		{
			//debug
			trace("SkinProxy - Loading process started...");
			
			_skinURL = Settings.instance.skinURL;
			
			if (_skinURL)
			{
				var loader:Loader = new Loader();
				var request:URLRequest = new URLRequest(_skinURL);

				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onPreloaderLoaded);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onBytesLoadProgress);
				

				trace("PreloaderProxy - Start loading from URL: " + request.url);

				loader.load(request);
			}
            
            
            
//			urlLoader.addEventListener(ProgressEvent.PROGRESS, onBytesLoadProgress);
//            urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onBytesLoadError);
//            urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onBytesLoadError);
//            urlLoader.addEventListener(Event.COMPLETE, onBytesLoadComplete);

			
			// debug
			trace("SkinProxy - Loading process started.");
        }
		
		//--------------------------------------
		// Methods - PRIVATE
		//--------------------------------------
		
        
		
        //--------------------------------------
		// Methods - HANDLERS
		//--------------------------------------
		        
		private function onBytesLoadProgress(event:ProgressEvent):void 
		{
			var progress:Number = event.bytesLoaded / event.bytesTotal;
            
            if (progress > 1)
            {
                progress == 1;
            }
            else if (progress < 0)
            {
                progress = 0;
            }
            
			facade.sendNotification(Notifications.instance.PRELOADER_PROGRESS, progress);
		}		
		
		private function onPreloaderLoaded(event:Event):void
		{
			if (event)
			{
				data = LoaderInfo(event.target).content;
			}
			
			trace("PreloaderProxy - Loading process finished.\n", data);
			sendNotification(Notifications.instance.SKIN_LOADED, NAME, RNAME);
		}
		
		private function onLoadError(event:IOErrorEvent):void 
		{
			// error
			trace("SkinProxy::onLoadError - error loading asset: ." + _skinURL);						
			sendLoadedNotification(Notifications.instance.SKIN_LOADING_FAIL, NAME , RNAME);
		}
	}
}