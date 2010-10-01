////////////////////////////////////////////////////////////////////////////////////
//
//  This program is free software; you can redistribute it and/or modify 
//  it under the terms of the GNU Lesser General Public License as published 
//  by the Free Software Foundation; either version 3 of the License, or (at 
//  your option) any later version.
//
//  This program is distributed in the hope that it will be useful, but 
//  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
//  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public 
//  License for more details.
//
//  You should have received a copy of the GNU Lesser General Public License 
//  along with this program; if not, see <http://www.gnu.org/copyleft/lesser.html>.
//
////////////////////////////////////////////////////////////////////////////////////

package merapi
{
import flash.external.ExternalInterface;
import flash.system.Security;

import merapi.handlers.MessageHandler;
import merapi.messages.DynamicMessage;
import merapi.messages.IMessage;
	

/**
 *  The <code>Message</code> class implements IMessage, a 'message' sent from the Merapi 
 *  UI layer.
 * 
 *  @see merapi.Bridge;
 *  @see merapi.handlers.IMessageHandler;
 *  @see merapi.messages.IMessage;
 */
public class JavaScriptExtension extends MessageHandler
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */		
	public function JavaScriptExtension()
	{
		Security.loadPolicyFile( 'xmlsocket://' + Bridge.HOST + ':12344' );
		
		Bridge.getInstance();
		
		ExternalInterface.addCallback( "registerMessageHandler", registerMessageHandler );
		ExternalInterface.addCallback( "unRegisterMessageHandler", unRegisterMessageHandler );
		ExternalInterface.addCallback( "sendMessage", sendMessage );
		ExternalInterface.addCallback( "dispatchMessage", dispatchMessage );
		ExternalInterface.addCallback( "connectMerapi", connectMerapi );
		ExternalInterface.addCallback( "disconnectMerapi", disconnectMerapi );
		ExternalInterface.addCallback( "systemExecute", systemExecute );

		__handler = new JavaScriptHandler();
	}
	
	private function alert( o : Object ) : void
	{
		ExternalInterface.call( "alert", o );
	}

		
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------
    
    public function registerMessageHandler( type : * ) : void
    {
    	__handler.removeMessageType( type );
    	__handler.addMessageType( type );
    }
    
    public function unRegisterMessageHandler( type : * ) : void
    {
    	__handler.removeMessageType( type );
    }
    
    public function sendMessage( message : * ) : void
    {
    	var m : DynamicMessage = new DynamicMessage();
    	
    	for ( var propName : String in message )
    	{
    		if ( !( m[ propName ] is Function ) )
    		{
    			m[ propName ] = message[ propName ];
    		}
    	}
    	
    	m.send();
    }
    
    public function dispatchMessage( message : * ) : void
    {
    	var m : DynamicMessage = new DynamicMessage();
    	
    	for ( var propName : String in message )
    	{
    		if ( !( m[ propName ] is Function ) )
    		{
    			m[ propName ] = message[ propName ];
    		}
    	}
    	
    	Bridge.getInstance().dispatchMessage( m );
    }
    
    protected var __handler : JavaScriptHandler = null;
    
} //  end class
} //  end package

import merapi.handlers.MessageHandler;
import merapi.messages.IMessage;
import flash.external.ExternalInterface;

class JavaScriptHandler extends MessageHandler
{
	override public function handleMessage( message : IMessage ) : void
	{
		ExternalInterface.call( "handleMerapiMessage", message );
	}
}
