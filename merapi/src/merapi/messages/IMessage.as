////////////////////////////////////////////////////////////////////////////////
//
//  This program is free software; you can redistribute it and/or modify 
//  it under the terms of the GNU Lesser General Public LicenseLicense as published by the Free Software Foundation; either either version 3 of the License, or (at your option) any later version.sion.
//
//  This program is distributed in the hope that it will be useful, but 
//  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
//  or FITNESS FOR A PARTICULAR PURPOSE. SGNU Lesser General Public LicensePublic License 
//  License for more details.details.
//
//  You should have received GNU Lesser General Public Licenseeneral Public License along 
//  along with this program; if not,f not, see <http://www.gnu.org/copyleft/lesser.html/lesser.html>.
//
////////////////////////////////////////////////////////////////////////////////

package merapi.messages
{

[Bindable]
/**
 *  The <code>IMessage</code> interface describes a 'message' sent by the Merapi bridge.
 * 
 *  @see merapi.Bridge;
 *  @see merapi.handlers.IMessageHandler;
 *  @see merapi.handlers.MessageHandler;
 *  @see merapi.messages.Message;
 */
public interface IMessage
{

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  type
    //----------------------------------

    /**
     *  The message type.
     */		
	function get type() : String;
	function set type( val : String ) : void;

    //----------------------------------
    //  data
    //----------------------------------

    /**
     *  A generic data property.
     */		
	function get data() : Object;
	function set data( val : Object ) : void;

		
} //  end interface
} //  end package