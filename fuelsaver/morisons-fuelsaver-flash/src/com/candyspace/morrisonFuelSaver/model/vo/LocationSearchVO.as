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
	public class LocationSearchVO
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
		
		public var postcodeQuerry:String = "";
		
		public var results:Vector.<StoreVO>;


		// --------------------------------------
		// Methods : Public
		// --------------------------------------
		
		public function LocationSearchVO()
		{
			results = new Vector.<StoreVO>();
		}

		public function toString():String
		{
			var str:String = "\nPOSTCODE: =========> " + postcodeQuerry;

		    for (var i:int = 0; i < results.length; i++) {
		    	str += "\n" + results[i];
		    }
			return str;
		}
	}
}
