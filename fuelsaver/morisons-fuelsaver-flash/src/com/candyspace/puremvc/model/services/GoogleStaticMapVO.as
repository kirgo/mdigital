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

	import flash.utils.Dictionary;
	import flash.geom.Point;
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
	public class GoogleStaticMapVO
	{
		public var icons:Dictionary = new Dictionary();
		public var iconLocations:Dictionary = new Dictionary();
		
	// --------------------------------------
	// Properties
	// --------------------------------------
	
		public var latitude:Number = Number.MAX_VALUE;
		
		public var longitude:Number = Number.MAX_VALUE;
		
		//size
		/**
		 * max 640
		 */
		public var width:Number = Number.MAX_VALUE;
		
		/**
		 * max 640
		 */
		public var height:Number = Number.MAX_VALUE;
		
		public var hasSensor:Boolean;
		
		/**
		 * values range [0, 21]
		 */
		public var zoom:int;
		
		
		public var scale:int = 1;
		
		public function addIcon(url:String, hasShade:Boolean, locations:Vector.<Point> = null)
		{
			icons[url] = hasShade;
			iconLocations[url] = locations;
		}
	}
}
