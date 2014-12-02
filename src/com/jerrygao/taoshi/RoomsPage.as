package com.jerrygao.taoshi
{
	import com.greensock.TweenLite;
	import com.jerrygao.Global;
	import com.jerrygao.screen.PictureBG;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class RoomsPage extends Sprite
	{
		//Area VO 列表
		public var areasList:Vector.<AreaVO>;
		
		// 导航栏图标
		private var roomNavIcon:PictureBG;
		
		// 导航栏 MC 
		private var  areaNav_MC:AreaNav_MC = new AreaNav_MC();
		
		
		//左切换按钮
		private var leftBtn:LeftArea_MC = new LeftArea_MC();
		
		//右切换按钮
		private var rightBtn:RightArea_MC = new RightArea_MC();
		
		
		public function RoomsPage()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private var mask1:Sprite = new Sprite();
		
		private var frontBar:FrontBar;// = new FrontBar();
		
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			mask1.graphics.clear();
			mask1.graphics.beginFill(0xff0000, 1); 
			mask1.graphics.drawRect(Global.displayX, Global.displayY, Global.stageW, Global.stageH); 
			mask1.graphics.endFill(); 
			
			
			
			leftBtn.btn.addEventListener(MouseEvent.MOUSE_UP,onLeftBtnClick,false,0,true);
			leftBtn.btn.addEventListener(MouseEvent.MOUSE_OVER,onLeftBtnOver,false,0,true);
			leftBtn.btn.addEventListener(MouseEvent.MOUSE_OUT,onLeftBtnOut,false,0,true);
			
			
			rightBtn.btn.addEventListener(MouseEvent.MOUSE_UP,onRightBtnClick,false,0,true);
			rightBtn.btn.addEventListener(MouseEvent.MOUSE_OVER,onRightBtnOver,false,0,true);
			rightBtn.btn.addEventListener(MouseEvent.MOUSE_OUT,onRightBtnOut,false,0,true);
		}
		
		
//		private function mainBG1Comp():void
//		{
//			addChild(BG);
//			BG.bitmap.width =Global.stageW;
//			BG.bitmap.height = Global.stageH;
//			//BG.x = Global.displayX - 400;
//			BG.alpha = 0.3;
//			TweenLite.to(BG,1.0,{alpha:1, delay:0.8});
//			BG.addEventListener(MouseEvent.MOUSE_UP,onmpClick,false,0,true);
//		}
		
		
		public function onmpClick(evt:MouseEvent):void
		{
			
			initArea();
		}
		
		
		private function onLeftBtnOver(evt:MouseEvent):void
		{
			leftBtn.gotoAndPlay(2);
			leftBtn.areaNameText.visible = true;
		}
		
		private function onLeftBtnOut(evt:MouseEvent):void
		{
			leftBtn.gotoAndStop(1);
			leftBtn.areaNameText.visible = false;
		}
		
		private function onRightBtnOver(evt:MouseEvent):void
		{
			rightBtn.gotoAndPlay(2);
			rightBtn.areaNameText.visible = true;
		}
		
		private function onRightBtnOut(evt:MouseEvent):void
		{
			rightBtn.gotoAndStop(1);
			rightBtn.areaNameText.visible = false;
		}
		
		
		private function onLeftBtnClick(evt:MouseEvent):void
		{
			if(roomIndex>=1)
			{
				roomIndex--;
				
				//  todo 加载新区域
				if(currentAreaPage!=null)
				{
					this.removeChild(currentAreaPage);
					currentAreaPage = null;
				}
				currentAreaPage = new AreaPage();
				currentAreaPage.initArea(areasList[roomIndex]);
				this.addChild(currentAreaPage);
				
				areaNav_MC.roomName.text = "返回"+areasList[roomIndex].roomName;
				areaNav_MC.AreaName.text = areasList[roomIndex].name;
				
				this.addChild(leftBtn);
				this.addChild(rightBtn);
				
				this.addChild(areaNav_MC);
				addChild(roomNavIcon);
			}
			else
			{
				return;
			}
			
		}
		
		private function onRightBtnClick(evt:MouseEvent):void
		{
			if(roomIndex<areasList.length-1)
			{
				roomIndex++;
				
				//  todo 加载新区域
				if(currentAreaPage!=null)
				{
					this.removeChild(currentAreaPage);
					currentAreaPage = null;
				}
				currentAreaPage = new AreaPage();
				currentAreaPage.initArea(areasList[roomIndex]);
				this.addChild(currentAreaPage);
				
				areaNav_MC.roomName.text = "返回"+areasList[roomIndex].roomName;
				areaNav_MC.AreaName.text = areasList[roomIndex].name;
				
				this.addChild(leftBtn);
				this.addChild(rightBtn);
				
				this.addChild(areaNav_MC);
				addChild(roomNavIcon);
			}
			else
			{
				return;
			}
			
		}
		
		
		private var isAreaDisplay:Boolean = false;//是正在显示房间还是正在显示区域
		private function OnReturnClicked(evt:MouseEvent):void
		{
			trace("..........OnReturnClicked.........");
			if(!isAreaDisplay)
			{
				ExternalInterface.call("CloseFrame", areasList[roomIndex].roomName);
				
				var returnHome:TaoshiEvent = new TaoshiEvent(TaoshiEvent.TaoshiEvent_Return_Home_Event,true);
				
				this.dispatchEvent(returnHome);
			}
			else
			{
				//initRoom(circleImageVO);
				var openRoom_Handler_Event:TaoshiEvent = new TaoshiEvent(TaoshiEvent.TaoshiEvent_OpenRoom_Handler_Event,true);
				
				openRoom_Handler_Event.imageVo = circleImageVO;
				
				this.dispatchEvent(openRoom_Handler_Event);
			}
		}
		
		
		private function iconComp():void
		{
			addChild(roomNavIcon);
			roomNavIcon.x = (Global.stageW - roomNavIcon.bitmap.width)/2;
			roomNavIcon.y = (Global.stageH - roomNavIcon.bitmap.height)/2;
			roomNavIcon.scaleX = roomNavIcon.scaleY = 0.1;
			
			var rate:Number = Global.stageW/1366;
			
			TweenLite.to(roomNavIcon,0.8,{x:25*rate,y:10*rate,scaleX:0.75,scaleY:0.75,delay:0.8,onComplete:IonComplete});
		}
		
		public function IonComplete():void
		{
			var rate:Number = Global.stageW/1366;
			areaNav_MC.visible =true;
			areaNav_MC.x = -areaNav_MC.width;
			areaNav_MC.y = 80*rate;
			this.addChild(areaNav_MC);
			addChild(roomNavIcon);
			
			TweenLite.to(areaNav_MC,1,{x:0});
		}
		
		public var roomIndex:int = 0;
		public var currentAreaPage:AreaPage;
		
		private var roomName:String = ""; 
		private var circleImageVO:CircleImageVO;
		
		private var bar:SpaFront = new SpaFront();
		public function initRoom(vo:CircleImageVO):void
		{
			isAreaDisplay = false;
			circleImageVO = vo;
			var rate:Number = Global.stageW/1366;
			roomNavIcon = new PictureBG(vo.imageUrl,1,"",iconComp);
			
			roomName = vo.name;//vo.title;
			areasList = AreaVO.GetRoomAreasByRoomName(roomName);
			trace("initRoom : ",roomName);
			
			roomIndex = 0;
			
			areaNav_MC.scaleX = areaNav_MC.scaleY = 0.6*rate;
			areaNav_MC.y = 60*rate;
			areaNav_MC.x = -areaNav_MC.width;
			areaNav_MC.ReturnBtn.addEventListener(MouseEvent.CLICK,OnReturnClicked,false,0,true);
			areaNav_MC.ReturnBtn.buttonMode = true;
			areaNav_MC.AreaName.text = areasList[roomIndex].roomName;//"abcdefghigklmn";//vo.title;
			areaNav_MC.visible =false;
			
			areaNav_MC.roomName.text = "返回乐淘小镇";
			roomNavIcon.buttonMode = true;
			roomNavIcon.addEventListener(MouseEvent.CLICK,OnReturnClicked,false,0,true);
			
			this.addChild(areaNav_MC);
			this.addChild(roomNavIcon);
			leftBtn.visible = rightBtn.visible = false;
			
			this.addChild(bar);
			bar.bg.height = Global.stageH;
			bar.btn1.buttonMode = true;
			bar.btn2.buttonMode = true;
			bar.btn3.buttonMode = true;
			bar.btn4.buttonMode = true;
			if(areasList[roomIndex].roomName == "SPA会所")
			{
				bar.btn1.text.text = "洗浴区";
				bar.btn2.text.text = "护理区";
				bar.btn3.text.text = "美发区";
				bar.btn4.text.text = "化妆区";
				
			}
			
			if(areasList[roomIndex].roomName == "艺术画廊")
			{
				bar.btn1.text.text = "画廊一区";
				bar.btn2.text.text = "画廊二区";
				bar.btn3.text.text = "画廊三区";
				bar.btn4.visible = false;
				
			}
			if(areasList[roomIndex].roomName == "影剧院")
			{
				bar.btn1.text.text = "影厅一";
				bar.btn2.text.text = "影厅二";
				bar.btn3.text.text = "影厅三";
				bar.btn4.visible = false;
				
				roomNavIcon.scaleX = roomNavIcon.scaleY = 0.65*rate;
				roomNavIcon.x = 25*rate;
				roomNavIcon.y = 10*rate;
			}
			
			
			bar.btn1.addEventListener(MouseEvent.CLICK,onbar1MouseClick);
			bar.btn1.buttonMode = bar.btn1.buttonMode =bar.btn1.buttonMode =bar.btn1.buttonMode = true;
			bar.btn2.addEventListener(MouseEvent.CLICK,onbar2MouseClick);
			bar.btn3.addEventListener(MouseEvent.CLICK,onbar3MouseClick);
			bar.btn4.addEventListener(MouseEvent.CLICK,onbar4MouseClick);
		//	BG = new PictureBG("assets/pic/area/TheatreBG.jpg",1,"",mainBG1Comp);
			
			frontBar = new FrontBar();
			frontBar.initBGByBGURL(vo.bgUrl);
			this.addChild(frontBar);
			//frontBar.addEventListener(MouseEvent.MOUSE_UP,onmpClick,false,0,true);
		}
		
		private function onbar1MouseClick(evt:MouseEvent):void
		{
			roomIndex = 0;
			initArea();
		}
		
		private function onbar2MouseClick(evt:MouseEvent):void
		{
			roomIndex = 1;
			initArea();
		}
		
		private function onbar3MouseClick(evt:MouseEvent):void
		{
			roomIndex = 2;
			initArea();
		}
		
		private function onbar4MouseClick(evt:MouseEvent):void
		{
			roomIndex = 3;
			initArea();
		}
		
		public function initArea():void
		{
		//	BG.visible = false;
			bar.visible = false;
			isAreaDisplay = true;
			frontBar.visible = false;
			leftBtn.visible = rightBtn.visible = true;
			
			if(areasList.length>0)
			{
				
				if(currentAreaPage!=null)
				{
					this.removeChild(currentAreaPage);
					currentAreaPage = null;
				}
				currentAreaPage = new AreaPage();
				currentAreaPage.initArea(areasList[roomIndex]);
				this.addChild(currentAreaPage);
				
				leftBtn.areaNameText.text = "left";
				leftBtn.y = ( Global.stageH - leftBtn.height)/2-60;
				
				rightBtn.y = ( Global.stageH - rightBtn.height)/2-60;
				
				rightBtn.x = Global.stageW;
				
				leftBtn.areaNameText.visible = false;
				rightBtn.areaNameText.visible = false;
				this.addChild(leftBtn);
				this.addChild(rightBtn);
				
				
				areaNav_MC.roomName.text = "返回"+areasList[roomIndex].roomName;
				areaNav_MC.AreaName.text = areasList[roomIndex].name;
				this.addChild(areaNav_MC);
				this.addChild(roomNavIcon);
				
				trace("AreaName:",areasList[roomIndex].name);
			}
			
			
			//if(roomName != "Theatre" || roomName != "Gallery")
			//{
				
			//}
			if(roomName == "Theatre" || roomName == "Gallery")
			{
				//areaNav_MC.visible = false;
				leftBtn.visible = false;
				rightBtn.visible = false;
				roomNavIcon.visible = false;
				//areaNav_MC
			}
			if(roomName == "Theatre")
			{
				currentAreaPage.initTheatre();//initGallery();
			}
			
			if(roomName == "Gallery")
			{
				currentAreaPage.initGallery();
			}
		}
		
		public function onResized(w:Number,h:Number):void
		{
			var rate:Number = Global.stageW/1366;
			
			if(currentAreaPage!=null&&this.contains(currentAreaPage))
			{
				this.addChild(currentAreaPage);
				currentAreaPage.onResized(w,h);
			}
			
			if(frontBar!=null&&this.contains(frontBar))
			{
				frontBar.onResized();
			}
			
			if(areaNav_MC!=null)
			{
				areaNav_MC.scaleX = areaNav_MC.scaleY = 0.6*rate;
				areaNav_MC.y = 80*rate;
				this.addChild(areaNav_MC);
			}
			
//			if(roomNavIcon!=null)
//			{
//				roomNavIcon.scaleX = roomNavIcon.scaleY = 0.85*rate;
//				roomNavIcon.x = 25*rate;
//				roomNavIcon.y = 10*rate;
//				this.addChild(roomNavIcon);
//			}
			
			if(areasList[roomIndex].roomName == "SPA会所")
			{
				roomNavIcon.scaleX = roomNavIcon.scaleY = 0.85*rate;
				roomNavIcon.x = 25*rate;
				roomNavIcon.y = 10*rate;
				this.addChild(roomNavIcon);
			}
			
			if(areasList[roomIndex].roomName == "艺术画廊")
			{
				roomNavIcon.scaleX = roomNavIcon.scaleY = 0.65*rate;
				roomNavIcon.x = 25*rate;
				roomNavIcon.y = 10*rate;
				this.addChild(roomNavIcon);
			}
			if(areasList[roomIndex].roomName == "影剧院")
			{
				roomNavIcon.scaleX = roomNavIcon.scaleY = 0.65*rate;
				roomNavIcon.x = 25*rate;
				roomNavIcon.y = 10*rate;
				this.addChild(roomNavIcon);
			}
			
			
			if(rightBtn!=null)
			{
			 this.addChild(bar);
			}
			
			
			if(leftBtn!=null)
			{
				leftBtn.areaNameText.text = "left";
				leftBtn.y = ( Global.stageH - leftBtn.height)/2-60;
				this.addChild(leftBtn);
			}
			
			if(rightBtn!=null)
			{
				rightBtn.y = ( Global.stageH - rightBtn.height)/2-60;
				
				rightBtn.x = Global.stageW;
				this.addChild(rightBtn);
			}
			
			if(bar.bg!=null)
			{
				bar.bg.height = Global.stageH;
			}
		}
	}
}