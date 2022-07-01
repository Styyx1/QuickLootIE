scriptname RN_Utility_MCM extends SKI_ConfigBase Conditional

import AhzmoreHUD
import AhzmoreHUDIE
import RN_Utility_Global

import utility
import debug

RN_Utility_Script property Util auto
RN_Main_Armory property _AddItemArmory auto
RN_Main_Museum_HOHLIB property _AddItemMain_1 auto
RN_Main_Museum_EEHMISC property _AddItemMain_2 auto
RN_Main_SupportedMods property _AddItemPatches auto
RN_Achivement_Script_Master property AchMaster auto
RN_PatchAPI property API auto
TCC_IconSetScript property IconScript auto
RN_Utility_Cache property MCMCache auto

;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;----------------------------------------------------------------------------- General Properties -------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;; String Returns
string[] PagesList

bool property advdebug auto hidden
bool Token_Vis conditional

bool Ach_Highlight
bool Property Ach_Perks auto hidden

Bool Page1
Bool Page2
Bool Page3
Bool Page4
Bool Page5
Bool Page6
Bool Page7
Bool Page8
Bool Page9
Bool Page10

;; General Globals
globalvariable property DBM_SortWait auto
globalvariable property RN_Setup_Start auto
globalvariable property RN_Setup_Finish auto

globalvariable property RN_Scan_Done auto
globalvariable property RN_Scan_Registered auto

;; Player Ref for Game.GetPlayer()
objectreference property PlayerRef auto

;; moreHUD
formlist property dbmNew auto
formlist property dbmDisp auto
formlist property dbmFound auto
formlist property dbmMaster auto

string[] moreHUDChoiceList 
int property IndexmoreHUD auto hidden
int moreHUDOptions

string[] moreHUDInventoryChoiceList 
int property IndexmoreHUDInventory auto hidden
int moreHUDInventoryOptions

string[] AchievementSoundList
int property IndexSounds auto hidden
int SoundListOptions

string[] AttributeList
int property IndexAttribute auto hidden
int AttributeListOptions

string[] TransferList
int property IndexTransfer auto hidden
int TransferListOptions

string[] CacheList
int IndexCache = 0
int CacheListOptions

objectreference property NotificationColour Auto
referenceAlias Property ColourAlias auto
int property IndexColour = 16777215 auto hidden
string property ColourString = "00FFFFFF" auto hidden
string[] HexDigits

;; bool Properties
bool property ShowMuseumVal = true auto hidden
bool property ShowArmoryVal = true auto hidden
bool property ShowModsVal = true auto hidden
bool property ShowSetCompleteVal = true auto hidden
bool property ShowListenerVal = true auto hidden
bool property Restricted auto hidden
bool property ShowStartup = true auto hidden

bool property Ach_Notify = true auto hidden
bool property Ach_Visual = true auto hidden

globalvariable property AchHealth auto
globalvariable property AchStamina auto
globalvariable property AchMagicka auto
globalvariable property AchSpeech auto
globalvariable property TokenRefList_NoShipmentSize auto

;; Globals for Complete Set Listings.
globalvariable property RN_SupportedModCount auto
globalvariable property RN_CustomModCount auto
globalvariable property RN_CreationClubContent_Installed auto

;; Treasury Globals
globalvariable property RN_Treasury_Count auto
globalvariable property RN_Treasury_Count2 auto
globalvariable property RN_Treasury_Count3 auto

Formlist property _Museum_Global_Complete auto
Formlist property _Museum_Global_Count auto
Formlist property _Museum_Global_Total auto
GlobalVariable[] RN_Museum_Global_Complete 
GlobalVariable[] RN_Museum_Global_Count 
GlobalVariable[] RN_Museum_Global_Total 
String[] _Museum_Section_names
String[] _Museum_Section_States

Formlist property _Armory_Global_Complete auto
Formlist property _Armory_Global_Count auto
Formlist property _Armory_Global_Total auto
Formlist property _Armory_Formlist_Items_Tracking auto
Formlist property _Armory_Formlist_Displays_Tracking auto
GlobalVariable[] RN_Armory_Global_Complete
GlobalVariable[] RN_Armory_Global_Count
GlobalVariable[] RN_Armory_Global_Total
Int[] _Armory_Section_Position
String[] _Armory_Section_names

;Achievements
globalvariable property RN_Achievements_Listener_Count auto
formlist property RN_Achievement_Globals auto
globalvariable[] RN_Ach_Globals
string[] RN_Ach_Highlight
string[] RN_Ach_AchName
int[] RN_Ach_Position

globalvariable property RN_ComAchievements_Listener_Count auto
formlist property RN_ComAchievement_Globals auto
globalvariable[] RN_ComAch_Globals
string[] RN_ComAch_Highlight
string[] RN_ComAch_AchName
int[] RN_ComAch_Position

;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;------------------------------------------------------------------------------ Patches -----------------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

GlobalVariable[] RN_Patches_Complete_Array
GlobalVariable[] RN_Patches_Count_Array
GlobalVariable[] RN_Patches_Total_Array
Quest[] RN_Patches_Quests_Array
Int[] RN_Patches_Position_Array
String[] RN_Patches_Name

GlobalVariable[] RN_Custom_Complete_Array
GlobalVariable[] RN_Custom_Count_Array
GlobalVariable[] RN_Custom_Total_Array
Quest[] RN_Custom_Quests_Array
Int[] RN_Custom_Position_Array
String[] RN_Custom_Name

GlobalVariable[] RN_Section_Complete_Array
GlobalVariable[] RN_Section_Count_Array
GlobalVariable[] RN_Section_Total_Array
Formlist RN_Section_DisplaysList
Formlist RN_Section_ItemsList
String[] RN_Section_Name
Int[] RN_Section_Position_Array
Int Index_Section

GlobalVariable[] RN_Section2_Complete_Array
GlobalVariable[] RN_Section2_Count_Array
GlobalVariable[] RN_Section2_Total_Array
Formlist RN_Section2_DisplaysList
Formlist RN_Section2_ItemsList
String[] RN_Section2_Name
Int[] RN_Section2_Position_Array
Int Index_Section2

Quest TrackedQuest
String TrackedPatch

Bool property CacheArmory auto hidden
Bool property CacheDaedricGallery auto hidden
Bool property CacheDragonbornhall auto hidden
Bool property CacheGuildhouse auto hidden
Bool property CacheHallofHeroes auto hidden
Bool property CacheHallofLostEmpires auto hidden
Bool property CacheHallofOddities auto hidden
Bool property CacheHallofSecrets auto hidden
Bool property CacheHallofWonders auto hidden
Bool property CacheLibrary auto hidden
Bool property CacheMisc auto hidden
Bool property CacheNaturalScience auto hidden
Bool property CacheSafehouse auto hidden
Bool property CacheStoreroom auto hidden

Int CacheArmoryPages
Int CacheDaedricGalleryPages
Int CacheDragonbornhallPages
Int CacheGuildhousePages
Int CacheHallofHeroesPages
Int CacheHallofLostEmpiresPages
Int CacheHallofOdditiesPages
Int CacheHallofSecretsPages
Int CacheHallofWondersPages
Int CacheLibraryPages
Int CacheMiscPages
Int CacheNaturalSciencePages
Int CacheSafehousePages
Int CacheStoreroomPages

ObjectReference[] Property TrackedDisplays Auto Hidden
ObjectReference[] Property  TrackedDisplays2 Auto Hidden
ObjectReference[] Property  TrackedDisplays3 Auto Hidden
ObjectReference[] Property  TrackedDisplays4 Auto Hidden
ObjectReference[] Property  TrackedDisplays5 Auto Hidden
ObjectReference[] Property  TrackedDisplays6 Auto Hidden
ObjectReference[] Property  TrackedDisplays7 Auto Hidden
ObjectReference[] Property  TrackedDisplays8 Auto Hidden
ObjectReference[] Property  TrackedDisplays9 Auto Hidden
ObjectReference[] Property  TrackedDisplays10 Auto Hidden

String[] Property  TrackedNames Auto Hidden
String[] Property  TrackedNames2 Auto Hidden
String[] Property  TrackedNames3 Auto Hidden
String[] Property  TrackedNames4 Auto Hidden
String[] Property  TrackedNames5 Auto Hidden
String[] Property  TrackedNames6 Auto Hidden
String[] Property  TrackedNames7 Auto Hidden
String[] Property  TrackedNames8 Auto Hidden
String[] Property  TrackedNames9 Auto Hidden
String[] Property  TrackedNames10 Auto Hidden

ObjectReference[] CustomContainerRef
Int[] CustomContainerPos

ObjectReference TCC_HEADER_TO_REPLACE

ObjectReference[] TempDispArray
String[] TempNameArray

Bool HEADERSREQUIRED
Int PagesRequired

Int SetVal
Int SetVal2
Int SetVal3
	
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------- Script Start ---------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Event OnConfigInit()

	AddDynamicPagesList()	
EndEvent

;-- Events --------------------------------

Event AddDynamicPagesList()

	ModName = "LOTD: The Curators Companion"
	PagesList = new String[128]
	PagesList[0] = "General Settings"
	PagesList[1] = "Advanced Settings"
	PagesList[2] = "Achievements"
	PagesList[3] = " "
	PagesList[4] = "~~ Completion ~~"
	PagesList[5] = "Museum Sections"
	PagesList[6] = "Armoury Sets"
	PagesList[7] = "Official Patches"		

	Int Q = 0
	Int x = 8

	if RN_CustomModCount.GetValue()
		Q = PagesList.Find("")	
			PagesList[Q] = "Custom Patches"
		x += 1
	endif

	Q = PagesList.Find("")	
		PagesList[Q] = " "
	x += 1	

	Q = PagesList.Find("")	
		PagesList[Q] = "~~ Display Tracking ~~"
	x += 1	
	
	Q = PagesList.Find("")	
		PagesList[Q] = "Display Tracker (1)"
	x += 1
	
	if Page2
		Q = PagesList.Find("")	
			PagesList[Q] = "Display Tracker (2)"
		x += 1
	endif
	
	if Page3
		Q = PagesList.Find("")	
			PagesList[Q] = "Display Tracker (3)"
		x += 1
	endif
	
	if Page4
		Q = PagesList.Find("")	
			PagesList[Q] = "Display Tracker (4)"
		x += 1
	endif
	
	if Page5
		Q = PagesList.Find("")	
			PagesList[Q] = "Display Tracker (5)"
		x += 1
	endif

	if Page6
		Q = PagesList.Find("")	
			PagesList[Q] = "Display Tracker (6)"
		x += 1
	endif

	if Page7
		Q = PagesList.Find("")	
			PagesList[Q] = "Display Tracker (7)"
		x += 1
	endif
	
	if Page8
		Q = PagesList.Find("")	
			PagesList[Q] = "Display Tracker (8)"
		x += 1
	endif
	
	if Page9
		Q = PagesList.Find("")	
			PagesList[Q] = "Display Tracker (9)"
		x += 1
	endif
	
	if Page10
		Q = PagesList.Find("")	
			PagesList[Q] = "Display Tracker (10)"
		x += 1
	endif

	Q = PagesList.Find("")	
		PagesList[Q] = " "
	x += 1	
		
	Q = PagesList.Find("")	
		PagesList[Q] = "Debug Options"
	x += 1
	
  Pages = Utility.CreateStringArray(x)
  Int index = x
  While index >= 1
    index -= 1 
    Pages[index] = PagesList[index]  
  EndWhile
EndEvent	

;-- Events --------------------------------

Event OnPageReset(string page)

	if page == ""
		LoadCustomContent("TCC/CuratorSplash.swf", 50, -32)
	else
		UnloadCustomContent()
	endif
		
	AddDynamicPagesList()
	AddSettingsPage()
	AddAdvancedPage()
	AddAchievementsPage()
	AddMuseumSetsPage()
	AddArmorySetsPage()
	AddCompletedModsPage()
	AddCustomModsPage()
	AddDebugPage()
	AddTrackingPage()
	AddTrackingPage2()
	AddTrackingPage3()
	AddTrackingPage4()
	AddTrackingPage5()
	AddTrackingPage6()
	AddTrackingPage7()
	AddTrackingPage8()
	AddTrackingPage9()
	AddTrackingPage10()
	InitmoreHUDChoiceList()
	InitAchievementSoundList()
	InitAttributeList()
	InitTransferList()
	InitCacheList()
EndEvent

;-- Events --------------------------------

Function InitmoreHUDChoiceList()

	moreHUDChoiceList = new string[5]
	moreHUDChoiceList[0] = "Show All Icons"
	moreHUDChoiceList[1] = "Show New Icons"
	moreHUDChoiceList[2] = "Show Found Icons"
	moreHUDChoiceList[3] = "Show Displayed Icons"
	moreHUDChoiceList[4] = "Hide All Icons"

	moreHUDInventoryChoiceList = new string[5]
	moreHUDInventoryChoiceList[0] = "Show All Icons"
	moreHUDInventoryChoiceList[1] = "Show New Icons"
	moreHUDInventoryChoiceList[2] = "Show Found Icons"
	moreHUDInventoryChoiceList[3] = "Show Displayed Icons"
	moreHUDInventoryChoiceList[4] = "Hide All Icons"
EndFunction

;-- Events --------------------------------

Function InitAchievementSoundList()

	AchievementSoundList = new string[4]
	AchievementSoundList[0] = "Default Sound FX"
	AchievementSoundList[1] = "Crowd Cheer FX"
	AchievementSoundList[2] = "Brass Triumph FX"
	AchievementSoundList[3] = "No Sound FX"
EndFunction

;-- Events --------------------------------

Function InitAttributeList()

	AttributeList = new string[5]
	AttributeList[0] = "No Attribute Reward"
	AttributeList[1] = "Increase Magicka"
	AttributeList[2] = "Increase Health"
	AttributeList[3] = "Increase Stamina"
	AttributeList[4] = "Random Attribute"
EndFunction

;-- Events --------------------------------

Function InitTransferList()

	TransferList = new string[3]
	TransferList[0] = "All Storage"
	TransferList[1] = "Relic Storage Container"
	TransferList[2] = "Custom Storage Only"
EndFunction

;-- Events --------------------------------

Function InitCacheList()

	CacheList = new string[15]
	CacheList[0] = " "
	CacheList[1] = "Armoury"
	CacheList[2] = "Daedric Gallery"
	CacheList[3] = "Dragonborn Hall"
	CacheList[4] = "Guildhouse"
	CacheList[5] = "Hall of Heroes"
	CacheList[6] = "Hall of Lost Empires"
	CacheList[7] = "Hall of Oddities"
	CacheList[8] = "Hall of Secrets"
	CacheList[9] = "Hall of Wonders"
	CacheList[10] = "Library"
	CacheList[11] = "Natural Science"
	CacheList[12] = "Safehouse"
	CacheList[13] = "Storeroom"
	CacheList[14] = "Miscellaneous"
EndFunction
		
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;----------------------------------------------------------------------------- Settings Page ------------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
Function AddSettingsPage()

	if CurrentPage == "General Settings"
		SetCursorFillMode(TOP_TO_BOTTOM)
		
		SetCursorPosition(0)
		AddHeaderOption("Notification Settings:")
		
		AddTextOptionST("iRelicMuseumNotifications", "Museum Items:", GetDefaultOnOff(ShowMuseumVal), 0)
		AddTextOptionST("iRelicArmoryNotifications", "Armoury Items:", GetDefaultOnOff(ShowArmoryVal), 0)	
		AddTextOptionST("iRelicModsNotifications", "Patch(es) Items:", GetDefaultOnOff(ShowModsVal), 0)
		AddTextOptionST("iRelicListenerNotifications", "Listeners:", GetDefaultOnOff(ShowListenerVal), 0)
		AddTextOptionST("iRelicSetCompleteNotifications", "Set Completion:", GetDefaultOnOff(ShowSetCompleteVal), 0)
			
		AddEmptyOption()		
		AddHeaderOption("General Settings:")
		AddTextOptionST("iRelicShowStartup", "Startup Notifications:", GetDefaultStartup(ShowStartup), 0)	
		AddTextOptionST("RefreshMCM", "Something not working?", "Reload MCM", 0)
		AddTextOptionST("Config_Default", "Restore Defaults", "Restore", 0)	
		
		SetCursorPosition(1)			
		AddHeaderOption("Mod Info:")
		
		AddTextOption("Thanks for downloading The Curators Companion.", "", 0)
		AddTextOption("Please read the information on the Nexus page", "", 0)
		AddTextOption("to get familiar with all the features.", "", 0)
		AddEmptyOption()
		AddTextOption("", "Developed By [Ic0n]Ic0de - Version 6.0.1", 0)
		
		AddEmptyOption()
		AddHeaderOption("Profile Settings:")
		AddTextOptionST("SaveConfig_JSON", "JSON - User Profile", GetConfigSaveString(), 0)
		AddTextOptionST("LoadConfig_JSON", "JSON - User Profile", GetConfigLoadString(), 0)
		AddTextOptionST("Config_Author", "Developers Preset", "Load Preset", 0)	
	endif
