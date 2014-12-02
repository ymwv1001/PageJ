package com.jerrygao.component
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class BtnSprite extends Sprite
	{
		private var btnName:String;
		public var btnNum:int;
		public var bp:Bitmap;
		public function BtnSprite(name:String,bmap:Bitmap,bnum:int = 1)
		{
			super();
			btnName = name;
			btnNum = bnum;
			this.name = name;
			bp = bmap;
			bmap.smoothing = true;
			this.addChild(bmap);
		}
		
		
//		public function showPhotoesOne():void
//		{
//			
//			
//			
//			var btnum:int = (e.currentTarget as BtnSprite).btnNum;
//			
//			var albumBtn:BtnSprite = new BtnSprite("PhotoesOne" + btnum,new albumBtn_img(),btnum);
//			albumBtn.x = this.getChildByName("albumBtn"+btnum).x;
//			albumBtn.y = 60;
//			while(photoesOneSpri.numChildren>0)
//			{
//				photoesOneSpri.removeChildAt(0);
//			}
//			
//			
//			photoesOneSpri.addChildAt(albumBtn,this.numChildren);
//		}
	}
}