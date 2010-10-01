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

package merapi.handlers
{

import merapi.messages.IMessage;

/**
 *  The <code>IMessageHandler</code> interface defines the methods for receiving a 
 *  <code>Message</code> from the Bridge.
 * 
 *  @see merapi.Bridge
 *  @see merapi.handlers.MessageHandler
 *  @see merapi.messages.IMessage
 *  @see merapi.messages.Message
 */
public interface IMessageHandler 
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------
	
	/**
	 *  Handles an <code>IMessage</code> dispatched from the Bridge.
	 */
	function handleMessage( message : IMessage ) : void;
	
	}
}