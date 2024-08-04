#pragma once 

#include <QuickLootIntegrations.h>

#include "PluginRequests/RequestServer.h"

namespace QuickLoot::Integrations
{
	class PluginServer
	{
	public:
		static void Init(const SKSE::MessagingInterface* messagingInterface);

		static bool RegisterOnTakenHandler(TakenHandler::OnTakenHandler handler);
		static bool RegisterOnSelectHandler(SelectHandler::OnSelectHandler handler);
		static bool RegisterOnLootMenuHandler(LootMenuHandler::OnLootMenuHandler handler);

		static bool HandleOnTaken(TakenHandler::TakenEvent* evt);
		static bool HandleOnTaken(
			RE::Actor* actor, 
			std::vector<TakenHandler::Element>* elements,
			RE::TESObjectREFR* container = nullptr
		);
		static bool HandleOnTaken(
			RE::Actor* actor,
			RE::TESForm* object,
			std::int32_t count,
			RE::TESObjectREFR* container = nullptr
		);
		
		static bool HandleOnSelect(SelectHandler::SelectEvent* evt);
		static bool HandleOnSelect(
			RE::Actor* actor,
			std::vector<SelectHandler::Element>* elements,
			RE::TESObjectREFR* container = nullptr
		);
		static bool HandleOnSelect(
			RE::Actor* actor,
			RE::TESForm* element,
			std::int32_t count,
			RE::TESObjectREFR* container = nullptr
		);

		static bool HandleOnLootMenu(LootMenuHandler::LootMenuEvent* evt);

		static bool HandleOnLootMenuClose(RE::Actor* actor);
		static bool HandleOnLootMenuClose(RE::ActorHandle actorHandle);

		static bool HandleOnLootMenuOpen(RE::Actor* actor, RE::TESObjectREFR* container);
		static bool HandleOnLootMenuOpen(RE::ActorHandle actorHandle, RE::ObjectRefHandle containerHandle);

		static bool HandleOnLootMenuInvalidate(RE::Actor* actor, RE::TESObjectREFR* container, std::vector<LootMenuHandler::Element>* elements);
		static bool HandleOnLootMenuInvalidate(RE::ActorHandle actorHandle, RE::ObjectRefHandle containerHandle, std::vector<LootMenuHandler::Element>* elements);

		static inline PluginRequests::RequestServer GetRequestServer() { return _server; };

	protected:
		static inline PluginRequests::RequestServer _server{};
		static inline std::list<TakenHandler::OnTakenHandler> _onTakenHandlers{};
		static inline std::list<SelectHandler::OnSelectHandler> _onSelectHandler{};
		static inline std::list<LootMenuHandler::OnLootMenuHandler> _onLootMenuHandlers{};
	};
}
