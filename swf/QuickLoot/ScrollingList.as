class QuickLoot.ScrollingList extends gfx.controls.ScrollingList
{
	private function populateData(data: Array): Void
	{
		for (var i: Number = 0; i < totalRenderers; i++) {
			var renderer: MovieClip = renderers[i];
			renderer.reset();
		}
		super.populateData(data);
	}
}
