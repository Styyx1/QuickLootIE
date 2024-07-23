#pragma once

/*
	Header File for QuickLootIE integration
*/

namespace QuickLoot
{
	class QuickLootIEInterface
	{
	public:
		struct Element
		{
			RE::TESForm* object;
			std::int32_t count;
		};
		struct TakenEvent
		{
			RE::Actor* actor;
			Element* elements;
			std::size_t elementsCount;
			RE::TESObjectREFR* container;
			RE::TESForm* containerOwner;
			bool isStealAlarm;
		};
		typedef void (*OnTakenHandler)(TakenEvent evt);

		/*
		* Public methods
		*/
		virtual bool registerOnTakenHandler(OnTakenHandler handler) = 0;
	};

	enum MessageType : std::uint32_t
	{
		Interface = 0xC0000003
	};

	struct InterfaceMessage
	{
		QuickLootIEInterface* quickLootInterface;
	};
}
