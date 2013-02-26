--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
----------------------------------------------------------------------]]

local STRING_STYLE  = "%s|| "
	-- %s = chat string (eg. "Guild", "2. Trade") (required)
	-- Pipe characters must be escaped by doubling them: | -> ||

local CHANNEL_STYLE = "%d"
	-- %d = channel number (optional)
	-- %s = channel name (optional)
	-- Will be used with STRING_STYLE for numbered channels.

local PLAYER_STYLE  = "%s"
	-- %s = player name (required)

local NUM_LINES_TO_SCROLL = 3
	-- Lines scrolled per turn of mouse wheel

local CUSTOM_CHANNELS = {
	-- Not case-sensitive. Must be in the format:
	-- ["mychannel"] = "MC",
}

------------------------------------------------------------------------

local DEFAULT_STRINGS = {
	-- If you play in a non-English locale, you'll need to edit the
	-- relevant file in the Locales subfolder, instead of this table.

	CONVERSATION_ABBR        =    "",
	GENERAL_ABBR             =   "G",
	LOCALDEFENSE_ABBR        =  "LD",
	LOOKINGFORGROUP_ABBR     = "LFG",
	TRADE_ABBR               =   "T",
	WORLDDEFENSE_ABBR        =  "WD",

	GUILD_ABBR                = "g",
	OFFICER_ABBR              = "o",
	PARTY_ABBR                = "p",
	PARTY_GUIDE_ABBR          = "P",
	PARTY_LEADER_ABBR         = "P",
	RAID_ABBR                 = "r",
	RAID_LEADER_ABBR          = "R",
	RAID_WARNING_ABBR         = "W",
	INSTANCE_CHAT_ABBR        = "i",
	INSTANCE_CHAT_LEADER_ABBR = "I",
	SAY_ABBR                  = "s",
	YELL_ABBR                 = "y",
	WHISPER_ABBR              = "w",
	WHISPER_INFORM_ABBR       = "@",
}

------------------------------------------------------------------------

DEFAULT_CHATFRAME_ALPHA = 0.25
	-- Opacity of chat frames when the mouse is over them.
	-- Default is 0.25.

CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0
	-- Opacity of the currently selected chat tab.
	-- Defaults are 1 and 0.4.

CHAT_FRAME_TAB_ALERTING_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_ALERTING_NOMOUSE_ALPHA = 0
	-- Opacity of currently alerting chat tabs.
	-- Defaults are 1 and 1.

CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0
	-- Opacity of non-selected, non-alerting chat tabs.
	-- Defaults are 0.6 and 0.2.

CHAT_FRAME_FADE_OUT_TIME = 0
	-- Seconds before fading out chat frames the mouse moves out of.
	-- Default is 2.

CHAT_TAB_HIDE_DELAY = 0
	-- Seconds before fading out chat tabs the mouse moves out of.
	-- Default is 1.

------------------------------------------------------------------------
--	Beyond here lies nothin'.
------------------------------------------------------------------------

local PHANXCHAT, PhanxChat = ...

PhanxChat.name = PHANXCHAT
PhanxChat.debug = false

PhanxChat.RunOnLoad = {}
PhanxChat.RunOnProcessFrame = {}

PhanxChat.STRING_STYLE = STRING_STYLE

local frames = {}
PhanxChat.frames = frames

local hooks = {}
PhanxChat.hooks = hooks

local noop = function() return end

local db

local format, gsub, strlower, strmatch, strsub, tonumber, type = format, gsub, strlower, strmatch, strsub, tonumber, type

------------------------------------------------------------------------

if not PhanxChat.L then
	PhanxChat.L = DEFAULT_STRINGS
end

local L = setmetatable(PhanxChat.L, { __index = function(t, k)
	if type(k) ~= "string" then return "" end
	t[k] = k
	return k
end })

------------------------------------------------------------------------

local CHANNEL_LINK   = "|h" .. format(STRING_STYLE, CHANNEL_STYLE) .. "|h"

local PLAYER_LINK    = "|Hplayer:%s|h" .. PLAYER_STYLE .. "|h"
local PLAYER_BN_LINK = "|HBNplayer:%s|h" .. PLAYER_STYLE .. "%s|h"

