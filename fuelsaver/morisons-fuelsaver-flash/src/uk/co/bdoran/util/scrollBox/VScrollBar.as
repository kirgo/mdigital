package uk.co.bdoran.util.scrollBox {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;	
	public class VScrollBar extends MovieClip
	{
		
		public var _scrubber:MovieClip;
		private var _bar:MovieClip;
		private var _pressed:Boolean;
		private var _heightLimit:uint;
		private var _linkageID : Class;
		
		public function VScrollBar( linkageID : Class, heightLimit:uint )
		{
			super();			
			this._heightLimit = heightLimit;
			this._linkageID = linkageID;
			this.addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}
		
		private function addedToStageHandler( e : Event ) : void{
			var scrollBarSWF:MovieClip = new _linkageID();
			
			_scrubber = scrollBarSWF.getChildByName( "scrubber_mc" ) as MovieClip;
			_bar = scrollBarSWF.getChildByName( "bar_mc" ) as MovieClip;	
			
			_scrubber.y = _bar.y;
			_scrubber.buttonMode=true;
			
			_scrubber.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			_bar.addEventListener(MouseEvent.MOUSE_DOWN, onScrollMouseDownHandler );
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
			
			this.addChild(_bar);
			this.addChild(_scrubber);
			
			this.height = this._heightLimit;
			
			_bar.buttonMode = true;
		}
		
		private function onMouseMoveHandler(event : MouseEvent) : void
		{
			if(_pressed==true){
				this.dispatchEvent(new DataEvent(Event.CHANGE, true, false, String(value)));
			}
		}
		
		private function onMouseDownHandler( e : MouseEvent ):void
		{
			_pressed = true;
			_scrubber.startDrag(false, new Rectangle( _scrubber.x, _bar.y, 0, _bar.height-_scrubber.height ));
		}
		
		private function onScrollMouseDownHandler( e : MouseEvent ):void{
			_pressed = true;
			_scrubber.y = _bar.mouseY - (_scrubber.height/2);
			if( _scrubber.y < _bar.y ) {
				_scrubber.y += (_scrubber.height/2);
			}
			if( _scrubber.y > _bar.y + _bar.height - _scrubber.height ){
				_scrubber.y -= _scrubber.height/2;
			}
			this.dispatchEvent(new DataEvent(Event.CHANGE, true, false, String(value)));
		}
		
		private function onMouseUpHandler( e : MouseEvent ):void
		{
			_pressed = false;
			_scrubber.stopDrag();
		}
		
		public function get value():Number
		{
			return _scrubber.y/(_bar.height-_scrubber.height);
		}
		
		public function set value(val:Number):void
		{
			_scrubber.y=val;
			this.dispatchEvent(new DataEvent(Event.CHANGE, true, false, String(value)));
		}
		
		public function get scrubber():MovieClip{
			return _scrubber;
		}
	}
}