endFunction

;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;----------------------------------------------------------------------------- Settings Page ------------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
Function AddAdvancedPage()

	if CurrentPage == "Advanced Settings"
		
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)
		
		AddHeaderOption("General Notification Colours:")
		
		AddColorOptionST("NotificationColourOptions", "Set Notification Colour:", IndexColour, 0)
		AddEmptyOption()
		
		AddHeaderOption("moreHUD Settings:")
		
		if SKSE.GetPluginVersion("Ahzaab's moreHUD Plugin") >= 30800
			AddMenuOptionST("moreHUDOptions", "moreHUD Main HUD:", moreHUDChoiceList[IndexmoreHUD])	
		else
			AddtextOption("moreHUD Main HUD:", "<font color='#750e0e'>moreHUD Not Found</font>")
		endif		
		
		
		if SKSE.GetPluginVersion("Ahzaab's moreHUD Inventory Plugin") >= 10017
			AddMenuOptionST("moreHUDInventoryOptions", "moreHUD Inventory:", moreHUDInventoryChoiceList[IndexmoreHUDInventory])	
		else
			AddtextOption("moreHUD Inventory:", "<font color='#750e0e'>moreHUD Inventory Not Found</font>")
		endif			
		
		AddEmptyOption()

		AddHeaderOption("Relic Storage Settings:")
		
		AddTextOptionST("iRelicRestrictionOptions", "Relic Storage Restriction:" , GetDefaultOnOff(Restricted), 0)
		AddTextOptionST("Token_Visibility", "Storage Token Recipe:", GetDefaultOnOff(Token_Vis), 0)
		AddMenuOptionST("TransferListOptions", "Transfer Station:", TransferList[IndexTransfer])
		
		SetCursorPosition(1)
		AddHeaderOption("Custom Storage Containers: (" +  TokenRefList_NoShipmentSize.GetValue() as Int + "/10)")
		
		CustomContainerRef = new ObjectReference[128]
		CustomContainerPos = new Int[128]
		ObjectReference RefToShow
		String RefToShowlocation
		Int Index = 0 
		Int Count = 0
		
		While Index < API.TokenRefList_NoShipment.length
			RefToShow = API.TokenRefList_NoShipment[Index] as ObjectReference	
			if RefToShow
				CustomContainerRef[Index] = RefToShow
				RefToShowlocation = RefToShow.GetCurrentLocation().GetName()
				if !RefToShowlocation
					RefToShowlocation = RefToShow.GetparentCell().GetName()
					if !RefToShowlocation
						RefToShowlocation = "Unknown Location"
					endif
				endif
				
				CustomContainerPos[Index] = AddTextOption("<font color='#070091'>" + RefToShow.GetDisplayName()+ "</font>", RefToShowlocation, 0)
				Count += 1
			endif
			
			Index += 1
		endWhile
		
		if (Count == 0)
			AddTextOption("No Custom Containers Found", "", 1)
		endif
	endif
endFunction

;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;----------------------------------------------------------------------------- Settings Page ------------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
Function AddAchievementsPage()

	if CurrentPage == "Achievements"
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)
			
		AddHeaderOption("Settings:")	
		AddToggleOptionST("AchievementSet01", "Notifications:", Ach_Notify, 0)
		AddToggleOptionST("AchievementSet02", "Visual effect:", Ach_Visual, 0)
		AddMenuOptionST("SoundListOptions", "Sound effect:", AchievementSoundList[IndexSounds])
		AddHeaderOption("Achievements:")	

		SetCursorPosition(1)			
		AddHeaderOption("")	
		
		AddToggleOptionST("Enable_Highlights", "Achievement Descriptions:", Ach_Highlight, 0)
		AddToggleOptionST("Disable_AchievementPerks", "Reward Perk Points:", Ach_Perks, 0)			
		AddMenuOptionST("AttributeListOptions", "Reward Attribute:", AttributeList[IndexAttribute])
		
		AddHeaderOption("Awarded: " + GetCurrentAchievementCount(RN_Achievements_Listener_Count, RN_Achievement_Globals) + " Achievements")
		
		Int PageIdx = 9			
		Int Index = 0
		While Index < RN_Ach_Globals.length
			SetCursorPosition(PageIdx + 1)
			if RN_Ach_Globals[Index] != none
				if RN_Ach_Globals[Index].GetValue()
					if Index == 29
						RN_Ach_Position[Index] = AddTextOption("<font color='#070091'>" + (RN_Ach_AchName[Index] + PlayerRef.GetBaseObject().GetName()) + "</font>", "<font color='#070091'>Awarded</font>", 0)
						PageIdx += 1
					else
						RN_Ach_Position[Index] = AddTextOption("<font color='#070091'>" + RN_Ach_AchName[Index] + "</font>", "<font color='#070091'>Awarded</font>", 0)
						PageIdx += 1
					endif
				else
					if Index == 29
						RN_Ach_Position[Index] = AddTextOption(RN_Ach_AchName[Index] + PlayerRef.GetBaseObject().GetName(), "Locked", 1)
						PageIdx += 1
					else
						RN_Ach_Position[Index] = AddTextOption(RN_Ach_AchName[Index], "Locked", 1)
						PageIdx += 1
					endif					
				endif
			endif
			Index +=1		
		endWhile
		
		SetCursorPosition(PageIdx + 1)
		AddHeaderOption("Community Achievements:")
		PageIdx += 1
		SetCursorPosition(PageIdx + 1) 
		AddHeaderOption("Awarded: " + GetCurrentAchievementCount(RN_ComAchievements_Listener_Count, RN_ComAchievement_Globals) + " Community Achievements")
		PageIdx += 1
		Index = 0
		While Index < RN_ComAch_Globals.length
			SetCursorPosition(PageIdx + 1)
			if RN_ComAch_Globals[Index] != none
				if RN_ComAch_Globals[Index].GetValue()
					RN_ComAch_Position[Index] = AddTextOption("<font color='#070091'>" + RN_ComAch_AchName[Index] + "</font>", "<font color='#070091'>Awarded</font>", 0)
					PageIdx += 1
				else
					RN_ComAch_Position[Index] = AddTextOption(RN_ComAch_AchName[Index], "Locked", 1)
					PageIdx += 1				
				endif
			endif
			Index +=1		
		endWhile
	endif
endFunction

;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;------------------------------------------------------------------------------ Museum Page -------------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
Function AddMuseumSetsPage()

	if CurrentPage == "Museum Sections"
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)	
		AddHeaderOption("Museum Sections:")	
		SetCursorPosition(1)
		AddHeaderOption("Displayed: " + (GetPrimaryDisplayCount()))
		Int PageIdx = 1	
		
		Int Index = 0
		Int ArraySize = RN_Museum_Global_Complete.length
		While Index < ArraySize			
			SetCursorPosition(PageIdx + 1)
			if RN_Museum_Global_Complete[Index] != none
				if Index == 8 && !RN_CreationClubContent_Installed.GetValue()
					AddTextOption(_Museum_Section_names[Index], "No Creations Installed", 1)
					PageIdx += 1
				elseif RN_Museum_Global_Complete[Index].GetValue()
					AddTextOption(_Museum_Section_names[Index], GetCurrentCount(RN_Museum_Global_Count[Index] , RN_Museum_Global_Total[Index]) + " (Complete)", 1)
					PageIdx += 1
				elseif RN_Scan_Registered.GetValue()
					AddTextOption(_Museum_Section_names[Index], "Updating...", 1)
					PageIdx += 1
				else
					AddTextOptionST(_Museum_Section_States[Index], _Museum_Section_names[Index], GetCurrentCount(RN_Museum_Global_Count[Index] , RN_Museum_Global_Total[Index]), 0)
					PageIdx += 1
				endif
			endif
			Index += 1
		endWhile
		
		SetCursorPosition(16)
		AddEmptyOption()
		SetCursorPosition(18)
		AddHeaderOption("Treasury Value:")
		SetCursorPosition(19)
		AddHeaderOption("")
		PageIdx = 19
		
		SetCursorPosition(PageIdx + 1)
		AddTextOption("Safehouse Treasury Value:", RN_Treasury_Count.GetValue() as Int, 0)
		PageIdx += 1
		SetCursorPosition(PageIdx + 1)
		AddTextOption("Deepholme Treasury Value:", RN_Treasury_Count2.GetValue() as Int, 0)
		PageIdx += 1
		SetCursorPosition(PageIdx + 1)
		AddTextOption("Karagas' Tower Treasury Value:", RN_Treasury_Count3.GetValue() as Int, 0)
		PageIdx += 1
		SetCursorPosition(PageIdx + 1)
		AddTextOption("<font color='#070091'>Total Value:", GetTotalTreasuryValue(RN_Treasury_Count, RN_Treasury_Count2, RN_Treasury_Count3) + "</font>", 0)
	endif
endFunction

;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;------------------------------------------------------------------------------ Armoury Page ------------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Function AddArmorySetsPage()

	if CurrentPage == "Armoury Sets"
		SetVal = BuildTotalsArray(SetVal, RN_Armory_Global_Complete)
		SetVal2 = BuildTotalsArray(SetVal2, RN_Section_Complete_Array)
		SetVal3 = BuildTotalsArray(SetVal3, RN_Section2_Complete_Array)
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)
		
		AddHeaderOption("Armoury Sets:")
		SetCursorPosition(1)
		AddHeaderOption("Completed: " + GetCurrentArmoryCount(SetVal) + " Sets")
		Int PageIdx = 1	
		Int Index = 0
		Int ArraySize = RN_Armory_Global_Complete.length
		While Index < ArraySize 
			SetCursorPosition(PageIdx + 1)
			if RN_Armory_Global_Complete[Index].GetValue()
				AddTextOption(_Armory_Section_names[Index], GetCurrentCount(RN_Armory_Global_Count[Index], RN_Armory_Global_Total[Index]) + " (Complete)", 1)
				PageIdx += 1
			elseif RN_Scan_Registered.GetValue()
				AddTextOption(_Armory_Section_names[Index], "Updating...", 1)
				PageIdx += 1
			else
				_Armory_Section_Position[Index] = AddTextOption(_Armory_Section_names[Index], GetCurrentCount(RN_Armory_Global_Count[Index], RN_Armory_Global_Total[Index]), 0)
				PageIdx += 1
			endif
			Index +=1
		endWhile
		
		PageIdx += 2
		SetCursorPosition(PageIdx + 1)

		if (Game.GetModByName("LOTD_TCC_ImmWeap.esp") != 255)
			AddHeaderOption("Immersive Weapons Sets:")
			PageIdx += 1
			SetCursorPosition(PageIdx + 1)
			AddHeaderOption("Completed: " + GetCurrentIWCount(SetVal3) + " Sets")
			PageIdx	+= 1
			Index = 0
			ArraySize = Index_Section2
			While Index < ArraySize 
				SetCursorPosition(PageIdx + 1)
				if RN_Section2_Name[Index] != ""				
					if RN_Section2_Complete_Array[Index].GetValue()
						AddTextOption(RN_Section2_Name[Index], GetCurrentCount(RN_Section2_Count_Array[Index], RN_Section2_Total_Array[Index]) + " (Complete)", 1)
						PageIdx += 1
					elseif RN_Scan_Registered.GetValue()
						AddTextOption(RN_Section2_Name[Index], "Updating...", 1)
						PageIdx += 1
					else
						RN_Section2_Position_Array[Index] = AddTextOption(RN_Section2_Name[Index], GetCurrentCount(RN_Section2_Count_Array[Index], RN_Section2_Total_Array[Index]), 0)
						PageIdx += 1
					endif
				endif
				Index +=1
			endWhile
			PageIdx += 2
			SetCursorPosition(PageIdx + 1)
		endif
		
		if (Game.GetModByName("LOTD_TCC_HeavyArm.esp") != 255)
			AddHeaderOption("Heavy Armoury Sets:")
			PageIdx += 1
			SetCursorPosition(PageIdx + 1)
			AddHeaderOption("Completed: " + GetCurrentHACount(SetVal2) + " Sets")
			PageIdx	+= 1		
			Index = 0
			ArraySize = Index_Section
			While Index < ArraySize 
				SetCursorPosition(PageIdx + 1)
				if RN_Section_Name[Index] != ""
					if RN_Section_Complete_Array[Index].GetValue()
						AddTextOption(RN_Section_Name[Index], GetCurrentCount(RN_Section_Count_Array[Index], RN_Section_Total_Array[Index]) + " (Complete)", 1)
						PageIdx += 1
					elseif RN_Scan_Registered.GetValue()
						AddTextOption(RN_Section_Name[Index], "Updating...", 1)
						PageIdx += 1
					else
						RN_Section_Position_Array[Index] = AddTextOption(RN_Section_Name[Index], GetCurrentCount(RN_Section_Count_Array[Index], RN_Section_Total_Array[Index]), 0)
						PageIdx += 1
					endif
				endif
				Index +=1
			endWhile
		endif
	endif
endFunction	

;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;---------------------------------------------------------------------------------Mods Page -------------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			
Function AddCompletedModsPage()

	if CurrentPage == "Official Patches"
		SetVal = BuildTotalsArray(SetVal, RN_Patches_Complete_Array)
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)				
		AddHeaderOption("Official Patch(es)")
		SetCursorPosition(1)
		AddHeaderOption("Completed: " + GetCurrentCountInt(SetVal, RN_SupportedModCount) + " Official Patch(es)")
		
		Int PageIdx = 1	
		Int Index = 0
		While Index < RN_Patches_Name.length			
			SetCursorPosition(PageIdx + 1)
			if RN_Patches_Name[Index] != ""
				if RN_Patches_Complete_Array[Index].GetValue()
					AddTextOption(RN_Patches_Name[Index], GetCurrentCount(RN_Patches_Count_Array[Index], RN_Patches_Total_Array[Index]) + " (Complete)", 1)
					PageIdx += 1
				elseif RN_Scan_Registered.GetValue()
					AddTextOption(RN_Patches_Name[Index], "Updating...", 1)
					PageIdx += 1
				else
					RN_Patches_Position_Array[Index] = AddTextOption(RN_Patches_Name[Index], GetCurrentCount(RN_Patches_Count_Array[Index], RN_Patches_Total_Array[Index]), 0)
					PageIdx += 1
				endif
			endif
			Index +=1
		endWhile
	endif
endFunction

;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;---------------------------------------------------------------------------------Mods Page -------------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Function AddCustomModsPage()

	if CurrentPage == "Custom Patches"
		SetVal = BuildTotalsArray(SetVal, RN_Custom_Complete_Array)
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)
	
		AddHeaderOption("Custom Patch(es)")
		SetCursorPosition(1)
		AddHeaderOption("Completed: " + GetCurrentCountInt(SetVal, RN_CustomModCount) + " Custom Patch(es)")	
		
		Int PageIdx = 1
		Int Index = 0
		While Index < RN_Custom_Name.length
			SetCursorPosition(PageIdx + 1)
			if RN_Custom_Name[Index] != ""
				if RN_Custom_Complete_Array[Index].GetValue()
					AddTextOption(RN_Custom_Name[Index], GetCurrentCount(RN_Custom_Count_Array[Index], RN_Custom_Total_Array[Index]) + " (Complete)", 1)
					PageIdx += 1
				elseif RN_Scan_Registered.GetValue()
					AddTextOption(RN_Custom_Name[Index], "Updating...", 1)
					PageIdx += 1
				else
					RN_Custom_Position_Array[Index] = AddTextOption(RN_Custom_Name[Index], GetCurrentCount(RN_Custom_Count_Array[Index], RN_Custom_Total_Array[Index]), 0)
					PageIdx += 1
				endif
			endif
			Index +=1			
		endWhile	
	endif
