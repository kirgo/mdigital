package uk.co.bdoran.util {
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Mathieu
	 */
	public class Waiter 
	{
		private var _timer : Timer ;
		private var _func : Function;
		private var _args : Object;

		public function Waiter(time : Number,func : Function, args : Object = null)
		{
			_func = func;
			_args = args;
			_timer = new Timer(time, 1);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start();
		}

		private function onTimer(e : TimerEvent) : void
		{
			_timer.stop();
			if( _args )
				_func.call( null, _args );
			else
				_func.call();
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);
		}
		
		public function stop() : void
		{
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);
			_timer.stop();
		}
		
		
	}
}
