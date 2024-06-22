Scriptname QuickLootIEMCM extends SKI_ConfigBase

int function GetVersion()
	return 3 ; Default version
endFunction

; General Settings
GlobalVariable property QLIECloseInCombat auto
GlobalVariable property QLIECloseWhenEmpty auto
GlobalVariable property QLIEDispelInvisibility auto
GlobalVariable property QLIEOpenWhenContainerUnlocked auto
GlobalVariable property QLIEDisableForAnimals auto

; Icon Settings
GlobalVariable property QLIEIconShowBookRead auto
GlobalVariable property QLIEIconShowEnchanted auto
GlobalVariable property QLIEIconShowDBMDisplayed auto
GlobalVariable property QLIEIconShowDBMFound auto
GlobalVariable property QLIEIconShowDBMNew auto

; Completionist Settings
GlobalVariable property QLIEShowCompNeeded auto
GlobalVariable property QLIEShowCompCollected auto

; Window Settings
GlobalVariable property QLIEWindowX auto
GlobalVariable property QLIEWindowY auto
GlobalVariable property QLIEWindowW auto
GlobalVariable property QLIEWindowH auto

;;;;;;;;;;;;;;;;;;;;
;;; Script Start ;;;
;;;;;;;;;;;;;;;;;;;;

event OnConfigInit()
	Pages = new string[1]
	Pages[0] = "Main Settings"
endEvent

event OnPageReset(string page)
    SetCursorFillMode(TOP_TO_BOTTOM)
    SetCursorPosition(0)

    AddHeaderOption("General Settings", 0)
    AddToggleOptionST("close_in_combat", "Close in combat", QLIECloseInCombat.GetValue(), 0)
    AddToggleOptionST("close_when_empty", "Close when container is empty", QLIECloseWhenEmpty.GetValue(), 0)
    AddToggleOptionST("dispel_invis", "Break invisibility when used", QLIEDispelInvisibility.GetValue(), 0)
    AddToggleOptionST("open_when_container_unlocked", "Open when container is unlocked", QLIEOpenWhenContainerUnlocked.GetValue(), 0)
    AddToggleOptionST("disable_for_animals", "Disable QuickLoot for animals", QLIEDisableForAnimals.GetValue(), 0)

    AddHeaderOption("Window Settings (leave at 0 for default)", 0)
    AddSliderOptionST("window_X", "Window X", QLIEWindowX.GetValue(), "{0}", 0)
    AddSliderOptionST("window_Y", "Window Y", QLIEWindowY.GetValue(), "{0}", 0)
    AddSliderOptionST("window_W", "Window W", QLIEWindowW.GetValue(), "{0}", 0)
    AddSliderOptionST("window_H", "Window H", QLIEWindowH.GetValue(), "{0}", 0)

    SetCursorPosition(1)
    AddHeaderOption("Icon Settings", 0)
    AddToggleOptionST("show_book_read_icon", "Show book read icon", QLIEIconShowBookRead.GetValue(), 0)
    AddToggleOptionST("show_enchanted_icon", "Show item enchanted icon", QLIEIconShowEnchanted.GetValue(), 0)
    AddToggleOptionST("show_lotd_disp_icon", "Show LOTD displayed item icon", QLIEIconShowDBMDisplayed.GetValue(), 0)
    AddToggleOptionST("show_lotd_found_icon", "Show LOTD found item icon", QLIEIconShowDBMFound.GetValue(), 0)
    AddToggleOptionST("show_lotd_new_icon", "Show LOTD new item icon", QLIEIconShowDBMNew.GetValue(), 0)
    AddToggleOptionST("show_comp_needed_icon", "Show Completionist needed icon", QLIEShowCompNeeded.GetValue(), 0)
    AddToggleOptionST("show_comp_collected_icon", "Show Completionist collected icon", QLIEShowCompCollected.GetValue(), 0)
endEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General Settings States ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

state close_in_combat
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLIECloseInCombat.SetValue(1 - QLIECloseInCombat.GetValue())
        self.SetToggleOptionValueST(QLIECloseInCombat.GetValue(), false, "")
    EndEvent
endState

state close_when_empty
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLIECloseWhenEmpty.SetValue(1 - QLIECloseWhenEmpty.GetValue())
        self.SetToggleOptionValueST(QLIECloseWhenEmpty.GetValue(), false, "")
    EndEvent
endState

state dispel_invis
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLIEDispelInvisibility.SetValue(1 - QLIEDispelInvisibility.GetValue())
        self.SetToggleOptionValueST(QLIEDispelInvisibility.GetValue(), false, "")
    EndEvent
endState

state open_when_container_unlocked
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLIEOpenWhenContainerUnlocked.SetValue(1 - QLIEOpenWhenContainerUnlocked.GetValue())
        self.SetToggleOptionValueST(QLIEOpenWhenContainerUnlocked.GetValue(), false, "")
    EndEvent
