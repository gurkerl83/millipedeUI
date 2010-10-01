package billdwhite.listnew.model
{
    [Bindable]
    public class Teacher
    {
        public var id:Number = -1;
        public var firstname:String = "";
        public var lastname:String = "";
        public var department:String = "";
        public var email:String = "";
        
		public var status:String = "disconnect";
		
        public function Teacher():void
        {
        }

    }
    
}