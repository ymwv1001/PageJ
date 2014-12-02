package com.jerrygao.net
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.GlowFilter;
	import flash.filters.GradientGlowFilter;
	import flash.net.URLRequest;
	
	public class ImageLoader extends Sprite
	{
		private var loader:Loader;
		public var w:Number;
		public var h:Number;
		
		public var bitmap:Bitmap;
		
		public var onCompFunc:Function;
		public function ImageLoader(url:String,_w:Number= 0, _h:Number = 0,onComploadFunc:Function  = null)
		{
			super();
			
			if(_w>0)this.w = _w;
			if(_h>0)this.h = _h;
			if(onComploadFunc!=null)
			onCompFunc = onComploadFunc;
			loader = new Loader();
			
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			
			loader.load(new URLRequest(url));
			
			trace(loader);
		}
		
		private function progressHandler(e:ProgressEvent):void {
			var num:uint = (e.bytesLoaded / e.bytesTotal) * 100;
			trace('已加载--' + num + "%");
		}
		
		private function completeHandler(e:Event):void {
			var loader:Loader = Loader(e.target.loader);
			bitmap = Bitmap(loader.content);
			
			//          var bitmap:Bitmap = e.currentTarget.content as Bitmap;
			//          trace(bitmap);
			
			trace(bitmap.width + '--' + bitmap.height);
			bitmap.smoothing = true;
			bitmap.x = 0;
			bitmap.y = 0;
			this.w = bitmap.width;
			this.h = bitmap.height;
			this.addChild(bitmap);
			glowFilter2(bitmap);
		}
		
		private function glowFilter(displayobject:Bitmap):void
		{
			//创建滤镜实例
			var distance:Number=0;
			var angleInDegress:Number=45;
			var colors:Array=[0x94582B,0x94582B,0x94582B,0x94582B];
			var alphas:Array=[0,1,1,1];//0x94582B
			var ratios:Array=null;//[0,63,126,255];
			var blurX:Number=1;
			var blurY:Number=1;
			var strength:Number=5;
			var quality:Number=BitmapFilterQuality.HIGH;
			var type:String=BitmapFilterType.OUTER;
			var knockout:Boolean=false;
			var gradientBevelFilter:GradientGlowFilter=new GradientGlowFilter(distance,angleInDegress,colors,alphas,ratios,blurX,blurY,strength,quality,type,knockout);
			//创建滤镜数组,通过将滤镜作为参数传递给Array()构造函数,
			//将该滤镜添加到数组中
			var filtersArray:Array=new Array(gradientBevelFilter);
			displayobject.filters = filtersArray;
		}
		
		
		private function glowFilter2(displayobject:Bitmap):void
		{
			
			var glow:GlowFilter = new GlowFilter(); 
			glow.color = 0x0A0255;
			glow.alpha = 1; 
			glow.blurX = 25; 
			glow.blurY = 25; 
			glow.quality = BitmapFilterQuality.MEDIUM; 
			
			displayobject.filters = [glow];
		}
		
		
		
	}
}