endFunction	

;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------- Patch Tracking Pages -------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Function AddTrackingPage()
	
	if CurrentPage == "Display Tracker (1)"
		BuildTrackingPage(Page1, Page2, TrackedDisplays, TrackedNames)
	endif
endFunction	

;;---------------------------------------------------

Function AddTrackingPage2()
	
	if CurrentPage == "Display Tracker (2)"
		BuildTrackingPage(Page2, Page3, TrackedDisplays2, TrackedNames2)
	endif
endFunction	

;;---------------------------------------------------

Function AddTrackingPage3()
	
	if CurrentPage == "Display Tracker (3)"
		BuildTrackingPage(Page3, Page4, TrackedDisplays3, TrackedNames3)
	endif
endFunction	

;;---------------------------------------------------

Function AddTrackingPage4()
	
	if CurrentPage == "Display Tracker (4)"
		BuildTrackingPage(Page4, Page5, TrackedDisplays4, TrackedNames4)
	endif
endFunction	

;;---------------------------------------------------

Function AddTrackingPage5()
	
	if CurrentPage == "Display Tracker (5)"
		BuildTrackingPage(Page5, Page6, TrackedDisplays5, TrackedNames5)
	endif
endFunction	

;;---------------------------------------------------

Function AddTrackingPage6()

	if CurrentPage == "Display Tracker (6)"
		BuildTrackingPage(Page6, Page7, TrackedDisplays6, TrackedNames6)
	endif
endFunction	

;;---------------------------------------------------

Function AddTrackingPage7()

	if CurrentPage == "Display Tracker (7)"
		BuildTrackingPage(Page7, Page8, TrackedDisplays7, TrackedNames7)
	endif
endFunction	

;;---------------------------------------------------

Function AddTrackingPage8()

	if CurrentPage == "Display Tracker (8)"
		BuildTrackingPage(Page8, Page9, TrackedDisplays8, TrackedNames8)
	endif
endFunction	

;;---------------------------------------------------

Function AddTrackingPage9()

	if CurrentPage == "Display Tracker (9)"
		BuildTrackingPage(Page9, Page10, TrackedDisplays9, TrackedNames9)
	endif
endFunction	

;;---------------------------------------------------

Function AddTrackingPage10()

	if CurrentPage == "Display Tracker (10)"
		BuildTrackingPage(Page10, False, TrackedDisplays10, TrackedNames10)
	endif
endFunction	

;;---------------------------------------------------

Function BuildTrackingPage(Bool ThisPage, Bool NextPage, ObjectReference[] DisplayArray, String[] NamesArray)
		
	if !ThisPage
		AddTextOption("No Tracking Data To Display...", "", 1)
		return
	endif
	
	if HEADERSREQUIRED
		SetTitleText(TrackedPatch + " Displays")
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)			

		Int Index = 0
		Int PGPos = 0
		Bool Moved = False
		While Index < DisplayArray.length
			if (NamesArray[Index] != "")
				While (PGPos > 63) && (!Moved)
					SetCursorPosition(1)
					PGPos = 1
					Moved = True
				endwhile
				if (DisplayArray[Index] == TCC_HEADER_TO_REPLACE)
					if (PGPos != 0) && (PGPos != 1)
						AddEmptyOption()
						PGPos += 1
					endif				
					AddHeaderOption(NamesArray[Index], 0)	
					PGPos += 1
				else
					if (!DisplayArray[Index].IsDisabled())
						AddToggleOption(NamesArray[Index], !DisplayArray[Index].IsDisabled(), 1)
						PGPos += 1
					else
						AddToggleOption(NamesArray[Index], !DisplayArray[Index].IsDisabled())
						PGPos += 1
					endif
				endif
			endif
			Index +=1
		endWhile
	else
		SetTitleText(TrackedPatch)
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)									
		AddHeaderOption(TrackedPatch, 0)
		SetCursorPosition(1)
		AddHeaderOption("", 0)
		Int PageIdx = 1
		Int Index = 0
		While Index < DisplayArray.length
			SetCursorPosition(PageIdx + 1)
			if (NamesArray[Index] != "")
				if (DisplayArray[Index].IsEnabled())
					AddToggleOption(NamesArray[Index], DisplayArray[Index].IsEnabled(), 1)
					PageIdx += 1
				else
					AddToggleOption(NamesArray[Index], DisplayArray[Index].IsEnabled())
					PageIdx += 1
				endif
			endif
			Index +=1			
		endWhile
		if NextPage
			AddTextOption("Continue on the next page...", "", 1)
		endif
	endif	
endFunction	

;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;-------------------------------------------------------------------------------- Debug Page ------------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Function AddDebugPage()

	if CurrentPage == "Debug Options"
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)
		AddHeaderOption("Debug Options:")
		
		AddTextOptionST("Scan_Debug", "Reset Museum Scanner", "Reset", 0)
		AddTextOptionST("AchPreview", "Preview Achievement FX", "Preview", 0)
		AddTextOptionST("ScanMuseum", "Confirm Museum Counts", "Update", 0)
		AddTextOptionST("AdvancedDebugging", "Enable Debugging", GetDefaultEnabled(advdebug))
		AddMenuOptionST("CacheListOptions", "Clear Cached Data:", CacheList[IndexCache])
		AddEmptyOption()
		AddHeaderOption("moreHUD Debug:")
		AddTextOption("moreHUD new count:", dbmNew.GetSize() As Int, 1)
		AddTextOption("moreHUD found count:", dbmFound.GetSize() As Int, 1)
		AddTextOption("moreHUD displayed count:", dbmDisp.GetSize() As Int, 1)
		AddTextOption("moreHUD total Count:", dbmMaster.GetSize() As Int, 1)
		AddTextOption("Status:", GetIconStatus(), 0)		
		AddEmptyOption()
		AddHeaderOption("Mod Status:")
		AddTextOption("Status:", GetStatusString(), 0)
		AddTextOption("Setup Start:", RN_Setup_Start.GetValue() As Int, 1)
		AddTextOption("Setup Finish:", RN_Setup_Finish.GetValue() As Int, 1)

		SetCursorPosition(1)
		
		AddHeaderOption("Mod Requirements:")

		if papyrusutil.GetVersion() > 31
			AddTextOption("PapyrusUtil:", "<font color='#070091'>Installed</font>" + " [" + papyrusutil.GetVersion() + "]", 0)
		else
			AddTextOption("PapyrusUtil:", "<font color='#750e0e'>Invalid / Missing</font>", 0)
		endif

		if SKSE.GetVersion() > 0			
			AddTextOption("SKSE:", "<font color='#070091'>Installed</font>" + " [" + SKSE.GetVersion()+"."+SKSE.GetVersionMinor()+"."+SKSE.GetVersionBeta() + "]", 0)
		else
			AddTextOption("SKSE:", "<font color='#750e0e'>Not Found</font>", 0)	
		endif

		if (Game.GetModByName("SkyUI_SE.esp") != 255)
			AddTextOption("SkyUI:", "<font color='#070091'>Installed</font>" + " [5.2SE]", 0)
		else
			AddTextOption("SkyUI:", "<font color='#750e0e'>Not Found</font>", 0)
		endif	
		
		AddEmptyOption()
		AddEmptyOption()
		AddEmptyOption()
		AddHeaderOption("moreHUD Icon Support:")
		
		if SKSE.GetPluginVersion("Ahzaab's moreHUD Plugin") < 30800
			AddTextOption("moreHUD:", "<font color='#750e0e'>Invalid / Missing</font>", 0)
		else
			AddTextOption("moreHUD:", "<font color='#070091'>Installed</font>" + " [" + GetVersionString() + "]", 0)
		endif

		if SKSE.GetPluginVersion("Ahzaab's moreHUD Inventory Plugin") < 10017
			AddTextOption("moreHUD Inventory Edition:", "<font color='#750e0e'>Invalid / Missing</font>", 0)
		else
			AddTextOption("moreHUD Inventory Edition:", "<font color='#070091'>Installed</font>" + " [" + SKSE.GetPluginVersion("Ahzaab's moreHUD Inventory Plugin") + "]", 0)
		endif
		AddEmptyOption()
		AddTextOptionST("RebuildLists", "moreHUD Icons Reset:", "Rebuild", 0)
		AddTextOptionST("ConfirmIcons", "moreHUD Icons Check:", "Verify", 0)
		AddEmptyOption()
		AddHeaderOption("")
		AddTextOption("SortWait:", DBM_SortWait.GetValue() As Int, 1)
		AddTextOption("Scan Registered:", RN_Scan_Registered.GetValue() As Int, 1)
		AddTextOption("Scan Done:", RN_Scan_Done.GetValue() As Int, 1)
	endif
endFunction

;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;----------------------------------------------------------------------------- General States------------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
state RefreshMCM

	Event OnSelectST()
		bool bRefresh = True
		SetTitleText("=== PLEASE EXIT THE MCM ===")
		While bRefresh
			if !IsInMenuMode()
				Page1 = False
				Page2 = False
				Page3 = False
				Page4 = False
				Page5 = False
				Page6 = False
				Page7 = False
				Page8 = False
				Page9 = False
				Page10 = False
				
				CacheArmory = False
				CacheDaedricGallery = False
				CacheDragonbornhall = False
				CacheGuildhouse = False
				CacheHallofHeroes = False
				CacheHallofLostEmpires = False
				CacheHallofOddities = False
				CacheHallofSecrets = False
				CacheHallofWonders = False
				CacheLibrary = False
				CacheMisc = False
				CacheNaturalScience = False
				CacheSafehouse = False
				CacheStoreroom = False
				
				Build_Arrays()
				BuildPatchArray(true, true, true, true)
				
				AddDynamicPagesList()		
				bRefresh = false
				Notify("The Curators Companion: MCM Rebuilt", ColourString)
			endif
		endWhile
	endEvent

	function OnHighlightST()

		SetInfoText("Force refresh Mod list and reload the MCM - use if installed mods don't automatically show up or something doesn't look right in the MCM")
	endFunction
endState

;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;------------------------------------------------------------------------------------ Config Save / Load -------------------------------------------------------------------------------------------------
;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

state SaveConfig_JSON

	Event OnSelectST()
		
		SetTitleText(" === Saving Profile ===") 
		Begin_Config_Save()
	EndEvent

	Event OnHighlightST()
		
		SetInfoText("Save current settings to Data > SKSE > Plugins > StorageUtilData > TCC_Config.json (Requires PapyrusUtil)")
	EndEvent
endState

state LoadConfig_JSON

	Event OnSelectST()
		
		SetTitleText(" === Loading Profile ===") 
		Begin_Config_Load()
	EndEvent

	Event OnHighlightST()

		SetInfoText("Load saved settings from Data > SKSE > Plugins > StorageUtilData > TCC_Config.json (Requires PapyrusUtil)")
	EndEvent
endState

String function GetConfigSaveString()
	
	if papyrusutil.GetVersion() > 31
		return "Save Preset"
	endif
	
	return "PapyrusUtil Not Found"
endFunction	

String function GetConfigLoadString()

	if papyrusutil.GetVersion() > 31
		return "Load Preset"
	endif
	
	return "PapyrusUtil Not Found"
endFunction	

;-- Save States / Function --------------------------------

Function Begin_Config_Save()
	if papyrusutil.GetVersion() > 31
		jsonutil.SetPathIntValue("TCC_Config", ".!ShowMuseumVal", ShowMuseumVal as Int)	
		jsonutil.SetPathIntValue("TCC_Config", ".!ShowArmoryVal", ShowArmoryVal as Int)	
		jsonutil.SetPathIntValue("TCC_Config", ".!ShowModsVal", ShowModsVal as Int)	
		jsonutil.SetPathIntValue("TCC_Config", ".!ShowSetCompleteVal", ShowSetCompleteVal as Int)	
		jsonutil.SetPathIntValue("TCC_Config", ".!ShowListenerVal", ShowListenerVal as Int)			
		jsonutil.SetPathIntValue("TCC_Config", ".!ShowStartup", ShowStartup as Int)	
		jsonutil.SetPathIntValue("TCC_Config", ".!Restricted", Restricted as Int)	
		jsonutil.SetPathIntValue("TCC_Config", ".!Token_Vis", Token_Vis as Int)
		jsonutil.SetPathIntValue("TCC_Config", ".!Ach_Notify", Ach_Notify as Int)
		jsonutil.SetPathIntValue("TCC_Config", ".!Ach_Visual", Ach_Visual as Int)
		jsonutil.SetPathIntValue("TCC_Config", ".!Ach_Perks", Ach_Perks as Int)			
		
		jsonutil.SetPathIntValue("TCC_Config", ".!IndexSounds", IndexSounds)
		jsonutil.SetPathIntValue("TCC_Config", ".!IndexAttribute", IndexAttribute)
		jsonutil.SetPathIntValue("TCC_Config", ".!IndexTransfer", IndexTransfer)

		jsonutil.SetPathIntValue("TCC_Config", ".!IndexmoreHUD", IndexmoreHUD)		
		jsonutil.SetPathIntValue("TCC_Config", ".!IndexmoreHUDInventory", IndexmoreHUDInventory)		
		
		jsonutil.SetPathIntValue("TCC_Config", ".!IndexColour", IndexColour)
		jsonutil.SetPathStringValue("TCC_Config", ".!ColourString", ColourString)	
		
		jsonutil.Save("TCC_Config", false)
		if IsInMenuMode()
			ShowMessage("Configuration settings successfully saved to file")
			ForcePageReset()
		endif
	else
		ShowMessage("PapyrusUtil Not Installed")
	endIf
EndFunction

;-- Load States / Function --------------------------------

Function Begin_Config_Load()
	if papyrusutil.GetVersion() > 31
		if jsonutil.JsonExists("TCC_Config")
			if !jsonutil.IsGood("TCC_Config")
				if IsInMenuMode()
					ShowMessage("The config file appears to be damaged or does not meet the requirements\n{}{" + jsonutil.GetErrors("TCC_Config") + "}", false, "Ok", "Cancel")
					return
				else
					Notify("The Curators Companion: Corrupt profile found - restoring defaults", ColourString)
					Begin_Config_Default()
					return 
				endif
			endIf
		
			ShowMuseumVal = (jsonutil.GetPathIntValue("TCC_Config", ".!ShowMuseumVal", ShowMuseumVal as Int))
			if ShowMuseumVal
				_AddItemMain_1.GoToState("Notify")
				_AddItemMain_2.GoToState("Notify")
			else
				_AddItemMain_1.GoToState("Silent")
				_AddItemMain_2.GoToState("Silent")
			endif				

			ShowArmoryVal = (jsonutil.GetPathIntValue("TCC_Config", ".!ShowArmoryVal", ShowArmoryVal as Int))
			if ShowArmoryVal
				_AddItemArmory.GoToState("Notify")
			else
				_AddItemArmory.GoToState("Silent")
			endif

			ShowModsVal = (jsonutil.GetPathIntValue("TCC_Config", ".!ShowModsVal", ShowModsVal as Int))
			if ShowModsVal
				_AddItemPatches.GoToState("Notify")
			else
				_AddItemPatches.GoToState("Silent")
			endif
			
			ShowSetCompleteVal = (jsonutil.GetPathIntValue("TCC_Config", ".!ShowSetCompleteVal", ShowSetCompleteVal as Int))
			ShowListenerVal = (jsonutil.GetPathIntValue("TCC_Config", ".!ShowListenerVal", ShowListenerVal as Int))
			ShowStartup = (jsonutil.GetPathIntValue("TCC_Config", ".!ShowStartup", ShowStartup as Int))
			Restricted = (jsonutil.GetPathIntValue("TCC_Config", ".!Restricted", Restricted as Int))
			Token_Vis = (jsonutil.GetPathIntValue("TCC_Config", ".!Token_Vis", Token_Vis as Int))
			Ach_Notify = (jsonutil.GetPathIntValue("TCC_Config", ".!Ach_Notify", Ach_Notify as Int))
			Ach_Visual = (jsonutil.GetPathIntValue("TCC_Config", ".!Ach_Visual", Ach_Visual as Int))
			Ach_Perks = (jsonutil.GetPathIntValue("TCC_Config", ".!Ach_Perks", Ach_Perks as Int))				
			
			IndexSounds = (jsonutil.GetPathIntValue("TCC_Config", ".!IndexSounds", IndexSounds))
			IndexAttribute = (jsonutil.GetPathIntValue("TCC_Config", ".!IndexAttribute", IndexAttribute))
			IndexTransfer = (jsonutil.GetPathIntValue("TCC_Config", ".!IndexTransfer", IndexTransfer))
			
			IndexColour = (jsonutil.GetPathIntValue("TCC_Config", ".!IndexColour", IndexColour))
			ColourString = (jsonutil.GetPathStringValue("TCC_Config", ".!ColourString", ColourString))
			SetColour()
		
			IndexmoreHUD = (jsonutil.GetPathIntValue("TCC_Config", ".!IndexmoreHUD", IndexmoreHUD))
			IndexmoreHUDInventory = (jsonutil.GetPathIntValue("TCC_Config", ".!IndexmoreHUDInventory", IndexmoreHUDInventory))
			IconScript.SetMainHud(IndexmoreHUD)
			IconScript.SetInventoryHud(IndexmoreHUDInventory)		
			IconScript.SetQuickLoot()			
			
			jsonutil.Load("TCC_Config")
			if IsInMenuMode()
				ShowMessage("Configuration settings successfully loaded from file")
				ForcePageReset()
			else
				Notify("The Curators Companion: Configuration profile loaded", ColourString)
			endif
		else
			if IsInMenuMode()
				ShowMessage("No Profile Found")
			else
				Notify("The Curators Companion: No profile found - restoring defaults", ColourString)
				Begin_Config_Default()
			endif
		endif
	else
		if IsInMenuMode()
			ShowMessage("PapyrusUtil Not Installed")
		endif
	endIf
