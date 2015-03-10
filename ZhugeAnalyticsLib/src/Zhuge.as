package
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;


	/**
	 *  使用时必须加入如下权限，APP_KEY在配置文件里写好
	 *  时间都是毫秒
	 *
	 *  <application ……>
			……
		<activity ……/>
		<meta-data android:value="YOUR_APP_KEY" android:name="Zhuge_APPKEY"></meta-data>
		<meta-data android:value="Channel ID" android:name="Zhuge_CHANNEL"/>
		</application>
	 *  <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"></uses-permission>
		<uses-permission android:name="android.permission.INTERNET"></uses-permission>
		<uses-permission android:name="android.permission.READ_PHONE_STATE"></uses-permission>
		<uses-permission android:name="android.permission.READ_LOGS"></uses-permission>
	 *
	 * @author mani
	 *
	 */
	public class Zhuge extends EventDispatcher
	{
		private static var _instance:Zhuge;
		private static var extensionContext:ExtensionContext;
		
		/**  is supported on iOS and Android devices. */
		public static function get isSupported() : Boolean
		{
			return Capabilities.manufacturer.indexOf("iOS") != -1 || Capabilities.manufacturer.indexOf("Android") != -1;
		}

		public static function get instance():Zhuge
		{
			if (!_instance)
			{
				_instance=new Zhuge();
				if (!extensionContext&&isSupported)
				{
					extensionContext=ExtensionContext.createExtensionContext('com.pamakids.ZhugeAnalytics', '');
        			extensionContext.addEventListener(StatusEvent.STATUS, onStatus);

				}
			}
			return _instance;
		}

//		public function getUDID():String
//		{
//			if (extensionContext)
//				return extensionContext.call('getUDID') as String;
//			return '';
//		}

//		public function onResume():void
//		{
//			if (extensionContext)
//				extensionContext.call('onResume');
//		}

		public function init(appkey:String="", channelID:String="",version:String="", isDebug:Boolean=false):void
		{
			if (extensionContext)
				extensionContext.call('startAnaly', appkey, channelID,version, isDebug);
		}

//		public function onPause():void
//		{
//			if (extensionContext)
//				extensionContext.call('onPause');
//		}

		/**
		 * 
		 */
		public function onEvent(eventID:String, label:Object):void
		{
			if (extensionContext)
			{
				var s:String = "";
				if(label)
					 s = JSON.stringify(label);
				extensionContext.call('onEvent', eventID, s);
			}
		}
		
		/**
		 * 
		 */
		public function identify(uId:String, label:Object):void
		{
			if (extensionContext)
			{
				var s:String = "";
				if(label)
					s = JSON.stringify(label);
				extensionContext.call('identify', uId, s);
			}
		}

//		public function onEventBegin(eventID:String, label:String=null):void
//		{
//			if (extensionContext)
//				extensionContext.call("onEventBegin", eventID, label);
//		}
//
//		public function onEventEnd(eventID:String, label:String=null):void
//		{
//			if (extensionContext)
//				extensionContext.call("onEventEnd", eventID, label);
//		}
//		public function beginLogPageView(pageName:String):void
//		{
//			if (extensionContext)
//				extensionContext.call("beginLogPageView", pageName);
//		}
//		public function endLogPageView(pageName:String):void
//		{
//			if (extensionContext)
//				extensionContext.call("endLogPageView", pageName);
//		}

//		public function onEventDuration(eventID:String, time:int, label:String=null, map:Array=null):void
//		{
//			if (extensionContext)
//				extensionContext.call("onEventDuration", eventID, time, label, map);
//		}
		private static function onStatus( event : StatusEvent ) : void
		{
			if(_instance.hasEventListener(StatusEvent.STATUS)) 
			{
				_instance.dispatchEvent(event);
			}
		}
	}
}

