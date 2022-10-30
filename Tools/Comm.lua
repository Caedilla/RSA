local RSA = LibStub('AceAddon-3.0'):GetAddon('RSA')
local L = LibStub('AceLocale-3.0'):GetLocale('RSA')

local groupMembers = {}
local groupAssistants = {}

RSA.Comm = {}

function RSA.Comm.Registry()
	--RSA:RegisterComm('RSA5', 'OnCommReceived')
	RSA:RegisterComm('RSA5Status', 'OnStatusReceived')
	RSA:RegisterComm('RSA5V', 'OnVersionCheckReceived')
end

function RSA.VersionCheck(type)
	if true == true then return end -- For RSA5 Alpha only
	if not type then return end
	if type == 'joinedGroup' then
		if IsInRaid() then
			RSA:SendCommMessage('RSA5V', RSA.db.global.version, (not IsInRaid(LE_PARTY_CATEGORY_HOME) and IsInRaid(LE_PARTY_CATEGORY_INSTANCE)) and 'INSTANCE_CHAT' or 'RAID')
		elseif IsInGroup() then
			RSA:SendCommMessage('RSA5V', RSA.db.global.version, (not IsInGroup(LE_PARTY_CATEGORY_HOME) and IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) and 'INSTANCE_CHAT' or 'PARTY')
		end
	end
	if type == 'guild' then
		if IsInGuild() and type then
			RSA:SendCommMessage('RSA5V', RSA.db.global.version, 'GUILD')
		end
	end
end

function RSA.OnVersionCheckReceived(addon, prefix, message, channel, sender)
	if true == true then return end -- For RSA5 Alpha only
	local mine = RSA.db.global.version
	local theirs = message

	local major, minor, patch = mine:gsub('%f[.]%.%f[^.]', '\0'):gmatch'%Z+'

	if mine < theirs then return end -- Don't warn on more recent development versions if we're on a more stable release type.
	if sender == UnitName('player') then return end -- Don't compare with self.
	if (tonumber(RSA.db.global.revision) < revision) and not RSA.Comm.userNotifiedOutOfDate then -- Someone else has a newer version
		RSA.Comm.userNotifiedOutOfDate = true -- don't warn again this session.
		RSA.Print_Self(L["Your version of RSA is out of date. You may want to grab the latest version from https://www.curseforge.com/wow/addons/rsa"])
	elseif tonumber(RSA.db.global.revision) > revision then -- We're on a newer version, but they should know this because we sent a comm message
	else -- their version is our version
	end
end

function RSA.CheckGroupStatus(self, status)
	if not RSA.db.global.personalID then
		RSA.db.global.personalID = RSA.GetPersonalID()
	end
	if IsInRaid() then
		RSA:SendCommMessage('RSA5Status', RSA.db.global.personalID, (not IsInRaid(LE_PARTY_CATEGORY_HOME) and IsInRaid(LE_PARTY_CATEGORY_INSTANCE)) and 'INSTANCE_CHAT' or 'RAID')
	elseif IsInGroup() then
		RSA:SendCommMessage('RSA5Status', RSA.db.global.personalID, (not IsInGroup(LE_PARTY_CATEGORY_HOME) and IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) and 'INSTANCE_CHAT' or 'PARTY')
	else
		RSA.Comm.groupAnnouncer = nil
		wipe(groupMembers)
		wipe(groupAssistants)
	end
	if status == 'joinedGroup' then
		RSA.VersionCheck('joinedGroup')
	elseif status == 'PLAYER_ENTERING_WORLD' then
		RSA.VersionCheck('guild')
	end
end

function RSA.OnStatusReceived(addon, prefix, message, channel, sender)
	--[[local random = string.gsub(message, '%d*%-', '')
	local namebytes = string.gsub(message, '%-%d*', '')
	local fullnumber = string.gsub(message, '%-*', '')]]--

	local SenderInfo = {
		['Name'] = sender,
		--['Random'] = tonumber(random),
		--['Bytes'] = tonumber(namebytes),
		['ID'] = tonumber(message),
	}
	groupMembers[sender] = SenderInfo

	for k, v in pairs(groupMembers) do
		if UnitIsGroupLeader(groupMembers[k].Name) then
			RSA.Comm.groupAnnouncer = groupMembers[k].ID
		end
		if UnitIsGroupAssistant(groupMembers[k].Name) then
			table.insert(groupAssistants, groupMembers[k].ID)
		end
	end

	if not RSA.Comm.groupAnnouncer then
		if #groupAssistants > 0 then
			local assistAnnouncer
			for i = 1, #groupAssistants do
				if i == 1 then
					assistAnnouncer = groupAssistants[i]
				elseif i > 1 then
					if assistAnnouncer < groupAssistants[i] then
						assistAnnouncer = groupAssistants[i]
					end
				end
			end
			RSA.Comm.groupAnnouncer = assistAnnouncer
		end
	end

	if not RSA.Comm.groupAnnouncer then
		local memberAnnouncer
		for i = 1, #groupMembers do
			if i == 1 then
				memberAnnouncer = groupMembers[i].ID
			elseif i > 1 then
				if memberAnnouncer < groupMembers[i].ID then
					memberAnnouncer = groupMembers[i].ID
				end
			end
			RSA.Comm.groupAnnouncer = memberAnnouncer
		end
	end


	if RSA.Comm.groupAnnouncer == tonumber(RSA.db.global.ID) then -- Group Announcer is me.
	else -- Group Announcer is someone else.
	end

end

function RSA.GroupLeft()
	RSA.Comm.groupAnnouncer = nil
	wipe(groupMembers)
	wipe(groupAssistants)
end


--RSA:RegisterEvent('PLAYER_TARGET_CHANGED', 'CheckGroupStatus') -- TESTING ONLY
--RSA:RegisterEvent('PLAYER_STARTED_MOVING', 'GroupLeft') -- TESTING ONLY

RSA:RegisterEvent('PLAYER_ENTERING_WORLD', 'CheckGroupStatus')
RSA:RegisterEvent('GROUP_ROSTER_UPDATE', 'CheckGroupStatus')
RSA:RegisterEvent('GROUP_FORMED', 'CheckGroupStatus', 'joinedGroup')
RSA:RegisterEvent('GROUP_JOINED', 'CheckGroupStatus', 'joinedGroup')
RSA:RegisterEvent('GROUP_LEFT', 'GroupLeft')