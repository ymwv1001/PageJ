package 
{
	import com.greensock.TweenLite;
	import com.jerrygao.screen.Picture;
	import com.jerrygao.taoshi.CircleImageVO;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	import fl.lang.Locale;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;

	/**
	 * ...
	 * @author winky
	 */
	public class Gallery extends BasicGallery
	{
		public function Gallery()
		{
			super();
			//loadXML("wordHouse/all.xml");
			loadXML("assets/MovieConfig.xml");
		}
		
			
		override protected function parseXML(xml:XML):XMLList
		{
			var imageXmlList:XMLList =xml.movies.albums.pic;
			//trace(imageXmlList.toString());
			
			for (var i:int = 0; i <imageXmlList.length(); i++)
			{
				var parentXML:XML = imageXmlList[i].parent();
				//SpecialID
				
				var imageVo:CircleImageVO = new CircleImageVO();
				imageVo.imageUrl = imageXmlList[i].@imageUrl;
				imageVo.bgUrl = imageXmlList[i].@bgUrl;
				imageVo.title =imageXmlList[i].@headline;
				imageVo.name =imageXmlList[i].@showName;
				imageVo.description = imageXmlList[i].@description;
				imageVo.movieUrl = imageXmlList[i].@url;
				imageVoAry.push(imageVo);
			}
			//
			return imageXmlList;
		}
		
		override public function showTitleTxt(_title:String):void
		{
			//trace("-------------------------",_title)
			//titleTxt.text = _title;
		}
		
		public function movieLeft():void
		{
			this.rightHandler(null);
		}
		
		public function movieRight():void
		{
			this.leftHandler(null);
		}
		
		private var bgID:String = "";
		//private var bg:Picture;
		override protected function showContentTxt(imgVO:CircleImageVO):void
		{
			if(imgVO.ID != bgID)
			{
				bgID = imgVO.ID;
				if(bg)
				{
					this.removeChild(bg);
					bg = null;
				}
				bg = new Picture(imgVO.ID,1,"");
				this.addChildAt(bg,0);
			}
			//showTxt.text = obj.imageLink;
		}
		
		override protected function showSpecialBG(imgVO:CircleImageVO):void
		{
			
		}
	}

}

class ImageVo
{
	public var title:String;
	
	public var imageUrl:String;

	public var movieLink:String;

	public var description:String;
	
	public var SpecialID:String;
	
	public var SpecialImg:String;
}