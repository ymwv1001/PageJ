package com.jerrygao.tools
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	//import tools.AssetsFactory;
	
	public class BGSound extends Sprite 
	{
		private var url:String="assets/bgsound.mp3";
		private var soundChannelng:SoundChannel;
		private var soundFactory:Sound;
		private var trans:SoundTransform = new SoundTransform();
		private var bool:Boolean=true;
		private var num:Number=0.5;
		private var sobtn:Sound_MC;
		private var playing:Boolean = true;
		public static var instance:BGSound;
		public function BGSound():void 
		{
			//var factory:AssetsFactory = AssetsFactory.getInstance();
		//	var SoundMC:Class = factory.getDefinition(AssetsFactory.assetsSourceKey,"Sound_MC") as Class;
			sobtn = new Sound_MC();
			//sobtn = new SoundMC();
			sobtn.bar.x = 60;
			this.addChild(sobtn)
			sobtn.addEventListener(MouseEvent.MOUSE_DOWN,sobtnHandler);
			loadingSound();
			instance = this;
		}
		
		public function setPos(x:Number,y:Number):void
		{
			this.x = x;
			this.y = y;
		}
		
		public function soundStop():void 
		{
			num = 0;
			setVolume(num);
			playing = false;
		}
		
		public function soundPlay():void 
		{
			playing = true;
			loadingSound();
		}
		
		private function loadingSound():void 
		{
			if(!soundFactory)
			{
				soundFactory = new Sound();
				soundFactory.load(new URLRequest(url));
				soundChannelng=soundFactory.play();
			}
			setVolume(num);
		}
		
		private function soundCompleteHandler(evt:Event):void 
		{
			soundStop();
			num = 0.5;
			soundPlay();
		}
		
		private function sobtnHandler(evt:MouseEvent):void 
		{
			sobtn.sbtn.addEventListener(MouseEvent.MOUSE_UP,sbtnHandler,false,0,true);
			sobtn.Channel.addEventListener(MouseEvent.MOUSE_UP,ChannelHandler,false,0,true);
		}
		
		private function sbtnHandler(evt:MouseEvent):void 
		{
			sobtn.sbtn.removeEventListener(MouseEvent.MOUSE_UP,sbtnHandler);
			bool=! bool;
			if (! bool) 
			{
				soundStop();
				sobtn.sbtn.gotoAndStop(2);
			} else 
			{
				num = 0.5;
				soundPlay();
				sobtn.sbtn.gotoAndStop(1);
			}
		}
		
		private function ChannelHandler(evt:MouseEvent):void 
		{
			sobtn.Channel.removeEventListener(MouseEvent.MOUSE_UP,ChannelHandler);
			sobtn.bar.x=sobtn.mouseX;
			
			num=(sobtn.bar.x-32)/28;
			if (num>1) 
			{
				num=1;
			}
			
			if (num<=0)
			{
				num=0;
				soundStop();
				return;
			}
			
			if(num<=1&&num>0)
			{
				if(!playing)
				{
					soundPlay();
					sobtn.sbtn.gotoAndStop(1);
				}
				else
				{

					setVolume(num);
				}
			}
			
			//sobtn.sbtn.gotoAndStop(1);
		}
		private var currentVolume:Number=0;
		private var mute_state:Boolean=false;
	 	public function mute(swith:Boolean):void{
		//	if(mute_state==swith)return;
			if(swith){
				currentVolume=num
				setVolume(0);
			}else{
				num=currentVolume
				soundPlay();
				setVolume(currentVolume);
			}	
		}
		
		public function setVolume(volume:Number):void
		{
			sobtn.bar.x = volume*28 + 32;
			if(volume == 0)
			{
				soundChannelng.stop();
				soundChannelng.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
				soundFactory=null;
			}
			else if(volume>0)
			{
				soundChannelng.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler,false,0,true);
				trans.volume=volume;
				soundChannelng.soundTransform=trans;
			}
		}
	}
}