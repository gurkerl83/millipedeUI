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

package merapi.io.amf
{

import flash.utils.ByteArray;

import merapi.io.writer.IWriter;
import merapi.messages.IMessage;



/**
 *  The <code>AMF3Reader</code> class serializes an IMessage into AMF 3 encoded  
 *  binary data.  
 * 
 *  @see merapi.io.reader.IWriter;
 */
public class AMF3Writer implements IWriter
{
   
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */		
	public function AMF3Writer()
	{
		super();
	}
	

	//--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Serializes <code>message</code> using <code>flash.utils.ByteArray</code> and
     *  returns the binary data.
     */		
	public function write( message : IMessage ) : ByteArray
	{
		var bytes : ByteArray = new ByteArray();
		bytes.writeObject( message );
		
		return bytes;
	}

} // end class
} // end package
