#include "GFxItem.h"

static const char * strIcons[] = {
	"none",					// 00
	"default_weapon",
	"weapon_sword",
	"weapon_greatsword",
	"weapon_daedra",
	"weapon_dagger",
	"weapon_waraxe",
	"weapon_battleaxe",
	"weapon_mace",
	"weapon_hammer",
	"weapon_staff",			// 10
	"weapon_bow",
	"weapon_arrow",
	"weapon_pickaxe",
	"weapon_woodaxe",
	"weapon_crossbow",
	"weapon_bolt",
	"default_armor",
	"lightarmor_body",
	"lightarmor_head",
	"lightarmor_hands",		// 20
	"lightarmor_forearms",
	"lightarmor_feet",
	"lightarmor_calves",
	"lightarmor_shield",
	"lightarmor_mask",
	"armor_body",
	"armor_head",
	"armor_hands",
	"armor_forearms",
	"armor_feet",			// 30
	"armor_calves",
	"armor_shield",
	"armor_mask",
	"armor_bracer",
	"armor_daedra",
	"clothing_body",
	"clothing_robe",
	"clothing_head",
	"clothing_pants",
	"clothing_hands",		// 40
	"clothing_forearms",
	"clothing_feet",
	"clothing_calves",
	"clothing_shoes",
	"clothing_shield",
	"clothing_mask",
	"armor_amulet",
	"armor_ring",
	"armor_circlet",
	"default_scroll",		// 50
	"default_book",
	"default_book_read",
	"book_tome",
	"book_tome_read",
	"book_journal",
	"book_note",
	"book_map",
	"default_food",
	"food_wine",
	"food_beer",			// 60
	"default_ingredient",
	"default_key",
	"key_house",
	"default_potion",
	"potion_health",
	"potion_stam",
	"potion_magic",
	"potion_poison",
	"potion_frost",
	"potion_fire",			// 70
	"potion_shock",
	"default_misc",
	"misc_artifact",
	"misc_clutter",
	"misc_lockpick",
	"misc_soulgem",
	"soulgem_empty",
	"soulgem_partial",
	"soulgem_full",
	"soulgem_grandempty",	// 80
	"soulgem_grandpartial",
	"soulgem_grandfull",
	"soulgem_azura",
	"misc_gem",
	"misc_ore",
	"misc_ingot",
	"misc_hide",
	"misc_strips",
	"misc_leather",
	"misc_wood",			// 90
	"misc_remains",
	"misc_trollskull",
	"misc_torch",
	"misc_goldsack",
	"misc_gold",
	"misc_dragonclaw"
};

using namespace RE;

namespace Items
{
	static GFxItem::Type GetItemTypeWeapon(TESObjectWEAP* weap)
	{
		GFxItem::Type type = GFxItem::Type::kType_DefaultWeapon;

		switch (weap->GetWeaponType()) {
		case RE::WEAPON_TYPE::kOneHandSword:
			type = GFxItem::Type::kType_WeaponSword;
			break;
		case RE::WEAPON_TYPE::kOneHandDagger:
			type = GFxItem::Type::kType_WeaponDagger;
			break;
		case RE::WEAPON_TYPE::kOneHandAxe:
			type = GFxItem::Type::kType_WeaponWarAxe;
			break;
		case RE::WEAPON_TYPE::kOneHandMace:
			type = GFxItem::Type::kType_WeaponMace;
			break;
		case RE::WEAPON_TYPE::kTwoHandSword:
			type = GFxItem::Type::kType_WeaponGreatSword;
			break;
		case RE::WEAPON_TYPE::kTwoHandAxe:
			type = GFxItem::Type::kType_WeaponBattleAxe;
			break;
		case RE::WEAPON_TYPE::kBow:
			type = GFxItem::Type::kType_WeaponBow;
			break;
		case RE::WEAPON_TYPE::kStaff:
			type = GFxItem::Type::kType_WeaponStaff;
			break;
		case RE::WEAPON_TYPE::kCrossbow:
			type = GFxItem::Type::kType_WeaponCrossbow;
			break;
		}

		return type;
	}

