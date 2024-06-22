
enum : std::size_t
{
	kQuestItem,
	kKey,
	kNote,
	kBook,
	kGold,
	kAmmo,
	kLockpick,
	kStolen,
	kIsEnchanted,
	kIsKnownEnchanted,
	kIsSpecialEnchanted,
	kIsRead,
	kIsDBMNew,
	kIsDBMFound,
	kIsDBMDisplayed,
	kIsItemTracked,
	kIsItemCollected,
	kTotalFlags,

	kDisplayName = kTotalFlags,
	kEnchantmentCharge,
	kWeight,
	kValue,
	kFormID,
	kItemType,
	kTotalCachedFlags
};

enum : std::size_t
{
	kInventory,
	kGround
};

class Cache
{
public:
	[[nodiscard]] bool operator[](std::size_t a_flag) const { return _cached.test(a_flag); }

	[[nodiscard]] bool QuestItem() const { return _flags.test(kQuestItem); }
	void QuestItem(bool a_value) { CacheFlag(kQuestItem, a_value); }

	[[nodiscard]] bool Key() const { return _flags.test(kKey); }
	void Key(bool a_value) { CacheFlag(kKey, a_value); }

	[[nodiscard]] bool Note() const { return _flags.test(kNote); }
	void Note(bool a_value) { CacheFlag(kNote, a_value); }

	[[nodiscard]] bool Book() const { return _flags.test(kBook); }
	void Book(bool a_value) { CacheFlag(kBook, a_value); }

	[[nodiscard]] bool Gold() const { return _flags.test(kGold); }
	void Gold(bool a_value) { CacheFlag(kGold, a_value); }

	[[nodiscard]] bool Ammo() const { return _flags.test(kAmmo); }
	void Ammo(bool a_value) { CacheFlag(kAmmo, a_value); }

	[[nodiscard]] bool Lockpick() const { return _flags.test(kLockpick); }
	void Lockpick(bool a_value) { CacheFlag(kLockpick, a_value); }

	[[nodiscard]] bool Stolen() const { return _flags.test(kStolen); }
	void Stolen(bool a_value) { CacheFlag(kStolen, a_value); }

	[[nodiscard]] double IsEnchanted() const noexcept { return _flags.test(kIsEnchanted); }
	void IsEnchanted(double a_value) { CacheFlag(kIsEnchanted, a_value); }

	[[nodiscard]] double IsKnownEnchanted() const noexcept { return _flags.test(kIsKnownEnchanted); }
	void IsKnownEnchanted(double a_value) { CacheFlag(kIsKnownEnchanted, a_value); }

	[[nodiscard]] double IsSpecialEnchanted() const noexcept { return _flags.test(kIsSpecialEnchanted); }
	void IsSpecialEnchanted(double a_value) { CacheFlag(kIsSpecialEnchanted, a_value); }

	[[nodiscard]] double IsRead() const noexcept { return _flags.test(kIsRead); }
	void IsRead(bool a_value) { CacheFlag(kIsRead, a_value); }

	[[nodiscard]] double IsDBMNew() const noexcept { return _flags.test(kIsDBMNew); }
	void IsDBMNew(bool a_value) { CacheFlag(kIsDBMNew, a_value); }

	[[nodiscard]] double IsDBMFound() const noexcept { return _flags.test(kIsDBMFound); }
	void IsDBMFound(bool a_value) { CacheFlag(kIsDBMFound, a_value); }

	[[nodiscard]] double IsDBMDisplayed() const noexcept { return _flags.test(kIsDBMDisplayed); }
	void IsDBMDisplayed(bool a_value) { CacheFlag(kIsDBMDisplayed, a_value); }

	[[nodiscard]] double IsItemTracked() const noexcept { return _flags.test(kIsItemTracked); }
	void IsItemTracked(bool a_value) { CacheFlag(kIsItemTracked, a_value); }

	[[nodiscard]] double IsItemCollected() const noexcept { return _flags.test(kIsItemCollected); }
	void IsItemCollected(bool a_value) { CacheFlag(kIsItemCollected, a_value); }

	[[nodiscard]] constexpr const std::string& DisplayName() const noexcept { return _displayName; }
	void DisplayName(std::string a_value)
	{
		_cached.set(kDisplayName);
		_displayName = std::move(a_value);
	}

	[[nodiscard]] constexpr double EnchantmentCharge() const noexcept { return _enchantmentCharge; }
	void EnchantmentCharge(double a_value)
	{
		_cached.set(kEnchantmentCharge);
		_enchantmentCharge = a_value;
	}

	[[nodiscard]] constexpr double Weight() const noexcept { return _weight; }
	void Weight(double a_value)
	{
		_cached.set(kWeight);
		_weight = a_value;
	}

	[[nodiscard]] constexpr std::ptrdiff_t Value() const noexcept { return _value; }
	void Value(std::ptrdiff_t a_value)
	{
		_cached.set(kValue);
		_value = a_value;
	}

	[[nodiscard]] constexpr RE::FormID FormID() const noexcept { return _formID; }
	void FormID(RE::FormID a_value)
	{
		_cached.set(kFormID);
		_formID = a_value;
	}

	[[nodiscard]] constexpr kType ItemType() const noexcept { return _itemType; }
	void ItemType(kType a_value)
	{
		_cached.set(kItemType);
		_itemType = a_value;
	}

private:
	void CacheFlag(std::size_t a_flag, bool a_value)
	{
		_cached.set(a_flag);
		_flags.set(a_flag, a_value);
	}

	std::bitset<kTotalFlags>       _flags;
	std::bitset<kTotalCachedFlags> _cached;

	std::string                    _displayName       = "";
	double                         _enchantmentCharge = -1.0;
	double                         _weight            = 0.0;
	std::ptrdiff_t                 _value             = 0;
	RE::FormID                     _formID            = 0;
	kType                          _itemType          = kType::None;
};