EndFunction	


function AutoLoadConfig()

	if papyrusutil.GetVersion() > 31
		if jsonutil.JsonExists("TCC_Config")
			if jsonutil.IsGood("TCC_Config")
				ShowMuseumVal = (jsonutil.GetPathIntValue("TCC_Config", ".!ShowMuseumVal", ShowMuseumVal as Int))
				if ShowMuseumVal
					_AddItemMain_1.GoToState("Notify")
					_AddItemMain_2.GoToState("Notify")
				else
					_AddItemMain_1.GoToState("Silent")
					_AddItemMain_2.GoToState("Silent")
				endif				

				ShowArmoryVal = (jsonutil.GetPathIntValue("TCC_Config", ".!ShowArmoryVal", ShowArmoryVal as Int))
				if ShowArmoryVal
					_AddItemArmory.GoToState("Notify")
				else
					_AddItemArmory.GoToState("Silent")
				endif

				ShowModsVal = (jsonutil.GetPathIntValue("TCC_Config", ".!ShowModsVal", ShowModsVal as Int))
				if ShowModsVal
					_AddItemPatches.GoToState("Notify")
				else
					_AddItemPatches.GoToState("Silent")
				endif
				
				ShowSetCompleteVal = (jsonutil.GetPathIntValue("TCC_Config", ".!ShowSetCompleteVal", ShowSetCompleteVal as Int))
				ShowListenerVal = (jsonutil.GetPathIntValue("TCC_Config", ".!ShowListenerVal", ShowListenerVal as Int))
				ShowStartup = (jsonutil.GetPathIntValue("TCC_Config", ".!ShowStartup", ShowStartup as Int))
				Restricted = (jsonutil.GetPathIntValue("TCC_Config", ".!Restricted", Restricted as Int))
				Token_Vis = (jsonutil.GetPathIntValue("TCC_Config", ".!Token_Vis", Token_Vis as Int))
				Ach_Notify = (jsonutil.GetPathIntValue("TCC_Config", ".!Ach_Notify", Ach_Notify as Int))
				Ach_Visual = (jsonutil.GetPathIntValue("TCC_Config", ".!Ach_Visual", Ach_Visual as Int))
				Ach_Perks = (jsonutil.GetPathIntValue("TCC_Config", ".!Ach_Perks", Ach_Perks as Int))				
				
				IndexSounds = (jsonutil.GetPathIntValue("TCC_Config", ".!IndexSounds", IndexSounds))
				IndexAttribute = (jsonutil.GetPathIntValue("TCC_Config", ".!IndexAttribute", IndexAttribute))
				IndexTransfer = (jsonutil.GetPathIntValue("TCC_Config", ".!IndexTransfer", IndexTransfer))
				
				IndexColour = (jsonutil.GetPathIntValue("TCC_Config", ".!IndexColour", IndexColour))
				ColourString = (jsonutil.GetPathStringValue("TCC_Config", ".!ColourString", ColourString))
				SetColour()
			
				IndexmoreHUD = (jsonutil.GetPathIntValue("TCC_Config", ".!IndexmoreHUD", IndexmoreHUD))
				IndexmoreHUDInventory = (jsonutil.GetPathIntValue("TCC_Config", ".!IndexmoreHUDInventory", IndexmoreHUDInventory))
				IconScript.SetMainHud(IndexmoreHUD)
				IconScript.SetInventoryHud(IndexmoreHUDInventory)					
				jsonutil.Load("TCC_Config")
				Notify("The Curators Companion - Profile successfully loaded from file", ColourString)
			else			
				Notify("The Curators Companion - Profile corrupt, Loading defaults", ColourString)
				Begin_Config_Default()
			endif
		else
			Notify("The Curators Companion - No profile found, Loading defaults", ColourString)
			Begin_Config_Default()
		endif
	else
		Notify("The Curators Companion - PapyrusUTIL out of date, Loading defaults", ColourString)
		Begin_Config_Default()
	endif
		
endFunction
;-- Load States / Function --------------------------------

state Config_Default

	Event OnSelectST()
		
		 if ShowMessage("This will Restore all MCM options back to default including moreHUD icons... do you want to Restore now?", true, "Restore", "Cancel")
			SetTitleText(" === Loading Defaults ===") 
			Begin_Config_Default()
		endif
	EndEvent

	Event OnHighlightST()

		SetInfoText("Restore MCM Options To Default")
	EndEvent
endState

;-- Load States / Function --------------------------------

state Config_Author

	Event OnSelectST()

		 if ShowMessage("This will set all MCM options to the Developers preferred setup, limited notifications, full moreHUD support and a less invasive but still full featured preset... do you want to configure now?", true, "Configure", "Cancel")
			SetTitleText(" === Loading Profile ===") 
			Begin_Config_Author()
		endif
	EndEvent

	Event OnHighlightST()

		SetInfoText("Configuration profile for the Developers personal and preferred setup")
	EndEvent
endState

;-- Load States / Function --------------------------------

Function Begin_Config_Default()

	ShowMuseumVal = False
	_AddItemMain_1.GoToState("Silent")
	_AddItemMain_2.GoToState("Silent")
	
	ShowArmoryVal = False
	_AddItemArmory.GoToState("Silent")
		
	ShowModsVal = False
	_AddItemPatches.GoToState("Silent")
	
	ShowSetCompleteVal = True
	ShowListenerVal = True
	ShowStartup = True
	Restricted = True
	
	IndexColour = 16777215
	ColourString = GetHexValue(HexDigits, IndexColour)
	SetColour()

	IndexmoreHUD = 0
	IconScript.SetMainHud(IndexmoreHUD)
	IconScript.SetInventoryHud(IndexmoreHUDInventory)
	
	Token_Vis = True
	IndexTransfer = 0
	
	Ach_Notify = True
	Ach_Visual = True
	IndexSounds = 2
	Ach_Highlight = False
	Ach_Perks = False
	IndexAttribute = 0
	
	if IsInMenuMode()
		ForcePageReset()
	endif
endFunction

;-- Load States / Function --------------------------------

Function Begin_Config_Author()

	ShowMuseumVal = False
	_AddItemMain_1.GoToState("Silent")
	_AddItemMain_2.GoToState("Silent")
	
	ShowArmoryVal = False
	_AddItemArmory.GoToState("Silent")
		
	ShowModsVal = False
	_AddItemPatches.GoToState("Silent")
	
	ShowSetCompleteVal = True
	ShowListenerVal = True
	ShowStartup = True
	Token_Vis = True
	IndexTransfer = 0
	
	IndexmoreHUD = 0
	IconScript.SetMainHud(IndexmoreHUD)
	IconScript.SetInventoryHud(IndexmoreHUDInventory)
	
	IndexColour = 9202896
	ColourString = GetHexValue(HexDigits, IndexColour)
	SetColour()
	
	Restricted = False
	
	Ach_Notify = True
	Ach_Visual = True
	IndexSounds = 2
	Ach_Highlight = True
	Ach_Perks = True
	IndexAttribute = 4
	
	if IsInMenuMode()
		ForcePageReset()
	endif
endFunction

;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;----------------------------------------------------------------------------- Museum Scan Options--------------------------------------------------------------------------------------------------------
;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

state ScanMuseum

	Event OnSelectST()
		
		if ShowMessage("This will start the process of Scanning the Museum for completed sets... do you want to scan now?", true, "Scan", "Cancel")
			ShowMessage("Please exit the MCM and wait for the scan to complete", false, "Ok")
			SetTitleText("=== PLEASE EXIT THE MCM ===")
			Util.ScanMuseum()
		endif
	endEvent

	Event OnHighlightST()

		SetInfoText("Selecting this option will scan the Museum & Armoury for all displayed items and update the listings within this mod.")
	endEvent
endState

;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;----------------------------------------------------------------------------- Debug Options -------------------------------------------------------------------------------------------------------------
;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;;-------------------------------

state Scan_Debug

	Event OnSelectST()
	
		if ShowMessage("This will reset the current Museum scan and reset the scanner, do you want to reset now?", true, "Reset", "Cancel")
			RN_Scan_Done.SetValue(RN_Scan_Registered.GetValue())
			DBM_SortWait.setvalue(0)
		endif
		
	EndEvent

	Event OnHighlightST()

		SetInfoText("Resets the Museum Scanner")
	EndEvent
endState

;;-------------------------------

state AchPreview

	Event OnSelectST()
	
		ShowMessage("Please exit the MCM to preview the current achievement FX settings", false, "Ok")
		SetTitleText("=== Please Exit The MCM ===")
		While IsInMenuMode()
			Wait(1)
		endwhile
		
		AchMaster.Preview()	
	EndEvent

	Event OnHighlightST()

		SetInfoText("Select and then exit the MCM to preview the current achievement FX settings")
	EndEvent
endState

;;-------------------------------

state AdvancedDebugging

	Event OnSelectST()		
		advdebug = !advdebug
		
		if advdebug
			if ShowMessage("This will enable debugging which can be used to diagnose issues with the Mod, would you like to enable debugging now?", true, "Enable", "Cancel")
				TCCDebug.EnableLogging()
			else
				advdebug = false
			endif
		else
			TCCDebug.DisableLogging()
		endIf
		
		
		SetTextOptionValueST(GetDefaultEnabled(advdebug))
	EndEvent

	Event OnHighlightST()

		SetInfoText("Enables TCC debug logging to Documents > My Games > Skyrim Special Edition > Logs > Script > User > TheCuratorsCompanion.log")
	EndEvent
endState

;;-------------------------------

state RebuildLists

	Event OnSelectST()
	
		if IsInMenuMode()
			if ShowMessage("This will rebuild and update the moreHUD lists for all new / found / displayed items, do you want to rebuild now?", true, "Rebuild", "Cancel")
				
				ShowMessage("Please exit the MCM and wait for a completion message", false, "Ok")
				SetTitleText("=== Please Exit The MCM ===")
				While IsInMenuMode()
					Wait(1)
				endwhile
				Util.RebuildLists()
			endif
		endif
	EndEvent

	Event OnHighlightST()

		SetInfoText("This option will rebuild the moreHUD lists -- Only to be used if prompted or advised by Developer.")
	EndEvent
endState

;;-------------------------------

state ConfirmIcons

	Event OnSelectST()
	
		if IsInMenuMode()
			if ShowMessage("Do you want to run the function now?", true, "Run", "Cancel")
				
				ShowMessage("Please exit the MCM and wait for a completion message", false, "Ok")
				SetTitleText("=== Please Exit The MCM ===")
				While IsInMenuMode()
					Wait(1)
				endwhile
				Util.ConfirmIcons()
			endif
		endif
	EndEvent

	Event OnHighlightST()

		SetInfoText("This function will check each form present in the moreHUD Total list and check for the form being present in each of the new, found and displayed lists, if a form is present in more than 1 list then an error has likely occured and the form will be printed to the Papyrus log for investigation.")
	EndEvent
endState

;;-------------------------------

String Function GetVersionString()
    int iVersion = AhzMoreHud.GetVersion()
    int iMajor = iVersion / 1000000
    int iMinor = (iVersion / 10000) % 100
    int iBug = (iVersion / 100) % 100
    int iBeta = iVersion % 100
    string aVersion = iMajor + "." + iMinor + "." + iBug

    if (iBeta > 0)
        aVersion += " Beta " + iBeta
    endif
    return aVersion
EndFunction

;;-------------------------------

string function GetIconStatus()
	
	if ((dbmNew.GetSize()) + (dbmFound.GetSize()) + (dbmDisp.GetSize())) == (dbmMaster.GetSize())
		return "No Icon Errors Detected"
	endif
	
	return "Rebuild Advised"
endfunction

;;-------------------------------

string function GetStatusString()

	if RN_Scan_Done.GetValue() > RN_Scan_Registered.GetValue()
		return "Scan Error"
	endIf
	
	if RN_Setup_Start.GetValue()
		return "Setting Up"
		
	elseif RN_Scan_Registered.GetValue()
		return "Scanning"
	
	elseif DBM_SortWait.getValue()
		return "Busy"
	endIf
	
	return "No Errors Detected"
endfunction

;;-------------------------------

state CacheListOptions

	event OnMenuOpenST()
		SetMenuDialogStartIndex(IndexCache)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(CacheList)
	endEvent

	event OnMenuAcceptST(int index)
		IndexCache = Index
		SetMenuOptionValueST(CacheListOptions, CacheList[IndexCache])
		DeleteCache(IndexCache)
		ForcePageReset()
	endEvent

	event OnDefaultST()
		IndexCache = 0
		SetMenuOptionValueST(CacheList[IndexCache])
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Clear cached data used by the Display Tracker")
	endEvent
endState

function DeleteCache(Int Index)
	
	if (Index != 0)
		ClearCachedData(IndexCache)
		ShowMessage(_Museum_Section_names[IndexCache - 1] + " cache deleted")
		IndexCache = 0
		SetMenuOptionValueST(CacheListOptions, CacheList[IndexCache])
	else
		IndexCache = 0
		SetMenuOptionValueST(CacheListOptions, CacheList[IndexCache])		
	endif
endFunction


;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;----------------------------------------------------------------------------- Notifications Options -----------------------------------------------------------------------------------------------------
;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

state NotificationColourOptions
	
	event OnColorOpenST()
	
		SetColorDialogStartColor(IndexColour)
		SetColorDialogDefaultColor(16777215)
	endEvent
	
	event OnColorAcceptST(Int Index)
	
		IndexColour = Index
		ColourString = GetHexValue(HexDigits, IndexColour)
		SetColour()
		SetColorOptionValueST(IndexColour, false)
	endEvent

	event OnDefaultST()
	
		IndexColour = 16777215
		ColourString = GetHexValue(HexDigits, IndexColour)
		SetColour()
		SetColorOptionValueST(IndexColour, false)
	endEvent

	event OnHighlightST()
		SetInfoText("Use this menu to customize the colour of The Curators Companion Notifications\n Default: White")
	endEvent
endState

;;-------------------------------

function SetColour()

	ColourAlias.Clear()
	NotificationColour.GetBaseObject().SetName(ColourString)
	ColourAlias.ForceRefTo(NotificationColour)
endfunction
		
;;-------------------------------

