#pragma once

#include "RE/B/BSCoreTypes.h"

namespace QuickLoot::Integrations
{
	class LOTD
	{
	private:
		LOTD() = default;
		~LOTD() = default;

		static constexpr const char* TCC_PLUGIN_NAME = "DBM_RelicNotifications.esp";

		static inline bool _isReady;

		static inline RE::BGSListForm* _new = nullptr;
		static inline RE::BGSListForm* _found = nullptr;
		static inline RE::BGSListForm* _displayed = nullptr;

	public:
		LOTD(LOTD const&) = delete;
		LOTD(LOTD const&&) = delete;
		LOTD operator=(LOTD&) = delete;
		LOTD operator=(LOTD&&) = delete;

		static void Init()
		{
			const auto dataHandler = RE::TESDataHandler::GetSingleton();

			if (!dataHandler) {
				SKSE::log::error("Failed to access TESDataHandler");
				return;
			}

			if (dataHandler->LookupLoadedModByName(TCC_PLUGIN_NAME) == nullptr) {
				SKSE::log::info("Plugin {} not found", TCC_PLUGIN_NAME);
				return;
			}

			_new = dataHandler->LookupForm<RE::BGSListForm>(0x558285, TCC_PLUGIN_NAME);
			_found = dataHandler->LookupForm<RE::BGSListForm>(0x558286, TCC_PLUGIN_NAME);
			_displayed = dataHandler->LookupForm<RE::BGSListForm>(0x558287, TCC_PLUGIN_NAME);

			if (_new && _found && _displayed) {
				_isReady = true;
				logger::info("Loaded TCC form lists");
			} else {
				logger::info("Failed to load TCC form lists");
			}
		}

		static bool IsReady()
		{
			return _isReady;
		}

		static bool IsItemNew(RE::FormID formID)
		{
			return _new && _new->HasForm(formID);
		}

		static bool IsItemFound(RE::FormID formID)
		{
			return _found && _found->HasForm(formID);
		}

		static bool IsItemDisplayed(RE::FormID formID)
		{
			return _displayed && _displayed->HasForm(formID);
		}
	};
}
