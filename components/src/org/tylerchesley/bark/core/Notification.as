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
package org.tylerchesley.bark.core
{
	import flash.events.EventDispatcher;
	
	import org.tylerchesley.bark.components.NotificationRenderer;

	//--------------------------------------
	//	Events
	//--------------------------------------
	
	[Event(name="notificationItemClick", type="org.tylerchesley.bark.events.NotificationEvent")]
	
	[Bindable]
	/**
	 * 
	 * @author Tyler Chesley
	 * 
	 */	
	public class Notification extends EventDispatcher
	{
		
	//------------------------------------------------------------------------------
	//	Static Constants
	//------------------------------------------------------------------------------
		
		/**
		 * 
		 */		
		public static const DEFAULT:String = 'default';
		
		/**
		 * 
		 * @param type
		 * @param title
		 * @param description
		 * @param icon
		 * 
		 */		
		public function Notification(type:String = DEFAULT, 
									 duration:Number = 5000,
									 title:String = '', 
									 description:String = '', 
									 icon:Object = null)
		{
			this.type = type;
			this.duration = duration;
			this.title = title;
			this.description = description;
			this.icon = icon;
		}
	
	//------------------------------------------------------------------------------
	//	Properties
	//------------------------------------------------------------------------------
		
		/**
		 * @default 
		 */		
		public var type:String;
		
		/**
		 * The amount of time in miliseconds that the notification renderer will be 
		 * displayed. If you set the duration to Infinity the renderer will not be 
		 * removed until the user dismisses the notification by clicking on it. 
		 * 
		 * @default 
		 */		
		public var duration:Number;
		
		/**
		 * 
		 */		
		public var renderer:Class = NotificationRenderer;
		
		/**
		 * 
		 */		
		public var title:String;
		
		/**
		 * 
		 */		
		public var description:String;
		
		/**
		 * 
		 */		
		public var icon:Object;
	
	}
}