package billdwhite.listnew
{
    import billdwhite.listnew.events.FilterListEvent;
    import billdwhite.listnew.filters.DepartmentFilter;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import mx.collections.ArrayCollection;
    import mx.core.SoundAsset;
    import mx.effects.Parallel;
    import mx.effects.Resize;
    import mx.effects.easing.Cubic;
    import mx.events.EffectEvent;
    import mx.events.FlexEvent;
    import spark.components.Button;
    import spark.components.CheckBox;
    import spark.components.Group;
    import spark.components.HGroup;
    import spark.components.Panel;
    import spark.components.SkinnableContainer;
    import spark.components.supportClasses.SkinnableComponent;
    import spark.primitives.BitmapImage;
    
    [Event(name="filterListEvent", type="billdwhite.listnew.events.FilterListEvent")]
    
    [SkinState("opened")]
    [SkinState("closed")]
    
    public class FilterView 
    extends SkinnableComponent
    {
        
        
        /**
        * Constructor
        */        
        public function FilterView()
        {
            super();
            addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
        }
        
        
        
        /* ===================================================================================== skin parts ================ */

        
        [SkinPart(required="true")]
        public var filterVisibleButton:Button;
        
        [SkinPart(required="true")]
        public var dptMathCheckBox:CheckBox;
        
        [SkinPart(required="true")]
        public var dptEnglishCheckBox:CheckBox;
        
        [SkinPart(required="true")]
        public var dptArtCheckBox:CheckBox;
        
        [SkinPart(required="true")]
        public var dptScienceCheckBox:CheckBox;
        
        [SkinPart(required="true")]
        public var dptSpanishCheckBox:CheckBox;
        
        [SkinPart(required="true")]
        public var dptHomeEconomicsCheckBox:CheckBox;
        
        [SkinPart(required="true")]
        public var dptComputingCheckBox:CheckBox;
        
        [SkinPart(required="true")]
        public var dptBandCheckBox:CheckBox;
        
        [SkinPart(required="true")]
        public var dptTheaterCheckBox:CheckBox;
        
        [SkinPart(required="true")]
        public var dptAllCheckBox:CheckBox;
                
        
                    
        /* =========================================================================================== members ============= */
        
        
        
        public var filterVisible:Boolean = false;
        private var grow:Resize;
        private var shrink:Resize;
        
        
        
        
        /* =========================================================================================== bindable members ==== */
      
        
        
        [Bindable] private var CHECKBOX_LABEL_HEIGHT:Number = 14;
        [Bindable] private var CHECKBOX_LABEL_WIDTH:Number = 60;
        [Bindable] private var MAX_HEIGHT:Number = 185;
        [Bindable] private var MIN_HEIGHT:Number = 30;
        [Bindable] private var SHOW_HIDE_DURATION:Number = 250;
        
        
        
        /* ===================================================================================== partAdded ================= */

        
        
        override protected function partAdded(partName:String, instance:Object):void
        {
            super.partAdded(partName, instance);
            
            if (instance == dptAllCheckBox)
            {
                dptAllCheckBox.addEventListener(MouseEvent.CLICK, onToggleAllDepts);
            }
            else
            if (instance == dptMathCheckBox)
            {
                dptMathCheckBox.addEventListener(MouseEvent.CLICK, applyFilter);
            }
            else
            if (instance == dptEnglishCheckBox)
            {
                dptEnglishCheckBox.addEventListener(MouseEvent.CLICK, applyFilter);
            }
            else
            if (instance == dptArtCheckBox)
            {
                dptArtCheckBox.addEventListener(MouseEvent.CLICK, applyFilter);
            }
            else
            if (instance == dptScienceCheckBox)
            {
                dptScienceCheckBox.addEventListener(MouseEvent.CLICK, applyFilter);
            }
            else
            if (instance == dptSpanishCheckBox)
            {
                dptSpanishCheckBox.addEventListener(MouseEvent.CLICK, applyFilter);
            }
            else
            if (instance == dptHomeEconomicsCheckBox)
            {
                dptHomeEconomicsCheckBox.addEventListener(MouseEvent.CLICK, applyFilter);
            }
            else
            if (instance == dptComputingCheckBox)
            {
                dptComputingCheckBox.addEventListener(MouseEvent.CLICK, applyFilter);
            }
            else
            if (instance == dptBandCheckBox)
            {
                dptBandCheckBox.addEventListener(MouseEvent.CLICK, applyFilter);
            }
            else
            if (instance == dptTheaterCheckBox)
            {
                dptTheaterCheckBox.addEventListener(MouseEvent.CLICK, applyFilter);
            }
            else
            if (instance == filterVisibleButton)
            {
                filterVisibleButton.addEventListener(MouseEvent.CLICK, toggleFilterPanel);
            }
        }
        
        
        
        /* =========================================================================================== onCreationComplete == */
        
        
        
        private function onCreationComplete(event:Event=null):void
        {
            shrink = new Resize(this);
            shrink.easingFunction = Cubic.easeOut;
            shrink.duration = SHOW_HIDE_DURATION;
            shrink.heightFrom = MAX_HEIGHT;                
            shrink.heightTo = MIN_HEIGHT;
            shrink.addEventListener(EffectEvent.EFFECT_START, onShrinkEnd);   
            
            grow = new Resize(this);
            grow.easingFunction = Cubic.easeOut;
            grow.duration = SHOW_HIDE_DURATION;
            grow.heightFrom = MIN_HEIGHT;                
            grow.heightTo = MAX_HEIGHT;
            grow.addEventListener(EffectEvent.EFFECT_START, onGrowEnd);
        }
        
        
        
        /* =========================================================================================== getCurrentSkinState = */
        
        
        
        override protected function getCurrentSkinState():String
        {
            var returnSkinState:String = "closed";
            if (filterVisible)
            {
                returnSkinState = "opened";
            }
            return returnSkinState;
        }
        
        
        
        /* =========================================================================================== onShrinkEnd ========= */
        
        
        
        private function onShrinkEnd(event:Event=null):void
        {
            filterVisibleButton.label = 'Department Filter';
            filterVisible = false;
            onToggleAllDepts();
            invalidateSkinState();
        }
        
        
        
        /* =========================================================================================== onGrowEnd =========== */
        
        
        
        private function onGrowEnd(event:Event=null):void
        {
            filterVisibleButton.label = 'Close Department Filter';
            filterVisible = true;
            invalidateSkinState();
            applyFilter();
        }
        
        
        
        /* =========================================================================================== toggleFilterPanel === */
        
        
        
        public function toggleFilterPanel(event:Event=null):void
        {
            if (filterVisible)
            {
                shrink.play();
            }
            else
            {
                grow.play();
            }
        }
        
        
        
        /* =========================================================================================== applyFilter ========= */
        
        
        
        private function applyFilter(event:Event=null):void
        {
            var filterArray:Array = new Array();                
            var departmentsArrayCollection:ArrayCollection = new ArrayCollection();
                            
            if (dptMathCheckBox.selected) { departmentsArrayCollection.addItem(dptMathCheckBox.label); }
            if (dptEnglishCheckBox.selected) { departmentsArrayCollection.addItem(dptEnglishCheckBox.label); }
            if (dptArtCheckBox.selected) { departmentsArrayCollection.addItem(dptArtCheckBox.label); }
            if (dptScienceCheckBox.selected) { departmentsArrayCollection.addItem(dptScienceCheckBox.label); }
            if (dptSpanishCheckBox.selected) { departmentsArrayCollection.addItem(dptSpanishCheckBox.label); }
            if (dptHomeEconomicsCheckBox.selected) { departmentsArrayCollection.addItem(dptHomeEconomicsCheckBox.label); }
            if (dptComputingCheckBox.selected) { departmentsArrayCollection.addItem(dptComputingCheckBox.label); }
            if (dptBandCheckBox.selected) { departmentsArrayCollection.addItem(dptBandCheckBox.label); }
            if (dptTheaterCheckBox.selected) { departmentsArrayCollection.addItem(dptTheaterCheckBox.label); }
            
            // uncheck the all_depts checkbox when less than all of the checkboxes are selected
            if (departmentsArrayCollection.length < 9)
            {
                dptAllCheckBox.selected = false;
            }
            else
            {
                dptAllCheckBox.selected = true;
            }
            
            var departmentFilter:DepartmentFilter = new DepartmentFilter(departmentsArrayCollection);
            dispatchEvent(new FilterListEvent(departmentFilter));
        }
        
        
        
        /* =========================================================================================== onToggleAllDepts ==== */
        
        
        
        private function onToggleAllDepts(event:Event=null):void
        {
            dptMathCheckBox.selected = dptAllCheckBox.selected;
            dptEnglishCheckBox.selected = dptAllCheckBox.selected;
            dptArtCheckBox.selected = dptAllCheckBox.selected;
            dptScienceCheckBox.selected = dptAllCheckBox.selected;
            dptSpanishCheckBox.selected = dptAllCheckBox.selected;
            dptHomeEconomicsCheckBox.selected = dptAllCheckBox.selected;
            dptComputingCheckBox.selected = dptAllCheckBox.selected;
            dptBandCheckBox.selected = dptAllCheckBox.selected;
            dptTheaterCheckBox.selected = dptAllCheckBox.selected;
            
            applyFilter();
        }
    }
}