////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 Tyler Chesley
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the “Software”), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 	
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//		
//		THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
////////////////////////////////////////////////////////////////////////////////////
package org.tylerchesley.bark.components
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	import mx.events.CloseEvent;
	
	import org.tylerchesley.bark.core.INotificationRenderer;
	import org.tylerchesley.bark.core.Notification;
	
	import spark.components.supportClasses.SkinnableComponent;
	import spark.components.supportClasses.TextBase;
	import spark.primitives.BitmapImage;

	//--------------------------------------
	//	Skin States
	//--------------------------------------
	
	/**
	 * 
	 * 
	 */	
	[SkinState("normal")]
	
	/**
	 * 
	 * 
	 */	
	[SkinState("hover")]
	
	/**
	 * 
	 * @author Tyler Chesley
	 * 
	 */	
	public class NotificationRenderer extends SkinnableComponent 
		implements INotificationRenderer
	{
		public function NotificationRenderer()
		{
			super();
			
			addHandlers();
		}
	
	//------------------------------------------------------------------------------
	//	Skin Parts
	//------------------------------------------------------------------------------
		
		[SkinPart(required="false")]
		
		/**
		 * A skin part that represents the close button of the renderer. 
		 */		
		public var closeElement:InteractiveObject;
		
		[SkinPart(required="false")]
		
		/**
		 * A skin part that defines the description of the renderer. 
		 */		
		public var descriptionElement:TextBase;
		
		[SkinPart(required="false")]
		
		/**
		 * A skin part that defines the icon of the renderer. 
		 */		
		public var iconElement:BitmapImage;
		
		[SkinPart(required="false")]
		
		/**
		 * A skin part that defines the title of the renderer. 
		 */		
		public var titleElement:TextBase;
		
	//------------------------------------------------------------------------------
	//	Properties
	//------------------------------------------------------------------------------
		
		//----------------------------------
		//	isOver
		//----------------------------------
		
		protected var isOver:Boolean = false;
		
		//----------------------------------
		//	notification
		//----------------------------------
		
		/**
		 * @private
		 * Storage of the notification propety 
		 */		
		private var _notification:Notification;
		
		public function get notification():Notification
		{
			return _notification;
		}
		
		/**
		 * @private
		 */		
		public function set notification(value:Notification):void
		{
			if (_notification == value)
				return;
			
			_notification = value;
		}
	
	//------------------------------------------------------------------------------
	//	Overriden Methods
	//------------------------------------------------------------------------------
		
		override protected function getCurrentSkinState() : String
		{
			if (isOver)
				return "hover";
			
			return "normal";
		}
		
		override protected function partAdded(partName:String, 
											  instance:Object) : void
		{
			super.partAdded(partName, instance);
			
			if (_notification != null)
			{
				if (instance == titleElement)
					titleElement.text = _notification.title;
				
				if (instance == descriptionElement)
					descriptionElement.text = _notification.description;
				
				if (instance == iconElement)
					iconElement.source = notification.icon;
				
				if (instance == closeElement)
					closeElement.addEventListener(MouseEvent.CLICK, 
												 closeElement_clickHandler);
			}
		}
		
		override protected function partRemoved(partName:String, 
												instance:Object) : void
		{
			super.partRemoved(partName, instance);
			
			if (instance == closeElement)
				closeElement.removeEventListener(MouseEvent.CLICK, 
												 closeElement_clickHandler);
		}
	
	//------------------------------------------------------------------------------
	//	Methods
	//------------------------------------------------------------------------------
		
		protected function addHandlers() : void
		{
			addEventListener(MouseEvent.ROLL_OVER, mouseEventHandler);
			addEventListener(MouseEvent.ROLL_OUT, mouseEventHandler);
		}
	
	//------------------------------------------------------------------------------
	//	Event Handlers
	//------------------------------------------------------------------------------
		
		/**
		 * @private 
		 * @param event
		 * 
		 */		
		protected function closeElement_clickHandler(event:MouseEvent):void
		{	// Stop
			event.stopPropagation();
			dispatchEvent(new CloseEvent(CloseEvent.CLOSE));
		}
		
		/**
		 * @private
		 * @param event
		 */		
		protected function mouseEventHandler(event:MouseEvent):void
		{
			switch (event.type)
			{
				case MouseEvent.ROLL_OUT:
				{
					isOver = false;
					break;
				}
				
				case MouseEvent.ROLL_OVER:
				{
					isOver = true;
					break;
				}
			}
			
			invalidateSkinState();
		}
	
	}
}