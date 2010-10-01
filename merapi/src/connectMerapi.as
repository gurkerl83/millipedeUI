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
import merapi.Bridge;

/**
 *  Connects the Merapi client/ui Bridge to the native Bridge.
 */
public function connectMerapi( port : int = -1, host : String = null ) : void
{
	if ( port == 0 ) port = -1;
	Bridge.connect( port, host );
} //  end top level function
} //  end package