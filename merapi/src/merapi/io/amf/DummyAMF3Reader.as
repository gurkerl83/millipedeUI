////////////////////////////////////////////////////////////////////////////////
//
//  This program is free software; you can redistribute it and/or modify 
//  it under the terms of the GNU General Public License as published by the 
//  Free Software Foundation; either version 3 of the License, or (at your 
//  option) any later version.
//
//  This program is distributed in the hope that it will be useful, but 
//  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
//  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License 
//  for more details.
//
//  You should have received a copy of the GNU General Public License along 
//  with this program; if not, see <http://www.gnu.org/licenses>.
//
////////////////////////////////////////////////////////////////////////////////

package merapi.io.amf
{

	import flash.utils.ByteArray;

import merapi.io.reader.IReader;
import merapi.messages.IMessage;
import merapi.messages.Message;


/**
 *  The <code>AMF3Reader</code> class deserializes AMF 3 encoded binary data into an 
 *  <code>IMessage</code>. 
 * 
 *  @see merapi.io.reader.IReader;
 */
public class DummyAMF3Reader implements IReader
	{
	   
		   private var __message:IMessage;
	    //--------------------------------------------------------------------------
	    //
	    //  Constructor
	    //
	    //--------------------------------------------------------------------------
	
	    /**
	     *  Constructor.
	     */		
		public function DummyAMF3Reader()
		{
				super();
				__message = new Message();
			}
		
	
		//--------------------------------------------------------------------------
	    //
	    //  Methods
	    //
	    //--------------------------------------------------------------------------
	
	    /**
	     *  Reads binary data serialized using the as AMF 3 protocol and deserializes 
	     *  it into a set of <code>IMessage</code> instances.
	     */		
		public function read( bytes : ByteArray ) : IMessage
		{
				bytes = null;
				return this.__message;
				
			}
	
	} // end class
} // end package