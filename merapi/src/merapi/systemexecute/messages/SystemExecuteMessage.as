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

package merapi.systemexecute.messages
{
import merapi.messages.Message;
	

[RemoteClass( alias="org.merapi.internal.systemexecute.messages.SystemExecuteMessage" )]
/**
 *  The <code>SystemExecuteMessage</code> class is a sub class of <code>Message</code> 
 *  that signals a system execute request from the UI layer.
 * 
 *  @see merapi.Bridge;
 *  @see merapi.messages.IMessage;
 *  @see merapi.messages.Message
 */
public class SystemExecuteMessage extends Message
{
    //--------------------------------------------------------------------------
    //
    //  Constants
    //
    //--------------------------------------------------------------------------

    /**
     *  The system execute message type.
     */
    public static const SYSTEM_EXECUTE : String = "systemExecute";
     
     		
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */		
	public function SystemExecuteMessage( args : Array = null ) : void
	{
		super();
		
		this.type    = SYSTEM_EXECUTE;
		this.data    = args;
	}
	
	
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  args
    //----------------------------------

    /**
     *  A set of args to use as the system execute parameters
     */		
	public function get args() : Array { return data as Array; }
	public function set args( val : Array ) : void { data = val; }

} //  end class
} //  end package