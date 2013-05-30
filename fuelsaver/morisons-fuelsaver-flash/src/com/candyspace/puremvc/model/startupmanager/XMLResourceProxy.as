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

	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.core.Settings;
	import com.candyspace.puremvc.model.startupmanager.EntityProxy;

	import org.puremvc.as3.multicore.utilities.startupmanager.interfaces.IStartupProxy;

	/**
	 * @author Carlos D. Rodriguez
	 */
		public class XMLResourceProxy extends EntityProxy implements IStartupProxy
    {
		//--------------------------------------
		// Properties - PUBLIC
		//--------------------------------------
		
		/**
		 * Proxy name.
		 */
		public static const NAME:String = "XMLResourceProxy";
		
		protected function get name():String
		{
			return NAME;
		}
		protected function get rName():String
		{
			return RNAME;
		}
		
		
		/**
		 * Resource name.
		 */
		public static const RNAME:String = "Resource_XMLResourceProxy";
		
		//--------------------------------------
		// Properties - PRIVATE
		//--------------------------------------
		

		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function XMLResourceProxy(name:String = NAME)
        {
			super(name);
			
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
			
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener(Event.COMPLETE, onResourceLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onResourceFail);
			
			loader.load(request);
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
		// Methods - PROTECTED
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
		private function onResourceFail(event:IOErrorEvent):void
		{
			//error
			trace("XMLResourceProxy - Loading process failed (due to an IOError).\n");
			
			//notify fail error to startup manager
			sendLoadedNotification(Notifications.instance.XML_RESOURCE_LOADING_FAIL, name ,rName);
		}
		
		/**
		 * 
		 * @param	event
		 */
		private function onResourceLoaded(event:Event):void
		{
			var xml:XML = null;
				trace(event.target.data);
			
			try
			{
				xml = XML(event.target.data);
			}
			catch (e:Error) 
			{				
				//notify fail error to startup manager
				//error
				trace("XMLResourceProxy - Loading process failed (no settings in data event).\n");
				sendLoadedNotification(Notifications.instance.XML_RESOURCE_LOADING_FAIL, name , rName);
				return;
			}
            
            //--------------------------------------
            // PARSE XML
            //--------------------------------------
            
            if (!parse(xml))
            {					
				trace("XMLResourceProxy - Loading process failed (could not validate XML).\n");
				sendLoadedNotification( Notifications.instance.XML_RESOURCE_LOADING_FAIL, name ,rName);
            }
			else
			{
	            //notify startup manager
	            trace("XMLResourceProxy - loading process successfull.\n");
	            sendLoadedNotification(Notifications.instance.XML_RESOURCE_LOADED, name , rName);				        
			}
		}
        
		
		protected function parse(xml:XML):Boolean
		{
			
			
			trace("XMLResourceProxy :: parse :: xml:", xml);
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
