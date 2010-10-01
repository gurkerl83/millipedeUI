/* ***REQUIRES ADOBE AIR - WILL NOT FUNCTION IN THE FLASH PLAYER PLUGIN*** 
 * 
 * Copyright (C) 2010 studio|chris
 *
 * This software is provided 'as-is', without any express or implied
 * warranty.  In no event will the authors be held liable for any damages
 * arising from the use of this software.
 *
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgment in the product documentation would be
 *    appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 */

package us.studiochris.openx 
{
	import flash.display.Sprite;
	import flash.net.URLRequest;
//	import flash.html.HTMLLoader;
	
	/**
	 * ...
	 * @author Chris Price [http://www.studiochris.us]
	 * @version 1.0
	 */
	public class OpenxLoader extends Sprite
	{
		
		private var _height:Number;
		private var _width:Number;
		private var _url:String;
		private var urlReq:URLRequest;
		
//		public var html:HTMLLoader;
		
		public function OpenxLoader(w:Number, h:Number, url:String) 
		{
			
			_width = w;
			_height = h;
			_url = url;
						
			urlReq = new URLRequest(url);

//			html = new HTMLLoader();
//			html.width = w;
//			html.height = h;
//			html.navigateInSystemBrowser = true;
//			html.paintsDefaultBackground = false;
//
//			addChild(html);
//
//			html.load(urlReq);
			
		}
		
		public override function set height(h:Number):void
		{
			_height = h;
//			html.height = _height;
		}
		
		public override function get height():Number
		{
			return _height;
		}
		
		public override function set width(w:Number):void
		{
			_width = w;
//			html.width = _width;
		}
		
		public override function get width():Number
		{
			return _width;
		}
		
		public function refresh():void
		{
//			html.navigateInSystemBrowser = false;
//			html.reload();
//			html.navigateInSystemBrowser = true;
		}
		
		public function set url(url:String):void
		{
			_url = url;
			urlReq.url = _url;
//			html.load(urlReq);
		}
		
		public function get url():String
		{
			return _url;
		}
	}

}