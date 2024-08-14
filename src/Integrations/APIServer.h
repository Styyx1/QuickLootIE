#pragma once

#include <QuickLootAPI.h>

#include "PluginRequests/RequestServer.h"

namespace QuickLoot::API
{
	class APIServer
	{
	public:
		APIServer() = delete;
		~APIServer() = delete;
		APIServer(APIServer const&) = delete;
		APIServer(APIServer const&&) = delete;
		APIServer operator=(APIServer&) = delete;
		APIServer operator=(APIServer&&) = delete;

		static void Init(const SKSE::MessagingInterface* messenger);

		static HandleResult DispatchTakingItemEvent(RE::Actor* actor, const std::vector<Element>& elements, RE::TESObjectREFR* container);
		static HandleResult DispatchTakingItemEvent(RE::Actor* actor, RE::TESForm* object, std::ptrdiff_t count, RE::TESObjectREFR* container);

		static void DispatchTakeItemEvent(RE::Actor* actor, const std::vector<Element>& elements, RE::TESObjectREFR* container = nullptr);
		static void DispatchTakeItemEvent(RE::Actor* actor, RE::TESForm* object, std::ptrdiff_t count, RE::TESObjectREFR* container = nullptr);

		static void DispatchSelectItemEvent(RE::Actor* actor, const std::vector<Element>& elements, RE::TESObjectREFR* container = nullptr);
		static void DispatchSelectItemEvent(RE::Actor* actor, RE::TESForm* object, std::ptrdiff_t count, const RE::ObjectRefHandle& container);

		static HandleResult DispatchOpeningLootMenuEvent(const RE::TESObjectREFRPtr& container);

		static void DispatchOpenLootMenuEvent(const RE::ObjectRefHandle& container);

		static void DispatchCloseLootMenuEvent(const RE::ObjectRefHandle& container);

		static void DispatchInvalidateLootMenuEvent(const std::vector<Element>& elements, const RE::ObjectRefHandle& container);

	private:
		static inline PluginRequests::RequestServer _server{};

		static inline std::vector<TakingItemHandler> _takingItemHandlers{};
		static inline std::vector<TakeItemHandler> _takeItemHandlers{};
		static inline std::vector<SelectItemHandler> _selectItemHandlers{};
		static inline std::vector<OpeningLootMenuHandler> _openingLootMenuHandlers{};
		static inline std::vector<OpenLootMenuHandler> _openLootMenuHandlers{};
		static inline std::vector<CloseLootMenuHandler> _closeLootMenuHandlers{};
		static inline std::vector<InvalidateLootMenuHandler> _invalidateLootMenuHandlers{};

		static void HandleSKSEMessage(SKSE::MessagingInterface::Message* message);
	};
}
