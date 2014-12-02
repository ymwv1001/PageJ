package com.jerrygao.tools
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.StyleSheet;
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.geom.ColorTransform;

	public class TextFieldBitmap
	{
		public function TextFieldBitmap()
		{
		}
		/*

		[Embed(source="04b_08__.ttf",fontName="04b_08",embedAsCFF="false",unicodeRange="U+0020,U+0041-005A,U+0020,U+0061-007A,U+0030-0039,U+002E,U+0020-002F,U+003A-0040,U+005B-0060,U+007B-007E,U+0020-002F,U+0030-0039,U+003A-0040,U+0041-005A,U+005B-0060,U+0061-007A,U+007B-007E")] 
		public var Font04b08:Class;
		public var myFont:Class;

		*/
		public static function getTextFieldBitmap( t:TextField, trans:Boolean = true, smoothing:Boolean = true):Bitmap
		{
			var s:Sprite = new Sprite();
			s.addChild(t);
			var bitmapdata:BitmapData = new BitmapData(s.width,s.height);
			if(trans){
				bitmapdata.colorTransform(new Rectangle(0,0,s.width,s.height), new ColorTransform(0,0,0,0));
			}
			bitmapdata.draw(s,null,null,null,null,true);
			var bmp:Bitmap = new Bitmap(bitmapdata);
			bmp.smoothing = smoothing;
			return bmp;
		}
		
		/**
		 * 将文本转换为图像
		 * 文本为html文本,可以设定样式
		 * 默认背景透明,平滑处理
		 */
		public static function getHtmlTextBitmap(txt:String, style:StyleSheet=null, trans:Boolean = true, smoothing:Boolean = true):Bitmap
		{
			var t:TextField = new TextField();
			t.autoSize = TextFieldAutoSize.LEFT;
			if(style)t.styleSheet = style;
			t.htmlText = txt;
			return getTextFieldBitmap(t, trans, smoothing);
		}
		
		/**
		 * 将文本转换为图像
		 * 文本为纯文本,可以设定样式
		 * 默认背景透明,平滑处理
		 */
		public static function getTextBitmap(txt:String, tf:TextFormat = null, trans:Boolean = true, smoothing:Boolean = true):Bitmap
		{
			var t:TextField = new TextField();
			t.autoSize = TextFieldAutoSize.LEFT;
			t.text = txt;
			if(tf)t.setTextFormat(tf);
			return getTextFieldBitmap(t, trans, smoothing);
		}
		
		/**
		 * 将文本转换为图像
		 * 文本为纯文本,可以设定逐字样式
		 * 默认背景透明,平滑处理
		 */
		public static function getTextBitmapEx(txt:String, textFormats:Array = null, ratios:Array=null, trans:Boolean = true, smoothing:Boolean = true):Bitmap
		{
			var t:TextField = new TextField();
			t.autoSize = TextFieldAutoSize.LEFT;
			t.text = txt;
			if(textFormats){
				var i:int=0, l:int = textFormats.length, rl:int, j:int = 0;
				var tLen:int = txt.length;
				if(!ratios){
					//没有给定样式位置,则逐字设定
					for(i = 0; i < l - 1; i++){
						trace(i)
						if(textFormats[i])t.setTextFormat(textFormats[i],i,i+1);
					}
					//最后的样式应用于所有字体
					if(textFormats[i])t.setTextFormat(textFormats[i],i, tLen);
				}else{
					//给定样式位置,则依照给定位置设置
					rl = ratios.length;
					for(i = 0; i<Math.min(rl-1, l); i++){
						if(textFormats[i])t.setTextFormat(textFormats[i],ratios[i],ratios[i+1]);
					}
					if( textFormats[i])t.setTextFormat(textFormats[i],ratios[i], tLen);
				}
			}
			return getTextFieldBitmap(t, trans, smoothing);
		}
	}
}
