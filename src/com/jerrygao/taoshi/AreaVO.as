package com.jerrygao.taoshi
{
	public class AreaVO extends Object
	{
		public var name:String;
		
		public var roomName:String;
		
		public var id:String;
		
		public var bgimageUrl:String;
		
		public var peopleUrl:String;
		
		public var productsUrl:String;
		
		public var items:Vector.<HotPointVO> = new Vector.<HotPointVO>();
		
		public function AreaVO()
		{
			super();
		}
		
		public static var areasVO:Vector.<AreaVO> =  new Vector.<AreaVO>();
		
		//通过房间名字得到此房间相关的Area列表
		public static function GetRoomAreasByRoomName(roomName:String):Vector.<AreaVO>
		{
			var areasList:Vector.<AreaVO> =  new Vector.<AreaVO>();
			for (var i:int = 0; i <areasVO.length; i++)
			{
				if(areasVO[i].roomName == roomName)
				{
					trace(roomName,areasVO[i].bgimageUrl);
					areasList.push(areasVO[i]);
				}
			}
			return areasList;
		}
		
		//初始化所有Area列表
		public static function GetAreaVOByXML(xml:XML):void
		{
			
			
			var areaXmlList:XMLList =xml.movies.rooms.area;
			
			for (var i:int = 0; i <areaXmlList.length(); i++)
			{
				var area:AreaVO = new AreaVO();
				area.name = areaXmlList[i].@name;
				area.roomName =areaXmlList[i].@roomName;
				area.bgimageUrl = areaXmlList[i].@bgimageUrl;
				area.peopleUrl = areaXmlList[i].@peopleUrl;
				area.productsUrl = areaXmlList[i].@productsUrl;
				areasVO.push(area);
				var itemXmlList:XMLList = areaXmlList[i].item;
				
				for (var j:int = 0; j <itemXmlList.length(); j++)
				{
					//把 HotPointVO 添加进 area.items 数组
					var hotpoint:HotPointVO = new HotPointVO();
					hotpoint.x = itemXmlList[j].@x;
					hotpoint.y = itemXmlList[j].@y;
					hotpoint.name = itemXmlList[j].@name;
					hotpoint.imageUrl = itemXmlList[j].@imageUrl;
					hotpoint.productUrl = itemXmlList[j].@productUrl;
					hotpoint.description = itemXmlList[j].@description;
					area.items.push(hotpoint);
					
					trace(hotpoint.name);
				}
			}
			
			//trace(areaXmlList.toXMLString());
			//return null;
		}
	}
}