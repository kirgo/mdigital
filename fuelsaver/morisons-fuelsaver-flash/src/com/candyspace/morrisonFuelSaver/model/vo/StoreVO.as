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
	public class StoreVO
	{
		/*
				<store>
				<name>Peckham</name>
				<street>Aylesham Centre Rye Lane</street>
				<city/>
				<postcode>SE15 5EW</postcode>
				<tel>020 7732 3518</tel>
				<long>51.4727401733398</long>
				<lat>-0.0686599984765053</lat>
				<opening_times>
				<monday>0800-2100</monday>
				<tuesday>0800-2100</tuesday>
				<wednesday>0800-2100</wednesday>
				<thursday>0800-2200</thursday>
				<friday>0800-2200</friday>
				<saturday>0800-2000</saturday>
				<sunday>0900-1800</sunday>
				</opening_times>
				</store>
		 */
		 
		// --------------------------------------
		// Properties
		// --------------------------------------		
		
		public var name:String = "";
		
		public var street:String = "";
		
		public var city:String = "";
		
		public var postcode:String = "";
		
		public var tel:String = "";
		
		
		public var lon:String = "";
		
		public var lat:String = "";

		
		public var openingTimes:Vector.<String> = new Vector.<String>();


		// --------------------------------------
		// Methods : Public
		// --------------------------------------

		public function toString():String
		{
			var store:String = "\nSTORE: ========= \n  name: " + name + "\n  street: " + street + "\n  city: " + city + "\n  postcode: " + postcode + "\n  tel: " + tel + "\n  long: " + lon + "\n  lat: " + lat;
		    for (var i:int = 0; i < openingTimes.length; i++) {
		    	store += "\n" + openingTimes[i];
		    }
			return store;
		}
	}
}
