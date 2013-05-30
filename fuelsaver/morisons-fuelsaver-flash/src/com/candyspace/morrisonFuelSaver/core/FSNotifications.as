// // // //////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // // ////////////////////////////////////////////////////////////////////////
package com.candyspace.morrisonFuelSaver.core
{

	import flash.utils.getQualifiedClassName;
	import com.candyspace.puremvc.core.Notifications;
	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------


	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class FSNotifications extends Notifications
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		protected static var _instance:FSNotifications = null;

		public static function get instance():FSNotifications
		{
			if (!_instance)
			{
				_instance = new FSNotifications();
			}

			return _instance;
		}
		
		public const ADD_CALCULATOR_CATEGORY:String = getQualifiedClassName(this) + ".ADD_CALCULATOR_CATEGORY";
		
		public const UPDATE_CALCULATOR_CATEGORY_VALUE:String = getQualifiedClassName(this) + ".UPDATE_CALCULATOR_CATEGORY_VALUE";
		
		public const RESET_APPLICATION:String = getQualifiedClassName(this) + ".RESET_APPLICATION";
	}
}
