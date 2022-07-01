Scriptname QuickLootEE Hidden
{Script used for adding custom icons to QuickLootEE}

int Function GetVersion() global native
{Gets the version e.g 292 for 2.9.2}

;iEquip Functions ---------------------------------------

Function RegisterNewItemsList(FormList alist) global native
{Registers a form list to be used to check wheather an item is not
 displayed in LOTD and is not in our inventory or LOTD containers.}

Function RegisterFoundItemsList(FormList alist) global native
{Registers a form list to be used to check wheather an item is not
 displayed in LOTD and is in our inventory or LOTD containers.}

Function RegisterDisplayedItemsList(FormList alist) global native
{Registers a form list to be used to check wheather an item is displayed in LOTD.}

; Gets the version as a string for viewing
string Function GetVersionString() global
    int iVersion = QuickLootEE.GetVersion()

    if (iVersion == 0)
        return ""
    endif

    int iMajor = iVersion / 100
    int iMinor = (iVersion / 10) % 10
    int iBug = iVersion % 10
    string aVersion = iMajor + "." + iMinor + "." + iBug
    return aVersion
EndFunction
