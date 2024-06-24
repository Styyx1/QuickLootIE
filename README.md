![image](.github/docs/QuickLootIE.png)

# QuickLootIE

QuickLootIE is a fork from QuickLootEE which aims to offer the definitive version of QuickLoot.
It intregates several features scattered across different QL versions under one umbrella to
remove the burden of choice from the End User, while also adding new features to it.
Below you can find a list of new features and requirements to use and/or build the project.

_Special thanks to Faen90 and AtomCrafty for helping with this project. 
This would have taken longer if not outright impossible without them!_

## New features

* A new name, QuickLootIE, to differentiate from the original
* A new icon, made by [Komegaki](https://github.com/Komegaki)
* One DLL for all Flatrim versions of Skyrim (1.5.97 <-> 1.6.1170)
	* A VR version of QuickLoot can be found [here](https://www.nexusmods.com/skyrimspecialedition/mods/102094) 
* An entirely overhauled MCM with new settings
	* Courtesy of Faen90 
	* Including a toggle to disable QuickLoot for animals to ensure compatibility with Hunting Overhauls
		* Courtey of [CPPCooper](https://github.com/Eloquence4/QuickLootEE/pull/3) 
* A new, customizable sorting system
	* Users can choose what should be sorted at the top of the LootMenu (i.e. Gold)
	* Courtesy of AtomCrafty
* A revamped LOTD integration with a Completionist one to match, including icons
* A `Take All` button has been added to the LootMenu
* Dynamically scale the LootMenu based on the amount of items in the container
* Inventory Interface Information Injector integration to display icons in the LootMenu
	* Courtesy of [Parapet](https://github.com/Eloquence4/QuickLootEE/pull/5)  

## Build Requirements
* [CMake](https://cmake.org/)
	* Add this to your `PATH`
* [PowerShell](https://github.com/PowerShell/PowerShell/releases/latest)
* [Vcpkg](https://github.com/microsoft/vcpkg)
	* Add the environment variable `VCPKG_ROOT` with the value as the path to the folder containing vcpkg
* [Visual Studio Community 2022](https://visualstudio.microsoft.com/)
	* Desktop development with C++
* [Spriggit](https://github.com/Mutagen-Modding/Spriggit)
	* Below are instructions for the CLI version
* [Caprica](https://github.com/Orvid/Caprica)
	* To compile the papyrus scripts
	* Due to the scripts being declared as native, Skyrim's CK will not be able to compile them

## Register Visual Studio as a Generator
* Open `x64 Native Tools Command Prompt`
* Run `cmake`
* Close the cmd window

## Building Instructions
```
# Cloning the repo with the --recursive flag to init the submodules
git clone https://github.com/MissCorruption/QuickLootIE --recursive
cd QuickLootIE

# Building the Cmake project
cmake --preset ALL
cmake --build build --config Release

# Building the ESP File
Path/To/Spriggit.CLI.exe deserialize --InputPath Source\ESP --OutputPath QuickLootIE.esp
```


## End User Dependencies
* [Address Library for SKSE Plugins](https://www.nexusmods.com/skyrimspecialedition/mods/32444)
* [Microsoft Visual C++ Redistributable for Visual Studio 2022](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170)
* [SKSE64](https://skse.silverlock.org/)
* [SkyUI](https://www.nexusmods.com/skyrimspecialedition/mods/12604)
* [PapyrusUtil SE - Modders Scripting Utility Functions](https://www.nexusmods.com/skyrimspecialedition/mods/13048)
* [Inventory Interface Information Injector](https://www.nexusmods.com/skyrimspecialedition/mods/85702)
	* Not required for the mod to function, only required if you want to benefit from it's integration.

## Credits
* [ilian53](https://github.com/Eloquence4) for the original QuickLootEE
* [Parapets](https://github.com/Exit-9B) for the PR for Inventory Interface Information Injector integration
* [AtomCrafty](https://github.com/AtomCrafty) for major contributions to the codebase, notably the sorting system
* [Faen90](https://github.com/Faen668) for major contributions to the codebase, notably the MCM
* [Ponzipyramid](https://github.com/ponzipyramid) for the [CommonLibSSE NG Template](https://github.com/ponzipyramid/CommonLibSSE-NG-Template) this fork is based on
* [Noggog](https://github.com/Noggog) for Spriggit
* [Orvid](https://github.com/Orvid) for Caprica
* [Komegaki](https://github.com/Komegaki) for the new icon

