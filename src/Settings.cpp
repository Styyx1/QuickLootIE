#include "Settings.h"

bool Settings::CloseInCombat()
{
	return GetBooleanGlobal(GetSingleton().m_close_in_combat, "QLEECloseInCombat");
}

bool Settings::CloseWhenEmpty()
{
	return GetBooleanGlobal(GetSingleton().m_close_when_empty, "QLEECloseWhenEmpty");
}

bool Settings::DispelInvisibility()
{
	return GetBooleanGlobal(GetSingleton().m_dispel_invis, "QLEEDispelInvisibility");
}

bool Settings::OpenWhenContainerUnlocked()
{
	return GetBooleanGlobal(GetSingleton().m_open_when_container_unlocked, "QLEEOpenWhenContainerUnlocked");
}

bool Settings::ShowBookRead()
{
	return GetBooleanGlobal(GetSingleton().m_show_book_read, "QLEEIconShowBookRead");
}

bool Settings::ShowEnchanted()
{
	return GetBooleanGlobal(GetSingleton().m_show_enchanted, "QLEEIconShowEnchanted");
}

bool Settings::ShowDBMDisplayed()
{
	return GetBooleanGlobal(GetSingleton().m_show_dbm_displayed, "QLEEIconShowDBMDisplayed");
}

bool Settings::ShowDBMFound()
{
	return GetBooleanGlobal(GetSingleton().m_show_dbm_found, "QLEEIconShowDBMFound");
}

bool Settings::ShowDBMNew()
{
	return GetBooleanGlobal(GetSingleton().m_show_dbm_new, "QLEEIconShowDBMNew");
}

bool Settings::GetBooleanGlobal(const RE::TESGlobal*& global, const char* editor_id)
{
	auto get_global = [&]() -> bool {
		const auto* form = RE::TESForm::LookupByEditorID(editor_id);
		global = form->GetFormType() == RE::FormType::Global ? static_cast<const RE::TESGlobal*>(form) : nullptr;
		return global ? global->value > 0 : false;
	};
	return global ? global->value > 0 : get_global();
}
