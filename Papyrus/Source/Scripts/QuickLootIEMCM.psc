scriptname QuickLootIEMCM extends SKI_ConfigBase conditional

; Script Imports
import QuickLootIENative
import StringUtil
import utility
import debug

; Maintenance Script
QuickLootIEMaintenance Property QLIEMaintenance Auto

; General Settings
bool property QLIECloseInCombat = false auto hidden
bool property QLIECloseWhenEmpty = true auto hidden
bool property QLIEDispelInvisibility = true auto hidden
bool property QLIEOpenWhenContainerUnlocked = true auto hidden
bool property QLIEDisableForAnimals = false auto hidden

; Icon Settings
bool property QLIEIconShowBookRead = true auto hidden
bool property QLIEIconShowEnchanted = true auto hidden

; LOTD Settings
bool property QLIEIconShowDBMDisplayed = true auto hidden
bool property QLIEIconShowDBMFound = true auto hidden
bool property QLIEIconShowDBMNew = true auto hidden

; Completionist Settings
bool property QLIEShowCompNeeded = true auto hidden
bool property QLIEShowCompCollected = true auto hidden

; Window Settings
float property QLIEWindowX = 0.0 auto hidden
float property QLIEWindowY = 0.0 auto hidden
float property QLIEWindowW = 0.0 auto hidden
float property QLIEWindowH = 0.0 auto hidden

; Sort priortiy for Loot Menu
string[] property user_selected_sort_options auto hidden
Int Property SortOptionsChoice = 0 Auto Hidden
bool property user_selected_sort_options_initialised = false auto hidden

string[] Sort_Options
string[] SortOptionName
string[] SortOptionHigh
string marked_sort_option

int[] SortOptionSlot
int SortOptionIndx
int sort_options_state
int OID_QLIE_SaveSortPreset

;Preset Selections
string[] sort_presets 	; Presets Menu
int sort_presets_state	; State
int property Sort_Presets_Choice = 0 auto hidden

; Controls if the preset should be loaded from the DLL or the JSON path.
int max_dll_preset_count

; Variables
bool AutoLoaded
bool lotd_installed
bool comp_installed

;---------------------------------------------------
;-- Events -----------------------------------------
;---------------------------------------------------

event OnConfigInit()	
	if (!AutoLoaded)
		AutoLoadConfig()
	endIf
endEvent

;---------------------------------------------------
;-- Events -----------------------------------------
;---------------------------------------------------

event OnConfigOpen()
	UpdateCompatibilityVariables()
	marked_sort_option = ""
	
	pages = new string[4]
	pages[0] = "$qlie_MainMCMPage"
	pages[1] = "$qlie_WindMCMPage"
	pages[2] = "$qlie_SortMCMPage"
	pages[3] = "$qlie_CompMCMPage"
endEvent

;---------------------------------------------------
;-- Events -----------------------------------------
;---------------------------------------------------

event OnPageReset(string page)
    if (CurrentPage == "$qlie_MainMCMPage")
		BuildMainPage()
		return
	endIf

    if (CurrentPage == "$qlie_WindMCMPage")
		BuildWindPage()
		return
	endIf
	
    if (CurrentPage == "$qlie_SortMCMPage")
		BuildSortPage()
		return
	endIf

    if (CurrentPage == "$qlie_CompMCMPage")
		BuildCompPage()
		return
	endIf
endEvent

;---------------------------------------------------
;-- Events -----------------------------------------
;---------------------------------------------------

event OnOptionHighlight(Int val)
	if (val == OID_QLIE_SaveSortPreset)
		SetInfoText("$qlie_sort_presets_state_save_info")
	else
		SetInfoText(GetSortOptionHighlight(val))
	endif
endEvent

;---------------------------------------------------
;-- Events -----------------------------------------
;---------------------------------------------------

event OnOptionInputOpen(Int val)
	if (val == OID_QLIE_SaveSortPreset)
		SetInputDialogStartText("$qlie_SavePreset")
	endIf
endEvent

;---------------------------------------------------
;-- Events -----------------------------------------
;---------------------------------------------------

event OnOptionInputAccept(Int val, String presetName)
	if (val == OID_QLIE_SaveSortPreset)
		SaveSortPreset(presetName)
	endIf
endEvent

;---------------------------------------------------
;-- Events -----------------------------------------
;---------------------------------------------------

