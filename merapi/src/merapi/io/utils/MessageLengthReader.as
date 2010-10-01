package merapi.io.utils
{
	
	import flash.utils.ByteArray;
	
	/**
	 * Klasa sprawdzajaca czy w strumieniu danych gniazdka
	 * nie znajduje sie opis nowej wiadomosci przekazanej
	 * z drugiego konca mostku
	 *  
	 * @author Grzegorz Nowak
	 * 
	 */
	public class MessageLengthReader
	{
		
		// dlugosc obiektu opisujacego cala wiadomosc
		private var __activeMessageLength:int = 0;
		
		public function scan(client:ByteArray):Boolean {
			
			var result:Boolean = false;
			
			// czy mamy liczbe int w strumieniu ? (int w AS3 rezyduje na 4 bajtach)
			if(client.bytesAvailable >= 4) {
				this.__activeMessageLength = client.readInt();
				
				result = true;	
			}	
			
			return result;
		}
		
		public function get activeMessageLength():int {
			return this.__activeMessageLength;
		}
		
	}
}