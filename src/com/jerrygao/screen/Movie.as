package com.jerrygao.screen
{
	import com.jerrygao.Global;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.printing.PrintJob;
	
	public class Movie extends MovieClip
	{
		public function Movie()
		{
			super();
		}
		
		public function disposeMy():void
		{
			if(video)
			{
				videoStream.close();
				video.clear();
				removeChild(video);
				videoStream = null;
				video = null;
				videolenght = null;
				videoConnection = null;
			}
		}
		/*
		private var nc:NetConnection; 
		private var ns:NetStream; 
		private var vid:Video; 
		private var t:Number; 
		private var duration:Number; 
		
		public function StartVideo(url:String):void
		{ 
		nc=new NetConnection(); 
		nc.connect(null); 
		ns = new NetStream(nc); 
		ns.play(url); 
		vid=new Video(); 
		vid.attachNetStream(ns); 
		var obj:Object=new Object(); 
		obj.onMetaData = onMetaData; 
		ns.client = obj; 
		//this.stage.addEventListener(MouseEvent.CLICK,onClick); 
		this.loaderInfo.addEventListener(Event.COMPLETE,mcPlay); 
		} 
		
		*/
		private var video:Video;
		private var videolenght:Object;
		private var videoConnection:NetConnection;
		private var videoStream:NetStream;
		private var duration:uint;
		public var isResized:Boolean = false;
		
		private var myVolume:Number;
		private var Vurl:String;
		private var isReplay:Boolean = true;
		public function playFlv(url:String,volume:Number,replay:Boolean):void
		{
			trace("playFlv:",replay.toString());
			if(video)
			{
				videoStream.removeEventListener(NetStatusEvent.NET_STATUS,onStatus);
				videoStream.close();
				video.clear();
				removeChild(video);
				videoStream = null;
				video = null;
				videolenght = null;
				videoConnection = null;
			}
			
			
			isReplay = replay;
			
			
			Vurl = url;
			myVolume = volume;
			isResized = false;
			video=new Video(1280,720);
			videolenght||=new Object();
			videoConnection||=new NetConnection();
			videoConnection.connect(null)	
			videoStream||=new NetStream(videoConnection);
			videoStream||videoStream.close();  // 加这句以后反而吃内存
			video||video.clear();
			video.smoothing=true;
			
			addChild(video);
			//video.addEventListener(Event.COMPLETE,videoCompleteHandler);
			videolenght.onMetaData=onMetaData;//function(data:Object):void{}
			videoStream.client=videolenght;
			
			videoStream.addEventListener(NetStatusEvent.NET_STATUS,onStatus,false,0,true);
			video.attachNetStream(videoStream);
			
			
			
			//currentUrl=url;
			videoStream.play(url);
			//fullScreen();
		}
		
		private function onStatus(event:NetStatusEvent):void 
		{ 
			resizeMovie();
			
			switch (event.info.code)  
			{  
				case "NetStream.Play.Start":  
					trace("提示:Start [" + videoStream.time.toFixed(3) + " seconds]");  
					break;  
				case "NetStream.Play.Stop":  
					trace("提示:Stop [" + videoStream.time.toFixed(3) + " seconds]");  
					if(isReplay)
					{
						playFlv(Vurl,myVolume,isReplay);
					}
					break;  
			}  
		}
		
		public function resizeMovie():void
		{
			if(isResized == true)
			{
				return;
				
			}
			// trace("onStatus");
			// video.width = 800;
			// video.height = 600;
			Global.pageScale = 1.0;
			trace("onStatus,0000...",video.width,video.height);
			if(video.width/video.height>=(stage.stageWidth*Global.pageScale)/stage.stageHeight)
			{
				var wrate:Number = (stage.stageWidth*Global.pageScale)/video.width;
				video.width = stage.stageWidth*Global.pageScale;
				video.height = video.height*wrate;
				//trace("onStatus,1111...",video.width,video.height);
				
			}else
			{
				var hrate:Number = stage.stageHeight/video.height;
				video.height = stage.stageHeight;
				video.width = video.width*hrate;
				//trace("onStatus,2222...",video.width,video.height);
			}
			
			video.x = (stage.stageWidth*Global.pageScale - video.width)/2;
			video.y = (stage.stageHeight - video.height)/2;
			
			//var soundTF:SoundTransform = videoStream.soundTransform;
			//soundTF.volume = 0.5;//value音量
			//videoStream.soundTransform = soundTF;
			changeSoundVolume(myVolume);
			isResized = true;
			//addChild(video);
		} 
		
		
		private function onMetaData(infoObject:Object):void 
		{ 
			duration=infoObject.duration;//获取总时间 
			
		} 
		
		//极酷播放器cuplayer.com提示：拖拽播放的进度 
		public function position(percent:Number):void 
		{ 
			var value:int = int(duration*percent);
			if (value == int(duration)) 
			{ 
				videoStream.seek(0); 
			} 
			else 
			{ 
				if (value > Math.floor(int(duration) * videoStream.bytesLoaded / videoStream.bytesTotal)) 
				{ 
					videoStream.seek(Math.floor(int(duration) * videoStream.bytesLoaded / videoStream.bytesTotal)-5); 
				} 
				else 
				{ 
					videoStream.seek(value); 
				} 
			} 
			trace(value,int(duration)); 
			trace(videoStream.bytesLoaded+":"+videoStream.bytesTotal); 
		} 
		
		
		public function playMovie():void
		{
			videoStream.resume();
		}
		
		public function pauseMovie():void
		{
			videoStream.pause();
		}
		
		public function changeSoundVolume(volume:Number):void 
		{
			myVolume = volume;
			var soundTF:SoundTransform = videoStream.soundTransform;
			soundTF.volume = volume;//value音量
			videoStream.soundTransform = soundTF;
		}
		
	} 
}