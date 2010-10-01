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

package merapi.messages
{

import flash.net.registerClassAlias;

import merapi.Bridge;

import mx.rpc.IResponder;
import mx.utils.UIDUtil;
	

/**
 *  The <code>Message</code> class implements IMessage, a 'message' sent from the Merapi 
 *  UI layer.
 * 
 *  @see merapi.Bridge;
 *  @see merapi.handlers.IMessageHandler;
 *  @see merapi.messages.IMessage;
 */
[RemoteClass( alias="org.merapi.messages.Message" )]
public class Message implements IMessage
{
	//  Needed for sending typed instances from Flash -> Java as Flash doesn't parse 
	//  the RemoteClass meta tag
//	{ registerClassAlias( "org.merapi.messages.Message", Message ); }
	
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */		
	public function Message( type : String = null, data : Object = null ) : void
	{
		super();
		
		this.type   = type;
		this.data   = data;
		this.uid	= UIDUtil.createUID();
	}
	
	
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  uid
    //----------------------------------

    /**
     *  A unique ID for the message.
     */		
	public var uid	 				: String			= null;

    //----------------------------------
    //  type
    //----------------------------------

    /**
     *  The type of the message.
     */		
//	public function get type() 		: String 			{ return __type };
//	public function set type( val 	: String ) : void 	{ __type = val; };

    //----------------------------------
    //  data
    //----------------------------------

    /**
     *  The data carried by this message.
     */		
//	public function get data() 		: Object 			{ return __data };
//	public function set data( val 	: Object ) : void 	{ __data = val };
	

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------
	
	/**
	 *  Redirects toString to the data property
	 */
	public function toString() : String
	{
		return uid + " " + (data != null ? data.toString() : "" ); 
	}
	
	/**
	 *  Sends the event across the Merapi bridge.
	 */
	public function send( responder : IResponder = null ) : void
	{
		Bridge.getInstance().sendMessage( this, responder );
	}
	
	/**
	 *  Dispatchs message across on this side of the bridge.
	 */
	public function dispatch() : void 
	{
		Bridge.getInstance().dispatchMessage( this );
	}


    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

//	private var __type		 		: String			= null;
//	private var __data 				: Object			= null;
	
	private var _type		 		: String			= null;

	/**
	 *  Used by the getters/setters.
	 */
	public function get type():String
	{
		return _type;
	}

	/**
	 * @private
	 */
	public function set type(value:String):void
	{
		_type = value;
	}

	private var _data 				: Object			= null;

	public function get data():Object
	{
		return _data;
	}

	public function set data(value:Object):void
	{
		_data = value;
	}
	
		
} //  end class
} //  end package