endState

state disable_for_animals
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLIEDisableForAnimals.SetValue(1 - QLIEDisableForAnimals.GetValue())
        self.SetToggleOptionValueST(QLIEDisableForAnimals.GetValue(), false, "")
    EndEvent
endState

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Window Settings States ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

state window_X
	event OnSliderAcceptST(Float value)
		QLIEWindowX.SetValue(value)
		self.SetSliderOptionValueST(value, "{0}", false, "")
    endEvent

	event OnSliderOpenST()
		self.SetSliderDialogStartValue(QLIEWindowX.GetValue())
		self.SetSliderDialogDefaultValue(0 as Float)
		self.SetSliderDialogRange(0 as Float, 5000 as Float)
		self.SetSliderDialogInterval(1 as Float)
	endEvent

	event OnDefaultST()
		QLIEWindowX.SetValue(0 as Float)
		self.SetSliderOptionValueST(0 as Float, "{0}", false, "")
	endEvent
endState

state window_Y
	event OnSliderAcceptST(Float value)
		QLIEWindowY.SetValue(value)
		self.SetSliderOptionValueST(value, "{0}", false, "")
    endEvent

	event OnSliderOpenST()
		self.SetSliderDialogStartValue(QLIEWindowY.GetValue())
		self.SetSliderDialogDefaultValue(0 as Float)
		self.SetSliderDialogRange(0 as Float, 5000 as Float)
		self.SetSliderDialogInterval(1 as Float)
	endEvent

	event OnDefaultST()
		QLIEWindowY.SetValue(0 as Float)
		self.SetSliderOptionValueST(0 as Float, "{0}", false, "")
	endEvent
endState

state window_W
	event OnSliderAcceptST(Float value)
		QLIEWindowW.SetValue(value)
		self.SetSliderOptionValueST(value, "{0}", false, "")
    endEvent

	event OnSliderOpenST()
		self.SetSliderDialogStartValue(QLIEWindowW.GetValue())
		self.SetSliderDialogDefaultValue(0 as Float)
		self.SetSliderDialogRange(0 as Float, 5000 as Float)
		self.SetSliderDialogInterval(1 as Float)
	endEvent

	event OnDefaultST()
		QLIEWindowW.SetValue(0 as Float)
		self.SetSliderOptionValueST(0 as Float, "{0}", false, "")
	endEvent
endState

state window_H
	event OnSliderAcceptST(Float value)
		QLIEWindowH.SetValue(value)
		self.SetSliderOptionValueST(value, "{0}", false, "")
    endEvent

	event OnSliderOpenST()
		self.SetSliderDialogStartValue(QLIEWindowH.GetValue())
		self.SetSliderDialogDefaultValue(0 as Float)
		self.SetSliderDialogRange(0 as Float, 5000 as Float)
		self.SetSliderDialogInterval(1 as Float)
	endEvent

	event OnDefaultST()
		QLIEWindowH.SetValue(0 as Float)
		self.SetSliderOptionValueST(0 as Float, "{0}", false, "")
	endEvent
endState

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Icon Settings States ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

state show_book_read_icon
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLIEIconShowBookRead.SetValue(1 - QLIEIconShowBookRead.GetValue())
        self.SetToggleOptionValueST(QLIEIconShowBookRead.GetValue(), false, "")
    EndEvent
endState

state show_enchanted_icon
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLIEIconShowEnchanted.SetValue(1 - QLIEIconShowEnchanted.GetValue())
        self.SetToggleOptionValueST(QLIEIconShowEnchanted.GetValue(), false, "")
    EndEvent
endState

state show_lotd_disp_icon
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLIEIconShowDBMDisplayed.SetValue(1 - QLIEIconShowDBMDisplayed.GetValue())
        self.SetToggleOptionValueST(QLIEIconShowDBMDisplayed.GetValue(), false, "")
    EndEvent
endState

state show_lotd_found_icon
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLIEIconShowDBMFound.SetValue(1 - QLIEIconShowDBMFound.GetValue())
        self.SetToggleOptionValueST(QLIEIconShowDBMFound.GetValue(), false, "")
    EndEvent
endState

state show_lotd_new_icon
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLIEIconShowDBMNew.SetValue(1 - QLIEIconShowDBMNew.GetValue())
        self.SetToggleOptionValueST(QLIEIconShowDBMNew.GetValue(), false, "")
    EndEvent
endState

state show_comp_needed_icon
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLIEShowCompNeeded.SetValue(1 - QLIEShowCompNeeded.GetValue())
        self.SetToggleOptionValueST(QLIEShowCompNeeded.GetValue(), false, "")
    EndEvent
endState

state show_comp_collected_icon
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLIEShowCompCollected.SetValue(1 - QLIEShowCompCollected.GetValue())
        self.SetToggleOptionValueST(QLIEShowCompCollected.GetValue(), false, "")
    EndEvent
endState
