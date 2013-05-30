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
	public class CalculatorCategoryVO
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		public var name:String = "";
		
		public var maxLimit:String = "";
		
		public var value:Number = 0;


		// --------------------------------------
		// Methods : Public
		// --------------------------------------

		public function toString():String
		{
			return "\n Calculator Category: ========= \n  name: " + name + "\n  maxLimit: " + maxLimit;
		}
	}
}
