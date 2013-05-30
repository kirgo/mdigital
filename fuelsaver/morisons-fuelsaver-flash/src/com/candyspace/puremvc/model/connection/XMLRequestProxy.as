// //////////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // ////////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.model.connection
{

	import flash.system.LoaderContext;
	import flash.events.HTTPStatusEvent;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.model.startupmanager.EntityProxy;

	import org.puremvc.as3.multicore.utilities.startupmanager.interfaces.IStartupProxy;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	/**
	 * @author Carlos D. Rodriguez
	 */
		public class XMLRequestProxy extends Proxy implements IProxy
    {
		//--------------------------------------
		// Properties - PUBLIC
		//--------------------------------------
		
		/**
		 * Proxy name.
		 */
		public static const NAME:String = "XMLRequestProxy";
		
		protected function get name():String
		{
			return NAME;
		}

		//--------------------------------------
		// Properties - PRIVATE
		//--------------------------------------
		

		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function XMLRequestProxy(name:String = NAME, data:Object = null)
        {
			super(name, data);
			
			//settings = Settings.getInstance();
		}
		
		//--------------------------------------
		// Methods - INIT
		//--------------------------------------

		
		//--------------------------------------
		// Methods - PUBLIC
		//--------------------------------------
		
		/**
		 * 
		 */
		public function load():void
		{
			
			
			
            var xmlResourceURL:String = getUrlString();
            
            if (!xmlResourceURL || xmlResourceURL == "")
            {
				//error
               trace ("SettingsProxy - Could not find SettingsProxy property named: 'xmlResourcesURLs'."
							 + " The settings URL will not be valid.");
            }
			
		    trace("SettingsProxy - Start loading settings from URL:\n" + xmlResourceURL);
			
			// create the URLRequest variable needed to load the settings
			var request:URLRequest = new URLRequest(xmlResourceURL);
			
			// create the URLVariables needed by the back-end to generate the correct
			// settings
			request.method = getMethod();
			
			if(getVariables())
			{
				request.data = getVariables() ;
			}
			
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener(Event.COMPLETE, onResourceLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onResourceFail);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpResponseStatus);
			
			loader.load(request);
		}

		protected function onHttpResponseStatus(event:HTTPStatusEvent):void
		{
		}
		
		/**
		 * 
		 * @param	identifier
		 * @return
		 */
//		private function getVar(identifier:String):*
//		{
//		    return Settings.getVar(identifier);
//		}
        
		//--------------------------------------
		// Methods - PROTECTED to be overrided
		//--------------------------------------
		
		protected function getUrlString():String
		{
			return null;
		}
		
		/**
		 * use URLRequestMethod const for allowed values
		 */
		protected function getMethod():String
		{
			
			return URLRequestMethod.GET;
		}
		
		protected function getVariables():URLVariables
		{
			return null;
		}
		
		//--------------------------------------
		// Methods - HANDLERS
		//--------------------------------------
		
		/**
		 * 
		 * @param	event
		 */
		protected function onResourceFail(event:IOErrorEvent):void
		{
			// fail procedure
			trace("");
		}
		
		/**
		 * 
		 * @param	event
		 */
		protected function onResourceLoaded(event:Event):void
		{
			var xml:XML = null;
			
			try
			{
				xml = XML(event.target.data);
			}
			catch (e:Error) 
			{				
				//error
				trace("XMLRequestProxy - Loading process failed (no settings in data event).\n");
				// fail procedure
				return;
			}
            
            //--------------------------------------
            // PARSE XML
            //--------------------------------------
            
            if (!parse(xml))
            {					
				trace("XMLRequestProxy - Loading process failed (could not validate XML).\n");
				//sendLoadedNotification( Notifications.instance.XML_RESOURCE_LOADING_FAIL, name ,rName);
				
            }
			else
			{
	            //notify startup manager
	            trace("XMLRequestProxy - loading process successfull.\n");
	            //sendLoadedNotification(Notifications.instance.XML_RESOURCE_LOADED, name , rName);
	            sendLoadedNotification();		        
			}
		}

		protected function sendLoadedNotification():void
		{
			
		}
		
        
		
		protected function parse(xml:XML):Boolean
		{
			
			
			trace("XMLRequestProxy :: parse :: xml:", xml);
			var list:XMLList = xml.children();
			//parse all settings
			for(var i:int = 0; i < list.length(); i++)
			{				
				parseDataItem(list[i]);	
			}
			return Boolean(xml);
			
		}
		
		protected function parseDataItem(xml:XML):Boolean
		{
			return false;
		}
		
	}
}
