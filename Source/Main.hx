import feathers.controls.Label;
import openfl.events.Event;
import feathers.data.ArrayCollection;
import feathers.controls.TabBar;
import feathers.layout.VerticalLayout;
import feathers.controls.ScrollContainer;
import openfl.display.Sprite;
import models.Tab;

class Main extends Sprite
{
	var xmlString:String;
	var container:ScrollContainer;
	var txtField:Label;

	public function new()
	{
		super();

		xmlString = sys.io.File.getContent("Assets/TabsForTest.xml");

		var tabs = parceXML(xmlString);
		createUI(tabs);
	}

	function parceXML(string:String)
	{
		var xml = Xml.parse(string).firstElement().elements();
		var listTabs:Array<Tab> = new Array();

		for (elem in xml) {
			var name = elem.get('name');
			var text = elem.firstElement().firstChild().nodeValue;

			listTabs.push(factory(name, text));
		}
		return listTabs;
	}

	function factory(name, text):Tab
	{
		var tab = new Tab(name, text);
		return tab;
	}

	function createUI(listTabs)
	{

		container = new ScrollContainer();
		var layout = new VerticalLayout();
		layout.gap = 20;
		layout.paddingTop = 20;
		container.layout = layout;
		container.width = stage.stageWidth;
		container.height = stage.stageHeight;

		stage.addEventListener(Event.RESIZE, resize_handler);

		this.addChild(container);

		var tabs = new TabBar();

		tabs.dataProvider = new ArrayCollection(listTabs);
		tabs.itemToText = function(item:Dynamic):String {
			return item.get_name();
		};

		container.addChild(tabs);

		tabs.addEventListener(Event.CHANGE, tabBar_changeHandler);

		txtField = new Label();
		txtField.text = tabs.selectedItem.get_text();
		container.addChild(txtField);
	}

	function tabBar_changeHandler(event:Event) {
		var tabs = cast(event.currentTarget, TabBar);
		txtField.text = tabs.selectedItem.get_text();
//		trace("TabBar selectedItem change: " + tabs.selectedItem.text);
	}

	function resize_handler(event: Event):Void
	{
		container.width = stage.stageWidth;
		container.height = stage.stageHeight;
	}
}
