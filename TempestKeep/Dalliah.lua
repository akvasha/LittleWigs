﻿------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Dalliah the Doomsayer"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local L2 = AceLibrary("AceLocale-2.2"):new("BigWigsCommonWords")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Dalliah",

	ww = "Whirlwind",
	ww_desc = "Warns for Dalliah's Whirlwind",
	ww_trigger = "Dalliah the Doomsayer gains Whirlwind.", --she doesn't yell everytime, this is more effective.
	ww_trigger1 = "Place holder 1", --This is for backwards compatibility and will be removed shorty.
	ww_trigger2 = "Place holder 2", --This is for backwards compatibility and will be removed shorty.
	ww_message = "Dalliah begins to Whirlwind!",

	gift = "Gift of the Doomsayer",
	gift_desc = "Warns for Dalliah's Gift of the Doomsayer debuff",
	gift_trigger = "^([^%s]+) ([^%s]+) afflicted by Gift of the Doomsayer.",
	gift_message = "%s has Gift of the Doomsayer!",
	gift_bar = "Gifted: %s",

	heal = "Healing",
	heal_desc = "Warns when Dalliah is casting a heal",
	heal_trigger = "Dalliah the Doomsayer begins to cast Heal.",
	heal_message = "Casting Heal!",
} end )

L:RegisterTranslations("koKR", function() return {
	ww = "소용돌이",
	ww_desc = "달리아의 소용돌이에 대한 경고",
	ww_trigger1 = "산산조각 내 버리겠어!",
	ww_trigger2 = "소용돌이를 받아라!",
	-- Could be more yell triggers
	ww_message = "달리아 소용돌이 시작!",

	gift = "파멸의 예언자의 선물",
	gift_desc = "달리아의 파멸의 예언자의 선물 디버프에 대한 알림",
	gift_trigger = "^([^|;%s]*)(.*)파멸의 예언자의 선물에 걸렸습니다%.$",
	gift_message = "%s 파멸의 예언자의 선물!",
	gift_bar = "예언자의 선물: %s",
} end )

L:RegisterTranslations("zhTW", function() return {
	ww = "旋風斬",
	ww_desc = "旋風斬警報",
	ww_trigger1 = "我將把你碎屍萬段!",
	ww_trigger2 = "獲得了旋風斬的效果。",
	-- Could be more yell triggers
	ww_message = "達利亞要發動旋風斬了！",

	gift = "末日預言者的賜福",
	gift_desc = "達利亞獲得末日預言者的賜福時發出警報",
	gift_trigger = "^(.+)受到(.*)末日預言者的賜福",
	gift_message = "%s 受到末日預言者的賜福的傷害！",
	gift_bar = "賜福: %s",
} end )

L:RegisterTranslations("frFR", function() return {
	ww = "Tourbillon",
	ww_desc = "Préviens quand Dalliah fait son Tourbillon.",
	ww_trigger1 = "Je vais vous découper en petits morceaux !",
	ww_trigger2 = "Récoltez la tempête !",
	-- Could be more yell triggers
	ww_message = "Dalliah gagne Tourbillon !",

	gift = "Don de l'auspice funeste",
	gift_desc = "Préviens quand quelqu'un est affecté par le Don de l'auspice funeste.",
	gift_trigger = "^([^%s]+) ([^%s]+) les effets .* Don de l'auspice funeste.",
	gift_message = "%s a le Don de l'auspice funeste !",
	gift_bar = "Don : %s",
} end )

L:RegisterTranslations("deDE", function() return {
	ww = "Wirbelwind",
	ww_desc = "Warnt vor Dalliah's Wirbelwind",
	ww_trigger1 = "Ich werde Euch in St\195\188cke schneiden!",
	ww_trigger2 = "Erntet den Sturm!",
	-- Could be more yell triggers
	ww_message = "Dalliah beginnt mit Wirbelwind!",

	gift = "Gabe des Verdammnisverk\195\188nders",
	gift_desc = "Warnt vor Dalliah's 'Gabe des Verdammnisverk\195\188nders'-Debuff",
	gift_trigger = "^([^%s]+) ([^%s]+) von Gabe des Verdammnisverk\195\188nders betroffen.",
	gift_message = "%s hat Gabe des Verdammnisverk\195\188nders!",
	gift_bar = "Gabe: %s",
} end )


--末日预言者达尔莉安
L:RegisterTranslations("zhCN", function() return {
	ww = "旋风斩",
	ww_desc = "达尔莉安旋风斩警报",
	ww_trigger1 = "I'll cut you to pieces!",
	ww_trigger2 = "Reap the whirlwind!",
	-- Could be more yell triggers
	ww_message = "旋风斩!",

	gift = "末日预言者的礼物",
	gift_desc = "当达尔莉安获得末日预言者的礼物时发出警报",
	gift_trigger = "^([^%s]+)受([^%s]+)了末日预言者的礼物效果的影响。$",
	gift_message = "%s 受到了末日预言者的礼物!",
	gift_bar = "礼物: %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Arcatraz"]
mod.enabletrigger = boss 
mod.toggleoptions = {"ww", "gift", "heal", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "WW")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", "WW")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", "Heal")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", "Gift")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", "Gift")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:WW(msg)
	if not self.db.profile.ww then return end
	if msg == L["ww_trigger1"] or msg == L["ww_trigger2"] or msg == L["ww_trigger"] then
		self:Message(L["ww_message"], "Important")
		self:Bar(L["ww"], 6, "Ability_Whirlwind")
	end
end

function mod:Gift(msg)
	if not self.db.profile.gift then return end
	local player, type = select(3, msg:find(L["gift_trigger"]))
	if player and type then
		if player == L2["you"] and type == L2["are"] then
			player = UnitName("player")
		end
		self:Message(L["gift_message"]:format(player), "Urgent")
		self:Bar(L["gift_bar"]:format(player), 10, "Spell_Shadow_AntiShadow")
	end
end

function mod:Heal(msg)
	if not self.db.profile.heal then return end
	if msg == L["heal_trigger"] then
		self:Message(L["heal_message"], Urgent)
	end
end