	static GFxItem::Type GetItemTypeArmor(TESObjectARMO* armor)
	{
		static GFxItem::Type types[] = {
			GFxItem::Type::kType_LightArmorBody,  // 0
			GFxItem::Type::kType_LightArmorHead,
			GFxItem::Type::kType_LightArmorHands,
			GFxItem::Type::kType_LightArmorForearms,
			GFxItem::Type::kType_LightArmorFeet,
			GFxItem::Type::kType_LightArmorCalves,
			GFxItem::Type::kType_LightArmorShield,
			GFxItem::Type::kType_LightArmorMask,

			GFxItem::Type::kType_ArmorBody,  // 8
			GFxItem::Type::kType_ArmorHead,
			GFxItem::Type::kType_ArmorHands,
			GFxItem::Type::kType_ArmorForearms,
			GFxItem::Type::kType_ArmorFeet,
			GFxItem::Type::kType_ArmorCalves,
			GFxItem::Type::kType_ArmorShield,
			GFxItem::Type::kType_ArmorMask,

			GFxItem::Type::kType_ClothingBody,  // 16
			GFxItem::Type::kType_ClothingHead,
			GFxItem::Type::kType_ClothingHands,
			GFxItem::Type::kType_ClothingForearms,
			GFxItem::Type::kType_ClothingFeet,
			GFxItem::Type::kType_ClothingCalves,
			GFxItem::Type::kType_ClothingShield,
			GFxItem::Type::kType_ClothingMask,

			GFxItem::Type::kType_ArmorAmulet,  // 24
			GFxItem::Type::kType_ArmorRing,
			GFxItem::Type::kType_Circlet,

			GFxItem::Type::kType_DefaultArmor  // 27
		};

		UINT32 index = 0;

		if (armor->IsLightArmor()) {
			index = 0;
		} else if (armor->IsHeavyArmor()) {
			index = 8;
		} else {
			if (armor->HasKeywordID(0x08F95A)) {  // VendorItemJewelry{
				index = 16;
			} else if (armor->HasKeywordID(0x08F95B)) {  // VendorItemClothing
				if (armor->HasPartOf(BGSBipedObjectForm::BipedObjectSlot::kAmulet))
					index = 24;
				else if (armor->HasPartOf(BGSBipedObjectForm::BipedObjectSlot::kRing))
					index = 25;
				else if (armor->HasPartOf(BGSBipedObjectForm::BipedObjectSlot::kCirclet))
					index = 26;
				else
					index = 27;
			} else {
				index = 27;
			}
		}

		if (index >= 24)
			return types[index];

		if (armor->HasPartOf(BGSBipedObjectForm::BipedObjectSlot::kBody) || armor->HasPartOf(BGSBipedObjectForm::BipedObjectSlot::kTail))
			index += 0;  // body
		else if (armor->HasPartOf(BGSBipedObjectForm::BipedObjectSlot::kHead) || armor->HasPartOf(BGSBipedObjectForm::BipedObjectSlot::kHair) || armor->HasPartOf(BGSBipedObjectForm::BipedObjectSlot::kLongHair)) {
			index += 1;  // head
			if (armor->formID >= 0x061C8B && armor->formID < 0x061CD7)
				index += 6;  // mask
		} else if (armor->HasPartOf(BGSBipedObjectForm::BipedObjectSlot::kHands))
			index += 2;  // hands
		else if (armor->HasPartOf(BGSBipedObjectForm::BipedObjectSlot::kForearms))
			index += 3;  // forarms
		else if (armor->HasPartOf(BGSBipedObjectForm::BipedObjectSlot::kFeet))
			index += 4;  // forarms
		else if (armor->HasPartOf(BGSBipedObjectForm::BipedObjectSlot::kCalves))
			index += 5;  // calves
		else if (armor->HasPartOf(BGSBipedObjectForm::BipedObjectSlot::kShield))
			index += 6;  // shield
		else
			index = 27;

		return types[index];
	}

