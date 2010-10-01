package billdwhite.listnew.events
{
    import billdwhite.listnew.filters.AbstractFilter;
    
    import flash.events.Event;
    
    public class FilterListEvent extends Event
    {
        public static const FILTERLISTEVENT:String = "filterListEvent";        
        public var filter:AbstractFilter;        
        
        
        public function FilterListEvent(filterArg:AbstractFilter=null):void
        {
            super(FILTERLISTEVENT, bubbles, cancelable);
            filter = filterArg;
        }
        
        
        public override function clone():Event
        {
            var returnEvent:FilterListEvent = new FilterListEvent(filter);
            return returnEvent;
        }
        
    }
    
}