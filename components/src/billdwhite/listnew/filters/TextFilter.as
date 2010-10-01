package billdwhite.listnew.filters
{
    import billdwhite.listnew.model.Teacher;
    
    import mx.collections.ArrayCollection;
    
    [Bindable]
    public class TextFilter
    extends AbstractFilter
    {
        public var filterText:String = "";
            
        
        public function TextFilter(filterTextArg:String)
        {
            super("TEXT_FILTER");
            filterText = filterTextArg;
        }
        
        
        override public function accept(objectToFilter:Object):Boolean
        {
            var returnValue:Boolean = false;
            var teacher:Teacher = objectToFilter as Teacher;
            
            if (
                 (filterText == null)
                 || 
                 (filterText.length == 0)
                 ||
                 (teacher.firstname.toLowerCase().indexOf(filterText.toLowerCase()) > -1)
                 ||
                 (teacher.lastname.toLowerCase().indexOf(filterText.toLowerCase()) > -1)
                 ||
                 (teacher.email.toLowerCase().indexOf(filterText.toLowerCase()) > -1)
               )
            {
                returnValue = true;
            }
            
            return returnValue;
        }
        
    }
    
}