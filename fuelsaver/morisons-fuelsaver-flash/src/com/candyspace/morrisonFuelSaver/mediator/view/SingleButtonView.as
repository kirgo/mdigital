// // ////////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // // ////////////////////////////////////////////////////////////////////////
package com.candyspace.morrisonFuelSaver.mediator.view
{
	import com.candyspace.morrisonFuelSaver.core.FSConstants;

	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------

	import com.candyspace.controls.TwoStateEnableButtonMovieClip;
	import com.candyspace.morrisonFuelSaver.core.FSSettings;
	import com.candyspace.puremvc.events.ButtonActionEvent;
	import com.candyspace.puremvc.view.AbstractView;
	import com.candyspace.puremvc.view.IView;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class SingleButtonView extends AbstractView implements IView
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		public static const SUBMIT_BUTTON_NAME:String = "submitBttn";
		
		protected var _bttn:MovieClip;
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function SingleButtonView(name:String, displayObjectClassRef:Class)
		{
			super(name, displayObjectClassRef, null,  orientation)
		}

		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------		
		
		override protected function initVars():void
		{
			super.initVars();
			
			var coor:Point = FSConstants.VIEWS_MENU_OFFSET;
			
			display.x = coor.x;
			
			display.y = coor.y;
			
			_bttn = displayObjectContainer.getChildByName(SUBMIT_BUTTON_NAME) as MovieClip;
			
			enableButton(_bttn);
			
			_bttn.mouseChildren = false;
		}
		
		override protected function initEventListeners():void
		{
			super.initEventListeners();
			_bttn.addEventListener(MouseEvent.CLICK, onButtonAction);
		}

		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		
		// TODO implement grey out
		public function enableButton(button:MovieClip, enabled:Boolean = true):void
		{
			if (enabled)
			{
				button.mouseEnabled = true;
				button.mouseChildren = false;
				button.buttonMode = true;
				button.useHandCursor = true;
				if(button is TwoStateEnableButtonMovieClip)
				{
					(button as TwoStateEnableButtonMovieClip).isEnabled = true;
				}
				
			}
			else
			{
				button.mouseEnabled = false;
				button.mouseChildren = false;
				button.buttonMode = false;
				button.useHandCursor = false;
				if(button is TwoStateEnableButtonMovieClip )
				{
					(button as TwoStateEnableButtonMovieClip).isEnabled = false;
				}
			}
		}
		
		protected function removeSpaces(str:String):String
		{
			var words:Array=str.split(' ');
			return(words.join(''));
		}
		
		// --------------------------------------
		// Event handlers
		// --------------------------------------
		protected function onButtonAction(event:MouseEvent):void
		{
			var buttonActionEvent:ButtonActionEvent = new ButtonActionEvent(ButtonActionEvent.ACTION);
			buttonActionEvent.event = event;
			buttonActionEvent.buttonName = event.target.name;
			//trace("button action event: =================================" , buttonActionEvent.buttonName);
			dispatchEvent(buttonActionEvent);
		}
	}
}