state iRelicMuseumNotifications

	Event OnSelectST()
		ShowMuseumVal = !ShowMuseumVal 
		
		if ShowMuseumVal
			_AddItemMain_1.GoToState("Notify")
			_AddItemMain_2.GoToState("Notify")
		else
			_AddItemMain_1.GoToState("Silent")
			_AddItemMain_2.GoToState("Silent")
		endif
		
		SetTextOptionValueST(GetDefaultOnOff(ShowMuseumVal), false, "")
	EndEvent

	Event OnHighlightST()

		SetInfoText("Show Notifications when picking up a displayable item for the Museum.\n Default: Off")
	EndEvent
endState

;;-------------------------------

state iRelicArmoryNotifications

	Event OnSelectST()
		ShowArmoryVal = !ShowArmoryVal 

		if ShowArmoryVal
			_AddItemArmory.GoToState("Notify")
		else
			_AddItemArmory.GoToState("Silent")
		endif
		
		SetTextOptionValueST(GetDefaultOnOff(ShowArmoryVal), false, "")
	EndEvent

	Event OnHighlightST()

		SetInfoText("Show Notifications when picking up a displayable item for the Armoury.\n Default: Off")
	EndEvent
endState

;;-------------------------------

state iRelicModsNotifications

	Event OnSelectST()
		ShowModsVal = !ShowModsVal 

		if ShowModsVal
			_AddItemPatches.GoToState("Notify")
		else
			_AddItemPatches.GoToState("Silent")
		endif
	
		SetTextOptionValueST(GetDefaultOnOff(ShowModsVal), false, "")
	EndEvent

	Event OnHighlightST()

		SetInfoText("Show Notifications when picking up a displayable item from any installed patch(es).\n Default: Off")
	EndEvent
endState

;;-------------------------------

state iRelicListenerNotifications
	
	function OnSelectST()
	
		ShowListenerVal = !ShowListenerVal 
		SetTextOptionValueST(GetDefaultOnOff(ShowListenerVal), false, "")
	EndFunction

	Event OnHighlightST()

		SetInfoText("Show notifications when quest, exploration and skill displays are enabled\n Default: On")
	EndEvent
endState

;;-------------------------------

state iRelicSetCompleteNotifications

	Event OnSelectST()
		ShowSetCompleteVal = !ShowSetCompleteVal 
		
		SetTextOptionValueST(GetDefaultOnOff(ShowSetCompleteVal), false, "")
	EndEvent

	Event OnHighlightST()

		SetInfoText("Show notifications when a collection, set or Museum section is completed\n Default: On")
	EndEvent
endState

;;-------------------------------

state iRelicShowStartup ;;Show Startup Notifications


	Event OnSelectST()
		ShowStartup = !ShowStartup 
		
		SetTextOptionValueST(GetDefaultStartup(ShowStartup), false, "")
	EndEvent

	Event OnHighlightST()

		SetInfoText("Hides the startup notifications when loading in.\n Default: Messages Shown")
	EndEvent
endState

;;-------------------------------

String function GetDefaultOnOff(bool val)

	if !val		
		return "Off"
	endif
	
	return "On"
endfunction

;;-------------------------------

String function GetDefaultType(bool val)

	if !val		
		return "Messagebox"
	endif
	
	return "Notification"
endfunction

;;-------------------------------

String function GetDefaultStartup(bool val)

	if !val		
		return "Messages Hidden"
	endif
	
	return "Messages Shown"
endfunction

;;-------------------------------
			
String function GetDefaultEnabled(bool val)

	if !val		
		return "Disabled"
	endif
	
	return "Enabled"
endfunction

;;-------------------------------
			
String function GetDefaultCache(bool val)

	if !val		
		return "No cached data found"
	endif
	
	return "Display Tracker will use cached data"
endfunction

;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;----------------------------------------------------------------------------------- Storage Options -----------------------------------------------------------------------------------------------------
;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	

state iRelicRestrictionOptions

	Event OnSelectST()
		Restricted = !Restricted 
			
		SetTextOptionValueST(GetDefaultOnOff(Restricted), false, "")
	EndEvent

	Event OnHighlightST()

		SetInfoText("Toggles storage restriction on/off.\n Off - The storage container will have no restrictions and will allow any items to be stored.\n On - The storage container will only allow items that are displayable and not already on display.")
	EndEvent
endState

;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;----------------------------------------------------------------------------------- Storage Transfer Options ---------------------------------------------------------------------------------------------------
;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
		
state TransferListOptions

	event OnMenuOpenST()
		SetMenuDialogStartIndex(IndexTransfer)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(TransferList)
	endEvent

	event OnMenuAcceptST(int index)
		IndexTransfer = Index
		SetMenuOptionValueST(TransferListOptions, TransferList[IndexTransfer])
		ForcePageReset()
	endEvent

	event OnDefaultST()
		IndexTransfer = 0
		SetMenuOptionValueST(TransferList[IndexTransfer])
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Choose which container(s) to check for displayable items when using the 'Transfer Relics' option at the Transfer station.\n All Storage: Player Inventory, Relic Storage Container, All custom storage containers added via token.\n Relic Storage Container: Relic Storage Container Only.\n Custom Storage Only: Only containers added via token.")
	endEvent
endState

;;-------------------------------

state Token_Visibility ;;Token Visibility

	Event OnSelectST()
		Token_Vis = !Token_Vis
		SetTextOptionValueST(GetDefaultOnOff(Token_Vis), false, "")
	EndEvent

	Event OnHighlightST()

		SetInfoText("Toggle to show / hide the Curators Storage Token crafting recipe at the Forge / Smelter.")
	EndEvent
	
endState

;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;----------------------------------------------------------------------------- Section Toggles------------------------------------------------------------------------------------------------------------
;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

state moreHUDOptions

	event OnMenuOpenST()
		SetMenuDialogStartIndex(IndexmoreHUD)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(moreHUDChoiceList)
	endEvent

	event OnMenuAcceptST(int index)
		IndexmoreHUD = Index
		SetMenuOptionValueST(moreHUDOptions, moreHUDChoiceList[IndexmoreHUD])
		IconScript.SetMainHud(IndexmoreHUD)			
		
		ForcePageReset()
	endEvent

	event OnDefaultST()
		IndexmoreHUD = 0
		SetMenuOptionValueST(moreHUDChoiceList[IndexmoreHUD])
		IconScript.SetMainHud(IndexmoreHUD)	
	endEvent

	event OnHighlightST()
		SetInfoText("Use this menu to customize which moreHUD icons are displayed on the main HUD.\n Default: Show All Icons")
	endEvent
endState

;;-------------------------------

state moreHUDInventoryOptions

	event OnMenuOpenST()
		SetMenuDialogStartIndex(IndexmoreHUDInventory)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(moreHUDInventoryChoiceList)
	endEvent

	event OnMenuAcceptST(int index)
		IndexmoreHUDInventory = Index
		SetMenuOptionValueST(moreHUDInventoryOptions, moreHUDInventoryChoiceList[IndexmoreHUDInventory])
		IconScript.SetInventoryHud(IndexmoreHUDInventory)			
		
		ForcePageReset()
	endEvent

	event OnDefaultST()
		IndexmoreHUDInventory = 0
		SetMenuOptionValueST(moreHUDInventoryChoiceList[IndexmoreHUDInventory])
		IconScript.SetInventoryHud(IndexmoreHUDInventory)	
	endEvent

	event OnHighlightST()
		SetInfoText("Use this menu to customize which moreHUD icons are displayed in the inventory, crafting and gift menus.\n Default: Show All Icons")
	endEvent
endState

;;-------------------------------

State Disable_AchievementPerks

	function OnSelectST()
	
		Ach_Perks = !Ach_Perks 
		SetToggleOptionValueST(Ach_Perks)
	EndFunction

	Event OnHighlightST()

		SetInfoText("Some achievements will grant perk points as part of the reward, use this option to enable/disable perk point rewards.\n Default: Disabled")
	EndEvent
endState

State Enable_Highlights

	function OnSelectST()
	
		Ach_Highlight = !Ach_Highlight 
		SetToggleOptionValueST(Ach_Highlight)
	EndFunction

	Event OnHighlightST()

		SetInfoText("Use to show/hide the specific requirements for obtaining an achievement when hovering over them in the MCM.\n Default: Disabled")
	EndEvent
endState	
;;-------------------------------
		
state SoundListOptions

	event OnMenuOpenST()
		SetMenuDialogStartIndex(IndexSounds)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(AchievementSoundList)
	endEvent

	event OnMenuAcceptST(int index)
		IndexSounds = Index
		SetMenuOptionValueST(SoundListOptions, AchievementSoundList[IndexSounds])
		ForcePageReset()
	endEvent

	event OnDefaultST()
		IndexSounds = 0
		SetMenuOptionValueST(AchievementSoundList[IndexSounds])
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Use this menu to customize which sound plays when an achievement is awarded.")
	endEvent
endState

;;-------------------------------
		
state AttributeListOptions

	event OnMenuOpenST()
		SetMenuDialogStartIndex(IndexAttribute)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(AttributeList)
	endEvent

	event OnMenuAcceptST(int index)
		IndexAttribute = Index
		SetMenuOptionValueST(AttributeListOptions, AttributeList[IndexAttribute])
		ForcePageReset()
	endEvent

	event OnDefaultST()
		IndexAttribute = 0
		SetMenuOptionValueST(AttributeList[IndexAttribute])
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Use this menu to customize which attribute is increased when an achievement is awarded.\n" + "\n" + "Total Increases from achievement rewards - Health: (" + AchHealth.GetValue() as Int + ")   Stamina: (" + AchStamina.GetValue() as Int + ")   Magicka: (" + AchMagicka.GetValue() as Int + ")   Speechcraft: (" + AchSpeech.GetValue() as Int +")")  
	endEvent
endState

;;-------------------------------

state AchievementSet01

	function OnSelectST()
		Ach_Notify = !Ach_Notify
		SetToggleOptionValueST(Ach_Notify)
	EndFunction

	Event OnHighlightST()

		SetInfoText("Enable this to turn on the achievements notification system.\n Default: Enabled")
	EndEvent
endState

;;-------------------------------

state AchievementSet02

	function OnSelectST()
		Ach_Visual = !Ach_Visual 
		SetToggleOptionValueST(Ach_Visual)		
	EndFunction

	Event OnHighlightST()

		SetInfoText("Enable this to turn on the visual effect when an achievement is awarded.\n Default: Enabled")
	EndEvent
endState
	
;;-------------------------------

state ArmoryTracking

	Event OnSelectST()
		SetupAPIPage(_Museum_Section_names[0], API._ArmoryDisplayRefs, API._ArmoryDisplayNames, API._ArmoryDisplaySection)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Click to track the " + _Museum_Section_names[0] + " in the Display Tracker\n" + GetDefaultCache(CacheArmory))
	EndEvent
endState

;;-------------------------------

state DaedricGalleryTracking

	Event OnSelectST()
			SetupAPIPage(_Museum_Section_names[1], API._DaedricGalleryDisplayRefs, API._DaedricGalleryDisplayNames, API._DaedricGalleryDisplaySection)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Click to track the " + _Museum_Section_names[1] + " in the Display Tracker\n" + GetDefaultCache(CacheDaedricGallery))
	EndEvent
endState

;;-------------------------------

state DragonbornHallTracking

	Event OnSelectST()
		SetupAPIPage(_Museum_Section_names[2], API._DragonbornHallDisplayRefs, API._DragonbornHallDisplayNames, API._DragonbornHallDisplaySection)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Click to track the " + _Museum_Section_names[2] + " in the Display Tracker\n" + GetDefaultCache(CacheDragonbornhall))
	EndEvent
endState	

;;-------------------------------

state GuildhouseTracking

	Event OnSelectST()
		SetupAPIPage(_Museum_Section_names[3], API._GuildhouseDisplayRefs, API._GuildhouseDisplayNames, API._GuildhouseDisplaySection)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Click to track the " + _Museum_Section_names[3] + " in the Display Tracker\n" + GetDefaultCache(CacheGuildhouse))
	EndEvent
endState

;;-------------------------------

state HallofHeroesTracking

	Event OnSelectST()
		SetupAPIPage(_Museum_Section_names[4], API._HallofHeroesDisplayRefs, API._HallofHeroesDisplayNames, API._HallofHeroesDisplaySection)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Click to track the " + _Museum_Section_names[4] + " in the Display Tracker\n" + GetDefaultCache(CacheHallofHeroes))
	EndEvent
endState

;;-------------------------------
	
state HallofLostEmpiresTracking

	Event OnSelectST()
		SetupAPIPage(_Museum_Section_names[5], API._HallofLostEmpiresDisplayRefs, API._HallofLostEmpiresDisplayNames, API._HallofLostEmpiresDisplaySection)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Click to track the " + _Museum_Section_names[5] + " in the Display Tracker\n" + GetDefaultCache(CacheHallofLostEmpires))
	EndEvent
endState

;;-------------------------------

state HallofOdditiesTracking

	Event OnSelectST()
		SetupAPIPage(_Museum_Section_names[6], API._HallofOdditiesDisplayRefs, API._HallofOdditiesDisplayNames, API._HallofOdditiesDisplaySection)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Click to track the " + _Museum_Section_names[6] + " in the Display Tracker\n" + GetDefaultCache(CacheHallofOddities))
	EndEvent
endState

;;-------------------------------

state HallofSecretsTracking

	Event OnSelectST()
		SetupAPIPage(_Museum_Section_names[7], API._HallofSecretsDisplayRefs, API._HallofSecretsDisplayNames, API._HallofSecretsDisplaySection)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Click to track the " + _Museum_Section_names[7] + " in the Display Tracker\n" + GetDefaultCache(CacheHallofSecrets))
	EndEvent
endState

;;-------------------------------

state HallofWondersTracking


	Event OnSelectST()
		SetupAPIPage(_Museum_Section_names[8], API._HallofWondersDisplayRefs, API._HallofWondersDisplayNames, API._HallofWondersDisplaySection)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Click to track the " + _Museum_Section_names[8] + " in the Display Tracker\n" + GetDefaultCache(CacheHallofWonders))
	EndEvent
endState

;;-------------------------------

state LibraryTracking

	Event OnSelectST()
		SetupAPIPage(_Museum_Section_names[9], API._LibraryDisplayRefs, API._LibraryDisplayNames, API._LibraryDisplaySection)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Click to track the " + _Museum_Section_names[9] + " in the Display Tracker\n" + GetDefaultCache(CacheLibrary))
	EndEvent
endState

;;-------------------------------

state NaturalScienceTracking

	Event OnSelectST()
		SetupAPIPage(_Museum_Section_names[10], API._NaturalScienceDisplayRefs, API._NaturalScienceDisplayNames, API._NaturalScienceDisplaySection)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Click to track the " + _Museum_Section_names[10] + " in the Display Tracker\n" + GetDefaultCache(CacheNaturalScience))
	EndEvent
endState

;;-------------------------------

state SafehouseTracking

	Event OnSelectST()
		SetupAPIPage(_Museum_Section_names[11], API._SafehouseDisplayRefs, API._SafehouseDisplayNames, API._SafehouseDisplaySection)
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Click to track the " + _Museum_Section_names[11] + " in the Display Tracker\n" + GetDefaultCache(CacheSafehouse))
	EndEvent
endState

;;-------------------------------

state StoreroomTracking

	Event OnSelectST()
		SetupAPIPage(_Museum_Section_names[12], API._StoreroomDisplayRefs, API._StoreroomDisplayNames, API._StoreroomDisplaySection)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Click to track the " + _Museum_Section_names[12] + " in the Display Tracker\n" + GetDefaultCache(CacheStoreroom))
	EndEvent
endState

;;-------------------------------

state MiscTracking

	Event OnSelectST()
		SetupAPIPage(_Museum_Section_names[13], API._MiscDisplayRefs, API._MiscDisplayNames, API._MiscDisplaySection)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Click to track the Museum " + _Museum_Section_names[13] + " Displays in the Display Tracker\n" + GetDefaultCache(CacheMisc))
	EndEvent
endState

;;--------------------------------------------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------- Return Strings -------------------------------------
;;--------------------------------------------------------------------------------------------------------------------------------------

