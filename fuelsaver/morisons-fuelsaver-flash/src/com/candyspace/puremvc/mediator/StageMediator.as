// // // // ////////////////////////////////////////////////////////////////////////
//
// CANDYMEDIA
// Copyright 2012 CANDYMEDIA
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // // // ////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.mediator
{

	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import uk.co.bdoran.util.FillClip;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import flash.display.StageAspectRatio;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.display.StageDisplayState;
	import com.candyspace.puremvc.core.Settings;
	import com.candyspace.puremvc.core.Notifications;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.SoftKeyboardEvent;
	import flash.desktop.NativeApplication;
	import flash.display.Stage;
	import flash.utils.getQualifiedClassName;

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
	public class StageMediator extends Mediator implements IMediator
	{
		private var isBackgroundSprite:Boolean;
		private var backgroundSprite:Sprite;
		// --------------------------------------
		// Properties
		// --------------------------------------
		/**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static function get NAME():String
		{
			return getQualifiedClassName(StageMediator);
		}

		/**
		 * Method used to get a reference to the view attached to the current mediator. Apart from the 
		 * viewComponent property, this getter returns a reference already casted to the view type.
		 */
		private function get stage():Stage
		{
			return viewComponent as Stage;
		}

		// --------------------------------------
		// Constructor
		// --------------------------------------
		public function StageMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
		}
		

		// --------------------------------------
		// Methods - Init
		// --------------------------------------
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		protected function initEventListener():void
		{
			stage.addEventListener(Event.RESIZE, onStageResize);
			stage.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, onSoftKeyboardState);
			stage.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, onSoftKeyboardState);
			
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, onAppActivated);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, onAppDeactivated);
			
			// TODO: it might be moved to its own mediator
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}

		override public function listNotificationInterests() : Array {
			return [

				Notifications.instance.ALLOW_ROTATION,
				Notifications.instance.FORCE_ORIENTATION 
				];
		}

		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case Notifications.instance.ALLOW_ROTATION :
				{
					enableRotation(notification.getBody() as Boolean);
					break;
				}
				case Notifications.instance.FORCE_ORIENTATION :
				{
					forceOrientation(notification.getBody() as String);
				}
				default:
				{
					break;
				}
			}
		}
		
		// --------------------------------------
		// Methods - Private
		// --------------------------------------
		private function sendOrientationChange():void
		{
			trace("StageMediator >>>>>>>>>>>>>>>>>>>>>>>>>>> ", stage);
			fillStage()
			setSourceRect();
			
			var orientation : String = stage.stageWidth > stage.stageHeight ? StageAspectRatio.LANDSCAPE : StageAspectRatio.PORTRAIT;
			sendNotification(Notifications.instance.ORIENTATION_CHANGED, orientation );
		}
		
		private function fillStage() : void{
			if( !backgroundSprite ){
				 backgroundSprite = new Sprite();
				 stage.addChild( backgroundSprite );
			}
			backgroundSprite.graphics.clear();
			FillClip.fillClipWithClipDimentions(backgroundSprite, stage);
		}
		
		private function setSourceRect():void
		{
			if (stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE || stage.displayState == StageDisplayState.FULL_SCREEN)
			{
				stage.fullScreenSourceRect = null;
				stage.displayState = StageDisplayState.NORMAL;
				stage.fullScreenSourceRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
		}		

		private function enableRotation(enabled:Boolean):void
		{
			stage.autoOrients = enabled;
			if ( enabled )
			{
				// TODO: ArgumentError: Error #2004: One of the parameters is invalid. WHEN StageAspectRatio.ANY || ONLY in desktop
				//stage.setAspectRatio(StageAspectRatio.ANY);
			}
		}

		private function forceOrientation(orientation:String):void
		{
			if ( orientation == StageAspectRatio.LANDSCAPE)
			{
				stage.setAspectRatio(StageAspectRatio.LANDSCAPE);
			}
			else
			{
				stage.setAspectRatio(StageAspectRatio.PORTRAIT);
			}
		}
		
		// --------------------------------------
		// Event handlers overriden
		// --------------------------------------
		override public function onRegister():void
		{
			trace("StageMediator >>> onRegister =======================")
			super.onRegister();
			initEventListener();
		}
		// --------------------------------------
		// Event handlers
		// --------------------------------------
		
		private function onStageResize(event:Event):void
		{
			sendOrientationChange();
		}
		
		private function onSoftKeyboardState(event:SoftKeyboardEvent):void
		{
			sendOrientationChange();
		}
		
		private function onAppActivated(event:Event):void
		{
			sendNotification(Notifications.instance.APP_ACTIVATED);
		}

		private function onAppDeactivated(event:Event):void
		{
			sendNotification(Notifications.instance.APP_DEACTIVATED);
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			trace("StageMediator :: onKeyDown", event.keyCode);
			
		}
	}
}
