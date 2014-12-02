package com.jerrygao.touchscreen.albums
{
	import com.jerrygao.Global;
	import com.jerrygao.net.ImageLoader;
	import com.jerrygao.tools.TextFieldBitmap;
	import com.jerrygao.tools.TextTool;
	import com.jerrygao.touchscreen.BtnSprite;
	
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
	
	public class Picture extends Sprite
	{
		[Embed(source="/assets/album/photoBG2.png")]
		private var PhotoBG_img:Class;
		public var PhotoBG:BtnSprite;
		
		private var state:int = 1;
		
		//private var imageLoader:ImageLoader;
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
		
		public function Picture(url:String,state:int = 1,discrip:String = "",callFunc:Function = null)
		{
			super();
			this.state = state;
			//PhotoBG = new BtnSprite("PhotoBG_img",new PhotoBG_img());
			//addChild(PhotoBG);
			imgUrl = url;
			//this.width = PhotoBG.width;
			//this.height = PhotoBG.height;
			description = discrip;
			if(callFunc != null )
			{
				picCallFunc = callFunc;
			}
			loader = new Loader();
			
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			
		loader.load(new URLRequest(url));
		/*				this.graphics.beginFill(0xff0000,1);
			this.graphics.drawCircle(0,0,5);
			this.graphics.endFill();*/
			trace(loader);
		}
		
		private function progressHandler(e:ProgressEvent):void {
			var num:uint = (e.bytesLoaded / e.bytesTotal) * 100;
			trace('Picture已加载--' + num + "%");
		}
		
		private function completeHandler(e:Event):void {
			var loader:Loader = Loader(e.target.loader);
			bitmap = Bitmap(loader.content);
			bitmap.smoothing = true;
			trace(bitmap.width + '--' + bitmap.height  + '-----state-------' +  state);
			
			if(state == 1)
			{
				
				
				bitmap.width = 640;
				bitmap.height = 480;
				bitmap.x = 6;
				bitmap.y = 6;
				this.w = bitmap.width;
				this.h = bitmap.height;
				
				
				var myBitmap:BitmapData = new BitmapData(bitmap.width+12, bitmap.height+12, false, 0xffffff);
				var myImage:Bitmap = new Bitmap(myBitmap); 
				myImage.smoothing = true;
				this.addChild(myImage);
				this.addChild(bitmap);
			}
			
			if(state == 2)
			{
				var scaley:Number = 2.2; 
				PhotoBG = new BtnSprite("PhotoBG_img",new PhotoBG_img());
				PhotoBG.bp.scaleX = PhotoBG.bp.scaleY = scaley;
				//addChild(PhotoBG);
				var rate:Number = bitmap.height/bitmap.width;

				if(rate<=1.2 )
				{
					if(bitmap.width>=210*scaley)
					{
						bitmap.width = 210*scaley;
						bitmap.height = 210*scaley*rate;
					}
				}
				else
				{
					
					bitmap.width =170*(bitmap.width/bitmap.height)*scaley;
					bitmap.height = 170*scaley;
				}
				
				bitmap.x = (PhotoBG.width - bitmap.width)/2;
				bitmap.y = (PhotoBG.height - bitmap.height)/2-33;
				this.w = bitmap.width;
				this.h = bitmap.height;
				PhotoBG.addChild(bitmap);
				
				labledes = new TextField();
				var textMC:MovieClip = new PicContent() as MovieClip;
				textMC.scaleX = textMC.scaleY = scaley;
				labledes = textMC.contentTxT;
				TextTool.getInstance().setTextFont(YaHei);
				TextTool.getInstance().setTextField(labledes,description,0x000000,12,TextFormatAlign.CENTER,false,false);

				textMC.y = textMC.y+54;
				PhotoBG.addChild(textMC);
				
				var bitmapdata:BitmapData = new BitmapData(PhotoBG.width,PhotoBG.height);
					bitmapdata.colorTransform(new Rectangle(0,0,PhotoBG.width,PhotoBG.height), new ColorTransform(0,0,0,0));
				bitmapdata.draw(PhotoBG,null,null,null,null,true);
				var textbmp:Bitmap = new Bitmap(bitmapdata);
				textbmp.smoothing = true;
				addChild(textbmp);
				picheight = textbmp.height;
				this.w = textbmp.width;
				this.h = textbmp.height;
				bitmap.bitmapData.dispose();
				bitmap=textbmp;
				PhotoBG = null;
			}
			
			/*
			用下面的方法可以实现高度自适应：
			var txt:TextField = new TextField();
			txt.wordWrap = true;//设置自动换行
			txt.width = 30;
			txt.border = true;
			txt.text = "111111111111111as\n111111111111111111123455677788";
			txt.height = txt.textHeight + 4;//至少加4
			addChild(txt);
			*/
			
			if(state == 3)
			{
				PhotoBG = new BtnSprite("PhotoBG_img",new PhotoBG_img());
				PhotoBG.bp.width = PhotoBG.bp.width*2.4;
				PhotoBG.bp.height = PhotoBG.bp.height*2.4;
				//addChild(PhotoBG);
				var rate1:Number = bitmap.height/bitmap.width;

				if(rate1<1.2 )
				{
					//if(bitmap.width>210*2.4)
					//{
						bitmap.width = 210*2.4;
						bitmap.height = 210*2.4*rate1;
					//}
				}
				else
				{
					
					bitmap.width =210*2.4*(bitmap.width/bitmap.height);
					bitmap.height = 210*2.4;
				}
				
				bitmap.x = (PhotoBG.bp.width - bitmap.width)/2;
				bitmap.y = (PhotoBG.bp.height - bitmap.height)/2-33*2.4;
				this.w = PhotoBG.bp.width;
				this.h = PhotoBG.bp.height;
				PhotoBG.addChild(bitmap);
				
				labledes = new TextField();
				var textMC1:MovieClip = new PicContent() as MovieClip;
				textMC1.width = (textMC1.width-2)*2.4;
				textMC1.height = textMC1.height*2.4;
				labledes = textMC1.contentTxT;
				TextTool.getInstance().setTextFont(YaHei);
				TextTool.getInstance().setTextField(labledes,description,0x000000,12,TextFormatAlign.CENTER,false,false);
				
				textMC1.y = textMC1.y + 15 +30*2.4;
				PhotoBG.addChild(textMC1);
				
				var bitmapdata1:BitmapData = new BitmapData(PhotoBG.width,PhotoBG.height);
				bitmapdata1.colorTransform(new Rectangle(0,0,PhotoBG.width,PhotoBG.height), new ColorTransform(0,0,0,0));
				bitmapdata1.draw(PhotoBG,null,null,null,null,true);
				var textbitmap:Bitmap = new Bitmap(bitmapdata1);
				textbitmap.smoothing = true;
				addChild(textbitmap);
				
				bitmap.bitmapData.dispose();
				PhotoBG = null;
				
				if(picCallFunc!=null)
				{
					picCallFunc(bitmapdata1);
					picCallFunc = null;
				}
			}
		}
		
		//public var textbitmap:Bitmap;
		public var picCallFunc:Function;

	}
}