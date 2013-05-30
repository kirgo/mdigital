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

	import com.candyspace.puremvc.core.Settings;

	import flash.geom.Point;
	import flash.text.StyleSheet;
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------


	// --------------------------------------
	// CLASS -- DEPRECATED
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class FSSettings extends Settings
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		protected static var _instance:FSSettings = null;

		public static function get instance():FSSettings
		{
			if (!_instance)
			{
				_instance = new FSSettings();
			}

			return _instance;
		}
		
		
		// CONFIG FILE VARIABLES
		
		//public var TANK_SIZE:Number;
		
		//public var SAVING:Number;
		
		//public var uuid:String;
		
		// PARAMETERS VARIABLES
		
//		public function get baseURL():String
//		{
//			//var baseUrl:String = "http://qa.csmobi.cc";
//			var baseUrl:String = "http://staging.csmobi.cc";
//			if(parameters && parameters.baseURL)
//			{
//				baseUrl = parameters.baseURL;
//			}
//			return baseUrl;
//		}
		
//		public function get enabledMenu():Boolean
//		{
//			var isMenuEnable:Boolean = true;
//			if(parameters && parameters.noMenu)
//			{
//				if(parameters.noMenu == "true")
//				{
//					isMenuEnable = false;
//				}
//				else
//				{
//					isMenuEnable = true;
//				}
//			}
//			trace(isMenuEnable, parameters.noMenu);
//			return isMenuEnable;
//		}
		
//		public function get closeLink():Boolean
//		{
//			var closeLink:Boolean = false;
//			if(parameters && parameters.closeLink)
//			{
//				if(parameters.closeLink == "true")
//				{
//					closeLink = true;
//				}
//				else
//				{
//					closeLink = false;
//				}
//			}
//			trace(closeLink, parameters.closeLink);
//			return closeLink;
//		}
		
		
		/// END POINTS
		
		//public var GOOGLE_MAP_ICON_URL:String = "http://9e8c5f3f6d207d69fa78-5e22e9b12f943cd58ffcd76fee4cede4.r56.cf3.rackcdn.com/MMiconNew.png";
		
		//public var GOOGLE_EXTERNAL_MAP_URL:String = "http://maps.google.com/maps?z=12&t=m&q=loc:{lon},{lat}";
		
//		public function getGoogleExternalMapUrl(lon:String, lat:String):String
//		{
//			return "http://maps.google.com/maps?z=12&t=m&q=loc:" +  lon + "," + lat;
//		}
		
		//transfered
		//public var UUID_ENDPOINT:String;
		
//		public var SEARCH_REQUEST_ENDPOINT:String;
//		public function getIdentifiedSearchEndPoint():String
//		{
//			return insertUUID(SEARCH_REQUEST_ENDPOINT);
//		}
//		
//		public var CALCULATOR_ENDPOINT:String;
//		public function getIdentifiedCalculatorEndPoint():String
//		{
//			return insertUUID(CALCULATOR_ENDPOINT);
//		}
//		
//		public var COLLECT_REQUEST_ENDPOINT:String;
//		public function getIdentifiedCollectEndPoint():String
//		{
//			return insertUUID(COLLECT_REQUEST_ENDPOINT);
//		}
//		
//		public var CALCULATOR_SLIDER_TRACKING_ENDPOINT:String;
//		public function getIdentifiedTrackingEndPoint():String
//		{
//			return insertUUID(CALCULATOR_SLIDER_TRACKING_ENDPOINT);
//		}

//		public function get SHARING_EMBED_CODE():String
//		{
//			return "<iframe width='520' height='780' src='" + baseURL + "/fuelsaver/flash/?no-menu=true' frameborder='0' allowfullscreen></iframe>"
//		}
		
		//public var TERMS_CONDITIONS_URL:String = "http://www.morrisons.co.uk/Terms-and-conditions/";
		
		//public var PRIVACY_POLICY_URL:String = "http://www.morrisons.co.uk/Privacy-Policy/";
		
		//public var FINDOUT_MORE_URL:String = "http://www.morrisonsfuelsaver.co.uk";
		
		//public var FACEBOOK_URL:String = "http://www.facebook.com/Morrisons";
		
		//public var TWITTER_URL:String = "http://twitter.com/#!/MorrisonsOffers/";
		
		//public var FACEBOOK_SHARE_CALL_NAME:String = "fbs_click";
		
		//public var TWITTER_SHARE_URL:String = "http://twitter.com/share?url=http://www.morrisonsfuelsaver.co.uk&text=Try Morrisons new fuel savings calculator and see how much you could save on your next Morrisons fuel bill.";


		public var CLOSE_PARENT_WINDOW_CALL_NAME:String = "exit_click";

		//public var CLOSE_PARENT_WINDOW_CALL_NAME:String = "mfs.hideOverlay";

		
		
		
		// VIEWS SETTINGS
		
		//public var VIEWS_MENU_OFFSET:Point = new Point(24, 122);
		/**
		public function get linkStyle():StyleSheet
		{
			var linkObj:Object = new Object();
       		linkObj.fontWeight = "bold";
        	linkObj.color = "#8DC73F";
			
			var linkStyle: StyleSheet = new StyleSheet();
			linkStyle.setStyle("a", linkObj);
			
			return linkStyle;
		}
		 * 
		 */
		
		//public var SPLASH_WINDOW_DELAY:Number = 3500;
		
		
		// --------------------------------------
		// Methods - Private
		// --------------------------------------
		
//		private function insertUUID(url:String):String
//		{
//			var urlParts:Array = url.split('{uuid}');
//			return urlParts[0] + uuid + urlParts[1];
//		}

	}
}