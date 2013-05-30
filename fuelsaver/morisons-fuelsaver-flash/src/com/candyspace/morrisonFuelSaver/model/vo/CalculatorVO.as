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
	import com.candyspace.puremvc.view.IViewInitVO;
	import flash.utils.Dictionary;
	/**
	 * @author Carlos D. Rodriguez
	 */

	// --------------------------------------
	// CLASS
	// --------------------------------------
	
	/**
	 * Class Comment
	 */
	public class CalculatorVO implements IViewInitVO
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		protected var props:Dictionary = new Dictionary();
		
		public var order:Vector.<String> = new Vector.<String>();
		
		public function get dictionary():Dictionary
		{
			return props;
		}
		
		public function get propertyNameOrder():Vector.<String>
		{
			return order;
		}

		// --------------------------------------
		// Methods : Public
		// --------------------------------------
		
		public function addProperty(categoryVO:CalculatorCategoryVO):void
		{
			props[categoryVO.name] = categoryVO;
			order.push(categoryVO.name);
			
		}
		public function getPropertyVO(name:String):CalculatorCategoryVO
		{
			return props[name];
		}
		
		public function setPropertyValue(name:String, value:Number):void
		{
			if(props[name])
			{
				(props[name] as CalculatorCategoryVO).value = value;
			}
			else
			{
				throw new Error("CalculatorVO :: Property is NOT defined ");
			}
		}
		
		public function getPropertyValue(name:String):Number
		{
			if(!props[name])
			{
				throw new Error("CalculatorVO :: Property is NOT defined ");
				return null;
			}
			return (props[name] as CalculatorCategoryVO).value;
			
		}

		public function toString():String
		{
			var string:String = "";
			var categoryVO:CalculatorCategoryVO;

			for (var name:String in props)
			{
				categoryVO = getPropertyVO(name);
				string += "\n-- " + categoryVO.name + " ::  " + categoryVO.value;
			}
			return string;
		}
	}
}
