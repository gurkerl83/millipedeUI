package merapi.connect
{
	import merapi.messages.Message;

	public class ConnectMessage extends Message
	{
		public static const CONNECT_SUCCESS : String = "connectSuccess";
		
		public function ConnectMessage( type : String )
		{
			super( type );
		}
		
	}
}