	static GFxItem::Type GetItemTypePotion(AlchemyItem* potion)
	{
		GFxItem::Type type = GFxItem::Type::kType_DefaultPotion;

		if (potion->IsFood()) {
			type = GFxItem::Type::kType_DefaultFood;

			const static UINT32 ITMPosionUse = 0x000B6435;
			if (potion->data.consumptionSound && potion->data.consumptionSound->formID == ITMPosionUse)
				type = GFxItem::Type::kType_FoodWine;
		} else if (potion->IsPoison()) {
			type = GFxItem::Type::kType_PotionPoison;
		} else {
			type = GFxItem::Type::kType_DefaultPotion;

			//MagicItem::EffectItem* pEffect = CALL_MEMBER_FN(potion, GetCostliestEffectItem)(5, false);
			Effect* pEffect = potion->GetCostliestEffectItem(5, false);
			if (pEffect && pEffect->baseEffect) {
				ActorValue primaryValue = pEffect->baseEffect->GetMagickSkill();

				if (primaryValue == ActorValue::kNone) {
					primaryValue = pEffect->baseEffect->data.primaryAV;
				}

				switch (primaryValue) {
				case ActorValue::kHealth:
					type = GFxItem::Type::kType_PotionHealth;
					break;
				case ActorValue::kMagicka:
					type = GFxItem::Type::kType_PotionMagic;
					break;
				case ActorValue::kStamina:
					type = GFxItem::Type::kType_PotionStam;
					break;
				case ActorValue::kResistFire:
					type = GFxItem::Type::kType_PotionFire;
					break;
				case ActorValue::kResistShock:
					type = GFxItem::Type::kType_PotionShock;
					break;
				case ActorValue::kResistFrost:
					type = GFxItem::Type::kType_PotionFrost;
					break;
				}
			}
		}

		return type;
	}

	static GFxItem::Type GetItemTypeMisc(TESObjectMISC* misc)
	{
		GFxItem::Type type = GFxItem::Type::kType_DefaultMisc;

		static const UINT32 LockPick = 0x00000A;
		static const UINT32 Gold = 0x00000F;
		static const UINT32 Leather01 = 0x000DB5D2;
		static const UINT32 LeatherStrips = 0x000800E4;

		static const UINT32 VendorItemAnimalHideFormId = 0x0914EA;
		static const UINT32 VendorItemDaedricArtifactFormId = 0x000917E8;
		static const UINT32 VendorItemGemFormId = 0x000914ED;
		static const UINT32 VendorItemToolFormId = 0x000914EE;
		static const UINT32 VendorItemAnimalPartFormId = 0x000914EB;
		static const UINT32 VendorItemOreIngotFormId = 0x000914EC;
		static const UINT32 VendorItemClutterFormId = 0x000914E9;
		static const UINT32 VendorItemFirewoodFormId = 0x000BECD7;

		static const UINT32 RubyDragonClaw = 0x04B56C;
		static const UINT32 IvoryDragonClaw = 0x0AB7BB;
		static const UINT32 GlassCraw = 0x07C260;
		static const UINT32 EbonyCraw = 0x05AF48;
		static const UINT32 EmeraldDragonClaw = 0x0ED417;
		static const UINT32 DiamondClaw = 0x0AB375;
		static const UINT32 IronClaw = 0x08CDFA;
		static const UINT32 CoralDragonClaw = 0x0B634C;
		static const UINT32 E3GoldenClaw = 0x0999E7;
		static const UINT32 SapphireDragonClaw = 0x0663D7;
		static const UINT32 MS13GoldenClaw = 0x039647;

		if (misc->formID == LockPick)
			type = GFxItem::Type::kType_MiscLockPick;
		else if (misc->formID == Gold)
			type = GFxItem::Type::kType_MiscGold;
		else if (misc->formID == Leather01)
			type = GFxItem::Type::kType_MiscLeather;
		else if (misc->formID == LeatherStrips)
			type = GFxItem::Type::kType_MiscStrips;
		else if (misc->HasKeywordID(VendorItemAnimalHideFormId))
			type = GFxItem::Type::kType_MiscHide;
		else if (misc->HasKeywordID(VendorItemDaedricArtifactFormId))
			type = GFxItem::Type::kType_MiscArtifact;
		else if (misc->HasKeywordID(VendorItemGemFormId))
			type = GFxItem::Type::kType_MiscGem;
		else if (misc->HasKeywordID(VendorItemAnimalPartFormId))
			type = GFxItem::Type::kType_MiscRemains;
		else if (misc->HasKeywordID(VendorItemOreIngotFormId))
			type = GFxItem::Type::kType_MiscIngot;
		else if (misc->HasKeywordID(VendorItemClutterFormId))
			type = GFxItem::Type::kType_MiscClutter;
		else if (misc->HasKeywordID(VendorItemFirewoodFormId))
			type = GFxItem::Type::kType_MiscWood;
		else if (misc->formID == RubyDragonClaw || misc->formID == IvoryDragonClaw || misc->formID == GlassCraw || misc->formID == EbonyCraw || misc->formID == EmeraldDragonClaw || misc->formID == DiamondClaw || misc->formID == IronClaw || misc->formID == CoralDragonClaw || misc->formID == E3GoldenClaw || misc->formID == SapphireDragonClaw || misc->formID == MS13GoldenClaw)
			type = GFxItem::Type::kType_MiscDragonClaw;

		return type;
	}

