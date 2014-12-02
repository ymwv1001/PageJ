package com.jerrygao.touchscreen
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.jerrygao.Global;
	import com.jerrygao.net.ImageLoader;
	import com.jerrygao.net.XMLLoader;
	import com.jerrygao.touchscreen.albums.Album;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class IndexPage extends Sprite
	{
		//[Embed(source="assets/start.png")]
		private var startimg:ImageLoader;
		//private var iconsPorsionXArr:Array;
		//private var iconsPorsionYArr:Array;
	//	private var isAction:Boolean;
		
		private var introducePage:IntroducePage;
		
		private var album:Album;
		
		private var albumsXmlLoader:XMLLoader;
		private var wenziXmlLoader:XMLLoader;
		
		private var myTimer:Timer = new Timer(1000*100, 0);
		
		public function IndexPage()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			startimg = new ImageLoader("assets/start.png");
			addChild(startimg);
			
			startimg.x = (stage.stageWidth - 236)/2;
			startimg.y = (stage.stageHeight - 93)/2;
			startimg.alpha = 0;
			
			
			TweenLite.to(startimg,2.5, { alpha:1, ease:Back.easeOut, delay:0.5, onComplete:onStartimgFinishTween } );
			loadeXMLS();
			
			myTimer.addEventListener("timer", timerHandler);
			myTimer.start();
			
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown,false,0,true);
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			resetTime();
		}
		
		public function timerHandler(event:TimerEvent):void {
			trace("timerHandler: " + event);
			if(album != null&&this.contains(album))
			{
				this.removeChild(album);
			album.removeEventListener(HuaDianEvents.MAIN_MENU_Return,onReturned);
			album.removeEventListener(HuaDianEvents.MOUSE_ACTION_HAPENED,onMouseHpend);
			album = null;
			}
			waitigpage.visible = true;
			waitigpage.startMove();
			myTimer.stop();
		}
		
		
		public function resetTime():void
		{
			myTimer.reset();
			myTimer.start();
		}
		
		private function loadeXMLS():void
		{
			albumsXmlLoader = new XMLLoader();
			albumsXmlLoader.loaderXML("assets/AlbumsConfig.xml",onAlbumsXMLLoaded); 
		}
		
		private function onAlbumsXMLLoaded():void
		{
			Global.albumsXml = albumsXmlLoader.externalXML;
			trace("ddd...........onAlbumsXMLLoaded");
			wenziXmlLoader = new XMLLoader();
			wenziXmlLoader.loaderXML("assets/IntroduceConfig.xml",onwenziXMLLoaded); 
		}
		
		private function onwenziXMLLoaded():void
		{
			trace("ddd...........onwenziXMLLoaded");
			Global.wenziXml = wenziXmlLoader.externalXML;
			
			
			introducePage = new IntroducePage();
			addChildAt(introducePage,this.numChildren);
			introducePage.addEventListener(HuaDianEvents.SHOW_Introduce_HuaDianEvents,ShowAlbums,false,0,true);
			
		}
		
		private function onReturned(e:HuaDianEvents):void
		{
			this.removeChild(album);
			album.removeEventListener(HuaDianEvents.MAIN_MENU_Return,onReturned);
			album.removeEventListener(HuaDianEvents.MOUSE_ACTION_HAPENED,onMouseHpend);
			album = null;
			waitigpage.visible = true;
			waitigpage.onstageMouseDown(null);
			//waitigpage.startMove();
			
			//myTimer.stop();
			myTimer.reset();
			myTimer.start();
		}
		//768*6    1366
		//4608
		private function onMouseHpend(e:HuaDianEvents):void
		{
			myTimer.reset();
			myTimer.start();
		}
		
		private function ShowAlbums(e:HuaDianEvents):void
		{
			album = new Album();
			addChildAt(album,this.numChildren);
			album.addEventListener(HuaDianEvents.MAIN_MENU_Return,onReturned,false,0,true);
			album.addEventListener(HuaDianEvents.MOUSE_ACTION_HAPENED,onMouseHpend,false,0,true);
			//onMouseActionHapend()
			switch(showState)
			{
				case 1:
					showState = 101;
					addChildAt(album,this.numChildren);
					break;
				case 2:
					showState = 102;
					addChildAt(album,this.numChildren);
					break;
				case 3:
					showState = 103;
					addChildAt(album,this.numChildren);
					break;
				case 4:
					showState = 104;
					addChildAt(album,this.numChildren);
					break;
				case 5:
					showState = 105;
					addChildAt(album,this.numChildren);
					break;
				case 6:
					showState = 106;
					addChildAt(album,this.numChildren);
					break;
			}
			album.loadPhotoesByState(showState);
			this.removeChild(introducePage);
			introducePage.removeEventListener(HuaDianEvents.SHOW_Introduce_HuaDianEvents,ShowAlbums);
			introducePage = null;
			
			//introducePage = new IntroducePage();
			//addChildAt(introducePage,this.numChildren);
			//introducePage.addEventListener(HuaDianEvents.SHOW_Introduce_HuaDianEvents,ShowAlbums,false,0,true);
			
		}
		
		private function onStartimgFinishTween():void
		{
			TweenLite.to(startimg,1.2, { alpha:0, ease:Back.easeOut, onComplete:onStartimgFinishTween2 } );
		}
		
		public var waitigpage:WaitingPage; 
		
		private function onStartimgFinishTween2():void
		{
			waitigpage = new WaitingPage();
			addChild(waitigpage);
			
			waitigpage.addEventListener(HuaDianEvents.MAIN_MENU_1,mainmenu_1,false,0,true);
			waitigpage.addEventListener(HuaDianEvents.MAIN_MENU_2,mainmenu_2,false,0,true);
			waitigpage.addEventListener(HuaDianEvents.MAIN_MENU_3,mainmenu_3,false,0,true);
			waitigpage.addEventListener(HuaDianEvents.MAIN_MENU_4,mainmenu_4,false,0,true);
			waitigpage.addEventListener(HuaDianEvents.MAIN_MENU_5,mainmenu_5,false,0,true);
			waitigpage.addEventListener(HuaDianEvents.MAIN_MENU_6,mainmenu_6,false,0,true);

		}
		
		private var showState:int = 0;
		private function mainmenu_1(evt:HuaDianEvents):void
		{
			showState = 1;
			trace("这里加载文字介绍画面----------------" + showState);
			
			//TODO加载不同的IntroducePage，根据showState；
			if(introducePage == null)
			{
				introducePage = new IntroducePage();
			introducePage.addEventListener(HuaDianEvents.SHOW_Introduce_HuaDianEvents,ShowAlbums,false,0,true);
			}
			addChildAt(introducePage,this.numChildren);
			introducePage.showPage(showState);
			
			waitigpage.visible = false;
			
			myTimer.reset();
			myTimer.start();
		}
		
		private function mainmenu_2(evt:HuaDianEvents):void
		{
			showState = 2;
			trace("这里加载文字介绍画面----------------" + showState);
			if(introducePage == null)
			{
				introducePage = new IntroducePage();
			introducePage.addEventListener(HuaDianEvents.SHOW_Introduce_HuaDianEvents,ShowAlbums,false,0,true);
			}
			addChildAt(introducePage,this.numChildren);
			introducePage.showPage(showState);
			
			waitigpage.visible = false;
			
			myTimer.reset();
			myTimer.start();
		}
		
		private function mainmenu_3(evt:HuaDianEvents):void
		{
			showState = 3;
			trace("这里加载文字介绍画面----------------" + showState);
			if(introducePage == null)
			{
				introducePage = new IntroducePage();
			introducePage.addEventListener(HuaDianEvents.SHOW_Introduce_HuaDianEvents,ShowAlbums,false,0,true);
			}
			addChildAt(introducePage,this.numChildren);
			introducePage.showPage(showState);
			
			waitigpage.visible = false;
			
			myTimer.reset();
			myTimer.start();
		}
		
		private function mainmenu_4(evt:HuaDianEvents):void
		{
			showState = 4;
			trace("这里加载文字介绍画面----------------" + showState);
			if(introducePage == null)
			{
				introducePage = new IntroducePage();
			introducePage.addEventListener(HuaDianEvents.SHOW_Introduce_HuaDianEvents,ShowAlbums,false,0,true);
			}
			addChildAt(introducePage,this.numChildren);
			introducePage.showPage(showState);
			
			waitigpage.visible = false;
			
			myTimer.reset();
			myTimer.start();
		}
		
		private function mainmenu_5(evt:HuaDianEvents):void
		{
			showState = 5;
			trace("这里加载文字介绍画面----------------" + showState);
			if(introducePage == null)
			{
				introducePage = new IntroducePage();
			introducePage.addEventListener(HuaDianEvents.SHOW_Introduce_HuaDianEvents,ShowAlbums,false,0,true);
			}
			addChildAt(introducePage,this.numChildren);
			introducePage.showPage(showState);
			
			waitigpage.visible = false;
			
			myTimer.reset();
			myTimer.start();
		}
		
		private function mainmenu_6(evt:HuaDianEvents):void
		{
			showState = 6;
			trace("这里加载文字介绍画面");
			if(introducePage == null)
			{
				introducePage = new IntroducePage();
			introducePage.addEventListener(HuaDianEvents.SHOW_Introduce_HuaDianEvents,ShowAlbums,false,0,true);
			}
			addChildAt(introducePage,this.numChildren);
			introducePage.showPage(showState);
			
			waitigpage.visible = false;
			
			myTimer.reset();
			myTimer.start();
		}
	}
}