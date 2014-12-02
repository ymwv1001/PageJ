package com.jerrygao.taoshi
{
	import com.greensock.TweenLite;
	import com.jerrygao.Global;
	import com.jerrygao.screen.PictureBG;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class HotPointPopUp extends Sprite
	{
		private var mask1:Sprite = new Sprite();
		public function HotPointPopUp()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		public var hotPointVO:HotPointVO;
		//private var image:PictureBG;

		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			mask1.graphics.clear();
			mask1.graphics.beginFill(0xcccccc, 0.8); 
			mask1.graphics.drawRect(0, 0, Global.stageW/2.5, Global.stageH); 
			mask1.graphics.endFill(); 
			
			//this.addChild(mask1);
			
			this.addChild(product);
			product.moistureURL.buttonMode = true;
			product.softURL.buttonMode = true;
			product.moistureURL.addEventListener(MouseEvent.MOUSE_UP,itemMouseUp,false,0,true);
			product.softURL.addEventListener(MouseEvent.MOUSE_UP,item2MouseUp,false,0,true);
			
			
			product.closeBtn.buttonMode = true;
			product.closeBtn.addEventListener(MouseEvent.MOUSE_UP,CloseMouseUp,false,0,true);
			
		}
		private var product:ProductIMG = new ProductIMG();
		
		public function initHotPointByVO(vo:HotPointVO):void
		{
			hotPointVO = vo;
			/*
			//image = new PictureBG(hotPointVO.imageUrl,1,"",setSize,10,10);
			image = new PictureBG(hotPointVO.imageUrl,1,"",setSize,10,10);
			this.addChild(image);
			image.buttonMode = true;
			image.addEventListener(MouseEvent.MOUSE_UP,itemMouseUp,false,0,true);
			trace("initHotPointByVO",vo.imageUrl);
			*/
		}
		
		
		private var itemLink:String = "";
		public function itemMouseUp(evt:MouseEvent):void
		{
			//navigateToURL(hotPointVO.productUrl,"_about");
			navigateToURL(new URLRequest("http://www.dow.com/products/market/personal-care-and-apparel/"),"_blank");
			
			//http://www.dow.com/products/market/personal-care-and-apparel
		}
		
		public function item2MouseUp(evt:MouseEvent):void
		{
			//navigateToURL(hotPointVO.productUrl,"_about");
			navigateToURL(new URLRequest("http://www.dow.com/products/market/personal-care-and-apparel/"),"_blank");
			
			//http://www.dow.com/products/market/personal-care-and-apparel/
		}
		
		public var tweenBG:Function;
		public function CloseMouseUp(evt:MouseEvent):void
		{
			TweenLite.to(this,0.7,{x:Global.stageW,alpha:1});
			tweenBG();
		}
		
		public function setSize():void
		{
			//
		}
	}
}