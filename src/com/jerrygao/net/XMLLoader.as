package com.jerrygao.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class XMLLoader extends EventDispatcher
	{
		private var onXMLComp:Function;
		public var externalXML:XML; 
		private var loader:URLLoader = new URLLoader(); 
		private var request:URLRequest;// = new URLRequest("assets/AlbumsConfig.xml"); 
		public function XMLLoader(target:IEventDispatcher=null)
		{
			super(target);
		
			//Download.
			//loader.load(request); 
			//loader.addEventListener(Event.COMPLETE, onComplete); 
		}
		
		public function loaderXML(url:String,onCompleteFunc:Function = null):void
		{
			if(onXMLComp!=null){
				onXMLComp = null;
			}
			onXMLComp = onCompleteFunc;
			request = new URLRequest(url);
			loader.load(request); 
			loader.addEventListener(Event.COMPLETE, onComplete); 
		}
		
		private function onComplete(event:Event):void 
		{ 
			var loader:URLLoader = event.target as URLLoader; 
			if (loader != null) 
			{ 
				externalXML = new XML(loader.data); 
				//trace(externalXML.toXMLString()); 
				
				if(onXMLComp!=null)
				{
					onXMLComp();
				}
			} 
			else 
			{ 
				trace("loader is not a URLLoader!"); 
			} 
		}
	}
}