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
package com.candyspace.puremvc.model.services
{

	import flash.display.DisplayObject;
	import flash.events.AsyncErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.system.SecurityDomain;
	import flash.system.Security;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import avmplus.getQualifiedClassName;
	import flash.display.LoaderInfo;
	import com.candyspace.puremvc.core.Notifications;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import org.puremvc.as3.multicore.interfaces.IProxy;

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
	public class GoogleStaticMapProxy extends Proxy implements IProxy
	{
		
		/*
		 
		  http://maps.googleapis.com/maps/api/staticmap?size=300,300&sensor=false&scale=1&zoom=16&markers=icon:http://9e8c5f3f6d207d69fa78-5e22e9b12f943cd58ffcd76fee4cede4.r56.cf3.rackcdn.com/MMiconNew.png|shadow:false|51.47274017,-0.068659998
		  BASE_URL + sizeString + &sensor=false&scale=1&zoom=16&markers=icon:http://9e8c5f3f6d207d69fa78-5e22e9b12f943cd58ffcd76fee4cede4.r56.cf3.rackcdn.com/MMiconNew.png|shadow:false|51.47274017,-0.068659998
		 
		 */
		// --------------------------------------
		// Properties - PROTECTED
		// --------------------------------------
		
		protected static const BASE_URL:String = "http://maps.googleapis.com/maps/api/staticmap?";
		
		protected static const API_KEY:String = "AIzaSyDJnxJsqgD4nUlDsHf_tswi7PK_qWkewgw";
		
		// url string escape characters
		
		protected static const PIPE:String = "%7C";
		
		protected static const AMP:String = "&";
		
		// google api parameters
		
		protected var _height:Number;
		
		protected var _width:Number;
		
		protected var _latitude:Number;		
		
		protected var _longitude:Number;
		
		protected var _hasSensor:Boolean;
		
		protected var _hasMarkerShadow:Boolean;

		protected var _icons:Dictionary = new Dictionary();
		
		protected var _iconLocations:Dictionary = new Dictionary();

		
		// --------------------------------------
		// Properties - PUBLIC
		// --------------------------------------		
		public static var INIT_MAP:String = NAME + ".INIT_MAP";
		public static var LOAD_ICON_CENTERED_MAP:String = NAME + ".LOAD_ICON_CENTERED_MAP";
		
		public static function get NAME():String
		{
			return getQualifiedClassName(GoogleStaticMapProxy);
		}
		
		public function set width(value:Number):void
		{
			_width = value;
		}
		
		public function set height(value:Number):void
		{
			_height = value;
		}
		
		public function set latitude(value:Number):void
		{
			_latitude = value;
		}
		
		public function set longitude(value:Number):void
		{
			_longitude = value;
		}
		
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function GoogleStaticMapProxy(proxyName:String = null, data:Object = null)
		{
			super(NAME, data);
		}
		// --------------------------------------
		// Methods - Init
		// --------------------------------------

		// TODO other value might need to be initialized when implementing other map types
		public function init(vo:GoogleStaticMapVO):void
		{
			_width = vo.width;
			_height = vo.height;
			_hasSensor = vo.hasSensor;

			if ( hasChildren(vo.icons))
			{
				_icons = vo.icons;

				if ( hasChildren(vo.iconLocations))
				{
					_iconLocations = vo.iconLocations;
				}
			}
		}
		
		// --------------------------------------
		// Methods - PUBLIC
		// --------------------------------------		
		// before calling this method the calls has to be initialized with the init method
		// and icon has to be added to the class
		public function getIconCenteredMap(latitude:Number, longitude:Number):void
		{
			var url:String = getMinRequiredUrl(_width, _height);

			url += getCenteredIconMapString(latitude, longitude);

			loadMap(url);
		}

		public function loadMap(url:String):void
		{
			trace("GoogleStaticMapProxy - Loading process started.\n");
			trace(url);
			trace("=====================================");
			Security.loadPolicyFile("http://maps.googleapis.com/crossdomain.xml");
			Security.allowDomain('http://maps.googleapis.com');
			Security.allowInsecureDomain('http://maps.googleapis.com');
			
			var context:LoaderContext = new LoaderContext(); 
			context.checkPolicyFile = true; 
			//context.securityDomain = SecurityDomain.currentDomain;
			context.applicationDomain = ApplicationDomain.currentDomain;
			

			

			if (url)
			{
				var loader:Loader = new Loader();
				var request:URLRequest = new URLRequest(url);

				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onImageFailed);
				
				//loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onImageSecurityError);
				//loader.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onImageSecurityError);
   			 	//loader.addEventListener(IOErrorEvent.IO_ERROR, onImageSecurityError);

				trace("PreloaderProxy - Start loading from URL: " + request.url);

				loader.load(request, context);
			}
			else
			{
			}
		}

		private function onImageSecurityError(event:SecurityErrorEvent):void
		{
			trace("kdkjlsdjf", event.type);
			trace("dd");
		}
		// --------------------------------------
		// Methods - PROTECTED 
		// --------------------------------------		
		
		/**
		 *  &scale=1
		 *  &zoom=16
		 *  &markers=icon:http://9e8c5f3f6d207d69fa78-5e22e9b12f943cd58ffcd76fee4cede4.r56.cf3.rackcdn.com/MMiconNew.png|shadow:false|51.47274017,-0.068659998
		 */
		protected function getMinRequiredUrl(width:Number, height:Number):String
		{
			var isLocationSet:Boolean = false;
			
			var url:String = BASE_URL + getSizeString(width, height) + getSensorString(false);
			
			return url;
		}
		
		/**
		 * returned string format: &size=300x300 (widht,height)
		 */
		protected function getSizeString(width:Number, height:Number):String
		{
			return AMP + "size=" + width + "x" + height;
		}
		
		/**
		 * returned string format: &sensor=false (or true)
		 */
		protected function getSensorString(hasSensor:Boolean):String
		{
			return AMP + "sensor=" + hasSensor;
		}
		
		// --------------------------------------
		// Methods - PROTECTED :: MARKERS
		// --------------------------------------
		// TODO: only the icon markers have been implemented. coloured labeled markers should be implemented
		
		protected function getAllMarkersString():String
		{
			var url:String = "";
			var locations:Vector.<Point>;
			
			for (var iconUrl:String in _icons) 
			{
				locations = _iconLocations[iconUrl];
				
				url += getIconMarkerString(iconUrl, locations);
			}
			
			return null;
		}
		
		/**
		 * returned string format: 
		 * &markers=icon: + <icon url> + |shadow:false|51.47274017,-0.068659998
		 * 
		 * x > latitude
		 * y > longitude
		 */
		protected function getIconMarkerString(iconUrl:String, locations:Vector.<Point>, hasShadow:Boolean = false ):String
		{
			
			var isLocationSet:Boolean;
			
			var url:String = AMP + "markers=icon:" + iconUrl + PIPE + "shadow:" + hasShadow;
			
			var location:Point;
			for (var i:int = 0; i < locations.length; i++) 
			{
				isLocationSet = true;
				
				location = locations[i];
				
				// x > longitude -- y > latitude
				url += PIPE + location.y + "," + location.x;
			}
			
			
			return  url;
		}
		
		protected function getCenteredIconMapString(latitude:Number, longitude:Number):String
		{
			var locations:Vector.<Point> = new Vector.<Point>();
			locations.push(new Point(latitude, longitude));
			
			var iconUrl:String;
			
			// gets the first marker
			for (var url:String in _icons) 
			{
				iconUrl = url;
				break;
			}
			
			return getIconMarkerString(iconUrl, locations);
		}
		
		// --------------------------------------
		// Methods - PRIVATE
		// --------------------------------------
		
		private function hasChildren(dict:Dictionary):Boolean
		{
			var hasChildren:Boolean = false;
			for(var key:* in dict)
			{
				hasChildren = true;
			}
			return hasChildren;
		}
		
		
		// --------------------------------------
		// Event handlers - Overriden
		// --------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
		}
		
		// --------------------------------------
		// Event handlers
		// --------------------------------------
		
		private function onImageFailed(event : IOErrorEvent) : void 
		{
			//error
			trace("GoogleStaticMapProxy - Loading process failed while trying to load static map \n");
			sendNotification(Notifications.instance.GOOGLE_STATIC_MAP_FAILED);
		}
		private function onImageLoaded(event : Event) : void 
		{
			
			trace("url", LoaderInfo(event.target).url);
			
			var loaderInfo : LoaderInfo = event.target as LoaderInfo;
			var displayObject : DisplayObject = null;
			
			try
			{ 
				displayObject = loaderInfo.loader.content as DisplayObject;
			}catch( e : Error )
			{
				displayObject = loaderInfo.loader as DisplayObject;
			}
//			if (event)
//			{
//				data = LoaderInfo(event.target).content;
//			}

			
			data = displayObject;
			
			trace(data);
			/**
			try {
				addChild(info.target.content);
			} catch(е) {
				addChild(info.target.loader);
				error_txt.appendText(e);
			}
			 */
			
			trace("GoogleStaticMapProxy - Loading process finished.\n", data);
			sendNotification(Notifications.instance.GOOGLE_STATIC_MAP_LOADED, data);
		}
		
	}
}