	static GFxItem::Type GetItemTypeSoulGem(TESSoulGem* gem)
	{
		GFxItem::Type type = GFxItem::Type::kType_MiscSoulGem;

		const static UINT32 DA01SoulGemAzurasStar = 0x063B27;
		const static UINT32 DA01SoulGemBlackStar = 0x063B29;

		if (gem->formID == DA01SoulGemBlackStar || gem->formID == DA01SoulGemAzurasStar) {
			type = GFxItem::Type::kType_SoulGemAzura;
		} else {
			if (gem->GetMaximumCapacity() < SOUL_LEVEL::kGrand) {
				if (gem->GetContainedSoul() == SOUL_LEVEL::kNone)
					type = GFxItem::Type::kType_SoulGemEmpty;
				else if (gem->GetContainedSoul() >= gem->GetMaximumCapacity())
					type = GFxItem::Type::kType_SoulGemFull;
				else
					type = GFxItem::Type::kType_SoulGemPartial;
			} else {
				if (gem->GetContainedSoul() == SOUL_LEVEL::kNone)
					type = GFxItem::Type::kType_SoulGemGrandEmpty;
				else if (gem->GetContainedSoul() >= gem->GetMaximumCapacity())
					type = GFxItem::Type::kType_SoulGemGrandFull;
				else
					type = GFxItem::Type::kType_SoulGemGrandPartial;
			}
		}

		return type;
	}

	const GFxItem::Type GetItemTypeBook(TESObjectBOOK* book)
	{
		GFxItem::Type type = GFxItem::Type::kType_DefaultBook;

		const static UINT32 VendorItemRecipeFormID = 0x000F5CB0;
		const static UINT32 VendorItemSpellTomeFormID = 0x000937A5;

		if (book->data.type.underlying() == 0xFF || book->HasKeywordID(VendorItemRecipeFormID)) {
			type = GFxItem::Type::kType_BookNote;
		} else if (book->HasKeywordID(VendorItemSpellTomeFormID)) {
			type = GFxItem::Type::kType_BookTome;
		}

		return type;
	}
	GFxItem::Type GFxItem::GetItemType(TESForm* form) const
	{
		Type type = Type::kType_None;

		switch (form->formType.get()) {
		case FormType::Scroll:
			type = Type::kType_DefaultScroll;
			break;
		case FormType::Armor:
			type = GetItemTypeArmor(static_cast<TESObjectARMO*>(form));
			break;
		case FormType::Book:
			type = GetItemTypeBook(static_cast<TESObjectBOOK*>(form));
			break;
		case FormType::Ingredient:
			type = GFxItem::Type::kType_DefaultIngredient;
			break;
		case FormType::Light:
			type = GFxItem::Type::kType_MiscTorch;
			break;
		case FormType::Misc:
			type = GetItemTypeMisc(static_cast<TESObjectMISC*>(form));
			break;
		case FormType::Weapon:
			type = GetItemTypeWeapon(static_cast<TESObjectWEAP*>(form));
			break;
		case FormType::Ammo:
			type = (static_cast<TESAmmo*>(form)->IsBolt()) ? GFxItem::Type::kType_WeaponBolt : GFxItem::Type::kType_WeaponArrow;
			break;
		case FormType::KeyMaster:
			type = GFxItem::Type::kType_DefaultKey;
			break;
		case FormType::AlchemyItem:
			type = GetItemTypePotion(static_cast<AlchemyItem*>(form));
			break;
		case FormType::SoulGem:
			type = GetItemTypeSoulGem(static_cast<TESSoulGem*>(form));
			break;
		}

		return type;
	}

	const char* GFxItem::GetItemIconLabel(Type form) const
	{
		if (form < sizeof(strIcons) / sizeof(strIcons[0]))
			return strIcons[form];

		return strIcons[0];
	}
}

