package flex.utils.spark.prompt {
	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.core.FlexGlobals;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleManager2;

	import spark.components.Button;
	import spark.components.Label;
	import spark.components.TextInput;
	import spark.events.TextOperationEvent;

	/** Style name for the prompt label. */
	[Style(name="promptStyleName", type="String")]

	public class PromptingTextInput extends TextInput {

		private static const classConstructed:Boolean = classConstruct();

		private static function classConstruct():Boolean {
			var styleManager:IStyleManager2 = FlexGlobals.topLevelApplication.styleManager;
			if (!styleManager.getStyleDeclaration("flex.utils.spark.prompt.PromptingTextInput")) {
				var css:CSSStyleDeclaration = new CSSStyleDeclaration(null, styleManager);
				css.defaultFactory = function():void {
					this.skinClass = PromptingTextInputSkin;
				}
				styleManager.setStyleDeclaration("flex.utils.spark.prompt.PromptingTextInput", css, true);
			}
			return true;
		}

		[SkinPart(required="false")]
		[Inspectable(environment="none")]
		public var promptLabel:Label;

		private var _prompt:String;

		public function PromptingTextInput() {
			super();
		}

		[Inspectable(category="Common", defaultValue="")]
		[Bindable("promptChanged")]
		public function set prompt(value:String):void {
			if (value != _prompt) {
				_prompt = value;
				if (promptLabel) {
					promptLabel.text = value;
				}
				dispatchEvent(new Event("promptChanged"));
			}
		}

		public function get prompt():String {
			return _prompt;
		}

		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			if (instance == promptLabel) {
				promptLabel.text = prompt;
			}
		}

		[Bindable("change")]
		[Bindable("textChanged")]
		[CollapseWhiteSpace]
		override public function get text():String {
			return super.text;
		}

		override public function set text(value:String):void {
			if (value != super.text) {
				super.text = value;
				// fire a change event on the textDisplay to update the prompt label visibility
				if (textDisplay) {
					textDisplay.dispatchEvent(new TextOperationEvent(TextOperationEvent.CHANGE));
				}
			}
		}

	}
}