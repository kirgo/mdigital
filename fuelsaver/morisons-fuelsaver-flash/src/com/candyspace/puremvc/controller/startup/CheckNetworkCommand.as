package com.candyspace.puremvc.controller.startup
{

	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.model.NetworkMonitorProxy;

	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class CheckNetworkCommand extends SimpleCommand implements ICommand
	{
		/**
		 * NOTE FOR APO :) : If network is on WIFI or 3G (i.e got a connection) boot the app (as in line 28) otherwise if show NO Internet POPUP
		 */
		override public function execute(notification:INotification):void
		{
			var networkMonitorProxy:NetworkMonitorProxy = facade.retrieveProxy(NetworkMonitorProxy.NAME) as NetworkMonitorProxy;
			var currentNetworkState:String = networkMonitorProxy.getCurrentNetworkState();

			sendNotification(Notifications.instance.NETWORK_STATUS_UPDATE, currentNetworkState);

			// if( currentNetworkState==NetworkMonitorProxy.STATE_ONLINE || currentNetworkState==NetworkMonitorProxy.STATE_WIFI ){
			// sendNotification(Notifications.CHECK_PERSISTANCE_FILE);
			// } else {
			// var popupVo:PopupVO = new PopupVO();
			// popupVo.message = TextConstants.MESSAGE_NO_INTERNET;
			// popupVo.errorType = Notifications.START_CONNECTION_PROBLEM;
			// sendNotification(Notifications.SHOW_POPUP_OVERLAY,popupVo);
			// }
		}
	}
}