event OnOptionSelect(Int val)
	
	string name = GetSortOptionName(val)
	if name == ""
		return
	endIf
	
	if marked_sort_option == name
		if ShowMessage("What would you like to do?", true, "Unmark Position", "Remove Priority")
			UnMarkSortOptionPosition(val)
		else
			RemoveSortOption(val)
		endif
	else		
		if ShowMessage("What would you like to do?", true, "Mark Position", "Remove Priority")
			MarkSortOptionPosition(val)
		else
			RemoveSortOption(val)
		endif
	endif
endEvent
	
;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

function UpdateCompatibilityVariables()
	lotd_installed = ((game.GetModByName("DBM_RelicNotifications.esp") != 255) as bool)
	comp_installed = ((game.GetModByName("Completionist.esp") != 255) as bool)
	
	if (!lotd_installed)
		QLIEIconShowDBMNew = false
		QLIEIconShowDBMFound = false
		QLIEIconShowDBMDisplayed = false
	endIf

	if (!comp_installed)
		QLIEShowCompNeeded = false
		QLIEShowCompCollected = false
	endIf
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

string function GetEnabledStatus(Bool bValue)
	if (bValue)
		return "$qlie_Enabled"
	endIf

	return "$qlie_Disabled"
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

string function GetCompatibilityEnabledStatus(Bool bValue, Bool bInstalled)
	
	if !bInstalled
		bValue = false
		return "$qlie_NotInstalled"
	endif
	
	if (bValue)
		return "$qlie_Enabled"
	endIf

	return "$qlie_Disabled"
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

string function GetConfigSaveString()
	
	if papyrusutil.GetScriptVersion() > 31
		return "$qlie_SavePreset"
	endIf
	
	return "$qlie_PapUtilError"
endFunction	

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

string function GetConfigLoadString()

	if papyrusutil.GetScriptVersion() > 31
		return "$qlie_LoadPreset"
	endIf
	
	return "$qlie_PapUtilError"
endFunction	

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

function BuildSortOptions(bool forceReset = false)
	
	;Get Default List
	Sort_Options = GetSortingPreset(1)
	
	;Reset to default on first load or if reset button is pressed.
	if forceReset || !user_selected_sort_options_initialised
		user_selected_sort_options = Sort_Options
		user_selected_sort_options_initialised = true
	endIf
	
	; Remove entries from Sort List if they are in the User List
	Sort_Options = FormatSortOptionsList(Sort_Options, user_selected_sort_options)
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

function BuildPresetList()

	;Grab presets from the DLL.
	sort_presets = GetSortingPresets()
	max_dll_preset_count = sort_presets.length

	;Grab custom presets from the JSON Path
	string[] custom_presets = jsonutil.JsonInFolder("../QuickLootIE/Profiles/SortPresets/")
	if custom_presets.length > 0
		sort_presets = AddPresetsToArray(sort_presets, custom_presets)
	endif
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

function load_preset()

	if Sort_Presets_Choice > 0 
		if Sort_Presets_Choice <= max_dll_preset_count 
			user_selected_sort_options = GetSortingPreset(Sort_Presets_Choice)
		else
			user_selected_sort_options = jsonutil.PathStringElements("../QuickLootIE/Profiles/SortPresets/" + sort_presets[Sort_Presets_Choice], ".!QLIESortOrder")
		endIf
	endif
	
	Sort_Presets_Choice = 0
	ForcePageReset()
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

string function GetSortOptionName(Int val)
	
	int Index = SortOptionSlot.Find(val)
	if (Index != -1)
		return SortOptionName[Index]
	endIf
		
	Return ""
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

string function GetSortOptionHighlight(Int val)
	
	int Index = SortOptionSlot.Find(val)
	if (Index != -1)
		return SortOptionHigh[Index]
	endIf
		
	Return ""
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

function SaveSortPreset(string presetName)
	
	if presetName == ""
		return
	endIf
	
	if papyrusutil.GetScriptVersion() > 31
		jsonutil.SetPathStringArray("../QuickLootIE/Profiles/SortPresets/" + presetName, ".!QLIESortOrder", user_selected_sort_options, false)
		jsonutil.Save("../QuickLootIE/Profiles/SortPresets/" + presetName, false)
		ShowMessage("$qlie_PresetSaveSuccessMenu")
		ForcePageReset()
	else
		ShowMessage("$qlie_PapUtilError")
		ForcePageReset()
	endIf
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

