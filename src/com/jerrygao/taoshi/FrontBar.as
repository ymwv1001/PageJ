package com.jerrygao.taoshi
{
	import com.greensock.TweenLite;
	import com.jerrygao.Global;
	import com.jerrygao.screen.PictureBG;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class FrontBar extends Sprite
	{
		public function FrontBar()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private var BG:PictureBG;//背景
		
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			
			//initBGByBGURL
			//BG = new PictureBG("assets/pic/area/TheatreBG.jpg",1,"",mainBG1Comp);
		}
		
		private function mainBG1Comp():void
		{
			addChild(BG);
			BG.bitmap.width =Global.stageW;
			BG.bitmap.height = Global.stageH;
			//BG.x = Global.displayX - 400;
			BG.alpha = 0.3;
			TweenLite.to(BG,1.0,{alpha:1, delay:0.8});
			//BG.addEventListener(MouseEvent.MOUSE_UP,onmpClick,false,0,true);
		}
		
		
		public function initBGByBGURL(url:String):void
		{
			trace("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",url);
			BG = new PictureBG(url,1,"",mainBG1Comp);
		}
		
		public function onResized():void
		{
			var rate:Number = Global.stageW/1366;
			if(BG!=null&&BG.bitmap!=null)
			{
				//addChild(BG);
				BG.bitmap.width =Global.stageW;
				BG.bitmap.height = Global.stageH;
			}
		}
		
	}
}