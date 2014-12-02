package com.jerrygao.component
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class SelectBtn extends Sprite
	{
		private var btnName:String;
		public var selectedImage:Bitmap;
		public var unselectedImage:Bitmap;
		
		public var isSelected:Boolean =false;
		public function SelectBtn(name:String,sBmap:Bitmap,unSBmp:Bitmap,isASelectedBtn:Boolean)
		{
			super();
			btnName = name;
			this.name = name;
			selectedImage = sBmap;
			selectedImage.smoothing = true;
			unselectedImage = unSBmp;
			unselectedImage.smoothing = true;
			isSelected= isASelectedBtn;
			
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			
			selectedImage.smoothing =  unselectedImage.smoothing = true;
			this.addChild(selectedImage);
			this.addChild(unselectedImage);
			this.buttonMode = true;
			//selectedImage
			setState(isSelected);
			//this.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		
		
		public function setState(isSelectedBtn:Boolean):void
		{
			this.isSelected = isSelectedBtn
			if(isSelected)
			{
				unselectedImage.visible = false;
				selectedImage.visible = true;
			}else
			{
				unselectedImage.visible = true;
				selectedImage.visible = false;
			}
		}
		
		public function onMouseUp(evt:MouseEvent):void
		{
			if(isSelected == false)
			{
				isSelected = !isSelected;
				setState(isSelected);
			}
		}
	}
}