// // // //////////////////////////////////////////////////////////////////////////
//
// CANDYMEDIA
// Copyright 2012 CANDYMEDIA
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // //////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.core
{
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
	public class Settings
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		protected static var _instance:Settings = null;

		public static function get instance():Settings
		{
			if (!_instance)
			{
				_instance = new Settings();
			}

			return _instance;
		}

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

		
		public var preloaderURL:String = "";
		
		public var xmlResourcesURLs:Vector.<String> = new Vector.<String>();
		
		public var configResouceURL:String;
		
		public var skinURL:String = "";
		
		public var parameters:Object = {};
		
//		public function set parameters(obj:Object):void
//		{
//			_parameters = obj;
//		}
//		public function get parameters():Object
//		{
//			return _parameters;
//		}

		
	}
}