function RemoveSortOption(int val)
	
	int Index = SortOptionSlot.Find(val)
	string name = GetSortOptionName(val)
	
	if (Index != -1)
		if ShowMessage("Are you sure you want to remove sort priority for " + GetSortOptionName(val) + "?", true, "$qlie_ConfirmY", "$qlie_ConfirmN")
			
			if marked_sort_option == name
				marked_sort_option = ""
			endIf
			
			user_selected_sort_options = RemoveSortOptionPriority(user_selected_sort_options, Index)
			SortOptionsChoice = 0
			ForcePageReset()
		endIf
	endIf
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

function UnMarkSortOptionPosition(int val)
	marked_sort_option = ""
	ForcePageReset()
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

function MarkSortOptionPosition(int val)
	int Index = SortOptionSlot.Find(val)
	if (Index != -1)
		marked_sort_option = SortOptionName[Index]
		ForcePageReset()
	endIf
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

function InsertSortOption()
		
	if marked_sort_option == ""
		user_selected_sort_options = InsertSortOptionPriority(user_selected_sort_options, Sort_Options[SortOptionsChoice], user_selected_sort_options.length)
	else
		int index = user_selected_sort_options.find(marked_sort_option)
	
		if (Index != -1)
			user_selected_sort_options = InsertSortOptionPriority(user_selected_sort_options, Sort_Options[SortOptionsChoice], Index)
			marked_sort_option = user_selected_sort_options[Min(user_selected_sort_options.length, index + 1)]
		endIf
	endif
	
	SortOptionsChoice = 0
	ForcePageReset()
EndFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

int function Min(int first, int second)

	if first < second
		return first
	endIf

	return second
endfunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

function BuildMainPage()
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
		
	AddHeaderOption("$qlie_GeneralSettingsHeader", 0)
	AddTextOptionST("close_in_combat", 					"$qlie_close_in_combat_text", 				GetEnabledStatus(QLIECloseInCombat), 0)
	AddTextOptionST("close_when_empty", 				"$qlie_close_when_empty_text", 				GetEnabledStatus(QLIECloseWhenEmpty), 0)
	AddTextOptionST("dispel_invis", 					"$qlie_dispel_invis_text", 					GetEnabledStatus(QLIEDispelInvisibility), 0)
	AddTextOptionST("open_when_container_unlocked", 	"$qlie_open_when_container_unlocked_text", 	GetEnabledStatus(QLIEOpenWhenContainerUnlocked), 0)

	AddEmptyOption()
	AddHeaderOption("$qlie_IconSettingsHeader", 0)
	AddTextOptionST("show_book_read_icon", 				"$qlie_show_book_read_icon_text", 			GetEnabledStatus(QLIEIconShowBookRead), 0)
	AddTextOptionST("show_enchanted_icon", 				"$qlie_show_enchanted_icon_text", 			GetEnabledStatus(QLIEIconShowEnchanted), 0)

	SetCursorPosition(1)
	AddHeaderOption("$qlie_ModInformationHeader")
	AddTextOption("", "$qlie_Author", 0)
	AddEmptyOption()
	AddTextOption("", "$qlie_ModVersion{ " + QLIEMaintenance.ModVersion + "}", 0)
	AddTextOption("", "$qlie_DLLVersion{ " + QuickLootIENative.GetVersion() + "}", 0)

	AddEmptyOption()
	AddHeaderOption("$qlie_ProfileHeader")
	AddTextOptionST("ProfileSave", 						"$qlie_ProfileText1", 			GetConfigSaveString(), 0)
	AddTextOptionST("ProfileLoad", 						"$qlie_ProfileText1", 			GetConfigLoadString(), 0)
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

function BuildWindPage()
	SetCursorFillMode(TOP_TO_BOTTOM)
	
	SetCursorPosition(0)
	AddHeaderOption("$qlie_WindowSettingsHeader", 0)
	AddSliderOptionST("window_X", 						"$qlie_window_X_text", QLIEWindowX, "{0}", 0)
	AddSliderOptionST("window_Y", 						"$qlie_window_Y_text", QLIEWindowY, "{0}", 0)

	SetCursorPosition(1)
	AddHeaderOption("")
	AddSliderOptionST("window_W", 						"$qlie_window_W_text", QLIEWindowW, "{0}", 0)
	AddSliderOptionST("window_H", 						"$qlie_window_H_text", QLIEWindowH, "{0}", 0)
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