string function GetPrimaryDisplayCount()
	
	Int Count = 0
	Int Total = 0
	Int Index = 0 
	
	While Index < RN_Museum_Global_Count.Length
		if RN_Museum_Global_Count[Index] != none
			Count += (RN_Museum_Global_Count[Index].GetValue() as Int)
			Total += (RN_Museum_Global_Total[Index].GetValue() as Int)
		endif
		Index += 1
	endwhile

	return (Count + " / " + Total + " Displays")
endFunction

;;-------------------------------

string function GetCurrentCountInt(Int akVariable, GlobalVariable akVariableB)
	
	return (akVariable + "/" + (akVariableB.GetValue()) as Int)
endFunction

;;-------------------------------

string function GetCurrentCount(GlobalVariable akVariable, GlobalVariable akVariableB)
	
	Int Current_Count = (akVariable.GetValue()) as Int	
	Int Total_Count = (akVariableB.GetValue()) as Int

	return (Current_Count + "/" + Total_Count) as String
endFunction

;;-------------------------------

Int Function BuildTotalsArray(Int val, Globalvariable[] _array)
	
	val = 0
	Int Index = _array.length
	while Index
		Index -= 1
		if _array[Index] != None
			if _array[Index].GetValue()
				val += 1
			endif
		endif
	endWhile
	
	Return val
endFunction

;;-------------------------------

string function GetCurrentAchievementCount(GlobalVariable akVariable, formlist akTotal)

	return (akVariable.GetValue() as Int + "/" + akTotal.GetSIze() as Int)
endFunction

;;-------------------------------

string function GetCurrentArmoryCount(Int akVariable)

	return (akVariable + "/20")
endFunction

;;-------------------------------

string function GetCurrentIWCount(Int akVariable)

	return (akVariable + "/16")
endFunction	

;;-------------------------------

string function GetCurrentHACount(Int akVariable)
	
	return (akVariable + "/19")
endFunction	
		
;;-------------------------------

String function GetTotalTreasuryValue(GlobalVariable akvariable1, GlobalVariable akvariable2, GlobalVariable akvariable3)

	return ("<font color='#070091'>" + ((akvariable1.GetValue() as Int) + (akvariable2.GetValue() as Int) + (akvariable3.GetValue() as Int)) + "</font>")
endFunction

;;-------------------------------

Event OnOptionSelect(Int _Val)
	
	Int Index
		
	if CurrentPage == "Official Patches"
		Index = RN_Patches_Position_Array.find(_Val)
		if Index != -1 
			if ShowMessage("Would you like to start tracking " + RN_Patches_Name[Index] + "?", true, "Track", "Cancel")
				SetupPage(RN_Patches_Quests_Array[Index], RN_Patches_Name[Index])
			endif
		endif
		
	elseif CurrentPage == "Custom Patches"
		Index = RN_Custom_Position_Array.find(_Val)
		if Index != -1 
			if ShowMessage("Would you like to start tracking " + RN_Custom_Name[Index] + "?", true, "Track", "Cancel")	
				SetupPage(RN_Custom_Quests_Array[Index], RN_Custom_Name[Index])		
			endif
		endif

	elseif CurrentPage == "Advanced Settings"
		Index = CustomContainerPos.find(_Val)
		if (Index != -1)
			if ShowMessage("Would you like to Access or Remove " + CustomContainerRef[Index].GetDisplayName() + "?", true, "Access", "Remove")
				ShowMessage("Please Exit The MCM", false, "Ok")
				While isInMenuMode()
					Wait(0.1)
				endWhile
				CustomContainerRef[Index].Activate(Game.GetPlayer())
			else	
				if ShowMessage("Are you sure you want to remove " + CustomContainerRef[Index].GetDisplayName() + " from the custom storage list?", true, "Remove", "Cancel")	
					API.EmptyContainerToPlayer(CustomContainerRef[Index])
					API.RemoveFromTokenRefList(CustomContainerRef[Index], True)
					ForcePageReset()
				endif
			endif
		endif
		
	elseif CurrentPage == "Armoury Sets"
		Index = _Armory_Section_Position.find(_Val)
		if Index != -1 
			if ShowMessage("Would you like to start tracking the " + _Armory_Section_names[Index] + "?", true, "Track", "Cancel")
				SetupPage(None, _Armory_Section_names[Index], _Armory_Formlist_Items_Tracking.GetAt(Index) as formlist, _Armory_Formlist_Displays_Tracking.GetAt(Index) as formlist)
			endif
		else
			Index = RN_Section_Position_Array.find(_Val)
			if Index != -1 
				if ShowMessage("Would you like to start tracking the Heavy Armoury " + RN_Section_Name[Index] + "?", true, "Track", "Cancel")
					SetupPage(None, "Heavy Armoury - " + RN_Section_Name[Index], RN_Section_ItemsList.GetAt(Index) as formlist, RN_Section_DisplaysList.GetAt(Index) as formlist)
				endif
			else
				Index = RN_Section2_Position_Array.find(_Val)
				if Index != -1 
					if ShowMessage("Would you like to start tracking the Immersive Weapons " + RN_Section2_Name[Index] + "?", true, "Track", "Cancel")
						SetupPage(None, "Immersive Weapons - " + RN_Section2_Name[Index], RN_Section2_ItemsList.GetAt(Index) as formlist, RN_Section2_DisplaysList.GetAt(Index) as formlist)
					endif
				endif
			endif
		endif
	endif
EndEvent

;;-------------------------------

Event OnOptionHighlight(Int _Val)
		
	Int Index		
		
	if CurrentPage == "Official Patches"
		Index = RN_Patches_Position_Array.find(_Val)
		if Index != -1 
			SetInfoText("Click to track " + RN_Patches_Name[Index] + " in the Display Tracker.")
		endif
	elseif CurrentPage == "Custom Patches"
		Index = RN_Custom_Position_Array.find(_Val)
		if Index != -1 
			SetInfoText("Click to track " + RN_Custom_Name[Index] + " in the Display Tracker.")
		endif
	
	elseif CurrentPage == "Advanced Settings"
		Index = CustomContainerPos.find(_Val)
		if Index != -1
			SetInfoText("Click to remove " + CustomContainerRef[Index].GetDisplayName() + " from the custom storage list and transfer all displayable items back to player inventory.")
		endif
		
	elseif CurrentPage == "Armoury Sets"
		Index = _Armory_Section_Position.find(_Val)
		if Index != -1 
			SetInfoText("Click to track the " + _Armory_Section_names[Index] + " in the Display Tracker.")
		else
			Index = RN_Section_Position_Array.find(_Val)
			if Index != -1 
				SetInfoText("Click to track the Heavy Armoury - " + RN_Section_Name[Index] + " in the Display Tracker.")
			else
				Index = RN_Section2_Position_Array.find(_Val)
				if Index != -1 
					SetInfoText("Click to track the Immersive Weapons - " + RN_Section2_Name[Index] + " in the Display Tracker.")	
				endif
			endif	
		endif
	elseif CurrentPage == "Achievements"
		Index = RN_Ach_Position.find(_Val)
		if Index != -1 && Ach_Highlight
			SetInfoText(RN_Ach_Highlight[Index])
		else		
			Index = RN_ComAch_Position.find(_Val)
			if Index != -1 && Ach_Highlight
				SetInfoText(RN_ComAch_Highlight[Index])	
			endif
		endif
	endif
EndEvent

;;-------------------------------

Function Build_Arrays()	
	
	Int Index	
	
	RN_Armory_Global_Count = new globalvariable[20]
	Index = 0
	While Index < _Armory_Global_Count.GetSize()
		globalvariable akvariable = _Armory_Global_Count.GetAt(Index) as globalvariable
		RN_Armory_Global_Count[Index] = akvariable
		Index += 1
	endWhile

	RN_Armory_Global_Complete = new globalvariable[20]
	Index = 0
	While Index < _Armory_Global_Complete.GetSize()
		globalvariable akvariable = _Armory_Global_Complete.GetAt(Index) as globalvariable
		RN_Armory_Global_Complete[Index] = akvariable
		Index += 1
	endWhile

	RN_Armory_Global_Total = new globalvariable[20]
	Index = 0
	While Index < _Armory_Global_Total.GetSize()
		globalvariable akvariable = _Armory_Global_Total.GetAt(Index) as globalvariable
		RN_Armory_Global_Total[Index] = akvariable
		Index += 1
	endWhile

;;-------------------------------

	RN_Museum_Global_Complete = new globalvariable[128]
	Index = 0
	While Index < _Museum_Global_Complete.GetSize()
		globalvariable akvariable = _Museum_Global_Complete.GetAt(Index) as globalvariable
		RN_Museum_Global_Complete[Index] = akvariable
		Index += 1
	endWhile

	RN_Museum_Global_Count = new globalvariable[128]
	Index = 0
	While Index < _Museum_Global_Count.GetSize()
		globalvariable akvariable = _Museum_Global_Count.GetAt(Index) as globalvariable
		RN_Museum_Global_Count[Index] = akvariable
		Index += 1
	endWhile

	RN_Museum_Global_Total = new globalvariable[128]
	Index = 0
	While Index < _Museum_Global_Total.GetSize()
		globalvariable akvariable = _Museum_Global_Total.GetAt(Index) as globalvariable
		RN_Museum_Global_Total[Index] = akvariable
		Index += 1
	endWhile
	
	RN_Ach_Globals = new globalvariable[128]
	Index = 0
	While Index < RN_Achievement_Globals.GetSize()
		globalvariable akvariable = RN_Achievement_Globals.GetAt(Index) as globalvariable
		RN_Ach_Globals[Index] = akvariable
		Index += 1
	endWhile	

	RN_ComAch_Globals = new globalvariable[128]
	Index = 0
	While Index < RN_ComAchievement_Globals.GetSize()
		globalvariable akvariable = RN_ComAchievement_Globals.GetAt(Index) as globalvariable
		RN_ComAch_Globals[Index] = akvariable
		Index += 1
	endWhile

;;-------------------------------
	_Armory_Section_Position = new Int[128]
	_Armory_Section_names = new string[20]
	_Armory_Section_names[0] = "Ancient Nord Set"
	_Armory_Section_names[1] = "Blades Set"
	_Armory_Section_names[2] = "Daedric Set"
	_Armory_Section_names[3] = "Dawnguard Set"
	_Armory_Section_names[4] = "Dragon Set"
	_Armory_Section_names[5] = "Dwarven Set"
	_Armory_Section_names[6] = "Ebony Set"
	_Armory_Section_names[7] = "Elven Set"
	_Armory_Section_names[8] = "Falmer Set"
	_Armory_Section_names[9] = "Forsworn Set"
	_Armory_Section_names[10] = "Glass Set"
	_Armory_Section_names[11] = "Guard Armor Set"
	_Armory_Section_names[12] = "Iron Set"
	_Armory_Section_names[13] = "Misc Set"
	_Armory_Section_names[14] = "Nordic Set"
	_Armory_Section_names[15] = "Orcish Set"
	_Armory_Section_names[16] = "Snow Elf Set"
	_Armory_Section_names[17] = "Stalhrim Set"
	_Armory_Section_names[18] = "Steel Set"
	_Armory_Section_names[19] = "Thane Weapons Set"

	_Museum_Section_names = new string[128]
	_Museum_Section_names[0] = "Armoury"
	_Museum_Section_names[1] = "Daedric Gallery"
	_Museum_Section_names[2] = "Dragonborn Hall"
	_Museum_Section_names[3] = "Guildhouse"
	_Museum_Section_names[4] = "Hall of Heroes"
	_Museum_Section_names[5] = "Hall of Lost Empires"
	_Museum_Section_names[6] = "Hall of Oddities"
	_Museum_Section_names[7] = "Hall of Secrets"
	_Museum_Section_names[8] = "Hall of Wonders"
	_Museum_Section_names[9] = "Library"
	_Museum_Section_names[10] = "Natural Science"
	_Museum_Section_names[11] = "Safehouse"
	_Museum_Section_names[12] = "Storeroom"
	_Museum_Section_names[13] = "Miscellaneous"
	
	_Museum_Section_States = new string[128]
	_Museum_Section_States[0] = "ArmoryTracking"
	_Museum_Section_States[1] = "DaedricGalleryTracking"
	_Museum_Section_States[2] = "DragonbornHallTracking"
	_Museum_Section_States[3] = "GuildhouseTracking"
	_Museum_Section_States[4] = "HallofHeroesTracking"
	_Museum_Section_States[5] = "HallofLostEmpiresTracking"
	_Museum_Section_States[6] = "HallofOdditiesTracking"
	_Museum_Section_States[7] = "HallofSecretsTracking"
	_Museum_Section_States[8] = "HallofWondersTracking"
	_Museum_Section_States[9] = "LibraryTracking"
	_Museum_Section_States[10] = "NaturalScienceTracking"
	_Museum_Section_States[11] = "SafehouseTracking"
	_Museum_Section_States[12] = "StoreroomTracking"
	_Museum_Section_States[13] = "MiscTracking"

	RN_Ach_Highlight = new string[128]
	RN_Ach_Highlight[0] = "Reach a total of 500 displays in the Museum"
	RN_Ach_Highlight[1] = "Reach a total of 750 displays in the Museum\n *Completing this achievement rewards a unique displayable item"
	RN_Ach_Highlight[2] = "Reach a total of 1000 displays in the Museum\n *Completing this achievement rewards a unique displayable item"
	RN_Ach_Highlight[3] = "Reach a total of 100 book displays in the Museum"
	RN_Ach_Highlight[4] = "Reach a total of 250 book displays in the Museum\n *Completing this achievement rewards a unique displayable item"
	RN_Ach_Highlight[5] = "Find and display all the Explorer Relics in the Guildhouse\n *Completing this achievement rewards a unique displayable item"
	RN_Ach_Highlight[6] = "Find and display all the Gems in the Gallery of Natural Science"
	RN_Ach_Highlight[7] = "Find and display all the Shells for the Tide Pool in the Gallery of Natural Science"
	RN_Ach_Highlight[8] = "Find and display all 10 Decks of Cards in the Hall of Oddities"
	RN_Ach_Highlight[9] = "Find and display the complete Coin Collection in the Hall of Oddities"
	RN_Ach_Highlight[10] = "Complete all side quests from Auryen's Notes"
	RN_Ach_Highlight[11] = "Locate and interact with all Standing Stones around Skyrim"
	RN_Ach_Highlight[12] = "Locate and interact with all Word Walls around Skyrim"
	RN_Ach_Highlight[13] = "Find and display all Dragon Priest Masks and Dragon Claws in the Hall of Heroes"	
	RN_Ach_Highlight[14] = "Help the people of Skyrim and become the Thane of every Hold"
	RN_Ach_Highlight[15] = "Find and display all the pieces from the Arms of the Crusader set in the Hall of Heroes"
	RN_Ach_Highlight[16] = "Visit Solitude and complete the Legacy starting quest to open the Museum"
	RN_Ach_Highlight[17] = "Find and display all the Black Books in the Daedric Gallery"
	RN_Ach_Highlight[18] = "Fill the Armoury and reach a Smithing level of 100, this achievement does not count items from supported mods"
	RN_Ach_Highlight[19] = "Build all creature displays in the Gallery of Natural Science"
	RN_Ach_Highlight[20] = "Locate and interact with the 9 Shrines of the Divines around Skyrim"
	RN_Ach_Highlight[21] = "Locate or craft all Dwemer artifacts in the Reception Hall"
	RN_Ach_Highlight[22] = "Locate or craft all Falmer artifacts in the Reception Hall"
	RN_Ach_Highlight[23] = "Locate or craft all Nordic artifacts in the Reception Hall"
	RN_Ach_Highlight[24] = "Agree to help Brother Ikard and don't skip the Haunted Museum quest"
	RN_Ach_Highlight[25] = "Display all Museum Paintings"
	RN_Ach_Highlight[26] = "Complete all Excavations and roll the credits"
	RN_Ach_Highlight[27] = "Build all the Explorer Outposts\n *Completing this achievement rewards a unique displayable item"
	RN_Ach_Highlight[28] = "Forgive Avram after Shadows of One's Past"
	RN_Ach_Highlight[29] = "Become a Master of each spell school"
	RN_Ach_Highlight[30] = "Find and display Ice's Stalhrim Spoon of Assassination"
	RN_Ach_Highlight[31] = "Renovate Deepholme"
	RN_Ach_Highlight[32] = "Display all Guild Displays in the Dragonborn Hall\n *Completing this achievement rewards a unique displayable item"
	RN_Ach_Highlight[33] = "Complete all Daedric Quests \n *Completing this achievement rewards a unique displayable item"
	RN_Ach_Highlight[34] = "Take all that gold and fill the Treasury!"
	RN_Ach_Highlight[35] = "Take all perks from the Excavation skill tree" 
	RN_Ach_Highlight[36] = "Take all perks from the Expedition skill tree"
	RN_Ach_Highlight[37] = "Take all perks from the Academia skill tree"
	
	RN_Ach_Position = new int[128]
	RN_Ach_AchName = new string[128]
	RN_Ach_AchName[0] = "Hobbyist"
	RN_Ach_AchName[1] = "Collector*"
	RN_Ach_AchName[2] = "Hoarder*"
	RN_Ach_AchName[3] = "Junior Librarian"
	RN_Ach_AchName[4] = "Bibliophile*"
	RN_Ach_AchName[5] = "Spelunker*"
	RN_Ach_AchName[6] = "Lapidarist"
	RN_Ach_AchName[7] = "Conchologist"
	RN_Ach_AchName[8] = "Fusilatelist"
	RN_Ach_AchName[9] = "Numismatist"
	RN_Ach_AchName[10] = "Expert Sleuth"
	RN_Ach_AchName[11] = "Pillar of Nirn"
	RN_Ach_AchName[12] = "Noise Complaint"
	RN_Ach_AchName[13] = "Masquerader"	
	RN_Ach_AchName[14] = "That's Sir Thane to You"
	RN_Ach_AchName[15] = "Guardian of the Divine"
	RN_Ach_AchName[16] = "Cut the Ribbon"
	RN_Ach_AchName[17] = "Tentacle Afficianado"
	RN_Ach_AchName[18] = "Temper Tantrum"
	RN_Ach_AchName[19] = "Taxidermist"
	RN_Ach_AchName[20] = "By All of the Gods!"
	RN_Ach_AchName[21] = "Gearhead"
	RN_Ach_AchName[22] = "Blind Construction"
	RN_Ach_AchName[23] = "Children of the Sky"
	RN_Ach_AchName[24] = "Ghostbuster"
	RN_Ach_AchName[25] = "Canvas Collector"
	RN_Ach_AchName[26] = "That's all Folks"
	RN_Ach_AchName[27] = "Expansionist*"
	RN_Ach_AchName[28] = "Forgive and Forget"
	RN_Ach_AchName[29] = "Yer a Wizard "
	RN_Ach_AchName[30] = "Master of Secrets"
	RN_Ach_AchName[31] = "Deep Pockets"
	RN_Ach_AchName[32] = "Guild Master Master*"
	RN_Ach_AchName[33] = "Champion of All*"
	RN_Ach_AchName[34] = "Midas Touch"
	RN_Ach_AchName[35] = "Deft Digger"
	RN_Ach_AchName[36] = "Expedient"
	RN_Ach_AchName[37] = "Professor"
	
	RN_ComAch_Position = new int[128]
	RN_ComAch_AchName = new string[128]
	RN_ComAch_AchName[0] = "Edward Daggerhands"
	RN_ComAch_AchName[1] = "Head Honcho"
	RN_ComAch_AchName[2] = "Don't ask where I got them"
	RN_ComAch_AchName[3] = "Food of the Gods"
	RN_ComAch_AchName[4] = "One Small Step"
	RN_ComAch_AchName[5] = "Jade Emperor*"
	RN_ComAch_AchName[6] = "Bibbidi-Bobbidi-Boo"
	RN_ComAch_AchName[7] = "Sommelier"
	RN_ComAch_AchName[8] = "Ic0nic Collector"
	RN_ComAch_AchName[9] = "Franchise"
	RN_ComAch_AchName[10] = "X Marker"
	RN_ComAch_AchName[11] = "Culture Cultivator"

	RN_ComAch_Highlight = new string[128]
	RN_ComAch_Highlight[0] = "Fill up the dagger display in the Hall of Heroes\n Achievement idea by: NGIS"
	RN_ComAch_Highlight[1] = "Fill up the helmet display in the Hall of Heroes\n Achievement idea by: NGIS"
	RN_ComAch_Highlight[2] = "Find and display all skulls in the Hall of Secrets\n Achievement idea by: WillowWisp"
	RN_ComAch_Highlight[3] = "Take home a snack from Sovngarde\n Achievement idea by: WillowWisp"
	RN_ComAch_Highlight[4] = "Locate and display all the planetarium cubes\n Achievement idea by: WillowWisp"
	RN_ComAch_Highlight[5] = "Collect and display all the Jade statues\n Achievement idea by: Megalorex\n *Completing this achievement rewards a unique displayable item"
	RN_ComAch_Highlight[6] = "Fill the magic staff display in the Hall of Heroes\n Achievement idea by: Captain Blob-eye"
	RN_ComAch_Highlight[7] = "Display all beverages in the Museum Storeroom\n Achievement idea by: NGIS"
	RN_ComAch_Highlight[8] = "Collect and display all the unique items from The Curators Companion\n Achievement idea by: Captain Blob-eye"
	RN_ComAch_Highlight[9] = "Display the Elder Scrolls\n Achievement idea by: NGIS"
	RN_ComAch_Highlight[10] = "Find and display all treasure maps in the library\n Achievement idea by: WillowWisp"
	RN_ComAch_Highlight[11] = "Discover all the culture displays for the Hall of Heroes\n Achievement idea by: Kriana"

    HexDigits = New String[16]
    HexDigits[0] = "0"
    HexDigits[1] = "1"
    HexDigits[2] = "2"
    HexDigits[3] = "3"
    HexDigits[4] = "4"
    HexDigits[5] = "5"
    HexDigits[6] = "6"
    HexDigits[7] = "7"
    HexDigits[8] = "8"
    HexDigits[9] = "9"
    HexDigits[10] = "a"
    HexDigits[11] = "b"
    HexDigits[12] = "c"
    HexDigits[13] = "d"
    HexDigits[14] = "e"
    HexDigits[15] = "f"
