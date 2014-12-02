package com.jerrygao.screen
{
	import com.jerrygao.Global;
	import com.jerrygao.component.BtnSprite;
	import com.jerrygao.net.ImageLoader;
	import com.jerrygao.tools.TextFieldBitmap;
	import com.jerrygao.tools.TextTool;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	//import mode.conte.VoInfo;
	
	public class Picture extends Sprite
	{
		//[Embed(source="/assets/album/photoBG2.png")]
		//private var PhotoBG_img:Class;
	//	public var PhotoBG:Sprite;
		
		//private var state:int = 1;
		
		private var imageLoader:ImageLoader;
		public var imgUrl:String;
		
		private var loader:Loader;
		public var w:Number;
		public var h:Number;
		public var bitmap:Bitmap;
		public var description:String;
		
		private var labledes:TextField;
		
		public var picheight:int;
		
		public var firstPointID:int;
		public var firstPoint:Point;
		public var scendPointID:int;
		public var scendPoint:Point;
		public var sceLocX:Number=0;
		public var sceLocY:Number=0;
		
		public var perDis:Number=0;
		public var perRot:Number=0;
		
		private var stri:String;
		public function Picture(url:String,state:int = 1,discrip:String = "",callFunc:Function = null)
		{
			super();
			//this.state = state;
			//PhotoBG = new BtnSprite("PhotoBG_img",new PhotoBG_img());
			//addChild(PhotoBG);
			imgUrl = url;
			//this.width = PhotoBG.width;
			//this.height = PhotoBG.height;
			description = discrip;
			stri = description;
			//stri=info;
			if(stri.length>10){
				stri=description.slice(0,10)+"...";
			}
			if(callFunc != null )
			{
				picCallFunc = callFunc;
			}
			loader = new Loader();
			
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			
			loader.load(new URLRequest(url));
		}
		
		private function progressHandler(e:ProgressEvent):void {
			var num:uint = (e.bytesLoaded / e.bytesTotal) * 100;
			//trace('Picture已加载--' + num + "%");
		}
		
	//	private var picBitmapData:BitmapData;
		private function completeHandler(e:Event):void {
			var loader:Loader = Loader(e.target.loader);
			bitmap = Bitmap(loader.content);
			bitmap.smoothing = true;
			//picBitmapData = bitmap.bitmapData.clone();
			Global.pageScale = 1.0;
			if(bitmap.width/bitmap.height>=(stage.stageWidth*Global.pageScale)/stage.stageHeight)
			{
				//var wrate:Number = (stage.stageWidth/2)/bitmap.width;
				var rate1:Number = bitmap.height/bitmap.width;
				bitmap.width = stage.stageWidth*Global.pageScale;
				
				//bitmap.height = bitmap.height*wrate;
				bitmap.height = bitmap.width*rate1;
				//trace("......width........",bitmap.width,bitmap.height);
				
			}else
			{
				//var hrate:Number = stage.stageHeight/bitmap.height;
				var rate2:Number = bitmap.width/bitmap.height;
				bitmap.height = stage.stageHeight;
				//bitmap.width = bitmap.width*hrate;
				bitmap.width = bitmap.height*rate2;
				//trace("......hight........",bitmap.width,bitmap.height);
			}
			
			addChild(bitmap);
			
			picCallFunc();
		}
		
		//public var textbitmap:Bitmap;
		public var picCallFunc:Function;
		
		public function disposeMy():void
		{
		}

	}
}