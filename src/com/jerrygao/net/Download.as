package com.jerrygao.net
{
	import flash.display.*;
	import flash.display.Loader;
	import flash.events.*;
	import flash.geom.*;
	import flash.media.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;

	public class Download {
		public static function loadTxt(url:String, callback:Function=null):void {
			// load the xml file
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			loader.load(new URLRequest(url));
			function onLoadComplete(event:Event):void {
				var txt:String = String(event.target.data);
				if (callback!=null) {
					callback(txt);
				}
				event.target.removeEventListener(Event.COMPLETE, onLoadComplete);
			}
			function onLoadError(event:IOErrorEvent) :void{
				trace("The xml file at URL[ \""+url+"\" ] is not existent...");
				if (callback!=null) {
					callback(null);
				}
				event.target.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			}
		}
		// load xml file and callback, the callback must have one param
		public static function loadXML(url:String, callback:Function=null):void 
		{
			// load the xml file
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			loader.load(new URLRequest(url));
			function onLoadComplete(event:Event):void {
				var xml:XML = XML(event.target.data);
				if (callback != null) {
					callback(xml);
				}
				event.target.removeEventListener(Event.COMPLETE, onLoadComplete);
			}
			function onLoadError(event:IOErrorEvent):void {
				trace("The xml file at URL[ \""+url+"\" ] is not existent...");
				if (callback!=null) {
					callback(null);
				}
				event.target.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			}
		}
				
		// load swf file and callback, the callback must have one param
		public static function loadSWF(url:String, progressfun:Function=null, callback:Function=null):void {
			// load the xml file
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoadInit);
            loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			loader.load(new URLRequest(url));
			function onLoadInit(event:Event):void {
				var swf:Loader = event.target.loader;
				//*********
				//var contentLoaderInfo:LoaderInfo = event.target as LoaderInfo;
				//var appdomain:ApplicationDomain = contentLoaderInfo.applicationDomain;
				//***********
				if (callback!=null) {
					callback(swf);
				}
				event.target.removeEventListener(Event.COMPLETE, onLoadInit);
				//loader.unload();
			}
			function progressHandler(event:ProgressEvent):void{
			    var progressNum:uint = Math.floor((event.bytesLoaded /event.bytesTotal)*100);
				if (progressfun!=null) {
					progressfun(progressNum);
				}
				if(progressNum == 100){
					event.target.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
				}
			}
			function onLoadError(event:IOErrorEvent) :void{
				trace("The swf file at URL[ \""+url+"\" ] is not existent...");
				if (callback!=null) {
					callback(null);
				}
				event.target.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
				loader.unload();
			}			
		}
		
		// load swf file and callback, the callback must have one param
		public static function loadAppDomain(url:String, progressfun:Function=null, callback:Function=null):void {
			// load the xml file
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadInit);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			loader.load(new URLRequest(url));
			function onLoadInit(event:Event):void {
				//var swf:Loader = event.target.loader;
				//*********
				var contentLoaderInfo:LoaderInfo = event.target as LoaderInfo;
				var appdomain:ApplicationDomain = contentLoaderInfo.applicationDomain;
				//***********
				if (callback!=null) {
					callback(appdomain,url);
				}
				event.target.removeEventListener(Event.COMPLETE, onLoadInit);
				//loader.unload();
			}
			function progressHandler(event:ProgressEvent):void{
				var progressNum:uint = Math.floor((event.bytesLoaded /event.bytesTotal)*100);

				if(progressNum == 100){
					event.target.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
				}
				if (progressfun!=null) {
					progressfun(progressNum);
				}
			}
			function onLoadError(event:IOErrorEvent) :void{
				trace("The swf file at URL[ \""+url+"\" ] is not existent...");
				if (callback!=null) {
					callback(null);
				}
				event.target.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
				loader.unload();
			}			
		}
		
	}
}