endFunction
		
;;-------------------------------
	
Function AddModSupport(GlobalVariable _GVComplete, GlobalVariable _GVCount, GlobalVariable _GVTotal, String _ModName, GlobalVariable akTotal, Quest _Quest)
	
	Int Index = GetArrayPos(_ModName)
	if Index == 999
		Index = RN_Patches_Complete_Array.Find(none)
		RN_Patches_Name[Index] = _ModName
		RN_Patches_Complete_Array[Index] = _GVComplete
		RN_Patches_Count_Array[Index] = _GVCount
		RN_Patches_Total_Array[Index] = _GVTotal
		RN_Patches_Quests_Array[Index] = _Quest
		akTotal.Mod(1)
	else
		RN_Patches_Name[Index] = _ModName
		RN_Patches_Complete_Array[Index] = _GVComplete
		RN_Patches_Count_Array[Index] = _GVCount
		RN_Patches_Total_Array[Index] = _GVTotal
		RN_Patches_Quests_Array[Index] = _Quest
		akTotal.Mod(1)
	endif
	
	TCCDebug.Log("MCM Registered Official Patch [" + _ModName + "] at position " + Index, 0)
endFunction

;;-------------------------------
	
Function AddCustomModSupport(GlobalVariable _GVComplete, GlobalVariable _GVCount, GlobalVariable _GVTotal, String _ModName, GlobalVariable akTotal, Quest _Quest)
	
	Int Index = RN_Custom_Name.Find(_ModName)
	if Index == -1
		Index = RN_Custom_Name.Find("")
		RN_Custom_Name[Index] = _ModName
		RN_Custom_Complete_Array[Index] = _GVComplete
		RN_Custom_Count_Array[Index] = _GVCount
		RN_Custom_Total_Array[Index] = _GVTotal
		RN_Custom_Quests_Array[Index] = _Quest
		akTotal.Mod(1)
	else
		RN_Custom_Name[Index] = _ModName
		RN_Custom_Complete_Array[Index] = _GVComplete
		RN_Custom_Count_Array[Index] = _GVCount
		RN_Custom_Total_Array[Index] = _GVTotal	
		RN_Custom_Quests_Array[Index] = _Quest
		akTotal.Mod(1)
	endif
	
	TCCDebug.Log("MCM Registered Custom Patch [" + _ModName + "] at position " + Index, 0)
endFunction

;;-------------------------------
	
Function AddSectionSupport(Formlist Count, Formlist Total, Formlist Complete, String _ModName, String[] _SectionName, Formlist ItemsList, Formlist DisplayList)
	
	Int Index
	
	if _ModName == "Heavy Armory"
		
		Index = _SectionName.length
		Index_Section = Index
		While  Index
			Index -= 1
			RN_Section_Name[Index] = _SectionName[Index]
			RN_Section_Complete_Array[Index] = Complete.GetAt(Index) as GlobalVariable
			RN_Section_Count_Array[Index] = Count.GetAt(Index) as GlobalVariable
			RN_Section_Total_Array[Index] = Total.GetAt(Index) as GlobalVariable
			TCCDebug.Log("MCM Registered Heavy Armory Section [" + _SectionName[Index] + "] at position " + Index, 0)
		endWhile

		RN_Section_ItemsList = ItemsList
		RN_Section_DisplaysList = DisplayList
			
	elseif _ModName == "Immersive Weapons"

		Index = _SectionName.length
		Index_Section2 = Index
		While  Index
			Index -= 1
			RN_Section2_Name[Index] = _SectionName[Index]
			RN_Section2_Complete_Array[Index] = Complete.GetAt(Index) as GlobalVariable
			RN_Section2_Count_Array[Index] = Count.GetAt(Index) as GlobalVariable
			RN_Section2_Total_Array[Index] = Total.GetAt(Index) as GlobalVariable
			TCCDebug.Log("MCM Registered Immersive Weapons Section [" + _SectionName[Index] + "] at position " + Index, 0)
		endWhile

		RN_Section2_ItemsList = ItemsList as Formlist
		RN_Section2_DisplaysList = DisplayList as FOrmlist
	endif
endFunction

;;-------------------------------

Function BuildPatchArray(bool CreateArrays, bool UpdateRegistrations, bool UpdateCounts, bool UpdateTracking)
	
	if CreateArrays
		TCCDebug.Log("MCM - Building Patch Array", 0)
		
		RN_Patches_Complete_Array = new globalvariable[128]
		RN_Patches_Count_Array = new globalvariable[128]
		RN_Patches_Total_Array = new globalvariable[128]
		RN_Patches_Quests_Array = new quest[128]
		RN_Patches_Position_Array = new int[128]
		RN_Patches_Name = new string[128]
		
		RN_Custom_Complete_Array = new globalvariable[128]
		RN_Custom_Count_Array = new globalvariable[128]
		RN_Custom_Total_Array = new globalvariable[128]
		RN_Custom_Quests_Array = new quest[128]
		RN_Custom_Position_Array = new int[128]
		RN_Custom_Name = new string[128]

		RN_Section_Complete_Array = new globalvariable[128]
		RN_Section_Count_Array = new globalvariable[128]
		RN_Section_Total_Array = new globalvariable[128]
		RN_Section_Position_Array = new int[128]
		RN_Section_Name = new string[128]
		
		RN_Section2_Complete_Array = new globalvariable[128]
		RN_Section2_Count_Array = new globalvariable[128]
		RN_Section2_Total_Array = new globalvariable[128]
		RN_Section2_Position_Array = new int[128]
		RN_Section2_Name = new string[128]
	endif
	
	if UpdateRegistrations
		API.UpdateArrays()
	endif
	
	if UpdateCounts
		API.UpdateCounts()
		Util.InitGlobals()
	endif

	if UpdateTracking
		API.UpdateTracking()
	endif
endFunction

;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;------------------------------------------------------------------------------ Caching Functions --------------------------------------------------------------------------------------------------------
;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Bool function IsSectionCached(String RoomName)
	
	if (RoomName == _Museum_Section_names[0]) && (CacheArmory)
		return true
	elseif (RoomName == _Museum_Section_names[1]) && (CacheDaedricGallery)
		return true	
	elseif (RoomName == _Museum_Section_names[2]) && (CacheDragonbornhall)
		return true
	elseif (RoomName == _Museum_Section_names[3]) && (CacheGuildhouse)
		return true
	elseif (RoomName == _Museum_Section_names[4]) && (CacheHallofHeroes)
		return true
	elseif (RoomName == _Museum_Section_names[5]) && (CacheHallofLostEmpires)
		return true
	elseif (RoomName == _Museum_Section_names[6]) && (CacheHallofOddities)
		return true
	elseif (RoomName == _Museum_Section_names[7]) && (CacheHallofSecrets)
		return true
	elseif (RoomName == _Museum_Section_names[8]) && (CacheHallofWonders)
		return true
	elseif (RoomName == _Museum_Section_names[9]) && (CacheLibrary)
		return true
	elseif (RoomName == _Museum_Section_names[10]) && (CacheNaturalScience)
		return true
	elseif (RoomName == _Museum_Section_names[11]) && (CacheSafehouse)
		return true
	elseif (RoomName == _Museum_Section_names[12]) && (CacheStoreroom)
		return true
	elseif (RoomName == _Museum_Section_names[13]) && (CacheMisc)
		return true
	endif	
	
	return False
endFunction
	
;;-------------------------------

function SetCacheDone(String RoomName)
	
	if (RoomName == _Museum_Section_names[0])
		CacheArmory = true
		CacheArmoryPages = PagesRequired
		
	elseif (RoomName == _Museum_Section_names[1])
		CacheDaedricGallery = true	
		CacheDaedricGalleryPages = PagesRequired
		
	elseif (RoomName == _Museum_Section_names[2])
		CacheDragonbornhall = true
		CacheDragonbornhallPages = PagesRequired
		
	elseif (RoomName == _Museum_Section_names[3])
		CacheGuildhouse = true
		CacheGuildhousePages = PagesRequired
		
	elseif (RoomName == _Museum_Section_names[4])
		CacheHallofHeroes = true
		CacheHallofHeroesPages = PagesRequired
		
	elseif (RoomName == _Museum_Section_names[5])
		CacheHallofLostEmpires = true
		CacheHallofLostEmpiresPages = PagesRequired
		
	elseif (RoomName == _Museum_Section_names[6])
		CacheHallofOddities = true
		CacheHallofOdditiesPages = PagesRequired
		
	elseif (RoomName == _Museum_Section_names[7])
		CacheHallofSecrets = true
		CacheHallofSecretsPages = PagesRequired
		
	elseif (RoomName ==_Museum_Section_names[8])
		CacheHallofWonders = true
		CacheHallofWondersPages = PagesRequired
		
	elseif (RoomName == _Museum_Section_names[9])
		CacheLibrary = true
		CacheLibraryPages = PagesRequired
		
	elseif (RoomName == _Museum_Section_names[10])
		CacheNaturalScience = true
		CacheNaturalSciencePages = PagesRequired
		
	elseif (RoomName == _Museum_Section_names[11])
		CacheSafehouse = true
		CacheSafehousePages = PagesRequired
		
	elseif (RoomName == _Museum_Section_names[12])
		CacheStoreroom = true
		CacheStoreroomPages = PagesRequired
		
	elseif (RoomName == _Museum_Section_names[13])
		CacheMisc = true
		CacheMiscPages = PagesRequired
	endif
endFunction

;;-------------------------------

