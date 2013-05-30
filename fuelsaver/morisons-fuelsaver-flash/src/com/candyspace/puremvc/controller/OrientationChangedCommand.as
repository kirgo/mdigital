package com.candyspace.puremvc.controller
{
//	import com.candyspacemedia.itvplayer.model.constants.TrackingConstants;
//	import com.candyspacemedia.itvplayer.model.StateProxy;
//	import com.candyspacemedia.itvplayer.model.TrackingProxy;
//	import com.candyspacemedia.itvplayer.model.constants.AppConstants;
//	import com.candyspacemedia.itvplayer.model.constants.Notifications;
//	import com.candyspacemedia.itvplayer.model.vo.tracking.TrackActionVO;
//	import com.candyspacemedia.itvplayer.view.ApplicationMediator;
//	import com.candyspacemedia.itvplayer.view.InitialViewMediator;
//	import com.candyspacemedia.itvplayer.view.MainViewLandscapeMediator;
//	import com.candyspacemedia.itvplayer.view.MainViewMediator;
//	import com.candyspacemedia.itvplayer.view.ProgrammeDetailViewMediator;
//	import com.candyspacemedia.itvplayer.view.SimpleMediator;
//	import com.candyspacemedia.itvplayer.view.VideoPlayerViewMediator;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class OrientationChangedCommand extends SimpleCommand {
		override public function execute(notification : INotification) : void 
		{
			var orientation : String = notification.getBody() as String;
			trace("orientation changed command ---------------------------", orientation);
//			
//			
//
//			var stateProxy : StateProxy = facade.retrieveProxy(StateProxy.NAME) as StateProxy;
//			if( orientation == stateProxy.orientation ){
//				return;
//			}else{
//				var trackingProxy : TrackingProxy = facade.retrieveProxy( TrackingProxy.NAME ) as TrackingProxy;
//				trackingProxy.setRotation( orientation );
//				if( orientation == AppConstants.ORIENTATION_PORTRAIT ){
//					sendNotification( Notifications.TRACK_ACTION, new TrackActionVO( TrackingConstants.ACTION_PORTRAIT ) );
//				}else{
//					sendNotification( Notifications.TRACK_ACTION, new TrackActionVO( TrackingConstants.ACTION_LANDSCAPE ) );
// 				}
//			}
//			
//			var appMediator : ApplicationMediator = facade.retrieveMediator( ApplicationMediator.NAME ) as ApplicationMediator;
//			appMediator.addBlanker();	 
//			
//			stateProxy.orientation = orientation;
//			
//			var viewToLoad : String;
//			
//			if (stateProxy.currentStateMediatorName == InitialViewMediator.NAME) {
//				// dont do anything
//			}
//
//			//IF We're coming from portrait
//			if (stateProxy.currentStateMediatorName == MainViewMediator.NAME || stateProxy.currentStateMediatorName == ProgrammeDetailViewMediator.NAME ) {
//				if( stateProxy.formFactor == AppConstants.SCREEN_SIZE_SMALL ){
//					viewToLoad = AppConstants.VIEW_PROGRAMME_DETAIL;
//				}else{
//					viewToLoad = AppConstants.VIEW_MAIN_LANDSCAPE;
//					/*if( stateProxy.currentStateMediatorName == MainViewMediator.NAME  ){
//						//sendNotification(AppConstants.HIDE_TOP_LEVEL_CAROUSEL);
//					}*/
//				}
//			}
//			
//			//If We're Coming From Landscape
//			var landscapeMediator : MainViewLandscapeMediator = facade.retrieveMediator( MainViewLandscapeMediator.NAME ) as MainViewLandscapeMediator;
//			if (stateProxy.currentStateMediatorName == MainViewLandscapeMediator.NAME) {
//				if( landscapeMediator ){
//					if( landscapeMediator.currentViewLevel > 2 ){
//						viewToLoad = AppConstants.VIEW_PROGRAMME_DETAIL;
//					}else{
//						viewToLoad = AppConstants.VIEW_MAIN;
//					}
//				}
//			}
//			
//			if (stateProxy.currentStateMediatorName == SimpleMediator.NAME) {
//				var simpleMediator : SimpleMediator = facade.retrieveMediator(SimpleMediator.NAME) as SimpleMediator;
//				if (simpleMediator) {
//					simpleMediator.updateViewWidth();
//				}
//			}
//
//			if (stateProxy.currentStateMediatorName == VideoPlayerViewMediator.NAME) {
//				viewToLoad = null;
//			}
//			
//			if (viewToLoad) {
//				sendNotification(Notifications.LOAD_VIEW, viewToLoad);
//			}
//			
		}
	}
}