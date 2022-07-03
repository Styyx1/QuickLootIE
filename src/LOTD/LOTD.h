#pragma once

#include "RE/B/BSCoreTypes.h"
#include "RE/F/FormTypes.h"

class LOTD
{
public:
	static void LoadLists();

	static bool IsItemNew(RE::FormID id);
	static bool IsItemFound(RE::FormID id);
	static bool IsItemDisplayed(RE::FormID id);

private:
	LOTD() = default;
	LOTD(LOTD&) = delete;
	LOTD operator=(LOTD&) = delete;
	~LOTD() = default;

	static LOTD& GetSingleton()
	{
		static LOTD ret;
		return ret;
	}

	const RE::BGSListForm* m_dbm_new = nullptr;
	const RE::BGSListForm* m_dbm_found = nullptr;
	const RE::BGSListForm* m_dbm_displayed = nullptr;
};

