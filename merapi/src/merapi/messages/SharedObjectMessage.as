package merapi.messages
{
	import flash.net.SharedObject;

	[RemoteClass(alias="org.millipede.gui.SharedObjectMessage")]
	public class SharedObjectMessage extends Message
	{
	public static const METHOD_CALL			: String = "methodCall";
	public static const RESULT				: String = "result";
	
	public static const GET_LOCAL 			: String = "getLocal";
	public static const CLEAR			 	: String = "clear";
	public static const CLOSE			 	: String = "close";
	public static const FLUSH			 	: String = "flush";

	public function SharedObjectMessage( type : String = null, methodName : String = null )
	{
		super( type );
	
		this.methodName = methodName;
	}
	
	public var methodName : String = null;
	
	public var localName : String = null;
	public var so : Object = null;

}
}