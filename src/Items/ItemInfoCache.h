#pragma once

#include "ItemType.h"

namespace QuickLoot::Items
{
	enum class CacheFlag
	{
		// flags

		kIsRead,
		kIsStolen,
		kIsQuestItem,
		kIsEnchanted,
		kIsKnownEnchanted,
		kIsSpecialEnchanted,

		kKey,
		kNote,
		kBook,
		kGold,
		kAmmo,
		kLockpick,

		kIsDbmNew,
		kIsDbmFound,
		kIsDbmDisplayed,

		kIsCompNew,
		kIsCompFound,
		kIsCompTracked,

		kTotalFlags,

		// fields

		kFormID = kTotalFlags,
		kWeight,
		kValue,
		kItemType,
		kDisplayName,
		kEnchantmentCharge,

		kTotalCachedFlags
	};

	using enum CacheFlag;

	class ItemInfoCache
	{
	private:
		std::bitset<static_cast<size_t>(kTotalCachedFlags)> _cached;
		std::bitset<static_cast<size_t>(kTotalFlags)> _flags;

		std::string _displayName{};
		double _weight = 0.0;
		int64_t _value = 0;
		double _enchantmentCharge = -1.0;
		RE::FormID _formID = 0;
		ItemType _itemType = ItemType::None;

	private:
		void MarkCached(CacheFlag flag) { _cached.set(static_cast<size_t>(flag)); }

		bool StoreFlag(CacheFlag flag, bool value)
		{
			_cached.set(static_cast<size_t>(flag));
			_flags.set(static_cast<size_t>(flag), value);
			return value;
		}

		bool RetrieveFlag(CacheFlag flag) const
		{
			return _flags.test(static_cast<size_t>(flag));
		}

		template <typename TValue>
		TValue& StoreValue(CacheFlag flag, TValue& target, TValue value)
		{
			MarkCached(flag);
			return target = value;
		}

	public:
		bool IsCached(CacheFlag flag) const { return _cached.test(static_cast<size_t>(flag)); }

		[[nodiscard]] bool IsQuestItem() const { return RetrieveFlag(kIsQuestItem); }
		[[nodiscard]] bool IsStolen() const { return RetrieveFlag(kIsStolen); }
		[[nodiscard]] bool IsRead() const noexcept { return RetrieveFlag(kIsRead); }
		[[nodiscard]] bool IsEnchanted() const noexcept { return RetrieveFlag(kIsEnchanted); }
		[[nodiscard]] bool IsKnownEnchanted() const noexcept { return RetrieveFlag(kIsKnownEnchanted); }
		[[nodiscard]] bool IsSpecialEnchanted() const noexcept { return RetrieveFlag(kIsSpecialEnchanted); }

		[[nodiscard]] bool IsKey() const { return RetrieveFlag(kKey); }
		[[nodiscard]] bool IsNote() const { return RetrieveFlag(kNote); }
		[[nodiscard]] bool IsBook() const { return RetrieveFlag(kBook); }
		[[nodiscard]] bool IsGold() const { return RetrieveFlag(kGold); }
		[[nodiscard]] bool IsAmmo() const { return RetrieveFlag(kAmmo); }
		[[nodiscard]] bool IsLockpick() const { return RetrieveFlag(kLockpick); }

		[[nodiscard]] double IsDbmNew() const noexcept { return RetrieveFlag(kIsDbmNew); }
		[[nodiscard]] double IsDbmFound() const noexcept { return RetrieveFlag(kIsDbmFound); }
		[[nodiscard]] double IsDbmDisplayed() const noexcept { return RetrieveFlag(kIsDbmDisplayed); }

		[[nodiscard]] double IsCompNew() const noexcept { return RetrieveFlag(kIsCompNew); }
		[[nodiscard]] double IsCompFound() const noexcept { return RetrieveFlag(kIsCompFound); }
		[[nodiscard]] double IsCompTracked() const noexcept { return RetrieveFlag(kIsCompTracked); }

		[[nodiscard]] constexpr RE::FormID GetFormID() const noexcept { return _formID; }
		[[nodiscard]] constexpr double GetWeight() const noexcept { return _weight; }
		[[nodiscard]] constexpr std::ptrdiff_t GetValue() const noexcept { return _value; }
		[[nodiscard]] constexpr ItemType GetItemType() const noexcept { return _itemType; }
		[[nodiscard]] constexpr const std::string& GetDisplayName() const noexcept { return _displayName; }
		[[nodiscard]] constexpr double GetEnchantmentCharge() const noexcept { return _enchantmentCharge; }

		bool SetRead(bool value) { return StoreFlag(kIsRead, value); }
		bool SetStolen(bool value) { return StoreFlag(kIsStolen, value); }
		bool SetQuestItem(bool value) { return StoreFlag(kIsQuestItem, value); }
		bool SetEnchanted(bool value) { return StoreFlag(kIsEnchanted, value); }
		bool SetKnownEnchanted(bool value) { return StoreFlag(kIsKnownEnchanted, value); }
		bool SetSpecialEnchanted(bool value) { return StoreFlag(kIsSpecialEnchanted, value); }

		bool SetKey(bool value) { return StoreFlag(kKey, value); }
		bool SetNote(bool value) { return StoreFlag(kNote, value); }
		bool SetBook(bool value) { return StoreFlag(kBook, value); }
		bool SetGold(bool value) { return StoreFlag(kGold, value); }
		bool SetAmmo(bool value) { return StoreFlag(kAmmo, value); }
		bool SetLockpick(bool value) { return StoreFlag(kLockpick, value); }

		bool SetsDbmNew(bool value) { return StoreFlag(kIsDbmNew, value); }
		bool SetDbmFound(bool value) { return StoreFlag(kIsDbmFound, value); }
		bool SetDbmDisplayed(bool value) { return StoreFlag(kIsDbmDisplayed, value); }

		bool SetCompNew(bool value) { return StoreFlag(kIsCompNew, value); }
		bool SetCompFound(bool value) { return StoreFlag(kIsCompFound, value); }
		bool SetCompTracked(bool value) { return StoreFlag(kIsCompTracked, value); }

		RE::FormID SetFormID(RE::FormID value) { return StoreValue(kFormID, _formID, value); }
		double SetWeight(double value) { return StoreValue(kWeight, _weight, value); }
		int64_t SetValue(int64_t value) { return StoreValue(kValue, _value, value); }
		ItemType SetItemType(ItemType value) { return StoreValue(kItemType, _itemType, value); }
		const std::string& SetDisplayName(const std::string& value) { return StoreValue(kDisplayName, _displayName, value); }
		double SetEnchantmentCharge(double value) { return StoreValue(kEnchantmentCharge, _enchantmentCharge, value); }
	};
}
