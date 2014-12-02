package com.jerrygao.touchscreen.albums
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.jerrygao.Global;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class Photoes extends Sprite
	{
		private var picNum:int;
		private var btnName:String;
		public var btnNum:int;
		public var picsArr:Array;
		public function Photoes(name:String,picsArr:Array,bnum:int = 1)
		{
			super();
			btnName = name;
			btnNum = bnum;
			this.name = name;
			//this.addChild(bmap);
			this.picsArr = picsArr;
			picNum = picsArr.length;
			
			loadPhotoes();
		}
		
		
		private function loadPhotoes():void
		{
			trace("-----------------loadPhotoes");
			var i:int; 
			for (i = 0; i < picNum; i++) 
			{
				if(i<4)
				{
					var picvo:PicVO = picsArr[i] as PicVO;
					//trace(i); 
					var po:Picture = new Picture(picvo.url,1);
					trace("picvo.url-----------------",picvo.url);
					po.x = i*80;
					po.y = -i*20;
					po.scaleX  = Global.scaleStage;
					po.scaleY  = Global.scaleStage;
					//po.rotation = -25 + i*14;
					TweenLite.to(po,1.2, { rotation:-25 + i*14, ease:Back.easeOut,delay:0.5 } );
					addChildAt(po,0);
				}
			}
		}
	}
}