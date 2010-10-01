package be.aboutme.flashDragDrop
{
	import com.dynamicflash.util.Base64;
	
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.utils.ByteArray;

	/*
	This class enables you to integrate HTML5 drag and drop functionality
	into your flash applications.
	
	Parts of the actionscript and source code are inspired by Mario Klingemanns
	demo on: http://code.google.com/p/quasimondolibs/source/browse/trunk/examples/FFDragAndDrop/FFDragAndDrop.as
	Author: Mario Klingemann
	http://www.quasimondo.com
	
	This Javascript part of the code is based in big parts on the example 
	by Paul Rouget on this page:
	http://hacks.mozilla.org/2009/12/file-drag-and-drop-in-firefox-3-6/
	
	The Base64 javascript code is based on the code found on webtoolkit.info:
	http://www.webtoolkit.info/javascript-base64.html 
	
	released under MIT License (X11)
	http://www.opensource.org/licenses/mit-license.php
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
	*/

    [Event(name='dragEnter', type='be.aboutme.flashDragDrop.FlashDragDropEvent')]
    [Event(name='dragLeave', type='be.aboutme.flashDragDrop.FlashDragDropEvent')]
    [Event(name='dragOver', type='be.aboutme.flashDragDrop.FlashDragDropEvent')]
    [Event(name='dropData', type='be.aboutme.flashDragDrop.FlashDragDropEvent')]
    [Event(name='dropFile', type='be.aboutme.flashDragDrop.FlashDragDropEvent')]
    
    /**
    * FlashDragDrop class
    * 
    * To detect drag and drop events, add event listeners to this class:
    * 
    * <code>FlashDragDrop.addEventListener(FlashDragDropEvent.DRAG_ENTER, dragEnterHandler);</code>
    * 
    * The data property of the FlashDragDropEvent contains info about the drag / drop action
    * When a file is dropped, the data property will be an instance of DroppedFile.
    * Use the content property to access the file's content. In case of an image, this will be
    * a ByteArray containing the bytes of the the image file that was dropped on the swf.
    */
	public class FlashDragDrop
	{
		
		private static var FUNCTION_ADDEVENT:String = 
			"document.insertScript = function ()" +
        	"{ " +
                "if (document.addEvent==null)" + 
                "{" + 
                    "addEvent = function (el, type, fn)" +
                	"{" + 
                		"if (document.addEventListener) {" + 
                			"if (el && el.nodeName || el === window) {" + 
                				"el.addEventListener(type, fn, false);" + 
                			"} else if (el && el.length) {" + 
                				"for (var i = 0; i < el.length; i++) {" + 
                					"addEvent(el[i], type, fn);" + 
                				"}" + 
                			"}" + 
                		"} else {" + 
                			"if (el && el.nodeName || el === window) {" + 
                				"el.attachEvent('on' + type, function () { return fn.call(el, window.event); });" + 
                			"} else if (el && el.length) {" + 
                				"for (var i = 0; i < el.length; i++) {" + 
                					"addEvent(el[i], type, fn);" + 
                				"}" + 
                			"}" + 
                		"}" + 
                    "}" +
                "}" +
            "}";
            
		private static var FUNCTION_INIT_DRAG_AND_DROP:String = 
            "document.insertScript = function ()" +
        	"{ " +
                "if (document.initDragAndDrop==null)" + 
                "{" + 
                    "initDragAndDrop = function (id)" +
                	"{" + 
                		"document.dropArea = document.getElementById(id);" + 
                		"addEvent(document.dropArea, 'dragenter', dragEnterHandler);" + 
                		"addEvent(document.dropArea, 'dragleave', dragLeaveHandler);" + 
                		"addEvent(document.dropArea, 'dragover', dragOverHandler);" + 
                		"addEvent(document.dropArea, 'drop', dropHandler);" + 
                    "}" +
                "}" +
            "}";
		
		private static var FUNCTION_DROP_HANDLER:String = 
            "document.insertScript = function ()" +
        	"{ " +
                "if (document.dropHandler==null)" + 
                "{" + 
                    "dropHandler = function (e)" +
                	"{" + 
                		"if(e.preventDefault) e.preventDefault();" + 
                		"if(e.dataTransfer.files) {" + 
                			"var hasUnhandledFiles = false;" + 
                			"for (var i = 0; i < e.dataTransfer.files.length; i++) {" + 
                				"var f = e.dataTransfer.files[i];" + 
                				"if(!handleFile(f) && f.fileName && f.fileSize) {" + 
                					"hasUnhandledFiles = true;" +   
                				"}" + 
                			"}" + 
                			"if(hasUnhandledFiles) {" +  
                				"document.dropArea.onDropData(packageData(e.dataTransfer));" + 
                			"}" + 
                		"} else {" + 
                			"document.dropArea.onDropData(packageData(e.dataTransfer));" +
                		"}" + 
                		"return false;" + 
                    "}" +
                "}" +
            "}";
		
		private static var FUNCTION_DRAG_ENTER_HANDLER:String = 
            "document.insertScript = function ()" +
        	"{ " +
                "if (document.dragEnterHandler==null)" + 
                "{" + 
                    "dragEnterHandler = function (e)" +
                	"{" + 
                		"if(e.preventDefault) e.preventDefault();" + 
                		"document.dropArea.onDragEnter(packageData(e.dataTransfer));" +
                		"return false;" + 
                    "}" +
                "}" +
            "}";
		
		private static var FUNCTION_DRAG_OVER_HANDLER:String = 
            "document.insertScript = function ()" +
        	"{ " +
                "if (document.dragOverHandler==null)" + 
                "{" + 
                    "dragOverHandler = function (e)" +
                	"{" + 
                		"if(e.preventDefault) e.preventDefault();" + 
                		"document.dropArea.onDragOver(packageData(e.dataTransfer));" +
                		"return false;" + 
                    "}" +
                "}" +
            "}";

		private static var FUNCTION_DRAG_LEAVE_HANDLER:String = 
            "document.insertScript = function ()" +
        	"{ " +
                "if (document.dragLeaveHandler==null)" + 
                "{" + 
                    "dragLeaveHandler = function (e)" +
                	"{" + 
                		"if(e.preventDefault) e.preventDefault();" + 
                		"document.dropArea.onDragLeave(packageData(e.dataTransfer));" + 
                		"return false;" + 
                    "}" +
                "}" +
            "}";
            
        private static var FUNCTION_PACKAGE_DATA:String = 
            "document.insertScript = function ()" +
        	"{ " +
                "if (document.packageData==null)" + 
                "{" + 
                    "packageData = function (dt)" +
                	"{" + 
                		"var data = {};" + 
                		"if(dt.types) {" + 
                			"for (var i = 0; i < dt.types.length; i++){" + 
                				"data[dt.types[i]] = {'content':'','encoding':'plain'};" +  
                				"try {" +  
	                				"data[dt.types[i]].content = Base64.encode(dt.getData(dt.types[i]));" + 
	                				"data[dt.types[i]].encoding = 'base64';" + 
	                			"} catch (e) {" +   
	                			"}" + 
                			"}" + 
                		"} else {" + 
                			"var text = dt.getData('Text');" + 
                			"if(text) data['text'] = {'content':Base64.encode(dt.getData('Text')),'encoding':'base64'};" + 
                			"else data['text'] = {'content':'','encoding':'plain'};" +
                		"}" + 
                		"return data;" + 
                    "}" +
                "}" +
            "}";
		private static var FUNCTION_HANDLE_FILE:String = 
            "document.insertScript = function ()" +
        	"{ " +
                "if (document.handleFile==null)" + 
                "{" + 
                    "handleFile = function (file)" +
                	"{" + 
                		"if(file.type) {" + 
	                		"var reader = new FileReader();" +  
	                		"reader.onloadend = function() {" + 
	                			"document.dropArea.onDropFile(file.type, Base64.encode(reader.result));" + 
	                		"};" + 
	                		"reader.readAsBinaryString(file);" + 
                		"} else {" +  
                			"return false;" + 
                		"}" + 
                		"return true;" +
                    "}" +
                "}" +
            "}";
            
		/**
		*
		*  Base64 encode / decode
		*  http://www.webtoolkit.info/
		*
		**/
		private static var FUNCTION_BASE64:String = 
			"document.insertScript = function ()" +
        	"{ " +
                "if (document.Base64==null)" + 
                "{" + 
                    "Base64 = {" + 
                    	"_keyStr : \"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=\"," + 
                    	"encode : function (input) {" + 
                    		"var output = \"\";" + 
                    		"var chr1, chr2, chr3, enc1, enc2, enc3, enc4;" + 
                    		"var i = 0;" + 
                    		"input = Base64._utf8_encode(input);" + 
                    		"while (i < input.length) {" + 
                    			"chr1 = input.charCodeAt(i++);" + 
                    			"chr2 = input.charCodeAt(i++);" + 
                    			"chr3 = input.charCodeAt(i++);" + 
                    			"enc1 = chr1 >> 2;" + 
                    			"enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);" + 
                    			"enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);" + 
                    			"enc4 = chr3 & 63;" + 
                    			"if (isNaN(chr2)) {" + 
                    				"enc3 = enc4 = 64;" + 
                    			"} else if (isNaN(chr3)) {" + 
                    				"enc4 = 64;" + 
                    			"}" + 
                    			"output = output + this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) + this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);" + 
                    		"}" + 
                    		"return output;" + 
                    	"}," + 
                    	"_utf8_encode : function (string) {" + 
                    		"string = string.replace(/\\r\\n/g,\"\\n\");" + 
                    		"var utftext = \"\";" + 
                    		"for (var n = 0; n < string.length; n++) {" + 
                    			"var c = string.charCodeAt(n);" + 
                    			"if (c < 128) {" + 
                    				"utftext += String.fromCharCode(c);" + 
                    			"} else if((c > 127) && (c < 2048)) {" + 
                    				"utftext += String.fromCharCode((c >> 6) | 192);" + 
                    				"utftext += String.fromCharCode((c & 63) | 128);" + 
                    			"} else {" + 
                    				"utftext += String.fromCharCode((c >> 12) | 224);" + 
                    				"utftext += String.fromCharCode(((c >> 6) & 63) | 128);" + 
                    				"utftext += String.fromCharCode((c & 63) | 128);" + 
                    			"}" + 
                    		"}" + 
                    		"return utftext;" + 
                    	"}," +  
                    "};" + 
                "}" +
            "}";
            
		private static var initializer:Boolean = initialize();
		private static var dispatcher:EventDispatcher = new EventDispatcher();
		
		public function FlashDragDrop(e:Enforcer)
		{
			throw new IllegalOperationError('FlashDragDrop cannot be instantiated.');
		}
		
		private static function initialize():Boolean {
			ExternalInterface.call(FUNCTION_ADDEVENT);
			ExternalInterface.call(FUNCTION_INIT_DRAG_AND_DROP);
			ExternalInterface.call(FUNCTION_DROP_HANDLER);
			ExternalInterface.call(FUNCTION_DRAG_ENTER_HANDLER);
			ExternalInterface.call(FUNCTION_DRAG_LEAVE_HANDLER);
			ExternalInterface.call(FUNCTION_DRAG_OVER_HANDLER);
			ExternalInterface.call(FUNCTION_PACKAGE_DATA);
			ExternalInterface.call(FUNCTION_BASE64);
			ExternalInterface.call(FUNCTION_HANDLE_FILE);
			
			ExternalInterface.call("initDragAndDrop", ExternalInterface.objectID);
			ExternalInterface.addCallback("onDragEnter", dragEnterHandler);
			ExternalInterface.addCallback("onDragLeave", dragLeaveHandler);
			ExternalInterface.addCallback("onDragOver", dragOverHandler);
			ExternalInterface.addCallback("onDropData", dropDataHandler);
			ExternalInterface.addCallback("onDropFile", dropFileHandler);
			
			return true;
		}
		
		private static function dragEnterHandler(data:Object):void
		{
			dispatchEvent(new FlashDragDropEvent(FlashDragDropEvent.DRAG_ENTER, decodeData(data)));
		}
		
		private static function dragLeaveHandler(data:Object):void
		{
			dispatchEvent(new FlashDragDropEvent(FlashDragDropEvent.DRAG_LEAVE, decodeData(data)));
		}
		
		private static function dragOverHandler(data:Object):void
		{
			dispatchEvent(new FlashDragDropEvent(FlashDragDropEvent.DRAG_OVER, decodeData(data)));
		}
		
		private static function dropDataHandler(data:Object):void
		{
			dispatchEvent(new FlashDragDropEvent(FlashDragDropEvent.DROP_DATA, decodeData(data)));
		}
		
		private static function decodeData(data:Object):Object
		{
			var decoded:Object = {};
			for(var key:String in data) {
				decoded[key] = data[key].content;
				switch(data[key].encoding)
				{
					case 'base64':
						decoded[key] = Base64.decode(data[key].content);
						break;
				}
			}
			return decoded;
		}
		
		private static function dropFileHandler(type:String, content:String):void
		{
			var byteString:String = Base64.decodeToByteArray(content).toString();
			var file:DroppedFile = new DroppedFile(type, byteString);
			switch(type)
			{
				case "application/x-shockwave-flash":
				case "image/jpeg":
				case "image/png":
				case "image/gif":
					var ba:ByteArray = new ByteArray();
					for(var i:uint = 0; i < byteString.length; i++) {
						ba.writeByte(byteString.charCodeAt(i));
					}
					file.content = ba;
					break;
				default:
					break;
			}
			dispatchEvent(new FlashDragDropEvent(FlashDragDropEvent.DROP_FILE, file));
		}
		
		/**
         * Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event. 
         * You can register event listeners on all nodes in the display list for a specific type of event, phase, and priority.
         * @param type The type of event.
         * @param listener The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing.
         * @param useCapture Determines whether the listener works in the capture phase or the target and bubbling phases.
         * @param priority The priority level of the event listener.
         * @param useWeakReference Determines whether the reference to the listener is strong or weak.
         * @throws ArgumentError The listener specified is not a function. 
         */
        public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, 
            useWeakReference:Boolean = false):void {
            dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }

        /**
         * Removes a listener from the EventDispatcher object. If there is no matching listener registered with the EventDispatcher object, a call to this method has no effect.
         * @param type The type of event. 
         * @param listener The listener object to remove.
         * @param useCapture Specifies whether the listener was registered for the capture phase or the target and bubbling phases. 
         * If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, 
         * one call with useCapture() set to true, and another call with useCapture() set to false. 
         */
        public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
            dispatcher.removeEventListener(type, listener, useCapture);
        }

        /**
         * Dispatches an event to all the registered listeners. 
         * @param event Event object.
         * @return A value of <code>true</code> if a listener of the specified type is registered; <code>false</code> otherwise.
         * @throws Error The event dispatch recursion limit has been reached. 
         */
        public static function dispatchEvent(event:Event):Boolean {
            return dispatcher.dispatchEvent(event);
        }

        /**
         * Checks whether the EventDispatcher object has any listeners registered for a specific type of event. This allows you to determine where an EventDispatcher object has 
         * altered handling of an event type in the event flow hierarchy.
         * @param event The type of event.  
         * @return A value of <code>true</code> if a listener of the specified type is registered; <code>false</code> otherwise. 
         */
        public static function hasEventListener(type:String):Boolean {
            return dispatcher.hasEventListener(type);
        }
		
	}
}
internal class Enforcer{};