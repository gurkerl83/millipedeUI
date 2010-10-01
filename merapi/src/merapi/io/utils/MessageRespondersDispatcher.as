package merapi.io.utils
{
	import flash.utils.Dictionary;
	
	import merapi.Bridge;
	import merapi.messages.IMessage;
	
	import mx.rpc.IResponder;
	
	public class MessageRespondersDispatcher
		{
			
				public function dispatch(message:IMessage, respondersMap:Dictionary):void {
			
						try 
				    		{
					    			//  Check in __respondersMaps to see if an IResponder has been
						    			//  registered for this message. (Mapped by Message.uid.) Notify
						    			//  the IResponder by invoking the result method. 
						        		if ( respondersMap[ message[ Bridge.UID ] ] != null )
							        		{
								        			var responder : IResponder = 
									        				respondersMap[ message[ Bridge.UID ] ] as IResponder
									        		
									        			responder.result( message );
								        			
								    				respondersMap[ message[ Bridge.UID ] ] = null;
								        		}
						        	}
					        	catch ( error : Error ) {}
					}
		
			}
}