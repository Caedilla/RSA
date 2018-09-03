local RSA = LibStub("AceAddon-3.0"):NewAddon("RSA", "AceConsole-3.0", "LibSink-2.0", "AceEvent-3.0", "AceComm-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local _, PlayerClass = UnitClass('player')
local ModuleName

function RSA:ChatCommand(input)
	if not InCombatLockdown() then
		if not IsAddOnLoaded("RSA_Options") then
			local loaded, reason = LoadAddOn("RSA_Options")
			if not loaded then
				ChatFrame1:AddMessage("|cFFFF75B3RSA|r [|cffFFCC00Options|r]"..L[" is disabled. If you want to configure RSA, you need to enable it."])
			else
				if input == "Blizz" then
					InterfaceOptionsFrame_OpenToCategory("RSA","RSA")
					InterfaceOptionsFrame_OpenToCategory("RSA","RSA")
				else
					LibStub("AceConfigDialog-3.0"):Open("RSA")
				end
			end
		else
			if input == "Blizz" then
				InterfaceOptionsFrame_OpenToCategory("RSA","RSA")
				InterfaceOptionsFrame_OpenToCategory("RSA","RSA")
			else
				LibStub("AceConfigDialog-3.0"):Open("RSA")	
			end
		end
	end	
end

function RSA:RefreshConfig()
	local Modules = {
		["DEATHKNIGHT"] = "DeathKnight",
		["DEMONHUNTER"] = "DemonHunter",
		["DRUID"] = "Druid",
		["HUNTER"] = "Hunter",
		["MAGE"] = "Mage",
		["MONK"] = "Monk",
		["PALADIN"] = "Paladin",
		["PRIEST"] = "Priest",
		["ROGUE"] = "Rogue",
		["SHAMAN"] = "Shaman",
		["WARLOCK"] = "Warlock",
		["WARRIOR"] = "Warrior",
	}	
	for k,v in pairs(Modules) do
		if k == PlayerClass then
			ModuleName = RSA:GetModule(v)
			ModuleName:Disable()
			ModuleName:Enable()
		end
	end

	RSA.db.profile = self.db.profile
	RSA:FixDB()
	RSA:UpdateOptions()


	if RSA.db.profile.Modules.Reminders == true then
		local loaded, reason = LoadAddOn("RSA_Reminders")
		if not loaded then
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Reminders " .. L.OptionsDisabled)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Reminders " .. L.OptionsMissing)
			end
		else
			RSA:EnableModule("Reminders")
		end
	else
		if LoadAddOn("RSA_Reminders") == 1 then
			RSA:DisableModule("Reminders")
		end
	end
end
