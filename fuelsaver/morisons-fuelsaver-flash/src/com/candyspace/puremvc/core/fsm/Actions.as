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
package com.candyspace.puremvc.core.fsm
{
	// --------------------------------------
	// IMPORTS
	// --------------------------------------
	// Flash

	import flash.utils.getQualifiedClassName;

	// PureMVC
	// Structure
	// Custom
	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class Actions
	{
		// --------------------------------------
		// Properties - PUBLIC STATIC
		// --------------------------------------
		/**
		 * The only instance of the Actions class.
		 */
		protected static var _instance:Actions = null;

		/**
		 * The only way to access an instance of the Actions class. The singletone pattern is 
		 * used because there can be only one instance in the application.
		 */
		public static function get instance():Actions
		{
			if (!_instance)
			{
				_instance = new Actions();
			}

			return _instance;
		}

		// --------------------------------------
		// Properties - PUBLIC
		// --------------------------------------
		
		public const BEGIN_APP:String = getQualifiedClassName(this) + ".BEGIN_APP";
		
		/**
		 * @ACTIONS -> general actions go here.
		 */
		/**
		 * Action sent while the application is in the INITIAL state. It will change the state to
		 * BEGIN GAME.
		 */
		public const RESTORE_BEGIN_GAME:String = getQualifiedClassName(this) + ".RESTORE_BEGIN_GAME";
		/**
		 * Action sent while the application is in the INITIAL state. It will change the state to
		 * END GAME.
		 */
		public const RESTORE_END_GAME:String = getQualifiedClassName(this) + ".RESTORE_END_GAME";
		/**
		 * Action sent while the application is in any state. It will change the state to
		 * ERROR.
		 */
		public const FATAL_ERROR:String = getQualifiedClassName(this) + ".FATAL_ERROR";

		// --------------------------------------
		// CONSTRUCTOR
		// --------------------------------------
		public function Actions()
		{
		}
	}
}
