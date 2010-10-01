package flexponential.dropdownlist
{
	import mx.core.mx_internal;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import spark.core.NavigationUnit;
    import spark.events.IndexChangeEvent;
	import spark.components.DropDownList;
	
    use namespace mx_internal;
    
	public class OptgroupDropDownList extends DropDownList
	{
        
        /**
         * Override the setSelectedIndex() mx_internal method to not select an item that
         * has selectionEnabled=false.
         */
        override mx_internal function setSelectedIndex(value:int, dispatchChangeEvent:Boolean = false):void
        {
            if (value == selectedIndex)
                return;
            
            if (value >= 0 && value < dataProvider.length){
                if (dataProvider.getItemAt(value).selectionEnabled != false){
                    
                    if (dispatchChangeEvent)
                        dispatchChangeAfterSelection = dispatchChangeEvent;
                    
                    _proposedSelectedIndex = value;
                    invalidateProperties();
                }
            } else {
                if (dispatchChangeEvent)
                    dispatchChangeAfterSelection = dispatchChangeEvent;
                
                _proposedSelectedIndex = value;
                invalidateProperties();
            }
        }
        
        /**
         * Override the setSelectedIndex() mx_internal method to not select an item that
         * has selectionEnabled=false.
         */
        override mx_internal function setSelectedIndices(value:Vector.<int>, dispatchChangeEvent:Boolean = false):void
        {
            var newValue:Vector.<int> = new Vector.<int>;
            // take out indices that are on items that have selectionEnabled=false
            
            for(var i:int = 0; i < value.length; i++)
            {
                
                var item:* = dataProvider.getItemAt(value[i]);
                
                if (item.selectionEnabled == false)
                {
                    continue;
                }
                
                newValue.push(value[i]);
            }
            
            super.setSelectedIndices(newValue, dispatchChangeEvent);
        }
          
        /**
         *  Override the keyDownHandler() to skip unselectable items
         */
        override protected function keyDownHandler(event:KeyboardEvent) : void
        {
            if (!enabled)
                return; 
            
            if (!dropDownController.processKeyDown(event))
            {
                var navigationUnit:uint = event.keyCode;
                
                if (findKey(event.charCode))
                {
                    event.preventDefault();
                    return;
                }
                
                if (!NavigationUnit.isNavigationUnit(navigationUnit))
                    return;
                
                var proposedNewIndex:int = NO_SELECTION;
                var currentIndex:int;
                
                if (isDropDownOpen)
                {   
                    // Normalize the proposed index for getNavigationDestinationIndex
                    currentIndex = userProposedSelectedIndex < NO_SELECTION ? NO_SELECTION : userProposedSelectedIndex;
                    proposedNewIndex = layout.getNavigationDestinationIndex(currentIndex, navigationUnit, arrowKeysWrapFocus);
                    
                    
                    //
                    // Flexponential: Added logic here to skip over indices that are not selectable
                    //
                    while (dataProvider.getItemAt(proposedNewIndex).selectionEnabled == false) 
                    {
                        if (navigationUnit == NavigationUnit.DOWN || 
                            navigationUnit == NavigationUnit.PAGE_DOWN || 
                            navigationUnit == NavigationUnit.HOME)
                            proposedNewIndex++;
                        
                        else if (navigationUnit == NavigationUnit.UP || 
                            navigationUnit == NavigationUnit.PAGE_UP || 
                            navigationUnit == NavigationUnit.END)
                            proposedNewIndex--;
                        
                        if (proposedNewIndex >= dataProvider.length || proposedNewIndex < 0)
                            return;
                        
                    }
                    
                    if (proposedNewIndex != NO_SELECTION)
                    {
                        changeHighlightedSelection(proposedNewIndex);
                        event.preventDefault();
                    }
                }
                else if (dataProvider)
                {
                    var maxIndex:int = dataProvider.length - 1;
                    
                    // Normalize the proposed index for getNavigationDestinationIndex
                    currentIndex = caretIndex < NO_SELECTION ? NO_SELECTION : caretIndex;
                    
                    switch (navigationUnit)
                    {
                        case NavigationUnit.UP:
                        {
                            if (arrowKeysWrapFocus && 
                                (currentIndex == 0 || 
                                    currentIndex == NO_SELECTION || 
                                    currentIndex == CUSTOM_SELECTED_ITEM))
                                proposedNewIndex = maxIndex;
                            else
                                proposedNewIndex = currentIndex - 1;  
                            event.preventDefault();
                            break;
                        }                      
                            
                        case NavigationUnit.DOWN:
                        {
                            if (arrowKeysWrapFocus && 
                                (currentIndex == maxIndex || 
                                    currentIndex == NO_SELECTION || 
                                    currentIndex == CUSTOM_SELECTED_ITEM))
                                proposedNewIndex = 0;
                            else
                                proposedNewIndex = currentIndex + 1;  
                            event.preventDefault();
                            break;
                        }
                            
                        case NavigationUnit.PAGE_UP:
                        {
                            proposedNewIndex = currentIndex == NO_SELECTION ? 
                                NO_SELECTION : Math.max(currentIndex - PAGE_SIZE, 0);
                            event.preventDefault();
                            break;
                        }
                            
                        case NavigationUnit.PAGE_DOWN:
                        {    
                            proposedNewIndex = currentIndex == NO_SELECTION ?
                                PAGE_SIZE : (currentIndex + PAGE_SIZE);
                            event.preventDefault();
                            break;
                        }
                            
                        case NavigationUnit.HOME:
                        {
                            proposedNewIndex = 0;
                            event.preventDefault();
                            break;
                        }
                            
                        case NavigationUnit.END:
                        {
                            proposedNewIndex = maxIndex;  
                            event.preventDefault();
                            break;
                        }  
                            
                    }
                    
                    proposedNewIndex = Math.min(proposedNewIndex, maxIndex);
                    
                    if (proposedNewIndex >= 0)
                        setSelectedIndex(proposedNewIndex, true);
                }
            }
            else
            {
                event.preventDefault();
            }
            
        }
	}
}