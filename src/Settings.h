#pragma once

#include "RE/F/FormTypes.h"

class Settings
{
public:
	static bool CloseInCombat();
	static bool CloseWhenEmpty();
	static bool DispelInvisibility();
	static bool OpenWhenContainerUnlocked();

	static bool ShowBookRead();
	static bool ShowEnchanted();
	static bool ShowDBMDisplayed();
	static bool ShowDBMFound();
	static bool ShowDBMNew();

private:
	static bool GetBooleanGlobal(const RE::TESGlobal*& global, const char* editor_id);

	Settings() = default;
	Settings(Settings&) = delete;
	Settings operator=(Settings&) = delete;
	~Settings() = default;

	static Settings& GetSingleton(){
		static Settings ret;
		return ret;
	};

	const RE::TESGlobal* m_close_in_combat;
	const RE::TESGlobal* m_close_when_empty;
	const RE::TESGlobal* m_dispel_invis;
	const RE::TESGlobal* m_open_when_container_unlocked;

	const RE::TESGlobal* m_show_book_read;
	const RE::TESGlobal* m_show_enchanted;
	const RE::TESGlobal* m_show_dbm_displayed;
	const RE::TESGlobal* m_show_dbm_found;
	const RE::TESGlobal* m_show_dbm_new;
};