function ClearCachedData(Int Index)

	if (Index == 1)
		CacheArmory = False
		CacheArmoryPages = 0
		
	elseif (Index == 2)
		CacheDaedricGallery = False	
		CacheDaedricGalleryPages = 0
		
	elseif (Index == 3)
		CacheDragonbornhall = False
		CacheDragonbornhallPages = 0

	elseif (Index == 4)
		CacheGuildhouse = False
		CacheGuildhousePages = 0

	elseif (Index == 5)
		CacheHallofHeroes = False
		CacheHallofHeroesPages = 0

	elseif (Index == 6)
		CacheHallofLostEmpires = False
		CacheHallofLostEmpiresPages = 0

	elseif (Index == 7)
		CacheHallofOddities = False
		CacheHallofOdditiesPages = 0

	elseif (Index == 8)
		CacheHallofSecrets = False
		CacheHallofSecretsPages = 0

	elseif (Index == 9)
		CacheHallofWonders = False
		CacheHallofWondersPages = 0

	elseif (Index == 10)
		CacheLibrary = False
		CacheLibraryPages = 0
		
	elseif (Index == 11)
		CacheNaturalScience = False
		CacheNaturalSciencePages = 0

	elseif (Index == 12)
		CacheSafehouse = False
		CacheSafehousePages = 0

	elseif (Index == 13)
		CacheStoreroom = False
		CacheStoreroomPages = 0

	elseif (Index == 14)
		CacheMisc = False
		CacheMiscPages = 0
	endif
endFunction

;;-------------------------------
	
function GetCacheData(String RoomName)
	
	Int Index
	
	if (RoomName == _Museum_Section_names[0])
		Index = CacheArmoryPages
		
	elseif (RoomName == _Museum_Section_names[1])
		CacheDaedricGallery = true	
		Index = CacheDaedricGalleryPages
		
	elseif (RoomName == _Museum_Section_names[2])
		CacheDragonbornhall = true
		Index = CacheDragonbornhallPages

	elseif (RoomName == _Museum_Section_names[3])
		CacheGuildhouse = true
		Index = CacheGuildhousePages

	elseif (RoomName == _Museum_Section_names[4])
		CacheHallofHeroes = true
		Index = CacheHallofHeroesPages

	elseif (RoomName == _Museum_Section_names[5])
		CacheHallofLostEmpires = true
		Index = CacheHallofLostEmpiresPages

	elseif (RoomName == _Museum_Section_names[6])
		CacheHallofOddities = true
		Index = CacheHallofOdditiesPages

	elseif (RoomName == _Museum_Section_names[7])
		CacheHallofSecrets = true
		Index = CacheHallofSecretsPages

	elseif (RoomName ==_Museum_Section_names[8])
		CacheHallofWonders = true
		Index = CacheHallofWondersPages

	elseif (RoomName == _Museum_Section_names[9])
		CacheLibrary = true
		Index = CacheLibraryPages
		
	elseif (RoomName == _Museum_Section_names[10])
		CacheNaturalScience = true
		Index = CacheNaturalSciencePages

	elseif (RoomName == _Museum_Section_names[11])
		CacheSafehouse = true
		Index = CacheSafehousePages

	elseif (RoomName == _Museum_Section_names[12])
		CacheStoreroom = true
		Index = CacheStoreroomPages

	elseif (RoomName == _Museum_Section_names[13])
		CacheMisc = true
		Index = CacheMiscPages
	endif
	
	LoadPages(Index)
endFunction

;;-------------------------------

function LoadPages(Int Index)
	
	if (Index == 10)
		Page1 = True
		Page2 = True
		Page3 = True
		Page4 = True
		Page5 = True
		Page6 = True
		Page7 = True
		Page8 = True
		Page9 = True
		Page10 = True
	
	elseif (Index == 9)
		Page1 = True
		Page2 = True
		Page3 = True
		Page4 = True
		Page5 = True
		Page6 = True
		Page7 = True
		Page8 = True
		Page9 = True
		Page10 = False	

	elseif (Index == 8)
		Page1 = True
		Page2 = True
		Page3 = True
		Page4 = True
		Page5 = True
		Page6 = True
		Page7 = True
		Page8 = True
		Page9 = False
		Page10 = False

	elseif (Index == 7)
		Page1 = True
		Page2 = True
		Page3 = True
		Page4 = True
		Page5 = True
		Page6 = True
		Page7 = True
		Page8 = False
		Page9 = False
		Page10 = False

	elseif (Index == 6)
		Page1 = True
		Page2 = True
		Page3 = True
		Page4 = True
		Page5 = True
		Page6 = True
		Page7 = False
		Page8 = False
		Page9 = False
		Page10 = False

	elseif (Index == 5)
		Page1 = True
		Page2 = True
		Page3 = True
		Page4 = True
		Page5 = True
		Page6 = False
		Page7 = False
		Page8 = False
		Page9 = False
		Page10 = False

	elseif (Index == 4)
		Page1 = True
		Page2 = True
		Page3 = True
		Page4 = True
		Page5 = False
		Page6 = False
		Page7 = False
		Page8 = False
		Page9 = False
		Page10 = False	

	elseif (Index == 3)
		Page1 = True
		Page2 = True
		Page3 = True
		Page4 = False
		Page5 = False
		Page6 = False
		Page7 = False
		Page8 = False
		Page9 = False
		Page10 = False

	elseif (Index == 2)
		Page1 = True
		Page2 = True
		Page3 = False
		Page4 = False
		Page5 = False
		Page6 = False
		Page7 = False
		Page8 = False
		Page9 = False
		Page10 = False

	elseif (Index == 1)
		Page1 = True
		Page2 = False
		Page3 = False
		Page4 = False
		Page5 = False
		Page6 = False
		Page7 = False
		Page8 = False
		Page9 = False
		Page10 = False
	endIf
endfunction

;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;----------------------------------------------------------------------------- Tracking Functions --------------------------------------------------------------------------------------------------------
;;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Function SetupPage(Quest Patch, String _Name, Formlist _Items = None, Formlist _Displays = None)

	TrackedNames = new string[128]
	TrackedNames2 = new string[128]
	TrackedNames3 = new string[128]
	TrackedNames4 = new string[128]
	TrackedNames5 = new string[128]
	TrackedNames6 = new string[128]
	TrackedNames7 = new string[128]
	TrackedNames8 = new string[128]
	TrackedNames9 = new string[128]
	TrackedNames10 = new string[128]
	TrackedDisplays = new objectreference[128]
	TrackedDisplays2 = new objectreference[128]
	TrackedDisplays3 = new objectreference[128]
	TrackedDisplays4 = new objectreference[128]
	TrackedDisplays5 = new objectreference[128]
	TrackedDisplays6 = new objectreference[128]
	TrackedDisplays7 = new objectreference[128]
	TrackedDisplays8 = new objectreference[128]
	TrackedDisplays9 = new objectreference[128]
	TrackedDisplays10 = new objectreference[128]	
	
	TrackedQuest = Patch
	TrackedPatch = _Name
	
	Page1 = True
	Page2 = False
	Page3 = False
	Page4 = False
	Page5 = False
	Page6 = False
	Page7 = False
	Page8 = False
	Page9 = False
	Page10 = False
	
	HEADERSREQUIRED = False
	
	if (Patch)
		SetTrackerArray()
	else
		SetTrackerSection(_Items, _Displays)
	endif

	SetTitleText("=== Finalizing ===")
	
	AddDynamicPagesList()
	
	ShowMessage(TrackedPatch + " Display Tracking Ready!", false, "Ok")
	
	if Page2 || Page3 || Page4 || Page5
		SetTitleText("=== please Re-Enter The MCM ===")
	else
		SetTitleText(CurrentPage)
	endif
endFunction

;;-------------------------------

Function SetupAPIPage(String _Name = "", Formlist[] DisplayList, Formlist[] ItemList, String[] Header)
	
	TrackedNames = new string[128]
	TrackedNames2 = new string[128]
	TrackedNames3 = new string[128]
	TrackedNames4 = new string[128]
	TrackedNames5 = new string[128]
	TrackedNames6 = new string[128]
	TrackedNames7 = new string[128]
	TrackedNames8 = new string[128]
	TrackedNames9 = new string[128]
	TrackedNames10 = new string[128]
	TrackedDisplays = new objectreference[128]
	TrackedDisplays2 = new objectreference[128]
	TrackedDisplays3 = new objectreference[128]
	TrackedDisplays4 = new objectreference[128]
	TrackedDisplays5 = new objectreference[128]
	TrackedDisplays6 = new objectreference[128]
	TrackedDisplays7 = new objectreference[128]
	TrackedDisplays8 = new objectreference[128]
	TrackedDisplays9 = new objectreference[128]
	TrackedDisplays10 = new objectreference[128]	
	
	TrackedQuest = None
	TrackedPatch = _Name
	
	Page1 = True
	Page2 = False
	Page3 = False
	Page4 = False
	Page5 = False
	Page6 = False
	Page7 = False
	Page8 = False
	Page9 = False
	Page10 = False
		
	HEADERSREQUIRED = True

	if IsSectionCached(_Name)
		SetTitleText("=== Loading Cache ===")
		MCMCache.LoadCache(_Name)
		GetCacheData(_Name)
	else
		SetTrackerDisplays(DisplayList, ItemList, Header, _Name)
		SetTitleText("=== Caching Displays ===")
		MCMCache.CacheDisplays(_Name)
		SetCacheDone(_Name)
	endIf
	
	SetTitleText("=== Finalizing ===")
	
	AddDynamicPagesList()
	
	ShowMessage(TrackedPatch + " Display Tracking Ready!", false, "Ok")
	
	if Page2 || Page3 || Page4 || Page5 || Page6 || Page7 || Page8 || Page9 || Page10
		SetTitleText("=== please Re-Enter The MCM ===")
	else
		SetTitleText(CurrentPage)
	endif
endFunction

;;-------------------------------

Function SetTrackerArray()
	DBMSupportedModScript SupportPatch = (TrackedQuest as DBMSupportedModScript)

	TempDispArray = new objectreference[128]
	TempNameArray = new string[128]
	
	Int P = 0	
	Int A = 0
	Int PageSet = 1
	
	SetNextPage(1)
	
	While (A < SupportPatch.NewSectionDisplayRefLists.length)
			
		Formlist flist = SupportPatch.NewSectionItemLists[A] as Formlist
		Formlist Dlist = SupportPatch.NewSectionDisplayRefLists[A] as Formlist					

		Int Index = 0
		While Index < Dlist.GetSize()		

			if (P >= 126)
				PageSet += 1
				SetNextPage(PageSet)				
				P = 0
			endIf
				
			Form fDisp = Dlist.GetAt(Index)
			Form fItem = flist.GetAt(Index)
			ObjectReference DispRef = None	
		
			if fDisp as FormList
				FormList NestedList = fDisp as FormList
				int Index3 = NestedList.GetSize()
				while Index3 && !DispRef
					Index3 -= 1
					ObjectReference TDisp = NestedList.GetAt(Index3) as ObjectReference
					if TDisp && TDisp.IsEnabled()
						DispRef = TDisp
						if fItem as FormList
							fItem = (fItem as Formlist).GetAt(Index3)
						endif
					endif
				endwhile
				if !DispRef
					DispRef = (NestedList.GetAt(0) as ObjectReference)
				endif
			elseif fDisp 
				DispRef = fDisp as ObjectReference
			endif

			String DispName
			if fItem
				if fItem as FormList
					DispName = (fItem as FormList).GetAt(0).GetName()
				else
					DispName = fItem.GetName()
				endif
			else
				DispName = "!Error"
			endif
				
			TempNameArray[P] = DispName
			TempDispArray[P] = DispRef			
			P += 1
		
			Index += 1
		endwhile
	
		A += 1
	endWhile
endFunction

;;-------------------------------

Function SetTrackerSection(Formlist AfListA = None, Formlist afListB = None)

	TempDispArray = new objectreference[128]
	TempNameArray = new string[128]
	
	Int P = 0	
	Int PageSet = 1
	
	SetNextPage(1)
		
	Formlist flist = AfListA as Formlist
	Formlist Dlist = afListB as Formlist	

	Int Index = 0
	While Index < Dlist.GetSize()		

		if (P >= 126)
			PageSet += 1
			SetNextPage(PageSet)				
			P = 0
		endIf
	
		Form fDisp = Dlist.GetAt(Index)
		Form fItem = flist.GetAt(Index)
		ObjectReference DispRef = None	

		if fDisp as FormList
			FormList NestedList = fDisp as FormList
			int Index3 = NestedList.GetSize()
			while Index3 && !DispRef
				Index3 -= 1
				ObjectReference TDisp = NestedList.GetAt(Index3) as ObjectReference
				if TDisp && TDisp.IsEnabled()
					DispRef = TDisp
					if fItem as FormList
						fItem = (fItem as Formlist).GetAt(Index3)
					endif
				endif
			endwhile
			if !DispRef
				DispRef = (NestedList.GetAt(0) as ObjectReference)
			endif
		elseif fDisp 
			DispRef = fDisp as ObjectReference
		endif

		String DispName
		if fItem
			if fItem as FormList
				DispName = (fItem as FormList).GetAt(0).GetName()
			else
				DispName = fItem.GetName()
			endif
		else
			DispName = "!Error"
		endif
		
		TempNameArray[P] = DispName
		TempDispArray[P] = DispRef			
		P += 1
	
		Index += 1
	endwhile
endFunction

;;-------------------------------

Function SetTrackerDisplays(Formlist[] DisplayArray = None, FormList[] NamesArray = None, String[] Header = None, String RoomName)

	TempDispArray = new objectreference[128]
	TempNameArray = new string[128]
	
	Int P = 0	
	Int A = 0
	Int PageSet = 1
	
	SetNextPage(1)
	
	While (A < DisplayArray.Length) && (DisplayArray[A] != None)	
		
		if P != 0
			P += 1
		endIf
		
		TempNameArray[P] = Header[A]
		TempDispArray[P] = TCC_HEADER_TO_REPLACE
		P += 1	
		
		Formlist flist = NamesArray[A] as Formlist
		Formlist Dlist = DisplayArray[A] as Formlist		
	
		Int Index = 0
		While Index < Dlist.GetSize()		

			if (P >= 126)
				PageSet += 1
				SetNextPage(PageSet)				
				P = 0
			endIf
			
			Form fDisp = Dlist.GetAt(Index)
			Form fItem = flist.GetAt(Index)
			ObjectReference DispRef = None	
		
			if fDisp as FormList
				FormList NestedList = fDisp as FormList
				int Index3 = NestedList.GetSize()
				while Index3 && !DispRef
					Index3 -= 1
					ObjectReference TDisp = NestedList.GetAt(Index3) as ObjectReference
					if TDisp && TDisp.IsEnabled()
						DispRef = TDisp
						if fItem as FormList
							fItem = (fItem as Formlist).GetAt(Index3)
						endif
					endif
				endwhile
				if !DispRef
					DispRef = (NestedList.GetAt(0) as ObjectReference)
				endif
			elseif fDisp 
				DispRef = fDisp as ObjectReference
			endif

			String DispName
			if fItem
				if fItem as FormList
					DispName = (fItem as FormList).GetAt(0).GetName()
				else
					DispName = fItem.GetName()
				endif
			else
				DispName = "!Error"
			endif
			
			TempNameArray[P] = DispName
			TempDispArray[P] = DispRef			
			P += 1
		
			Index += 1
		endwhile
	
		A += 1
	endWhile
endFunction

;;-------------------------------

function SetNextPage(Int Page)
	
	SetTitleText("=== Building Page " + Page + "  ===")
	PagesRequired = Page
	LoadPages(PagesRequired)
	
	if (Page == 1)
		TempDispArray = TrackedDisplays
		TempNameArray = TrackedNames
		
	elseif (Page == 2)
		TempDispArray = TrackedDisplays2
		TempNameArray = TrackedNames2

	elseif (Page == 3)
		TempDispArray = TrackedDisplays3
		TempNameArray = TrackedNames3

	elseif (Page == 4)
		TempDispArray = TrackedDisplays4
		TempNameArray = TrackedNames4	

	elseif (Page == 5)
		TempDispArray = TrackedDisplays5
		TempNameArray = TrackedNames5

	elseif (Page == 6)
		TempDispArray = TrackedDisplays6
		TempNameArray = TrackedNames6

	elseif (Page == 7)
		TempDispArray = TrackedDisplays7
		TempNameArray = TrackedNames7

	elseif (Page == 8)
		TempDispArray = TrackedDisplays8
		TempNameArray = TrackedNames8

	elseif (Page == 9)
		TempDispArray = TrackedDisplays9
		TempNameArray = TrackedNames9

	elseif (Page == 10)
		TempDispArray = TrackedDisplays10
		TempNameArray = TrackedNames10
	endif
endFunction

