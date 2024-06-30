class QuickLoot.LootMenu extends gfx.core.UIComponent
{
	// stage elements
	
	private var itemList: QuickLoot.ScrollingList;
	private var title: TextField;
	private var weight: TextField;
	private var infoBar: QuickLoot.InfoBar;
	private var buttonBar: QuickLoot.ButtonBar;
	
	private var background: MovieClip;
	
	// private variables
	
	private var movingElements: Array;
	private var nonTransparentElements: Array;
	
	private var stageCenterX: Number;
	private var stageCenterY: Number;
	
	// settings
	
	public var useStealingTextColor = true;
	
	public var showStealingIcon = true;
	public var showReadIcon = true;
	
	public var showEnchantmentIcon = true;
	public var showKnownEnchantmentIcon = true;
	public var showSpecialEnchantmentIcon = true;
	
	public var showDbmNewIcon = true;
	public var showDbmFoundIcon = true;
	public var showDbmDisplayedIcon = true;
	
	public var showCompNewIcon = true;
	public var showCompFoundIcon = true;
	
	public var minLines = 3;
	public var maxLines = 10;
	
	public var offsetX = 100;
	public var offsetY = -200;
	public var scale = 1;
	
	public var alphaNormal = 100;
	public var alphaEmpty = 30;
	
	// public functions
	
	public function init(settings: Object)
	{
		QuickLoot.Utils.log("Initializing LootMenu");
		
		loadSetting(settings, "useStealingTextColor", "boolean");
		
		loadSetting(settings, "showStealingIcon", "boolean");
		loadSetting(settings, "showReadIcon", "boolean");
		
		loadSetting(settings, "showEnchantmentIcon", "boolean");
		loadSetting(settings, "showKnownEnchantmentIcon", "boolean");
		loadSetting(settings, "showSpecialEnchantmentIcon", "boolean");
		
		loadSetting(settings, "showDbmNewIcon", "boolean");
		loadSetting(settings, "showDbmFoundIcon", "boolean");
		loadSetting(settings, "showDbmDisplayedIcon", "boolean");
		
		loadSetting(settings, "showCompNewIcon", "boolean");
		loadSetting(settings, "showCompFoundIcon", "boolean");
		
		loadSetting(settings, "minLines", "number");
		loadSetting(settings, "maxLines", "number");
		
		loadSetting(settings, "offsetX", "number");
		loadSetting(settings, "offsetY", "number");
		loadSetting(settings, "scale", "number");
		
		loadSetting(settings, "alphaNormal", "number");
		loadSetting(settings, "alphaEmpty", "number");
		
		// The CoreList constructor sets a scale9Grid, which causes very odd
		// behavior when changing the list size after it's created.
		itemList["container"].scale9Grid = null;
		itemList.rowCount = maxLines;
		
		movingElements = [weight, infoBar, buttonBar];
		nonTransparentElements = [buttonBar];
		
		saveInitialElementBounds();
		refresh();
	}
	
	public function refresh()
	{
		var lineCount = itemList.dataProvider.length;
		var isEmpty = lineCount == 0;
		
		resizeContainer(lineCount);
		setOpacity(isEmpty ? alphaEmpty : alphaNormal);
		updateScale();
	}
	
	// private functions
	
	private function loadSetting(settings: Object, name: String, type: String)
	{
		//QuickLoot.Utils.log(name + " (" + type + "): " + settings[name]);
		
		if(typeof(settings[name]) == type) {
			this[name] = settings[name];
		}
	}
	
	private function resizeContainer(lineCount: Number)
	{
		// How many lines the stage placement accounts for.
		var neutralLineCount = 7;
		var heightPerLine = 40;
		
		lineCount = Math.min(lineCount, maxLines);
		lineCount = Math.max(lineCount, minLines);
		
		var shiftAmount = (lineCount - neutralLineCount) * heightPerLine;
		
		//QuickLoot.Utils.log("Resizing to " + lineCount + " lines (shift by " + shiftAmount + ")");
		
		background._height = background._originalH + shiftAmount;
		
		for(var i in movingElements) {
			var element = movingElements[i];
			element._y = element._originalY + shiftAmount;
		}
	}
	
	private function updateScale()
	{
		var bounds = getBounds(this);
		
		_width = (bounds.xMax - bounds.xMin) * scale;
		_height = (bounds.yMax - bounds.yMin) * scale;
		_x = stageCenterX + offsetX;
		_y = stageCenterY + offsetY;
	}
	
	private function setOpacity(opacity: Number)
	{
		for(var member in this) {
			var element = this[member];
			
			if(nonTransparentElements.indexOf(element) >= 0) {
				continue;
			}
			
			element._alpha = opacity;
		}
	}
	
	private function saveInitialElementBounds()
	{
		stageCenterX = _x;
		stageCenterY = _y;
		
		for(var member in this) {
			var element = this[member];
			
			if(!(element instanceof MovieClip) && !(element instanceof TextField)) continue;
			
			//QuickLoot.Utils.log(member + ": " + element._x + ", " + element._y + ", " + element._width + ", " + element._height);
			
			element._originalX = element._x;
			element._originalY = element._y;
			element._originalW = element._width;
			element._originalH = element._height;
		}
	}
}