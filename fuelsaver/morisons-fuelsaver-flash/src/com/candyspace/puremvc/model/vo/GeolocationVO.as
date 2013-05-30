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
package com.candyspace.puremvc.model.vo
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
	public class GeolocationVO
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		// The latitude in degrees.
		public var latitude:Number;
		
		// The longitude in degrees.
		public var longitude:Number;
		
		// The altitude in meters.
		public var altitude:Number;
		
		// The horizontal accuracy in meters.
		public var hAccuracy:Number;
		
		// The vertical accuracy in meters.
		public var vAccuracy:Number;
		
		// The speed in meters/second.
		public var speed:Number;
		
		// The direction of movement (with respect to true north) in integer degrees.
		public var heading:Number;
		
		// The number of milliseconds at the time of the event since the runtime was initialized.
		public var timestamp:Number;

	
	}
}
