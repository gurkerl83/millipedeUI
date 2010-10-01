package billdwhite.listnew.filters
{
    import mx.collections.ArrayCollection;
    
    public class AbstractFilter
    {        
        public var filtername:String = "";
        
        public function AbstractFilter(filterNameArg:String)
        {
            filtername = filterNameArg;
        }
    
    
        public function accept(objectToFilter:Object):Boolean
        {
            return true;
        }
        
    }
    
}