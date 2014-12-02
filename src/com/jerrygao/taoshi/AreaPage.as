package com.jerrygao.taoshi
{
	import com.greensock.TweenLite;
	import com.jerrygao.Global;
	import com.jerrygao.screen.PictureBG;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	public class AreaPage extends Sprite
	{
		public function AreaPage()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,init);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemove);
		}
		
		private var mask1:Sprite = new Sprite();
		private var BG:PictureBG;//背景
		private var peopleImage:PictureBG;//人物图
		
		private var productsImg:PictureBG;//人物图
		
		private var hotPiontArr:Vector.<HotPointVO> = new Vector.<HotPointVO>();//热点列表
		private var hotPiontMCArr:Array = new Array();
		
		private var hotPointPopUp:HotPointPopUp ;//= new HotPointPopUp();
		
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			
			mask1.graphics.clear();
			mask1.graphics.beginFill(0xff0000, 1); 
			mask1.graphics.drawRect(0, 0, Global.stageW, Global.stageH); 
			mask1.graphics.endFill(); 
		}
		
		private function mainBG1Comp():void
		{
			addChild(BG);
			BG.bitmap.width =Global.stageW;
			BG.bitmap.height = Global.stageH;
			//BG.x = Global.displayX - 400;
			BG.alpha = 0.3;
			TweenLite.to(BG,1.0,{alpha:1, delay:0.8,onComplete:setupJSPopup});
			initHitpoint();
		}
		
		//private var  areaNav_MC:AreaNav_MC = new AreaNav_MC();
		
		//调用JS函数 显示：电影列表 或 图片列表 
		
		private function setupJSPopup():void
		{
			ExternalInterface.call("OpenFrame", areaVO.roomName);
		}
		
		//点击返回 发送返回 主页画面 事件。 
		//如果当前是 电影 或 图片 area  调用JS函数 关闭：电影列表 或 图片列表 
		private function OnReturnClicked(evt:MouseEvent):void
		{
			trace("..........OnReturnClicked.........");
			if(areaVO.peopleUrl=="")
			{
				ExternalInterface.call("CloseFrame", areaVO.roomName);
			}
			var returnHome:TaoshiEvent = new TaoshiEvent(TaoshiEvent.TaoshiEvent_Return_Home_Event,true);
			
			this.dispatchEvent(returnHome);
		}
		
		private function SendRectangle(fx:Number,fy:Number,fw:Number,fh:Number):void
		{
			//调用JS函数 参数为flash 有效显示区域的 x y w h
			ExternalInterface.call("FlashRectangle",fx, fy, fw,fh);
		}
		
		private var tableImg:PictureBG;
		
		private function peopleImageComp():void
		{
			addChild(peopleImage);
			peopleImage.bitmap.width =Global.stageW;
			peopleImage.bitmap.height = Global.stageH;
			peopleImage.x = 1200;
			
			
			tableImg = new PictureBG("assets/pic/area/table.png",1,"",tableImgComp);
		}
		
		private function tableImgComp():void
		{
			//this.addChild(tableImg);
			tableImg.bitmap.width =Global.stageW;
			tableImg.y =100;// Global.stageW - tableImg.height;
			
			productsImg = new PictureBG(areaVO.productsUrl,1,"",productsImgComp);
		}
		
		
		private function productsImgComp():void
		{
			this.addChild(productsImg);
			productsImg.bitmap.width =Global.stageW;
			productsImg.bitmap.height = Global.stageH;
			productsImg.x = -1600;
			tweenPage();
		}
		
		private function tweenPage():void
		{
			TweenLite.to(BG,1.4,{x:0, delay:0.8});
			TweenLite.to(peopleImage,1.0,{x:0,alpha:1, delay:2.0});
			TweenLite.to(productsImg,0.8,{x:0,alpha:1, delay:1.5 ,onComplete:initHitpoint});
		}
		
		public function tweenBG():void
		{			
			TweenLite.to(BG,1.0,{x:0});
			BG.addChild(cuttHP);
			cuttHP.ToOpenLable();
		}
		
		private function initHitpoint():void
		{
			hotPiontMCArr = [];
			trace("initHitpoint");
			for (var i:int = 0; i <hotPiontArr.length; i++)
			{
				var rate:Number = Global.stageW/1366;
				
				var hotpoint:HotPointSp = new HotPointSp();
				
				hotpoint.hotVO = hotPiontArr[i];
				BG.addChild(hotpoint);
				
				
				
				hotpoint.x = int(hotPiontArr[i].x)*rate;// - 40;
				hotpoint.y = int(hotPiontArr[i].y)*rate;// - 40;
				
				hotpoint.buttonMode = true;
				hotpoint.addEventListener(MouseEvent.CLICK,onmouseClick,false,0,true);
				hotpoint.addEventListener(MouseEvent.MOUSE_OVER,onhpmouseOver,false,0,true);
				hotpoint.addEventListener(MouseEvent.MOUSE_OUT,onhpmouseOut,false,0,true);
				
				hotpoint.name = "hotpoint_" + i;
				hotPiontMCArr.push(hotpoint);
			}
			
			onResized(Global.stageW,Global.stageH);
		}
		
		private function onhpmouseOver(evt:MouseEvent):void
		{
			var ht:HotPointSp = evt.currentTarget as HotPointSp;
			BG.addChild(ht);
			ht.onhpmouseOver();
		}
		
		private function onhpmouseOut(evt:MouseEvent):void
		{
			(evt.currentTarget as HotPointSp).onhpmouseOut();
		}
		
		
		private function removeHitpoint():void
		{
			
			for (var i:int = 0; i <hotPiontMCArr.length; i++)
			{
				var hotpoint:HotPointSp = hotPiontMCArr[i] as HotPointSp;
				hotpoint.removeEventListener(MouseEvent.CLICK,onmouseClick);
				BG.removeChild(hotpoint);
			}
		}
		
		public var areaVO:AreaVO;
		public function initArea(VO:AreaVO):void
		{
			this.areaVO = VO;
			hotPiontArr = areaVO.items;
			// 加载画面。。。。。
			
			trace("initArea  bgimageUrl: ",areaVO.bgimageUrl);
			
			
			
			BG = new PictureBG(areaVO.bgimageUrl,1,"",mainBG1Comp);
			//move();
			
			//this.addChild(hotPointPopUp);
		}
		
		private var picshow:PicShow;
		public function initGallery():void
		{
			var rate:Number = Global.stageW/1366;
		 picshow = new PicShow();
				this.addChild(picshow);
				picshow.scaleX = picshow.scaleY = rate;
				picshow.y = (Global.stageH - picshow.height)/2 - 50;
				picshow.x = (Global.stageW - picshow.width)/2;
				picshow.visible = false;
				addEventListener(MouseEvent.MOUSE_UP,onPicBtnClick,false,0,true);
				//picshow.CloseBtn.addEventListener(MouseEvent.MOUSE_UP,onCloseBtnClick,false,0,true);
		}
		
		
		public function onPicBtnClick(evt:MouseEvent):void
		{
			picshow.visible = !picshow.visible;
			
		}
		
		public function onCloseBtnClick(evt:MouseEvent):void
		{
			picshow.visible = false;
		}
		private var mp:MoviePlayUI = new MoviePlayUI();
		public function initTheatre():void
		{
			var rate:Number = Global.stageW/1366;
			this.addChild(mp);
			mp.scaleX = mp.scaleY = rate;
			mp.y = (Global.stageH - mp.height)/2 - 100;
			mp.x = (Global.stageW - mp.width)/2;
			mp.visible = false;
		//	mp.alpha = 0.01;
			addEventListener(MouseEvent.MOUSE_UP,onmpClick,false,0,true);
		}
		
		public function onmpClick(evt:MouseEvent):void
		{
			
			mp.visible = !mp.visible;
		}
		
		
		private var isShowProduct:Boolean  =false;
		
		private var cuttHP:HotPointSp;
		private var perHP:HotPointSp;
		private var cuttHPindex:int;
		public function onmouseClick(evt:MouseEvent):void
		{
			if(cuttHP!=null)
			{
				perHP = cuttHP;
			}
			cuttHP = evt.currentTarget as HotPointSp;
			if(perHP == cuttHP )
			{
				if(cuttHP.isCloseLable == true)
				{
					//  当前是 X 状态 变成 动画状态
					
					//关闭弹出框
					TweenLite.to(hotPointPopUp,0.7,{x:Global.stageW,alpha:1});
					//TweenLite.to(peopleImage,1.2,{x:0,delay:0.1});
					TweenLite.to(BG,1.0,{x:0});
					BG.addChild(cuttHP);
					cuttHP.ToOpenLable();
					trace("关闭弹出框");
					
					isShowProduct = false;
				}
				else
				{
					//当前是 动画状态 变成 X 状态
					cuttHP.ToCloseLable();
					
					//打开弹出框
					cuttHPindex = int(cuttHP.name.substr(9,1));
					popUpByHotPiontIndex(cuttHPindex);
				}
			}
			else
			{
				if(perHP!=null&&perHP.isCloseLable == true)
				{
					//  当前是 X 状态 变成 动画状态
					BG.addChild(perHP);
					perHP.ToOpenLable();
					
				}
				
				cuttHP.ToCloseLable();
				cuttHPindex = int(cuttHP.name.substr(9,1));
				
				popUpByHotPiontIndex(cuttHPindex);
				
			}
		}
		
		private function popUpByHotPiontIndex(index:int):void
		{
			var currVO:HotPointVO = hotPiontArr[cuttHPindex];
			
			var rate:Number = Global.stageW/1366;
			
			if(hotPointPopUp!=null)
			{
				this.removeChild(hotPointPopUp);
				hotPointPopUp = null;
			}
			
			isShowProduct = true;
			
			hotPointPopUp = new HotPointPopUp();
			hotPointPopUp.tweenBG = tweenBG;
			hotPointPopUp.scaleX = hotPointPopUp.scaleY = rate;
			hotPointPopUp.x = Global.displayX + Global.stageW;
			this.addChild(hotPointPopUp);
			hotPointPopUp.initHotPointByVO(currVO);
			TweenLite.to(hotPointPopUp,0.7,{x:Global.stageW - hotPointPopUp.width,alpha:1});
			TweenLite.to(BG,1.2,{x:-380,alpha:1});
			
		}
		

		
		public function onResized(w:Number,h:Number):void
		{
			var rate:Number = Global.stageW/1366;
			if(BG!=null&&BG.bitmap!=null)
			{
				addChild(BG);
				BG.bitmap.width =Global.stageW;
				BG.bitmap.height = Global.stageH;
			}
			
			if(peopleImage!=null&&peopleImage.bitmap!=null)
			{
				addChild(peopleImage);
				peopleImage.bitmap.width =Global.stageW;
				peopleImage.bitmap.height = Global.stageH;
			}
			
			
			
			if(productsImg!=null&&productsImg.bitmap!=null)
			{
				this.addChild(productsImg);
				productsImg.bitmap.width =Global.stageW;
				productsImg.bitmap.height = Global.stageH;
			}
			
			if(hotPointPopUp!=null&&this.contains(hotPointPopUp))
			{
				hotPointPopUp.scaleX = hotPointPopUp.scaleY = rate;
				this.addChild(hotPointPopUp);
			}
			
			if(tableImg!=null&&tableImg.bitmap!=null)
			{
				this.addChildAt(tableImg,this.numChildren);
				tableImg.bitmap.width =Global.stageW;
				tableImg.y = Global.stageW - tableImg.height;
			}
			if(picshow!=null&&this.contains(picshow))
			{
				this.addChild(picshow);
				picshow.scaleX = picshow.scaleY = rate;
				picshow.y = (Global.stageH - picshow.height)/2 - 50;
				picshow.x = (Global.stageW - picshow.width)/2;
			}
			
			//mp
			
			if(mp!=null&&this.contains(mp))
			{
				this.addChild(mp);
				mp.scaleX = mp.scaleY = rate;
				mp.y = (Global.stageH - mp.height)/2 - 50;
				mp.x = (Global.stageW - mp.width)/2;
			}
			
			SendRectangle(Global.displayX,Global.displayY,Global.stageW,Global.stageH);
			
			//if(areaNav_MC!=null)
			//{
			///	this.addChild(areaNav_MC);/
			//}
			
			if(hotPiontMCArr.length>0)
			{
				for (var i:int = 0; i <hotPiontMCArr.length; i++)
				{
					var hotpoint:HotPointSp = hotPiontMCArr[i];
					hotpoint.x = int(hotPiontArr[i].x)*rate;// - 40;
					hotpoint.y = int(hotPiontArr[i].y)*rate;// - 40;
					BG.addChild(hotpoint);//.addChild(hotpoint);
				}
			}
			
		}
		
		private function onRemove(evt:Event):void
		{
			trace("area be removed!!");
			removeHitpoint();
			
			if(this.contains(BG))
			{
				removeChild(BG);
				BG.bitmap.bitmapData.dispose();
				BG = null;
			}
			
			if(peopleImage!=null&&this.contains(peopleImage))
			{
				removeChild(peopleImage);
				peopleImage.bitmap.bitmapData.dispose();
				peopleImage = null;
			}
			
			if(productsImg!=null&&this.contains(productsImg))
			{
				removeChild(productsImg);
				productsImg.bitmap.bitmapData.dispose();
				productsImg = null;
			}
			//removeChild(areaNav_MC);
			
			if(tableImg!=null&&this.contains(tableImg))
			{
				removeChild(tableImg);
				tableImg.bitmap.bitmapData.dispose();
				tableImg = null;
			}
			
			
			
			
		
		}
	}
}