#pragma once

#include "pch.h"

class PapyrusQuickLootRE
{
public:
	static bool Register();

	static bool RegisterFunctions(RE::BSScript::IVirtualMachine* a_vm);
	static bool ItemIsNew(RE::FormID id);
	static bool ItemIsFound(RE::FormID id);
	static bool ItemIsDisplayed(RE::FormID id);

private:
	static bool HasForm(RE::BGSListForm* form_list, uint32_t form_id);
	static uint32_t GetVersion(RE::StaticFunctionTag* base);
	static void RegisterNewItemsList(RE::StaticFunctionTag* base, RE::BGSListForm* list);
	static void RegisterFoundItemsList(RE::StaticFunctionTag* base, RE::BGSListForm* list);
	static void RegisterDisplayedItemsList(RE::StaticFunctionTag* base, RE::BGSListForm* list);
};
