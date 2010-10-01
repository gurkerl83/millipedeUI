package com.adambergman.ui.layout
{
	/*************************************************************************
	  
		Copyright 2009 Adam Bergman (adambergman.com).  
		
		You are free to use this code in any personal or commercial projects.
		I only ask that if you intend to use this code in any commercial project, 
		please contact me via adambergman.com and let me know.
		 
	*************************************************************************/
	
	import flash.display.DisplayObject;
	
//	import gs.TweenLite;
//	import gs.easing.*;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	
	import mx.core.ILayoutElement;
	
	import spark.components.supportClasses.GroupBase;
	import spark.layouts.supportClasses.LayoutBase;

	public class PagedLayout extends LayoutBase
	{
		[Bindable] public static var EASING_BOUNCE:String	= "bounce";
		[Bindable] public static var EASING_ELASTIC:String	= "elastic";
		[Bindable] public static var EASING_DEFAULT:String	= "";
		[Bindable] public static var EASING_CUBIC:String	= "cubic";
		
		
		// Private variables for our properties
		private var _currentPage:Number = 1;
		private var _requestedPage:Number = 1;
		private var _totalPages:Number = 1;
		private var _itemPadding:Number = 10;
		private var _isAnimating:Boolean = false;
		private var _animationDuration:Number = 1;
		private var _useAnimation:Boolean = true;
		private var _easingFunction:Function = Quad.easeOut;
		private var _easingType:String = EASING_DEFAULT;
		
		public function get easingType():String
		{
			return _easingType;
		}

		public function set easingType(v:String):void
		{
			switch(v)
			{
				case EASING_BOUNCE:		this.easingFunction = Bounce.easeOut; 	break;
				case EASING_ELASTIC:	this.easingFunction = Elastic.easeOut; 	break;
				case EASING_DEFAULT:	this.easingFunction = Quad.easeOut; 	break;
				case EASING_CUBIC:		this.easingFunction = Cubic.easeOut; 	break;				
				default:				this.easingFunction = Linear.easeNone;	break;
			}
			_easingType = v;
		}		

		private function get easingFunction():Function
		{
			return _easingFunction;
		}

		private function set easingFunction(v:Function):void
		{
			_easingFunction = v;
		}

		
		
		public function PagedLayout()
		{
			super();
			this.clipAndEnableScrolling = true;
		}
		
		[Bindable] 

		[Bindable] public function get useAnimation():Boolean
		{
			return _useAnimation;
		}

		public function set useAnimation(v:Boolean):void
		{
			_useAnimation = v;
		}

		[Bindable] public function get animationDuration():Number
		{
			return _animationDuration;
		}

		public function set animationDuration(v:Number):void
		{
			_animationDuration = v;
		}

		[Bindable] public function get isAnimating():Boolean
		{
			return _isAnimating;
		}

		private function set isAnimating(v:Boolean):void
		{
			_isAnimating = v;
		}

		[Bindable] public function get requestedPage():Number
		{
			return _requestedPage;
		}

		public function set requestedPage(v:Number):void
		{
			_requestedPage = v;
		}

		public function get itemPadding():Number
		{
			return _itemPadding;
		}

		public function set itemPadding(v:Number):void
		{
			_itemPadding = v;
			var layoutTarget:GroupBase = target; 
            if (!layoutTarget)
                return;
			layoutTarget.invalidateDisplayList();
		}

		[Bindable] public function get totalPages():Number
		{                        
			return _totalPages;
		}
		
		private function set totalPages(v:Number):void
		{                        
			_totalPages = v;
		}

		[Bindable] public function get currentPage():Number
		{
			return _currentPage;
		}
		
		private function set currentPage(v:Number):void
		{                        
			_currentPage = v;
		}
		
		private var switchIt:Boolean = false;
		
		// Move to the Next Page
		public function next():void
		{
			if(this.isAnimating){ return; }
			updatePageCount();
			if(this.currentPage + 1 > this.totalPages)
			{
				this.requestedPage = 1;	
				switchIt = true;
			}else{
				this.requestedPage++;
			}
			var layoutTarget:GroupBase = target; 
            if (!layoutTarget)
                return;
			layoutTarget.invalidateDisplayList();
		}
		
		// Move to the Previous Page
		public function previous():void
		{
			if(this.isAnimating){ return; }
			updatePageCount();
			if(this.currentPage - 1 == 0)
			{
				this.requestedPage = this.totalPages;	
				switchIt = true;
			}else{
				this.requestedPage--;
			}
			var layoutTarget:GroupBase = target; 
            if (!layoutTarget)
                return;
			layoutTarget.invalidateDisplayList();
		}
		
		// Examine the width of the container and all layout elements
		// and determine the number of pages 
		private function updatePageCount():void
		{
			var layoutTarget:GroupBase = target; 
            if (!layoutTarget)
                return;
                
			var element:ILayoutElement;
			var pageCount:Number = 1;        
            var totalWidth:Number = 0;
			
			for (var index:int = 0; index < target.numElements; index++)
            {
//            	element = target.getElementAt(index);
				element = useVirtualLayout ? target.getVirtualElementAt(index) : target.getElementAt(index);
            	if( !element.includeInLayout )
                	continue;
                	
               	totalWidth += element.getLayoutBoundsWidth() + _itemPadding;
              	
              	if(totalWidth > layoutTarget.width)
               	{
               		pageCount++;
               		totalWidth = element.getLayoutBoundsWidth() + _itemPadding;
               	}
            }
            
            this.totalPages = pageCount;
		}
		
		// Returns true if the given "testElement" exists on the the given page "pageNumber"
		private function isElementOnPage(testElement:ILayoutElement, pageNumber:Number):Boolean
		{
			
			var layoutTarget:GroupBase = target; 
            if (!layoutTarget)
                return false;
                
			var element:ILayoutElement;
			var pageCount:Number = 1;        
            var totalWidth:Number = 0;
			var layoutWidth:Number = layoutTarget.width + layoutTarget.getStyle("paddingRight") + layoutTarget.getStyle("paddingLeft");
			
			for (var index:int = 0; index < target.numElements; index++)
            {
//            	element = target.getElementAt(index);
				element = useVirtualLayout ? target.getVirtualElementAt(index) : target.getElementAt(index);
            	if( !element.includeInLayout )
                	continue;
                	
               	totalWidth += element.getLayoutBoundsWidth() + _itemPadding;
              	
              	if(totalWidth > layoutTarget.width)
               	{
               		pageCount++;
               		totalWidth = element.getLayoutBoundsWidth() + _itemPadding;
               	}         
              	
              	if(element == testElement)
              	{
              		if(pageCount == pageNumber){ return true; }else{ return false; }
              	}             	
            }           
            return false;
		}

		// This is the method that actually moves layout elements into position
	    private function createPage(pageNum:Number, offset:Number=0, hideItems:Boolean=true):void
	    {	    	
	    	// hack to check if the current Page Number requested is less than or equal to
	    	// the total amount of available pages (in case of window or component resize)
			if(pageNum > this.totalPages){ pageNum = this.totalPages; this.currentPage = pageNum; } 
			
	    	var layoutTarget:GroupBase = target; 
            if (!layoutTarget)
                return;
	    	
	    	var element:ILayoutElement;            
            var totalWidth:Number = 5;
            
            for (var index:int = 0; index < target.numElements; index++)
            {
//            	element = target.getElementAt(index);
				element = useVirtualLayout ? target.getVirtualElementAt(index) : target.getElementAt(index);
            	if( !element.includeInLayout )
                	continue;
                	              	
              	// Not sure if this is the best way of "hiding" 
              	// layout elements.  This could obviously be a problem
              	// if you are manually setting visibility.  Instead
              	// set includeInLayout = false and you should have no 
              	// problems.  If there is a better way to "hide"
              	// elements please drop me an e-mail.  I considered
              	// just moving them to negative X and Y positions but
              	// I thought this may cause a problem if a scroll bar is
              	// eventually worked into the code.  I'm assuming when I 
              	// go to try and animation this change this will need to be
              	// reworked heavily.
              	if(!isElementOnPage(element, pageNum))
              	{
              		if(hideItems){ DisplayObject(element).visible = false; }              		
              		continue;
              	}else{
              		DisplayObject(element).visible = true;
              		element.setLayoutBoundsPosition(totalWidth - offset, (layoutTarget.height / 2 - element.getLayoutBoundsHeight() / 2));
              		totalWidth += element.getLayoutBoundsWidth() + _itemPadding; 
              	}              	   			      	
            }
	    }
		
		private function animatePages(switchDirection:Boolean=false):void
		{
			var layoutTarget:GroupBase = target; 
            if (!layoutTarget)
                return;
             
            this.isAnimating = true;   

			var offsetMultiplier:Number;
			if(this.requestedPage > this.currentPage)
			{
				offsetMultiplier = -1;
			}else{
				offsetMultiplier = 1;
			}
			
			if(switchIt)
			{
				offsetMultiplier *= -1;	
			}
			
			var offset:Number = (layoutTarget.width + 10) * offsetMultiplier;
			
			createPage(this.currentPage);
			
			createPage(this.requestedPage, offset, false);
			
			var element:ILayoutElement;
			
            for (var index:int = 0; index < target.numElements; index++)
            {
//            	element = target.getElementAt(index);
				element = useVirtualLayout ? target.getVirtualElementAt(index) : target.getElementAt(index);
            	if( !element.includeInLayout )
                	continue;
				
              	if(isElementOnPage(element, this.currentPage) || isElementOnPage(element, this.requestedPage))
              	{
					TweenLite.to(DisplayObject(element), this.animationDuration, {x: DisplayObject(element).x + (offset), ease: this.easingFunction});
              	}
            }
            
            TweenLite.delayedCall(this.animationDuration, animationDone);              	
		}
		
		private function animationDone():void
		{
			this.isAnimating = false;
			this.currentPage = this.requestedPage;
		}
		
		// Override the updateDisplayList method and call our sub methods
		override public function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);
           	
           	var layoutTarget:GroupBase = target; 
            if (!layoutTarget)
                return;
            
            updatePageCount();
            
       		if(this.totalPages < 1){ return; }            
            
            if(this.requestedPage != this.currentPage && this.useAnimation)
            {
            	if(!this.isAnimating)
            	{
            		animatePages(this.switchIt);
            		this.switchIt = false;
            	}
            }else{
            	createPage(this.currentPage);
            }            
        }
	}
}