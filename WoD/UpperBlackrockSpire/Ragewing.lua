
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ragewing the Untamed", 995, 1229)
if not mod then return end
mod:RegisterEnableMob(76585)

--------------------------------------------------------------------------------
-- Locals
--

local percent = 70

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{155620, "FLASH"}, -- Burning Rage
		155051, -- Magma Spit
		{154996, "FLASH"}, -- Engulfing Fire
		-10740, -- Ragewing Whelp
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "BurningRage", 155620)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BurningRage", 155620)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "EngulfingFire", "boss1")

	self:Log("SPELL_CAST_SUCCESS", "SwirlingWinds", 167203)

	self:Log("SPELL_DAMAGE", "MagmaSpit", 155051)
	self:Log("SPELL_MISSED", "MagmaSpit", 155051)

	self:Death("Win", 76585)
end

function mod:OnEngage()
	percent = 70
	self:CDBar(154996, 15.7) -- Engulfing Fire
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BurningRage(args)
	self:Message(args.spellId, "Urgent", self:Dispeller("enrage", true) and "Warning", CL.onboss:format(args.spellName))
	if self:Dispeller("enrage", true) then
		self:Flash(args.spellId)
	end
end

function mod:EngulfingFire(unit, _, _, _, spellId)
	if spellId == 154996 then -- Engulfing Fire
		self:Message(spellId, "Attention", "Warning")
		self:Flash(spellId)
		self:CDBar(spellId, 24) -- 24-28
	end
end

function mod:SwirlingWinds(args)
	self:Message(-10740, "Important", "Long", ("%d%% - %s"):format(percent, self:SpellName(93679)), 93679) -- 93679 = Summon Whelps
	self:StopBar(155025) -- Engulfing Fire
	percent = 40
end

function mod:MagmaSpit(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
	end
end

