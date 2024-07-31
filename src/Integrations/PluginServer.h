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
		static bool HandleOnTaken(TakenHandler::TakenEvent evt);

		static TakenHandler::TakenEvent CreateOnTakenEvent(
			RE::Actor* actor,
			std::vector<TakenHandler::Element>* elements,
			RE::TESObjectREFR* container = nullptr,
			RE::TESForm* containerOwner = nullptr,
			bool isStealAlarm = false);

		static inline PluginRequests::RequestServer GetRequestServer() { return _server; };

	protected:
		static inline PluginRequests::RequestServer _server{};
		static inline std::list<TakenHandler::OnTakenHandler> _onTakenHandlers{};
	};
}
