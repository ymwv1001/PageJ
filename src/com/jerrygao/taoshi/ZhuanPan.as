package com.jerrygao.taoshi
{
	import com.jerrygao.Global;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ZhuanPan extends Sprite
	{
		
		private var mask1:Sprite = new Sprite();
		
		public function ZhuanPan()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private var gallery:Gallery;
		
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			
			mask1.graphics.clear();
			mask1.graphics.beginFill(0x00ff00, 0.5); 
			mask1.graphics.drawRect(0, 0, Global.stageW, Global.stageH); 
			mask1.graphics.endFill(); 
			//this.addChild(mask1);
			
			gallery = new Gallery();
			this.addChild(gallery);
			gallery.clickCoverToPlayMovie = PlayMovie;
			
			//addCEO();
		}
		
		//添加首页 背景 热点 CEO引导组件
		private var ceoSay:CEOSay = new CEOSay();
		
		private var skyscraper:Skyscraper_MC = new Skyscraper_MC();
		private var skyscraper2:Skyscraper_MC = new Skyscraper_MC();
		
		private function addCEO():void
		{
			var rate:Number = Global.stageW/1366;
			skyscraper.x =  260*rate;
			skyscraper.y =  150*rate;
			skyscraper.scaleX = skyscraper.scaleY = 0.4*rate;
			addChild(skyscraper);
			
			skyscraper2.x =  99*rate;
			skyscraper2.y =  145*rate;
			skyscraper2.scaleX = skyscraper2.scaleY = 0.55*rate;
			addChild(skyscraper2);
			
			ceoSay.y = Global.stageH-ceoSay.height;
			this.addChild(ceoSay);
			ceoSay.closeBtn.buttonMode = true;
			ceoSay.addEventListener(MouseEvent.MOUSE_UP,OnCEOCloseBtnClick,false,0,true);
			
			
			AddCircleImage("风车",83,165);
			
			AddCircleImage("桥",750,100);
			
			AddCircleImage("摩天楼",850,70);
			
			AddCircleImage("大海",1050,145);
			
			AddCircleImage("高速路",1075,275);
			
			AddCircleImage("喷泉",562,232);
			
			AddCircleImage("牧场",765,535);
			
			AddCircleImage("跑道",418,225);
		}
		//		
		private var hotPointAtIndex:Vector.<CircleImage> = new Vector.<CircleImage>();
		protected var xAry:Array = [83,750,850,1050,1075,562,765,418];
		protected var yAry:Array = [165,100,70,145,  275,232,535,225];
		
		private function AddCircleImage(name:String,_x:int,_y:int):void
		{
			var rate:Number = Global.stageW/1366;
			
			var imageVo3:CircleImageVO = new CircleImageVO();
			imageVo3.imageUrl = "";
			imageVo3.name = name;
			
			var himg:CircleImage = new CircleImage();
			himg.buttonMode = true;
			himg.circleImageVO = imageVo3;
			himg.createQRImage();
			
			himg.x =  _x*rate;
			himg.y =  _y*rate;
			this.addChild(himg);
			himg.addEventListener(MouseEvent.MOUSE_OVER,onpaoMouseOver,false,0,true);
			himg.addEventListener(MouseEvent.MOUSE_OUT,onpaoMouseOut,false,0,true);
			
			hotPointAtIndex.push(himg);
		}
		
		private function onpaoMouseOver(evt:MouseEvent):void
		{
			var image:CircleImage = evt.currentTarget as CircleImage;
			image.showPaoPao();
			
		}
		
		private function onpaoMouseOut(evt:MouseEvent):void
		{
			var image:CircleImage = evt.currentTarget as CircleImage;
			image.hidePaoPao();//PaoPao();
			
		}
		
		
		private function OnCEOCloseBtnClick(evt:MouseEvent):void
		{
			ceoSay.visible = false;
		}
		
		//private var  player:Player; 
		public function PlayMovie():void
		{
			trace("gallery.clickImgVo.movieUrl:",gallery.clickImgVo.title);
			
			//发送转场事件
			var circleImageClickEvent:TaoshiEvent = new TaoshiEvent(TaoshiEvent.TaoshiEvent_On_CircleImageClick_Event,true);
			
			circleImageClickEvent.imageVo = gallery.clickImgVo;
			
			this.dispatchEvent(circleImageClickEvent);
		}
		
		public function onResized(w:Number,h:Number):void
		{
			mask1.graphics.clear();
			mask1.graphics.beginFill(0x00ff00, 0.5); 
			mask1.graphics.drawRect(0, 0, Global.stageW, Global.stageH); 
			mask1.graphics.endFill(); 
			
		}
		
	}
}