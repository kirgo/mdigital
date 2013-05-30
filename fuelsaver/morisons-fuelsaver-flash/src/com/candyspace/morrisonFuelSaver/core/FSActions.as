// // // //////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // //////////////////////////////////////////////////////////////////////////
package com.candyspace.morrisonFuelSaver.core 
{
	import com.candyspace.puremvc.core.fsm.Actions;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class FSActions extends Actions 
	{
		// --------------------------------------
		// Properties - PUBLIC STATIC
		// --------------------------------------
		
		/**
		 * The only instance of the Actions class.
		 */
		protected static var _instance : FSActions = null;

		/**
		 * The only way to access an instance of the Actions class. The singletone pattern is 
		 * used because there can be only one instance in the application.
		 */
		public static function get instance() : FSActions 
		{
			if (!_instance) {
				_instance = new FSActions();
			}

			return _instance;
		}

		// --------------------------------------
		// Properties - PUBLIC
		// --------------------------------------
		
		public const RELOAD_APP : String = getQualifiedClassName(this) + ".RELOAD_APP";
		
		public const SELECT_MENU_CALCULATOR : String = getQualifiedClassName(this) + ".SELECT_MENU_CALCULATOR";
		
		public const SELECT_MENU_REGISTRATION : String = getQualifiedClassName(this) + ".SELECT_MENU_SIGNUP";
		
		public const SELECT_MENU_LOCATION : String = getQualifiedClassName(this) + ".SELECT_MENU_LOCATION";
		
		public const SELECT_MENU_SHARING : String = getQualifiedClassName(this) + ".SELECT_MENU_WIDGET";
		
		public const OPEN_CALCULATOR : String = getQualifiedClassName(this) + ".OPEN_CALCULATOR";
		
		public const OPEN_REGISTRATION : String = getQualifiedClassName(this) + ".OPEN_REGISTRATION";
		
		public const OPEN_LOCATION : String = getQualifiedClassName(this) + ".OPEN_LOCATION";
		
		public const OPEN_SHARING : String = getQualifiedClassName(this) + ".OPEN_SHARING";
		
		public const CALCULATE : String = getQualifiedClassName(this) + ".CALCULATE";
		
		public const CALCULATION_RECEIVED : String = getQualifiedClassName(this) + ".CALCULATION_RECEIVED";
		
		public const SUBMIT_REGISTRATION : String = getQualifiedClassName(this) + ".SUBMIT_REGISTRATION";
		
		public const REGISTRATION_CONFIRMATION_RECEIVED : String = getQualifiedClassName(this) + ".REGISTRATION_CONFIRMATION_RECEIVED";
		
		public const SHOW_TC : String = getQualifiedClassName(this) + ".SHOW_TC";

		
		public const RETRIEVE_MAP : String = getQualifiedClassName(this) + ".RETRIEVE_MAP";
		
		public const MAP_RECEIVED : String = getQualifiedClassName(this) + ".MAP_RECEIVED";
		
		public const STORES_RECEIVED : String = getQualifiedClassName(this) + ".STORES_RECEIVED";
		
		// -------
		
		public const FIND_NEAREST : String = getQualifiedClassName(this) + ".FIND_NEAREST";
		
		public const SEARCH_AGAIN : String = getQualifiedClassName(this) + ".SEARCH_AGAIN";
		
		public const SHOW_NEXT_LOCATION : String = getQualifiedClassName(this) + ".SHOW_NEXT_LOCATION";
		
		public const SHOW_PREV_LOCATION : String = getQualifiedClassName(this) + ".SHOW_PREV_LOCATION";
		
		// ----------
		
		public const OPEN_FACEBOOK : String = getQualifiedClassName(this) + ".OPEN_FACEBOOK";
		
		public const OPEN_TWITTER : String = getQualifiedClassName(this) + ".OPEN_TWITTER";
		
		public const EMBED_CODE : String = getQualifiedClassName(this) + ".EMBED_CODE";
		
		public const WAIT_FOR_NEXT_ACTION : String = getQualifiedClassName(this) + ".WAIT_FOR_NEXT_ACTION";

	}
}
