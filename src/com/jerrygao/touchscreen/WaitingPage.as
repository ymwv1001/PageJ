package com.jerrygao.touchscreen
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.jerrygao.Global;
	import com.jerrygao.touchscreen.HuaDianEvents;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class WaitingPage extends Sprite
	{
		[Embed(source="/assets/bg/guangraoBg1.jpg")]
		private var wait_bg1_img:Class;
		private var waitbgimg1:Bitmap;
		
		[Embed(source="/assets/bg/guangraoBg2.jpg")]
		private var wait_bg2_img:Class;
		private var waitbgimg2:Bitmap;
		
		[Embed(source="/assets/bg/guangraoBg3.jpg")]
		private var wait_bg3_img:Class;
		private var waitbgimg3:Bitmap;
		
		[Embed(source="/assets/bg/guangraoBg4.jpg")]
		private var wait_bg4_img:Class;
		private var waitbgimg4:Bitmap;
		
		
		private var bg:Sprite = new Sprite();;
		//menuicon1.png
		
		[Embed(source="/assets/menuicon/menuicon1.png")]
		private var menuicon1_img:Class;
		[Embed(source="/assets/menuicon/menuicon2.png")]
		private var menuicon2_img:Class;
		[Embed(source="/assets/menuicon/menuicon3.png")]
		private var menuicon3_img:Class;
		[Embed(source="/assets/menuicon/menuicon4.png")]
		private var menuicon4_img:Class;
		[Embed(source="/assets/menuicon/menuicon5.png")]
		private var menuicon5_img:Class;
		[Embed(source="/assets/menuicon/menuicon6.png")]
		private var menuicon6_img:Class;
		
		private var menuicon1:BtnSprite;
		private var menuicon2:BtnSprite;
		private var menuicon3:BtnSprite;
		private var menuicon4:BtnSprite;
		private var menuicon5:BtnSprite;
		private var menuicon6:BtnSprite;
		
		
		[Embed(source="/assets/menutext/menutext1.png")]
		private var menutext1_img:Class;
		[Embed(source="/assets/menutext/menutext2.png")]
		private var menutext2_img:Class;
		[Embed(source="/assets/menutext/menutext3.png")]
		private var menutext3_img:Class;
		[Embed(source="/assets/menutext/menutext4.png")]
		private var menutext4_img:Class;
		[Embed(source="/assets/menutext/menutext5.png")]
		private var menutext5_img:Class;
		[Embed(source="/assets/menutext/menutext6.png")]
		private var menutext6_img:Class;
		
		private var menutext1:BtnSprite;
		private var menutext2:BtnSprite;
		private var menutext3:BtnSprite;
		private var menutext4:BtnSprite;
		private var menutext5:BtnSprite;
		private var menutext6:BtnSprite;
		
		 private var menutext62:BtnSprite;
		private var bgnum:int = 1;
		public var isAction:Boolean;
		public function WaitingPage()
		{
			super();
			
			addChild(bg);
			isAction = false;
			waitbgimg1 = new wait_bg1_img();
			waitbgimg1.scaleX = Global.scaleStage;
			waitbgimg1.scaleY = Global.scaleStageY900;
			
			waitbgimg2 = new wait_bg2_img();
			waitbgimg2.scaleX = Global.scaleStage;
			waitbgimg2.scaleY =Global.scaleStageY900;
			
			waitbgimg3 = new wait_bg3_img();
			waitbgimg3.scaleX = Global.scaleStage;
			waitbgimg3.scaleY =Global.scaleStageY900;
			
			waitbgimg4 = new wait_bg4_img();
			waitbgimg4.scaleX = Global.scaleStage;
			waitbgimg4.scaleY = Global.scaleStageY900;
			waitbgimg2.visible = waitbgimg3.visible = waitbgimg4.visible = false;
			waitbgimg4.name = "waitbgimg4";
			waitbgimg3.name = "waitbgimg3";
			waitbgimg2.name = "waitbgimg2";
			waitbgimg1.name = "waitbgimg1";
			bg.alpha=0.2;
			bg.addChild(waitbgimg1);
			bg.addChild(waitbgimg2);
			bg.addChild(waitbgimg3);
			bg.addChild(waitbgimg4);
			//TweenLite.to(bg,5.5, { alpha:1.0, ease:Back.easeOut, delay:0.1, onComplete:onBGFinish});
			
			menuicon1 = new BtnSprite("menuicon1",new menuicon1_img());
			menuicon2 = new BtnSprite("menuicon2",new menuicon2_img());
			menuicon3 = new BtnSprite("menuicon3",new menuicon3_img());
			menuicon4 = new  BtnSprite("menuicon4",new menuicon4_img());
			menuicon5 = new  BtnSprite("menuicon5",new menuicon5_img());
			menuicon6 = new  BtnSprite("menuicon6",new menuicon6_img());
			
			menuicon1.name = "menuicon1";
			menuicon2.name = "menuicon2";
			menuicon3.name = "menuicon3";
			menuicon4.name = "menuicon4";
			menuicon5.name = "menuicon5";
			menuicon6.name = "menuicon6";
			
			addChild(menuicon1);
			addChild(menuicon2);
			addChild(menuicon3);
			addChild(menuicon4);
			addChild(menuicon5);
			addChild(menuicon6);
			
			menutext1 = new BtnSprite("menutext1",new menutext1_img());
			menutext2 = new BtnSprite("menutext2",new menutext2_img());
			menutext3 = new BtnSprite("menutext3",new menutext3_img());
			menutext4 = new BtnSprite("menutext4",new menutext4_img());
			menutext5 = new BtnSprite("menutext5",new menutext5_img());
			menutext6 = new BtnSprite("menutext6",new menutext6_img());
			menutext62 = new BtnSprite("menutext6",new menutext6_img());
			menutext1.visible = menutext2.visible = menutext3.visible = menutext4.visible = menutext5.visible = menutext6.visible = false;
			menutext1.scaleX = menutext2.scaleX = menutext3.scaleX = menutext4.scaleX = menutext5.scaleX = menutext6.scaleX = Global.scaleStage;
			menutext1.scaleY = menutext2.scaleY = menutext3.scaleY = menutext4.scaleY = menutext5.scaleY = menutext6.scaleY = Global.scaleStageY;
			addChild(menutext1);
			addChild(menutext2);
			addChild(menutext3);
			addChild(menutext4);
			addChild(menutext5);
			addChild(menutext6);
			
			
			menutext62.scaleX = menutext62.scaleY = 0.2;
			menutext62.y = -1240*Global.scaleStage;
			addChild(menutext62);
			
			menuicon1.x = 191*Global.scaleStage;
			menuicon2.x = 551*Global.scaleStage;
			menuicon3.x = 901*Global.scaleStage;
			menuicon4.x = 1251*Global.scaleStage;
			menuicon5.x = 1601*Global.scaleStage;
			menuicon6.x = 1951*Global.scaleStage;
			menuicon1.y = menuicon2.y = menuicon3.y = menuicon4.y = menuicon5.y = menuicon6.y = 280*Global.scaleStageY900;
			menuicon1.scaleX = menuicon2.scaleX = menuicon3.scaleX = menuicon4.scaleX = menuicon5.scaleX = menuicon6.scaleX = Global.scaleStage;
			menuicon1.scaleY = menuicon2.scaleY = menuicon3.scaleY = menuicon4.scaleY = menuicon5.scaleY = menuicon6.scaleY = Global.scaleStageY;
			menuicon1.alpha = menuicon2.alpha = menuicon3.alpha = menuicon4.alpha = menuicon5.alpha = menuicon6.alpha = 0;
			
			TweenMax.allTo([menuicon1,menuicon2,menuicon3,menuicon4,menuicon5,menuicon6],1, { alpha:1, delay:0.1 } );
			if(!isAction)
			{
				startMove();
			}
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,onstageMouseDown,false,0,true);
		}
		
		private function changeBg():void
		{
			switch(bgnum)
			{
				case 1:
					bg.alpha=0.2;
					waitbgimg1.visible = true;
					TweenLite.to(bg,5.5, { alpha:1.0, ease:Back.easeOut, delay:0.1, onComplete:onBGFinish});
					waitbgimg2.visible = waitbgimg3.visible = waitbgimg4.visible = false;
					break;
				case 2:
					bg.alpha=0.2;
					waitbgimg2.visible = true;
					TweenLite.to(bg,5.5, { alpha:1.0, ease:Back.easeOut, delay:0.1, onComplete:onBGFinish});
					waitbgimg1.visible = waitbgimg3.visible = waitbgimg4.visible = false;
					break;
				case 3:
					bg.alpha=0.2;
					waitbgimg3.visible = true;
					TweenLite.to(bg,5.5, { alpha:1.0, ease:Back.easeOut, delay:0.1, onComplete:onBGFinish});
					waitbgimg2.visible = waitbgimg1.visible = waitbgimg4.visible = false;
					break;
				case 4:
					bg.alpha=0.2;
					waitbgimg4.visible = true;
					TweenLite.to(bg,5.5, { alpha:1.0, ease:Back.easeOut, delay:0.1, onComplete:onBGFinish});
					waitbgimg2.visible = waitbgimg3.visible = waitbgimg1.visible = false;
					break;
			}
		}
		
		public function onBGFinish():void
		{
			if(bgnum<4)
			{
				bgnum ++;
			}else{
				bgnum = 1;
			}
			changeBg();
			
		}
		
		public function startMove():void
		{
			trace("startMove-------------");
			if(mapimg!= null&& this.contains(mapimg))this.removeChild(mapimg);
			bg.visible = true;
			onBGFinish();
			isAction = false;
			menutext1.visible = menutext2.visible = menutext3.visible = menutext4.visible = menutext5.visible = menutext6.visible = false;
			menuicon1.y = menuicon2.y = menuicon3.y = menuicon4.y = menuicon5.y = menuicon6.y =280*Global.scaleStageY900;
			tweenS();
		}
		
		
		private function onBtnMouseDown(e:MouseEvent):void
		{
			var bname:String = (e.currentTarget as DisplayObject).name;
			trace("target ------------" + bname);
			switch(bname)
			{
				case "menuicon1":
					//获得当前播放列表
					this.dispatchEvent(new HuaDianEvents(HuaDianEvents.MAIN_MENU_1,true));
					break;
				case "menuicon2":
					this.dispatchEvent(new HuaDianEvents(HuaDianEvents.MAIN_MENU_2,true));
					break;
				case "menuicon3":
					this.dispatchEvent(new HuaDianEvents(HuaDianEvents.MAIN_MENU_3,true));
					break;
				case "menuicon4":
					this.dispatchEvent(new HuaDianEvents(HuaDianEvents.MAIN_MENU_4,true));
					break;
				case "menuicon5":
					this.dispatchEvent(new HuaDianEvents(HuaDianEvents.MAIN_MENU_5,true));
					break;
				case "menuicon6":
					this.dispatchEvent(new HuaDianEvents(HuaDianEvents.MAIN_MENU_6,true));
					break;
			}
		}
		
		[Embed(source="/assets/nav_mapbg.png")]
		private var nav_mapbg:Class;
		private var mapimg:Bitmap;
		public function onstageMouseDown(e:MouseEvent):void
		{
			//trace("onstageMouseDown ------------" + (e.currentTarget as DisplayObject).name);
			if(!isAction)
			{
				isAction = true;
				bg.visible = false;
				//this.removeChild(bg);
//				while(bg.numChildren>0)
//				{
//					bg.removeChildAt(0);
//				}
				//this.removeEventListener(MouseEvent.MOUSE_DOWN,onstageMouseDown);
				//if(actionpage == null)actionpage = new ActionPage();
				//addChild(actionpage);
				mapimg = new nav_mapbg();
				mapimg.alpha=0;
				addChild(mapimg);
				mapimg.scaleX = Global.scaleStage;
				mapimg.scaleY = Global.scaleStageY900;
				mapimg.smoothing = true;
				mapimg.x = (stage.stageWidth - 429)/2;
				mapimg.y = 100;
				TweenLite.to(mapimg,0.5, {alpha:1, ease:Back.easeOut } );
				
				//TweenMax.allTo([menuicon1,menuicon2,menuicon3,menuicon4,menuicon5,menuicon6],1.5, { y:280, delay:0.5 } );
			}
		}
		
		private function goActionState():void
		{

			TweenMax.allTo([menuicon1,menuicon2,menuicon3,menuicon4,menuicon5,menuicon6],0.3, { y:350*Global.scaleStageY900, onComplete:onFinishGoAction});
		
		    
			
		}
		
		private function onFinishGoAction():void
		{
			menutext1.visible = menutext2.visible = menutext3.visible = menutext4.visible = menutext5.visible = menutext6.visible = true;
			menuicon1.y = menuicon2.y = menuicon3.y = menuicon4.y = menuicon5.y = menuicon6.y =350*Global.scaleStageY900;
			
			menuicon1.x = 105*Global.scaleStage;
			menuicon2.x = 495*Global.scaleStage;
			menuicon3.x = 875*Global.scaleStage;
			menuicon4.x = 1260*Global.scaleStage;
			menuicon5.x = 1645*Global.scaleStage;
			menuicon6.x = 2035*Global.scaleStage;
			
			//TweenLite.to(menuicon1,0.5, { x:201*Global.scaleStage});
			//TweenLite.to(menuicon2,0.5, { x:551*Global.scaleStage});
			//TweenLite.to(menuicon3,0.5, { x:901*Global.scaleStage});
			//TweenLite.to(menuicon4,0.5, { x:1251*Global.scaleStage});
			//TweenLite.to(menuicon5,0.5, { x:1601*Global.scaleStage});
			//TweenLite.to(menuicon6,0.5, { x:1951*Global.scaleStage});
			
			var offY:int = 0; 
			if(Global.stageScale == 900)
			{
				offY = 100;
			}
			menutext1.y = 190*Global.scaleStageY900 + offY;
			
			menutext2.y = menutext3.y = menutext4.y = 170*Global.scaleStageY900 + offY;
			
			menutext6.y = 160*Global.scaleStageY900 + offY;
			menutext5.y = 180*Global.scaleStageY900 + offY;
			
			menutext1.x = menuicon1.x + 30*Global.scaleStage;
			menutext2.x = menuicon2.x + 30*Global.scaleStage;
			menutext3.x = menuicon3.x + 30*Global.scaleStage;
			menutext4.x = menuicon4.x + 30*Global.scaleStage;
			menutext5.x = menuicon5.x + 20*Global.scaleStage;
			menutext6.x = menuicon6.x + 20*Global.scaleStage;
			
			menutext1.visible = menutext2.visible = menutext3.visible = menutext4.visible = menutext5.visible = menutext6.visible = true;
			menuicon1.addEventListener(MouseEvent.MOUSE_DOWN,onBtnMouseDown,false,0,true);
			menuicon2.addEventListener(MouseEvent.MOUSE_DOWN,onBtnMouseDown,false,0,true);
			menuicon3.addEventListener(MouseEvent.MOUSE_DOWN,onBtnMouseDown,false,0,true);
			menuicon4.addEventListener(MouseEvent.MOUSE_DOWN,onBtnMouseDown,false,0,true);
			menuicon5.addEventListener(MouseEvent.MOUSE_DOWN,onBtnMouseDown,false,0,true);
			menuicon6.addEventListener(MouseEvent.MOUSE_DOWN,onBtnMouseDown,false,0,true);
		}
		
		private function tweenS():void
		{
			trace("tweenS()-------------");
			menuicon6.alpha = 1;
			TweenLite.to(menuicon1,0.5, { x:350*Global.scaleStage,y:280*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon2,0.5, { x:700*Global.scaleStage,y:280*Global.scaleStageY900+150*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon3,0.5, { x:970*Global.scaleStage, y:280*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon4,0.5, { x:1180*Global.scaleStage,y:280*Global.scaleStageY900-150*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon5,0.5, { x:1450*Global.scaleStage,y:280*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon6,0.5, { x:1750*Global.scaleStage,y:280*Global.scaleStageY900+150*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			//TweenLite.to(menuicon6,0.5, { x:1750,y:280*Global.scaleStage+150*Global.scaleStage, ease:Back.easeOut, delay:0.5, onComplete:onFinishTweenS});
			
			//TweenLite.to(menuicon6,4.0, { alpha:0.5, onComplete:onFinishTweenS});
			TweenLite.to(menutext62,4.0, { y:-600*Global.scaleStage, onComplete:onFinishTweenS});
			//menutext62.y = -1240*Global.scaleStage;
		}
		
		private function onFinishTweenS():void
		{
			trace("onFinishTweenS-------------");
			if(isAction)
			{
				goActionState();
				return;
			}
			TweenMax.allTo([menuicon1,menuicon2,menuicon3,menuicon4,menuicon5,menuicon6],0.2, { y:280*Global.scaleStageY900} );
			tweenS2();
		}
		
		private var scral:Number = Global.scaleStage;
		private function tweenS2():void
		{
			menuicon6.alpha = 1;
			TweenLite.to(menuicon1,0.5, { x:201*Global.scaleStage,y:280*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon2,0.5, { x:551*Global.scaleStage,y:280*Global.scaleStageY900-150*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon3,0.5, { x:901*Global.scaleStage,y:280*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon4,0.5, { x:1251*Global.scaleStage,y:280*Global.scaleStageY900+150*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon5,0.5, { x:1601*Global.scaleStage,y:280*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon6,0.5, { x:1951*Global.scaleStage,y:280*Global.scaleStageY900-150*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			//TweenLite.to(menuicon6,0.5, { x:1951,y:280*scral-150*scral, ease:Back.easeOut, delay:0.5, onComplete:onFinishTweenS2});
			
			TweenLite.to(menuicon6,4, { alpha:0.95, onComplete:onFinishTweenS2});
		}
		
		
		/*23
		menuicon1.x = 201*Global.scaleStage;
		menuicon2.x = 551*Global.scaleStage;
		menuicon3.x = 901*Global.scaleStage;
		menuicon4.x = 1251*Global.scaleStage;
		menuicon5.x = 1601*Global.scaleStage;
		menuicon6.x = 1951*Global.scaleStage;*/
		
		private function onFinishTweenS2():void
		{
			if(isAction)
			{
				goActionState();
				return;
			}
			TweenMax.allTo([menuicon1,menuicon2,menuicon3,menuicon4,menuicon5,menuicon6],0.2, { y:280*Global.scaleStageY900} );
			tweenO();
		}
		
		private function tweenO():void
		{
			menuicon6.alpha = 1;
			TweenLite.to(menuicon1,0.5, { y:280*Global.scaleStageY900 - 200*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon2,0.5, { y:280*Global.scaleStageY900+50*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon3,0.5, { y:280*Global.scaleStageY900 + 200*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon4,0.5, { y:280*Global.scaleStageY900+200*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon5,0.5, { y:280*Global.scaleStageY900+50*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon6,0.5, { y:280*Global.scaleStageY900-200*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			//TweenLite.to(menuicon6,0.5, { y:280*scral-200*scral, ease:Back.easeOut, delay:0.5, onComplete:onFinishTweenO});
			TweenLite.to(menuicon6,4, { alpha:0.95,  onComplete:onFinishTweenO});
		}
		
		private function onFinishTweenO():void
		{
			if(isAction)
			{
				goActionState();
				return;
			}
			TweenMax.allTo([menuicon1,menuicon2,menuicon3,menuicon4,menuicon5,menuicon6],0.2, { y:280*Global.scaleStageY900} );
			tweenO2();
		}
		
		private function tweenO2():void
		{
			menuicon6.alpha = 1;
			TweenLite.to(menuicon1,0.5, { y:280*Global.scaleStageY900 + 200*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon2,0.5, { y:280*Global.scaleStageY900-50*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon3,0.5, { y:280*Global.scaleStageY900 - 200*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon4,0.5, { y:280*Global.scaleStageY900-200*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon5,0.5, { y:280*Global.scaleStageY900-50*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
			TweenLite.to(menuicon6,0.5, { y:280*Global.scaleStageY900+200*Global.scaleStageY900, ease:Back.easeOut, delay:0.3});
		//	TweenLite.to(menuicon6,0.5, { y:280*scral+200*scral, ease:Back.easeOut, delay:0.5, onComplete:onFinishTweenO2});
			TweenLite.to(menuicon6,4, { alpha:0.95,  onComplete:onFinishTweenO2});
		}
		
		private function onFinishTweenO2():void
		{
			if(isAction)
			{
				goActionState();
				return;
			}
			TweenMax.allTo([menuicon1,menuicon2,menuicon3,menuicon4,menuicon5,menuicon6],0.2, { y:280*Global.scaleStageY900} );
			tweenS();
		}
	}
}