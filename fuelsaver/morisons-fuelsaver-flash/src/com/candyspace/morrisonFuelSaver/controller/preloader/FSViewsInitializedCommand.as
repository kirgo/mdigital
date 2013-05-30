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
package com.candyspace.morrisonFuelSaver.controller.preloader
{

	import com.candyspace.morrisonFuelSaver.core.FSConstants;
	import com.candyspace.morrisonFuelSaver.core.FSSettings;
	import flash.utils.setTimeout;
	import com.candyspace.morrisonFuelSaver.core.FSActions;
	import com.candyspace.puremvc.controller.startup.web.WAViewsInitializedCommand;
	import com.candyspace.puremvc.core.Notifications;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.utilities.statemachine.StateMachine;
    
    public class FSViewsInitializedCommand extends WAViewsInitializedCommand
    {
        //--------------------------------------
        // Methods - OVERRIDDEN
        //--------------------------------------
        
        /**
         * @param	notification
         */
        override public function execute(notification:INotification):void 
        {
			
			sendNotification(Notifications.instance.REGISTER_FSM);
            
            //sendNotification(Notifications.instance.REMOVE_PRELOADER);
            
			// TODO should have remove at stateChange            
			setTimeout(sendNotification, FSConstants.SPLASH_WINDOW_DELAY, Notifications.instance.REMOVE_PRELOADER);
            
			sendNotification(StateMachine.ACTION, null, FSActions.instance.BEGIN_APP);
        }
    }
}