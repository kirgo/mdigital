package 
{

	import com.candyspace.puremvc.mediator.tracer.TraceMediator;
	import com.candyspace.morrisonFuelSaver.controller.preloader.InjectEndpoinCommand;
	import com.candyspace.morrisonFuelSaver.controller.FSUserActionsCommand;
	import com.candyspace.morrisonFuelSaver.controller.calculator.AddCalculatorCategoryCommand;
	import com.candyspace.morrisonFuelSaver.controller.calculator.UpdateCalculatorCategoryValueCommand;
	import com.candyspace.morrisonFuelSaver.controller.fsm.FSClientActionCommand;
	import com.candyspace.morrisonFuelSaver.controller.fsm.FSInjectFSMCommand;
	import com.candyspace.morrisonFuelSaver.controller.fsm.FSServerActionCommand;
	import com.candyspace.morrisonFuelSaver.controller.fsm.FSServerResponseCommand;
	import com.candyspace.morrisonFuelSaver.controller.fsm.FSStateChangedCommand;
	import com.candyspace.morrisonFuelSaver.controller.preloader.FSPreloadCommand;
	import com.candyspace.morrisonFuelSaver.controller.preloader.FSViewsInitializedCommand;
	import com.candyspace.morrisonFuelSaver.core.FSApplicationLayers;
	import com.candyspace.morrisonFuelSaver.core.FSConstants;
	import com.candyspace.morrisonFuelSaver.core.FSNotifications;
	import com.candyspace.morrisonFuelSaver.core.FSSettings;
	import com.candyspace.morrisonFuelSaver.mediator.BackgroundMediator;
	import com.candyspace.morrisonFuelSaver.mediator.CalculatorIntroMediator;
	import com.candyspace.morrisonFuelSaver.mediator.CalculatorMediator;
	import com.candyspace.morrisonFuelSaver.mediator.CalculatorResultsMediator;
	import com.candyspace.morrisonFuelSaver.mediator.FSMenuMediator;
	import com.candyspace.morrisonFuelSaver.mediator.LocationEntryMediator;
	import com.candyspace.morrisonFuelSaver.mediator.LocationIntroMediator;
	import com.candyspace.morrisonFuelSaver.mediator.LocationResultsMediator;
	import com.candyspace.morrisonFuelSaver.mediator.RegistrationConfirmationMediator;
	import com.candyspace.morrisonFuelSaver.mediator.RegistrationEntryMediator;
	import com.candyspace.morrisonFuelSaver.mediator.RegistrationIntroMediator;
	import com.candyspace.morrisonFuelSaver.mediator.SharingIntroMediator;
	import com.candyspace.morrisonFuelSaver.mediator.SharingMediator;
	import com.candyspace.morrisonFuelSaver.mediator.TermsConditionsMediator;
	import com.candyspace.morrisonFuelSaver.mediator.view.CalculatorIntroView;
	import com.candyspace.morrisonFuelSaver.mediator.view.CalculatorResultsView;
	import com.candyspace.morrisonFuelSaver.mediator.view.CalculatorView;
	import com.candyspace.morrisonFuelSaver.mediator.view.FSMenuView;
	import com.candyspace.morrisonFuelSaver.mediator.view.LocationEntryView;
	import com.candyspace.morrisonFuelSaver.mediator.view.LocationResultView;
	import com.candyspace.morrisonFuelSaver.mediator.view.RegistrationEntryView;
	import com.candyspace.morrisonFuelSaver.mediator.view.SharingView;
	import com.candyspace.morrisonFuelSaver.mediator.view.SingleButtonView;
	import com.candyspace.morrisonFuelSaver.mediator.view.TermsConditionsView;
	import com.candyspace.morrisonFuelSaver.model.CalculatorProxy;
	import com.candyspace.morrisonFuelSaver.model.EmailProxy;
	import com.candyspace.morrisonFuelSaver.model.LocationProxy;
	import com.candyspace.morrisonFuelSaver.model.TrackingProxy;
	import com.candyspace.puremvc.core.AbstractEntryPointLogic;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.core.Settings;
	import com.candyspace.puremvc.facade.IAppFacade;
	import com.candyspace.puremvc.facade.WebAppFacade;
	import com.candyspace.puremvc.model.services.GoogleStaticMapProxy;
	import com.candyspace.puremvc.view.AbstractView;
	import com.candyspace.puremvc.view.TracerView;

	import org.puremvc.as3.multicore.utilities.statemachine.StateMachine;




	public class FuelSaverApp extends AbstractEntryPointLogic
	{
		// --------------------------------------
		// Properties - Views
		// --------------------------------------
		
		protected var _backgroundView:AbstractView;	
		
		protected var _menuView:FSMenuView;	
		
		protected var _calculatorView:CalculatorView;
		
		protected var _calculatorIntroView:CalculatorIntroView;
		
		protected var _registrationIntroView:SingleButtonView;
		
		protected var _locationIntroView:SingleButtonView;
		
		protected var _sharingIntroView:SingleButtonView;
		
		protected var _calculatorEntryView:SingleButtonView;
		
		protected var _locationEntryView:LocationEntryView;
		
		protected var _registrationEntryView:RegistrationEntryView;
		
		protected var _sharingView:SharingView;
		
		protected var _calculatorResultsView:CalculatorResultsView;
		
		protected var _locationResultsView:LocationResultView;
		
		protected var _termsConditionsView:TermsConditionsView;
		
		protected var _registrationConfimationView:SingleButtonView;
		
		protected var _tracerView:TracerView;
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function FuelSaverApp()
		{
			super();
		}
		
		// --------------------------------------
		// Methods - Overriden
		// --------------------------------------
		
		override protected function initNotifications():Notifications
		{
			return FSNotifications.instance;
		}

		override protected function initFacade():IAppFacade
		{
			return WebAppFacade.getInstance();
		}
		
		override protected function initCustomSettings():void
		{
			FSConstants.preloaderURL = "fuelsaver_preloader.swf";
			
			FSConstants.skinURL = "fuelsaver_skin.swf";
			
			FSConstants.configResouceURL = (_facade as IAppFacade).getParameter(FSConstants.BASE_URL_PARAMETER_NAME, FSConstants.BASE_URL_PARAMETER_DEFAULT_VALUE) + "/fuelsaver/services/config";
			
			FSConstants.SHARING_EMBED_CODE = updateSharingEmbedCode();
		}
		
		private function updateSharingEmbedCode():String
		{
			var baseUrl:String = (_facade as IAppFacade).getParameter(FSConstants.BASE_URL_PARAMETER_NAME, FSConstants.BASE_URL_PARAMETER_DEFAULT_VALUE);
			
			var urlParts:Array = FSConstants.SHARING_EMBED_CODE.split('{baseUrl}');
			return urlParts[0] + baseUrl + urlParts[1];
		}

		override protected function facadeInitialized():void
		{
			_facade.applicationLayers = FSApplicationLayers.instance.layersOrder;
		}
		
		
		override protected function initCustomCommands():void
		{
			super.initCustomCommands();
			
			_facade.replaceCommand(Notifications.instance.PRELOAD_APPLICATION, FSPreloadCommand);

			// register FSM commands
			_facade.replaceCommand(Notifications.instance.REGISTER_FSM, FSInjectFSMCommand);
			_facade.replaceCommand(FSNotifications.instance.SERVER_ACTION, FSServerActionCommand);
			_facade.replaceCommand(FSNotifications.instance.SERVER_RESPONSE, FSServerResponseCommand);
			_facade.replaceCommand(FSNotifications.instance.CLIENT_ACTION, FSClientActionCommand);
			_facade.replaceCommand(StateMachine.CHANGED, FSStateChangedCommand);
			
			_facade.registerCommand(FSNotifications.instance.USER_ACTION, FSUserActionsCommand);

			_facade.replaceCommand(Notifications.instance.VIEWS_INITIALIZED, FSViewsInitializedCommand);
			
			_facade.registerCommand(FSNotifications.instance.ADD_CALCULATOR_CATEGORY, AddCalculatorCategoryCommand);
			
			_facade.registerCommand(FSNotifications.instance.UPDATE_CALCULATOR_CATEGORY_VALUE, UpdateCalculatorCategoryValueCommand);		
			
			_facade.registerCommand(FSNotifications.instance.INJECT_ENDPOINT, InjectEndpoinCommand);		

			
				
		}

		override protected function initCustomViews():void
		{
			super.initCustomViews();
			
			_tracerView = new TracerView("tracerView");
			
			_backgroundView = new AbstractView("backgroundView", BackgroundDisplay);
			
			_menuView = new FSMenuView("menuView", MenuDisplay);
			
			// 1ST LEVEL VIEWS
			
			_calculatorIntroView = new CalculatorIntroView("calculatorIntroView", CalculatorIntroDisplay);
			
			_registrationIntroView = new SingleButtonView("registrationIntroView", RegistrationIntroDisplay);
			
			_locationIntroView = new SingleButtonView("locationIntroView", LocationIntroDisplay);
			
			_sharingIntroView = new SingleButtonView("sharingIntroView", SharingIntroDisplay);
			
			// 2ND LEVEL VIEWS
			
			_calculatorView = new CalculatorView("calculatorEntryView", CalculatorDisplay);
			
			_registrationEntryView = new RegistrationEntryView("registrationEntryView", RegistrationEntryDisplay);
			
			_locationEntryView = new LocationEntryView("locationEntryView", LocationEntryDisplay);
			
			_sharingView = new SharingView("sharingEntryView", SharingDisplay);
			
			// OTHER VIEWS
			
			_calculatorResultsView = new CalculatorResultsView("calculatorResultsView", CalculatorResultDisplay);
			
			_locationResultsView = new LocationResultView("locationResultsView", LocationResultsDisplay);
			
			_termsConditionsView = new TermsConditionsView("termsConditionsView", ConditionsDisplay);
			
			_registrationConfimationView = new SingleButtonView("registrationConfimationView", RegistrationConfirmationDisplay);

		}
		override protected function initCustomMediators():void
		{
			super.initCustomMediators();
			
			
			// PERSISTENT VIEWS MEDIATOR			
			
			_facade.registerMediator(new FSMenuMediator(_menuView));
			
			_facade.registerMediator(new BackgroundMediator(_backgroundView));
			
			// 1ST LEVEL MEDIATORS
			
			_facade.registerMediator(new CalculatorIntroMediator(_calculatorIntroView));
			
			_facade.registerMediator(new RegistrationIntroMediator(_registrationIntroView));
			
			_facade.registerMediator(new LocationIntroMediator(_locationIntroView));
			
			_facade.registerMediator(new SharingIntroMediator(_sharingIntroView));
			
			// 2ND LEVEL MEDIATORS
			
			_facade.registerMediator(new CalculatorMediator(_calculatorView));
			
			_facade.registerMediator(new RegistrationEntryMediator(_registrationEntryView));
			
			_facade.registerMediator(new LocationEntryMediator(_locationEntryView));
			
			_facade.registerMediator(new SharingMediator(_sharingView));
			
			// OTHER MEDIATORS
			
			_facade.registerMediator(new CalculatorResultsMediator(_calculatorResultsView));
			
			_facade.registerMediator(new LocationResultsMediator(_locationResultsView));
			
			_facade.registerMediator(new TermsConditionsMediator(_termsConditionsView));
			
			_facade.registerMediator(new RegistrationConfirmationMediator(_registrationConfimationView));			
			
			//_facade.registerMediator(new TraceMediator(_tracerView));			
		}
		
		override protected function initCustomProxies():void
		{
			super.initCustomProxies();
			
			_facade.registerProxy(new CalculatorProxy());
			
			_facade.registerProxy(new EmailProxy());
			
			_facade.registerProxy(new LocationProxy());
			
			_facade.registerProxy(new TrackingProxy());

			_facade.registerProxy(new GoogleStaticMapProxy());
		}
		
	}
}
