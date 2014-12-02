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
	
	public class PictureBG extends Sprite
	{
		//[Embed(source="/assets/album/photoBG2.png")]
		//private var PhotoBG_img:Class;
		//	public var PhotoBG:Sprite;
		
		//private var state:int = 1;
		
		public var imgUrl:String;
		
		private var loader:Loader;
		public var w:Number;
		public var h:Number;
		public var bitmap:Bitmap;
		public var description:String;
		public var picheight:int;
		
		public var offsetX:Number = 0;
		public var offsetY:Number = 0;
		private var stri:String;
		private var isSetSize:Boolean = false;
		public function PictureBG(url:String,state:int = 1,discrip:String = "",callFunc:Function = null,offX:Number = 0,offY:Number = 0)
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
			//if(callFunc != null )
			//{
				picCallFunc = callFunc;
			//}
			
			offsetX = offX;
			offsetY = offY;
			loader = new Loader();
			
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			
			loader.load(new URLRequest(url));
		}
		
		public function setSize(_w:Number,_h:Number):void
		{
				bitmap.width = _w;
				bitmap.height = _h;
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
			bitmap.x = offsetX;
			bitmap.y = offsetY;
			addChild(bitmap);
			if(picCallFunc != null )
			picCallFunc();
		}
		
		//public var textbitmap:Bitmap;
		public var picCallFunc:Function;
		
		public function disposeMy():void
		{
			bitmap.bitmapData.dispose();
		}
		
	}
}