package  
{
	//impo
	//import fl.lang.Locale;
	import com.greensock.TweenLite;
	import com.jerrygao.Global;
	import com.jerrygao.screen.Picture;
	import com.jerrygao.taoshi.CircleImage;
	import com.jerrygao.taoshi.CircleImageVO;
	import com.jerrygao.taoshi.HotPointCircle;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import fl.lang.Locale;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;

	/**
	 * ...
	 * @author winky
	 */
	public class BasicGallery extends MovieClip
	{
		public var imageHolder:MovieClip;
		protected var bg:Picture;
		
		protected var playDirection:String = "left";
		protected var imageAry:Array = [];
		protected var imageVoAry:Array = [];
		protected var allImageAry:Array = [];

		protected var centerX:int = Global.stageW / 2;
		protected var centerY:int = Global.stageH / 2;
		
		protected var xAry:Array = [724,510,390,485,577,670,772,850,930,1000,1060,1080];
		protected var yAry:Array = [392,463,349,300,267,260,250,250,270,300,327,433];
		
		protected var sizeAry:Array =  [1,1,1,1,1,1,1,1,1,1,1,1];
		protected var alphaAry:Array = [1,1,1,1,1,1,1,1,1,1,1,1];
		
		//protected var xAry:Array = [552,300,200,893,905];
		//protected var yAry:Array = [340,356,255,219,340];
		
		//protected var sizeAry:Array = [1.0,1.0,1.0,1.0,1.0];
		//protected var alphaAry:Array = [1,1,1,1,1];
		
		public var imgSpeed:int = 25;
		protected var timer:Timer = new Timer(4000);
		
		protected var imageViewNum:int = 12;
		
		protected var lastImageX:int = 800;
		
		public function BasicGallery() 
		{
			imageHolder = new MovieClip();
			imageHolder.x = 0;
			imageHolder.y = 0;
			this.addChild(imageHolder);
		}
		
		public function loadXML(url:String):void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(new URLRequest(url));
			urlLoader.addEventListener(Event.COMPLETE, loadCompletexml);
			//urlLoader.addEventListener(IOErrorEvent, loadComplete);
		}
		
		protected function loadCompletexml(evt:Event):void
		{
			var xml:XML = new XML((evt.currentTarget as URLLoader).data);
			//trace(xml.toString());
			//var imageXmlList:XMLList = parseXML(xml);
			var adress:String =xml.adress.@url;
			//trace(adress);
			onRequestXML(adress);
		}
		
		public function showTitleTxt(_title:String):void
		{
				
		}
		
		public function onRequestXML(url:String):void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(new URLRequest(url));
			urlLoader.addEventListener(Event.COMPLETE, loadComplete);
			//urlLoader.addEventListener(IOErrorEvent, loadComplete);
		}
		
		
		protected function loadComplete(evt:Event):void
		{
			var xml:XML = new XML((evt.currentTarget as URLLoader).data);
			//trace(xml.toString());
			var imageXmlList:XMLList = parseXML(xml);
			
			var remainNum:int = imageViewNum-imageVoAry.length;
			var remainAry:Array = [];
			if(remainNum>0)
			{
				var index:int  = 0;
				for(var j:int = 0;j<remainNum;j++)
				{
					if(index>imageVoAry.length-1)
					{
						index = 0;
					}
					remainAry[j] = imageVoAry[index];
					index++;
				}
			}
			imageVoAry = imageVoAry.concat(remainAry);
			
			if (imageXmlList.length() > 0)
			{
				createGallery();
				timer.addEventListener(TimerEvent.TIMER, timerHd);
				//timer.start();
				//-------------------开始转------------------
			}
			
			this.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			
		}
	
		protected function parseXML(xml:XML):XMLList
		{
			return null;
		}
		
		//创建图片墙，只创建12个
		private function createGallery():void
		{
			imageAry = [];
			allImageAry = [];
			var len:int = imageVoAry.length > imageViewNum ? imageViewNum:imageVoAry.length;
			for (var i:int = 0; i < imageVoAry.length; i++)
			{
				var img:CircleImage = new CircleImage();
				img.index = i;
				img.ZhuanIndex = i;
				//img.
				if (i < imageViewNum)
				{
					imageAry.push(img);
					img.x = xAry[i]-55;
					img.y = yAry[i]-42;
					img.scaleX = sizeAry[i];
					img.scaleY = sizeAry[i];
					img.alpha = alphaAry[i];
				}
				else
				{
					img.alpha = 0;	
					img.x = 200;    
					img.y = 0;      
				}
				allImageAry.push(img);
				imageHolder.addChild(img);
				
				var imageVo:CircleImageVO = imageVoAry[i];
				img.buttonMode = true;
				img.circleImageVO = imageVo;
				img.createQRImage();
				img.addEventListener(MouseEvent.MOUSE_UP,onMoviesClicked,false,0,true);
				img.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver,false,0,true);
				img.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut,false,0,true);
				if(i==0){
				img.showEver = true;
				img.showPaoPao(true);
				}
				else
				{
					img.showEver = false;
				}
			
			}
			swapDepth();
			var middleIndex:int = int(imageViewNum / 2);
		}
		
		
		private function onMouseOver(evt:MouseEvent):void
		{
			var image:CircleImage = evt.currentTarget as CircleImage;
			image.showPaoPao();
			//image.showPaoPao();
			//.addChild(hotPao);
		}
		
		private function onMouseOut(evt:MouseEvent):void
		{
			var image:CircleImage = evt.currentTarget as CircleImage;
			image.hidePaoPao();//PaoPao();
			//image.showPaoPao();
			//.addChild(hotPao);
		}

		
		public var clickImgVo:CircleImageVO;
		public var clickCoverToPlayMovie:Function;
		private function onMoviesClicked(evt:MouseEvent):void
		{
			/*
			zhuanIndex = (evt.currentTarget as CircleImage).ZhuanIndex;
			var index:int = (evt.currentTarget as CircleImage).index;
			if(zhuanIndex == 0&& index<3)
			{
				//截图+遮罩
				clickImgVo = (evt.currentTarget as CircleImage).circleImageVO;
				clickCoverToPlayMovie();
			}
			
			trace("onMoviesClicked : ",zhuanIndex);
			moveByZhuanIndex();
			*/
			
			
			
			clickImgVo = (evt.currentTarget as CircleImage).circleImageVO;
			
			trace("......clickImgVo..........  : ",clickImgVo.name);
			if(clickImgVo.title =="SPA" || clickImgVo.title =="Theatre" || clickImgVo.title =="Gallery" )
			{
				//截图+遮罩
				clickImgVo = (evt.currentTarget as CircleImage).circleImageVO;
				clickCoverToPlayMovie();
			}
			
		}
		
		
		protected function showSpecialBG(imgVO:CircleImageVO):void
		{
			
		}
		
		protected function showContentTxt(imgVO:CircleImageVO):void
		{
			
		}
		
		private function loadImg(url:String,cav:Sprite):void
		{
			var loader:Loader = new Loader();
			loader.load(new URLRequest(url));
			cav.addChild(loader);
		}
		
		
		private function move():void
		{
			if (playDirection == "right")
			{
				var newIndex:int = imageAry[0].index - 1;
				if (newIndex < 0)
				{
					newIndex = imageVoAry.length - 1;
				}
				var newImg:CircleImage = allImageAry[newIndex];
				newImg.x = xAry[imageAry.length-1];
				newImg.y = yAry[imageAry.length-1];
				newImg.scaleX = sizeAry[imageAry.length-1];
				newImg.scaleY = sizeAry[imageAry.length-1];
				newImg.alpha = alphaAry[imageAry.length-1];
				imageAry.unshift(newImg);
				for (var i:int = 0; i < imageAry.length; i++)
				{
					var img:CircleImage = imageAry[i];
					if (i < imageAry.length-1 )
					{
						TweenLite.to(img,0.45,{x:xAry[i],y:yAry[i],scaleX:sizeAry[i],scaleY:sizeAry[i],alpha:alphaAry[i]});
						img.ZhuanIndex = i;
					}
					else
					{//最后一个
						TweenLite.to(img,0.45,{x:xAry[0],y:yAry[0],scaleX:1,scaleY:1,alpha:1});
						img.ZhuanIndex = 0;
					}
				}
				
				imageAry.pop();
				swapDepth();
			}
			else if (playDirection == "left")
			{
				newIndex = imageAry[imageAry.length - 1].index + 1;
				if (newIndex > imageVoAry.length-1)
				{
					newIndex = 0;
				}
				newImg = allImageAry[newIndex];
				newImg.x = xAry[0];
				newImg.y = yAry[0];
				newImg.scaleX = sizeAry[0];
				newImg.scaleY = sizeAry[0];
				newImg.alpha = alphaAry[0];
				imageAry.push(newImg);
				for (var j:int = 0; j < imageAry.length; j++)
				{
					
					if(j==12)
					{
						break;
					}
					
					img = imageAry[j];
					if (j >0)
					{
						TweenLite.to(img,0.45,{x:xAry[j - 1],y:yAry[j - 1],scaleX:sizeAry[j - 1],scaleY:sizeAry[j - 1],alpha:alphaAry[j -1]});
						
						img.ZhuanIndex = j-1;
					}
					else if (j ==0)
					{//最后一个
						TweenLite.to(img,0.45,{x:xAry[11],y:yAry[11],scaleX:sizeAry[11],scaleY:sizeAry[11],alpha:alphaAry[11]});
						img.ZhuanIndex = 11;
					}
					
					if(img.ZhuanIndex ==0)
					{
						img.showEver = true;
						img.showPaoPao();
					   // img.	
					}else
					{
						img.showEver = false;
						img.hidePaoPao();
					}
					trace("index ：",img.index,"ZhuanIndex : ",img.ZhuanIndex);
				}
				trace("__________________________________________________________________");
				imageAry.shift();
				swapDepth();
			}
			var middleIndex:int = int(imageViewNum / 2);
			//showContentTxt(imageVoAry[imageAry[middleIndex].index]);
		}

		//调整深度
		protected function swapDepth():void
		{
			
			
			if (imageAry[6])
			{
				imageHolder.addChild(imageAry[6]);
			}
			
			if (imageAry[7])
			{
				imageHolder.addChild(imageAry[7]);
			}
			
			if (imageAry[8])
			{
				imageHolder.addChild(imageAry[8]);
			}
			
			if (imageAry[9])
			{
				imageHolder.addChild(imageAry[9]);
			}
			
			if (imageAry[10])
			{
				imageHolder.addChild(imageAry[10]);
			}
			
			if (imageAry[11])
			{
				imageHolder.addChild(imageAry[11]);
			}
			
			
			
			if (imageAry[5])
			{
				imageHolder.addChild(imageAry[5]);
			}
			if (imageAry[4])
			{
				imageHolder.addChild(imageAry[4]);
			}
			if (imageAry[3])
			{
				imageHolder.addChild(imageAry[3]);
			}
			if (imageAry[2])
			{
				imageHolder.addChild(imageAry[2]);
			}
			
			if (imageAry[1])
			{
				imageHolder.addChild(imageAry[1]);
			}
			
			
			imageHolder.addChild(imageAry[0]);
		}
		
		protected function rightHandler(evt:MouseEvent):void
		{
			playDirection = "right";
			//timer.reset();
			//timer.start();
			move();
		}

		protected function leftHandler(evt:MouseEvent):void
		{
			playDirection = "left";
			//timer.reset();
			//timer.start();
			move();
		}
		
		
		private var zhuanIndex:int = 0;
		private function moveByZhuanIndex():void
		{
			trace("move");
			if(zhuanIndex > 0)
			{
				leftHandler(null);
				zhuanIndex--;
				setTimeout(moveByZhuanIndex, 350); 
			}
			else if(zhuanIndex == 0)
			{
				pauseGallery();
			}
		}
		
		private var canRotate:Boolean = true
		protected function mouseWheelHandler(evt:MouseEvent):void
		{
			trace("wheel");
			if (evt.delta > 1  && canRotate)
			{
				leftHandler(null);
				canRotate = false;
				setTimeout(canRotateHandler, 300);
			}else if(evt.delta<-1 && canRotate){
				rightHandler(null);
				canRotate = false;
				setTimeout(canRotateHandler, 300);
			}
		}
		
		protected function canRotateHandler():void
		{
			canRotate = true;
		}
		
		public function pauseGallery():void
		{
			timer.stop();
		}
		
		public function playGallery():void
		{
			timer.reset();
			timer.start();
		}
		

		protected function timerHd(evt:TimerEvent):void
		{
			move();
		}
    }
	
}