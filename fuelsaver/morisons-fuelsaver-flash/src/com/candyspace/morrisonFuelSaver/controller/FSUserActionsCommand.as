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
package com.candyspace.morrisonFuelSaver.controller
{

	import com.candyspace.puremvc.facade.IAppFacade;
	import com.candyspace.morrisonFuelSaver.core.FSConstants;
	import com.candyspace.morrisonFuelSaver.core.FSActions;
	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSSettings;
	import com.candyspace.morrisonFuelSaver.core.FSUserActions;
	import com.candyspace.morrisonFuelSaver.model.vo.StoreVO;

	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.System;

	/**
	 * @author Carlos D. Rodriguez
	 */
	// --------------------------------------
	// IMPORTS
	// --------------------------------------


	// --------------------------------------
	// CLASS
	// --------------------------------------
	/**
	 * Class Comment
	 */
	public class FSUserActionsCommand extends SimpleCommand implements ICommand
	{
		// --------------------------------------
		// Properties
		// --------------------------------------

		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		override public function execute(notification:INotification):void
		{
			var action:String = notification.getType();
			
			switch (action)
			{ 
				case FSUserActions.SELECT_MENU_LOGO:
				{
					trace( "FSUserActionsCommand :: SELECT_MENU_LOGO was selected" ); 
					
					sendNotification(FSNotifications.instance.CLIENT_ACTION, null, FSActions.instance.RELOAD_APP);
					
					break;
				}
				case FSUserActions.SELECT_MENU_CALCULATOR:
				{
					trace( "FSUserActionsCommand :: SELECT_MENU_CALCULATOR was selected" ); 
					
					sendNotification(FSNotifications.instance.CLIENT_ACTION, null, FSActions.instance.SELECT_MENU_CALCULATOR);
					
					break;
				}
				case FSUserActions.SELECT_MENU_REGISTRATION: 
				{
					trace( "FSUserActionsCommand :: SELECT_MENU_REGISTRATION"); 
					sendNotification(FSNotifications.instance.CLIENT_ACTION, null, FSActions.instance.SELECT_MENU_REGISTRATION);
					break;
				}
				case FSUserActions.SELECT_MENU_LOCATION:
				{
					trace( "FSUserActionsCommand :: SELECT_MENU_LOCATION was selected" ); 
					sendNotification(FSNotifications.instance.CLIENT_ACTION, null, FSActions.instance.SELECT_MENU_LOCATION);
					break;
				}
				case FSUserActions.SELECT_MENU_SHARING: 
				{
					trace( "FSUserActionsCommand :: SELECT_MENU_WIDGET was selected" ); 
					sendNotification(FSNotifications.instance.CLIENT_ACTION, null, FSActions.instance.SELECT_MENU_SHARING);
					break;
				}
				case FSUserActions.OPEN_CALCULATOR:
				{
					trace( "FSUserActionsCommand :: OPEN_CALCULATOR was selected" ); 
					sendNotification(FSNotifications.instance.CLIENT_ACTION, null, FSActions.instance.OPEN_CALCULATOR);
					break;
				}
				case FSUserActions.OPEN_REGISTRATION: 
				{
					trace( "FSUserActionsCommand :: OPEN_SIGNUP was selected" ); 
					sendNotification(FSNotifications.instance.CLIENT_ACTION, null, FSActions.instance.OPEN_REGISTRATION);
					break;
				}
				case FSUserActions.OPEN_LOCATION: 
				{
					trace( "FSUserActionsCommand :: OPEN_LOCATION was selected" ); 
					sendNotification(FSNotifications.instance.CLIENT_ACTION, null, FSActions.instance.OPEN_LOCATION);
					break;
				}
				case FSUserActions.OPEN_SHARING: 
				{
					trace( "FSUserActionsCommand :: OPEN_LOCATION was selected" ); 
					sendNotification(FSNotifications.instance.CLIENT_ACTION, null, FSActions.instance.OPEN_SHARING);
					break;
				}
				case FSUserActions.CHANGE_CALCULATOR_ITEM:
				{
					trace( "FSUserActionsCommand :: CHANGE_CALCULATOR_ITEM was selected" ); 
					var data:Object = notification.getBody();
					sendNotification(FSNotifications.instance.UPDATE_CALCULATOR_CATEGORY_VALUE, data);
					break;
				}
				case FSUserActions.CALCULATE: 
				{
					trace( "FSUserActionsCommand :: CALCULATE was selected" ); 					
					sendNotification(FSNotifications.instance.SERVER_ACTION, null, FSActions.instance.CALCULATE);					
					break;
				}
				case FSUserActions.FINDOUT_MORE: 
				{
					trace( "FSUserActionsCommand :: FINDOUT_MORE was selected" );
					navigateToURL(new URLRequest(FSConstants.FINDOUT_MORE_URL));
					break;
				}
				case FSUserActions.CLOSE_APP: 
				{
					trace( "FSUserActionsCommand :: FINDOUT_MORE was selected" );
					var functionCallName:String = FSConstants.CLOSE_PARENT_WINDOW_CALL_NAME;
					
					if((facade as IAppFacade).getParameter(FSConstants.CLOSE_LINK_PARAMETER_NAME, FSConstants.CLOSE_LINK_PARAMETER_DEFAULT_VALUE) == "true")
					{
						functionCallName = "parent." + FSConstants.CLOSE_PARENT_WINDOW_CALL_NAME;
					}
					ExternalInterface.call(functionCallName);
					break;
				}
				case FSUserActions.SUBMIT_REGISTRATION: 
				{
					trace( "FSUserActionsCommand :: SUBMIT_REGISTRATION was selected" ); 
					var email:String = String(notification.getBody());
					sendNotification(FSNotifications.instance.SERVER_ACTION, email, FSActions.instance.SUBMIT_REGISTRATION);
					break;
				}
				case FSUserActions.SHOW_PRIVACY_POLICY:
				{ 
					trace( "FSUserActionsCommand :: SHOW_PRIVACY_POLICY was selected" ); 
					navigateToURL(new URLRequest(FSConstants.PRIVACY_POLICY_URL));
					break;
				}
				case FSUserActions.SHOW_TC:
				{  
					trace( "FSUserActionsCommand :: SHOW_TC was selected" ); 
					sendNotification(FSNotifications.instance.CLIENT_ACTION, null, FSActions.instance.SHOW_TC);
					break;
				}
				case FSUserActions.FIND_NEAREST:
				{  
					trace( "FSUserActionsCommand :: FIND_NEAREST was selected" ); 
					var postcode:String = String(notification.getBody());
					sendNotification(FSNotifications.instance.SERVER_ACTION, postcode, FSActions.instance.RETRIEVE_MAP);
					break;
				}
				case FSUserActions.SEARCH_AGAIN:
				{  
					trace( "FSUserActionsCommand :: SEARCH_AGAIN was selected" ); 
					break;
				}
				case FSUserActions.OPEN_EXTERNAL_MAP:
				{  
					trace( "FSUserActionsCommand :: OPEN_EXTERNAL_MAP was selected" ); 
					var store:StoreVO = notification.getBody() as StoreVO;
					var url:String = getGoogleExternalMapUrl(store.lon, store.lat);					
					navigateToURL(new URLRequest(url));
					break;
				}
				case FSUserActions.SHARE_ON_FACEBOOK:
				{  
					trace( "FSUserActionsCommand :: SHARE_ON_FACEBOOK was selected" ); 
					ExternalInterface.call(FSConstants.FACEBOOK_SHARE_CALL_NAME);
					break;
				}
				case FSUserActions.SHARE_ON_TWITTER:
				{  
					trace( "FSUserActionsCommand :: SHARE_ON_TWITTER was selected" );
					navigateToURL(new URLRequest(FSConstants.TWITTER_SHARE_URL));
					break;
				}
				case FSUserActions.OPEN_FACEBOOK:
				{  
					trace( "FSUserActionsCommand :: OPEN_FACEBOOK was selected" ); 
					navigateToURL(new URLRequest(FSConstants.FACEBOOK_URL));
					break;
				}
				case FSUserActions.OPEN_TWITTER:
				{  
					trace( "FSUserActionsCommand :: OPEN_TWITTER was selected" );
					navigateToURL(new URLRequest(FSConstants.TWITTER_URL));
					break;
				}
				case FSUserActions.OPEN_TC:
				{  
					trace( "FSUserActionsCommand :: OPEN_TWITTER was selected" );
					navigateToURL(new URLRequest(FSConstants.TERMS_CONDITIONS_URL));
					break;
				}
				case FSUserActions.EMBED_CODE: 
				{
					trace( "FSUserActionsCommand :: EMBED_CODE was selected" ); 			
					System.setClipboard(FSConstants.SHARING_EMBED_CODE);					
					break;
				}

				default: 
					trace( "FSUserActionsCommand :: ACTION IS NOT DEFINED: ", action );
			}

		}

		
		public function getGoogleExternalMapUrl(lon:String, lat:String):String
		{
			return FSConstants.GOOGLE_EXTERNAL_MAP_URL +  lon + "," + lat;
		}

	}
}