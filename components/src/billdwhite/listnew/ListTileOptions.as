package billdwhite.listnew
{
    import com.greensock.TweenMax;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import mx.core.SoundAsset;
    import mx.effects.easing.Cubic;
    import spark.components.Button;
    import spark.components.Group;
    import spark.components.HGroup;
    import spark.components.Panel;
    import spark.components.SkinnableContainer;
    import spark.components.supportClasses.SkinnableComponent;
    import spark.primitives.BitmapImage;
    
    
    [Event(name="close")]
    [Event(name="edit")]
    [Event(name="delete")]
    
    [SkinState("normal")]
    [SkinState("up")]
    [SkinState("over")]
    [SkinState("down")]
    [SkinState("disabled")]
    
    public class ListTileOptions 
    extends SkinnableComponent
    {
    
    
    
        /**
        * Constructor
        */
        public function ListTileOptions()
        {
            super();
        }
        
        
        
        /* ===================================================================================== skin parts ================ */

        
        
        [SkinPart(required="true")]
        public var optionsPanel:Group;
        
        [SkinPart(required="true")]
        public var optionsGroup:Group;
        
        [SkinPart(required="true")]
        public var editButton:Button;
        
        [SkinPart(required="true")]
        public var deleteButton:Button;
        
        [SkinPart(required="true")]
        public var cornerImage:BitmapImage;
        
        [SkinPart(required="true")]
        public var closeSound:SoundAsset;
        
        
        
        /* ===================================================================================== bindable members ========== */
        
        
        
        [Bindable] public var cornerSize:Number = 24;
        [Bindable] public var slideDistance:Number = 124;
        
        
        
        /* ===================================================================================== partAdded ================= */

        
        
        override protected function partAdded(partName:String, instance:Object):void
        {
            super.partAdded(partName, instance);
            
            if (instance == editButton)
            {
                editButton.addEventListener(MouseEvent.CLICK, onEditClick);
            }
            else
            if (instance == deleteButton)
            {
                deleteButton.addEventListener(MouseEvent.CLICK, onDeleteClick);
            }
        }
        
        

        /* ===================================================================================== onEditClick =============== */

        
        
        private function onEditClick(event:Event):void
        {
            dispatchEvent(new Event("edit"));
        }
        
        

        /* ===================================================================================== onDeleteClick ============= */

        
        
        private function onDeleteClick(event:Event):void
        {
            dispatchEvent(new Event("delete"));
        }
            
            

        /* ===================================================================================== open ====================== */

        
        
        public function open(callbackFunctionArg:Function):void
        {
            TweenMax.to(optionsPanel, .3, {x:0, onComplete:callbackFunctionArg});
        }
        
        

        /* ===================================================================================== close ===================== */

        
        
        public function close(completeFunctionArg:Function):void
        {
            closeSound.play();
            TweenMax.to(optionsPanel, .2, {x: -slideDistance, onComplete:completeFunctionArg});
        }
    }
}