#include "Papyrus.h"
#include "pch.h"

static std::recursive_mutex mtx;
static RE::BGSListForm* new_items;
static RE::BGSListForm* found_items;
static RE::BGSListForm* displayed_items;

bool PapyrusQuickLootRE::Register()
{
	auto papyrus = SKSE::GetPapyrusInterface();
	if (!papyrus->Register(RegisterFunctions)) {
		return false;
	} else {
		logger::info("registered papyrus PapyrusMoreHud funcs");
	}

	return true;
}

bool PapyrusQuickLootRE::RegisterFunctions(RE::BSScript::IVirtualMachine* a_vm)
{
	a_vm->RegisterFunction("GetVersion", "QuickLootRE", GetVersion, true);
	a_vm->RegisterFunction("RegisterNewItemsList", "QuickLootRE", RegisterNewItemsList);
	a_vm->RegisterFunction("RegisterFoundItemsList", "QuickLootRE", RegisterFoundItemsList);
	a_vm->RegisterFunction("RegisterDisplayedItemsList", "QuickLootRE", RegisterDisplayedItemsList);
	return true;
}

bool PapyrusQuickLootRE::ItemIsNew(RE::FormID id)
{
	return new_items && HasForm(new_items, id);
}

bool PapyrusQuickLootRE::ItemIsFound(RE::FormID id)
{
	return found_items && HasForm(found_items, id);
}

bool PapyrusQuickLootRE::ItemIsDisplayed(RE::FormID id)
{
	return displayed_items && HasForm(displayed_items, id);
}

bool PapyrusQuickLootRE::HasForm(RE::BGSListForm* form_list, uint32_t form_id)
{
	logger::trace("HasForm");
	std::lock_guard<std::recursive_mutex> lock(mtx);

	if (!form_id)
		return false;

	auto formFromId = RE::TESForm::LookupByID(form_id);

	if (!formFromId)
		return false;

	return form_list->HasForm(formFromId);
}

uint32_t PapyrusQuickLootRE::GetVersion([[maybe_unused]] RE::StaticFunctionTag* base)
{
	uint32_t version = 0;
	for (int i = 0; i < sizeof(Plugin::VERSION); i++) {
		version *= 10;
		version += Plugin::VERSION[i];
	}
	logger::trace("GetVersion: {}", version);
	return version;
}

void PapyrusQuickLootRE::RegisterNewItemsList([[maybe_unused]] RE::StaticFunctionTag* base, RE::BGSListForm* list)
{
	logger::trace("RegisterIconFormList");
	std::lock_guard<std::recursive_mutex> lock(mtx);
	new_items = list;
}

void PapyrusQuickLootRE::RegisterFoundItemsList([[maybe_unused]] RE::StaticFunctionTag* base, RE::BGSListForm* list)
{
	logger::trace("RegisterIconFormList");
	std::lock_guard<std::recursive_mutex> lock(mtx);
	found_items = list;
}

void PapyrusQuickLootRE::RegisterDisplayedItemsList([[maybe_unused]] RE::StaticFunctionTag* base, RE::BGSListForm* list)
{
	logger::trace("RegisterIconFormList");
	std::lock_guard<std::recursive_mutex> lock(mtx);
	displayed_items = list;
}
