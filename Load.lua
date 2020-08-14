local RSA = LibStub("AceAddon-3.0"):NewAddon("RSA", "AceConsole-3.0", "LibSink-2.0", "AceEvent-3.0", "AceComm-3.0")

-- Global Frames and Event Registers
RSA.SpellData = {}
RSA.monitorData = {}

RSA.Monitor = CreateFrame("Frame", "RSA:CLM")
RSA.Monitor:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")