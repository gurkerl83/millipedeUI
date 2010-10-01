package merapi.io.utils
{
	import flash.system.System;
	import flash.utils.ByteArray;
	
	import merapi.error.MerapiErrorMessage;
	import merapi.io.reader.IReader;
	import merapi.messages.IMessage;
	
	public class MessageReader
		{
			
				private var __messageLengthReader:MessageLengthReader = new MessageLengthReader();
			
			// zmienna mowiaca o tym czy jestesmy wlasnie w trakcie pobierania nowej wiadomosci
			private var __newMessageFoundFlag:Boolean = false;
			
			// ostatnio odczytana wiadomosc ze strumienia
			private var __activeMessage:IMessage = null;
			
			private var __messageBody:ByteArray = null;
			
			public function get activeMessage():IMessage {
					return this.__activeMessage;
				}
			
			public function scan(client:ByteArray, readerImpl:IReader):Boolean {
					var result:Boolean = false;
					
					var bef:Number;
					var curr:Number;
					
					// sprawdzamy czy przypadkiem nie jestesmy w trakcie odczytywania
					// wykrytej wiadomosci
					if(!this.__newMessageFoundFlag) {
							
							// nie. Sprawdzamy warunki dla odczytania nowej wiadomosci
							// czy mozemy odczytac ze strumienia wejsciowego
							// rozmiar nastepnej wysylanej wiadomosci ?
							bef = System.totalMemory;
							if(__messageLengthReader.scan(client)) {
				
									this.__newMessageFoundFlag = true;	
								}
							curr = System.totalMemory;
							trace("mem diff 1: "+(curr-bef));
						}
					
					// no, to juz jestesmy w trakcie przetwarzania nowej wiadomosci
					if(this.__newMessageFoundFlag) {
							
							// zapamietujemy rozmiar (w bajtach) pobieranej wiadomosci
							var messageBodyLength:int = this.__messageLengthReader.activeMessageLength;
							
							// czy liczba danych w strumieniu pozwala na doczytanie calej wiadomosci
							if(client.bytesAvailable >= messageBodyLength) {
									
									// zwalniamy referencje i przygotowujemy sie do pobrania nowego obiektu 					
									this.__activeMessage = null;
									
									bef = System.totalMemory;
									/** tak, wiec ja odczytujemy */
									// Zerujemy tablice z bajtami ciala wiadomosci
									__messageBody = new ByteArray();
									
									// wczytujemy tylko tyle bajtow, z ilu sklada sie cialo wiadomosci				
									client.readBytes( __messageBody, 0, messageBodyLength );
									curr = System.totalMemory;
									trace("mem diff 2: "+(curr-bef));
				
									// zdejmujemy flage informujaca o przetwarzaniu nowej wiadomosci - przygotowujemy sie
									// do odebrania nowej
									this.__newMessageFoundFlag = false;
									
									// informujemy o sukcesie zwracajac <true>
									result = true;
									
									/** korzystajac z implementacji readera, przekazanej w parametrze wywolania funkcji
									 *  odczytujemy (i deserializujemy) wiadomosc wyslana z drugiego konca mostka
									**/
									try {
											bef = System.totalMemory;
											this.__activeMessage = readerImpl.read( __messageBody );
											curr = System.totalMemory;
											trace("mem diff 3: "+(curr-bef));
										} 
									
									// przechwytujemy bledy podczas deserializacji
									catch( e : Error )	{
							
												// w tym niemilym przypadku tez tworzymy wiadomosc, ktora bedzie przekazana
												// na barki frameworka, z tym ze ta informuje o bledzie wystepujacym wewnatrz maszynerii 
												this.__activeMessage = new MerapiErrorMessage( MerapiErrorMessage.DESERIALIZE_ERROR ); 
										}
									
								} 	
						}			
					
					return result;
				}
	
		}
}