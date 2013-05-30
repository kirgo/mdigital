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
package com.candyspace.puremvc.mediator.preloader
{

	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.view.preloader.IPreloader;

	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author Carlos D. Rodriguez
	 */

	public class PreloaderMediator extends Mediator implements IMediator
	{
		// -----------------------------
		// Properties - PUBLIC
		// -----------------------------
		public static function get NAME():String
		{
			return getQualifiedClassName(PreloaderMediator);
		}

		// -----------------------------
		// Properties - PUBLIC
		// -----------------------------
		private function get view():IPreloader
		{
			return (viewComponent as IPreloader);
		}

		// -----------------------------
		// CONSTRUCTOR
		// -----------------------------
		public function PreloaderMediator(viewComponent:Object = null)
		{
			super(NAME, viewComponent);
		}

		// -----------------------------
		// Methods - INIT
		// -----------------------------
		private function init():void
		{
		}
		


		// -----------------------------
		// Methods - OVERRIDDEN
		// -----------------------------
		override public function listNotificationInterests():Array
		{
			return [Notifications.instance.PRELOADER_PROGRESS, Notifications.instance.REMOVE_PRELOADER];
		}

		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case Notifications.instance.PRELOADER_PROGRESS:
				{
					if (view && !isNaN(notification.getBody() as Number))
					{
						view.progress(notification.getBody() as Number);
					}
					break;
				}
				case Notifications.instance.REMOVE_PRELOADER:
				{
					// when the preloader is removed, the view should self-destruct
					// view.applicationInitialized();
					break;
				}
				default:
					break;
			}
		}
	}
}
