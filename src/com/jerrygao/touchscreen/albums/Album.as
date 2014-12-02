package com.jerrygao.touchscreen.albums
{
	
	import com.jerrygao.Global;
	import com.jerrygao.tools.TextFieldBitmap;
	import com.jerrygao.tools.TextTool;
	import com.jerrygao.touchscreen.BtnSprite;
	import com.jerrygao.touchscreen.HuaDianEvents;
	
	import fl.motion.MatrixTransformer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.GesturePhase;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.events.TransformGestureEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	public class Album extends Sprite
	{
		public var photosNum:int;
		
		private var albumBtnSpri:Sprite;
		private var photoesOneSpri:Sprite;
		
		private var picsSpri:Sprite;
		
		[Embed(source="/assets/albumBtn.png")]
		private var albumBtn_img:Class;
		
		[Embed(source="/assets/album/PhotoesOne.png")]
		private var PhotoesOne_img:Class;
		
		[Embed(source="/assets/returnMenuBtn.png")]
		private var returnMenuBtn_img:Class;
		private var returnMenuBtn:Sprite;
		
		private var menutextSp:Sprite;
		
		private var pop:Sprite;// = new Sprite();
		public function Album()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			Multitouch.inputMode=MultitouchInputMode.TOUCH_POINT;
			
			
			photosNum = Math.random()*5 + 1;
			albumBtnSpri = new Sprite();
			photoesOneSpri = new Sprite();
			this.addChild(albumBtnSpri);
			this.addChild(photoesOneSpri);
			picsSpri = new Sprite();
			this.addChild(picsSpri);
		//	picsSpri.addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
		//	picsSpri.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			
			menutextSp = new Sprite();
			this.addChild(menutextSp);
			
			pop = new Sprite();
			this.addChild(pop);
			
			if(returnMenuBtn == null)
			{
				returnMenuBtn = new BtnSprite("returnMenuBtn",new returnMenuBtn_img());
				returnMenuBtn.x = (stage.stageWidth - 236* Global.scaleStage)/2;
				returnMenuBtn.y = stage.stageHeight - 93* Global.scaleStageY;
				this.addChild(returnMenuBtn);
				returnMenuBtn.addEventListener(MouseEvent.MOUSE_DOWN,onreturnBtnMouseDown,false,0,true);
			}
			initFont();
		}
		
		[Embed(source="/assets/menutext/menutext1.png")]
		private var menutext1_img:Class;
		[Embed(source="/assets/menutext/menutext2.png")]
		private var menutext2_img:Class;
		[Embed(source="/assets/menutext/menutext3.png")]
		private var menutext3_img:Class;
		[Embed(source="/assets/menutext/menutext4.png")]
		private var menutext4_img:Class;
		[Embed(source="/assets/menutext/menutext5.png")]
		private var menutext5_img:Class;
		[Embed(source="/assets/menutext/menutext6.png")]
		private var menutext6_img:Class;
		
		private var menutext1:BtnSprite;
		private var menutext2:BtnSprite;
		private var menutext3:BtnSprite;
		private var menutext4:BtnSprite;
		private var menutext5:BtnSprite;
		private var menutext6:BtnSprite;
		
		private var state:int;
		private var viewlevel:int  = 1; 
		public function loadPhotoesByState(state:int):void
		{
			viewlevel = 1;
			this.state = state;
			switch(state)
			{
				case 101:
					menutext1 = new BtnSprite("menutext1",new menutext1_img());
					menutext1.x = 145;
					menutext1.y = 130* Global.scaleStageY900;
					menutext1.mouseEnabled= false;
					this.addChild(menutext1);
					getGaikuangArr();
					loadPhotoes(gaikuangArr,gaikuanglableArr);
					break;
				case 102:
					menutext2 = new BtnSprite("menutext2",new menutext2_img());
					menutext2.x = 145;
					menutext2.y = 130* Global.scaleStageY900;
					menutext2.mouseEnabled = false;
					this.addChild(menutext2);
					getwenhuaArr();
					loadPhotoes(wenhuaArr,wenhualableArr);
					
					break;
				case 103:
					menutext3 = new BtnSprite("menutext3",new menutext3_img());
					menutext3.x = 145;
					menutext3.y = 130* Global.scaleStageY900;
					menutext3.mouseEnabled = false;
					this.addChild(menutext3);
					getshiliArr();
					loadPhotoes(shiliArr,shililableArr);
					break;
				case 104:
					menutext4 = new BtnSprite("menutext4",new menutext4_img());
					menutext4.x = 145;
					menutext4.y = 130* Global.scaleStageY900;
					menutext4.mouseEnabled = false;
					this.addChild(menutext4);
					getShengtaiArr();
					loadPhotoes(shengtaiArr,shengtailableArr);
					break;
				case 105:
					menutext5 = new BtnSprite("menutext5",new menutext5_img());
					menutext5.x = 145;
					menutext5.y = 130* Global.scaleStageY900;
					menutext5.mouseEnabled=false;
					this.addChild(menutext5);
					getyijuArr();
					loadPhotoes(yijuArr,yijulableArr);
					break;
				case 106:
					menutext6 = new BtnSprite("menutext6",new menutext6_img());
					menutext6.x = 145;
					menutext6.y = 130* Global.scaleStageY900;
					menutext6.mouseEnabled = false;
					this.addChild(menutext6);
					getxingfuArr();
					loadPhotoes(xingfuArr,xingfulableArr);
					break;
			}
		}
		
		public function loadPhotoes(albumArr:Array,lableArr:Array):void
		{
			
			var offY:int = 0;
			if(Global.stageScale == 900)
			{
				offY = 300;
			}
			photosNum = albumArr.length;//Math.random()*8 + 1;
			var i:int; 
			for (i = 0; i < photosNum; i++) 
			{
				var albumBtn:BtnSprite = new BtnSprite("albumBtn"+i,new albumBtn_img(),i);
				albumBtnSpri.addChild(albumBtn);
				
				albumBtn.x = 270+i*320*Global.scaleStage;
				albumBtn.y = 430* Global.scaleStageY900;
				if(photosNum ==1)
				{
					albumBtn.x = stage.stageWidth/2 -130;
				}
			
				if(photosNum ==2)
				{
					albumBtn.x = (stage.stageWidth/2 -130)+i*320*Global.scaleStage;
				}
				
				if(photosNum ==3)
				{
					albumBtn.x = (stage.stageWidth/2 -130 - 320)+i*320*Global.scaleStage;
				}
				
				if(photosNum ==4)
				{
					albumBtn.x = (stage.stageWidth/2 -130 - 320 - 160)+i*320*Global.scaleStage;
				}
				
				if(photosNum ==5)
				{
					albumBtn.x = (stage.stageWidth/2 -130 - 320 - 160)+i*320*Global.scaleStage;
				}
				
				if(photosNum ==6)
				{
					albumBtn.x = (stage.stageWidth/2 -430 - 320 - 160)+i*320*Global.scaleStage;
				}
				
				label = new TextField();
				TextTool.getInstance().setTextField(label,lableArr[i],0xffffff,24,TextFieldAutoSize.LEFT,false,false);
				var lableBitmap:Bitmap = TextFieldBitmap.getTextFieldBitmap(label,true,true);
				lableBitmap.x = albumBtn.x + 50;
				lableBitmap.y = albumBtn.y + 20;
				lableBitmap.smoothing = true;
				albumBtnSpri.addChild(lableBitmap);
				var PhotoesOne:Photoes = new Photoes(state.toString(),albumArr[i] as Array,i);
				PhotoesOne.x = albumBtn.x -50* Global.scaleStage;
				PhotoesOne.y = albumBtn.y - 370;
				
				PhotoesOne.scaleX  = PhotoesOne.scaleY = 0.3;
				photoesOneSpri.addChild(PhotoesOne);
				PhotoesOne.addEventListener(MouseEvent.MOUSE_DOWN,onBtnMouseDown,false,0,true);
			}
		}
		
		private var label:TextField;
		private var labelStr:String = "领导关怀";
		
		private function onBtnMouseDown(e:MouseEvent):void
		{
			
			albumBtnSpri.visible = false;
			photoesOneSpri.visible = false;
			picsSpri.visible = true;
			
			viewlevel = 2;
			OpenUpPics((e.currentTarget as Photoes).btnNum);
			onMouseActionHapend();
		}
		
		private function OpenUpPics(num:int):void
		{
		//	Multitouch.inputMode=MultitouchInputMode.GESTURE;
			var albumarr:Array;
			switch(state)
			{
				case 101:
					albumarr = gaikuangArr;
					break;
				case 102:
					albumarr = wenhuaArr;
					break;
				case 103:
					albumarr = shiliArr;
					break;
				case 104:
					albumarr = shengtaiArr;
					break;
				case 105:
					albumarr = yijuArr;
					break;
				case 106:
					albumarr = xingfuArr;
					break;
			}
			
			var offY:int = 0;
			if(Global.stageScale == 900)
			{
				offY = 150;
			}
			
			var picArr:Array  = albumarr[num] as Array;
			var i:int;
			var picNum:int = picArr.length;
			var ht:int;
			while(picsSpri.numChildren>0){(picsSpri.removeChildAt(0) as Picture).bitmap.bitmapData.dispose();}
			for (i = 0; i < picNum; i++) 
			{
				var picvo:PicVO = picArr[i] as PicVO;
				var po:Picture = new Picture(picvo.url,2,picvo.description);
				
				//var randnum:int = Math.round(Math.random()*(5*230*1.66*Global.scaleStage-1))+1;
				po.x = 200 + i*230*2.5* Global.scaleStage;
				po.y = 200* Global.scaleStageY900 + offY;
				
				if(i>=5)
				{
					po.x = randRange(200,1209);//0 + i*230*1.66* Global.scaleStage;
					po.y = randRange(300,stage.stageHeight-400);//150* Global.scaleStageY900 + offY;
					
				}
				po.rotationZ = randRange(-45,45);
				po.scaleX  = Global.scaleStage;
				po.scaleY  = Global.scaleStage;
				picsSpri.addChild(po);
				
				//po.addEventListener(MouseEvent.CLICK,onPicClick, false,0,true);
				//ht = po.picheight;
				
				po.addEventListener(TouchEvent.TOUCH_BEGIN, onBegin);
			//	po.addEventListener(MouseEvent.MOUSE_DOWN,OnTestDown);

			//	po.addEventListener(TransformGestureEvent.GESTURE_ROTATE, rothandler);
			}
			

			/*
			var myBitmap:BitmapData = new BitmapData(picNum*230*1.66* Global.scaleStage+200,550* Global.scaleStage, true, 0x10ffffff);
			var myImage:Bitmap = new Bitmap(myBitmap); 
			myImage.smoothing = true;
			if(Global.stageScale == 900)
			{
				myImage.height = myImage.height + 50;
			}
			myImage.y = 110* Global.scaleStageY900 +offY;
			myImage.x = -100* Global.scaleStage;
			picsSpri.addChildAt(myImage,0);
			
			
			if(picsSpri.width<stage.stageWidth)
			{
				picsSpri.x = (stage.stageWidth - picsSpri.width)/2-110* Global.scaleStage;
			}
			trace("picsSpri.width :--------" + picsSpri.width+"picsSpri.height-----------" + picsSpri.height);
			*/
		}
		private function OnTestDown(evt:MouseEvent):void{
			var display:Picture = evt.target as Picture;
			//display.alpha = 0.4;
			display.bitmap.alpha=0.6;
			
			
			
			display.bitmap.x-=evt.localX;
			display.bitmap.y-=evt.localY;
			//display.bitmap.bitmapData.dispose();
			display.x=evt.stageX;
			display.y=evt.stageY;
			display.addEventListener(MouseEvent.MOUSE_MOVE,MouseMove);
			display.addEventListener(MouseEvent.MOUSE_UP,MouseUp);
		//s	trace(evt.localX,evt.localY);
		}
		private function MouseMove(evt:MouseEvent):void{
			var display:Picture = evt.target as Picture;
			display.x=evt.stageX;
			display.y=evt.stageY;
		}
		private function MouseUp(evt:MouseEvent):void{
			var display:Picture = evt.target as Picture;
			display.removeEventListener(MouseEvent.MOUSE_MOVE,MouseMove);
			display.removeEventListener(MouseEvent.MOUSE_UP,MouseUp);
			display.bitmap.alpha=1;
		}
		//取随机整数
		public function randRange(minNum:int, maxNum:int):int
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		private function rothandler(evt:TransformGestureEvent): void 
		{
			var display:Picture = evt.currentTarget as Picture;
			display.rotationZ += evt.rotation; 
			//trace("evt.rotation : " + evt.rotation);
			evt.updateAfterEvent();
			
			var point:Point
			
		}
		
		private function onBegin(e:TouchEvent):void
		{
			onMouseActionHapend();
			var display:Picture = e.currentTarget as Picture;
			display.alpha = 0.8;
			if(display.firstPoint==null){
				display.firstPoint=new Point(e.stageX,e.sizeY);
				display.firstPointID=e.touchPointID;
				display.bitmap.x-=e.localX;
				display.bitmap.y-=e.localY;
				display.x=e.stageX;
				display.y=e.stageY;
			//	display.locX=e.localX;
			//	display.locY=e.localY;
				display.addEventListener(TouchEvent.TOUCH_MOVE, onMoved);
				display.addEventListener(TouchEvent.TOUCH_ROLL_OUT,onEnd);
				display.addEventListener(TouchEvent.TOUCH_END, onEnd);
				picsSpri.addChild(display);
			//	trace("记录第一个点",display.firstPointID);
			}else if(display.scendPoint==null){
				display.scendPoint=new Point(e.stageX,e.stageY);
				display.scendPointID=e.touchPointID;
				display.sceLocX=e.localX;
				display.sceLocY=e.localY;
			//	trace("记录第二个点",display.scendPointID);
			}
						
			if (e.touchPointID == 0)
			{
				//display.startDrag()
			}
			else
			{
				//display.stopDrag();
				//
				//display.addEventListener(TransformGestureEvent.GESTURE_ZOOM, onZoom);
			}
		}
		
		private function onMoved(event:TouchEvent):void
		{
			
			var display:Picture = event.currentTarget as Picture;
			if(display.firstPointID==event.touchPointID){
			//	trace("move",event.touchPointID);	
				display.firstPoint.x=event.stageX;
				display.firstPoint.y=event.stageY;
			}
			if(display.scendPointID==event.touchPointID){
				display.scendPoint.x=event.stageX;
				display.scendPoint.y=event.stageY;
			}	
			if(display.firstPoint!=null){
				if(display.scendPoint!=null){
					//放大  或者  旋转
				//	trace(display.firstPoint,display.scendPoint);
					//放大
					if(display.perDis != 0)
					{
						var thisDis:Number = touchDis(display.firstPoint,display.scendPoint);
						var offs:Number = OffScale(display.perDis,thisDis);
						display.scaleX += offs;
						display.scaleY += offs;
				//	trace("thisDis : ",thisDis,offs,display.firstPoint,display.scendPoint);
						if(display.scaleX>1.8)
						{
							display.scaleX = display.scaleY = 1.8;
						}
						
						if(display.scaleX<0.7)
						{
							display.scaleX = display.scaleY = 0.7;
						}
						display.perDis = thisDis;
						
					}else{
						display.perDis = 	touchDis(display.firstPoint,display.scendPoint);				
					}
					//旋转
				if(display.perRot != 0)
					{
						var thisRot:Number = touchRot(display.firstPoint,display.scendPoint);
						display.rotationZ += OffRotation(display.perRot,thisRot);
						if(display.rotationZ>=360)
						{
							display.rotationZ -= 360;
						}
						if(display.rotationZ<=-360)
						{
							display.rotationZ+=360;
						}
						display.perRot = thisRot;
						trace(display.rotationZ);
					}else{
						display.perRot = 	touchRot(display.firstPoint,display.scendPoint);				
					}
					//trace(display.x,display.y);

				}else{
					// 移动
				//	trace("move",display.x,event.stageX);
					display.x=event.stageX;
					display.y=event.stageY;
				}	
				
			}
			event.updateAfterEvent();
		}
		
		//private var  perDis:Number = 0;
		//private var perRot:Number = 0;
		private function onZoom(event:TransformGestureEvent):void { 
			var view:Picture = event.currentTarget as Picture;
			var locX:Number=event.localX; 
			var locY:Number=event.localY; 
			var stX:Number=event.stageX; 
			var stY:Number=event.stageY; 
			var prevScaleX:Number=view.scaleX; 
			var prevScaleY:Number=view.scaleY; 
			var mat:Matrix; 
			var externalPoint:Point= new Point(stX,stY); 
			var internalPoint:Point= new Point(locX,locY); 
			view.scaleX *= event.scaleX; 
			view.scaleY *= event.scaleY; 
			//确保“container”没有缩放超过600％或低于80％  
			if(event.scaleX > 1 && view.scaleX > 2){ 
				view.scaleX=prevScaleX; 
				view.scaleY=prevScaleY; 
			} 
			
			if(event.scaleY > 1 && view.scaleY > 2){ 
				view.scaleX=prevScaleX; 
				view.scaleY=prevScaleY; 
			} 
			if(event.scaleX < 1 && view.scaleX < 0.8){ 
				view.scaleX=prevScaleX; 
				view.scaleY=prevScaleY; 
			} 
			if(event.scaleY < 1 && view.scaleY < 0.8){ 
				view.scaleX=prevScaleX; 
				view.scaleY=prevScaleY; 
			} 
			//调整坐标 
			mat=view.transform.matrix.clone(); 
			MatrixTransformer.matchInternalPointWithExternal(mat, internalPoint, externalPoint); 
			view.transform.matrix=mat; 
		}		
		
		private function onEnd(event:TouchEvent):void
		{
		//	trace("end");
			var display:Picture = event.currentTarget as Picture;
			if(display.firstPointID==event.touchPointID){//如果第一个点消失，第二个点变成第一个点； 让first 永远存在
				if(display.scendPoint!=null){

				//	display.bitmap.x=0
				//	display.bitmap.y=0;
					display.bitmap.x-=display.sceLocX;
					display.bitmap.y-=display.sceLocY;
				//	display.bitmap.y-=display.sceLocY;
					display.x=display.scendPoint.x;
					display.y=display.scendPoint.y;
					
					display.firstPointID=display.scendPointID;
					display.firstPoint=display.scendPoint;
					
					
					display.scendPointID=0;
					display.scendPoint=null;	
					
					display.perDis = 0;
					display.perRot = 0;
				}else{
					display.firstPointID=0;
					display.firstPoint=null;	
					display.alpha=1;
					display.removeEventListener(TouchEvent.TOUCH_MOVE, onMoved);
					display.removeEventListener(TouchEvent.TOUCH_ROLL_OUT,onEnd);
					display.removeEventListener(TouchEvent.TOUCH_END, onEnd);
					display.perDis = 0;
					display.perRot = 0;
				}	
			}
			if(display.scendPointID==event.touchPointID){
				display.scendPointID=0;
				display.scendPoint=null
			}
		}
        
		
		//计算两个点的距离
		private function touchDis(pointOne:Point,pointTwo:Point):Number
		{
			var dis:Number = Point.distance(pointOne,	pointTwo);
			return dis;
		}
		
		//计算两个点的角度
		private function touchRot(pointOne:Point,pointTwo:Point):Number
		{
			var angle:Number  = Math.atan((pointOne.x - pointTwo.x)/(pointOne.y - pointTwo.y));
			var rota:Number = angle*180/Math.PI;
			return rota;
		}
		
		
		//计算两个距离的比率（放缩大小差）
		private function OffScale(disOne:Number,disTwo:Number):Number
		{
			var scale:Number = 1-disOne/disTwo;	
		//	trace("#################:  ",disOne,disTwo,scale);
			return scale;
		}
		
		//计算两个角度的差值（旋转角度差）
		private function OffRotation(rotationOne:Number,rotatonTwo:Number):Number
		{
			var offRo:Number = rotationOne-rotatonTwo;
			return offRo;
			
		}
		
		private function onPicClick(evt:MouseEvent):void
		{
			var pic:Picture = evt.currentTarget as Picture;
			var po:Picture = new Picture(pic.imgUrl,3,pic.description,addPopPicFunction);
			onMouseActionHapend();
		}
		
		private function addPopPicFunction(bitmapData:BitmapData):void
		{
			var textbmp:Bitmap = new Bitmap(bitmapData);
			textbmp.smoothing = true;

			
			textbmp.scaleX  = Global.scaleStageY900;
			textbmp.scaleY  = Global.scaleStageY900;
			while(pop.numChildren>0)
			{
				pop.removeChildAt(0);
			}
			
			pop.addChild(textbmp);
			
			var offY:int = 0;
			if(Global.stageScale == 900)
			{
				offY = -120;
			}
			textbmp.x = 760* Global.scaleStage + offY;
			textbmp.y = -5* Global.scaleStageY;
			var myBitmap:BitmapData = new BitmapData(stage.stageWidth,stage.stageHeight, true, 0x30ffffff);
			var myImage:Bitmap = new Bitmap(myBitmap); 
			myImage.smoothing = true;
			
			pop.addChildAt(myImage,0);
			
			pop.addEventListener(MouseEvent.CLICK,onPopClicked, false,0,true);
		}
		
		private function onPopClicked(evt:MouseEvent):void
		{
			while(pop.numChildren>0)
			{
				pop.removeChildAt(0);
			}
			pop.removeEventListener(MouseEvent.CLICK,onPopClicked);
			onMouseActionHapend();
		}
		
		private var offsetX:Number;
		private var offsetY:Number;
		
		private var draggedObject:Sprite;

		//开始移动
		private function startDragging(event:MouseEvent):void {
			offsetX = event.stageX - picsSpri.x;
			offsetY = event.stageY - picsSpri.y;
			picsSpri.addEventListener(MouseEvent.MOUSE_MOVE, dragObject);
			onMouseActionHapend();
		}
		//停止拖动
		private function stopDragging(event:MouseEvent):void {
			//移除鼠标移动事件
			picsSpri.removeEventListener(MouseEvent.MOUSE_MOVE, dragObject);
			onMouseActionHapend();
		}
		private function dragObject(event:MouseEvent):void {
			//设置新的坐标
			picsSpri.x = event.stageX - offsetX;
			event.updateAfterEvent();
		}

		private function onMouseActionHapend():void
		{
			this.dispatchEvent(new HuaDianEvents(HuaDianEvents.MOUSE_ACTION_HAPENED,true));
		}
		
		private function onreturnBtnMouseDown(e:MouseEvent):void
		{
			if(viewlevel == 2)
			{
				albumBtnSpri.visible = true;
				photoesOneSpri.visible = true;
				picsSpri.visible = false;
				viewlevel = 1;
				
				while(pop.numChildren>0)
				{
					pop.removeChildAt(0);
				}
				
				while(picsSpri.numChildren>0)
				{
					picsSpri.removeChildAt(0);
				}
				
			}else if(viewlevel == 1)
			{
				while(picsSpri.numChildren>0){(picsSpri.removeChildAt(0) as Picture).bitmap.bitmapData.dispose();}
				while(albumBtnSpri.numChildren>0){albumBtnSpri.removeChildAt(0)};
				this.dispatchEvent(new HuaDianEvents(HuaDianEvents.MAIN_MENU_Return,true));
				this.removeChild(returnMenuBtn);
			}
		}
		
		private var textTool:TextTool;
		private function initFont():void
		{
			textTool = TextTool.getInstance();
			textTool.setTextFont(YaHei);
		}
		
		//序列化XML数据
		private var gaikuangArr:Array;//概况数组
		private var gaikuanglableArr:Array = new Array();
		private function  getGaikuangArr():void
		{
			gaikuanglableArr = new Array();
			gaikuangArr=new Array();
			var gaikuang:XMLList = Global.albumsXml.gaikuang;
			
			var albumslist:XMLList=gaikuang.albums;
			if(albumslist.length()>0)
			{
				for(var i:int=0;i<albumslist.length();i++)
				{
					gaikuanglableArr.push(albumslist[i].@name);
					var picArr:Array=new Array();
					gaikuangArr.push(picArr);
					var pics:XMLList = albumslist[i].pic;
					for(var j:int=0;j<pics.length();j++)
					{
						trace(pics[j].@url);
						var pic:PicVO = new PicVO();
						pic.url = pics[j].@url;
						pic.description = pics[j].@description;
						picArr.push(pic);
					}
				}
			}
		}
		
		private var shengtaiArr:Array;//生态数组
		private var shengtailableArr:Array = new Array();
		private function  getShengtaiArr():void
		{
			shengtailableArr = new Array();
			shengtaiArr=new Array();
			var shengtai:XMLList = Global.albumsXml.shengtai;
			
			var albumslist:XMLList=shengtai.albums;
			if(albumslist.length()>0)
			{
				for(var i:int=0;i<albumslist.length();i++)
				{
					shengtailableArr.push(albumslist[i].@name);
					var picArr:Array=new Array();
					shengtaiArr.push(picArr);
					var pics:XMLList = albumslist[i].pic;
					for(var j:int=0;j<pics.length();j++)
					{
						trace(pics[j].@url);
						var pic:PicVO = new PicVO();
						pic.url = pics[j].@url;
						pic.description = pics[j].@description;
						picArr.push(pic);
					}
				}
			}
		}
		
		private var shiliArr:Array;//实力数组
		private var shililableArr:Array = new Array();
		private function  getshiliArr():void
		{
			shililableArr= new Array();
			shiliArr=new Array();
			var shili:XMLList = Global.albumsXml.shili;
			
			var albumslist:XMLList=shili.albums;
			if(albumslist.length()>0)
			{
				for(var i:int=0;i<albumslist.length();i++)
				{
					shililableArr.push(albumslist[i].@name);
					var picArr:Array=new Array();
					shiliArr.push(picArr);
					var pics:XMLList = albumslist[i].pic;
					for(var j:int=0;j<pics.length();j++)
					{
						trace(pics[j].@url);
						var pic:PicVO = new PicVO();
						pic.url = pics[j].@url;
						pic.description = pics[j].@description;
						picArr.push(pic);
					}
				}
			}
		}
		
		private var wenhuaArr:Array;//文化数组
		private var wenhualableArr:Array = new Array();
		private function  getwenhuaArr():void
		{
			wenhualableArr = new Array();
			wenhuaArr=new Array();
			var wenhua:XMLList = Global.albumsXml.wenhua;
			
			var albumslist:XMLList=wenhua.albums;
			if(albumslist.length()>0)
			{
				for(var i:int=0;i<albumslist.length();i++)
				{
					wenhualableArr.push(albumslist[i].@name);
					var picArr:Array=new Array();
					wenhuaArr.push(picArr);
					var pics:XMLList = albumslist[i].pic;
					for(var j:int=0;j<pics.length();j++)
					{
						trace(pics[j].@url);
						var pic:PicVO = new PicVO();
						pic.url = pics[j].@url;
						pic.description = pics[j].@description;
						picArr.push(pic);
					}
				}
			}
		}
		
		private var xingfuArr:Array;//幸福数组
		private var xingfulableArr:Array;
		private function  getxingfuArr():void
		{
			
			xingfuArr=new Array();
			xingfulableArr = new Array();
			var xingfu:XMLList = Global.albumsXml.xingfu;
			
			var albumslist:XMLList=xingfu.albums;
			if(albumslist.length()>0)
			{
				for(var i:int=0;i<albumslist.length();i++)
				{
					xingfulableArr.push(albumslist[i].@name);
					var picArr:Array=new Array();
					xingfuArr.push(picArr);
					var pics:XMLList = albumslist[i].pic;
					for(var j:int=0;j<pics.length();j++)
					{
						trace(pics[j].@url);
						var pic:PicVO = new PicVO();
						pic.url = pics[j].@url;
						pic.description = pics[j].@description;
						picArr.push(pic);
					}
				}
			}
		}
		
		private var yijuArr:Array;//幸福数组
		private var yijulableArr:Array;
		private function  getyijuArr():void
		{
			
			yijuArr=new Array();
			yijulableArr = new Array();
			var yiju:XMLList = Global.albumsXml.yiju;
			
			var albumslist:XMLList=yiju.albums;
			if(albumslist.length()>0)
			{
				for(var i:int=0;i<albumslist.length();i++)
				{
					yijulableArr.push(albumslist[i].@name);
					var picArr:Array=new Array();
					yijuArr.push(picArr);
					var pics:XMLList = albumslist[i].pic;
					for(var j:int=0;j<pics.length();j++)
					{
						trace(pics[j].@url);
						var pic:PicVO = new PicVO();
						pic.url = pics[j].@url;
						pic.description = pics[j].@description;
						picArr.push(pic);
					}
				}
			}
		}
	}
}
import flash.geom.Point;

class TouchPoint{
	public function getPoints(name:String):Vector.<Point>{
		var resualt:Vector.<Point>
		
		
		return resualt;
	}
}