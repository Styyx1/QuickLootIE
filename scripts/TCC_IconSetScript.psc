scriptname TCC_IconSetScript extends quest

formlist property dbmNew auto
formlist property dbmFound auto
formlist property dbmDisp auto

Function SetMainHud(Int Config)

    if SKSE.GetPluginVersion("Ahzaab's moreHUD Plugin") >= 30800

        if Config == 0
            AhzmoreHUD.RegisterIconFormList("dbmNew", dbmNew)
            AhzmoreHUD.RegisterIconFormList("dbmDisp", dbmDisp)
            AhzmoreHUD.RegisterIconFormList("dbmFound", dbmFound)

        elseif Config == 1
            AhzmoreHUD.UnRegisterIconFormList("dbmFound")
            AhzmoreHUD.UnRegisterIconFormList("dbmDisp")
            AhzmoreHUD.RegisterIconFormList("dbmNew", dbmNew)

        elseif Config == 2
            AhzmoreHUD.UnRegisterIconFormList("dbmDisp")
            AhzmoreHUD.UnRegisterIconFormList("dbmNew")
            AhzmoreHUD.RegisterIconFormList("dbmFound", dbmFound)

        elseif Config == 3
            AhzmoreHUD.UnRegisterIconFormList("dbmNew")
            AhzmoreHUD.UnRegisterIconFormList("dbmFound")
            AhzmoreHUD.RegisterIconFormList("dbmDisp", dbmDisp)

        elseif Config == 4
            AhzmoreHUD.UnRegisterIconFormList("dbmNew")
            AhzmoreHUD.UnRegisterIconFormList("dbmDisp")
            AhzmoreHUD.UnRegisterIconFormList("dbmFound")
        endif
    endif
endFunction

Function SetInventoryHud(Int Config)

    if SKSE.GetPluginVersion("Ahzaab's moreHUD Inventory Plugin") >= 10017

        if Config == 0
            AhzmoreHUDIE.RegisterIconFormList("dbmNew", dbmNew)
            AhzmoreHUDIE.RegisterIconFormList("dbmDisp", dbmDisp)
            AhzmoreHUDIE.RegisterIconFormList("dbmFound", dbmFound)

        elseif Config == 1
            AhzmoreHUDIE.UnRegisterIconFormList("dbmFound")
            AhzmoreHUDIE.UnRegisterIconFormList("dbmDisp")
            AhzmoreHUDIE.RegisterIconFormList("dbmNew", dbmNew)

        elseif Config == 2
            AhzmoreHUDIE.UnRegisterIconFormList("dbmDisp")
            AhzmoreHUDIE.UnRegisterIconFormList("dbmNew")
            AhzmoreHUDIE.RegisterIconFormList("dbmFound", dbmFound)

        elseif Config == 3
            AhzmoreHUDIE.UnRegisterIconFormList("dbmNew")
            AhzmoreHUDIE.UnRegisterIconFormList("dbmFound")
            AhzmoreHUDIE.RegisterIconFormList("dbmDisp", dbmDisp)

        elseif Config == 4
            AhzmoreHUDIE.UnRegisterIconFormList("dbmNew")
            AhzmoreHUDIE.UnRegisterIconFormList("dbmDisp")
            AhzmoreHUDIE.UnRegisterIconFormList("dbmFound")
        endif
    endif
endFunction

Function SetQuickLoot()
    QuickLootEE.RegisterNewItemsList(dbmNew)
    QuickLootEE.RegisterDisplayedItemsList(dbmDisp)
    QuickLootEE.RegisterFoundItemsList(dbmFound)
EndFunction
