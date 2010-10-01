package com.hulstkamp.flex.spark.components
{
	import com.hulstkamp.flex.spark.skins.NiceToolTipSkin;
	
	import mx.core.FlexGlobals;
	import mx.core.IDataRenderer;
	import mx.core.IFactory;
	import mx.core.IToolTip;
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	import mx.styles.CSSStyleDeclaration;
	
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.RichText;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.skins.SparkSkin;
	import spark.utils.TextFlowUtil;
	
	/**
	 * Custom Tooltip component for styleable Tooltips with an optional title and text
	 * View is defined in associated Skin
	 * @author andy andreas hulstkamp. www.hulstkamp.com
	 * 
	 */
	public class NiceToolTip extends SkinnableComponent implements IToolTip
	{
		//static initialization of default style values
		private static var defaultStyleValuesInited:Boolean = classConstruct();
		
		//If no styles are defined for this component, apply default ones
		private static function classConstruct():Boolean {
			if (!FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration("com.hulstkamp.flex.spark.components.NiceToolTip"))
			{
				var niceToolTipStyles:CSSStyleDeclaration = new CSSStyleDeclaration();
				niceToolTipStyles.defaultFactory = function():void
				{	
					this.color = 0x303030;
					this.chromeColor = 0x90d000;
					this.fontSize = 11;
				}
				FlexGlobals.topLevelApplication.styleManager.setStyleDeclaration("com.hulstkamp.flex.spark.components.NiceToolTip", niceToolTipStyles, true);
			}
			return true;
		}

		
		public function NiceToolTip()
		{
			super();
			mouseEnabled = false;
			this.mouseChildren = false;
			maxWidth = 300;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Skin parts 
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 * Factory of the dynamic skin part for a title 
		 */
		[SkinPart(required="false", type="spark.components.Label")]
		public var displayTitle:IFactory;
		
		/**
		 * Instance of the title part if any 
		 */
		private var displayTitleInstance:IDataRenderer;
		
		
		/**
		 *  Part for the text of the tooltip
		 */
		[SkinPart(required="true")]
		public var displayText:RichText;
		
		/**
		 * Group that holds all text components (title and text)
		 * If a title is requested, it will be added to this group 
		 */
		[SkinPart(required="true")]
		public var tooltipGroup:Group;
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Text of the tooltip 
		 */
		private var _text:String;
		
		public function set text (value:String):void {
			
			if (_text != value && displayText && value) {
				_text = value;
				displayText.content = TextFlowUtil.importFromString(_text);
			}
		}
		
		public function get text ():String {
			return _text;
		}
		
		
		/**
		 * Title of the tooltip if any 
		 */
		private var _title:String;
		
		public function set title (value:String):void {
			
			if (_title != value) {
				_title = value;
				
				//See if we need to create a dynamic skin part
				if (!displayTitleInstance) 
				{
					//Create and add dynmic skin part. Push down relevant styles
					displayTitleInstance = IDataRenderer(this.createDynamicPartInstance("displayTitle"));
					UIComponent(displayTitleInstance).setStyle("color", this.getStyle("color"));
					tooltipGroup.addElementAt(UIComponent(displayTitleInstance), 0);
				}
				//Set the data to the title to be displayed
				displayTitleInstance.data = TextFlowUtil.importFromString(_title);
			}
		}
		
		public function get title ():String {
			return _title;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Overwritten Methods
		//
		//--------------------------------------------------------------------------
		
		override public function stylesInitialized():void {
			var skinClass:Object = this.getStyle("skinClass");
			if (!skinClass) {
				this.setStyle("skinClass", NiceToolTipSkin);
			}
		}
	}
}