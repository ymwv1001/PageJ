package com.jerrygao.taoshi
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class HotPointCircle extends Sprite
	{
		public function HotPointCircle()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
//		private var hotpoint:HotPoint;
		private var paopao:Paopao_MC = new Paopao_MC();
		
		
		public var isCloseLable:Boolean = false;
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
//			
//			hotpoint = new HotPoint();
//			hotpoint.scaleX = hotpoint.scaleY = 0.5;
//			this.addChild(hotpoint);
		}
		
		public function ToClosePaopao():void
		{
			//hotpoint.gotoAndStop("close");
			isCloseLable = true;
			
			if(paopao!=null&&this.contains(paopao))
			this.removeChild(paopao);
		}
		
		public function ToOpenPaopao(text:String):void
		{
			if(text.length>10)
			isCloseLable = false;
			paopao.y = -50;
			this.addChild(paopao);
			//paopao.paopao.gotoAndStop(50);
		}
		
		public function setpaopaoName(paoName:String):void
		{
			paopao.paopaoName.text = paoName;
			var len:int = paoName.length;
			if(len<=5)
			{
				paopao.paopao.gotoAndStop(55);
				paopao.paopaoName.x -= 15;
			}
			else if(len>5 && len<=7)
			{
				paopao.paopao.gotoAndStop(70);
			}
			
			if(len == 8)
			{
				paopao.paopao.gotoAndStop(80);
			}
			//paopao.paopao.gotoAndStop(10*len);
		}

	}
}











