package com.jerrygao.touchscreen
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.jerrygao.Global;
	import com.jerrygao.net.ImageLoader;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class IntroducePage extends Sprite
	{

		private var IntroduceXML:XML = Global.wenziXml;//yiju:XMLList = Global.albumsXml.yiju;
		
		//
		
		
		[Embed(source="/assets/Introduce/Introduce1.png")]
		private var Introduce1_img:Class;
		[Embed(source="/assets/Introduce/Introduce2.png")]
		private var Introduce2_img:Class;
		[Embed(source="/assets/Introduce/Introduce3.png")]
		private var Introduce3_img:Class;
		[Embed(source="/assets/Introduce/Introduce4.png")]
		private var Introduce4_img:Class;
		[Embed(source="/assets/Introduce/Introduce5.png")]
		private var Introduce5_img:Class;
		[Embed(source="/assets/Introduce/Introduce6.png")]
		private var Introduce6_img:Class;
		
		private var pNum:int;
		
		private var Introduce1:ImageLoader;
		private var Introduce2:ImageLoader;
		private var Introduce3:ImageLoader;
		private var Introduce4:ImageLoader;
		private var Introduce5:ImageLoader;
		private var Introduce6:ImageLoader;
		public function IntroducePage():void
		{
			super();
			
			//initPage();
			initPageByXML();
		}
		
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
		
		public function showPage(pageNum:int = 1):void
		{
			pNum = pageNum;
			while(this.numChildren>0)
			{
				removeChildAt(0);
			}
			var offY:int = 0;
			if(Global.stageScale == 900)
			{
				offY = 230;
			}
			switch(pNum)
			{
				case 1:
					menutext1 = new BtnSprite("menutext1",new menutext1_img());
					menutext1.x = 145;
					menutext1.y = 130*Global.scaleStageY900;
					this.addChild(menutext1);
					Introduce1.scaleX = Introduce1.scaleY = 0.5;
					addChild(Introduce1);
					Introduce1.y = -800;
					TweenLite.to(Introduce1,1.2, {y:650,x:900, ease:Back.easeInOut, onComplete:onFinishTweenS});
					
					break;
				case 2:
					menutext2 = new BtnSprite("menutext2",new menutext2_img());
					menutext2.x = 145;
					menutext2.y = 130*Global.scaleStageY900;
					this.addChild(menutext2);
					addChild(Introduce2);
					Introduce2.y =  -800;
					TweenLite.to(Introduce2,1.2, {y:650,x:900, ease:Back.easeInOut, onComplete:onFinishTweenS2});
					
					break;
				case 3:
					menutext3 = new BtnSprite("menutext3",new menutext3_img());
					menutext3.x = 145;
					menutext3.y = 130*Global.scaleStageY900;
					this.addChild(menutext3);
					addChild(Introduce3);
					Introduce3.y =  -800;
					TweenLite.to(Introduce3,1.2, {y:650,x:900, ease:Back.easeInOut, onComplete:onFinishTweenS3});
					
					break;
				case 4:
					menutext4 = new BtnSprite("menutext4",new menutext4_img());
					menutext4.x = 145;
					menutext4.y = 130*Global.scaleStageY900;
					this.addChild(menutext4);
					addChild(Introduce4);
					Introduce4.y =  -800;
					TweenLite.to(Introduce4,1.2, {y:650,x:900, ease:Back.easeInOut, onComplete:onFinishTweenS4});
					

					break;
				case 5:
					menutext5 = new BtnSprite("menutext5",new menutext5_img());
					menutext5.x = 145;
					menutext5.y = 130*Global.scaleStageY900;
					this.addChild(menutext5);
					addChild(Introduce5);
					Introduce5.y =  -800;
					//TweenLite.to(Introduce5,0.5, {y:300, ease:Back.easeInOut});
					TweenLite.to(Introduce5,1.2, {y:650,x:900, ease:Back.easeInOut, onComplete:onFinishTweenS5});
					

					break;
				case 6:
					menutext6 = new BtnSprite("menutext6",new menutext6_img());
					menutext6.x = 145;
					menutext6.y = 130*Global.scaleStageY900;
					this.addChild(menutext6);
					addChild(Introduce6);
					Introduce6.y =  -800;
					//TweenLite.to(Introduce6,0.5, {y:0, ease:Back.easeInOut});
					TweenLite.to(Introduce6,1.2, {y:650,x:900, ease:Back.easeInOut, onComplete:onFinishTweenS6});
					

					break;
			}
		}
		
       private var sy:int = 300;
		private function onFinishTweenS():void
		{
			TweenLite.to(Introduce1,0.8, {x:0,y:sy,scaleX:1.0,scaleY:1.0, ease:Back.easeInOut});
		}
		
		private function onFinishTweenS2():void
		{
			TweenLite.to(Introduce2,0.8, {x:0,y:sy,scaleX:1.0,scaleY:1.0, ease:Back.easeInOut});
		}
		
		private function onFinishTweenS3():void
		{
			TweenLite.to(Introduce3,0.8, {x:0,y:sy,scaleX:1.0,scaleY:1.0, ease:Back.easeInOut});
		}
		
		private function onFinishTweenS4():void
		{
			TweenLite.to(Introduce4,0.8, {x:0,y:sy,scaleX:1.0,scaleY:1.0, ease:Back.easeInOut});
		}
		
		private function onFinishTweenS5():void
		{
			TweenLite.to(Introduce5,0.8, {x:0,y:sy,scaleX:1.0,scaleY:1.0, ease:Back.easeInOut});
		}
		
		private function onFinishTweenS6():void
		{
			TweenLite.to(Introduce6,0.8, {x:0,y:sy,scaleX:1.0,scaleY:1.0, ease:Back.easeInOut});
		}
		
		private function initPageByXML():void
		{
			//var xingfu:XMLList = IntroduceXML.gaikuang;
			var Introduce1url:String = IntroduceXML.gaikuang[0].pic[0].@url;
			var Introduce2url:String = IntroduceXML.wenhua[0].pic[0].@url;
			var Introduce3url:String = IntroduceXML.shili[0].pic[0].@url;
			var Introduce4url:String = IntroduceXML.shengtai[0].pic[0].@url;
			var Introduce5url:String = IntroduceXML.yiju[0].pic[0].@url;
			var Introduce6url:String = IntroduceXML.xingfu[0].pic[0].@url;
			
			Introduce1 = new ImageLoader(Introduce1url);
			Introduce2 = new ImageLoader(Introduce2url);
			Introduce3 = new ImageLoader(Introduce3url);
			Introduce4 = new ImageLoader(Introduce4url);
			Introduce5 = new ImageLoader(Introduce5url);
			Introduce6 = new ImageLoader(Introduce6url);
			Introduce1.scaleX = Introduce2.scaleX = Introduce3.scaleX = Introduce4.scaleX = Introduce5.scaleX = Introduce6.scaleX = Global.scaleStage;
			Introduce1.scaleY = Introduce2.scaleY = Introduce3.scaleY = Introduce4.scaleY = Introduce5.scaleY = Introduce6.scaleY = Global.scaleStage;
			
			//Introduce1.y = Introduce2.y = Introduce3.y =Introduce4.y = Introduce5.y= Introduce6.y = 300;
			this.addEventListener(MouseEvent.MOUSE_DOWN ,onstageMouseDown,false,0,true);
			/*Introduce1.y = (stage.stageHeight - Introduce1.height)/2;
			Introduce2.y = (stage.stageHeight - Introduce1.height)/2;
			Introduce3.y = (stage.stageHeight - Introduce1.height)/2;
			Introduce4.y = (stage.stageHeight - Introduce1.height)/2;
			Introduce5.y = (stage.stageHeight - Introduce1.height)/2;
			Introduce6.y = (stage.stageHeight - Introduce1.height)/2;*/
			
			trace("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
		}

		private function onstageMouseDown(e:MouseEvent):void
		{
			
			trace("yyyyyyyyyyyyy");
			this.dispatchEvent(new HuaDianEvents(HuaDianEvents.SHOW_Introduce_HuaDianEvents,true));
		}
		
	}
}