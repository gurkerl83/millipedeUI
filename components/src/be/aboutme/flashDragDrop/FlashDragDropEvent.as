package be.aboutme.flashDragDrop
{
	import flash.events.Event;

	public class FlashDragDropEvent extends Event
	{
		
		public static const DRAG_ENTER:String = "dragEnter";
		public static const DRAG_LEAVE:String = "dragLeave";
		public static const DRAG_OVER:String = "dragOver";
		public static const DROP_DATA:String = "dropData";
		public static const DROP_FILE:String = "dropFile";
		
		public var data:*;
		
		public function FlashDragDropEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		public override function clone():Event {
            return new FlashDragDropEvent(type, data, bubbles, cancelable);
        }
		
	}
}