function BuildSortPage()
	BuildPresetList()
	BuildSortOptions()

	SortOptionIndx = 0
	SortOptionSlot = new int[128]
	SortOptionName = new string[128]
	SortOptionHigh = new string[128]
	
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	AddHeaderOption("Loot Menu Sort Options", 0)
	AddMenuOptionST("sort_options_state", 			"$qlie_sort_options_state_text",   		Sort_Options[SortOptionsChoice], (!(Sort_Options.length) as bool) as Int)
	
	AddEMptyOption()
	if Sort_Options.length == 0
		AddTextOptionST("sort_options_insert", 		"$qlie_sort_options_insert_none_text", 		"Insert Option", 1)
	else
		AddTextOptionST("sort_options_insert", 		"$qlie_sort_options_insert_text{" + Sort_Options[SortOptionsChoice] + "}", 		"Insert Option", 0)
	endIf
	AddTextOptionST("sort_options_reset", 			"$qlie_sort_options_reset_text", "Reset", 0)
	
	AddEmptyOption()
	AddHeaderOption("Sort Priority Presets", 0)
	AddMenuOptionST("sort_presets_state", 			"$qlie_sort_presets_state_text",   		sort_presets[Sort_Presets_Choice])
	OID_QLIE_SaveSortPreset = AddInputOption("$qlie_sort_presets_state_save_text", "$qlie_SaveSortPreset", 0)
	
	SetCursorPosition(1)
	AddHeaderOption("Current Sort Priority", 0)
	
	int idx = 0	
	while idx < user_selected_sort_options.length
		if user_selected_sort_options[idx] != ""
			SortOptionName[SortOptionIndx] = user_selected_sort_options[idx]
			SortOptionHigh[SortOptionIndx] = "Click to mark or remove sort priority for this option"
			
			if SortOptionName[SortOptionIndx] == marked_sort_option
				SortOptionSlot[SortOptionIndx] = AddTextOption(idx + ": <font color='" + "#13a81c" + "'>" +marked_sort_option + "</font>", "{M}")
			else
				SortOptionSlot[SortOptionIndx] = AddTextOption(idx + ": " + user_selected_sort_options[idx], "", 0)
			endif

			SortOptionIndx += 1
		endif
		idx += 1
	endWhile
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

function BuildCompPage()
	SetCursorFillMode(TOP_TO_BOTTOM)
	
	SetCursorPosition(0)
	AddHeaderOption("$qlie_LOTDCompatHeader", 0)
	AddTextOptionST("show_lotd_new_icon", 			"$qlie_show_lotd_new_icon_text", 		GetCompatibilityEnabledStatus(QLIEIconShowDBMNew, lotd_installed), (!lotd_installed as Bool) as Int)
	AddTextOptionST("show_lotd_found_icon", 		"$qlie_show_lotd_found_icon_text", 		GetCompatibilityEnabledStatus(QLIEIconShowDBMFound, lotd_installed), (!lotd_installed as Bool) as Int)
	AddTextOptionST("show_lotd_disp_icon", 			"$qlie_show_lotd_disp_icon_text", 		GetCompatibilityEnabledStatus(QLIEIconShowDBMDisplayed, lotd_installed), (!lotd_installed as Bool) as Int)
	
	AddEmptyOption()
	AddHeaderOption("$qlie_MiscCompatHeader", 0)
	AddTextOptionST("disable_for_animals", 			"$qlie_disable_for_animals_text", 		GetEnabledStatus(QLIEDisableForAnimals), 0)
	
	SetCursorPosition(1)
	AddHeaderOption("$qlie_CompCompatHeader", 0)
	AddTextOptionST("show_comp_needed_icon", 		"$qlie_show_comp_needed_icon_text", 	GetCompatibilityEnabledStatus(QLIEShowCompNeeded, comp_installed), (!comp_installed as Bool) as Int)
	AddTextOptionST("show_comp_collected_icon", 	"$qlie_show_comp_collected_icon_text", 	GetCompatibilityEnabledStatus(QLIEShowCompCollected, comp_installed), (!comp_installed as Bool) as Int)
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

