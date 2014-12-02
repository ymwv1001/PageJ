package com.jerrygao.taoshi
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class HotPointSp extends Sprite
	{
		public function HotPointSp()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		public var hotVO:HotPointVO;
		
		public var tweenBG:Function;
		
		private var hotpoint:HotPoint;
		public var isCloseLable:Boolean = false;
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			
			hotpoint = new HotPoint();
			this.addChild(hotpoint);
		}
		
		private var pao:Paopao_MC = new Paopao_MC();
		
		public function onhpmouseOver():void
		{
			addChild(pao);
			pao.paopao.gotoAndStop(50);
			pao.paopaoName.text = hotVO.name;
			pao.paopaoName.x = -20;
			pao.y = -60;
			
		}
		
		public function onhpmouseOut():void
		{
			this.removeChild(pao);
		}
		
		
		public function ToCloseLable():void
		{
			hotpoint.gotoAndStop("close");
			isCloseLable = true;
		}
		
		public function ToOpenLable():void
		{
			hotpoint.gotoAndStop(1);
			isCloseLable = false;
		}
	}
}