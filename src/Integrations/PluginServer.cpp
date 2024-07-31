#include "PluginServer.h"

namespace QuickLoot::Integrations
{
	void PluginServer::Init(const SKSE::MessagingInterface* messagingInterface)
	{
		_server.Init(QuickLootAPI::API_MAJOR_VERSION, QuickLootAPI::API_MINOR_VERSION);

		_server.RegisterHandler<TakenHandler::Request, bool>(QuickLootAPI::RequestType::kRegisterTakenHandler, "kRegisterTakenHandler", [](const char*, const TakenHandler::Request* request, bool* response) {
			PluginServer::RegisterOnTakenHandler(request->handler);
			*response = true;
			return true;
		});

		if (!messagingInterface->RegisterListener(nullptr, [](SKSE::MessagingInterface::Message* a_msg) { PluginServer::GetRequestServer().Handle(a_msg); })) {
			logger::error("Error on register QuickLootIE Message Handler"sv);
		}
	}

	bool PluginServer::RegisterOnTakenHandler(TakenHandler::OnTakenHandler handler)
	{
		_onTakenHandlers.push_back(handler);
		return true;
	}


	bool PluginServer::HandleOnTaken(TakenHandler::TakenEvent evt)
	{
		for (TakenHandler::OnTakenHandler const& handler : _onTakenHandlers) {
			handler(evt);
		}
		return true;
	}

	TakenHandler::TakenEvent PluginServer::CreateOnTakenEvent(
		RE::Actor* actor,
		std::vector<TakenHandler::Element>* elements,
		RE::TESObjectREFR * container,
		RE::TESForm * containerOwner,
		bool isStealAlarm)
	{

		TakenHandler::TakenEvent evt = TakenHandler::TakenEvent();
		evt.actor = actor;
		evt.elements = elements->data();
		evt.elementsCount = elements->size();
		evt.container = container;
		evt.containerOwner = containerOwner;
		evt.isStealAlarm = isStealAlarm;
		return evt;
	};
}
