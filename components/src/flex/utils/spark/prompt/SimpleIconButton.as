package flex.utils.spark.prompt {
	import flash.events.Event;

	import mx.core.FlexGlobals;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleManager2;

	import spark.components.Button;

	public class SimpleIconButton extends Button {

		private static const classConstructed:Boolean = classConstruct();

		private static function classConstruct():Boolean {
			var styleManager:IStyleManager2 = FlexGlobals.topLevelApplication.styleManager;
			if (!styleManager.getStyleDeclaration("flex.utils.spark.prompt.SimpleIconButton")) {
				var css:CSSStyleDeclaration = new CSSStyleDeclaration(null, styleManager);
				css.defaultFactory = function():void {
					this.skinClass = SimpleIconButtonSkin;
				}
				styleManager.setStyleDeclaration("flex.utils.spark.prompt.SimpleIconButton", css, true);
			}
			return true;
		}

		public function SimpleIconButton() {
			super();
		}

		private var _icon:Class;

		[Bindable("iconChanged")]
		public function get icon():Class {
			return _icon;
		}

		public function set icon(value:Class):void {
			if (value != _icon) {
				_icon = value;
				dispatchEvent(new Event("iconChanged"));
			}
		}

		private var _disabledIcon:Class;

		[Bindable("disabledIconChanged")]
		public function get disabledIcon():Class {
			return (_disabledIcon != null ? _disabledIcon : icon);
		}

		public function set disabledIcon(value:Class):void {
			if (value != _disabledIcon) {
				_disabledIcon = value;
				dispatchEvent(new Event("disabledIconChanged"));
			}
		}


	}
}