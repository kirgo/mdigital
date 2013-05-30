package com.candyspace.puremvc.controller.startup
{

	import com.candyspace.puremvc.core.Settings;
	import com.candyspace.puremvc.core.display.ScreenSize;
	import flash.display.StageAspectRatio;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.model.StateProxy;
	import org.puremvc.as3.multicore.patterns.observer.Notification;

	import nl.funkymonkey.android.deviceinfo.NativeDeviceInfo;
	import nl.funkymonkey.android.deviceinfo.NativeDeviceInfoEvent;
	import nl.funkymonkey.android.deviceinfo.NativeDeviceProperties;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	import flash.system.Capabilities;

	/**
	 * @author bendoran
	 */
	public class GetDevicePropertiesCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var stateProxy:StateProxy = facade.retrieveProxy(StateProxy.NAME) as StateProxy;

			// TODO - Not sure about this implementation, but it keeps it in one Command
			var screenWidth:int = Capabilities.screenResolutionX < Capabilities.screenResolutionY ? Capabilities.screenResolutionX : Capabilities.screenResolutionY;
			if ( screenWidth >= 600 && Capabilities.screenDPI < 320 )
			{
				stateProxy.formFactor = ScreenSize.BIG;
				stateProxy.deviceCapability = ScreenSize.BIG;
			}
			else
			{
				stateProxy.formFactor = ScreenSize.SMALL;
				stateProxy.deviceCapability = ScreenSize.SMALL;
			}

			// Inspect Device Properties (for Device Exclusions)
			var deviceInfo:NativeDeviceInfo = new NativeDeviceInfo();
			deviceInfo.addEventListener(NativeDeviceInfoEvent.PROPERTIES_PARSED, handleDevicePropertiesParsed);
			deviceInfo.addEventListener(NativeDeviceInfoEvent.FAILED_ON_LOAD, handleDevicePropertiesFailed);
			deviceInfo.setDebug(false);
			deviceInfo.parse();
		}

		private function handleDevicePropertiesParsed(event:NativeDeviceInfoEvent):void
		{
			NativeDeviceInfo(event.target).removeEventListener(NativeDeviceInfoEvent.PROPERTIES_PARSED, handleDevicePropertiesParsed);
			var stateProxy:StateProxy = facade.retrieveProxy(StateProxy.NAME) as StateProxy;
			if ( NativeDeviceProperties.PRODUCT_MODEL.value == "GT-P1000" )
			{
				stateProxy.deviceCapability = ScreenSize.SMALL;
			}

			stateProxy.osVersion = NativeDeviceProperties.OS_VERSION.value;
			getPropertiesComplete();
			
			sendNotification(Notifications.instance.DEVICE_PROPERTIES_PARSED);
		}

		private function handleDevicePropertiesFailed(event:NativeDeviceInfoEvent):void
		{
			getPropertiesComplete();
			sendNotification(Notifications.instance.DEVICE_PROPERTIES_FAILED);
		}

		// TODO define list of device sizes that support rotation
		private function getPropertiesComplete():void
		{
			if(isRotationRestricted)
			{
				sendNotification(Notifications.instance.FORCE_ORIENTATION, StageAspectRatio.PORTRAIT);
			}
			else
			{
				sendNotification(Notifications.instance.ALLOW_ROTATION, true);
			}

			// TODO: 
			//sendNotification(Notifications.instance.INIT_TRACKING);
		}
		
		private function get isRotationRestricted():Boolean
		{
			var stateProxy:StateProxy = facade.retrieveProxy(StateProxy.NAME) as StateProxy;
			var noRotatingDevices:Array = Settings.instance.noRotatingDeviceSizes;
			
			for (var i:int = 0; i < noRotatingDevices.length; i++) 
			{
				if(noRotatingDevices[i] == stateProxy.formFactor)	return true;
			}
			
			return false;
		}
	}
}
