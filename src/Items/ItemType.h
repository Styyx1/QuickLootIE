#pragma once

namespace QuickLoot::Items
{
	enum class ItemType
	{
		None,
		DefaultWeapon,
		WeaponSword,
		WeaponGreatSword,
		WeaponDaedra,
		WeaponDagger,
		WeaponWarAxe,
		WeaponBattleAxe,
		WeaponMace,
		WeaponHammer,
		WeaponStaff,
		WeaponBow,
		WeaponArrow,
		WeaponPickAxe,
		WeaponWoodAxe,
		WeaponCrossbow,
		WeaponBolt,

		DefaultArmor,

		LightArmorBody,
		LightArmorHead,
		LightArmorHands,
		LightArmorForearms,
		LightArmorFeet,
		LightArmorCalves,
		LightArmorShield,
		LightArmorMask,

		ArmorBody,
		ArmorHead,
		ArmorHands,
		ArmorForearms,
		ArmorFeet,
		ArmorCalves,
		ArmorShield,
		ArmorMask,
		ArmorBracer,
		ArmorDaedra,

		ClothingBody,
		ClothingRobe,
		ClothingHead,
		ClothingPants,
		ClothingHands,
		ClothingForearms,
		ClothingFeet,
		ClothingCalves,
		ClothingShoes,
		ClothingShield,
		ClothingMask,

		ArmorAmulet,
		ArmorRing,
		Circlet,

		DefaultScroll,

		DefaultBook,
		BookRead,
		BookTome,
		TomeRead,
		BookJournal,
		BookNote,
		BookMap,

		DefaultFood,
		FoodWine,
		FoodBeer,

		DefaultIngredient,

		DefaultKey,
		KeyHouse,

		DefaultPotion,
		PotionHealth,
		PotionStam,
		PotionMagic,
		PotionPoison,
		PotionFrost,
		PotionFire,
		PotionShock,

		DefaultMisc,
		MiscArtifact,
		MiscClutter,
		MiscLockPick,
		MiscSoulGem,

		SoulGemEmpty,
		SoulGemPartial,
		SoulGemFull,
		SoulGemGrandEmpty,
		SoulGemGrandPartial,
		SoulGemGrandFull,
		SoulGemAzura,

		MiscGem,
		MiscOre,
		MiscIngot,
		MiscHide,
		MiscStrips,
		MiscLeather,
		MiscWood,
		MiscRemains,
		MiscTrollSkull,
		MiscTorch,
		MiscGoldSack,
		MiscGold,
		MiscDragonClaw
	};

	enum class EnchantmentType
	{
		None,
		Known,
		CannotDisenchant,
		Unknown
	};
}
