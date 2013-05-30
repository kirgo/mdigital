// // ////////////////////////////////////////////////////////////////////////////
//
// CANDYMEDIA
// Copyright 2012 CANDYMEDIA
// All Rights Reserved.
//
// NOTICE: You may not use, distribute or modify this document without the
// written permission of its copyright owner
//
// // ////////////////////////////////////////////////////////////////////////////
package com.candyspace.puremvc.core.layers
{

	import com.candyspace.puremvc.core.layers.transitions.ILayersTransition;
	import com.candyspace.puremvc.core.Notifications;
	import com.candyspace.puremvc.core.layers.vo.LayerChildVO;
	import com.candyspace.puremvc.core.layers.IApplicationLayers;
	import com.candyspace.puremvc.events.ViewEvent;
	import com.candyspace.puremvc.facade.AppFacade;
	import com.candyspace.puremvc.view.IView;
	import com.candyspace.puremvc.view.Layer;
	import com.candyspace.puremvc.view.Root;
	import com.greensock.TweenLite;

	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

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
	public class ApplicationLayersMediator extends Mediator implements IMediator
	{
		//--------------------------------------
        // Properties - PUBLIC
        //--------------------------------------
    
        /**
		 * Returns the full name of the mediator (including packages to insure that the name is unique).
		 */
		public static function get NAME():String
		{
			return getQualifiedClassName(ApplicationLayersMediator);
		}
		
		//--------------------------------------
        // Properties - PRIVATE
        //--------------------------------------
		
        /**
		 * Method used to get a reference to the view attached to the current mediator. Apart from the 
		 * viewComponent property, this getter returns a reference already casted to the view type.
		 */
		private function get view():ApplicationLayers
		{
			return viewComponent as ApplicationLayers;
		}
		
        /**
         * Holder for the layers.
         */
		private var _root:Root;
		
		/**
         * Vector of objects that contain references to all the application masks that are currently
         * added in any of the application layers.
         * 
         * Each object has the following properties:
         *      - mask : DisplayObject - reference to the mask display object.
         *      - child : DisplayObject - refernce to the child that uses the current mask to block
         * other user actions on the other application components.
         *      - removeChildOnClick : Boolean - flag that will be used to determin if the associated
         * child will be removed when the user clicks on the mask display object.
         */
        private var _masks:Vector.<Object>;
		
		private var _childsVector:Vector.<LayerChildVO>;
		
		private var _layerChildrenList:Dictionary = new Dictionary();
		
		private var _displayedLayers:Vector.<String> = new Vector.<String>();
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		public function ApplicationLayersMediator(viewComponent:Object = null)
		{
			super(NAME, viewComponent);
            
            if (!(viewComponent is IApplicationLayers))
            {
				throw new Error("Expected a view component of type: " + getQualifiedClassName(IApplicationLayers));
            }
            
           // initView();
		}
		//--------------------------------------
        //  Methods - Init
        //--------------------------------------
        
		
		override public function onRegister():void
		{
			
			super.onRegister();
			initView();
			trace("=================  This mediator has been registered :: \t", NAME);
		}
        /**
		 * Method called when the INIT_VIEWS notification is received. Initializes the view and the mediator.
		 */
		private function initView():void
		{
			_root = new Root("root", (facade as AppFacade).application);
            _root.init();
            
			var layers:Array = (facade as AppFacade).applicationLayers;
			
            if (!layers || layers.length == 0)
            {
                throw new Error(getQualifiedClassName(this) + "::initView - application layers not defined in game facade.");
            }
            
			view.addEventListener(ApplicationLayersEvent.ADD_LAYER, onAddLayer);
			view.addEventListener(ApplicationLayersEvent.REMOVE_LAYER, onRemoveLayer);
            
			var layerMouseEnabled:Boolean;
			var layerName:String; 
            // register the initial layers
			for (var i:int = 0; i < layers.length; i++) 
			{
				layerMouseEnabled = layers[i].mouseEnabled;
				layerName = layers[i].name;
				
				_layerChildrenList[layerName] = new Vector.<Object>();
				
                view.registerLayerAt(
                                        (layers[i].name as String), 
                                        i, 
                                        (layers[i].addToStage as Boolean)
                                    );
									
				if (layers[i].hasOwnProperty("mouseEnabled"))
				{
					var layer:DisplayObjectContainer = view.getHolder(layerName);
					layer.mouseEnabled = layerMouseEnabled;
				}
			}
			
            // initialize the masks vector
            //_masks = new Vector.<Object>();
			
			_childsVector = new Vector.<LayerChildVO>();
		}
		
		//--------------------------------------
        //  Methods - OVERRIDDEN
        //--------------------------------------
		
        /**
		 * List of notifications that will be handled in the current mediator.
		 * @return Array that contains the name of all the notifications.
		 */
		override public function listNotificationInterests():Array 
		{
			return [
						Notifications.instance.ADD_VIEW,
						Notifications.instance.ADD_UNIQUE_VIEW,
						Notifications.instance.REMOVE_VIEW,
						Notifications.instance.REGISTER_VIEW_FOR_STARTUP,
						Notifications.instance.INIT_LAYER_DISPLAY,
						Notifications.instance.VIEW_ADDED
				   ];
				   /*
				   	Notifications.instance.ADD_VIEW,
					Notifications.instance.REMOVE_VIEW,
					Notifications.instance.APPLICATION_LAYERS_TRANSITION,
                    Notifications.instance.VIEWS_INITIALIZED,
                    Notifications.instance.STORE_SETTINGS_LOCAL,
                    Notifications.instance.ENABLE_USER_INTERACTION,
                    Notifications.instance.RESIZE,
					Notifications.instance.ADJUST_FRAME_RATE
				  */
		}
		override public function handleNotification(notification:INotification):void 
		{
			trace("========== application layer mediator notification", notification.getName());
			var addingToStage:Boolean = true;
			
			switch (notification.getName())
			{
				case Notifications.instance.REGISTER_VIEW_FOR_STARTUP:
				{
					trace("ApplicationLayerMediator :: Register View for Startup:", notification.getBody(), "--", notification.getType());
					addView(notification.getBody(), notification.getType(), !addingToStage);
					break;
				}
				case Notifications.instance.VIEW_ADDED:
				{
					trace("> ApplicationLayerMediator :: View Added:", notification.getBody(), "--", notification.getType());
					//addView(notification.getBody(), notification.getType(), addingToStage);
					onChildViewInitialized(notification);
					break;
				}
				case Notifications.instance.INIT_LAYER_DISPLAY:
				{
					trace("> ApplicationLayerMediator :: Init Layer Display:", notification.getBody(), "--", notification.getType());
					initStartupDisplay();
					break;
				}
				case Notifications.instance.ADD_VIEW:
				{
					trace("> ApplicationLayerMediator :: adding view:", notification.getBody(), "--", notification.getType());
					addView(notification.getBody(), notification.getType(), addingToStage);
					break;
				}
				case Notifications.instance.REMOVE_VIEW:
				{
					//removeView(notification.getBody().child, retrieveAssociatedMaskObject(notification.getBody().child));
					removeView(notification.getBody().child);
					break;
				}
				case Notifications.instance.ADD_UNIQUE_VIEW:
				{
					//removeView(notification.getBody().child, retrieveAssociatedMaskObject(notification.getBody().child));
					removeLayerChildren(notification.getType());
					addView(notification.getBody(), notification.getType())
					break;
				}
				
			}
		}
		// --------------------------------------
		// Methods - Public
		// --------------------------------------
		
		//--------------------------------------
        //  Methods - PRIVATE
        //--------------------------------------
		
		/**
		 * Add a new layer to the application.
		 * @param	container The layer holder, that will be added to stage.
		 */
		public function addLayer(container:DisplayObjectContainer, depth:int = -1):void
		{
			try
			{
				if (depth < 0 || depth > _root.holder.numChildren)
				{
					//(_root.holder as IVisualElementContainer).addElement(container as IVisualElement);
					(_root.holder as DisplayObjectContainer).addChild(container as DisplayObject);
				}
				else
				{
					//(_root.holder as IVisualElementContainer).addElementAt(container as IVisualElement, depth);
					(_root.holder as DisplayObjectContainer).addChildAt(container as DisplayObject, depth);
				}
			}
			catch (error:Error)
			{
				trace(getQualifiedClassName(this) + "::addLayer - could not add new layer. Reason: " + error.message);
			}
		}
        
         /**
          * Add the child supplied as a paramter, to the desired layer. If the layer is not found in 
		  * the layers list, add the child in the uppermost layer.
          * 
          * @param	child The child that will be added.
          * @param	layerName The name of the layer on which the child will be added.
          * @param	tween The tween that will be played after the child is added to the stage.
          * @param	addApplicationMask Flag used to determine if a mask that will cover all the application 
          * (only the layers that are under the layer into which the chlid will be added), will be added, or
          * not.
          * @param	removeChildOnClick Only taken into account if the 'addApplicationMask' parameter is set 
          * to true. If so, this flag adds the possibility to remove the child and, of course, the application
          * mask that is associated with it, when the user clicks on the mask.
          */
         
        /**
         * Add the child supplied as a paramter, to the desired layer. If the layer is not found in 
		  * the layers list, add the child in the uppermost layer.
         * 
         * @param	childObject Object that can contain the following properties:
         * 
         *      - tween: TweenLite - The tween that will be played after the child is added to the stage.
         * 
         *      - addApplicationMask: Boolean - Flag used to determine if a mask that will cover all the 
         * application (only the layers that are under the layer into which the chlid will be added), will
         * be added, or not.
         * 
         *      - removeChildOnClick: Boolean - Only taken into account if the 'addApplicationMask' parameter
         * is set to true. If so, this flag adds the possibility to remove the child and, of course, the 
         * application mask that is associated with it, when the user clicks on the mask.
          * 
         * @param	layerName The name of the layer on which the child will be added.
         */
		private function addView(childObject:Object, layerName:String, addingToStage:Boolean = true):void
		{
			// initial checks
            if (!childObject.child)
            {
                //Logger.error(getQualifiedClassName(this) + "::addView - no child was supplied. Method will not execute. childObject: {" + childObject + "}, layer: {" + layerName + "}");
                trace(getQualifiedClassName(this) + "::addView - no child was supplied. Method will not execute. childObject: {" + childObject + "}, layer: {" + layerName + "}");
                return;
            }
			
			if (!layerName)
			{
				// if the layer name is not supplied, get the uppermost layer
				layerName = view.layers[view.layers.length - 1];
			}
			
			if (!(childObject.child is IView))
            {
                childObject.child = new Layer("Layer" + childObject.child.name + Math.floor(Math.random() * 1000), childObject.child);
                childObject.child.init();
            }

			Vector.<Object>(_layerChildrenList[layerName]).push(childObject);
						
			if(addingToStage)
			{
				if(isLayerVisible(layerName))
				{
					addDisplay(childObject, layerName);
				}
			}
			
			trace("adding layer..... ", layerName, childObject.child.name);
		}
		
		private function isLayerVisible(layerName:String):Boolean
		{
			for (var i:int = 0; i < _displayedLayers.length; i++) 
			{
				if(_displayedLayers[i] == layerName)
				{
					return true;
				}				
			}
			return false;
		}
		
		private var _viewInitizalionQueueNum:int;
		private function initStartupDisplay():void
		{
			trace(">> ApplicationLayerMediator :: initStarupDisplay :: displayed layers : ", _displayedLayers.length);
			_viewInitizalionQueueNum = 0;
			
			for (var i:int = 0; i < _displayedLayers.length; i++) 
			{
				var layerName:String = _displayedLayers[i];
				
				initLayerDisplay(layerName);						
			}	
		}
		              
		private function initLayerDisplay(layerName:String):void
		{

			var layerChildren:Vector.<Object> = _layerChildrenList[layerName];
			
			trace("\n\n>> ApplicationLayerMediator :: initLayerDisplay :: layer:" , layerName, "\t\tchildren: ", layerChildren.length);
			
			for (var j:int = 0; j < layerChildren.length; j++) 
			{
					var child:IView = layerChildren[j].child;
					if(!child.isInitialized)
					{
						initChildView(child,layerName);
					}
			}
		}
		
		
		private function removeLayerChildren(layerName:String):void
		{
			var layerChildren:Vector.<Object> = _layerChildrenList[layerName];
			
			for (var j:int = 0; j < layerChildren.length; j++) 
			{
					var child:IView = layerChildren[j].child;
					
					removeViewDisplay(child);
			}
			
		}
		
		private function initChildView(view:IView, layerName:String):void
		{			
			//view.addEventListener(ViewEvent.INITIALIZED, onChildViewInitialized);
			//view.init();
			trace(">> ApplicationLayerMediator :: initChildView:", view.name, " -- ", layerName);
			sendNotification(Notifications.instance.INIT_VIEW, view, layerName);
			_viewInitizalionQueueNum++;
		}
		
		private var initialized:Boolean = false;
		
		private function onChildViewInitialized(note:INotification):void
		{
			trace(">> ApplicationLayerMediator :: onChildViewInitialized :: view remaining to init ", _viewInitizalionQueueNum);
			//event.target.removeEventListener( ViewEvent.INITIALIZED, onChildViewInitialized );
			//addDisplay(event.target);
			var view:IView = note.getBody() as IView;
			var childObject:Object = getChildObject(view);
			var layerName:String = note.getType() as String;
			
			trace(">> ApplicationLayerMediator :: onChildViewInitialized :: local values: ", view.name, childObject, layerName);
			addDisplay(childObject, layerName);
			
			_viewInitizalionQueueNum--;
			
			// if initialazed send some notation (also create var)
			if(_viewInitizalionQueueNum == 0)
			{
				// after setup process only
				if(!initialized)
				{
					initialized = true;
					sendNotification(Notifications.instance.VIEWS_INITIALIZED);
				}
				
				// after a layer has been added
				if(!isLayerVisible(layerName))
				{
					transitionAddLayer(layerName);
				}
				
			}
		}
		
		private function getChildObject(view:IView):Object
		{
			for each (var viewVector:Object in _layerChildrenList)
			{
				var viewObjects:Vector.<Object> = viewVector as Vector.<Object>;

				for (var i:int = 0; i < viewObjects.length; i++)
				{
					var child:IView = viewObjects[i].child as IView;
					if (child == view)
					{
						return viewObjects[i];
					}
				}
			}
			return null;
		}

		private function onChildViewInitialized0(event:ViewEvent = null):void
		{
			event.target.removeEventListener( ViewEvent.INITIALIZED, onChildViewInitialized );
			addDisplay(event.target);
			_viewInitizalionQueueNum--;
			
			if(_viewInitizalionQueueNum == 0)
			{
				
			}
		}
		
		
		
		private function addDisplay(childObject:Object, layerName:String = null):void
		{
			// after view initialization layerName is not provided and childObject is just a iview(wrapper... etc not present)
			if(layerName == null)
			{
				
			}
			
            var child:IView;// = childObject.child as IView;
			
            if (childObject.child is IView)
            {
                child = childObject.child;
            }
            else
            {
                child = new Layer("Layer" + childObject.child.name + Math.floor(Math.random() * 1000), childObject.child);
                child.init();
            }


			if(!child.isInitialized)
			{
				initChildView(child, layerName);
				return;
			}
            
            
            _root.addView(child);
            
            var tween:TweenLite = childObject.tween;
            
            var addApplicationMask:Boolean;
            if (childObject.addApplicationMask)
            {
                addApplicationMask = childObject.addApplicationMask;
            }
            else
            {
                addApplicationMask = false;
            }
            
            var removeChildOnClick:Boolean;
            if (childObject.hasOwnProperty("removeChildOnClick"))
            {
                removeChildOnClick = childObject.removeChildOnClick;
            }
            else
            {
                removeChildOnClick = true;
            }
            
			// retrieve the holder for that layer
			var displayObjectContainer:DisplayObjectContainer = view.getHolder(layerName) || view.getHolderAt(view.layers.length - 1);
			
            //Logger.debug("ApplicationLayersMediator::addView -> Adding " + child + " to " + layerName);
            trace("ApplicationLayersMediator::addView -> Adding " + child.display + " to " + layerName);
			
            if (displayObjectContainer)
			{
				try
				{
					var mask:DisplayObject;
					var addedChild:DisplayObject;
					var wrapperObject:DisplayObjectContainer;
					//var maskWrapper:SpriteVisualElement;
					var maskWrapper:Sprite;
					var index:int;
					
					// test if the view was already added to the stage
					index = retrieveChildIndex(child.display);
					
					if (index > 0)
					{
						// if the view was already added
						// then remove the previous and add it again.
						removeViewDisplay(childObject)//, _childsVector[index].child);
						//Logger.warning(getQualifiedClassName(this) + "::addView - The view " + childObject + " was already added! So was removed and added again to the new layer!");
						trace(getQualifiedClassName(this) + "::addView - The view " + childObject + " was already added! So was removed and added again to the new layer!");
					}
					/*
                    if (addApplicationMask)
                    {
                        mask = createMask(removeChildOnClick);
                       
                        maskWrapper = new SpriteVisualElement();
						maskWrapper.addChild(mask);
                    }
                     * 
                     */
                    
					//if (child.display as IVisualElement)
					if (child.display as DisplayObject)
					{
						addedChild = child.display;
						
						if (maskWrapper)
						{
							// if a mask should be added and the child is a IVisualElement
							// then the wrapper and the child will be added in a new wrapper
							// ( a group object).
							
							//wrapperObject = new Group();
							//(wrapperObject as IVisualElementContainer).addElement(maskWrapper as IVisualElement);
							//(wrapperObject as IVisualElementContainer).addElement(addedChild as IVisualElement);
						}
					}
					else
					{
						/*
						wrapperObject = new SpriteVisualElement();
						if (mask)
						{
							wrapperObject.addChild(mask);
						}
						wrapperObject.addChild(child.display);
						 * 
						 */
						
						addedChild = child.display;
					}
                    
					if (wrapperObject)
					{
						//DisplayObjectUtil.instance.addChild(displayObjectContainer, wrapperObject);
					}
					else
					{
						//DisplayObjectUtil.instance.addChild(displayObjectContainer, addedChild);
						trace("adding child > > > > > > > > > > > > > > > > > > > > > ", displayObjectContainer.parent.x, displayObjectContainer.x, displayObjectContainer.y);
						trace("adding child > > > > > > > > > > > > > > > > > > > > > ", addedChild.parent, addedChild.width, addedChild.height);
						trace("adding child > > > > > > > > > > > > > > > > > > > > > ", addedChild.parent, addedChild.scaleX, addedChild.scaleY);
						trace("adding child > > > > > > > > > > > > > > > > > > > > > ", displayObjectContainer.stage.width, displayObjectContainer.stage.height);
						displayObjectContainer.addChild(addedChild);
					}
					
					_childsVector.push(new LayerChildVO(addedChild, wrapperObject, mask, removeChildOnClick));
					
					
					(child as IEventDispatcher).dispatchEvent(new ViewEvent(ViewEvent.ADDED));
					
                    if (tween)
                    {
                        tween.play();
                    }
                    
				}
				catch (error:Error)
				{
					//Logger.warning(getQualifiedClassName(this) + "::addView - could not add child: " + getQualifiedClassName(child.display) + ". Reason: " + error.message);
					trace(getQualifiedClassName(this) + "::addView - could not add child: " + getQualifiedClassName(child.display) + ". Reason: " + error.message);
				}
			}
			else
			{
				//Logger.warning(getQualifiedClassName(this) + "::addView - could not retrieve holder.");
				trace(getQualifiedClassName(this) + "::addView - could not retrieve holder.");
			}
		}
		
		
		
		/**
		 * Remove the child supplied as a parameter.
		 * @param	child The display object to be removed.
		 */
		private function removeView(child:Object):void
		{
			var layerName:String;

			for (var i:int = 0; i < _displayedLayers.length; i++)
			{
				layerName = _displayedLayers[i];
				var layerChildren:Vector.<Object> = _layerChildrenList[layerName];

				for (var j:int = 0; j < layerChildren.length; j++)
				{
					var childView:IView = layerChildren[j].child;
					var childDisplay:DisplayObject = childView.display;
					trace("=============", child, childView, childDisplay)

					if (child == childDisplay)
					{
						layerChildren.splice(i, 1);
						if(isLayerVisible(layerName))
						{
							removeViewDisplay(childView);							
						}
					}
				}
			}
		}
	
	
		private function removeViewDisplay(child:Object):void
		{
			
			trace("------")
            if (child is IView)
            {
                child = (child as IView).display;
            }
            
			try
			{
				
				var index:int = retrieveChildIndex(child as DisplayObject);
				
				if (index >= 0 && _childsVector[index])
				{
					if (_childsVector[index].wrapper)
					{
						//DisplayObjectUtil.instance.removeChild(_childsVector[index].wrapper.parent, _childsVector[index].wrapper, DisplayObjectUtil.THROW_LOG);
						_childsVector[index].wrapper.parent.removeChild(_childsVector[index].wrapper);
						//DisplayObjectUtil.instance.removeChild(_childsVector[index].wrapper, _childsVector[index].child, DisplayObjectUtil.THROW_LOG);
						_childsVector[index].wrapper.removeChild(_childsVector[index].child);
					}
					else
					{
						//DisplayObjectUtil.instance.removeChild((_childsVector[index].mask.parent as DisplayObjectContainer), _childsVector[index].mask, DisplayObjectUtil.THROW_LOG);
						//(_childsVector[index].mask.parent as DisplayObjectContainer).removeChild(_childsVector[index].mask);
						//DisplayObjectUtil.instance.removeChild((child.parent as DisplayObjectContainer), child as DisplayObject, DisplayObjectUtil.THROW_LOG);
						trace("=== ", (child.parent as DisplayObjectContainer), (child as DisplayObject));
						(child.parent as DisplayObjectContainer).removeChild(child as DisplayObject);
					}
					
					_childsVector.splice(index, 1);
				}
			}
			catch (error:Error)
			{
				/*
				Logger.warning(
									getQualifiedClassName(this) + "::removeView - could not remove display object: " 
									+ getQualifiedClassName(child) + ". Reason: " + error.message
							  );
			   * 
			   */
				trace(
									getQualifiedClassName(this) + "::removeView - could not remove display object: " 
									+ getQualifiedClassName(child) + ". Reason: " + error.message
							  );
			}
			
			trace("child to be removed", child);
			
			(child as DisplayObject).dispatchEvent(new ViewEvent(ViewEvent.REMOVED));
		}
		
		
        /**
         * Method used to execute a transition between one or more application layers.
         * @param	transitionObject Object that holds the following properties:
         * 
		 * 		- isReversed : Boolean - Flag used to determine if the normal or reversed transition will be 
		 * done. If true, the normal one will be selected, otherwise, the reversed transition will be applied.
		 * 		- transition : ILayersTransition - instance of a class  that implements the IlayersTransition
		 * interface. This instance will be used to make the actual transition;
		 * 
		 * If either one of the two arrays (transitionOutLayers and transitionInLayers properties from the object) 
		 * are missing, the ApplicationLayersMediator will assume that the layers references were already setted
		 * in the 'transition' instance.
		 * 
		 * If 'isReversed' property is mising, its default value will be considered 'false'. 
         */
		private function doTransition(transitionObject:Object):void
		{
			var transition:ILayersTransition;
			
			if (!transitionObject.hasOwnProperty("transition"))
			{
				return;
			}
			else
			{
				transition = transitionObject["transition"] as ILayersTransition;
			}
			
            // add the needed listeners
            transition.addEventListener(ApplicationLayersEvent.TRANSITION_STARTED, onTransitionStart);
            transition.addEventListener(ApplicationLayersEvent.TRANSITION_COMPLETE, onTransitionComplete);
            transition.addEventListener(ApplicationLayersEvent.ADD_LAYER_TO_STAGE, onTransitionAddLayer);
            transition.addEventListener(ApplicationLayersEvent.REMOVE_LAYER_FROM_STAGE, onTransitionRemoveLayer);
            
			var transitionInLayers:Array = null;
			var transitionOutLayers:Array = null;
			var isReversed:Boolean = false;
			
			// iterator
			var i:int;
			var arr:Array;
			
            // search for the needed properties within the transition;
            
			if (transition.transitionOutLayersNames)
			{
				arr = transition.transitionOutLayersNames;
				
				if (arr)
				{
					transitionOutLayers = [];
					for (i = 0; i < arr.length; i++)
					{
						transitionOutLayers.push(view.getHolder(arr[i]));
					}
				}
			}
			else
			{
				//Logger.warning(getQualifiedClassName(this) + ".Empty transitionIn array. ");
				trace(getQualifiedClassName(this) + ".Empty transitionIn array. ");
				return ;
			}
			
			if (transition.transitionInLayersNames)
			{
				arr = transition.transitionInLayersNames;
				
				if (arr)
				{
					transitionInLayers = [];
					for (i = 0; i < arr.length; i++)
					{
						transitionInLayers.push(view.getHolder(arr[i]));
					}
				}
			}
			else
			{
				//Logger.warning(getQualifiedClassName(this) + ".Empty transitionOut array. ");
				trace(getQualifiedClassName(this) + ".Empty transitionOut array. ");
				return ;
			}
			
			if (transitionObject.hasOwnProperty("isReversed"))
			{
				isReversed = transitionObject["isReversed"] as Boolean;
			}
			
            // set the transition details
			transition.setLayers(transitionInLayers, transitionOutLayers);
			
            // do the actual transition
			if (!isReversed)
			{
				transition.doTransition();
			}
			else 
			{
				transition.undoTransition();
			}
		}
        
        /**
         * Creates a new mask display object that will cover the entire application. Also adds an
         * event listener, if 'addClickEvent' parameter is set to true.
         * 
         * @param	addClickEvent Flag used to determine if an event listener will be added to the
         * msak display object. If it will be added, the mask will be removed on the first click
         * action.
         * 
         * @return The newly created mask display object.
         */
        private function createMask(addClickEvent:Boolean = false):DisplayObject
        {
            var mask:Sprite = new Sprite();
            
            mask.graphics.beginFill(0x000000, 0.5);
            //mask.graphics.drawRect(-2000, 0, Settings.getVar("STAGE_WIDTH") + 4000, Settings.getVar("STAGE_HEIGHT") + 2000);
            mask.graphics.endFill();
            
            if (addClickEvent)
            {
                mask.addEventListener(MouseEvent.MOUSE_DOWN, onMaskClick, false, 0, true);
            }
            
            return mask;
        }
        
        /**
         * Method used to retrieve a mask object, from the '_masks' vector. This method searches
         * for the first mask object whose mask reference is the same as the reference received
         * as a parameter.
         * 
         * @param	mask Reference to the mask that will be used to compare the references.
         * 
         * @return The reference to the mask object that has the same mask reference as the one 
         * received as a paramter, or null, if no mask object that matches this condition is
         * found with the vector.
         */
        private function retrieveChildObject(mask:DisplayObject):LayerChildVO
        {
            var childVO:LayerChildVO;
            
            if (mask && _masks)
            {
                for (var i:int = 0; i < _childsVector.length; i++) 
                {
                    if (_childsVector[i].mask == mask)
                    {
                        childVO = _childsVector[i];
                        break;
                    }
                }
            }
            
            return childVO;
        }
        
        /**
         * Method used to retrieve a mask object, from the '_masks' vector. This method searches
         * for the first mask object whose 'child' reference is the same as the reference received
         * as a parameter.
         * 
         * @param	child Reference to the child that will be used to compare the references.
         * 
         * @return The reference to the mask object that has the same child reference as the one 
         * received as a paramter, or null, if no mask object that matches this condition is
         * found with the vector.
         */
        private function retrieveAssociatedMaskObject(child:Object):Object
        {
            var maskObject:Object;
			
			if (child is IView)
			{
				child = (child as IView).display;
			}
            
			/*
            if (child && _masks)
            {
                for (var i:int = 0; i < _masks.length; i++) 
                {
                    if (_masks[i]["child"] == child)
                    {
                        maskObject = _masks[i];
                        break;
                    }
                }
            }
            */
			
			var index:int = retrieveChildIndex(child as DisplayObject);
			if (index > 0 && _childsVector[index])
			{
				maskObject = { mask: _childsVector[index] };
			}
			
            return maskObject;
        }
        
        /**
         * Remove the mask object from the vector and the mask and child (depending on the state
         * of the 'removeChildOnClick' flag.
         * 
         * @param	maskObject Mask object that will be deleted.
         */
        private function removeMaskObject(maskObject:LayerChildVO):void
        {
            if (maskObject)
            {
                if ((maskObject.removeChildOnClick))
                {
					// TODO: uncomment
                    //removeView(maskObject.child, maskObject.mask);
                }
                else
                {
                    var mask:DisplayObject = maskObject.mask;
					mask.parent.removeChild(mask);
                }
                
                _masks.splice(_masks.indexOf(maskObject), 1);
            }
        }
		
		private function retrieveChildIndex(child:DisplayObject):int 
		{
			var index:int = -1;
			for (var i:int = 0; i < _childsVector.length; i++)
			{
				if (_childsVector[i].child == child)
				{
					index = i;
					break;
				}
			}
			
			return index;
		}
		
		protected function getLayerChildrenList(layerName:String):Vector.<IView>
		{
			return _layerChildrenList[layerName] as Vector.<IView>;
		}
		
		protected function destroyLayerChildren(layerName:String):void
		{
			var layerChildrenViews:Vector.<IView> = _layerChildrenList[layerName];
			
			for (var i:int = 0; i < layerChildrenViews.length; i++) 
			{
				layerChildrenViews[i].destroyDisplay();
			}
			
			//_layerChildrenList[layerName] = new Vector.<IView>;
		}
		
		protected function initLayerChildrenDisplay(layerName:String):void
		{
			var layerChildrenViews:Vector.<IView> = _layerChildrenList[layerName];
			
			for (var i:int = 0; i < layerChildrenViews.length; i++) 
			{
				
				//layerChildrenViews[i].initDisplay();
			}
		}
		
		
		//--------------------------------------
        //  Methods - HANDLERS
        //--------------------------------------
		
        /**
         * Add a new layer to the stage.
         * @param	event ApplicationLayersEvent instance.
         */
		private function onAddLayer(event:ApplicationLayersEvent):void 
		{
			var layerIndex:int = view.layers.indexOf(event.layerName);
			
			var depth:int;
			
			if (layerIndex != -1)
			{
				// the newly added layer was found
				try
				{
					if (layerIndex == 0)
					{
						// add the child at the bottom of the list
						depth = 0;
					}
					else if (layerIndex == view.layers.length - 1)
					{
						// add the child add the highest possible depth
						depth = -1;
					}
					else
					{
						// find the next holder
						var nextLayerHolder:DisplayObjectContainer = view.getHolderAt(layerIndex + 1);
						// determine the actual depth of the next holder, and set the depth of the new layer to this
						depth = _root.holder.getChildIndex(nextLayerHolder);
					}
					
					addLayer(event.layerHolder, depth);
					//--
					_displayedLayers.push(event.layerName);
				}
				catch (e:Error)
				{
					//Logger.warning(getQualifiedClassName(this) + "::onAddLayer - could not add the new layer. Reason: " + e.message);
					trace(getQualifiedClassName(this) + "::onAddLayer - could not add the new layer. Reason: " + e.message);
				}
			}
		}
		
        /**
         * Removes a layer from the stage.
         * @param	event ApplicationLayersEvent instance.
         */
		private function onRemoveLayer(event:ApplicationLayersEvent):void 
		{
			removeViewDisplay(event.layerHolder);
			
			for (var i:int = 0; i < _displayedLayers.length; i++) 
			{
				if(_displayedLayers[i] == event.layerName)
				{
					_displayedLayers.splice(i, 1);
					break;
				}
				
			}
		}
        /**
         * Method called when a new layers transition starts.
         * @param	event ApplicationLayersEvent instance.
         */
        private function onTransitionStart(event:ApplicationLayersEvent):void 
        {
            sendNotification(
                                Notifications.instance.LAYERS_TRANSITION_ACTION,
                                null,
                                'start'
                            );
        }
        
        /**
         * Method called when a layers transition has finished.
         * @param	event ApplicationLayersEvent instance.
         */
        private function onTransitionComplete(event:ApplicationLayersEvent):void 
        {
            var transition:ILayersTransition = event.currentTarget as ILayersTransition;
            
            // remove the listeners from the current transition
            transition.removeEventListener(ApplicationLayersEvent.TRANSITION_STARTED, onTransitionStart);
            transition.removeEventListener(ApplicationLayersEvent.TRANSITION_COMPLETE, onTransitionComplete);
            //transition.removeEventListener(ApplicationLayersEvent.ADD_LAYER_TO_STAGE, onTransitionAddLayer);
            //transition.removeEventListener(ApplicationLayersEvent.REMOVE_LAYER_FROM_STAGE, onTransitionRemoveLayer);
            
            sendNotification(
                                Notifications.instance.LAYERS_TRANSITION_ACTION,
                                null,
                                'complete'
                            );
        }
        
        /**
         * Method called when a layers transition requests to add a layer to the stage.
         * @param	event ApplicationLayersEvent instance.
         */
        private function onTransitionAddLayer(event:ApplicationLayersEvent):void 
        {
            if (!event.layer)
            {
                //Logger.error(getQualifiedClassName(this) + "::onTransitionAddLayer - cannot add a null reference to the stage.");
                trace(getQualifiedClassName(this) + "::onTransitionAddLayer - cannot add a null reference to the stage.");
                return;
            }
			
			var layerName:String = view.getHolderName(event.layer);
			
			initLayerDisplay(layerName);
		}
         private function transitionAddLayer(layerName:String):void
		 {  
			var layer:DisplayObjectContainer = view.getHolder(layerName);
            // retrieve all the layers under the current one
            var layersUnder:Array = view.getHoldersUnder(layer);
            
            var addToDefaultIndex:Boolean = true;
            
            if (layersUnder && layersUnder.length != 0)
            {
                var currentLayer:DisplayObjectContainer;
                
                var len:uint = layersUnder.length - 1;
                for (var i:int = len; i >= 0; i--) 
                {
                    currentLayer = Object(layersUnder[i]).container;
                    
                    if (_root.holder.contains(currentLayer))
                    {
						_root.holder.addChildAt(layer, _root.holder.getChildIndex(currentLayer) + 1);
                        addToDefaultIndex = false;
                        break;
                    }
                }
            }
            
            if (addToDefaultIndex)
            {
				   _root.holder.addChildAt(layer, 0);
            }
            
            sendNotification(
                                Notifications.instance.LAYERS_TRANSITION_ACTION,
                                view.getHolderName(layer),
                                'addLayer'
                            );
        }
        
        /**
         * Method called when a layers transition requests to remove a layer to the stage.
         * @param	event ApplicationLayersEvent instance.
         */
        private function onTransitionRemoveLayer(event:ApplicationLayersEvent):void 
        {
			var layerName:String = view.getHolderName(event.layer);
            if (_root.holder.removeChild(event.layer))
            {
                sendNotification(
                                    Notifications.instance.LAYERS_TRANSITION_ACTION,
                                    layerName,
                                    'removeLayer'
                                );
            }
			
			 delete _displayedLayers[layerName];
			 
			removeLayerChildren(layerName);
        }
		
        /**
         * Method called when the user clicks on any of the application masks.
         * 
         * @param	event MouseEvent instance.
         */
        private function onMaskClick(event:MouseEvent):void
        {
            removeMaskObject(retrieveChildObject(event.currentTarget as DisplayObject));
        }
	}
}
