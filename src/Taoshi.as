package
{
	import com.greensock.TweenLite;
	import com.jerrygao.Global;
	import com.jerrygao.anfei.AnIndexPage;
	import com.jerrygao.net.Download;
	import com.jerrygao.screen.MovieScale;
	import com.jerrygao.taoshi.RoomsPage;
	import com.jerrygao.taoshi.TaoIndexPage;
	import com.jerrygao.taoshi.TaoshiEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	
	[SWF(backgroundColor="0xffffff", frameRate="30")]
	//[SWF(width=1366, height=700,backgroundColor = "0xcccccc")]
	public class Taoshi extends Sprite
	{
		public function Taoshi()
		{
			
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			
			//this.addChild(mask1);
			
			stage.addEventListener(Event.RESIZE,onResized,false,0,true);
			
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.quality = StageQuality.HIGH;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			onResized(null);
			//Global.SendRectangle(Global.displayX,Global.displayY,Global.stageW,Global.stageH);
			Download.loadSWF("assets/loading.swf",progressfunLoading,completeLoading);
			
		}
		
		private  function progressfunLoading(number:Number):void
		{
			trace(" :",number);
		}
		
		private var loadSwf:Loader;
		private var loading:Loadig_mc = new Loadig_mc();
		private function completeLoading(loader:Loader):void
		{
			loadSwf = loader;
			loadSwf.width=Global.stageW;
			loadSwf.height = Global.stageH;
			loadSwf.x = Global.displayX;
			this.addChild(loadSwf);
			
			Download.loadSWF("assets/movie/tsStart.jpg",progressfun360,complete360);
			
			this.addChild(loading);
			loading.x =Global.displayX + (Global.stageW -90)/2;
			loading.y = (Global.stageH - 90)/2 + 85;
			trace(loading.width,loading.height);
		}
		
		private  function progressfun360(number:Number):void
		{
			loading.loadText.text = number + "%";
		}
		
		private var startmv:MovieScale;
		private var tiaoguo:TiaoguoEn_MC;
		private var loading1:Loadig_mc = new Loadig_mc();
		private function complete360(loader:Loader):void
		{
			//this.removeChild(loading1);
			
			this.removeChild(loadSwf);
			this.removeChild(loading);
			
			startmv = new MovieScale();
			this.addChild(startmv);
			
			tiaoguo = new TiaoguoEn_MC();
			this.addChild(tiaoguo);
			tiaoguo.fhbg.alpha = 0.4;
			tiaoguo.x = Global.displayX + 30;
			tiaoguo.y = stage.stageHeight - 80;
			tiaoguo.addEventListener(MouseEvent.MOUSE_UP,onfanhuihMouseup,false,0,true);
			tiaoguo.addEventListener(MouseEvent.MOUSE_OVER,onfanhuihMouseover,false,0,true);
			tiaoguo.addEventListener(MouseEvent.MOUSE_OUT,onfanhuihMouseout,false,0,true);
			
			startmv.playFlv("assets/movie/tsStart.jpg",0.6,false,OnMVFinish);
			
			onResized(null);
			
		}
		
		private function onfanhuihMouseover(evt:MouseEvent):void
		{
			tiaoguo.fhbg.alpha = 1;
		}
		private function onfanhuihMouseout(evt:MouseEvent):void
		{
			tiaoguo.fhbg.alpha = 0.4;
		}
		
		private function onfanhuihMouseup(evt:MouseEvent):void
		{
			//xiadantxt.visible = true;
			tiaoguo.visible = false;
			OnMVFinish();
		}
		
		private var taoIndex:TaoIndexPage;
		private var roompage:RoomsPage;
		private function OnMVFinish():void
		{
			this.removeChild(tiaoguo);
			Global.fg = "fg1";
			if(startmv&&this.contains(startmv))
			{
				this.removeChild(startmv);
				startmv.clearMV();
				startmv = null;	
			}
			
			taoIndex = new TaoIndexPage();
			taoIndex.addEventListener(TaoshiEvent.TaoshiEvent_OpenRoom_Handler_Event,initRoomPage,false,0,true);
			addChild(taoIndex);
			onResized(null);
		}
		
		
		private var mnainBmp:Bitmap;
		private var sceneMask:SceneMask; 
		private function initRoomPage(evt:TaoshiEvent):void
		{
//			var roomName:String = evt.imageVo.title;
//			trace("roomName : ",roomName);
//			if(roomName != "Theatre"||roomName != "SPA"||roomName != "Gallery")
//			{
//				return;
//			}
			
			

			

			//截图+遮罩动画

			
			var bitmapdata:BitmapData = new BitmapData(Global.stageW,Global.stageH);
			bitmapdata.colorTransform(new Rectangle(Global.displayX, Global.displayY,Global.stageW,Global.stageH), new ColorTransform(0,0,0,0));
			bitmapdata.draw(this,null,null,null,null,true);
			mnainBmp = new Bitmap(bitmapdata);
			mnainBmp.smoothing = true;
			//mnainBmp.x = Global.displayX;
			mnainBmp.y = Global.displayY;
			addChild(mnainBmp);
			
			sceneMask = new SceneMask();
			sceneMask.scaleX = sceneMask.scaleY = 6.5;
			sceneMask.x = Global.displayX+ Global.stageW/2;
			sceneMask.y = Global.displayY+ Global.stageH/2;
			addChild(sceneMask);
			
			mnainBmp.mask = sceneMask;
			
			TweenLite.to(sceneMask,1,{scaleX:0.1,scaleY:0.1,onComplete:sceneMaskComplete});
			
			
			if(roompage&&this.contains(roompage))
			{
				this.removeChild(roompage);
				roompage.removeEventListener(TaoshiEvent.TaoshiEvent_Return_Home_Event,returnHomeHandler);//,false,0,true);
				roompage.removeEventListener(TaoshiEvent.TaoshiEvent_OpenRoom_Handler_Event,initRoomPage);//false,0,true);
				roompage = null;
			}
			
			if(taoIndex&&this.contains(taoIndex))
			{
				this.removeChild(taoIndex);
				taoIndex.removeEventListener(TaoshiEvent.TaoshiEvent_OpenRoom_Handler_Event,initRoomPage);
				taoIndex = null;
			}
			
			
			roompage = new RoomsPage();
			roompage.initRoom(evt.imageVo);
			this.addChild(roompage);
			roompage.addEventListener(TaoshiEvent.TaoshiEvent_Return_Home_Event,returnHomeHandler,false,0,true);
			roompage.addEventListener(TaoshiEvent.TaoshiEvent_OpenRoom_Handler_Event,initRoomPage,false,0,true);
		}
		
		private function returnHomeHandler(evt:TaoshiEvent):void
		{
			taoIndex = new TaoIndexPage();
			taoIndex.addEventListener(TaoshiEvent.TaoshiEvent_OpenRoom_Handler_Event,initRoomPage,false,0,true);
			addChild(taoIndex);
			
			var bitmapdata:BitmapData = new BitmapData(Global.stageW,Global.stageH);
			bitmapdata.colorTransform(new Rectangle(Global.displayX, Global.displayY,Global.stageW,Global.stageH), new ColorTransform(0,0,0,0));
			bitmapdata.draw(this,null,null,null,null,true);
			mnainBmp = new Bitmap(bitmapdata);
			mnainBmp.smoothing = true;
			mnainBmp.x = Global.displayX;
			mnainBmp.y = Global.displayY;
			addChild(mnainBmp);
			
			sceneMask = new SceneMask();
			sceneMask.x = Global.displayX+ Global.stageW/2;
			sceneMask.y = Global.displayY+ Global.stageH/2;
			sceneMask.scaleX = sceneMask.scaleY = 6.5;
			addChild(sceneMask);
			
			mnainBmp.mask = sceneMask;
			
			TweenLite.to(sceneMask,1.2,{scaleX:0.1,scaleY:0.1,onComplete:sceneMaskComplete});
			
			if(roompage&&this.contains(roompage))
			{
				this.removeChild(roompage);
				roompage.removeEventListener(TaoshiEvent.TaoshiEvent_Return_Home_Event,returnHomeHandler);
				roompage = null;
			}
			
			
		}
		
		
		private function sceneMaskComplete():void
		{
			this.removeChild(mnainBmp);
			mnainBmp.bitmapData.dispose();
			mnainBmp = null;
			
			onResized(null);
			
		}
		
		
		private var mask1:Sprite = new Sprite();
		private function onResized(evt:Event):void
		{
			
			mask1.graphics.clear();
			mask1.graphics.beginFill(0xff0000, 1); 
			mask1.graphics.drawRect(Global.displayX, Global.displayY, Global.stageW, Global.stageH); 
			//mask1.graphics.drawRect(Global.displayX+200, Global.displayY+200, 100, 100); 
			mask1.graphics.endFill(); 
			//mask1.rotation = 30;
			//this.addChild(mask1);
			this.mask = mask1;
			
			
			var displayRect:Rectangle = Global.DisplayRect(1366,700,stage.stageWidth,stage.stageHeight);
			
			var w:Number = displayRect.width;//stage.stageWidth;
			if(w<1024)
			{
				w = 1024;
			}
			Global.stageW = w;
			var h:Number = displayRect.height;//stage.stageHeight;
			if(h<525)
			{
				h = 525;
			}
			Global.stageH = h;
			
			Global.displayX = displayRect.x;
			Global.displayY = displayRect.y;
			

			
			var rate:Number = Global.stageW/1366;
			
			if(startmv&&this.contains(startmv))
			{
				startmv.onResized(Global.stageW,Global.stageH);
			}
			
			if(taoIndex!=null&&this.contains(taoIndex))
			{
				taoIndex.onResized(Global.stageW,Global.stageH);
				taoIndex.x = Global.displayX;
				taoIndex.y = Global.displayY;
			}
			
			
			if(tiaoguo&&this.contains(tiaoguo))
			{
				tiaoguo.x =Global.displayX + Global.stageW - tiaoguo.fhbg.width - 30;
				tiaoguo.y =Global.displayY + Global.stageH - tiaoguo.fhbg.height - 30;
			}
			if(roompage!=null&&this.contains(roompage))
			{
				roompage.x = Global.displayX;
				roompage.y = Global.displayY;
				roompage.onResized(Global.stageW,Global.stageH);
			}
		}
	}
}