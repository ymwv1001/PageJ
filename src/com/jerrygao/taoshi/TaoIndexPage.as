package com.jerrygao.taoshi
{
	import com.jerrygao.Global;
	import com.jerrygao.screen.PictureBG;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class TaoIndexPage extends Sprite
	{
		
		private var mask1:Sprite = new Sprite();

		public function TaoIndexPage()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private var mainBG:Sprite;
		private var mainBG1a:PictureBG;
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			mask1.graphics.clear();
			mask1.graphics.beginFill(0x0000ff, 0.5); 
			mask1.graphics.drawRect(0, 0, Global.stageW, Global.stageH); 
			mask1.graphics.endFill(); 	
			
			onLoadRoomsXML("assets/TSConfig.xml");
		}
		
		private var cloud:Cloud_MC = new Cloud_MC();
		private var cloud2:Cloud_MC = new Cloud_MC();
		
		private function mainBG1Comp():void
		{
			mainBG.addChildAt(mainBG1a,0);
			trace("mainBG1Comp : ",mainBG1a.bitmap.width,mainBG1a.bitmap.height);
			
			mainBG1a.bitmap.width =Global.stageW;
			mainBG1a.bitmap.height = Global.stageH;
			//mainBG1a.x = Global.displayX;
			cloud.x = 500;
			cloud.y = -36;
			cloud.scaleX = cloud.scaleY = 0.6;
			addChild(cloud);
			
			cloud2.x = 750;
			cloud2.y = -66;
			cloud2.scaleX = cloud2.scaleY = 0.8;
			addChild(cloud2);
			
			
			startCircle();
			addCEO();
			
			trace("mainBG1Comp  1 : ",mainBG1a.bitmap.width,mainBG1a.bitmap.height);
		}
		
        //加载 房间 XML
		public function onLoadRoomsXML(url:String):void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(new URLRequest(url));
			urlLoader.addEventListener(Event.COMPLETE, loadComplete);
		}
		
		private var ecoHouse:PictureBG;
		
		protected function loadComplete(evt:Event):void
		{
			var xml:XML = new XML((evt.currentTarget as URLLoader).data);
			
			AreaVO.GetAreaVOByXML(xml);
			
			// 加载画面。。。。。
			mainBG = new Sprite();
			this.addChild(mainBG);
			mainBG1a = new PictureBG("assets/pic/mainBg.jpg",1,"",mainBG1Comp);
			
			//ecoHouse = new PictureBG("assets/pic/EcoHouse_icon.png",1,"",ecoHouseComp);
		}
		
		private function ecoHouseComp():void
		{
			addChild(ecoHouse);
			ecoHouse.bitmap.scaleX = 0.5;
			ecoHouse.bitmap.scaleY = 0.5;
			ecoHouse.x = 230;
			ecoHouse.y = 250;
			//trace("mainBG1Comp : ",mainBG1a.bitmap.width,mainBG1a.bitmap.height);
			
			startCircle();
			addCEO();
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
			
			AddCircleImage("风能叶片解决方案",142,203);
			
			AddCircleImage("桥面铺装系统",1080,210);
			
			AddCircleImage("节能型建筑材料",1200,120);
			
			AddCircleImage("海水淡化技术",1177,272);
			
			AddCircleImage("公路路面漆",1200,400);
			
			AddCircleImage("景观用水",730,310);
			
			AddCircleImage("禽畜疾病防御",1020,635);
			
			AddCircleImage("环保型塑胶跑道",600,350);
			
			AddCircleImage("去陶氏导购中心",285,454,"../shop");
		}
		
		private function OnCEOCloseBtnClick(evt:MouseEvent):void
		{
			ceoSay.visible = false;
		}
		
		private var hotPointAtIndex:Vector.<CircleImage> = new Vector.<CircleImage>();
		protected var xAry:Array = [83,750,850,1050,1075,562,765,418];
		protected var yAry:Array = [165,100,70,145,  275,232,535,225];
		
		private function AddCircleImage(name:String,_x:int,_y:int,link:String =""):void
		{
			var rate:Number = Global.stageW/1366;
			
			var imageVo3:CircleImageVO = new CircleImageVO();
			imageVo3.imageUrl = "";
			imageVo3.name = name;
			imageVo3.link = link;
			var himg:CircleImage = new CircleImage();
			himg.buttonMode = true;
			himg.circleImageVO = imageVo3;
			himg.createQRImage();
			
			himg.x =  (_x - 55)*rate;
			himg.y =  (_y - 42)*rate;
			this.addChild(himg);
			himg.addEventListener(MouseEvent.MOUSE_OVER,onpaoMouseOver,false,0,true);
			himg.addEventListener(MouseEvent.MOUSE_OUT,onpaoMouseOut,false,0,true);
			himg.addEventListener(MouseEvent.MOUSE_UP,onpaoMouseUp,false,0,true);
			hotPointAtIndex.push(himg);
		}
		
		private function onpaoMouseUp(evt:MouseEvent):void
		{
			var cImg:CircleImage = evt.currentTarget as CircleImage;
			var link:String = cImg.circleImageVO.link;
			if(link!="")
			{
				trace("link",link);
				navigateToURL(new URLRequest(link),"_blank");
			}
		}
		
		private function onpaoMouseOver(evt:MouseEvent):void
		{
			var image:CircleImage = evt.currentTarget as CircleImage;
			image.showPaoPao();
			
		}
		
		private function onpaoMouseOut(evt:MouseEvent):void
		{
			var image:CircleImage = evt.currentTarget as CircleImage;
			image.hidePaoPao();
		}
		
		//添加首页 大转盘组建   
		private var circle:ZhuanPan;
		
		private function startCircle():void
		{
			circle = new ZhuanPan();
			
			this.addChild(circle);
			
			circle.addEventListener(TaoshiEvent.TaoshiEvent_On_CircleImageClick_Event,onRoomIconClick,false,0,true);
			
			onResized(Global.stageW,Global.stageH);
		}
		
		private function onRoomIconClick(evt:TaoshiEvent):void
		{
			var openRoom_Handler_Event:TaoshiEvent = new TaoshiEvent(TaoshiEvent.TaoshiEvent_OpenRoom_Handler_Event,true);
			
			openRoom_Handler_Event.imageVo = evt.imageVo;
			
			this.dispatchEvent(openRoom_Handler_Event);
		}
		

		
		
		//添加 单类房间组page
		
		public var CurrentCircleImageVO:CircleImageVO;
		
		public function startRoomPageByCircleImageVO():void
		{
			var CircleImageClickEvent:TaoshiEvent = new TaoshiEvent(TaoshiEvent.TaoshiEvent_On_CircleImageClick_Event,true);
			this.dispatchEvent(CircleImageClickEvent);
			
		}
		
		
		public function onResized(w:Number,h:Number):void
		{
			mask1.graphics.clear();
			
			var rate:Number = Global.stageW/1366;
			
			if(mainBG1a!=null&&mainBG1a.bitmap != null)
			{
				mainBG1a.bitmap.width =  Global.stageW;
				mainBG1a.bitmap.height =  Global.stageH;
				mainBG1a.x = 0;
				mainBG1a.y = 0;
			}
			
			if(circle!=null)
			{
				circle.scaleX = circle.scaleY = rate;
				circle.onResized(Global.stageW, Global.stageH); 
				trace("circle", 1111111);
			}
			
			if(circle!=null)
			{
				ceoSay.scaleX = ceoSay.scaleY = rate;
				ceoSay.y = Global.stageH-ceoSay.height;
			}
			
			skyscraper.x =  260*rate;
			skyscraper.y =  150*rate;
			skyscraper.scaleX = skyscraper.scaleY = 0.4*rate;
			addChild(skyscraper);
			
			
			
			
			skyscraper2.x =  99*rate;
			skyscraper2.y =  145*rate;
			skyscraper2.scaleX = skyscraper2.scaleY = 0.55*rate;
			
			if(ecoHouse!=null)
			{
				ecoHouse.bitmap.scaleX = 0.5*rate;
				ecoHouse.bitmap.scaleY = 0.5*rate;
				ecoHouse.x = 230*rate;
				ecoHouse.y = 250*rate;
			}
			/*
			for (var i:int = 0; i < hotPointAtIndex.length; i++)
			{
				var img:CircleImage = hotPointAtIndex[i];
				img.x = xAry[i]*rate;
				img.y = yAry[i]*rate;
			}
			*/
			
		}
	}
}








