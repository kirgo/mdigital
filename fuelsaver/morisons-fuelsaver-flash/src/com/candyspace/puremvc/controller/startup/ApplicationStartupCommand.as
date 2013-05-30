package com.candyspace.puremvc.controller.startup
{

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	import com.candyspace.puremvc.core.Notifications;

	/**
	 * @author 
	 */
	public class ApplicationStartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			// addSubCommand( RegisterCommandsCommand );
			// addSubCommand( ModelPrepCommand );
			// addSubCommand( ViewPrepCommand );

			sendNotification(Notifications.instance.GET_DEVICE_PROPERTIES);

			sendNotification(Notifications.instance.REGISTER_FSM);

			sendNotification(Notifications.instance.RETRIEVE_PERSISTENCE_DATA);
			
			/**
			 * it should be a connectionproxy loade type of notification
			 * then load views
			 */
			 //sendNotification(Notifications.instance.REGISTER_VIEW_FOR_STARTUP);
			 
			 
			 // initialize data actors connection...etc then whe data is available call
			 trace("sending INIT_LAYER_DISPLAY  ======================================= ....");
			 sendNotification(Notifications.instance.INIT_LAYER_DISPLAY);

			// sendNotification(Notifications.)
		}
	}
}
