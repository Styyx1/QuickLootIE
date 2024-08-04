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
		_server.RegisterHandler<SelectHandler::Request, bool>(QuickLootAPI::RequestType::kRegisterSelectHandler, "kRegisterSelectHandler", [](const char*, const SelectHandler::Request* request, bool* response) {
			PluginServer::RegisterOnSelectHandler(request->handler);
			*response = true;
			return true;
		});
		_server.RegisterHandler<LootMenuHandler::Request, bool>(QuickLootAPI::RequestType::kRegisterLootMenuHandler, "kRegisterLootMenuHandler", [](const char*, const LootMenuHandler::Request* request, bool* response) {
			PluginServer::RegisterOnLootMenuHandler(request->handler);
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

	bool PluginServer::RegisterOnSelectHandler(SelectHandler::OnSelectHandler handler)
	{
		_onSelectHandler.push_back(handler);
		return true;
	}

	bool PluginServer::RegisterOnLootMenuHandler(LootMenuHandler::OnLootMenuHandler handler)
	{
		_onLootMenuHandlers.push_back(handler);
		return true;
	}


	bool PluginServer::HandleOnTaken(TakenHandler::TakenEvent* evt)
	{
		for (TakenHandler::OnTakenHandler const& handler : _onTakenHandlers) {
			handler(evt);
		}
		return true;
	}

	bool PluginServer::HandleOnTaken(RE::Actor* actor, std::vector<TakenHandler::Element>* elements, RE::TESObjectREFR* container)
	{
		TakenHandler::TakenEvent evt = TakenHandler::TakenEvent();
		evt.actor = actor;
		evt.elements = elements->data();
		evt.elementsCount = elements->size();
		evt.container = container;

		return HandleOnTaken(&evt);
	}

	bool PluginServer::HandleOnTaken(RE::Actor* actor, RE::TESForm* object, std::int32_t count, RE::TESObjectREFR* container)
	{
		TakenHandler::Element elements[1] = { { object, count } };
		TakenHandler::TakenEvent evt = TakenHandler::TakenEvent();
		evt.actor = actor;
		evt.elements = elements;
		evt.elementsCount = 1;
		evt.container = container;

		return HandleOnTaken(&evt);
	}
	bool PluginServer::HandleOnSelect(SelectHandler::SelectEvent* evt)
	{
		for (SelectHandler::OnSelectHandler const& handler : _onSelectHandler) {
			handler(evt);
		}
		return true;
	}
	bool PluginServer::HandleOnSelect(RE::Actor* actor, std::vector<SelectHandler::Element>* elements, RE::TESObjectREFR* container)
	{
		SelectHandler::SelectEvent evt = SelectHandler::SelectEvent();
		evt.actor = actor;
		evt.elements = elements->data();
		evt.elementsCount = elements->size();
		evt.container = container;

		return HandleOnSelect(&evt);
	}
	bool PluginServer::HandleOnSelect(RE::Actor* actor, RE::TESForm* element, std::int32_t count, RE::TESObjectREFR* container)
	{
		SelectHandler::Element elements[1] = { element, count };
		SelectHandler::SelectEvent evt = SelectHandler::SelectEvent();
		evt.actor = actor;
		evt.elements = elements;
		evt.elementsCount = 1;
		evt.container = container;

		return HandleOnSelect(&evt);
	}
	bool PluginServer::HandleOnLootMenu(LootMenuHandler::LootMenuEvent* evt)
	{
		for (LootMenuHandler::OnLootMenuHandler const& handler : _onLootMenuHandlers) {
			handler(evt);
		}
		return true;
	}
	bool PluginServer::HandleOnLootMenuClose(RE::Actor* actor)
	{
		LootMenuHandler::LootMenuEvent evt = LootMenuHandler::LootMenuEvent();

		evt.status = LootMenuHandler::Status::CLOSE;
		evt.actor = actor;
		evt.container = nullptr;
		evt.elements = nullptr;
		evt.elementsCount = 0;

		return HandleOnLootMenu(&evt);
	}
	bool PluginServer::HandleOnLootMenuClose(RE::ActorHandle actorHandle)
	{
		RE::Actor* actor = actorHandle.get() ? actorHandle.get().get() : nullptr;
		return HandleOnLootMenuClose(actor);
	}
	bool PluginServer::HandleOnLootMenuOpen(RE::Actor* actor, RE::TESObjectREFR* container)
	{
		LootMenuHandler::LootMenuEvent evt = LootMenuHandler::LootMenuEvent();

		evt.status = LootMenuHandler::Status::OPEN;
		evt.actor = actor;
		evt.container = container;
		evt.elements = nullptr;
		evt.elementsCount = 0;

		return HandleOnLootMenu(&evt);
	}
	bool PluginServer::HandleOnLootMenuOpen(RE::ActorHandle actorHandle, RE::ObjectRefHandle containerHandle)
	{
		RE::Actor* actor = actorHandle.get() ? actorHandle.get().get() : nullptr;
		RE::TESObjectREFR* container = containerHandle.get() ? containerHandle.get().get() : nullptr;
		return HandleOnLootMenuOpen(actor, container);
	}
	bool PluginServer::HandleOnLootMenuInvalidate(RE::Actor* actor, RE::TESObjectREFR* container, std::vector<LootMenuHandler::Element>* elements)
	{
		LootMenuHandler::LootMenuEvent evt = LootMenuHandler::LootMenuEvent();

		evt.status = LootMenuHandler::Status::INVALIDATE;
		evt.actor = actor;
		evt.container = container;
		evt.elements = elements->data();
		evt.elementsCount = elements->size();

		return HandleOnLootMenu(&evt);
	}
	bool PluginServer::HandleOnLootMenuInvalidate(RE::ActorHandle actorHandle, RE::ObjectRefHandle containerHandle, std::vector<LootMenuHandler::Element>* elements)
	{
		RE::Actor* actor = actorHandle.get() ? actorHandle.get().get() : nullptr;
		RE::TESObjectREFR* container = containerHandle.get() ? containerHandle.get().get() : nullptr;
		return HandleOnLootMenuInvalidate(actor, container, elements);
	}
}
