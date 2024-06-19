![image](.github/docs/QuickLootIE.png)
# Differences to upstream

This fork of QuickLootEE has some differences, such as:

- Moves the CLib dependency into a submodule
- Cleans up the building process
- Supports 1.5.97, 1.6.640 and 1.6.1770 in one DLL (other versions untested but should work)
	- VR is not supported, but a VR version can be found [here](https://www.nexusmods.com/skyrimspecialedition/mods/102094)
	- The DLL has been renamed to reflect that change, it is now named `QuickLootEE-NG.dll`
- Implements the changes from Parapet's [PR](https://github.com/Eloquence4/QuickLootEE/pull/5) that integrates Inventory Interface Information Injector compatibility.
- Implements the changes from CPPCooper's [PR](https://github.com/Eloquence4/QuickLootEE/pull/3) which adds support for Hunterborn

## Build Requirements
* [CMake](https://cmake.org/)
	* Add this to your `PATH`
* [PowerShell](https://github.com/PowerShell/PowerShell/releases/latest)
* [Vcpkg](https://github.com/microsoft/vcpkg)
	* Add the environment variable `VCPKG_ROOT` with the value as the path to the folder containing vcpkg
* [Visual Studio Community 2022](https://visualstudio.microsoft.com/)
	* Desktop development with C++

## Register Visual Studio as a Generator
* Open `x64 Native Tools Command Prompt`
* Run `cmake`
* Close the cmd window

## Building
```
# Cloning the repo with the --recursive flag to init the submodules
git clone https://github.com/MissCorruption/QuickLootEE-NG --recursive
cd QuickLootEE-NG

# Building the Cmake project
cmake --preset ALL
cmake --build build --config Release
```


## End User Dependencies
* [Address Library for SKSE Plugins](https://www.nexusmods.com/skyrimspecialedition/mods/32444)
* [Microsoft Visual C++ Redistributable for Visual Studio 2022](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170)
* [SKSE64](https://skse.silverlock.org/)
* [SkyUI](https://www.nexusmods.com/skyrimspecialedition/mods/12604)
## Optional
* [Inventory Interface Information Injector](https://www.nexusmods.com/skyrimspecialedition/mods/85702)

## Credits
* [ilian53](https://github.com/Eloquence4) for the original QuickLootEE
* [Parapets](https://github.com/Exit-9B) for the PR for Inventory Interface Information Injector integration
* [AtomCrafty](https://github.com/AtomCrafty) for the sorting fix and persistent selection index
* [Ponzipyramid](https://github.com/ponzipyramid) for the [CommonLibSSE NG Template](https://github.com/ponzipyramid/CommonLibSSE-NG-Template) this fork is based on
* [Komegaki](https://github.com/Komegaki) for the new icon

