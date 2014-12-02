package com.jerrygao.taoshi
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class TipButton extends Sprite
	{
		private var isDisplayTip:Boolean= true;//是否现实气泡
		private var type:String = "right";//气泡方向
		private var button:Sprite;		  //气泡下边的小红点按钮
		private var tip:Sprite;           //气泡
		
		private var tipName:TextField;
		
		public function TipButton()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			
			tipName = new TextField();
			tipName.wordWrap = true;//设置自动换行
			tipName.width = 30;
			tipName.border = true;
			tipName.text = "111111111111111as\n111111111111111111123455677788";
			tipName.height = tipName.textHeight + 4;//至少加4
			addChild(tipName);
		}
		/*
		用下面的方法可以实现高度自适应：
		var txt:TextField = new TextField();
		txt.wordWrap = true;//设置自动换行
		txt.width = 30;
		txt.border = true;
		txt.text = "111111111111111as\n111111111111111111123455677788";
		txt.height = txt.textHeight + 4;//至少加4
		addChild(txt);
		*/
		
		
	}
}