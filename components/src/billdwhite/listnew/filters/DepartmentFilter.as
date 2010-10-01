package billdwhite.listnew.filters
{
    import billdwhite.listnew.model.Teacher;
    
    import mx.collections.ArrayCollection;
    
    [Bindable]
    public class DepartmentFilter
    extends AbstractFilter
    {
        // the filter criteria array is used when determining if the object being filtered is a memeber of a 
        // group;  (ie, does the filter target's group intersect with the list of visible groups?)
        public var filterCriteriaArrayCollection:ArrayCollection = null;
        
        public function DepartmentFilter(filterCriteriaArg:ArrayCollection)
        {
            super("DEPARTMENT_FILTER");
            filterCriteriaArrayCollection = filterCriteriaArg;
        }
        
        
        override public function accept(objectToFilter:Object):Boolean
        {
            var returnValue:Boolean = false;
            var teacher:Teacher = objectToFilter as Teacher;
            
            for (var j:int=0; j<filterCriteriaArrayCollection.length; j++)
            {
                if (filterCriteriaArrayCollection.getItemAt(j) == teacher.department)
                {
                    returnValue = true;
                    break;
                }
            }
            return returnValue;
        }
        
    }

}