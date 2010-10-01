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
package org.tylerchesley.bark.managers
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import mx.core.FlexGlobals;
	import mx.effects.Effect;
	import mx.effects.IEffect;
	import mx.events.CloseEvent;
	import mx.events.EffectEvent;
	import mx.managers.PopUpManager;
	
	import org.tylerchesley.bark.core.INotificationRenderer;
	import org.tylerchesley.bark.core.Notification;
	import org.tylerchesley.bark.events.NotificationEvent;
	
	import spark.components.supportClasses.GroupBase;
	import spark.effects.Fade;

	//--------------------------------------
	//	Events
	//--------------------------------------
	
	[Event(name="notificationAdd", type="org.tylerchesley.bark.NotificationEvent")]
	
	[Event(name="notificationRemove", type="org.tylerchesley.bark.NotificationEvent")]
	
	//--------------------------------------
	//	Styles
	//--------------------------------------
	
	[Style(name="horizontalGap", type="Number")]
	
	[Style(name="verticalGap", type="Number")]
	
	/**
	 * 
	 * @author Tyler Chesley
	 * 
	 * TODO:
	 * Get show and hide effects working.
	 * Get moved effect working correctly. 
	 * Switch to using Flex layouts instead of custom layout model.
	 * 
	 */	
	public class NotificationManager extends EventDispatcher
	{
		
		/**
		 * @private 
		 */		
		private static var instance:NotificationManager;
		
	//------------------------------------------------------------------------------
	//	Static Methods
	//------------------------------------------------------------------------------
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public static function getInstance():NotificationManager
		{
			if (!instance)
			{
				instance = new NotificationManager();
			}
			
			return instance;
		}
		
		/**
		 * 
		 * @param target
		 * @param rendererProviders
		 * 
		 */		
		public static function initialize(target:DisplayObject = null):void
		{
			instance = new NotificationManager(target);
		}
	
	//------------------------------------------------------------------------------
	//	Constructor
	//------------------------------------------------------------------------------
	
		/**
		 * 
		 * @param target
		 * @param rendererProviders
		 * 
		 */		
		public function NotificationManager(target:DisplayObject = null)
		{
			super();
			
			if (instance)
			{
				throw new Error("Instance already exists.");
			}
			
			_target = target;
			
			// Add the listener for notify events
			this.target.addEventListener(NotificationEvent.NOTIFY, 
										 notifyHandler);
			
			showEffect = new Fade();
			showEffect.duration = 700;
			Fade(showEffect).alphaFrom = 0;
			Fade(showEffect).alphaTo = 1;
			
			hideEffect = new Fade();
			hideEffect.duration = 700;
			Fade(hideEffect).alphaFrom = 1;
			Fade(hideEffect).alphaTo = 0;
		}
	
	//------------------------------------------------------------------------------
	//	Variables
	//------------------------------------------------------------------------------
		
		/**
		 * @private 
		 */		
		private var _target:DisplayObject;
		
		protected function get target():DisplayObject
		{
			if (!_target)
			{
				return FlexGlobals.topLevelApplication as DisplayObject;
			}
			
			return _target;
		}
		
		protected var notifications:Vector.<NotificationData> = new Vector.<NotificationData>();
	
	//------------------------------------------------------------------------------
	//	Properties
	//------------------------------------------------------------------------------
		
		//----------------------------------
		//	showEffect
		//----------------------------------
		
		/**
		 * @private
		 * Storage of the showEffect property. 
		 */		
		private var _showEffect:IEffect;
		
		public function get showEffect():IEffect
		{
			return _showEffect;
		}
		
		/**
		 * @private
		 */		
		public function set showEffect(value:IEffect):void
		{
			if (_showEffect == value)
				return;
			
			_showEffect = value;
		}
		
		//----------------------------------
		//	moveEffect
		//----------------------------------
		
		private var _moveEffect:IEffect;
		
		public function get moveEffect():IEffect
		{
			return _moveEffect;
		}
		
		public function set moveEffect(value:IEffect):void
		{
			if (_moveEffect == value)
				return;
				
			_moveEffect = value;
		}
		
		//----------------------------------
		//	hideEffect
		//----------------------------------
		
		private var _hideEffect:IEffect;
		
		public function get hideEffect():IEffect
		{
			return _hideEffect;
		}
		
		public function set hideEffect(value:IEffect):void
		{
			if (_hideEffect == value)
				return;
			
			_hideEffect = value;
		}
	
	//------------------------------------------------------------------------------
	//	Methods
	//------------------------------------------------------------------------------
		
		/**
		 * 
		 * @param renderer
		 * @param duration
		 * 
		 */		
		public function addNotification(notification:Notification):void
		{
			var data:NotificationData = new NotificationData();
			data.notification = notification;
			notifications.push(data);
			
			// Add event listener
			notification.addEventListener(NotificationEvent.NOTIFICATION_ITEM_CLICK, 
										  notificationItemClickHandler);
			
			var renderer:INotificationRenderer = createNotificationRenderer(notification);
			data.renderer = renderer;
			PopUpManager.addPopUp(renderer, target);
			
			layoutNotifications();
			
			if (renderer.getStyle("addedEffect"))
				renderer.addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
			else
				showEffectEnded(data);
			
			// Trigger the show effect.
			renderer.visible = true;
			
			dispatchEvent(new NotificationEvent(NotificationEvent.NOTIFICATION_ADD, 
												notification, renderer));
		}
		
		/**
		 * 
		 * @param notification
		 * @return 
		 * 
		 */		
		public function createNotificationRenderer(notification:Notification):INotificationRenderer
		{
			var renderer:INotificationRenderer = new notification.renderer();
			renderer.notification = notification;
			
			if (notification.type)
				renderer.styleName = notification.type;
				
			if (showEffect) 
			{
				// We have to add an addedEffect because the show effect doesn't 
				// work.
				renderer.setStyle('addedEffect', showEffect);
				renderer.setStyle('showEffect', showEffect);
			}
				
			if (hideEffect)
				renderer.setStyle('hideEffect', hideEffect);
			
			renderer.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			
			// Add event listeners
			renderer.addEventListener(CloseEvent.CLOSE, closeHandler);
			renderer.addEventListener(MouseEvent.CLICK, clickHandler);
			
			// Set visible to false so that when it's set to visible it triggers the 
			// show effect.
			renderer.visible = false;
			
			return renderer;
		}
		
		protected function isMouseOver(renderer:INotificationRenderer):Boolean
		{
			if (!renderer || !renderer.stage)
    			return false;
    		
    		return renderer.hitTestPoint(renderer.stage.mouseX,
    							   		 renderer.stage.mouseY, true);
		}
		
		protected function findNotificationData(search:Object):NotificationData
		{
			const n:int = notifications.length;
			for (var i:int = 0; i < n; i++)
			{
				var data:NotificationData = notifications[i];
				if (data.notification == search || 
					data.renderer == search || 
					data.timer == search)
				{
					return data;
				}
			}
			return null;
		}
		
		/**
		 * @private 
		 * 
		 */		
		private function layoutNotifications():void
		{
			var width:Number = target.width;
			var height:Number = target.height;
//			var y:Number = 10;
			var begin:Number = height - 100;// - notifications[0].renderer.height;
			var y:Number = begin;//(height - 10 - notifications[0].renderer.height);//(10 + 42);//renderer.height);
			var verticalGap:Number = 10;
			var n:int = notifications.length;
			var col:Number = 1;
			
			for (var i:int = 0; i < n; i++)
			{
				var data:NotificationData = notifications[i];
				var renderer:INotificationRenderer = data.renderer;
				
//				if (y + renderer.height + 10 > height) 
//				{
//					// Start a new column
//					col++;
//					y = 10;
//				}
				
				renderer.width = 200;
				renderer.x = width - (210 * col);
				renderer.y = y;
//				y += renderer.height + verticalGap;
//				y -= (renderer.height + verticalGap);
			}
			
		}
		
		/**
		 * 
		 * @param notification
		 * 
		 */		
		public function removeNotification(notification:Notification):void
		{
			var data:NotificationData = findNotificationData(notification);
			var renderer:INotificationRenderer = data.renderer;
			renderer.addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
			
			if (renderer.getStyle("hideEffect"))
			{
				// This will trigger the hide effect. 
				renderer.visible = false;
			}
			else
			{
				hideEffectEnded(data);
			}
		}
		
		/**
		 * Starts the duration timer if applicable.
		 *  
		 * @param notification
		 * @private
		 */		
		protected function showEffectEnded(data:NotificationData):void
		{
			var notification:Notification = data.notification;
			data.renderer.removeEventListener(EffectEvent.EFFECT_END, 
											  effectEndHandler);
			if (notification.duration < Infinity)
			{
				var timer:Timer = new Timer(notification.duration);
				data.timer = timer;
				timer.addEventListener(TimerEvent.TIMER, timerHandler);
				timer.start();
			}
		}
		
		/**
		 * 
		 * @param renderer
		 * @private
		 */		
		protected function hideEffectEnded(data:NotificationData):void
		{
			var renderer:INotificationRenderer = data.renderer;
			var notification:Notification = data.notification;
			var timer:Timer = data.timer;
			
			if (timer) // Timer can be null if duration is set to infinity
			{
				timer.removeEventListener(TimerEvent.TIMER, timerHandler);
				timer.stop();
			}
			
			// Remove notification event listeners
			notification.removeEventListener(NotificationEvent.NOTIFICATION_ITEM_CLICK,
											 notificationItemClickHandler);
			
			// Remove from notifications list
			notifications.splice(notifications.indexOf(data), 1);
			
			// Remove event listeners
			renderer.removeEventListener(EffectEvent.EFFECT_END, effectEndHandler);
			renderer.removeEventListener(CloseEvent.CLOSE, closeHandler);
			renderer.removeEventListener(MouseEvent.CLICK, clickHandler);
			
			// Remove renderer from display
			PopUpManager.removePopUp(renderer);
			
			dispatchEvent(new NotificationEvent(NotificationEvent.NOTIFICATION_REMOVE, 
												notification, renderer));
		}
		
	//------------------------------------------------------------------------------
	//	Event Handlers
	//------------------------------------------------------------------------------
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function clickHandler(event:MouseEvent):void
		{
			var renderer:INotificationRenderer;
			var target:DisplayObject = event.target as DisplayObject;
			
			while (!renderer)
			{
				if (target is INotificationRenderer)
				{
					renderer  = target as INotificationRenderer;
					break;
				}
				target = target.parent;
			}
			
			var notification:Notification = renderer.notification;
			notification.dispatchEvent(
					new NotificationEvent(NotificationEvent.NOTIFICATION_ITEM_CLICK, 
									  	  notification, renderer));
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function closeHandler(event:CloseEvent):void
		{
			var renderer:INotificationRenderer = event.target as INotificationRenderer;
			removeNotification(renderer.notification);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function effectEndHandler(event:EffectEvent):void
		{
			var renderer:INotificationRenderer = event.target as 
															INotificationRenderer;
			var data:NotificationData = findNotificationData(renderer);
			if (event.effectInstance.effect == showEffect)
				showEffectEnded(data);
			else if (event.effectInstance.effect == hideEffect)
			{
				hideEffectEnded(data);
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function notifyHandler(event:NotificationEvent):void
		{
			addNotification(event.notification);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function notificationItemClickHandler(event:NotificationEvent):void
		{
			if (event.preventDefault())
			{
				return;
			}
			
			removeNotification(event.notification);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function rollOverHandler(event:MouseEvent):void
		{
			var renderer:INotificationRenderer = event.target as INotificationRenderer;
			var data:NotificationData = findNotificationData(renderer);
			var rHideEffect:Effect = renderer.getStyle("hideEffect");
			var timer:Timer = data.timer;
			
			if (timer) // Timer can be null if duration is set to infinity
			{
				timer.reset();
				timer.start();
			}
			
			if (rHideEffect.isPlaying)
			{
				renderer.removeEventListener(EffectEvent.EFFECT_END, 
											 effectEndHandler);
				rHideEffect.stop();
				
				// Trigger the show effect if any.
				renderer.visible = true;
				renderer.alpha = 1;
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function timerHandler(event:TimerEvent):void
		{
			var data:NotificationData = findNotificationData(event.target);
			
			if (isMouseOver(data.renderer))
			{
				var timer:Timer = data.timer;
				timer.reset();
				timer.start();
				return;
			}
			
			if (data)
			{
				removeNotification(data.notification);
			}
		}
		
	}
}
import org.tylerchesley.bark.core.Notification;
import org.tylerchesley.bark.core.INotificationRenderer;
import flash.utils.Timer;

class NotificationData
{
	public function NotificationData()
	{
		
	}

	public var notification:Notification;
	
	public var renderer:INotificationRenderer;
	
	public var timer:Timer;
	
}