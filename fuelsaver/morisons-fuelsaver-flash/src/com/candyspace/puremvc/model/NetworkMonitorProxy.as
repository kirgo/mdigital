package com.candyspace.puremvc.model
{

	import com.candyspace.puremvc.core.Notifications;
	import flash.events.Event;
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;

	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class NetworkMonitorProxy extends Proxy implements IProxy
	{
		public static const STATE_OFFLINE:String = "stateOffline";
		public static const STATE_ONLINE:String = "stateOnline";
		public static const STATE_WIFI:String = "stateWifi";
		private var currentState:String;
		public static const NAME:String = "NetworkMonitorProxy";

		public function NetworkMonitorProxy(data:Object = null)
		{
			super(NAME, data);
			startNetworkMonitor();
		}

		public function getMacAddress():String
		{
			var returnValue:String;

			var interfaces:Vector.<NetworkInterface> = NetworkInfo.networkInfo.findInterfaces();
			for (var i:uint = 0; i < interfaces.length; i++)
			{
				if (interfaces[i].name.toLowerCase() == "wifi")
				{
					returnValue = interfaces[i].hardwareAddress;
					break;
				}
			}

			return returnValue;
		}

		public function getCurrentNetworkState():String
		{
			return currentState;
		}

		protected function checkNetworkConnection(event:Event):void
		{
			var newState:String = STATE_OFFLINE;

			var interfaces:Vector.<NetworkInterface> = NetworkInfo.networkInfo.findInterfaces();

			for (var i:uint = 0; i < interfaces.length; i++)
			{
				// // //trace("NetworkInterfaceCheck:",interfaces[i].name,"active:",interfaces[i].active);
				if (interfaces[i].name.toLowerCase() == "wifi" && interfaces[i].active)
				{
					newState = STATE_WIFI;
					break;
				}
				else if (interfaces[i].active)
				{
					newState = STATE_ONLINE;
					break;
				}
			}

			// // //trace("NetworkMonitorProxy::new network state:",newState);
			if (newState != currentState)
			{
				currentState = newState;
				sendNotification(Notifications.instance.NETWORK_STATUS_UPDATE, newState);
			}
		}

		private function startNetworkMonitor():void
		{
			currentState = STATE_OFFLINE;

			var interfaces:Vector.<NetworkInterface> = NetworkInfo.networkInfo.findInterfaces();

			for (var i:uint = 0; i < interfaces.length; i++)
			{
				// // trace("NetworkInterfaceCheck:",interfaces[i].name,"active:",interfaces[i].active);
				if (interfaces[i].name.toLowerCase() == "wifi" && interfaces[i].active)
				{
					currentState = STATE_WIFI;
					break;
				}
				else if (interfaces[i].active)
				{
					currentState = STATE_ONLINE;
					break;
				}
			}

			// // //trace("NetworkMonitorProxy initial network state:",currentState);
			NetworkInfo.networkInfo.addEventListener(Event.NETWORK_CHANGE, checkNetworkConnection);
		}
	}
}