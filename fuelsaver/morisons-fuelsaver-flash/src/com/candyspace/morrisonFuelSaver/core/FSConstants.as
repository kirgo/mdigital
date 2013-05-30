// // // //////////////////////////////////////////////////////////////////////////
//
// CANDYMEDIA
// Copyright 2012 CANDYMEDIA
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // // ////////////////////////////////////////////////////////////////////////
package com.candyspace.morrisonFuelSaver.core
{

	import flash.text.StyleSheet;
	import flash.geom.Point;
	import com.candyspace.puremvc.core.display.ScreenSize;
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	import flash.utils.getQualifiedClassName;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class FSConstants
	{
		// --------------------------------------
		// Properties
		// --------------------------------------


		/**
		 * Orientation constants
		 * deprecated :: using StageAspectRatio constant value instead
		 */		
		public const ORIENTATION_PORTRAIT:String = "portrait";
		public const ORIENTATION_LANDSCAPE:String = "landscape";
		
		/**
		 * add values from the ScreenSize class constants
		 * rotation will be no allowed in the screen sizes included in the array.
		 * 
		 * possible values [ScreenSize.BIG, ScreenSize.SMALL];
		 */
		public var noRotatingDeviceSizes:Array = [];
		
		// Persistance
		public const PERSISTANCE_FILE_HOME : String = "home.store";
		public const PERSISTANCE_FILE_LAST_WATCHED : String = "lastWatched.store";
		public const PERSISTENCE_FILE_PIN : String = "pin.store";
		
		/// WEB APPLICATIONS ONLY

		
		public var xmlResourcesURLs:Vector.<String> = new Vector.<String>();
		
		public var parameters:Object = {};
		
//		public function set parameters(obj:Object):void
//		{
//			_parameters = obj;
//		}
//		public function get parameters():Object
//		{
//			return _parameters;
//		}


		public static var preloaderURL:String;
		
		public static var configResouceURL:String;
		
		public static var skinURL:String = "";
		
		// PARAMETERS NAMES
		public static var BASE_URL_PARAMETER_NAME:String = "baseURL";
		public static var BASE_URL_PARAMETER_DEFAULT_VALUE:String = "http://staging.csmobi.cc";
		
		public static var NO_MENU_PARAMETER_NAME:String = "noMenu";
		public static var NO_MENU_PARAMETER_DEFAULT_VALUE:String = "false";
		
		public static var CLOSE_LINK_PARAMETER_NAME:String = "closeLink";
		public static var CLOSE_LINK_PARAMETER_DEFAULT_VALUE:String = "true";
		
		
		/// END POINTS
		
		public static var GOOGLE_MAP_ICON_URL:String = "http://9e8c5f3f6d207d69fa78-5e22e9b12f943cd58ffcd76fee4cede4.r56.cf3.rackcdn.com/MMiconNew.png";
		
		public static var GOOGLE_EXTERNAL_MAP_URL:String = "http://maps.google.com/maps?z=12&t=m&q=loc:";
		
		public static var TERMS_CONDITIONS_URL:String = "http://www.morrisons.co.uk/Terms-and-conditions/";
		
		public static var PRIVACY_POLICY_URL:String = "http://www.morrisons.co.uk/Privacy-Policy/";
		
		public static var FINDOUT_MORE_URL:String = "http://www.morrisonsfuelsaver.co.uk";
		
		public static var FACEBOOK_URL:String = "http://www.facebook.com/Morrisons";
		
		public static var TWITTER_URL:String = "http://twitter.com/#!/MorrisonsOffers/";
		
		public static var FACEBOOK_SHARE_CALL_NAME:String = "fbs_click";
		
		public static var TWITTER_SHARE_URL:String = "http://twitter.com/share?url=http://www.morrisonsfuelsaver.co.uk&text=Try Morrisons new fuel savings calculator and see how much you could save on your next Morrisons fuel bill.";

		public static var CLOSE_PARENT_WINDOW_CALL_NAME:String = "mfs.hideOverlay";
		
		public static var SHARING_EMBED_CODE:String = "<iframe width='520' height='780' src='{baseUrl}/fuelsaver/flash/?no-menu=true' frameborder='0' allowfullscreen></iframe>";
		
		
		// VIEWS SETTINGS
		
		public static var VIEWS_MENU_OFFSET:Point = new Point(24, 122);		
		
		public static var SPLASH_WINDOW_DELAY:Number = 3500;
		
		public static function get linkStyle():StyleSheet
		{
			var linkObj:Object = new Object();
       		linkObj.fontWeight = "bold";
        	linkObj.color = "#8DC73F";
			
			var linkStyle: StyleSheet = new StyleSheet();
			linkStyle.setStyle("a", linkObj);
			
			return linkStyle;
		}

		
	}
}
