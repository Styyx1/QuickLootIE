#pragma once 

#include <QuickLootIEInterface.h>

#include "PluginRequests/RequestServer.h"

namespace QuickLoot
{
	enum RequestType : uint32_t
	{
		kVersion = 'XVER',
		kQuery = 'XQRY',
		kQueryArray = 'XARR',
	};

	class QuickLootInterfaceImpl : public QuickLootIE::QuickLootIEInterface
	{
	public:
		QuickLootInterfaceImpl();
		~QuickLootInterfaceImpl();

		/* Interface implementation */
		bool registerOnTakedHandler(OnTakedHandler handler) override;
		uint16_t getMajorVersion() override;
		uint16_t getMinorVersion() override;
		/* \Interface implementation */

		
		static QuickLootInterfaceImpl* GetSingleton();

		PluginRequests::RequestServer* getRequestServer();

		void Init(const SKSE::MessagingInterface* messagingInterface);

		bool handleOnTaked(TakedEvent evt);

		QuickLootIE::QuickLootIEInterface::TakedEvent createOnTakedEvent(RE::Actor* actor,
																				TakedSource source,
																				std::vector<TakedItem> items,
																				RE::TESObjectREFR* container = nullptr,
																				RE::TESForm* containerOwner = nullptr,
																				bool isStealAlarm = false);

	protected:
		PluginRequests::RequestServer* _server = nullptr;
		std::list<OnTakedHandler> _onTakedHandlers = {};
	};
}
