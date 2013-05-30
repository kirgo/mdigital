package uk.co.bdoran.util {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.geom.Point;

	/**
	 * @author Mathieu
	 */
	public class MotionBlur 
	{
		private static var _list:Array = new Array();
		
		private var _oldPosition : Point ;
		private var _blurFilter : BlurFilter ;
		private var _target : DisplayObject ;
		private var _strength : Number ;
		
		public function MotionBlur()
		{
			_list.push(this);
		}

		
		
		public function addMotionBlur(target : DisplayObject,strength:Number=1) : void
		{
			_target = target;
			_strength = strength;
			_blurFilter = new BlurFilter(0,0,BitmapFilterQuality.LOW);
			_oldPosition = new Point(_target.x, _target.y);
			_target.addEventListener(Event.ENTER_FRAME, onMotionBlurEnterFrame);
			_target.filters = [_blurFilter];
		}

		public function onMotionBlurEnterFrame(e : Event) : void
		{
			
			//Set strength of blur based on old and new x position
			var blurX : Number = Math.abs(_oldPosition.x - _target.x); 
			var blurY : Number = Math.abs(_oldPosition.y - _target.y);

			    
			_blurFilter.blurX = _strength * blurX;
			_blurFilter.blurY = _strength * blurY;
			
			_target.filters = [_blurFilter];
			
			
			_oldPosition.x = _target.x;
			_oldPosition.y = _target.y;
		}
		
		
		public function remove() : void
		{
			_target.removeEventListener(Event.ENTER_FRAME, onMotionBlurEnterFrame);
			//remove the filter:
			//_target.filters.splice(_target.filters.length-1,1);
			_target.filters = [];
		}
		
		public static function removeAll() : void
		{
			for (var i : Number = 0; i < _list.length; i++) {
				
				_list[i].remove();
				
			}
			
		}
		
	}
}
