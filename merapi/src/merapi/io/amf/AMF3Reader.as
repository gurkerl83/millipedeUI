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

package merapi.io.amf
{
	
	import flash.utils.ByteArray;
	import merapi.io.reader.IReader;
	import merapi.messages.IMessage;
//	import merapi.messages.Message;

	/**
	 *  The <code>AMF3Reader</code> class deserializes AMF 3 encoded binary data into an
	 *  <code>IMessage</code>.
	 *
	 *  @see merapi.io.reader.IReader;
	 */
	public class AMF3Reader implements IReader
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
		public function AMF3Reader()
		{
			super();
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
		//    public function read( bytes : ByteArray ) : Array
		public function read( bytes : ByteArray ) : IMessage
		{
			//        var message : Object = bytes.readObject();
			//        var messages : Array = [];
			__message = null;
			
			//        while ( message != null )
			try
			{
				//            messages.push( message );
				//            try
				//            {
				//                message = bytes.readObject();
				//            }
				//            catch ( error : Error )
				//            {
				//                message = null;
				//                return messages;
				//            }
				__message = bytes.readObject();
				bytes = new ByteArray();
			}
			
			//        return messages;
			catch ( error : Error )
			{
				__message = null;
				return __message;
			}
			return __message;
		}
		
	} // end class
} // end package