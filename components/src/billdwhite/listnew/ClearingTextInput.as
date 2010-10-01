package billdwhite.listnew
{
    import flash.events.Event;
    import flash.events.FocusEvent;
    import flash.events.MouseEvent;
    
    import spark.components.Button;
    import spark.components.RichEditableText;
    import spark.components.TextInput;
    import spark.events.TextOperationEvent;
    
    [Event(name="clearClicked")]
    
    [SkinState("empty")]
    [SkinState("normal")]
    [SkinState("up")]
    [SkinState("over")]
    [SkinState("down")]
    [SkinState("disabled")]
    
    public class ClearingTextInput extends TextInput
    {
        
        
        
        /**
        * Constructor
        */
        public function ClearingTextInput()
        {
            super();
        }
        
        
        
        /* ===================================================================================== skin parts ================ */

        
        
        [SkinPart(required="true")]
        public var clearButton:Button;
        
        
        
        /* ===================================================================================== partAdded ================= */

        
        
        override protected function partAdded(partName:String, instance:Object):void
        {
            super.partAdded(partName, instance);
            
            if (instance == clearButton)
            {
                clearButton.addEventListener(MouseEvent.CLICK, onClearButtonClick);
            }
            else
            if (instance == textDisplay)
            {
                textDisplay.text = defaultText;
                textDisplay.addEventListener(TextOperationEvent.CHANGE, textDisplayChangeHandler);
                textDisplay.addEventListener(FocusEvent.FOCUS_IN, textDisplayFocusInHandler)
                textDisplay.addEventListener(FocusEvent.FOCUS_OUT, textDisplayFocusOutHandler)
            }
        }
        
        
        
        /* ===================================================================================== getCurrentSkinState ======= */
        
        
        
        override protected function getCurrentSkinState():String
        {
            var returnSkinState:String = "up";
            if (text == "")
            {
                returnSkinState = "empty";
            }
            return returnSkinState;
        }
        
        
        
        /* ===================================================================================== textDisplayFocusInHandler  */
        
        
        
        private function textDisplayFocusInHandler(event:FocusEvent):void
        {
            if (text == defaultText)
            {
                this.text = "";
                invalidateSkinState();
            }
        }
        
        
        
        /* ===================================================================================== textDisplayFocusOutHandler */
        
        
        
        private function textDisplayFocusOutHandler(event:FocusEvent):void
        {
            if (text == "")
            {
                this.text = defaultText;
                invalidateSkinState();
            }
        }
        
        
        
        /* ===================================================================================== onClearButtonClick ======== */
        
        
        
        private function onClearButtonClick(mouseEvent:MouseEvent):void
        {
            this.text = "";
            dispatchEvent(new Event("clearClicked"));
            invalidateSkinState();
        }
        
        
        
        /* ===================================================================================== textDisplayChangeHandler == */
        
        
        
        private function textDisplayChangeHandler(textOperationEvent:TextOperationEvent):void
        {
            invalidateSkinState();
        }
        
        
        
        /* ===================================================================================== defaultText =============== */
        
        
        
        private var _defaultText:String = "";
        public function get defaultText():String
        {
            return _defaultText;
        }
        public function set defaultText(value:String):void
        {
            if (_defaultText != value)
            {
                _defaultText = value;
            }
        }
        
    }
}