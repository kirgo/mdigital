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
package com.candyspace.puremvc.controller.startup.web
{

	import com.candyspace.puremvc.core.Notifications;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
    
    public class WAViewsInitializedCommand extends SimpleCommand
    {
        //--------------------------------------
        // Methods - OVERRIDDEN
        //--------------------------------------
        
        /**
         * @param	notification
         */
        override public function execute(notification:INotification):void 
        {
            // start the server connecting process
            //debug
            trace("ViewsInitializedCommand - Sending notifications.\n");

            // register the FSM
            sendNotification(Notifications.instance.REGISTER_FSM);
			
			//TODO: add initial set up notation as service get implemted in here:
            
            sendNotification(Notifications.instance.REMOVE_PRELOADER);
        }
    }
}
