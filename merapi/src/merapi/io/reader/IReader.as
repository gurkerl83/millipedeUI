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

package merapi.io.reader
{

import flash.utils.ByteArray;
import merapi.messages.IMessage;


/**
 *  The <code>IReader</code> interface describes a class for reading binary data from the Merapi
 *  bridge.
 * 
 *  @see merapi.Bridge
 *  @see merapi.io.AMF3Reader
 *  @see merapi.messages.IMessage
 */
public interface IReader
{

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Deserializes the binary data <code>bytes</code> and returns a the data as a
     *  set of <code>IMessage</code> instances.
     */	
//	function read( bytes : ByteArray ) : Array;
	function read( bytes : ByteArray ) : IMessage;

} // end interface
} // end package
