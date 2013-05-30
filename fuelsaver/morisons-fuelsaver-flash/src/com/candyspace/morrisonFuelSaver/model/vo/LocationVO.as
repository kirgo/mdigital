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
package com.candyspace.morrisonFuelSaver.model.vo
{
	/**
	 * @author Carlos D. Rodriguez
	 */

	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class LocationVO
	{
		// --------------------------------------
		// Properties
		// --------------------------------------		
		
		public var postcode:String = "";
		
		public var address:String = "";
		
		public var city:String = "";
		
		public var longitude:String = "";
		
		public var latitude:String = "";

		// --------------------------------------
		// Methods : Public
		// --------------------------------------

		public function toString():String
		{
			return "\nLOCATION: ========= \n  postcode: " + postcode + "\n  address: " + address + "\n  city: " + city + "\n  longitude: " + longitude + "\n  latitude: " + latitude;
		}
	}
}
