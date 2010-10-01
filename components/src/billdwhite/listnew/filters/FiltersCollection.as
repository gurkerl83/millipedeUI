package billdwhite.listnew.filters
{
    import mx.collections.ArrayCollection;
    
    public class FiltersCollection
    {
        private var filterArrayCollection:ArrayCollection = new ArrayCollection();
        
        public function FiltersCollection()
        {
        }

        public function getFilter(filterNameArg:String):AbstractFilter
        {
            var returnFilter:AbstractFilter = null;
            var nextFilter:AbstractFilter = null;
            for (var i:int = 0; i < filterArrayCollection.length; i++)
            {
                nextFilter = filterArrayCollection.getItemAt(i) as AbstractFilter;
                if (nextFilter.filtername.toLowerCase() == filterNameArg)
                {
                    returnFilter = nextFilter;
                    break;
                }
            }
            return returnFilter;
        }
        
        public function addFilter(filterArg:AbstractFilter):void
        {
            // first search for the existing version of this filter in the internal arraycollection
            var existingFilter:Boolean = false;
            var nextFilter:AbstractFilter = null;
            for (var i:int = 0; i < filterArrayCollection.length; i++)
            {
                nextFilter = filterArrayCollection.getItemAt(i) as AbstractFilter;
                if (nextFilter.filtername.toLowerCase() == filterArg.filtername.toLowerCase())
                {
                    // the filter is already in the arraycollection so update it
                    filterArrayCollection.removeItemAt(i);
                    filterArrayCollection.addItemAt(filterArg, i);
                    existingFilter = true;
                    break;
                }
            }
            // if the filter was not already in the internal arraycollection, add it.
            if (!existingFilter)
            {
                filterArrayCollection.addItem(filterArg);
            }
        }
        
        public function get length():int
        {
            return filterArrayCollection.length;
        }
        
        public function getFilterAt(filterIndexArg:int):AbstractFilter
        {
            return filterArrayCollection.getItemAt(filterIndexArg) as AbstractFilter;
        }
        
        public function getFilters():Array
        {
            return filterArrayCollection.toArray();
        }
    }
}