local ChannelNames = {
	[L["Conversation"]]	    = L.CONVERSATION_ABBR,
	[L["General"]]          = L.GENERAL_ABBR,
	[L["LocalDefense"]]     = L.LOCALDEFENSE_ABBR,
	[L["LookingForGroup"]]  = L.LOOKINGFORGROUP_ABBR,
	[L["Trade"]]            = L.TRADE_ABBR,
	[L["WorldDefense"]]     = L.WORLDDEFENSE_ABBR,
}

for name, abbr in pairs(CUSTOM_CHANNELS) do
	ChannelNames[strlower(name)] = abbr
end

local CHANNEL_PATTERN      = "|h%[(%d+)%.%s?([^%]%:%-]-)%s?[%:%-]?[^%]]*%]|h%s?"
local CHANNEL_PATTERN_PLUS = "|h%[(%d+)%.%s?([^%]%:%-]-)%s?[%:%-]?[^%]]*%]|h%s?.+"

local PLAYER_PATTERN = "|Hplayer:(.-)|h%[(.-)%]|h"
local BNPLAYER_PATTERN = "|HBNplayer:(.-)|h%[(|Kf(%d+).-)%](.*)|h"

local AddMessage = function(frame, message, ...)
	if type(message) == "string" then
		if db.ShortenChannelNames then
			local channelID, channelName = strmatch(message, CHANNEL_PATTERN_PLUS)
			if channelID then
				channelName = ChannelNames[channelName] or ChannelNames[strlower(channelName)] or strsub(channelName, 1, 2)
				message = gsub(message, CHANNEL_PATTERN, (CHANNEL_LINK:gsub("%%d", channelID):gsub("%%s", channelName)))
			end
		end

		local playerData, playerName = strmatch(message, PLAYER_PATTERN)
		if playerData then
			if db.RemoveServerNames then
				if strmatch(playerName, "|cff") then
					playerName = gsub(playerName, "%-[^|]+", "")
				else
					playerName = strmatch(playerName, "[^%-]+")
				end
			end
			message = gsub(message, PLAYER_PATTERN, format(PLAYER_LINK, playerData, playerName))
		end

		local bnData, bnName, bnID, bnExtra = strmatch(message, BNPLAYER_PATTERN)
		if bnData then
			if db.ReplaceRealNames or db.ShortenRealNames ~= "FULLNAME" then
				bnName = PhanxChat.bnetNames[tonumber(bnID) or ""] or bnName
			end
			local link = format(PLAYER_BN_LINK, bnData, bnName, bnExtra or "")
			message = gsub(message, BNPLAYER_PATTERN, link)
		end
	end
	hooks[frame].AddMessage(frame, message, ...)
end

------------------------------------------------------------------------

local IsControlKeyDown, IsShiftKeyDown = IsControlKeyDown, IsShiftKeyDown

local bottomButton = setmetatable({}, { __index = function(t, self)
	local button = _G[self:GetName() .. "ButtonFrameBottomButton"]
	t[self] = button
	return button
end })

function FloatingChatFrame_OnMouseScroll(self, delta)
	if delta > 0 then
		if IsShiftKeyDown() then
			self:ScrollToTop()
		elseif IsControlKeyDown() then
			self:PageUp()
		else
			for i = 1, NUM_LINES_TO_SCROLL do
				self:ScrollUp()
			end
		end
	elseif delta < 0 then
		if IsShiftKeyDown() then
			self:ScrollToBottom()
		elseif IsControlKeyDown() then
			self:PageDown()
		else
			for i = 1, NUM_LINES_TO_SCROLL do
				self:ScrollDown()
			end
		end
	end

	if db.HideButtons then
		if self:AtBottom() then
			bottomButton[self]:Hide()
		else
			bottomButton[self]:Show()
		end
	end
end

------------------------------------------------------------------------

local playerRealm = GetRealmName()

hooksecurefunc("ChatEdit_OnSpacePressed", function(editBox)
	if editBox.autoCompleteParams then
		return -- print("autoCompleteParams")
	end
	local command, message = strmatch(editBox:GetText(), "^/[tw]t (.*)")
	if command and UnitIsPlayer("target") and UnitCanCooperate("player", "target") then
		editBox:SetAttribute("chatType", "WHISPER")
		editBox:SetAttribute("tellTarget", GetUnitName("target", true):gsub("%s", ""))
		editBox:SetText(message or "")
		ChatEdit_UpdateHeader(editBox)
	end
end)

SLASH_TELLTARGET1 = "/tt"
SLASH_TELLTARGET2 = "/wt"

