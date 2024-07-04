class QuickLoot.ListItemRenderer extends gfx.controls.ListItemRenderer
{
	/* PRIVATE VARIABLES */

	private static var STEALING_TEXT_COLOR: Number = 0xEF9A9A;
	private static var DEFAULT_TEXT_COLOR: Number = 0xFFFFFF;
	private static var MAX_TEXT_LENGTH: Number = 32;
	
	private static var DEFAULT_ICON_SOURCE = "skyui/icons_item_psychosteve.swf";
	private static var DEFAULT_ICON_LABEL = "default_misc";
	private static var DEFAULT_ICON_COLOR = 0xFFFFFF;
	private static var ICON_SIZE = 24;
	
	private var _iconLoader: MovieClipLoader;
	private var _iconSource: String = DEFAULT_ICON_SOURCE;
	private var _iconLabel: String = DEFAULT_ICON_LABEL;
	private var _iconColor: Number = undefined;
	
	private var _iconPosX: Number;
	private var _iconSpacing: Number = 3;

	/* STAGE ELEMENTS */

	public var textField: TextField;
	public var itemIcon: MovieClip;
	
	public var stolenIcon: MovieClip;
	public var readIcon: MovieClip;
	
	public var enchantIcon: MovieClip;
	public var knownEnchantIcon: MovieClip;
	public var specialEnchantIcon: MovieClip;
	
	public var dbmNew: MovieClip;
	public var dbmFound: MovieClip;
	public var dbmDisp: MovieClip;
	
	public var compNew: MovieClip;
	public var compFound: MovieClip;
	
	public var itemWeight: TextField;
	public var itemValue: TextField;
	public var itemValuePerWeight: TextField;
	
	public function ListItemRenderer(a_obj: Object)
	{
		super();
		
		_iconLoader = new MovieClipLoader();
		_iconLoader.addListener(this);
		_iconLoader.loadClip(_iconSource, itemIcon);
		
		reset();
	}
	
	public function reset()
	{
		itemIcon._visible = false;
		
		stolenIcon._visible = false;
		readIcon._visible = false;
		
		enchantIcon._visible = false;
		knownEnchantIcon._visible = false;
		specialEnchantIcon._visible = false;
		
		dbmNew._visible = false;
		dbmFound._visible = false;
		dbmDisp._visible = false;
		
		compNew._visible = false;
		compFound._visible = false;
		
		itemWeight._visible = false;
		itemValue._visible = false;
		itemValuePerWeight._visible = false;
	}
	
	public function setData(data: Object): Void
	{
		if (!data) return;

		// Call i4 if it is installed
		skse.plugins.InventoryInjector.ProcessEntry(data);
		
		// Do this first, so the icon source can load
		// in the background while we initialize the rest.
		setItemIcon(data.iconSource, data.iconLabel, data.iconColor);
		itemIcon._visible = true;
		
		// Item name
		
		var displayName: String = data.displayName;
		var count: Number = data.count;
		var stolen: Boolean = data.stolen;
		var weight: Number = data.weight;
		var value: Number = data.value;
		
		updateItemName(displayName, data.textColor, count, stolen);
		_iconPosX = textField._x + textField._width + _iconSpacing;
		
		// Column values
		
		updateColumnValue(itemValue, value, 2);
		updateColumnValue(itemWeight, weight, 2);
		updateColumnValue(itemValuePerWeight, value / weight, 0);
		
		// Icons behind the item name
		
		updateIcon(stolenIcon, data.stolen);
		updateIcon(readIcon, data.isRead);
		
		updateIcon(knownEnchantIcon, data.knownEnchanted)
		|| updateIcon(specialEnchantIcon, data.specialEnchanted)
		|| updateIcon(enchantIcon, data.enchanted);
		
		updateIcon(dbmNew, data.dbmNew)
		|| updateIcon(dbmDisp, data.dbmDisp)
		|| updateIcon(dbmFound, data.dbmFound);
		
		updateIcon(compNew, data.compNew)
		|| updateIcon(compFound, data.compFound);
	}
	
	public function updateItemName(displayName: String, color: Number, count: Number, stealing: Boolean) {
		if(!displayName) displayName = "<unnamed>";
		if(!color) color = stealing ? STEALING_TEXT_COLOR : DEFAULT_TEXT_COLOR;
		if(!count) count = 1;
		
		if(count > 1) {
			displayName += " (" + count.toString() + ")";
		}
		
		if(displayName.length > MAX_TEXT_LENGTH) {
			displayName = displayName.substr(0, MAX_TEXT_LENGTH - 3) + "...";
		}
		
		label = displayName;
		textField.autoSize = "left";
		textField.textColor = color;
	}
	
	private function updateIcon(icon: MovieClip, enable: Boolean)
	{
		if(!enable) return false;
		
		icon._x = _iconPosX;
		icon._visible = true;
		_iconPosX += icon._width + _iconSpacing;
		
		return true;
	}
	
	public function updateColumnValue(text: TextField, value: Number, precision: Number)
	{
		if(!value || isNaN(value) || !isFinite(value)) {
			text.text = "-";
			text._visible = true;
			return;
		}
		
		text.text = formatNumber(value, precision);
		text._visible = true;
	}
	
	private function formatNumber(number: Number, precision: Number)
	{
 		var factor = Math.pow(10, precision);
 		return (Math.round(number * factor) / factor).toString();
	}
	
	private function setItemIcon(iconSource: String, iconLabel: String, iconColor: Number)
	{
		if(!iconSource) iconSource = DEFAULT_ICON_SOURCE;
		if(!iconLabel) iconLabel = DEFAULT_ICON_LABEL;
		
		var iconSourceChanged = iconSource != _iconSource;
		
		_iconSource = iconSource;
		_iconLabel = iconLabel;
		_iconColor = iconColor;
		
		// Either trigger an asynchronous swf load or invoke the callback directly
		if(iconSourceChanged) {
			_iconLoader.loadClip(_iconSource, itemIcon);
		}
		else {
			onLoadInit(itemIcon);
		}
	}
	
	// This is called when the _iconLoader has finished loading the icon source swf
	private function onLoadInit(icon: MovieClip): Void
	{
		icon.gotoAndStop(_iconLabel);
		icon._width = itemIcon._height = ICON_SIZE;
		
		if(typeof(_iconColor) != "number") return;
		
		var colorTransform = new flash.geom.ColorTransform();
		colorTransform.rgb = _iconColor;
		
		var transform = new flash.geom.Transform(MovieClip(icon));
		transform.colorTransform = colorTransform;
	}
}
