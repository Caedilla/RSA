------------------------------------------------
---- Raeli's Spell Announcer Utility Spells ----
------------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Utilities = RSA:NewModule("Utilities")

local spellinfo,spelllinkinfo,extraspellinfo,extraspellinfolink,missinfo
local Config_DivineShield
local Config_DivineShield_End
local MonitorConfig_Utilities

function RSA_Utilities:OnInitialize()
    RSA_Utilities.CombatLogMonitor = CreateFrame("Frame", "RSA_Utilities:CLM")
    RSA_Utilities.CombatLogMonitor:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function RSA_Utilities:OnEnable()
    RSA.db.profile.Modules.Utilities = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
    local Config_RepairBots = { -- Blessing of Sacrifice & Ultimate Sacrifice honour talent
        profile = 'Jeeves',
        comm = true,
        --sourceIsMe = true,
        replacements = { SOURCE = 1 }
    }
	MonitorConfig_Utilities = {
		player_profile = RSA.db.profile.Utilities,
		SPELL_SUMMON = {
            [22700] = Config_RepairBots, -- Field Repair Bot 74A
            [44389] = Config_RepairBots, -- Field Repair Bot 110G            
            [54711] = Config_RepairBots, -- Scrapbot (Northrend Engineering)
            [67826] = Config_RepairBots, -- Jeeves
            [157066] = Config_RepairBots, -- Walter (WoD Engineer Workshop)            
            [199109] = Config_RepairBots, -- Auto-Hammer
            [200205] = Config_RepairBots, -- Reaves Auto-Hammer mode
        },
    }

    RSA.UtilityMonitorConfig(MonitorConfig_Utilities)

    local function Spells()
        if RSA.db.profile.Modules.Utilities == false then return end
        local configType = "utilities"
        local timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, overheal, ex3, ex4 = CombatLogGetCurrentEventInfo()
        if RSA.AffiliationGroup(sourceFlags) then
            RSA.MonitorAndAnnounce(self, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, overheal, ex3, ex4, configType)
        end
    end
    RSA_Utilities.CombatLogMonitor:SetScript("OnEvent", Spells)
end

function RSA_Utilities:OnDisable()
    RSA.db.profile.Modules.Utilities = false 
    RSA_Utilities.CombatLogMonitor:SetScript("OnEvent", nil)
end
