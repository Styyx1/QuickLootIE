Scriptname QuickLootEEMCM extends SKI_ConfigBase

int function GetVersion()
	return 3 ; Default version
endFunction

; General Settings
GlobalVariable property QLEECloseInCombat auto
GlobalVariable property QLEECloseWhenEmpty auto
GlobalVariable property QLEEDispelInvisibility auto
GlobalVariable property QLEEOpenWhenContainerUnlocked auto

; Icon Settings
GlobalVariable property QLEEIconShowBookRead auto
GlobalVariable property QLEEIconShowEnchanted auto
GlobalVariable property QLEEIconShowDBMDisplayed auto
GlobalVariable property QLEEIconShowDBMFound auto
GlobalVariable property QLEEIconShowDBMNew auto

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
    AddToggleOptionST("close_in_combat", "Close in combat", QLEECloseInCombat.GetValue(), 0)
    AddToggleOptionST("close_when_empty", "Close when container is empty", QLEECloseWhenEmpty.GetValue(), 0)
    AddToggleOptionST("dispel_invis", "Break invisibility when used", QLEEDispelInvisibility.GetValue(), 0)
    AddToggleOptionST("open_when_container_unlocked", "Open when container is unlocked", QLEEOpenWhenContainerUnlocked.GetValue(), 0)

    SetCursorPosition(1)
    AddHeaderOption("Icon Settings", 0)
    AddToggleOptionST("show_book_read_icon", "Show book read icon", QLEEIconShowBookRead.GetValue(), 0)
    AddToggleOptionST("show_enchanted_icon", "Show item enchanted icon", QLEEIconShowEnchanted.GetValue(), 0)
    AddToggleOptionST("show_lotd_disp_icon", "Show LOTD displayed item icon", QLEEIconShowDBMDisplayed.GetValue(), 0)
    AddToggleOptionST("show_lotd_found_icon", "Show LOTD found item icon", QLEEIconShowDBMFound.GetValue(), 0)
    AddToggleOptionST("show_lotd_new_icon", "Show LOTD new item icon", QLEEIconShowDBMNew.GetValue(), 0)
endEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General Settings States ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

state close_in_combat
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLEECloseInCombat.SetValue(1 - QLEECloseInCombat.GetValue())
        self.SetToggleOptionValueST(QLEECloseInCombat.GetValue(), false, "")
    EndEvent
endState

state close_when_empty
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLEECloseWhenEmpty.SetValue(1 - QLEECloseWhenEmpty.GetValue())
        self.SetToggleOptionValueST(QLEECloseWhenEmpty.GetValue(), false, "")
    EndEvent
endState

state dispel_invis
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLEEDispelInvisibility.SetValue(1 - QLEEDispelInvisibility.GetValue())
        self.SetToggleOptionValueST(QLEEDispelInvisibility.GetValue(), false, "")
    EndEvent
endState

state open_when_container_unlocked
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLEEOpenWhenContainerUnlocked.SetValue(1 - QLEEOpenWhenContainerUnlocked.GetValue())
        self.SetToggleOptionValueST(QLEEOpenWhenContainerUnlocked.GetValue(), false, "")
    EndEvent
endState

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Icon Settings States ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

state show_book_read_icon
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLEEIconShowBookRead.SetValue(1 - QLEEIconShowBookRead.GetValue())
        self.SetToggleOptionValueST(QLEEIconShowBookRead.GetValue(), false, "")
    EndEvent
endState

state show_enchanted_icon
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLEEIconShowEnchanted.SetValue(1 - QLEEIconShowEnchanted.GetValue())
        self.SetToggleOptionValueST(QLEEIconShowEnchanted.GetValue(), false, "")
    EndEvent
endState

state show_lotd_disp_icon
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLEEIconShowDBMDisplayed.SetValue(1 - QLEEIconShowDBMDisplayed.GetValue())
        self.SetToggleOptionValueST(QLEEIconShowDBMDisplayed.GetValue(), false, "")
    EndEvent
endState

state show_lotd_found_icon
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLEEIconShowDBMFound.SetValue(1 - QLEEIconShowDBMFound.GetValue())
        self.SetToggleOptionValueST(QLEEIconShowDBMFound.GetValue(), false, "")
    EndEvent
endState

state show_lotd_new_icon
    event OnHighlightST()
    endEvent

    Event OnSelectST()
        QLEEIconShowDBMNew.SetValue(1 - QLEEIconShowDBMNew.GetValue())
        self.SetToggleOptionValueST(QLEEIconShowDBMNew.GetValue(), false, "")
    EndEvent
endState

