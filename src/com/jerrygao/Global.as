/**
 *UI资源  舞台  全局属性
 */

package com.jerrygao
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;

	public class Global
	{
		public static var stageW:Number = 1024;
		public static var stageH:Number = 576;
		public static var displayX:Number = 0;
		public static var displayY:Number = 0;
		
		public static var fg:String = "fg1";
		
		public static var stageScale:int = 900;
		public static var albumsXml:XML;
		public static var wenziXml:XML;
		//全局舞台
		public static var stage:Stage;

		//zip集合
		public static var zips:XMLList;
		public static var pageScale:Number = 1.0;
		
		public function Global()
		{
			throw Error("Can't Instance");
		}
		
		public static function SendRectangle(fx:Number,fy:Number,fw:Number,fh:Number):void
		{
			//调用JS函数 参数为flash 有效显示区域的 x y w h
			ExternalInterface.call("FlashRectangle",fx, fy, fw,fh);
		}
		
		//public static  function stage111():Point
		//{
//			if(video.width/video.height>=(stage.stageWidth*Global.pageScale)/stage.stageHeight)
//			{
//				var wrate:Number = (stage.stageWidth*Global.pageScale)/video.width;
//				video.width = stage.stageWidth*Global.pageScale;
//				video.height = video.height*wrate;
//				//trace("onStatus,1111...",video.width,video.height);
//				
//			}else
//			{
//				var hrate:Number = stage.stageHeight/video.height;
//				video.height = stage.stageHeight;
//				video.width = video.width*hrate;
//				//trace("onStatus,2222...",video.width,video.height);
//			}
		//}
		/**
		 *全局切换场景文本提示信息框 
		 */	
		public static function getInfoTxt():TextField{
			var txt:TextField=new TextField();
			txt.width=330;
			txt.height=55;
			txt.multiline=true;
			txt.wordWrap=true;
			
			var txt_css:TextFormat=new TextFormat();
			txt_css.color=0x0D3F86;
			txt_css.font="宋体";
			txt_css.size=12;
			txt.defaultTextFormat=txt_css;
			
			return txt;
		}
		
		/**
		 *黑色框 用于多个模块半透黑背景
		 */		
		public static function maskBit():Sprite{
			var spr:Sprite=new Sprite();
			spr.graphics.beginFill(0,1);
			spr.graphics.drawRect(0,0,1920,1080);
			spr.graphics.endFill();
			return spr;
		}
		
		public static function DisplayRect(displayW:Number,displayH:Number,stageWidth:Number,stageHeight:Number):Rectangle
		{
			trace("displayW: ",displayW);
			trace("displayH: ",displayH);
			trace("stageWidth: ",stageWidth);
			trace("stageHeight: ",stageHeight);
			if(stageWidth<=1024)
			{
				stageWidth = 1024;
			}
			if(stageHeight<=576)
			{
				stageHeight = 576;
			}
			if(displayW/displayH>=stageWidth/stageHeight)
			{
				var wrate:Number = stageWidth/displayW;
				displayW = stageWidth;
				displayH = displayH*wrate;
				
			}else
			{
				var hrate:Number = stageHeight/displayH;
				displayH = stageHeight;
				displayW = displayW*hrate;
			}
			return new Rectangle((stageWidth-displayW)/2,0,displayW,displayH);
		}
	}
}