Function Begin_Config_Save()
	if papyrusutil.GetScriptVersion() > 31
		jsonutil.SetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIECloseInCombat", QLIECloseInCombat as Int)
		jsonutil.SetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIECloseWhenEmpty", QLIECloseWhenEmpty as Int)
		jsonutil.SetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEDispelInvisibility", QLIEDispelInvisibility as Int)
		jsonutil.SetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEOpenWhenContainerUnlocked", QLIEOpenWhenContainerUnlocked as Int)
		jsonutil.SetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEDisableForAnimals", QLIEDisableForAnimals as Int)
		
		jsonutil.SetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEIconShowBookRead", QLIEIconShowBookRead as Int)
		jsonutil.SetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEIconShowEnchanted", QLIEIconShowEnchanted as Int)
		
		jsonutil.SetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEIconShowDBMDisplayed", QLIEIconShowDBMDisplayed as Int)
		jsonutil.SetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEIconShowDBMFound", QLIEIconShowDBMFound as Int)
		jsonutil.SetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEIconShowDBMNew", QLIEIconShowDBMNew as Int)
		
		jsonutil.SetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEShowCompNeeded", QLIEShowCompNeeded as Int)
		jsonutil.SetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEShowCompCollected", QLIEShowCompCollected as Int)
		
		jsonutil.SetPathFloatValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEWindowX", QLIEWindowX)
		jsonutil.SetPathFloatValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEWindowY", QLIEWindowY)
		jsonutil.SetPathFloatValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEWindowW", QLIEWindowW)
		jsonutil.SetPathFloatValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEWindowH", QLIEWindowH)

		jsonutil.Save("../QuickLootIE/Profiles/MCMConfig", false)
		ShowMessage("$qlie_ProfileSaveSuccessMenu")
		ForcePageReset()
	else
		ShowMessage("$qlie_PapUtilError")
		ForcePageReset()
	endIf
EndFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

