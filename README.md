# Differences to upstream

This fork of QuickLootEE has some differences, such as:

- Moves the CLib dependency into a submodule
- Cleans up the building process
- Supports 1.5.97, 1.6.640 and 1.6.1770 in one DLL (other versions untested but should work)
	- VR is not supported, but a Vr version can be found [here](https://www.nexusmods.com/skyrimspecialedition/mods/102094)
	- The DLL has been renamed to reflect that change, it is now named `QuickLootEE-NG.dll`
- Implements the changes from Parapet's [PR](https://github.com/Eloquence4/QuickLootEE/pull/5) that integrates Inventory Interface Information Injector compatibility.

If desired I'll also merge the fixed animal check PR, which is located [here](https://github.com/Eloquence4/QuickLootEE/pull/3)

Below is the original description of QuickLootEE
All credits go to [ilian53](https://github.com/Eloquence4) for the original QLEE and [Parapets](https://github.com/Exit-9B) for the I4 compatibility changes.

# QuickLootEE

Fork of QuickLootRE made to use the old QuickLootSE icons and show the TCC icons for LOTD. To be used with:

https://www.nexusmods.com/skyrimspecialedition/mods/11802
https://www.nexusmods.com/skyrimspecialedition/mods/38529

![Demo screenshot](https://github.com/Eloquence4/QuickLootEE/raw/master/screenshot.png)

## Build Dependencies
* [Boost](https://www.boost.org/)
	* Regex
* [CommonLibSSE](https://github.com/Ryan-rsm-McKenzie/CommonLibSSE)
* [frozen](https://github.com/serge-sans-paille/frozen)
* [spdlog](https://github.com/gabime/spdlog)
* [Xbyak](https://github.com/herumi/xbyak)

## End User Dependencies
* [Address Library for SKSE Plugins](https://www.nexusmods.com/skyrimspecialedition/mods/32444)
* [Microsoft Visual C++ Redistributable for Visual Studio 2019](https://support.microsoft.com/en-us/help/2977003/the-latest-supported-visual-c-downloads)
* [SKSE64](https://skse.silverlock.org/)
* [SkyUI](https://www.nexusmods.com/skyrimspecialedition/mods/12604)
