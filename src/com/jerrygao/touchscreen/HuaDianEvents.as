package com.jerrygao.touchscreen
{
	

	
	import flash.events.Event;
	
	public final class HuaDianEvents extends Event
	{
		
		public static const MAIN_MENU_1:String = "MAIN_MENU_1";
		public static const MAIN_MENU_2:String = "MAIN_MENU_2";
		public static const MAIN_MENU_3:String = "MAIN_MENU_3";
		public static const MAIN_MENU_4:String = "MAIN_MENU_4";
		public static const MAIN_MENU_5:String = "MAIN_MENU_5";
		public static const MAIN_MENU_6:String = "MAIN_MENU_6";
		

		public static const SHOW_Introduce_HuaDianEvents:String = "SHOW_Introduce_HuaDianEvents";
		
		public static const MAIN_MENU_Return:String = "MAIN_MENU_Return";
		
		public static const MOUSE_ACTION_HAPENED:String = "MOUSE_ACTION_HAPENED";
		
		public function HuaDianEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}