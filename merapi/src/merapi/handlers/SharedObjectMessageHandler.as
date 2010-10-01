package merapi.handlers
{
import flash.external.ExternalInterface;
import flash.net.SharedObject;

import merapi.Bridge;
import merapi.messages.DynamicMessage;
import merapi.messages.IMessage;
import merapi.messages.SharedObjectMessage;

public class SharedObjectMessageHandler extends MessageHandler
{
	public function SharedObjectMessageHandler()
	{
		super();
		
		addMessageType( SharedObjectMessage.METHOD_CALL );
	}
	
	override public function handleMessage( message : IMessage ) : void
	{
		switch( message.type )
		{
			case SharedObjectMessage.METHOD_CALL : 
				callMethod( message );
				break;	
		}
	}
	
	protected function callMethod( message : IMessage ) : void
	{
		var dynMess : DynamicMessage = message as DynamicMessage;
		
		var so : SharedObject = SharedObject.getLocal( dynMess.localName );
	
		if ( dynMess.methodName == SharedObjectMessage.GET_LOCAL )
		{
			dynMess.type = SharedObjectMessage.RESULT;
			dynMess.data = ( so.data.data != null ? so.data.data : {} );
			
			Bridge.getInstance().dispatchMessage( dynMess );
		}
		else
		{
			so.data.data = dynMess.data;
			so[ dynMess.methodName ]();
		}
	}
	
}
}