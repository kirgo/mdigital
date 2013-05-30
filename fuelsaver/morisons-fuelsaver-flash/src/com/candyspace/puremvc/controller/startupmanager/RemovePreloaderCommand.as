// //////////////////////////////////////////////////////////////////////////////
//
// CANDYSPACE
// Copyright 2012 CANDYSPACE
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// //////////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.controller.startupmanager
{

	import com.candyspace.puremvc.mediator.preloader.PreloaderMediator;
	import flash.utils.getQualifiedClassName;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.model.startupmanager.PreloaderProxy;
	import flash.display.MovieClip;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
    //--------------------------------------
    // IMPORTS
    //--------------------------------------
    
 
    
	//--------------------------------------
    // Class
	//--------------------------------------
	
    /**
     * Removes the preloader, after the asstets loading is complete.
     */

	public class RemovePreloaderCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var preloader:MovieClip = (facade.retrieveProxy(PreloaderProxy.NAME) as PreloaderProxy).getData() as MovieClip;
			
			try
			{
				sendNotification(Notifications.instance.REMOVE_VIEW, {child: preloader});
			}
			catch (e:Error)
			{
				//error
				trace(getQualifiedClassName(this) + "::execute - preloader could not be removed from stage.");
			}
			
			//GameFacade(facade).applyGameMask();
			facade.removeMediator(PreloaderMediator.NAME);
			facade.removeProxy(PreloaderProxy.NAME);
			facade.removeCommand(Notifications.instance.REMOVE_PRELOADER);
		}
	}
}
