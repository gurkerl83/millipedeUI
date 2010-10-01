package billdwhite.listnew
{
    import com.greensock.TimelineMax;
    import com.greensock.TweenMax;
    import com.greensock.easing.Elastic;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import billdwhite.listnew.model.Teacher;
    import mx.binding.utils.BindingUtils;
    import mx.core.mx_internal;
    import mx.events.FlexEvent;
    import mx.events.FlexMouseEvent;
    import mx.managers.PopUpManager;
    import spark.components.Button;
    import spark.components.Group;
    import spark.components.Label;
    import spark.components.Panel;
    import spark.components.SkinnableContainer;
    import spark.components.supportClasses.SkinnableComponent;
    import spark.primitives.BitmapImage;
    
    [SkinState("normal")]
    [SkinState("over")]
    [SkinState("down")]
    
    public class ListTile__ 
    extends SkinnableComponent
    {
    
    
    
        /**
        * Constructor
        */
        public function ListTile__()
        {
            super();
            addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
            // TODO: Should I move rollover and rollout effects to skin?
            addEventListener(MouseEvent.ROLL_OUT, onRollOut);
            addEventListener(MouseEvent.ROLL_OVER, onRollOver);
        }
        
        
        
        /* ===================================================================================== skin parts ================ */

        
        
        [SkinPart(required="true")]
        public var nameLabel:Label;
        
        [SkinPart(required="true")]
        public var departmentLabel:Label;
        
        [SkinPart(required="true")]
        public var emailLabel:Label;
        
        [SkinPart(required="true")]
        public var cornerButton:Button;
        
        
        
        /* ===================================================================================== bindable variables ======== */

        
        
        [Bindable] public var tileLabel:String = "none";
        [Bindable] public var optionsSize:Number = 24;
        [Bindable] public var optionsWidth:Number = 124;
        
        
        
        /* ===================================================================================== member variables ========== */
        
        
        
        private var _timelineMax:TimelineMax = new TimelineMax();
        private var _optionsVisible:Boolean = false;
        private var _listTileOptions:ListTileOptions = null;
        private var _originalY:Number = 0;
        
        

        /* ===================================================================================== onCreationComplete ======= */

        
        
        private function onCreationComplete(event:Event=null):void
        {
            _listTileOptions = new ListTileOptions();
            _listTileOptions.width = optionsWidth; //200;
            _listTileOptions.height = optionsSize;
            _listTileOptions.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, popMouseDownOutsideHandler);
            _listTileOptions.addEventListener(FlexMouseEvent.MOUSE_WHEEL_OUTSIDE, popMouseDownOutsideHandler);
            _listTileOptions.addEventListener("close", onOptionsClose);
            _listTileOptions.addEventListener("edit", onOptionsEdit);
            _listTileOptions.addEventListener("delete", onOptionsDelete);
            skin.addEventListener(MouseEvent.CLICK, onClick);
        }
        
        
        
        /* ===================================================================================== partAdded ================= */

        
        
        override protected function partAdded(partName:String, instance:Object):void
        {
            super.partAdded(partName, instance);
            
            if (instance == nameLabel)
            {
                BindingUtils.bindSetter(function():void { nameLabel.text = teacher.firstname + ' ' + teacher.lastname; },
                                        teacher,
                                        "firstname");
                BindingUtils.bindSetter(function():void { nameLabel.text = teacher.firstname + ' ' + teacher.lastname; },
                                        teacher,
                                        "lastname");
                if (teacher)
                {
                    nameLabel.text = _teacher.firstname + ' ' + _teacher.lastname;
                }
            }
            else
            if (instance == departmentLabel)
            {
                BindingUtils.bindSetter(function():void { departmentLabel.text = teacher.department; }, teacher, "department");
                if (teacher)
                {
                    departmentLabel.text = _teacher.department;
                }
            }
            else
            if (instance == emailLabel)
            {
                BindingUtils.bindSetter(function():void { emailLabel.text = teacher.email; }, teacher, "email");
                if (teacher)
                {
                    emailLabel.text = _teacher.email;
                }
            }
            else
            if (instance == cornerButton)
            {
                cornerButton.addEventListener(MouseEvent.CLICK, onCornerButtonClick);
            }
        }
        
        
        
        /* ===================================================================================== getCurrentSkinState ======= */
        
        
        
        override protected function getCurrentSkinState():String
        {
            var returnSkinState:String = "normal";
            if (selected)
            {
                returnSkinState = "down";
            }
            return returnSkinState;
        }
        
        
        
        /* ===================================================================================== onCornerButtonClick ======= */

        
        
        private function onCornerButtonClick(mouseEvent:MouseEvent):void
        {
            if (_optionsVisible)
            {
                hideOptions();
            }
            else
            {
                showOptions();
            }
            this.callLater(onClick);
        }
        
        
        
        /* ===================================================================================== onClick =================== */

        
        
        private function onClick(mouseEvent:MouseEvent=null):void
        {
            if (!selected)
            {
                selected = true;
                dispatchEvent(new Event("tileSelected"));
            }
        }
        

        /* ===================================================================================== showOptions =============== */

        
        
        private function showOptions(event:Event=null):void
        {
            cornerButton.visible = false;
            var listTileOptionsPoint:Point = localToGlobal(new Point(cornerButton.x, cornerButton.y));
            _listTileOptions.x = listTileOptionsPoint.x;
            _listTileOptions.y = listTileOptionsPoint.y;
            _listTileOptions.width = width;
            _listTileOptions.height = optionsSize;
            PopUpManager.addPopUp(_listTileOptions, this, false);
            callLater(_listTileOptions.open, [showOptionsComplete]); // calllater fixes issue with the open animation getting missed on the first opening
        }
        
        

        /* ===================================================================================== showOptionsComplete ======= */

        
        
        private function showOptionsComplete(event:Event=null):void
        {
            _optionsVisible = true;
        }
        
        

        /* ===================================================================================== hideOptions =============== */

        
        
        private function hideOptions():void
        {
            _optionsVisible = false;
            _listTileOptions.close(hideOptionsComplete);
        }

        
        
        /* ===================================================================================== hideOptionsComplete ======= */

        
        
        public function hideOptionsComplete(event:Event=null):void
        {
            PopUpManager.removePopUp(_listTileOptions);
            cornerButton.visible = true;
        }
        
        

        /* ===================================================================================== onOptionsClose ============ */

        
        
        private function onOptionsClose(event:Event=null):void
        {
            hideOptions();
        }

        
        
        /* ===================================================================================== onOptionsView ============= */

        
        
        private function onOptionsView(event:Event):void
        {
            dispatchEvent(new Event("showTeacherView"));
            hideOptions();
        }
        
        

        /* ===================================================================================== onOptionsEdit ============= */

        
        
        private function onOptionsEdit(event:Event):void
        {
            dispatchEvent(new Event("showTeacherEdit"));
            hideOptions();
        }
        
        

        /* ===================================================================================== onOptionsDelete =========== */

        
        
        private function onOptionsDelete(event:Event):void
        {
            dispatchEvent(new Event("showTeacherDelete"));
            hideOptions();
        }

        
        
        /* ===================================================================================== popMouseDownOutsideHandler =*/

        
        
        private function popMouseDownOutsideHandler(event:MouseEvent):void
        {
            var p:Point = event.target.localToGlobal(new Point(event.localX, event.localY));
            if (!(hitTestPoint(p.x, p.y, true)))
            {
                hideOptions();
            }
        }
        
        

        /* ===================================================================================== onRollOver ================ */

        
        
        private function onRollOver(event:MouseEvent):void
        {
            if (!selected && !animating)
            {
                TweenMax.to(this, .1, {z:3});
            }
        }
        
        

        /* ===================================================================================== onRollOut ================= */

        
        
        private function onRollOut(event:MouseEvent):void
        {
            if (!selected && !animating)
            {
                TweenMax.to(this, .1, {z:0, onComplete:function(param1:ListTile):void { param1.transform.matrix3D = null; }, onCompleteParams:[this]} );
            }
        }
        
        

        /* ===================================================================================== selected ================== */
        
        
        
        private var _selected:Boolean = false;
        [Bindable]
        public function get selected():Boolean
        {
            return _selected;
        }
        public function set selected(selectedArg:Boolean):void
        {
            if (_selected != selectedArg)
            {
                _selected = selectedArg;
                
                if (_selected)
                {
                    z = 0;
                }
                invalidateSkinState();
            }
        }
        
        
        
        /* ===================================================================================== animating ================= */
        
        
        
        private var _animating:Boolean = false;
        public function get animating():Boolean
        {
            return _animating;
        }
        public function set animating(value:Boolean):void
        {
            if (_animating != value)
            {
                _animating = value;
            }
        }
            

    
    
        /* ===================================================================================== teacher =================== */

        private function updateFields():void
        {
            trace("updateFields");
            if (teacher)
            {
                if (nameLabel)
                {
                    nameLabel.text = _teacher.firstname + ' ' + _teacher.lastname;
                }
                
                if (departmentLabel)
                {
                    departmentLabel.text = _teacher.department;
                }
                
                if (emailLabel)
                {
                    emailLabel.text = _teacher.email;
                }
            }
        }
        
        
        private var _teacher:Teacher;
        [Bindable]
        public function get teacher():Teacher
        {
            return _teacher;
        }
        public function set teacher(teacherArg:Teacher):void
        {
            if (_teacher != teacherArg)
            {
                _teacher = teacherArg;
                updateFields();
            }
        }        
    }
}