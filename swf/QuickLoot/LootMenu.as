class QuickLoot.LootMenu extends gfx.core.UIComponent
{
	// stage elements
	var itemList: QuickLoot.ScrollingList;
	var title: TextField;
	var weight: TextField;
	var infoBar: QuickLoot.InfoBar;
	var buttonBar: QuickLoot.ButtonBar;
	
	var bgTop: MovieClip;
	var bgMiddle: MovieClip;
	var bgBottom: MovieClip;
	
	var background: MovieClip;
	
	var movingElements: Array;
	
	// settings
	var minLines = 3;
	var maxLines = 7;
	
	var alphaNormal = 100;
	var alphaEmpty = 30;
	
	var useStealingTextColor = true;
	var showStealingIcon = true;
	var showReadIcon = true;
	
	var showEnchantmentIcon = true;
	var showKnownEnchantmentIcon = true;
	var showSpecialEnchantmentIcon = true;
	
	var showDbmNewIcon = true;
	var showDbmFoundIcon = true;
	var showDbmDisplayedIcon = true;
	
	var showCompNewIcon = true;
	var showCompFoundIcon = true;
	
	public function init(settings)
	{
		if (typeof(settings.minLines) == "number" && settings.minLines >= 0 && settings.minLines <= 10)
			minLines = settings.minLines;
		if (typeof(settings.maxLines) == "number" && settings.maxLines >= minLines && settings.maxLines <= 10)
			maxLines = settings.maxLines;
		
		if (typeof(settings.useStealingTextColor) == "boolean")
			useStealingTextColor = settings.useStealingTextColor;
		if (typeof(settings.showStealingIcon) == "boolean")
			showStealingIcon = settings.showStealingIcon;
		if (typeof(settings.showReadIcon) == "boolean")
			showReadIcon = settings.showReadIcon;
		
		if (typeof(settings.showEnchantmentIcon) == "boolean")
			showEnchantmentIcon = settings.showEnchantmentIcon;
		if (typeof(settings.showKnownEnchantmentIcon) == "boolean")
			showKnownEnchantmentIcon = settings.showKnownEnchantmentIcon;
		if (typeof(settings.showSpecialEnchantmentIcon) == "boolean")
			showSpecialEnchantmentIcon = settings.showSpecialEnchantmentIcon;
		
		if (typeof(settings.showDbmNewIcon) == "boolean")
			showDbmNewIcon = settings.showDbmNewIcon;
		if (typeof(settings.showDbmFoundIcon) == "boolean")
			showDbmFoundIcon = settings.showDbmFoundIcon;
		if (typeof(settings.showDbmDisplayedIcon) == "boolean")
			showDbmDisplayedIcon = settings.showDbmDisplayedIcon;
		
		if (typeof(settings.showCompNewIcon) == "boolean")
			showCompNewIcon = settings.showCompNewIcon;
		if (typeof(settings.showCompFoundIcon) == "boolean")
			showCompFoundIcon = settings.showCompFoundIcon;
		
		// TODO figure out how to change the number of rows without completely breaking the ScrollingList
		//itemList.rowCount = maxLines;
		//itemList.height = maxLines * 39;
		//itemList.invalidate();
		
		movingElements = [bgBottom, weight, infoBar, buttonBar];
		saveInitialElementBounds();
		refresh();
	}
	
	public function refresh():Void
	{
		resizeContainer(itemList.dataProvider.length);
	}
	
	private function resizeContainer(lineCount: Number)
	{
		// How many lines the stage placement accounts for.
		var neutralLineCount = 7;
		var heightPerLine = 39;
		
		lineCount = Math.min(lineCount, neutralLineCount);
		//lineCount = Math.min(lineCount, maxLines);
		//lineCount = Math.max(lineCount, minLines);
		
		var shiftAmount = (lineCount - neutralLineCount) * heightPerLine;
		
		QuickLoot.Utils.log("Resizing to " + lineCount + " lines (shift by " + shiftAmount + ")");
		
		background._height = background._originalH + shiftAmount;
		
		for(var i in movingElements) {
			var element = movingElements[i];
			element._y = element._originalY + shiftAmount;
		}
	}
	
	private function saveInitialElementBounds()
	{
		for(var member in this) {
			var element = this[member];
		
			if(!(element instanceof MovieClip) && !(element instanceof TextField)) continue;
			
			QuickLoot.Utils.log(member + ": " + element._x + ", " + element._y + ", " + element._width + ", " + element._height);
			
			element._originalX = element._x;
			element._originalY = element._y;
			element._originalW = element._width;
			element._originalH = element._height;
		}
	}
}