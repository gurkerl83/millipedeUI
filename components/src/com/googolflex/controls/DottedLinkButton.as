package com.googolflex.controls {

	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	import mx.controls.LinkButton;

	public class DottedLinkButton extends LinkButton {
		
		public function DottedLinkButton() {
			super();
		}
		
		override protected function rollOverHandler(event : MouseEvent) : void {
			super.rollOverHandler(event);
			
			// Change this expression: 
			// 'this.textField.width + 5 - this.textField.x + N'
			// to add length to the line.
			var w : int = this.textField.width + 5 - this.textField.x + 8;		
			
			drawDashedLine(this.graphics, w);
		}
		
		override protected function rollOutHandler(event:MouseEvent):void {
			super.rollOutHandler(event);
			
			var g : Graphics = this.graphics;
			g.clear();
		}
		
		private function drawDashedLine(g : Graphics, w : int) : void {
			g.lineStyle(1, 0x000000, 1.0);
			
			// Change this expression: 
			// 'textField.x + N' 
			// to offset the line left or right.
			var cur : int = textField.x + 4;
			
			while (cur < w) {
				g.moveTo(cur, textField.y + textField.height-3);
				g.lineTo(cur+2, textField.y + textField.height-3);
				cur += 4;
			}
		}
		
	}
}