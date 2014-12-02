package com.jerrygao.taoshi
{
	import com.jerrygao.Global;
	import com.jerrygao.screen.PictureBG;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class CircleImage extends Sprite
	{
		public var index:int;
		public var ZhuanIndex:int;
		public var thumbs:Sprite = new Sprite();
		public var circleImageVO:CircleImageVO;
		
		private var circleIcon:CircleIcon = new CircleIcon();
		
		public function CircleImage()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			this.addChild(thumbs);
			this.addChild(circleIcon);
		}
		
		public var image:PictureBG;
		private var qrcode:PictureBG;
		public function createQRImage():void
		{
			if(circleImageVO.imageUrl!="")
			{
				//image = new PictureBG(circleImageVO.imageUrl,1,"",setImageSize,10,15);
				//circleIcon.addChildAt(image,0);
				
				circleIcon.IconName.text = "";
			}
			
			var rate:Number = Global.stageW/1366;
			
			this.addChild(hotPao);
			hotPao.x = 45*rate;
			hotPao.y = 40*rate;
			hotPao.setpaopaoName(circleImageVO.name);
		}
		
		public function setImageSize():void
		{
			image.setSize(146,125);
		}
		
		public function setQrcodeSize():void
		{
			//qrcode.setSize(325,325);
		}
		
		private function loadImg(url:String,_x:int,_y:int):void
		{
			var loader:Loader = new Loader();
			loader.load(new URLRequest(url));
			loader.x = _x;
			loader.y = _y;
			thumbs.addChild(loader);
		}
		
		private var hotPao:HotPointCircle = new HotPointCircle();
		
		public var showEver:Boolean = false;
		public function showPaoPao(isShowEver:Boolean = false,paopaoText:String = ""):void
		{
			//showEver = isShowEver;
			hotPao.ToOpenPaopao(paopaoText);
		}
		
		public function hidePaoPao():void
		{
			//this.removeChild(hotPao);
			if(showEver == false)
			{
			 	hotPao.ToClosePaopao();
			}
		}
		
	}
}