SlashCmdList.TELLTARGET = function(message)
	if UnitIsPlayer("target") and UnitCanCooperate("player", "target") then
		SendChatMessage(message, "WHISPER", nil, GetUnitName("target", true):gsub("%s", ""))
	elseif UnitExists("target") then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00"..PHANXCHAT..":|r "..L["You can't whisper that target!"])
	else
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00"..PHANXCHAT..":|r "..L["You don't have a target to whisper!"])
	end
end

------------------------------------------------------------------------

function PhanxChat:ProcessFrame(frame)
	if frames[frame] then return end

	local history = {}
	for i = 1, frame:GetNumMessages() do
		local text, accessID, lineID, extraData = frame:GetMessageInfo(i)
		history[i] = text
	end
	frame:SetMaxLines(512)
	for i = 1, #history do
		frame:AddMessage(history[i])
	end

	frame:SetClampRectInsets(0, 0, 0, 0)
	frame:SetMaxResize(UIParent:GetWidth(), UIParent:GetHeight())
	frame:SetMinResize(200, 40)

	if self.debug then print("PhanxChat: ProcessFrame", frame:GetName()) end

	if frame ~= COMBATLOG then
		if not hooks[frame] then
			hooks[frame] = {}
		end
		if not hooks[frame].AddMessage then
			hooks[frame].AddMessage = frame.AddMessage
			frame.AddMessage = AddMessage
		end
	end

	-- #TODO: Move this to a separate module?
	if db.FontSize then
		FCF_SetChatWindowFontSize(nil, frame, db.FontSize)
	end

	if not self.isLoading then
		for _, func in ipairs(self.RunOnProcessFrame) do
			func(self, frame)
		end
	end

	frames[frame] = true
end

for i = 1, NUM_CHAT_WINDOWS do
	_G["ChatFrame" .. i]:SetClampRectInsets(0, 0, 0, 0)
end

FCF_ValidateChatFramePosition = noop

------------------------------------------------------------------------

function PhanxChat:ADDON_LOADED(addon)
	if addon ~= PHANXCHAT then return end
	if self.debug then print("PhanxChat: ADDON_LOADED") end

	self.defaults = {
		EnableArrows        = true,
		EnableResizeEdges   = true,
		EnableSticky        = "ALL",  -- may be ALL, BLIZZARD, or NONE
		FadeTime			= 1,      -- 0 disables fading
		HideButtons         = true,
		HideFlash           = false,
		HideNotices         = false,
		HideRepeats         = true,
		HideTextures        = true,
		LinkURLs            = true,
		LockTabs            = true,
		MoveEditBox         = true,
		RemoveServerNames   = true,
		ReplaceRealNames    = "FIRSTNAME", -- BATTLETAG, CHARACTER, FIRSTNAME, FULLNAME
		ShortenChannelNames = true,
	}

	if not PhanxChatDB then
		PhanxChatDB = {}
	end
	self.db = PhanxChatDB
	db = PhanxChatDB -- faster access for AddMessage

	for k, v in pairs(self.defaults) do
		if type(db[k]) ~= type(v) then
			db[k] = v
		end
	end

	self.isLoading = true

	for i = 1, NUM_CHAT_WINDOWS do
		self:ProcessFrame(_G["ChatFrame" .. i])
	end

	hooks.FCF_OpenTemporaryWindow = FCF_OpenTemporaryWindow
	FCF_OpenTemporaryWindow = function(...)
		local frame = hooks.FCF_OpenTemporaryWindow(...)
		self:ProcessFrame(frame)
		return frame
	end

	for i = 1, #self.RunOnLoad do
		self.RunOnLoad[i](self)
	end

	self.isLoading = nil

	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
end

------------------------------------------------------------------------

PhanxChat.frame = CreateFrame("Frame")
PhanxChat.frame:RegisterEvent("ADDON_LOADED")
PhanxChat.frame:SetScript("OnEvent", function(self, event, ...)
	-- print("PhanxChat: " .. event)
	return PhanxChat[event] and PhanxChat[event](PhanxChat, ...)
end)

function PhanxChat:RegisterEvent(event) return self.frame:RegisterEvent(event) end
function PhanxChat:UnregisterEvent(event) return self.frame:UnregisterEvent(event) end

------------------------------------------------------------------------

_G.PhanxChat = PhanxChat

SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI