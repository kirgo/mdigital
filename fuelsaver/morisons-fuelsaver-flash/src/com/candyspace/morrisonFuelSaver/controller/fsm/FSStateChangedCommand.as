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
package com.candyspace.morrisonFuelSaver.controller.fsm
{

	import com.candyspace.morrisonFuelSaver.core.FSConstants;
	import com.candyspace.puremvc.model.services.GoogleStaticMapProxy;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.morrisonFuelSaver.core.FSSettings;
	import com.candyspace.puremvc.model.services.GoogleStaticMapVO;
	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSStates;
	import com.candyspace.puremvc.facade.AppFacade;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.utilities.statemachine.State;

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
	public class FSStateChangedCommand extends SimpleCommand
	{
		// --------------------------------------
		// Properties
		// --------------------------------------


		
		
		//--------------------------------------
        // Methods - OVERRIDDEN
        //--------------------------------------      
        /**
         * 
         * @param	notification
         */
        override public function execute(notification:INotification):void 
        {			
            var currentState:String = State(notification.getBody()).name;
            
			// fsm
            trace("*************************************************");
            trace("STATE CHANGED TO: " + currentState);
            trace("*************************************************");
            
            
            // set the current state
            // TODO: connection proxy is also hold currentState           
            (facade as AppFacade).currentState = currentState;
            
            var enableUserInterface:Boolean = true;
            
            // iterator
            var i:int;
			
            switch (currentState)
            {
                case FSStates.instance.INITIAL:
                {
                    trace("Sending notification: " + FSNotifications.instance.INITIAL);
					
					var initMapVO:GoogleStaticMapVO = new GoogleStaticMapVO();
					initMapVO.width = 348;
					initMapVO.height = 153;
					initMapVO.hasSensor = false;
					initMapVO.addIcon(FSConstants.GOOGLE_MAP_ICON_URL, false)
					sendNotification(Notifications.instance.GOOGLE_STATIC_MAP_ACTION, initMapVO, GoogleStaticMapProxy.INIT_MAP);
					
                    break;
                }
                case FSStates.instance.WAIT_FOR_NEXT_ACTION:
                {
                    trace("Sending notification: " + FSNotifications.instance.WAIT_FOR_NEXT_ACTION);
                    sendNotification(FSNotifications.instance.WAIT_FOR_NEXT_ACTION);
                    break;
                }			                                                                                                     
                default:
                {
                    break;
                }
            }
			
			// update possible user actions when implemented
            
        }
	}
}
