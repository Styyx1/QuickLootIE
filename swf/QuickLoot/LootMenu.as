class QuickLoot.LootMenu extends gfx.core.UIComponent
{
	// stage elements
	
	private var itemList: QuickLoot.ScrollingList;
	private var title: TextField;
	private var weight: TextField;
	private var infoBar: QuickLoot.InfoBar;
	private var buttonBar: QuickLoot.ButtonBar;
	
	private var arrowUp: MovieClip;
	private var arrowDown: MovieClip;
	
	private var background: MovieClip;
	
	// private variables
	
	private var movingElements: Array;
	private var nonTransparentElements: Array;
	
	private var stageCenterX: Number;
	private var stageCenterY: Number;
	
	// settings
	
	public var minLines = 3;
	public var maxLines = 10;
	
	public var offsetX = 100;
	public var offsetY = -200;
	public var scale = 1;
	
	public var alphaNormal = 100;
	public var alphaEmpty = 30;
	
	public var anchorFractionX = 0;
	public var anchorFractionY = 0;
	
	// public functions
	
	public function init(settings: Object)
	{
		//QuickLoot.Utils.log("Initializing LootMenu");
		
		loadSetting(settings, "minLines", "number");
		loadSetting(settings, "maxLines", "number");
		
		loadSetting(settings, "offsetX", "number");
		loadSetting(settings, "offsetY", "number");
		loadSetting(settings, "scale", "number");
		
		loadSetting(settings, "alphaNormal", "number");
		loadSetting(settings, "alphaEmpty", "number");
		
		loadSetting(settings, "anchorFractionX", "number");
		loadSetting(settings, "anchorFractionY", "number");
		
		// The CoreList constructor sets a scale9Grid, which causes very odd
		// behavior when changing the list size after it's created.
		itemList["container"].scale9Grid = null;
		itemList.rowCount = maxLines;
		var self = this;
		itemList.addEventListener("scrollPositionChanged", function() { self.updateScrollArrows(); });
		
		movingElements = [weight, infoBar, buttonBar, arrowDown];
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
		updateScrollArrows();
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
		_x = stageCenterX + offsetX - background._width * anchorFractionX;
		_y = stageCenterY + offsetY - background._height * anchorFractionY;
	}
	
	private function updateScrollArrows()
	{
		arrowUp._visible = itemList.canScrollUp();
		arrowDown._visible = itemList.canScrollDown();
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