local RSA = LibStub('AceAddon-3.0'):GetAddon('RSA')
local uClass = string.lower(select(2, UnitClass('player')))
RSA.Monitor = {}

local running = {}
local messageCache = {}
local cacheTagSpellName = {}
local cacheTagSpellLink = {}
local replacements = {}
local missTypes = {
	'ABSORB',
	'BLOCK',
	'DEFLECT',
	'DODGE',
	'EVADE',
	'IMMUNE',
	'MISS',
	'PARRY',
	'REFLECT',
	'RESIST',
}

local function CommCheck(currentSpell)
	-- Track group announced spells using RSA.Comm (AddonMessages)
	local canAnnounce = true
	if currentSpell.comm then
		if RSA.Comm.groupAnnouncer then
			canAnnounce = true
			if RSA.Comm.groupAnnouncer == tonumber(RSA.db.global.ID) then -- This is us, continue as normal.
				canAnnounce = true
			else -- Someone else is announcing.
				canAnnounce = false
			end
		else -- No Group, continue as normal.
			canAnnounce = true
		end
	end
	return canAnnounce
end

local function BuildMessageCache(currentSpell, spellProfileName, event, fakeEvent)
	local currentSpellData = currentSpell.events[event]
	if fakeEvent then
		currentSpellData = currentSpell.events[fakeEvent]
	end

	-- Build Cache of valid messages
	-- We store empty strings when users blank a default message so we know not to use the default. An empty string can also be stored when a user deletes extra messages.
	-- We need to validate the list of messages so when we pick a message at random, we don't accidentally pick the blanked message.
	local messageCacheProfile = messageCache[spellProfileName]
	if not messageCacheProfile then
		messageCacheProfile = {}
		messageCache[spellProfileName] = {}
	end
	local validMessages = messageCacheProfile[currentSpellData]
	if not validMessages then
		validMessages = {}

		local numEvents = 0
		for _ in pairs(currentSpell.events) do
			numEvents = numEvents + 1
		end
		for i = 1, numEvents do
			if currentSpellData.messages[i] ~= '' then
				validMessages[i] = currentSpellData.messages[i]
			end
		end
		messageCache[spellProfileName][currentSpellData] = validMessages
	end
	if #validMessages == 0 then return end
	local message = validMessages[math.random(#validMessages)]
	if not message then return end
	message = gsub(message,'%%','%%%%')
	return message
end

function RSA:WipeMessageCache()
	wipe(messageCache)
end

local function HandleEvents()
	local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlag, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, ex1, ex2, ex3, ex4, ex5, ex6, ex7, ex8 = CombatLogGetCurrentEventInfo()

	local profile = RSA.db.profile

	if RSA.IsMe(sourceFlags) and type(spellName) == 'string' then
		print(event .. ": " .. tostring(spellID) .. " - " .. spellName)
	end

	local extraSpellID, extraSpellName, extraSchool = ex1, ex2, ex3
	local missType = ex1

	local spellProfileName = RSA.monitorData[uClass][spellID]
	if not spellProfileName then
		if RSA.monitorData['utilities'][spellID] then
			spellProfileName = RSA.monitorData['utilities'][spellID]
		elseif RSA.monitorData['racials'][spellID] then
			spellProfileName = RSA.monitorData['racials'][spellID]
		else
			for k in pairs(RSA.monitorData.customCategories) do
				if RSA.monitorData.customCategories[k][spellID] then
					spellProfileName = RSA.monitorData.customCategories[k][spellID]
				end
			end
		end
	end

	if event == 'SPELL_DISPEL' or event == 'SPELL_STOLEN' then
		if not spellProfileName then
			spellID, extraSpellID = extraSpellID, spellID
			spellName, extraSpellName = extraSpellName, spellName
			spellSchool, extraSchool = extraSchool, spellSchool
			spellProfileName = RSA.monitorData[uClass][spellID]
		end
	end
	if not spellProfileName then return end

	local currentSpell = profile[uClass][spellProfileName]
	if not currentSpell then return end
	if not currentSpell.events[event] then return end

	local currentSpellData = currentSpell.events[event]

	if currentSpellData.targetIsMe and not RSA.IsMe(destFlags) then return end
	if currentSpellData.targetNotMe and RSA.IsMe(destFlags) then return end
	if currentSpellData.sourceIsMe and not RSA.IsMe(sourceFlags) then return end

	if not currentSpellData.customSourceUnit and not RSA.IsMe(sourceFlags) then return end
	-- TODO: handle customDestUnit and parse it as well as customSourceUnit for valid units.

	-- Track multiple occurences of the same spell to more accurately detect it's real end point.
	local tracker = currentSpellData.tracker or nil -- Tracks spells like AoE Taunts to prevent multiple messages playing.
	if tracker then
		if tracker == 1 and running[spellProfileName] == nil then return end -- Prevent announcement if we didn't start the tracker (i.e Tank Metamorphosis random procs from Artifact)
		if tracker == 1 and running[spellProfileName] >= 500 then return end -- Prevent multiple announcements of buff/debuff removal.
		if tracker == 2 then
			if running[spellProfileName] ~= nil then
				if running[spellProfileName] >= 0 and running[spellProfileName] < 500 then -- Prevent multiple announcements of buff/debuff application.
					running[spellProfileName] = running[spellProfileName] + 1
					return
				end
			end
			running[spellProfileName] = 0
		end
		if tracker == 1 and running[spellProfileName] == 0 then
			running[spellProfileName] = running[spellProfileName] + 500
		end
		if tracker == 1 and running[spellProfileName] > 0 and running[spellProfileName] < 500 then
			running[spellProfileName] = running[spellProfileName] - 1
			return
		end
	end

	local fakeEvent
	if missType == 'IMMUNE' and event == 'SPELL_MISSED' then
		fakeEvent = 'RSA_SPELL_MISSED_IMMUNE'
	end
	local message = BuildMessageCache(currentSpell, spellProfileName, event, fakeEvent)
	if not message then return end

	-- Build Spell Name and Link Cache
	local tagSpellName = cacheTagSpellName[spellID]
	if not tagSpellName then
		tagSpellName = GetSpellInfo(spellID)
		cacheTagSpellName[spellID] = tagSpellName
	end

	local tagSpellLink = cacheTagSpellLink[spellID]
	if not tagSpellLink then
		tagSpellLink = GetSpellLink(spellID)
		cacheTagSpellLink[spellID] = tagSpellLink
	end

	if currentSpellData.uniqueSpellID then -- Replace cached data with 'real' spell name/link to announce the expected spell.
		local parentSpell = currentSpell.spellID

		tagSpellName = GetSpellInfo(parentSpell)
		cacheTagSpellName[spellID] = tagSpellName

		tagSpellLink = GetSpellLink(parentSpell)
		cacheTagSpellLink[spellID] = tagSpellLink
	end

	-- Trim Server Names
	local longName = destName
	if RSA.db.profile.general.globalAnnouncements.removeServerNames == true then
		if destName and destGUID then
			local realmName = select(7,GetPlayerInfoByGUID(destGUID))
			if realmName then
					destName = gsub(destName, '-'..realmName, '')
			end
		end
	end

	-- Build Tag replacements
	wipe(replacements)
	replacements['[SPELL]'] = tagSpellName
	replacements['[LINK]'] = tagSpellLink
	local tagReplacements = currentSpellData.tags or {}
	-- TODO: Add fallbacks in case people try to enable tags where there is no appropriate replacement.
	if tagReplacements.TARGET then replacements['[TARGET]'] = destName end
	if tagReplacements.SOURCE then replacements['[TARGET]'] = sourceName end
	if tagReplacements.AMOUNT then replacements['[AMOUNT]'] = ex1 end
	if tagReplacements.EXTRA then
		local name = cacheTagSpellName[extraSpellID]
		if not name then
			name = GetSpellInfo(extraSpellID)
			cacheTagSpellName[extraSpellID] = name
			replacements['[EXTRA]'] = name
		end
		local link = cacheTagSpellLink[extraSpellID]
		if not link then
			link = GetSpellLink(extraSpellID)
			cacheTagSpellLink[extraSpellID] = link
			replacements['[EXTRALINK]'] = link
		end
	end

	if tagReplacements.MISSTYPE then
		if RSA.db.profile.general.replacements.missType.useGenericReplacement == true then
			for i = 1,#missTypes do
				if missType == missTypes[i] then
					replacements['[MISSTYPE]'] = RSA.db.profile.general.replacements.missType.genericReplacementString
				end
			end
		else
			replacements['MISSTYPE'] = RSA.db.profile.general.replacements.missType[string.lower(missType)]
		end
	end

	if currentSpellData.channels.personal == true then
		if currentSpellData.groupRequired then -- Used in Mage Teleports, only locally announces if you are in a group.
			if not (GetNumSubgroupMembers() > 0 or GetNumGroupMembers() > 0) then return end
		end
		RSA.SendMessage.LibSink(gsub(message, ".%a+.", replacements))
	end

	if currentSpell.comm then -- Track group announced spells using RSA.Comm (AddonMessages)
		if not CommCheck(currentSpell) then return end
		--Local messages can always go through, so only check this after sending the local message.
	end

	if currentSpellData.channels.yell == true then
		RSA.SendMessage.Yell(gsub(message, ".%a+.", replacements))
	end
	if currentSpellData.channels.whisper == true and UnitExists(longName) and RSA.Whisperable(destFlags) then
		RSA.SendMessage.Whisper(message, longName, replacements, destName)
	end
	if currentSpellData.channels.say == true then
		RSA.SendMessage.Say(gsub(message, ".%a+.", replacements))
	end
	if currentSpellData.channels.emote == true then
		RSA.SendMessage.Emote(gsub(message, ".%a+.", replacements))
	end

	local announced = false
	if currentSpellData.channels.party == true then
		if RSA.SendMessage.Party(gsub(message, ".%a+.", replacements)) == true then announced = true end
	end
	if currentSpellData.channels.raid == true then
		if RSA.SendMessage.Raid(gsub(message, ".%a+.", replacements)) == true then announced = true end
	end
	if currentSpellData.channels.instance == true then
		if RSA.SendMessage.Instance(gsub(message, ".%a+.", replacements)) == true then announced = true end
	end
	if currentSpellData.channels.smartGroup == true and announced == false then
		RSA.SendMessage.SmartGroup(gsub(message, ".%a+.", replacements))
	end

end

function RSA.Monitor.Start()
	local monitorFrame = _G['RSACombatLogMonitor'] or nil
	if not monitorFrame then
		monitorFrame = CreateFrame("Frame", "RSACombatLogMonitor")
		monitorFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	end

	monitorFrame:SetScript('OnEvent', nil)
	monitorFrame:SetScript('OnEvent', HandleEvents)
end

function RSA.Monitor.Stop()
	local monitorFrame = _G['RSACombatLogMonitor'] or nil
	if not monitorFrame then return end
	monitorFrame:SetScript('OnEvent', nil)
end