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

package
{
import merapi.systemexecute.messages.SystemExecuteMessage;

/**
 *  Performs a systemExecute by creating a SystemExecutMessage and sending it to the
 *  native Merapi Bridge.
 */
public function systemExecute( args : Array ) : void
{
	var sem : SystemExecuteMessage 	= new SystemExecuteMessage();
		sem.args 					= args;
		sem.send();
} //  end top level function
} //  end package