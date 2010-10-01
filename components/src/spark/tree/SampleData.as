package spark.tree
{
import flash.events.EventDispatcher;

import mx.collections.ArrayCollection;

public class SampleData extends EventDispatcher
{
	
	[Embed("icon1.png")]
	public static var ICON1:Class;
	
	[Embed("icon2.png")]
	public static var ICON2:Class;
	
	[Embed("icon3.png")]
	public static var ICON3:Class;
	
	[Embed("icon4.png")]
	public static var ICON4:Class;
	
	private static var icons:Vector.<Class> = Vector.<Class>([ ICON1, ICON2, ICON3, ICON4 ]);
	
	public function SampleData(label:String = null)
	{
		this.label = label;
	}
	
	[Bindable]
	public var label:String;
	
	[Bindable]
	public var children:ArrayCollection;
	
	[Bindable]
	public var icon:Class;
	
	public function setRandomIcon():void
	{
		icon = getRandomIcon();
	}
	
	public function getRandomIcon():Class
	{
		var index:int = Math.round(Math.random() * (icons.length - 0.1) - 0.45);
		return icons[index];
	}
	
}
}