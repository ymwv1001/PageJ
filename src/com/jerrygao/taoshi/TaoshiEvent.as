package com.jerrygao.taoshi
{
	import flash.events.Event;
	
	public class TaoshiEvent extends Event
	{
		
		public var roomName:String = ""; 
		
		public var imageVo:CircleImageVO;
		
		public static var TaoshiEvent_On_CircleImageClick_Event:String = "TaoshiEvent_On_CircleImageClick_Event";
		
		
		public static var TaoshiEvent_OpenRoom_Handler_Event:String = "TaoshiEvent_OpenRoom_Handler_Event";
		
		public static var TaoshiEvent_Return_Home_Event:String = "TaoshiEvent_Return_Home_Event";
		
		public function TaoshiEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}