Function Begin_Config_Load()

	if papyrusutil.GetScriptVersion() > 31
		if jsonutil.JsonExists("../QuickLootIE/Profiles/MCMConfig")
			if !jsonutil.IsGood("../QuickLootIE/Profiles/MCMConfig")
				if IsInMenuMode()
					ShowMessage("$qlie_ProfileLoadDamaged{" + jsonutil.GetErrors("../QuickLootIE/Profiles/MCMConfig") + "}", false, "$qlie_ConfirmY", "$qlie_ConfirmN")
					return
				else
					Notification("$qlie_ProfileLoadCorrupt");
					Begin_Config_Default()
					return 
				endIf
			endIf
			
			QLIECloseInCombat = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIECloseInCombat", QLIECloseInCombat as Int))
			QLIECloseWhenEmpty = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIECloseWhenEmpty", QLIECloseWhenEmpty as Int))
			QLIEDispelInvisibility = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEDispelInvisibility", QLIEDispelInvisibility as Int))
			QLIEOpenWhenContainerUnlocked = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEOpenWhenContainerUnlocked", QLIEOpenWhenContainerUnlocked as Int))
			QLIEDisableForAnimals = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEDisableForAnimals", QLIEDisableForAnimals as Int))
			
			QLIEIconShowBookRead = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEIconShowBookRead", QLIEIconShowBookRead as Int))
			QLIEIconShowEnchanted = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEIconShowEnchanted", QLIEIconShowEnchanted as Int))
			
			QLIEIconShowDBMDisplayed = lotd_installed && (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEIconShowDBMDisplayed", QLIEIconShowDBMDisplayed as Int))
			QLIEIconShowDBMFound = lotd_installed && (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEIconShowDBMFound", QLIEIconShowDBMFound as Int))
			QLIEIconShowDBMNew = lotd_installed && (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEIconShowDBMNew", QLIEIconShowDBMNew as Int))
			
			QLIEShowCompNeeded = comp_installed && (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEShowCompNeeded", QLIEShowCompNeeded as Int))
			QLIEShowCompCollected = comp_installed && (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEShowCompCollected", QLIEShowCompCollected as Int))
			
			QLIEWindowX = jsonutil.GetPathFloatValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEWindowX", QLIEWindowX)
			QLIEWindowY = jsonutil.GetPathFloatValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEWindowY", QLIEWindowY)
			QLIEWindowW = jsonutil.GetPathFloatValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEWindowW", QLIEWindowW)
			QLIEWindowH = jsonutil.GetPathFloatValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEWindowH", QLIEWindowH)
			
			jsonutil.Load("../QuickLootIE/Profiles/MCMConfig")
			if IsInMenuMode()
				ShowMessage("$qlie_ProfileLoadSuccessMenu")
				ForcePageReset()
			endIf
		else
			if IsInMenuMode()
				ShowMessage("$qlie_ProfileLoadMissingMenu")
				ForcePageReset()
			else
				Begin_Config_Default()
			endIf
		endIf
	else
		if IsInMenuMode()
			ShowMessage("$qlie_PapUtilError")
			ForcePageReset()
		endIf
	endIf
EndFunction	

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

function AutoLoadConfig()
	UpdateCompatibilityVariables()
	
	if (papyrusutil.GetScriptVersion() > 31) && (jsonutil.JsonExists("../QuickLootIE/Profiles/MCMConfig")) && (jsonutil.IsGood("../QuickLootIE/Profiles/MCMConfig"))
		QLIECloseInCombat = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIECloseInCombat", QLIECloseInCombat as Int))
		QLIECloseWhenEmpty = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIECloseWhenEmpty", QLIECloseWhenEmpty as Int))
		QLIEDispelInvisibility = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEDispelInvisibility", QLIEDispelInvisibility as Int))
		QLIEOpenWhenContainerUnlocked = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEOpenWhenContainerUnlocked", QLIEOpenWhenContainerUnlocked as Int))
		QLIEDisableForAnimals = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEDisableForAnimals", QLIEDisableForAnimals as Int))
		
		QLIEIconShowBookRead = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEIconShowBookRead", QLIEIconShowBookRead as Int))
		QLIEIconShowEnchanted = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEIconShowEnchanted", QLIEIconShowEnchanted as Int))
		
		if (lotd_installed)
			QLIEIconShowDBMDisplayed = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEIconShowDBMDisplayed", QLIEIconShowDBMDisplayed as Int))
			QLIEIconShowDBMFound = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEIconShowDBMFound", QLIEIconShowDBMFound as Int))
			QLIEIconShowDBMNew = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEIconShowDBMNew", QLIEIconShowDBMNew as Int))
		endIf
		
		if (comp_installed)
			QLIEShowCompNeeded = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEShowCompNeeded", QLIEShowCompNeeded as Int))
			QLIEShowCompCollected = (jsonutil.GetPathIntValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEShowCompCollected", QLIEShowCompCollected as Int))
		endIf
		
		QLIEWindowX = jsonutil.GetPathFloatValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEWindowX", QLIEWindowX)
		QLIEWindowY = jsonutil.GetPathFloatValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEWindowY", QLIEWindowY)
		QLIEWindowW = jsonutil.GetPathFloatValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEWindowW", QLIEWindowW)
		QLIEWindowH = jsonutil.GetPathFloatValue("../QuickLootIE/Profiles/MCMConfig", ".!QLIEWindowH", QLIEWindowH)

		jsonutil.Load("../QuickLootIE/Profiles/MCMConfig")
		Notification("$qlie_ProfileLoadSuccess")
	else
		Begin_Config_Default()
		Notification("$qlie_ProfileLoadMissing")
	endIf
	AutoLoaded = True
	UpdateVariables()
endFunction

;---------------------------------------------------
;-- Functions --------------------------------------
;---------------------------------------------------

Function Begin_Config_Default()

	QLIECloseInCombat = false
	QLIECloseWhenEmpty = true
	QLIEDispelInvisibility = true
	QLIEOpenWhenContainerUnlocked = true
	QLIEDisableForAnimals = false
	
	QLIEIconShowBookRead = true
	QLIEIconShowEnchanted
	
	QLIEIconShowDBMDisplayed = true
	QLIEIconShowDBMFound = true
	QLIEIconShowDBMNew = true
	
	QLIEShowCompNeeded = true
	QLIEShowCompCollected = true
	
	QLIEWindowX = 0.0
	QLIEWindowY = 0.0
	QLIEWindowW = 0.0
	QLIEWindowH = 0.0
	
	if IsInMenuMode()
		ForcePageReset()
	endIf
endFunction

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state ProfileSave
	event OnSelectST()
		SetTitleText("$qlie_SaveProfileTitleText") 
		Begin_Config_Save()
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_SaveProfileTitleInfo")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state ProfileLoad
	event OnSelectST()
		SetTitleText("$qlie_LoadProfileTitleText") 
		Begin_Config_Load()
		UpdateVariables()
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_LoadProfileTitleInfo")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state sort_options_state

	event OnMenuOpenST()
		SetMenuDialogStartIndex(SortOptionsChoice)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(Sort_Options)
	endEvent
					
	event OnMenuAcceptST(Int index)
		SortOptionsChoice = Index
		SetMenuOptionValueST(sort_options_state, Sort_Options[SortOptionsChoice])
		ForcePageReset()
	endEvent

	event OnDefaultST()
		SortOptionsChoice = 0
		SetMenuOptionValueST(sort_options_state, Sort_Options[SortOptionsChoice])
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_sort_options_state_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state sort_presets_state

	event OnMenuOpenST()
		SetMenuDialogStartIndex(Sort_Presets_Choice)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(sort_presets)
	endEvent
					
	event OnMenuAcceptST(Int index)
		Sort_Presets_Choice = Index
		
		if Sort_Presets_Choice > 0
			load_preset()
		endif

		SetMenuOptionValueST(sort_presets_state, sort_presets[Sort_Presets_Choice])
		ForcePageReset()
	endEvent

	event OnDefaultST()
		Sort_Presets_Choice = 0
		BuildSortOptions(true)
		SetMenuOptionValueST(sort_presets_state, sort_presets[Sort_Presets_Choice])
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_sort_presets_state_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state sort_options_reset

	event OnSelectST()
		BuildSortOptions(true)
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_sort_options_reset_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state sort_options_insert
	event OnSelectST()
		InsertSortOption()
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_sort_options_insert_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state close_in_combat

	event OnSelectST()
		QLIECloseInCombat = !QLIECloseInCombat
		SetTextOptionValueST(GetEnabledStatus(QLIECloseInCombat))
	endEvent
	
	event OnDefaultST()
		QLIECloseInCombat = True
		SetTextOptionValueST(GetEnabledStatus(QLIECloseInCombat))
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_close_in_combat_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state close_when_empty

	event OnSelectST()
		QLIECloseWhenEmpty = !QLIECloseWhenEmpty
		SetTextOptionValueST(GetEnabledStatus(QLIECloseWhenEmpty))
	endEvent
	
	event OnDefaultST()
		QLIECloseWhenEmpty = True
		SetTextOptionValueST(GetEnabledStatus(QLIECloseWhenEmpty))
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_close_when_empty_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state dispel_invis

	event OnSelectST()
		QLIEDispelInvisibility = !QLIEDispelInvisibility
		SetTextOptionValueST(GetEnabledStatus(QLIEDispelInvisibility))
	endEvent
	
	event OnDefaultST()
		QLIEDispelInvisibility = True
		SetTextOptionValueST(GetEnabledStatus(QLIEDispelInvisibility))
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_dispel_invis_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state open_when_container_unlocked

	event OnSelectST()
		QLIEOpenWhenContainerUnlocked = !QLIEOpenWhenContainerUnlocked
		SetTextOptionValueST(GetEnabledStatus(QLIEOpenWhenContainerUnlocked))
	endEvent
	
	event OnDefaultST()
		QLIEOpenWhenContainerUnlocked = True
		SetTextOptionValueST(GetEnabledStatus(QLIEOpenWhenContainerUnlocked))
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_open_when_container_unlocked_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state disable_for_animals

	event OnSelectST()
		QLIEDisableForAnimals = !QLIEDisableForAnimals
		SetTextOptionValueST(GetEnabledStatus(QLIEDisableForAnimals))
	endEvent
	
	event OnDefaultST()
		QLIEDisableForAnimals = True
		SetTextOptionValueST(GetEnabledStatus(QLIEDisableForAnimals))
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_disable_for_animals_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state window_X
	event OnSliderAcceptST(Float value)
		QLIEWindowX = value
		self.SetSliderOptionValueST(value, "{0}", false, "")
    endEvent

	event OnSliderOpenST()
		self.SetSliderDialogStartValue(QLIEWindowX)
		self.SetSliderDialogDefaultValue(0 as Float)
		self.SetSliderDialogRange(0 as Float, 5000 as Float)
		self.SetSliderDialogInterval(1 as Float)
	endEvent

	event OnDefaultST()
		QLIEWindowX = 0
		self.SetSliderOptionValueST(0 as Float, "{0}", false, "")
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_window_X_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state window_Y
	event OnSliderAcceptST(Float value)
		QLIEWindowY = value
		self.SetSliderOptionValueST(value, "{0}", false, "")
    endEvent

	event OnSliderOpenST()
		self.SetSliderDialogStartValue(QLIEWindowY)
		self.SetSliderDialogDefaultValue(0 as Float)
		self.SetSliderDialogRange(0 as Float, 5000 as Float)
		self.SetSliderDialogInterval(1 as Float)
	endEvent

	event OnDefaultST()
		QLIEWindowY = 0
		self.SetSliderOptionValueST(0 as Float, "{0}", false, "")
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_window_Y_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state window_W
	event OnSliderAcceptST(Float value)
		QLIEWindowW = value
		self.SetSliderOptionValueST(value, "{0}", false, "")
    endEvent

	event OnSliderOpenST()
		self.SetSliderDialogStartValue(QLIEWindowW)
		self.SetSliderDialogDefaultValue(0 as Float)
		self.SetSliderDialogRange(0 as Float, 5000 as Float)
		self.SetSliderDialogInterval(1 as Float)
	endEvent

	event OnDefaultST()
		QLIEWindowW = 0
		self.SetSliderOptionValueST(0 as Float, "{0}", false, "")
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_window_W_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state window_H
	event OnSliderAcceptST(Float value)
		QLIEWindowH = value
		self.SetSliderOptionValueST(value, "{0}", false, "")
    endEvent

	event OnSliderOpenST()
		self.SetSliderDialogStartValue(QLIEWindowH)
		self.SetSliderDialogDefaultValue(0 as Float)
		self.SetSliderDialogRange(0 as Float, 5000 as Float)
		self.SetSliderDialogInterval(1 as Float)
	endEvent

	event OnDefaultST()
		QLIEWindowH = 0
		self.SetSliderOptionValueST(0 as Float, "{0}", false, "")
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_window_H_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state show_book_read_icon

	event OnSelectST()
		QLIEIconShowBookRead = !QLIEIconShowBookRead
		SetTextOptionValueST(GetEnabledStatus(QLIEIconShowBookRead))
	endEvent
	
	event OnDefaultST()
		QLIEIconShowBookRead = True
		SetTextOptionValueST(GetEnabledStatus(QLIEIconShowBookRead))
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_show_book_read_icon_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state show_enchanted_icon

	event OnSelectST()
		QLIEIconShowEnchanted = !QLIEIconShowEnchanted
		SetTextOptionValueST(GetEnabledStatus(QLIEIconShowEnchanted))
	endEvent
	
	event OnDefaultST()
		QLIEIconShowEnchanted = True
		SetTextOptionValueST(GetEnabledStatus(QLIEIconShowEnchanted))
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_show_enchanted_icon_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state show_lotd_disp_icon

	event OnSelectST()
		QLIEIconShowDBMDisplayed = !QLIEIconShowDBMDisplayed
		SetTextOptionValueST(GetEnabledStatus(QLIEIconShowDBMDisplayed))
	endEvent
	
	event OnDefaultST()
		QLIEIconShowDBMDisplayed = True
		SetTextOptionValueST(GetEnabledStatus(QLIEIconShowDBMDisplayed))
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_show_lotd_disp_icon_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state show_lotd_found_icon

	event OnSelectST()
		QLIEIconShowDBMFound = !QLIEIconShowDBMFound
		SetTextOptionValueST(GetEnabledStatus(QLIEIconShowDBMFound))
	endEvent
	
	event OnDefaultST()
		QLIEIconShowDBMFound = True
		SetTextOptionValueST(GetEnabledStatus(QLIEIconShowDBMFound))
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_show_lotd_found_icon_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state show_lotd_new_icon

	event OnSelectST()
		QLIEIconShowDBMNew = !QLIEIconShowDBMNew
		SetTextOptionValueST(GetEnabledStatus(QLIEIconShowDBMNew))
	endEvent
	
	event OnDefaultST()
		QLIEIconShowDBMNew = True
		SetTextOptionValueST(GetEnabledStatus(QLIEIconShowDBMNew))
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_show_lotd_new_icon_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state show_comp_needed_icon

	event OnSelectST()
		QLIEShowCompNeeded = !QLIEShowCompNeeded
		SetTextOptionValueST(GetEnabledStatus(QLIEShowCompNeeded))
	endEvent
	
	event OnDefaultST()
		QLIEShowCompNeeded = True
		SetTextOptionValueST(GetEnabledStatus(QLIEShowCompNeeded))
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_show_comp_needed_icon_info")
	endEvent
endState

;---------------------------------------------------
;-- States -----------------------------------------
;---------------------------------------------------

state show_comp_collected_icon

	event OnSelectST()
		QLIEShowCompCollected = !QLIEShowCompCollected
		SetTextOptionValueST(GetEnabledStatus(QLIEShowCompCollected))
	endEvent
	
	event OnDefaultST()
		QLIEShowCompCollected = True
		SetTextOptionValueST(GetEnabledStatus(QLIEShowCompCollected))
	endEvent

	event OnHighlightST()
		SetInfoText("$qlie_show_comp_collected_icon_info")
	endEvent
endState
