#include "QuickLootInterfaceImpl.h"

#include "Plugin.h"

namespace
{
	void QuickLootIEMessageHandler(SKSE::MessagingInterface::Message* a_msg)
	{
		switch (a_msg->type) {
			// Request Interface
		case QuickLootIE::MessageType::Interface:
			logger::trace("QuickLootIEMessageHandler RetrieveInterface from {}"sv, a_msg->sender);
			if (a_msg->dataLen == sizeof(QuickLootIE::InterfaceMessage)) {
				QuickLootIE::InterfaceMessage* exchangeMessage = (QuickLootIE::InterfaceMessage*)(a_msg->data);
				exchangeMessage->quickLootInterface = QuickLoot::QuickLootInterfaceImpl::GetSingleton();
			} else {
				logger::warn("QuickLootIEMessageHandler RetrieveInterface error: wrong size of data"sv);
			}
			break;
			// Pass message to RequestServer
		default:
			QuickLoot::QuickLootInterfaceImpl::GetSingleton()->getRequestServer()->Handle(a_msg);
		}
	}
}

namespace QuickLoot
{
	using TakedSource = QuickLootIE::QuickLootIEInterface::TakedSource;
	using TakedItem = QuickLootIE::QuickLootIEInterface::TakedItem;
	using TakedEvent = QuickLootIE::QuickLootIEInterface::TakedEvent;
	using OnTakedHandler = QuickLootIE::QuickLootIEInterface::OnTakedHandler;

	QuickLootInterfaceImpl::QuickLootInterfaceImpl()
	{
		_server = new PluginRequests::RequestServer();
	}

	QuickLootInterfaceImpl::~QuickLootInterfaceImpl()
	{
		delete _server;
	}

	/****************************************************************************
			Interface implementation
	*****************************************************************************/
	bool QuickLootInterfaceImpl::registerOnTakedHandler(OnTakedHandler handler)
	{
		_onTakedHandlers.push_back(handler);
		return true;
	}

	uint16_t QuickLootInterfaceImpl::getMajorVersion()
	{
		return Plugin::VERSION.major();
	}

	uint16_t QuickLootInterfaceImpl::getMinorVersion()
	{
		return Plugin::VERSION.minor();
	}
	/****************************************************************************
			\Interface implementation
	*****************************************************************************/

	QuickLootInterfaceImpl* QuickLootInterfaceImpl::GetSingleton()
	{
		static QuickLootInterfaceImpl* singleton = new QuickLootInterfaceImpl();
		return singleton;
	}

	PluginRequests::RequestServer* QuickLootInterfaceImpl::getRequestServer()
	{
		return _server;
	}

	void QuickLootInterfaceImpl::Init(const SKSE::MessagingInterface* messagingInterface)
	{
		_server->Init(Plugin::VERSION.major(), Plugin::VERSION.minor());

		// Register Message Query Handlers:
		//_server->RegisterHandler<..., ...>(..., "...", [](const char*, const ..., ...) {return true;});

		if (!messagingInterface->RegisterListener(nullptr, QuickLootIEMessageHandler)) {
			logger::error("Error on register QuickLootIE Message Handler"sv);
		}
	}

	bool QuickLootInterfaceImpl::handleOnTaked(TakedEvent evt)
	{
		for (OnTakedHandler const& handler : _onTakedHandlers) {
			handler(evt);
		}
		return true;
	}

	TakedEvent QuickLootInterfaceImpl::createOnTakedEvent(RE::Actor* actor,
													TakedSource source,
													std::vector<TakedItem> items,
													RE::TESObjectREFR * container,
													RE::TESForm * containerOwner,
													bool isStealAlarm)
	{
		TakedEvent evt = TakedEvent();
		evt.actor = actor;
		evt.source = source;
		evt.items = items;
		evt.container = container;
		evt.containerOwner = containerOwner;
		evt.isStealAlarm = isStealAlarm;
		return evt;
	};

}
