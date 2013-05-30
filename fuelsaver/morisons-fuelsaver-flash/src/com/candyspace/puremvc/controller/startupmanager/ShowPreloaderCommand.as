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

	import com.candyspace.puremvc.facade.WebAppFacade;
	import com.candyspace.puremvc.mediator.preloader.PreloaderMediator;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.core.layers.GeneralLayers;
	import com.candyspace.puremvc.model.startupmanager.PreloaderProxy;
	import com.candyspace.puremvc.view.preloader.IPreloader;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.utilities.startupmanager.controller.StartupResourceLoadedCommand;
	/**
	 * @author Carlos D. Rodriguez
	 */
	public class ShowPreloaderCommand extends SimpleCommand
    {
        //--------------------------------------
        // Properties - PRIVATE
        //--------------------------------------
        
        private var _preloader:IPreloader;
        
        private var _notification:INotification;
        
        //--------------------------------------
        // Methods - OVERRIDDEN
        //--------------------------------------
        
		override public function execute(notification:INotification):void 
		{
            _notification = notification;
            
			_preloader = (facade.retrieveProxy(PreloaderProxy.NAME) as PreloaderProxy).getData() as IPreloader;
			
			trace("ShowPreloaderCommand :: execute :: preloader:", (facade.retrieveProxy(PreloaderProxy.NAME) as PreloaderProxy).getData() as IPreloader);
			
			if (_preloader)
			{
				//_preloader.init(getConfigObject());
			}
            
            initializedPreloaderActions();
		}
        
        //--------------------------------------
        // Methods - PRIVATE
        //--------------------------------------
        
		private function initializedPreloaderActions():void
		{
			facade.registerMediator(new PreloaderMediator(_preloader));

			if (_preloader)
			{
				sendNotification(Notifications.instance.ADD_VIEW, {child:_preloader}, GeneralLayers.instance.PRELOADER);
			}

			var command:StartupResourceLoadedCommand = new StartupResourceLoadedCommand();
			command.initializeNotifier(WebAppFacade.MAIN_APP_KEY);
			command.execute(_notification);
		}
        
		/** 
        private function getConfigObject():Object
		{	
			 // object could be generated to pass some values if needed
 		}
 		*/

	}
	
}
