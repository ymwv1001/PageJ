package com.jerrygao.tools
{
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public final class TextTool
	{
		private static var _instance:TextTool;
		private static var CCfont:Font;
		
		public function TextTool(){}
		
		public function setTextFont(fontClass:Class):void
		{
			CCfont = new fontClass() as Font;
		}
		public function setTextField(textField:TextField, content:String,color:uint = 0x333333,size:int = 12,Align:String = TextFieldAutoSize.CENTER,bold:Boolean = false,isHtmlText:Boolean = false,italic:Boolean = false):void
		{
			var newTextField:TextField;
			newTextField = textField;
			//newTextField.autoSize = Align;

			var textFomat:TextFormat = new TextFormat();
			textFomat.font = CCfont.fontName;
			textFomat.align = TextFormatAlign.LEFT;
			textFomat.size = size;
			textFomat.bold = bold;
			textFomat.italic = italic;
			
			if(color!=1)
			{
				textFomat.color = color;
				//newTextField.textColor = color;//0x666666;
			}
			newTextField.selectable = false;
			newTextField.defaultTextFormat = textFomat;
			//NC_Name.setTextFormat(textFomat);
			if(!isHtmlText)
			{
				newTextField.text = content;
			}else
			{
				newTextField.htmlText = content;
			}
			//newTextField.htmlText = content;
		}
		
		//single-ton setting. 
		public static function getInstance():TextTool
		{
			if (!_instance)_instance=new TextTool();
			return TextTool._instance;
		}
	}
}