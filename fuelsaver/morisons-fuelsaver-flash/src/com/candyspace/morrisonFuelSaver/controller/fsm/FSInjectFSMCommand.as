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

	import com.candyspace.morrisonFuelSaver.core.FSActions;
	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSStates;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.utilities.statemachine.FSMInjector;
    /**
     * @author Carlos D. Rodriguez
     */
    
    //--------------------------------------
    // IMPORTS
    //--------------------------------------
    
    // Flash
    
    // PureMVC	

	
    // Custom
    
    //--------------------------------------
    // CLASS
    //--------------------------------------
    
    /**
    * Class Comment
    */
    
    public class FSInjectFSMCommand extends SimpleCommand
    {
        //--------------------------------------
        // Methods - OVERRIDDEN
        //--------------------------------------
        
        /**
         * 
         * @param	notification
         */
        override public function execute(notification:INotification):void 
        {
            var fsmXML:XML = 
            <fsm initial={FSStates.instance.INITIAL}>               
                <state name={FSStates.instance.INITIAL} exiting={FSNotifications.instance.REGISTER_EXITING_STATE}>
					
                    <transition action={FSActions.instance.BEGIN_APP} target={FSStates.instance.CALCULATOR_INFO}/>
					<transition action={FSActions.instance.OPEN_CALCULATOR} target={FSStates.instance.CALCULATOR_ENTRY}/>
                    <transition action={FSActions.instance.FATAL_ERROR} target={FSStates.instance.ERROR}/>
                </state>
                
                <state name={FSStates.instance.CALCULATOR_INFO} exiting={FSNotifications.instance.REGISTER_EXITING_STATE}>
                   	<transition action={FSActions.instance.RELOAD_APP} target={FSStates.instance.CLOSE_APP}/>
					
                    <transition action={FSActions.instance.SELECT_MENU_CALCULATOR} target={FSStates.instance.CALCULATOR_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_REGISTRATION} target={FSStates.instance.REGISTRATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_LOCATION} target={FSStates.instance.LOCATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_SHARING} target={FSStates.instance.SHARING_INFO}/>
					
                    <transition action={FSActions.instance.OPEN_CALCULATOR} target={FSStates.instance.CALCULATOR_ENTRY}/>
                    <transition action={FSActions.instance.FATAL_ERROR} target={FSStates.instance.ERROR}/>
                </state>
				
				<state name={FSStates.instance.REGISTRATION_INFO} exiting={FSNotifications.instance.REGISTER_EXITING_STATE}>
                    <transition action={FSActions.instance.RELOAD_APP} target={FSStates.instance.CLOSE_APP}/>
					
                    <transition action={FSActions.instance.SELECT_MENU_CALCULATOR} target={FSStates.instance.CALCULATOR_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_REGISTRATION} target={FSStates.instance.REGISTRATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_LOCATION} target={FSStates.instance.LOCATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_SHARING} target={FSStates.instance.SHARING_INFO}/>
					
                    <transition action={FSActions.instance.OPEN_REGISTRATION} target={FSStates.instance.REGISTRATION_ENTRY}/>
                    <transition action={FSActions.instance.FATAL_ERROR} target={FSStates.instance.ERROR}/>
                </state>
                
                <state name={FSStates.instance.LOCATION_INFO} exiting={FSNotifications.instance.REGISTER_EXITING_STATE}>
                   <transition action={FSActions.instance.RELOAD_APP} target={FSStates.instance.CLOSE_APP}/>
					
                    <transition action={FSActions.instance.SELECT_MENU_CALCULATOR} target={FSStates.instance.CALCULATOR_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_REGISTRATION} target={FSStates.instance.REGISTRATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_LOCATION} target={FSStates.instance.LOCATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_SHARING} target={FSStates.instance.SHARING_INFO}/>
					
                    <transition action={FSActions.instance.OPEN_LOCATION} target={FSStates.instance.LOCATION_ENTRY}/>
                    <transition action={FSActions.instance.FATAL_ERROR} target={FSStates.instance.ERROR}/>
                </state>
                
				<state name={FSStates.instance.SHARING_INFO} exiting={FSNotifications.instance.REGISTER_EXITING_STATE}>
                    <transition action={FSActions.instance.RELOAD_APP} target={FSStates.instance.CLOSE_APP}/>
					
                    <transition action={FSActions.instance.SELECT_MENU_CALCULATOR} target={FSStates.instance.CALCULATOR_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_REGISTRATION} target={FSStates.instance.REGISTRATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_LOCATION} target={FSStates.instance.LOCATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_SHARING} target={FSStates.instance.SHARING_INFO}/>
					
                    <transition action={FSActions.instance.OPEN_SHARING} target={FSStates.instance.SHARING}/>
                    <transition action={FSActions.instance.FATAL_ERROR} target={FSStates.instance.ERROR}/>
                </state>
				
				<state name={FSStates.instance.CALCULATOR_ENTRY} exiting={FSNotifications.instance.REGISTER_EXITING_STATE}>
                    <transition action={FSActions.instance.RELOAD_APP} target={FSStates.instance.CLOSE_APP}/>
					
                    <transition action={FSActions.instance.SELECT_MENU_CALCULATOR} target={FSStates.instance.CALCULATOR_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_REGISTRATION} target={FSStates.instance.REGISTRATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_LOCATION} target={FSStates.instance.LOCATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_SHARING} target={FSStates.instance.SHARING_INFO}/>
					
                    <transition action={FSActions.instance.CALCULATE} target={FSStates.instance.WAIT_FOR_NEXT_ACTION}/>
                    <transition action={FSActions.instance.FATAL_ERROR} target={FSStates.instance.ERROR}/>
                </state>
				
                 <state name={FSStates.instance.CALCULATOR_RESULTS} exiting={FSNotifications.instance.REGISTER_EXITING_STATE}>
                    <transition action={FSActions.instance.RELOAD_APP} target={FSStates.instance.CLOSE_APP}/>
					
                    <transition action={FSActions.instance.SELECT_MENU_CALCULATOR} target={FSStates.instance.CALCULATOR_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_REGISTRATION} target={FSStates.instance.REGISTRATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_LOCATION} target={FSStates.instance.LOCATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_SHARING} target={FSStates.instance.SHARING_INFO}/>

					<!-- no state change on this action [?] -->
                    <!-- transition action={FSActions.instance.FINDOUT_MORE} target={FSStates.instance.SHARE}/ -->
                    <transition action={FSActions.instance.FATAL_ERROR} target={FSStates.instance.ERROR}/>
                </state>
								
                 <state name={FSStates.instance.REGISTRATION_ENTRY} exiting={FSNotifications.instance.REGISTER_EXITING_STATE}>
                    <transition action={FSActions.instance.RELOAD_APP} target={FSStates.instance.CLOSE_APP}/>
					
                    <transition action={FSActions.instance.SELECT_MENU_CALCULATOR} target={FSStates.instance.CALCULATOR_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_REGISTRATION} target={FSStates.instance.REGISTRATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_LOCATION} target={FSStates.instance.LOCATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_SHARING} target={FSStates.instance.SHARING_INFO}/>

                    <transition action={FSActions.instance.SHOW_TC} target={FSStates.instance.TERMS_CONDITIONS}/>
                    <transition action={FSActions.instance.SUBMIT_REGISTRATION} target={FSStates.instance.WAIT_FOR_NEXT_ACTION}/>
                    <transition action={FSActions.instance.FATAL_ERROR} target={FSStates.instance.ERROR}/>
                </state>				
             				
                 <state name={FSStates.instance.REGISTRATION_CONFIRMATION} exiting={FSNotifications.instance.REGISTER_EXITING_STATE}>
                    <transition action={FSActions.instance.RELOAD_APP} target={FSStates.instance.CLOSE_APP}/>
					
                    <transition action={FSActions.instance.SELECT_MENU_CALCULATOR} target={FSStates.instance.CALCULATOR_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_REGISTRATION} target={FSStates.instance.REGISTRATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_LOCATION} target={FSStates.instance.LOCATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_SHARING} target={FSStates.instance.SHARING_INFO}/>

					
                    <transition action={FSActions.instance.OPEN_CALCULATOR} target={FSStates.instance.CALCULATOR_ENTRY}/>
                    <transition action={FSActions.instance.FATAL_ERROR} target={FSStates.instance.ERROR}/>
                </state>				
				
                <state name={FSStates.instance.TERMS_CONDITIONS} exiting={FSNotifications.instance.REGISTER_EXITING_STATE}>
                    <transition action={FSActions.instance.RELOAD_APP} target={FSStates.instance.CLOSE_APP}/>
					
                    <transition action={FSActions.instance.SELECT_MENU_CALCULATOR} target={FSStates.instance.CALCULATOR_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_REGISTRATION} target={FSStates.instance.REGISTRATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_LOCATION} target={FSStates.instance.LOCATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_SHARING} target={FSStates.instance.SHARING_INFO}/>

					<!--TODO: ? MISING IN THE DISPLAY-->
					<transition action={FSActions.instance.OPEN_REGISTRATION} target={FSStates.instance.REGISTRATION_ENTRY}/>
                    <transition action={FSActions.instance.FATAL_ERROR} target={FSStates.instance.ERROR}/>
                </state>
				
                <state name={FSStates.instance.LOCATION_ENTRY} exiting={FSNotifications.instance.REGISTER_EXITING_STATE}>
                    <transition action={FSActions.instance.RELOAD_APP} target={FSStates.instance.CLOSE_APP}/>
					
                    <transition action={FSActions.instance.SELECT_MENU_CALCULATOR} target={FSStates.instance.CALCULATOR_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_REGISTRATION} target={FSStates.instance.REGISTRATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_LOCATION} target={FSStates.instance.LOCATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_SHARING} target={FSStates.instance.SHARING_INFO}/>

                    <transition action={FSActions.instance.RETRIEVE_MAP} target={FSStates.instance.WAIT_FOR_NEXT_ACTION}/>
                    <transition action={FSActions.instance.FATAL_ERROR} target={FSStates.instance.ERROR}/>>
                </state>
               
                <state name={FSStates.instance.MAP} exiting={FSNotifications.instance.REGISTER_EXITING_STATE}>
                    <transition action={FSActions.instance.RELOAD_APP} target={FSStates.instance.CLOSE_APP}/>
					
                    <transition action={FSActions.instance.SELECT_MENU_CALCULATOR} target={FSStates.instance.CALCULATOR_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_REGISTRATION} target={FSStates.instance.REGISTRATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_LOCATION} target={FSStates.instance.LOCATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_SHARING} target={FSStates.instance.SHARING_INFO}/>

					<transition action={FSActions.instance.OPEN_LOCATION} target={FSStates.instance.LOCATION_ENTRY}/>
                    <transition action={FSActions.instance.RETRIEVE_MAP} target={FSStates.instance.WAIT_FOR_NEXT_ACTION}/>
                    <transition action={FSActions.instance.FATAL_ERROR} target={FSStates.instance.ERROR}/>
                </state>
				
                <state name={FSStates.instance.SHARING} exiting={FSNotifications.instance.REGISTER_EXITING_STATE}>
                    <transition action={FSActions.instance.RELOAD_APP} target={FSStates.instance.CLOSE_APP}/>
					
                    <transition action={FSActions.instance.SELECT_MENU_CALCULATOR} target={FSStates.instance.CALCULATOR_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_REGISTRATION} target={FSStates.instance.REGISTRATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_LOCATION} target={FSStates.instance.LOCATION_INFO}/>
                    <transition action={FSActions.instance.SELECT_MENU_SHARING} target={FSStates.instance.SHARING_INFO}/>

                    <transition action={FSActions.instance.FATAL_ERROR} target={FSStates.instance.ERROR}/>
                </state>
				
				<state name={FSStates.instance.WAIT_FOR_NEXT_ACTION} exiting={FSNotifications.instance.REGISTER_EXITING_STATE}>
                    <transition action={FSActions.instance.CALCULATION_RECEIVED} target={FSStates.instance.CALCULATOR_RESULTS}/>
					<transition action={FSActions.instance.REGISTRATION_CONFIRMATION_RECEIVED} target={FSStates.instance.REGISTRATION_CONFIRMATION}/>
					<transition action={FSActions.instance.STORES_RECEIVED} target={FSStates.instance.MAP}/>
                    <transition action={FSActions.instance.FATAL_ERROR} target={FSStates.instance.ERROR}/>
                </state>  
				
				<state name={FSStates.instance.WARNING} exiting={FSNotifications.instance.REGISTER_EXITING_STATE}>

                </state>  
				                
                <state name={FSStates.instance.ERROR}>
                </state>
                
            </fsm>;
			
			var fsmInjector:FSMInjector = new FSMInjector(fsmXML);
			// this line only in multicore
			fsmInjector.initializeNotifier(this.multitonKey);
			fsmInjector.inject();
        }
    }
}
