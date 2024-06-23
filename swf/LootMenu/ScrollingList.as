class LootMenu.ScrollingList extends gfx.controls.ScrollingList
{
	/* INITIALIZATION */

	// @override gfx.controls.ScrollingList
	public function ScrollingList()
	{
		super();
	}


	/* PUBLIC FUNCTIONS */

	public function modSelectedPage(a_page: Number): Void
	{
		selectedIndex = clamp(_selectedIndex + totalRenderers * a_page, 0, _dataProvider.length - 1);
	}


	/* PRIVATE FUNCTIONS */

	private function clamp(a_val: Number, a_lo: Number, a_hi: Number): Number
	{
		return Math.min(Math.max(a_lo, a_val), a_hi);
	}
	
	private function populateData(data: Array): Void
	{
		for (var i: Number = 0; i < totalRenderers; i++) {
			var renderer: MovieClip = renderers[i];
			renderer.reset();
		}

		super.populateData(data);
		var lootmenu = this.getParentMovieClip(this);
		this.setWindowSize(data.length);
		this.recordAlphaIfMissing(lootmenu);
		lootmenu._alpha = data.length == 0 ? 33 : lootmenu._originalAlpha;
	}
	function setWindowSize(numberOfRecords)
	{
		var lootmenu = this.getParentMovieClip(this);
		lootmenu.alpha = numberOfRecords == 0 ? 0 : 1;
		if (numberOfRecords < 7)
		{
			var extraRecords = 7 - numberOfRecords;
			var emptySlots = -40 * extraRecords;
			var squishBy = 40 * extraRecords;
			
			this.squish(lootmenu.bgMiddle, squishBy, extraRecords);
			this.moveToPos(lootmenu.bgBottom, emptySlots);
			this.moveToPos(lootmenu.buttonBar, emptySlots);
			this.moveToPos(lootmenu.infoBar, emptySlots);
			this.moveToPos(lootmenu.weight, emptySlots);
		}
		else
		{
			this.resetHeight(lootmenu.bgMiddle);
			this.resetY(lootmenu.bgBottom);
			this.resetY(lootmenu.buttonBar);
			this.resetY(lootmenu.infoBar);
			this.resetY(lootmenu.weight);
		}
	}
	function squish(obj, squishBy, emptySlots)
	{
      if(!obj)
      {
         return undefined;
      }
      this.recordOriginIfMissing(obj);
      obj._height = obj._originalH - squishBy;
   }
   function moveToPos(obj, newPos)
   {
      if(!obj)
      {
         return undefined;
      }
      this.recordOriginIfMissing(obj);
      obj._y = obj._originalY + newPos;
   }
   function resetY(obj)
   {
      if(!obj || !obj._originalY)
      {
         return undefined;
      }
      obj._y = obj._originalY;
   }
   function resetHeight(obj)
   {
      if(!obj || !obj._originalH)
      {
         return undefined;
      }
      obj._height = obj._originalH;
   }
   function recordOriginIfMissing(obj)
   {
      if(!obj)
      {
         return undefined;
      }
      if(obj._originalX == undefined)
      {
         obj._originalX = obj._x;
      }
      if(obj._originalY == undefined)
      {
         obj._originalY = obj._y;
      }
      if(obj._originalH == undefined)
      {
         obj._originalH = obj._height;
      }
      if(obj._originalW == undefined)
      {
         obj._originalW = obj._width;
      }
   }
   function recordAlphaIfMissing(obj)
   {
      if(!obj)
      {
         return undefined;
      }
      if(obj._originalAlpha == undefined)
      {
         obj._originalAlpha = obj._alpha;
      }
   }
   function getParentMovieClip(obj)
   {
      while(obj._parent != null)
      {
         obj = obj._parent;
         if(obj instanceof MovieClip)
         {
            return obj;
         }
      }
      return undefined;
   }
}
