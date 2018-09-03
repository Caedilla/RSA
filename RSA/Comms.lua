local RSA =  RSA or LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")

local HighNumber = time()*time()
local CanAnnounce
local GroupMembers = {}
local GroupLeader
local GroupAssistants = {}

RSA.Comm = {}
RSA.Comm.GroupStatus = {}
--RSA.Comm.GroupAnnouncer


function RSA.GetMyRandomNumber()
	local random = math.random(1,time())
	local namebytes = 0
	for i = 1,string.len(UnitName("player")) do
		namebytes = namebytes + string.byte(UnitName("player"),i)
    end
    local random = tostring(random) .. tostring(namebytes)
	return random
end

function RSA.CheckGroupStatus(Status)
    if not RSA.db.global.ID then
        RSA.db.global.ID = RSA.GetMyRandomNumber()
    end
    RSA.SendCommMessage("RSA","RSA_Status",RSA.db.global.ID,"GUILD")
end

function RSA.OnStatusReceived(addon, prefix, message, channel, sender)
    --[[local random = string.gsub(message,"%d*%-","")
    local namebytes = string.gsub(message,"%-%d*","")
    local fullnumber = string.gsub(message,"%-*","")]]--

    local SenderInfo = {
        ["Name"] = sender,
        --["Random"] = tonumber(random),
        --["Bytes"] = tonumber(namebytes),
        ["ID"] = tonumber(message),
    }
    GroupMembers[sender] = SenderInfo

    for k,v in pairs(GroupMembers) do
        if GroupMembers[k].ID < HighNumber then
            RSA.Comm.GroupAnnouncer = GroupMembers[k].ID
        end
    end
    if RSA.Comm.GroupAnnouncer == tonumber(RSA.db.global.ID) then -- Group Announcer is me.
    else -- Group Announcer is someone else.
    end

end

function RSA.GroupLeft()
    RSA.Comm.GroupAnnouncer = nil
    wipe(GroupMembers)
    wipe(GroupAssistants)
end


RSA:RegisterEvent("PLAYER_TARGET_CHANGED","CheckGroupStatus") -- TESTING ONLY
RSA:RegisterEvent("PLAYER_STARTED_MOVING","GroupLeft") -- TESTING ONLY

--RSA:RegisterEvent("GROUP_ROSTER_UPDATE","CheckGroupStatus","Update")
--RSA:RegisterEvent("GROUP_FORMED","CheckGroupStatus","Join")
--RSA:RegisterEvent("GROUP_JOINED","CheckGroupStatus","Join")
--RSA:RegisterEvent("GROUP_LEFT","GroupLeft")