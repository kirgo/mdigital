package uk.co.bdoran.util.scrollBox {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	
	import uk.co.bdoran.util.Align;	
	public class VScrollBox extends MovieClip
	{
		private var _content:DisplayObject;
		private var _heightLimit:uint;
		private var _scrollBar:VScrollBar;
		private var _initialY:Number;
		
		public function VScrollBox( content:DisplayObject, linkageID : Class, heightLimit:int, vOffset : int  = 20, hOffset : int = 0)
		{
			this._content = content;
			this._heightLimit = heightLimit;
			this._initialY = _content.y;

			this.addChild(_content);
			
			if (_content.height > _heightLimit)
			{			
				_scrollBar = new VScrollBar(linkageID, _heightLimit - vOffset);
				_scrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
				_scrollBar.y = this._initialY + vOffset / 2;
				addChild(_scrollBar);			
				Align.HBOX( this, hOffset);	
			}	
			var mask:Sprite = new Sprite();
			this.addChild(mask);
			mask.graphics.beginFill(0xFF00F0, 0.5);
			mask.graphics.drawRect(0,0,_content.width,_heightLimit);
			mask.graphics.endFill();
			
			_content.mask = mask;
			mask.x = _content.x;
			mask.y = _content.y;
		}
		
		public function onScrollBarChange( event : DataEvent ) : void {
			_content.y = _initialY - ( Number(event.data) * ( _content.height - _heightLimit ) );
//			//////trace(_scrollBar._scrubber.y);
		}
		
		public function resetScroller() : void {
			_scrollBar.value = 0;
		}
		
		public function scrollTo(val:Number):void
		{
			_scrollBar.value = val;
		}
	}
}