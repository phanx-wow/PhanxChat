--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and improves chat frame usability.
	By Phanx < addons@phanx.net >
	Copyright © 2006–2010 Phanx. See README for license terms.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx
----------------------------------------------------------------------]]

if ChatFrameEditBox then
	print("ATTENTION! This version of PhanxChat is only compatible with WoW 3.3.5 or higher.")
	print("Until your locale patches to 3.3.5, you should download an older version of PhanxChat.")
	return
end

local ADDON_NAME, PhanxChat = ...

------------------------------------------------------------------------
--	Advanced configuration
------------------------------------------------------------------------

-- Note that pipe characters must be doubled to escape themselves, since
-- they normally indicate the beginning of an escape sequence. If not
-- escaped, they can break real escape sequences that follow them.

local CHANNEL_STYLE = "%1||"
-- %1 = channel number
-- %2 = channel short name

local PLAYER_STYLE = "%s"
-- %s = player name

local STRING_STYLE = "%s||%%s: "
-- %s = chat string
-- %%s = player name

local STRING_STYLE_CHANNEL = "%s: "
-- %s = player name

local URL_STYLE = "|cff00ccff%s|r"
-- %s = player name

local NUM_SCROLL_LINES = 3

local framesToIgnore = {
	["*"] = {
		["ChatFrame2"] = true, -- Combat Log
	},
	["Server-Character"] = {
		["ChatFrame3"] = true,
	},
}

------------------------------------------------------------------------
--	Global overrides
--	This section allows you to change some values that the Blizzard UI
--	uses to affect the appearance of chat frames.
------------------------------------------------------------------------

DEFAULT_CHATFRAME_ALPHA = 0.25
-- Opacity of chat frames when the mouse is over them.
-- Default is 0.25.

CHAT_FRAME_FADE_OUT_TIME = 0
-- Seconds to wait before fading out chat frames the mouse moves out of.
-- Default is 2.

CHAT_TAB_HIDE_DELAY = 0
-- Seconds to wait before fading out chat tabs the mouse moves out of.
-- Default is 1.

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

------------------------------------------------------------------------
--	Locals
------------------------------------------------------------------------

local default_L = {
	-- Chat Strings
	SHORT_BATTLEGROUND = "b",
	SHORT_BATTLEGROUND_LEADER = "B",
	SHORT_BN_WHISPER = "F",
	SHORT_BN_WHISPER_INFORM = "T",
	SHORT_GUILD = "g",
	SHORT_OFFICER = "o",
	SHORT_PARTY = "p",
	SHORT_PARTY_GUIDE = "P",
	SHORT_PARTY_LEADER = "P",
	SHORT_RAID = "r",
	SHORT_RAID_LEADER = "R",
	SHORT_RAID_WARNING = "R",
	SHORT_SAY = "s",
	SHORT_WHISPER = "F",
	SHORT_WHISPER_INFORM = "T",
	SHORT_YELL = "y",

	-- Channel Names
	SHORT_GENERAL = "G",
	SHORT_TRADE = "T",
	SHORT_LOCALDEFENSE = "LD",
	SHORT_WORLDDEFENSE = "WD",
	SHORT_LOOKINGFORGROUP = "LF",
	SHORT_GUILDRECRUITMENT = "GR",
}

if not PhanxChat.L then
	PhanxChat.L = { }
end

local L = setmetatable(PhanxChat.L, { __index = function(t, k)
	t[k] = default_L[k] or k
	return t[k]
end })

local eventsToColor = {
	CHAT_MSG_AFK = true,
	CHAT_MSG_DND = true,
	CHAT_MSG_CHANNEL_JOIN = true,
	CHAT_MSG_CHANNEL_LEAVE = true,
	CHAT_MSG_CHANNEL_NOTICE = true,
	CHAT_MSG_CHANNEL_NOTICE_USER = true,
	CHAT_MSG_SYSTEM = true,
}

local eventsToFormat = {
	CHAT_MSG_ACHIEVEMENT = true,
	CHAT_MSG_AFK = true,
	CHAT_MSG_BATTLEGROUND = true,
	CHAT_MSG_BATTLEGROUND_LEADER = true,
	CHAT_MSG_BN_WHISPER = true,
	CHAT_MSG_BN_WHISPER_INFORM = true,
	CHAT_MSG_CHANNEL = true,
	CHAT_MSG_CHANNEL_JOIN = true,
	CHAT_MSG_CHANNEL_LEAVE = true,
	CHAT_MSG_CHANNEL_NOTICE = true,
	CHAT_MSG_CHANNEL_NOTICE_USER = true,
	CHAT_MSG_DND = true,
	CHAT_MSG_GUILD = true,
	CHAT_MSG_GUILD_ACHIEVEMENT = true,
	CHAT_MSG_OFFICER = true,
	CHAT_MSG_PARTY = true,
	CHAT_MSG_PARTY_GUIDE = true,
	CHAT_MSG_PARTY_LEADER = true,
	CHAT_MSG_RAID = true,
	CHAT_MSG_RAID_LEADER = true,
	CHAT_MSG_RAID_WARNING = true,
	CHAT_MSG_SAY = true,
	CHAT_MSG_SYSTEM = true,
	CHAT_MSG_WHISPER = true,
	CHAT_MSG_WHISPER_INFORM = true,
	CHAT_MSG_YELL = true,
}

local eventsToLinkURLs = {
	CHAT_MSG_BATTLEGROUND = true,
	CHAT_MSG_BATTLEGROUND_LEADER = true,
	CHAT_MSG_BN_WHISPER = true,
	CHAT_MSG_BN_WHISPER_INFORM = true,
	CHAT_MSG_CHANNEL = true,
	CHAT_MSG_DUNEON_GUIDE = true,
	CHAT_MSG_GUILD = true,
	CHAT_MSG_OFFICER = true,
	CHAT_MSG_PARTY = true,
	CHAT_MSG_PARTY_GUIDE = true,
	CHAT_MSG_PARTY_LEADER = true,
	CHAT_MSG_RAID = true,
	CHAT_MSG_RAID_LEADER = true,
	CHAT_MSG_RAID_WARNING = true,
	CHAT_MSG_SAY = true,
	CHAT_MSG_WHISPER = true,
	CHAT_MSG_WHISPER_INFORM = true,
	CHAT_MSG_YELL = true,
}

local eventsToFilterForNotices = {
	CHAT_MSG_CHANNEL_JOIN = true,
	CHAT_MSG_CHANNEL_LEAVE = true,
	CHAT_MSG_CHANNEL_NOTICE = true,
	CHAT_MSG_CHANNEL_NOTICE_USER = true,
}

local eventsToFilterForRepeats = {
	CHAT_MSG_SAY = true,
	CHAT_MSG_YELL = true,
	CHAT_MSG_CHANNEL = true,
	CHAT_MSG_EMOTE = true,
	CHAT_MSG_TEXT_EMOTE = true,
}

local function noop() return end

------------------------------------------------------------------------
--	Internals
------------------------------------------------------------------------

local playerRealm = GetRealmName()
local ACHIEVEMENT_BROADCAST = ACHIEVEMENT_BROADCAST:gsub("%%s[^%s]?", "") -- "%s has earned the achievement %s!"

local hooks = { }
local ChannelList = { }
local PlayerClasses = { }
local PlayerNames = { }

local ClassColors = { }
for k, v in pairs(RAID_CLASS_COLORS) do
	ClassColors[k] = ("%02x%02x%02x"):format(v.r * 255, v.g * 255, v.b * 255)
end

local ClassTokens = { }
do
	local t = { }
	FillLocalizedClassList(t, false)
	for k, v in pairs(t) do
		ClassTokens[v] = k
	end
	FillLocalizedClassList(t, true)
	for k, v in pairs(t) do
		ClassTokens[v] = k
	end
end

local ChannelNames = {
	[L["General"]]          = L.SHORT_GENERAL,
	[L["Trade"]]            = L.SHORT_TRADE,
	[L["LocalDefense"]]     = L.SHORT_LOCALDEFENSE,
	[L["WorldDefense"]]     = L.SHORT_WORLDDEFENSE,
	[L["LookingForGroup"]]  = L.SHORT_LOOKINGFORGROUP,
	[L["GuildRecruitment"]] = L.SHORT_GUILDRECRUITMENT,
}

local STRING_STYLE_LINK = STRING_STYLE:format("|Hchannel:%s|h%s|h")

local ShortStrings = {
	CHAT_BATTLEGROUND_GET        = STRING_STYLE_LINK:format("Battleground", L.SHORT_BATTLEGROUND, "%s"),
	CHAT_BATTLEGROUND_LEADER_GET = STRING_STYLE_LINK:format("Battleground", L.SHORT_BATTLEGROUND_LEADER, "%s"),
	CHAT_BN_WHISPER_GET          = STRING_STYLE:format(L.SHORT_BN_WHISPER, "%s"),
	CHAT_BN_WHISPER_INFORM_GET   = STRING_STYLE:format(L.SHORT_BN_WHISPER_INFORM, "%s"),
	CHAT_CHANNEL_GET             = STRING_STYLE_CHANNEL,
	CHAT_GUILD_GET               = STRING_STYLE_LINK:format("Guild", L.SHORT_GUILD, "%s"),
	CHAT_OFFICER_GET             = STRING_STYLE_LINK:format("o", L.SHORT_OFFICER, "%s"),
	CHAT_PARTY_GET               = STRING_STYLE_LINK:format("Party", L.SHORT_PARTY, "%s"),
	CHAT_PARTY_GUIDE_GET         = STRING_STYLE_LINK:format("Party", L.SHORT_PARTY_GUIDE, "%s"),
	CHAT_PARTY_LEADER_GET        = STRING_STYLE_LINK:format("Party", L.SHORT_PARTY_LEADER, "%s"),
	CHAT_RAID_GET                = STRING_STYLE_LINK:format("Raid", L.SHORT_RAID, "%s"),
	CHAT_RAID_LEADER_GET         = STRING_STYLE_LINK:format("Raid", L.SHORT_RAID_LEADER, "%s"),
	CHAT_RAID_WARNING_GET        = STRING_STYLE_LINK:format("Raid", L.SHORT_RAID_WARNING, "%s"),
	CHAT_SAY_GET                 = STRING_STYLE_LINK:format("s", L.SHORT_SAY, "%s"),
	CHAT_WHISPER_GET             = STRING_STYLE:format(L.SHORT_WHISPER, "%s"),
	CHAT_WHISPER_INFORM_GET      = STRING_STYLE:format(L.SHORT_WHISPER_INFORM, "%s"),
	CHAT_YELL_GET                = STRING_STYLE_LINK:format("y", L.SHORT_YELL, "%s"),
}

PLAYER_STYLE = "|Hplayer:%s|h" .. PLAYER_STYLE .. "%s|h"
URL_STYLE    = "|Hurl:%s|h" .. URL_STYLE .. "|h"

------------------------------------------------------------------------
--	Initialization functions
------------------------------------------------------------------------

if select(6, GetAddOnInfo("PhanxMod")) ~= "MISSING" then
	framesToIgnore["*"][ChatFrame3] = true 	-- Loot
	framesToIgnore["*"][ChatFrame7] = true 	-- Debug
end

function PhanxChat:ADDON_LOADED(addon)
	if addon ~= ADDON_NAME then return end

	local defaults = {
		autoStartChatLog = false,
		colorPlayerNames = true,
		disableTabFlash = true,
		enableArrowKeys = true,
		enableResizeEdges = true,
		fadeTime = 5,
		filterNotices = false,
		filterRepeats = false,
		hideButtons = true,
		hideCrap = true,
		linkURLs = true,
		lockDockedTabs = true,
		moveEditBox = true,
		shortChannels = true,
		stickyChannels = "BLIZZARD",
	}
	if not PhanxChatDB then
		PhanxChatDB = { }
	end
	self.db = PhanxChatDB
	for k, v in pairs(defaults) do
		if type(self.db[k]) ~= type(v) then
			self.db[k] = v
		end
	end

	if framesToIgnore["*"] then
		for k, v in pairs(framesToIgnore["*"]) do
			framesToIgnore[k] = v
		end
	end
	local t = framesToIgnore[("%s-%s"):format(playerRealm, UnitName("player"))]
	if t then
		for k, v in pairs(t) do
			framesToIgnore[k] = v
		end
	end

	for i = 1, 10 do
		local frame = _G[("ChatFrame%d"):format(i)]

		frame:SetClampRectInsets(0, 0, 0, 0)
		frame:SetMaxLines(250)
		frame:SetMaxResize(UIParent:GetWidth(), UIParent:GetHeight())
		frame:SetMinResize(150, 20)

		local tab = _G[("ChatFrame%dTab"):format(i)]
		local text = _G[("ChatFrame%dTabText"):format(i)]
		text:ClearAllPoints()
		text:SetPoint("BOTTOMLEFT", tab, 10, 5)
		text:SetPoint("BOTTOMRIGHT", tab, -10, 5)
		text:SetJustifyH("LEFT")

		if not framesToIgnore[frame] then
			if not hooks[frame] then
				hooks[frame] = { }
			end
			hooks[frame].AddMessage = frame.AddMessage
			frame.AddMessage = self.ChatFrame_AddMessage
		end
	end

	self.isLoading = true

	self:SetAutoStartChatLog()
	self:SetColorPlayerNames()
	self:SetDisableTabFlash()
	self:SetEnableArrowKeys()
	self:SetEnableResizeEdges()
	self:SetFadeTime()
	self:SetFilterNotices()
	self:SetFilterRepeats()
	self:SetHideButtons()
	self:SetHideCrap()
	self:SetLinkURLs()
	self:SetLockDockedTabs()
	self:SetMoveEditBox()
	self:SetShortChannels()
	self:SetStickyChannels()

	self.isLoading = nil
--[[
	SLASH_TELLTARGET1 = "/tt"
	SLASH_TELLTARGET2 = "/wt"
	SlashCmdList.TELLTARGET = self.TellTarget
]]
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil

	if IsLoggedIn() then
		self:PLAYER_LOGIN()
	else
		self:RegisterEvent("PLAYER_LOGIN")
	end
end

function PhanxChat:PLAYER_LOGIN()
	if CUSTOM_CLASS_COLORS then
		for k, v in pairs(CUSTOM_CLASS_COLORS) do
			ClassColors[k] = format("%02x%02x%02x", v.r * 255, v.g * 255, v.b * 255)
		end
		CUSTOM_CLASS_COLORS:RegisterCallback(function()
			for k, v in pairs(CUSTOM_CLASS_COLORS) do
				ClassColors[k] = format("%02x%02x%02x", v.r * 255, v.g * 255, v.b * 255)
			end
			for name, class in pairs(PlayerClasses) do
				PlayerNames[name] = nil
				self:RegisterName(name, class)
			end
		end)
	end
end

------------------------------------------------------------------------
--	General message formatting
------------------------------------------------------------------------

function PhanxChat.ChatFrame_AddMessage(frame, text, ...)
	if not event or eventsToFormat[event] then
		local name = event and event ~= "CHAT_MSG_SYSTEM" and arg2
		if not name then
			name = text:match("|Hplayer:(.-)[:|]")
		end
		if name then
			if PhanxChat.db.colorPlayerNames and eventsToColor[event] then
				text = text:gsub("|Hplayer:(.-)|h%[.-%](.-)|h", format(PLAYER_STYLE, "%1", PlayerNames[name] or name, "%2"), 1)
			else
				text = text:gsub("|Hplayer:(.-)|h%[(.-)%](.-)|h", PLAYER_STYLE:format("%1", "%2", "%3"), 1)
			end
		end
		if event == "CHAT_MSG_CHANNEL" and PhanxChat.db.shortChannels then
			text = text:gsub("%[%d+%.%s?[^%]%-]+%]%s?", (CHANNEL_STYLE:gsub("%%1", arg8, 1):gsub("%%2", ChannelList[arg8] or arg8, 1)), 1)
		end
	end
	hooks[frame].AddMessage(frame, text, ...)
end

------------------------------------------------------------------------
--	Automatically start logging chat
------------------------------------------------------------------------

function PhanxChat:SetAutoStartChatLog(v)
	if type(v) == "boolean" then
		self.db.autoStartChatLog = v
	end

	if self.db.autoStartChatLog then
		LoggingChat(1)
	end
end

------------------------------------------------------------------------
--	Color player names
------------------------------------------------------------------------

function PhanxChat:SetColorPlayerNames(v)
	if type(v) == "boolean" then
		self.db.colorPlayerNames = v
	end

	if self.db.colorPlayerNames then
		for k, v in pairs(ChatTypeInfo) do
			SetChatColorNameByClass(k, true)
			--v.colorNameByClass = true
		end

		self:RegisterEvent("CHAT_MSG_SYSTEM")
		self:RegisterEvent("FRIENDLIST_UPDATE")
		self:RegisterEvent("GUILD_ROSTER_UPDATE")
		self:RegisterEvent("PARTY_MEMBERS_CHANGED")
		self:RegisterEvent("PLAYER_GUILD_UPDATE")
		self:RegisterEvent("PLAYER_TARGET_CHANGED")
		self:RegisterEvent("RAID_ROSTER_UPDATE")
		self:RegisterEvent("UPDATE_LFG_LIST")
		self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
		self:RegisterEvent("WHO_LIST_UPDATE")

		self:RegisterName(UnitName("player"), select(2, UnitClass("player")))

		if GetNumFriends() > 0 then
			ShowFriends()
		end

		if IsInGuild() then
			GuildRoster()
		end
	elseif not self.isLoading then
		for k, v in pairs(ChatTypeInfo) do
			SetChatColorNameByClass(k, false)
			-- v.colorNameByClass = nil
		end

		self:UnregisterEvent("CHAT_MSG_SYSTEM")
		self:UnregisterEvent("FRIENDLIST_UPDATE")
		self:UnregisterEvent("GUILD_ROSTER_UPDATE")
		self:UnregisterEvent("PARTY_MEMBERS_CHANGED")
		self:UnregisterEvent("PLAYER_GUILD_UPDATE")
		self:UnregisterEvent("PLAYER_TARGET_CHANGED")
		self:UnregisterEvent("RAID_ROSTER_UPDATE")
		self:UnregisterEvent("UPDATE_LFG_LIST")
		self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
		self:UnregisterEvent("WHO_LIST_UPDATE")

		wipe(PlayerNames)
	end
end

function PhanxChat:RegisterName(name, class)
	if not name or not class or not ClassTokens[class] or PlayerNames[name] then return end
	local token = ClassTokens[class]
	PlayerClasses[class] = token
	PlayerNames[name] = ("|cff%s%s|r"):format(ClassColors[token], name)
end

function PhanxChat.GetColoredName(event, arg1, name, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, guid)
	if name and guid and guid ~= "" then
		if PlayerNames[name] then return end
		local _, class = GetPlayerInfoByGUID(guid)
		if class then
			PhanxChat:RegisterName(name, class)
		end
	end
	return hooks.GetColoredName(event, arg1, name, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, guid)
end

function PhanxChat:FRIENDLIST_UPDATE()
	local name, class
	for i = 1, GetNumFriends() do
		name, _, class = GetFriendInfo(i)
		self:RegisterName(name, class)
	end
end

function PhanxChat:PLAYER_GUILD_UPDATE()
	if IsInGuild() then
		GuildRoster()
	end
end

function PhanxChat:GUILD_ROSTER_UPDATE()
	local unregister
	for i = 1, GetNumGuildMembers(true) do
		local name, _, _, _, class = GetGuildRosterInfo(i)
		self:RegisterName(name, class)
		unregister = true
	end
	if unregister then
		self:UnregisterEvent("PLAYER_GUILD_UPDATE")
		self:UnregisterEvent("GUILD_ROSTER_UPDATE")
	end
end

function PhanxChat:UPDATE_LFG_LIST()
	for i = 1, SearchLFGGetNumResults() do
		local name, _, _, _, _, _, _, class = SearchLFGGetResults(i)
		self:RegisterName(name, class)
	end
end

function PhanxChat:PARTY_MEMBERS_CHANGED()
	local name, class
	for i = 1, GetNumPartyMembers() do
		self:RegisterName(UnitName("party" .. i), select(2, UnitClass("party" .. i)))
	end
end

function PhanxChat:RAID_ROSTER_UPDATE()
	local name, class
	for i = 1, GetNumRaidMembers() do
		name, _, _, _, _, class = GetRaidRosterInfo(i)
		self:RegisterName(name, class)
	end
end

function PhanxChat:PLAYER_TARGET_CHANGED()
	if not UnitExists("target") or not UnitIsPlayer("target") or not UnitIsFriend("player", "target") then return end
	self:RegisterName(UnitName("target"), select(2, UnitClass("target")))
end

function PhanxChat:UPDATE_MOUSEOVER_UNIT()
	if not UnitExists("mouseover") or not UnitIsPlayer("mouseover") or not UnitIsFriend("player", "mouseover") then return end
	self:RegisterName(UnitName("mouseover"), select(2, UnitClass("mouseover")))
end

function PhanxChat:WHO_LIST_UPDATE()
	local name, class
	for i = 1, GetNumWhoResults() do
		name, _, _, _, class = GetWhoInfo(i)
		self:RegisterName(name, class)
	end
end

function PhanxChat:CHAT_MSG_SYSTEM(message)
	if message:match("^%|Hplayer:") then
		self:WHO_LIST_UPDATE()
	end
end

------------------------------------------------------------------------
--	Disable tab flashing when new messages are received
------------------------------------------------------------------------

function PhanxChat:SetDisableTabFlash(v) -- #TODO: update for 3.3.5
	if type(v) == "boolean" then
		self.db.disableTabFlash = v
	end

	if self.db.disableTabFlash then
		for i = 1, 10 do
			local f = _G[("ChatFrame%dTabFlash"):format(i)]
			f:SetScript("OnShow", f.Hide)
			f:Hide()
		end
		if not hooks.FCF_FlashTab then
			hooks.FCF_FlashTab = FCF_FlashTab
			FCF_FlashTab = noop
		end
		if not hooks.FCF_StartAlertFlash then
			hooks.FCF_StartAlertFlash = FCF_StartAlertFlash
			FCF_StartAlertFlash = noop
		end
		if not hooks.FCF_StopAlertFlash then
			hooks.FCF_StopAlertFlash = FCF_StopAlertFlash
			FCF_StopAlertFlash = noop
		end
	elseif not self.isLoading then
		for i = 1, 10 do
			local f = _G[("ChatFrame%dTabFlash"):format(i)]
			f:SetScript("OnShow", nil)
		end
		if hooks.FCF_FlashTab then
			FCF_FlashTab = hooks.FCF_FlashTab
			hooks.FCF_FlashTab = nil
		end
		if hooks.FCF_StartAlertFlash then
			FCF_StartAlertFlash = hooks.FCF_StartAlertFlash
			hooks.FCF_StartAlertFlash = nil
		end
		if hooks.FCF_StopAlertFlash then
			FCF_StopAlertFlash = hooks.FCF_StopAlertFlash
			hooks.FCF_StopAlertFlash = nil
		end
	end
end

------------------------------------------------------------------------
--	Enable arrow keys in chat frame edit boxes
------------------------------------------------------------------------

function PhanxChat:SetEnableArrowKeys(v)
	if type(v) == "boolean" then
		self.db.enableArrowKeys = v
	end

	for i = 1, 10 do
		_G[("ChatFrame%dEditBox"):format(i)]:SetAltArrowKeyMode(not self.db.enableArrowKeys)
	end
end

------------------------------------------------------------------------
--	Enable edge resizing
------------------------------------------------------------------------

local anchorPoints = { "TopLeft", "TopRight", "BottomLeft", "BottomRight", "Top", "Bottom", "Left", "Right" }

function PhanxChat:SetEnableResizeEdges(v)
	if type(v) == "boolean" then
		self.db.enableResizeEdges = v
	end

	if self.db.enableResizeEdges then
		for i = 1, 10 do
			local f = _G[("ChatFrame%d"):format(i)]
			if not f.resizeTopLeft then
				f.background = _G[("ChatFrame%dBackground"):format(i)]

				for _, v in ipairs(anchorPoints) do
					local k = "resize" .. v
					f[k] = CreateFrame("Button", "ChatFrame" .. i .. "Resize" .. v, f)
					local b = f[k]
					b.anchorPoint = v:upper()
					b:SetWidth(20)
					b:SetHeight(20)
					b:SetScript("OnMouseDown", self.ChatFrame_StartResizing)
					b:SetScript("OnMouseUp", self.ChatFrame_StopResizing)
					LowerFrameLevel(b)

					b.tex = b:CreateTexture(nil, "BACKGROUND")
					b.tex:SetTexture([[Interface\ChatFrame\ChatFrameBorder]])
					b.tex:SetWidth(20)
					b.tex:SetHeight(20)
					b.tex:SetAllPoints(b)
					b.tex:SetVertexColor(0, 0, 0, 0.25)
				end

				f.resizeTopLeft:SetPoint("TOPLEFT", f.background, -2, 2)
				f.resizeTopLeft.tex:SetTexCoord(0, 0.25, 0, 0.125)

				f.resizeTopRight:SetPoint("TOPRIGHT", f.background, 2, 2)
				f.resizeTopRight.tex:SetTexCoord(0.75, 1, 0, 0.125)

				f.resizeBottomLeft:SetPoint("BOTTOMLEFT", f.background, -2, -3)
				f.resizeBottomLeft.tex:SetTexCoord(0, 0.25, 0.7265625, 0.8515625)

				f.resizeBottomRight:SetPoint("BOTTOMRIGHT", f.background, 2, -3)
				f.resizeBottomRight.tex:SetTexCoord(0.75, 1, 0.7265625, 0.8515625)

				f.resizeTop:SetPoint("LEFT", f.resizeTopLeft, "RIGHT", 0, 0)
				f.resizeTop:SetPoint("RIGHT", f.resizeTopRight, "LEFT", 0, 0)
				f.resizeTop.tex:SetTexCoord(0.25, 0.75, 0, 0.125)

				f.resizeBottom:SetPoint("LEFT", f.resizeBottomLeft, "RIGHT", 0, 0)
				f.resizeBottom:SetPoint("RIGHT", f.resizeBottomRight, "LEFT", 0, 0)
				f.resizeBottom.tex:SetTexCoord(0.25, 0.75, 0.7265625, 0.8515625)

				f.resizeLeft:SetPoint("TOP", f.resizeTopLeft, "BOTTOM", 0, 0)
				f.resizeLeft:SetPoint("BOTTOM", f.resizeBottomLeft, "TOP", 0, 0)
				f.resizeLeft.tex:SetTexCoord(0, 0.25, 0.125, 0.7265625)

				f.resizeRight:SetPoint("TOP", f.resizeTopRight, "BOTTOM", 0, 0)
				f.resizeRight:SetPoint("BOTTOM", f.resizeBottomRight, "TOP", 0, 0)
				f.resizeRight.tex:SetTexCoord(0.75, 1, 0.125, 0.7265625)
			end

			if not hooks.FCF_FadeInChatFrame then
				hooks.FCF_FadeInChatFrame = FCF_FadeInChatFrame
				FCF_FadeInChatFrame = self.FCF_FadeInChatFrame
			end
			if not hooks.FCF_FadeOutChatFrame then
				hooks.FCF_FadeOutChatFrame = FCF_FadeOutChatFrame
				FCF_FadeOutChatFrame = self.FCF_FadeOutChatFrame
			end
			if not hooks.SetChatWindowLocked then
				hooks.SetChatWindowLocked = SetChatWindowLocked
				SetChatWindowLocked = self.SetChatWindowLocked
			end
			if not hooks.FCF_SetWindowAlpha then
				hooks.FCF_SetWindowAlpha = FCF_SetWindowAlpha
				FCF_SetWindowAlpha = self.FCF_SetWindowAlpha
			end
			if not hooks.FCF_SetWindowColor then
				hooks.FCF_SetWindowColor = FCF_SetWindowColor
				FCF_SetWindowColor = self.FCF_SetWindowColor
			end

			local b = _G[("ChatFrame%dResizeButton"):format(i)]
			b:SetScript("OnShow", b.Hide)
			b:Hide()
		end
	elseif not self.isLoading then
		for i = 1, 10 do
			local f = _G[("ChatFrame%d"):format(i)]
			if f.resizeTopLeft then
				for _, v in ipairs(anchorPoints) do
					f["resize" .. v]:Hide()
				end
			end

			if hooks.FCF_FadeInChatFrame then
				FCF_FadeInChatFrame = hooks.FCF_FadeInChatFrame
				hooks.FCF_FadeInChatFrame = nil
			end
			if hooks.FCF_FadeOutChatFrame then
				FCF_FadeOutChatFrame = hooks.FCF_FadeOutChatFrame
				hooks.FCF_FadeOutChatFrame = nil
			end
			if hooks.SetChatWindowLocked then
				SetChatWindowLocked = hooks.SetChatWindowLocked
				hooks.SetChatWindowLocked = nil
			end
			if hooks.FCF_SetWindowAlpha then
				FCF_SetWindowAlpha = hooks.FCF_SetWindowAlpha
				hooks.FCF_SetWindowAlpha = nil
			end
			if hooks.FCF_SetWindowColor then
				FCF_SetWindowColor = hooks.FCF_SetWindowColor
				hooks.FCF_SetWindowColor = nil
			end

			local b = _G[("ChatFrame%dResizeButton"):format(i)]
			b:SetScript("OnShow", nil)
			if not (f.isUninteractable or f.isLocked) then
				b:Show()
			end
		end
	end
end

function PhanxChat.ChatFrame_StartResizing(self)
	local chatFrame = self:GetParent()
	if chatFrame.isLocked then return end
	if chatFrame.isDocked and chatFrame ~= DEFAULT_CHAT_FRAME then return end
	SetCursor("UI-Cursor-Size")
	chatFrame.resizing = 1
	chatFrame:StartSizing(self.anchorPoint)
end

function PhanxChat.ChatFrame_StopResizing(self)
	local chatFrame = self:GetParent()
	chatFrame:StopMovingOrSizing()
	SetCursor(nil)
--	if chatFrame == DEFAULT_CHAT_FRAME then
--		FCF_DockUpdate()
--	end
	chatFrame.resizing = nil
	FCF_SavePositionAndDimensions(chatFrame)
end

function PhanxChat.FCF_FadeInChatFrame(frame)
	hooks.FCF_FadeInChatFrame(frame)
	for _, v in ipairs(anchorPoints) do
		local object = frame["resize" .. v]
		if object:IsShown() then
			UIFrameFadeIn(object, CHAT_FRAME_FADE_TIME, object:GetAlpha(), max(frame.oldAlpha, DEFAULT_CHATFRAME_ALPHA))
		end
	end
end

function PhanxChat.FCF_FadeOutChatFrame(frame)
	hooks.FCF_FadeOutChatFrame(frame)
	for _, v in ipairs(anchorPoints) do
		local object = frame["resize" .. v]
		if object:IsShown() then
			UIFrameFadeOut(object, CHAT_FRAME_FADE_OUT_TIME, max(object:GetAlpha(), frame.oldAlpha), frame.oldAlpha)
		end
	end
end

function PhanxChat.FCF_SetWindowAlpha(frame, a, doNotSave)
	hooks.FCF_SetWindowAlpha(frame, a, doNotSave)
	for _, v in ipairs(anchorPoints) do
		frame["resize" .. v]:SetAlpha(a)
	end
end

function PhanxChat.FCF_SetWindowColor(frame, r, g, b, doNotSave)
	hooks.FCF_SetWindowColor(frame, r, g, b, doNotSave)
	for _, v in ipairs(anchorPoints) do
		frame["resize" .. v].tex:SetVertexColor(r, g, b)
	end
end

function PhanxChat.SetChatWindowLocked(index, locked, ...)
	local f = _G["ChatFrame" .. index]
	for _, v in ipairs(anchorPoints) do
		local k = "resize" .. v
		if f[k] then
			f[k]:EnableMouse(not locked)
		end
	end
	return hooks.SetChatWindowLocked(index, locked, ...)
end

------------------------------------------------------------------------
--	Enable mouse wheel scrolling
------------------------------------------------------------------------

hooks.FloatingChatFrame_OnMouseScroll = FloatingChatFrame_OnMouseScroll
function FloatingChatFrame_OnMouseScroll(self, delta)
	if delta > 0 then
		if IsShiftKeyDown() then
			self:ScrollToTop()
		elseif IsControlKeyDown() then
			self:PageUp()
		else
			for i = 1, NUM_SCROLL_LINES do
				self:ScrollUp()
			end
		end
	elseif delta < 0 then
		if IsShiftKeyDown() then
			self:ScrollToBottom()
		elseif IsControlKeyDown() then
			self:PageDown()
		else
			for i = 1, NUM_SCROLL_LINES do
				self:ScrollDown()
			end
		end
	end
end

------------------------------------------------------------------------
--	Fade time
------------------------------------------------------------------------

function PhanxChat:SetFadeTime(v)
	if type(v) == "number" then
		self.db.fadeTime = v
	end

	local frame
	if self.db.fadeTime > 0 then
		for i = 1, 10 do
			frame = _G[("ChatFrame%d"):format(i)]
			frame:SetFading(1)
			frame:SetTimeVisible(self.db.fadeTime * 60)
		end
	else
		for i = 1, 10 do
			frame = _G[("ChatFrame%d"):format(i)]
			frame:SetFading(0)
		end
	end
end

------------------------------------------------------------------------
--	Filter notices
------------------------------------------------------------------------

function PhanxChat:SetFilterNotices(v)
	if type(v) == "boolean" then
		self.db.filterNotices = v
	end

	if self.db.filterNotices then
		for event in pairs(eventsToFilterForNotices) do
			ChatFrame_AddMessageEventFilter(event, self.FilterNotices)
		end
	elseif not self.isLoading then
		for event in pairs(eventsToFilterForNotices) do
			ChatFrame_RemoveMessageEventFilter(event, self.FilterNotices)
		end
	end
end

function PhanxChat.FilterNotices()
	return true
end

------------------------------------------------------------------------
--	Filter repeats
------------------------------------------------------------------------

function PhanxChat:SetFilterRepeats(v)
	if type(v) == "boolean" then
		self.db.filterRepeats = v
	end

	if self.db.filterRepeats then
		for event in pairs(eventsToFilterForRepeats) do
			ChatFrame_AddMessageEventFilter(event, self.FilterRepeats)
		end
	elseif not self.isLoading then
		for event in pairs(eventsToFilterForRepeats) do
			ChatFrame_RemoveMessageEventFilter(event, self.FilterRepeats)
		end
	end
end

local history = { }
local playerName = UnitName("player")

function PhanxChat.FilterRepeats(frame, event, message, sender, ...)
	if sender and sender ~= playerName and type(message) == "string" then
		if not history[frame] then
			history[frame] = {}
		end

		local t = history[frame]
		local v = ("%s: %s"):format(sender, message:gsub("%s", ""):lower())

		if t[v] then
			return true
		end

		if #t == NUM_HISTORY_LINES then
			local r = tremove(t, 1)
			t[r] = nil
		end

		tinsert(t, v)
		t[v] = true
	end
	return false, message, sender, ...
end

------------------------------------------------------------------------
--	Font size
------------------------------------------------------------------------

function PhanxChat:SetFontSize(v)
	if type(v) == "number" and v >= 6 and v <= 32 then
		for i = 1, 10 do
			FCF_SetChatWindowFontSize(nil, _G[("ChatFrame%d"):format(i)], v)
		end
	end
end

------------------------------------------------------------------------
--	Hide buttons
------------------------------------------------------------------------

function PhanxChat:SetHideButtons(v)
	if type(v) == "boolean" then
		self.db.hideButtons = v
	end

	if self.db.hideButtons then
		for i = 1, 10 do
			local cf = _G[("ChatFrame%d"):format(i)]

			local bf = _G[("ChatFrame%dButtonFrame"):format(i)]
			bf:SetScript("OnShow", bf.Hide)
			bf:Hide()

			local ub = _G[("ChatFrame%dButtonFrameUpButton"):format(i)]
			ub:SetScript("OnShow", ub.Hide)
			ub:Hide()

			local db = _G[("ChatFrame%dButtonFrameDownButton"):format(i)]
			db:SetScript("OnShow", db.Hide)
			db:Hide()

			local bb = _G[("ChatFrame%dButtonFrameBottomButton"):format(i)]
			bb:ClearAllPoints()
			bb:SetParent(cf)
			bb:SetPoint("BOTTOMRIGHT", cf, "BOTTOMRIGHT", 0, -4)
			bb:Hide()

			if not hooks[bb] then
				hooks[bb] = { }
			end
			if not hooks[bb].OnClick then
				hooks[bb].OnClick = bb:GetScript("OnClick")
				bb:SetScript("OnClick", self.ChatFrameBottomButton_OnClick)
			end
		end

		ChatFrameMenuButton:SetScript("OnShow", ChatFrameMenuButton.Hide)
		ChatFrameMenuButton:Hide()

		FriendsMicroButton:SetScript("OnShow", FriendsMicroButton.Hide)
		FriendsMicroButton:Hide()

		GeneralDockManagerOverflowButton:SetScript("OnShow", GeneralDockManagerOverflowButton.Hide)
		GeneralDockManagerOverflowButton:Hide()

		if not hooks.ChatFrame_OnUpdate then
			hooks.ChatFrame_OnUpdate = ChatFrame_OnUpdate
			ChatFrame_OnUpdate = self.ChatFrame_OnUpdate
		end

--		if not hooks.FCF_SetButtonSide then
--			hooks.FCF_SetButtonSide = FCF_SetButtonSide
--			FCF_SetButtonSide = noop
--		end
	elseif not self.isLoading then
		ChatFrameMenuButton:SetScript("OnShow", nil)
		ChatFrameMenuButton:Show()

		FriendsMicroButton:SetScript("OnShow", nil)
		FriendsMicroButton:Show()

		GeneralDockManagerOverflowButton:SetScript("OnShow", nil)
		GeneralDockManagerOverflowButton:Show()

		if hooks.ChatFrame_OnUpdate then
			ChatFrame_OnUpdate = hooks.ChatFrame_OnUpdate
			hooks.ChatFrame_OnUpdate = nil
		end

--		if hooks.FCF_SetButtonSide then
--			FCF_SetButtonSide = hooks.FCF_SetButtonSide
--			hooks.FCF_SetButtonSide = nil
--		end

		for i = 1, 10 do
			local cf = _G[("ChatFrame%d"):format(i)]

			local bf = _G[("ChatFrame%dButtonFrame"):format(i)]
			bf:SetScript("OnShow", nil)
			bf:Show()

			local ub = _G[("ChatFrame%dButtonFrameUpButton"):format(i)]
			ub:SetScript("OnShow", nil)
			ub:Show()

			local db = _G[("ChatFrame%dButtonFrameDownButton"):format(i)]
			db:SetScript("OnShow", nil)
			db:Show()

			local bb = _G[("ChatFrame%dButtonFrameBottomButton"):format(i)]
			bb:ClearAllPoints()
			bb:SetParent(bf)
			bb:SetPoint("BOTTOMRIGHT", cf, "BOTTOMLEFT", 0, -4)
			bb:Show()

			if hooks[bb] and hooks[bb].OnClick then
				bb:SetScript("OnClick", hooks[bb].OnClick)
				hooks[bb].OnClick = nil
			end

			FCF_UpdateButtonSide(frame)
		end
	end
end

function PhanxChat.ChatFrame_OnUpdate(frame, elapsed)
	if frame:AtBottom() then
		_G[("%sButtonFrameBottomButton"):format(frame:GetName())]:Hide()
	else
		_G[("%sButtonFrameBottomButton"):format(frame:GetName())]:Show()
		hooks.ChatFrame_OnUpdate(frame, elapsed)
	end
end

function PhanxChat.ChatFrameBottomButton_OnClick(self, button)
	PlaySound("igChatBottom")
	local parent = self:GetParent()
	if parent.ScrollToBottom then
		parent:ScrollToBottom()
	else
		parent:GetParent():ScrollToBottom()
	end
end

------------------------------------------------------------------------
--	Hide crap
------------------------------------------------------------------------

function PhanxChat:SetHideCrap(v) -- #TODO: update for 3.3.5
	if type(v) == "boolean" then
		self.db.hideCrap = v
	end

	if self.db.hideCrap then
		for i = 1, 10 do
			local frame = _G[("ChatFrame%d"):format(i)]

			frame.clickAnywhereButton:SetScript("OnShow", frame.clickAnywhereButton.Hide)
			frame.clickAnywhereButton:Hide()

			local editBox = _G[("ChatFrame%dEditBox"):format(i)]

			if not editBox.left then
				editBox.left = _G[("ChatFrame%sEditBoxLeft"):format(i)]
				editBox.right = _G[("ChatFrame%sEditBoxRight"):format(i)]
				editBox.mid = _G[("ChatFrame%sEditBoxMid"):format(i)]
			end

			editBox.left:SetAlpha(0)
			editBox.right:SetAlpha(0)
			editBox.mid:SetAlpha(0)

			editBox.focusLeft:SetTexture([[Interface\ChatFrame\UI-ChatInputBorder-Left2]])
			editBox.focusRight:SetTexture([[Interface\ChatFrame\UI-ChatInputBorder-Right2]])
			editBox.focusMid:SetTexture([[Interface\ChatFrame\UI-ChatInputBorder-Mid2]])

			local tab = _G[("ChatFrame%dTab"):format(i)]

			tab.noMouseAlpha = 0
			FCFTab_UpdateAlpha(frame)

			tab.leftSelectedTexture:SetAlpha(0)
			tab.rightSelectedTexture:SetAlpha(0)
			tab.middleSelectedTexture:SetAlpha(0)

			tab.leftHighlightTexture:SetTexture(nil)
			tab.rightHighlightTexture:SetTexture(nil)

			tab.middleHighlightTexture:SetTexture([[Interface\PaperDollInfoFrame\UI-Character-Tab-Highlight]])
			tab.middleHighlightTexture:SetHorizTile(false)
			tab.middleHighlightTexture:ClearAllPoints()
			tab.middleHighlightTexture:SetHeight(32)
			tab.middleHighlightTexture:SetPoint("LEFT", _G[("ChatFrame%dTabLeft"):format(i)], 0, -7)
			tab.middleHighlightTexture:SetPoint("RIGHT", _G[("ChatFrame%dTabRight"):format(i)], 0, -7)

			if not hooks[tab.middleHighlightTexture] then
				hooks[tab.middleHighlightTexture] = { }
			end
			if not hooks[tab.middleHighlightTexture].SetVertexColor then
				hooks[tab.middleHighlightTexture].SetVertexColor = tab.middleHighlightTexture.SetVertexColor
				tab.middleHighlightTexture.SetVertexColor = noop
			end
		end

		if not hooks.PanelTemplates_TabResize then
			hooks.PanelTemplates_TabResize = PanelTemplates_TabResize
			PanelTemplates_TabResize = self.PanelTemplates_TabResize
		end
	elseif not self.isLoading then
		for i = 1, 10 do
			local frame = _G[("ChatFrame%d"):format(i)]

			frame.clickAnywhereButton:SetScript("OnShow", frame.clickAnywhereButton.Hide)
			frame.clickAnywhereButton:Hide()

			local editBox = _G[("ChatFrame%dEditBox"):format(i)]

			if not editBox.left then
				editBox.left = _G[("ChatFrame%sEditBoxLeft"):format(i)]
				editBox.right = _G[("ChatFrame%sEditBoxRight"):format(i)]
				editBox.mid = _G[("ChatFrame%sEditBoxMid"):format(i)]
			end

			editBox.left:SetAlpha(1)
			editBox.right:SetAlpha(1)
			editBox.mid:SetAlpha(1)

			editBox.focusLeft:SetTexture([[Interface\ChatFrame\UI-ChatInputBorderFocus-Left]])
			editBox.focusRight:SetTexture([[Interface\ChatFrame\UI-ChatInputBorderFocus-Right]])
			editBox.focusMid:SetTexture([[Interface\ChatFrame\UI-ChatInputBorderFocus-Mid]])

			local tab = _G[("ChatFrame%dTab"):format(i)]
			tab.noMouseAlpha = 0.4

			tab.leftSelectedTexture:SetAlpha(1)
			tab.rightSelectedTexture:SetAlpha(1)
			tab.middleSelectedTexture:SetAlpha(1)

			tab.leftHighlightTexture:SetTexture([[Interface\ChatFrame\ChatFrameTab-HighlightLeft]])
			tab.rightHighlightTexture:SetTexture([[Interface\ChatFrame\ChatFrameTab-HighlightRight]])

			tab.middleHighlightTexture:SetTexture([[Interface\ChatFrame\ChatFrameTab-HighlightMid]])
			tab.middleHighlightTexture:SetHorizTile(true)
			tab.middleHighlightTexture:ClearAllPoints()
			tab.middleHighlightTexture:SetWidth(44)
			tab.middleHighlightTexture:SetHeight(32)
			tab.middleHighlightTexture:SetPoint("TOPLEFT", _G[("ChatFrame%dTabMiddle"):format(i)], 0, 0)
			tab.middleHighlightTexture:SetPoint("TOPRIGHT", _G[("ChatFrame%dTabMiddle"):format(i)], 0, 0)

			if hooks[tab.middleHighlightTexture] and hooks[tab.middleHighlightTexture].SetVertexColor then
				tab.middleHighlightTexture.SetVertexColor = hooks[tab.middleHighlightTexture].SetVertexColor
				hooks[tab.middleHighlightTexture].SetVertexColor = nil
			end
		end

		if hooks.PanelTemplates_TabResize then
			PanelTemplates_TabResize = hooks.PanelTemplates_TabResize
			hooks.PanelTemplates_TabResize = nil
		end
	end
end

function PhanxChat.PanelTemplates_TabResize(tab, padding, absoluteSize, maxWidth, absoluteTextSize)
	local tabName = tab:GetName()
	if tabName:match("^ChatFrame%d") then
		absoluteSize = _G[("%sText"):format(tabName)]:GetStringWidth() + 35
	end
	return hooks.PanelTemplates_TabResize(tab, padding, absoluteSize, maxWidth, absoluteTextSize)
end

------------------------------------------------------------------------
--	Link URLs
------------------------------------------------------------------------

function PhanxChat:SetLinkURLs(v)
	if type(v) == "boolean" then
		self.db.linkURLs = v
	end

	if self.db.linkURLs then
		for event in pairs(eventsToLinkURLs) do
			ChatFrame_AddMessageEventFilter(event, self.LinkURLs)
		end
		if not hooks.SetItemRef then
			hooks.SetItemRef = SetItemRef
			SetItemRef = self.SetItemRef
		end
	elseif not self.isLoading then
		for event in pairs(eventsToLinkURLs) do
			ChatFrame_RemoveMessageEventFilter(event, self.LinkURLs)
		end
		if hooks.SetItemRef then
			SetItemRef = hooks.SetItemRef
			hooks.SetItemRef = nil
		end
	end
end

local TLDs = { AC = true, AD = true, AE = true, AERO = true, AF = true, AG = true, AI = true, AL = true, AM = true, AN = true, AO = true, AQ = true, AR = true, ARPA = true, AS = true, ASIA = true, AT = true, AU = true, AW = true, AX = true, AZ = true, BA = true, BB = true, BD = true, BE = true, BF = true, BG = true, BH = true, BI = true, BIZ = true, BJ = true, BM = true, BN = true, BO = true, BR = true, BS = true, BT = true, BV = true, BW = true, BY = true, BZ = true, CA = true, CAT = true, CC = true, CD = true, CF = true, CG = true, CH = true, CI = true, CK = true, CL = true, CM = true, CN = true, CO = true, COM = true, COOP = true, CR = true, CU = true, CV = true, CX = true, CY = true, CZ = true, DE = true, DJ = true, DK = true, DM = true, DO = true, DZ = true, EC = true, EDU = true, EE = true, EG = true, ER = true, ES = true, ET = true, EU = true, FI = true, FJ = true, FK = true, FM = true, FO = true, FR = true, GA = true, GB = true, GD = true, GE = true, GF = true, GG = true, GH = true, GI = true, GL = true, GM = true, GN = true, GOV = true, GP = true, GQ = true, GR = true, GS = true, GT = true, GU = true, GW = true, GY = true, HK = true, HM = true, HN = true, HR = true, HT = true, HU = true, ID = true, IE = true, IL = true, IM = true, IN = true, INFO = true, INT = true, IO = true, IQ = true, IR = true, IS = true, IT = true, JE = true, JM = true, JO = true, JOBS = true, JP = true, KE = true, KG = true, KH = true, KI = true, KM = true, KN = true, KP = true, KR = true, KW = true, KY = true, KZ = true, LA = true, LB = true, LC = true, LI = true, LK = true, LR = true, LS = true, LT = true, LU = true, LV = true, LY = true, MA = true, MC = true, MD = true, ME = true, MG = true, MH = true, MIL = true, MK = true, ML = true, MM = true, MN = true, MO = true, MOBI = true, MP = true, MQ = true, MR = true, MS = true, MT = true, MU = true, MUSEUM = true, MV = true, MW = true, MX = true, MY = true, MZ = true, NA = true, NAME = true, NC = true, NE = true, NET = true, NF = true, NG = true, NI = true, NL = true, NO = true, NP = true, NR = true, NU = true, NZ = true, OM = true, ORG = true, PA = true, PE = true, PF = true, PG = true, PH = true, PK = true, PL = true, PM = true, PN = true, PR = true, PRO = true, PS = true, PT = true, PW = true, PY = true, QA = true, RE = true, RO = true, RS = true, RU = true, RW = true, SA = true, SB = true, SC = true, SD = true, SE = true, SG = true, SH = true, SI = true, SJ = true, SK = true, SL = true, SM = true, SN = true, SO = true, SR = true, ST = true, SU = true, SV = true, SY = true, SZ = true, TC = true, TD = true, TEL = true, TF = true, TG = true, TH = true, TJ = true, TK = true, TL = true, TM = true, TN = true, TO = true, TP = true, TR = true, TRAVEL = true, TT = true, TV = true, TW = true, TZ = true, UA = true, UG = true, UK = true, UM = true, US = true, UY = true, UZ = true, VA = true, VC = true, VE = true, VG = true, VI = true, VN = true, VU = true, WF = true, WS = true, YE = true, YT = true, YU = true, ZA = true, ZM = true, ZW = true, }

local function LinkURL(url)
	return URL_STYLE:format(url, url)
end

local function LinkURLwithTLD(url, tld)
	if TLDs[tld:upper()] then
		return URL_STYLE:format(url, url)
	else
		return url
	end
end

local URL_PATTERNS = {
		-- X://Y url
	{ "^(%a[%w%.+-]+://%S+)", LinkURL },
	{ "%f[%S](%a[%w%.+-]+://%S+)", LinkURL },
		-- www.X.Y url
	{ "^(www%.[-%w_%%]+%.%S+)", LinkURL },
	{ "%f[%S](www%.[-%w_%%]+%.%S+)", LinkURL },
		-- X@Y.Z email
	{ "(%S+@[-%w_%%%.]+%.(%a%a+))", LinkURLwithTLD },
		-- XXX.YYY.ZZZ.WWW:VVVV/UUUUU IPv4 address with port and path
	{ "^([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d:[0-6]?%d?%d?%d?%d/%S+)", LinkURL },
	{ "%f[%S]([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d:[0-6]?%d?%d?%d?%d/%S+)", LinkURL },
		-- XXX.YYY.ZZZ.WWW:VVVV IPv4 address with port (IP of ts server for example)
	{ "^([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d:[0-6]?%d?%d?%d?%d)%f[%D]", LinkURL },
	{ "%f[%S]([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d:[0-6]?%d?%d?%d?%d)%f[%D]", LinkURL },
		-- XXX.YYY.ZZZ.WWW/VVVVV IPv4 address with path
	{ "^([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%/%S+)", LinkURL },
	{ "%f[%S]([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%/%S+)", LinkURL },
		-- XXX.YYY.ZZZ.WWW IPv4 address
	{ "^([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%)%f[%D]", LinkURL },
	{ "%f[%S]([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%)%f[%D]", LinkURL },
		-- X.Y.Z:WWWW/VVVVV url with port and path
	{ "^([-%w_%%%.]+[-%w_%%]%.(%a%a+):[0-6]?%d?%d?%d?%d/%S+)", LinkURLwithTLD },
	{ "%f[%S]([-%w_%%%.]+[-%w_%%]%.(%a%a+):[0-6]?%d?%d?%d?%d/%S+)", LinkURLwithTLD },
		-- X.Y.Z:WWWW url with port (ts server for example)
	{ "^([-%w_%%%.]+[-%w_%%]%.(%a%a+):[0-6]?%d?%d?%d?%d)%f[%D]", LinkURLwithTLD },
	{ "%f[%S]([-%w_%%%.]+[-%w_%%]%.(%a%a+):[0-6]?%d?%d?%d?%d)%f[%D]", LinkURLwithTLD },
		-- X.Y.Z/WWWWW url with path
	{ "^([-%w_%%%.]+[-%w_%%]%.(%a%a+)/%S+)", LinkURLwithTLD },
	{ "%f[%S]([-%w_%%%.]+[-%w_%%]%.(%a%a+)/%S+)", LinkURLwithTLD },
		-- X.Y.Z url
	{ "^([-%w_%%%.]+[-%w_%%]%.(%a%a+))", LinkURLwithTLD },
	{ "%f[%S]([-%w_%%%.]+[-%w_%%]%.(%a%a+))", LinkURLwithTLD },
}

function PhanxChat.LinkURLs(frame, event, message, ...)
	if message then
		for i, v in ipairs(URL_PATTERNS) do
			local new = message:gsub(v[1], v[2])
			if new ~= message then
				message = new
				break
			end
		end
	end
	return false, message, ...
end

local currentURL

local URL_COPY_DIALOG = {
	text = "URL",
	button2 = CLOSE,
	hasEditBox = 1,
	hasWideEditBox = 1,
	hideOnEscape = 1,
	maxLetters = 1024,
	showAlert = 1,
	timeout = 0,
	whileDead = 1,
	OnShow = function(self)
		local icon = self.icon or _G[self:GetName().."AlertIcon"]
		if icon then
			icon:Hide()
		end
		local wideEditBox = self.wideEditBox or _G[self:GetName().."WideEditBox"]
		if wideEditBox then
			wideEditBox:SetText(currentURL)
			wideEditBox:SetFocus()
			wideEditBox:HighlightText(0)
		end
		local button2 = self.button2 or _G[self:GetName().."Button2"]
		if button2 then
			button2:ClearAllPoints()
			button2:SetPoint("TOPRIGHT", wideEditBox, "BOTTOMRIGHT", 7, 12)
			button2:SetWidth(150)
		end
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end,
}

function PhanxChat.SetItemRef(link, ...)
	if link:sub(1, 3) == "url" then
		currentURL = link:sub(5)
		if not StaticPopupDialogs.URL_COPY_DIALOG then
			StaticPopupDialogs.URL_COPY_DIALOG = URL_COPY_DIALOG
		end
		return StaticPopup_Show("URL_COPY_DIALOG")
	end
	hooks.SetItemRef(link, ...)
end

------------------------------------------------------------------------
--	Lock docked tabs
------------------------------------------------------------------------

function PhanxChat:SetLockDockedTabs(v)
	if type(v) == "boolean" then
		self.db.lockDockedTabs = v
	end

	if self.db.lockDockedTabs then
		local tab
		for i = 2, 7 do
			tab = _G[("ChatFrame%dTab"):format(i)]
			if not hooks[tab] then
				hooks[tab] = { }
			end
			if not hooks[tab].OnDragStart then
				hooks[tab].OnDragStart = tab:GetScript("OnDragStart")
				tab:SetScript("OnDragStart", self.ChatTab_OnDragStart)
			end
		end
	elseif not self.isLoading then
		local tab
		for i = 2, 7 do
			tab = _G[("ChatFrame%dTab"):format(i)]
			if hooks[tab] and hooks[tab].OnDragStart then
				tab:SetScript("OnDragStart", hooks[tab].OnDragStart)
				hooks[tab].OnDragStart = nil
			end
		end
	end
end

function PhanxChat:ChatTab_OnDragStart()
	-- 'self' is the chat tab
	if IsAltKeyDown() or not _G[self:GetName():sub(1, -4)].isDocked then
		hooks[self].OnDragStart(self)
	end
end

------------------------------------------------------------------------
--	Move edit box
------------------------------------------------------------------------

function PhanxChat:SetMoveEditBox(v)
	if type(v) == "boolean" then
		self.db.moveEditBox = v
	end

	if self.db.moveEditBox then
		for i = 1, 10 do
			local f = _G[("ChatFrame%d"):format(i)]
			f.editBox:ClearAllPoints()
			f.editBox:SetPoint("BOTTOMLEFT", f, "TOPLEFT", -5, 2)
			f.editBox:SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", 5, 2)
		end
	elseif not self.isLoading then
		for i = 1, 10 do
			local f = _G[("ChatFrame%d"):format(i)]
			f.editBox:ClearAllPoints()
			f.editBox:SetPoint("TOPLEFT", f, "BOTTOMLEFT", -5, -2)
			f.editBox:SetPoint("TOPRIGHT", f, "BOTTOMRIGHT", 5, -2)
		end
	end
end

------------------------------------------------------------------------
--	Short channels
------------------------------------------------------------------------

function PhanxChat:SetShortChannels(v)
	if type(v) == "boolean" then
		self.db.shortChannels = v
	end

	if self.db.shortChannels then
		for k, v in pairs(ShortStrings) do
			ShortStrings[k] = _G[k]
			_G[k] = v
		end
		self:BuildChannelList(GetChannelList())
	elseif not self.isLoading then
		for k, v in pairs(ShortStrings) do
			_G[k] = v
			self.strings[k] = nil
		end
		for k, v in pairs(ChannelList) do
			ChannelList[k] = nil
		end
	end
end

function PhanxChat.ChatEdit_UpdateHeader(frame)
	if not frame then
		frame = ChatFrameEditBox
	end
	if frame:IsShown() then
		local header = _G[frame:GetName().."Header"]
		local text = header:GetText()
		for k, v in pairs(ChannelNames) do
			text = text:gsub(k, v)
		end
		text = text:gsub("%[(%w+)%.%s(%w*)%]", CHANNEL_STYLE)
		frame:SetTextInsets(header:GetWidth() + 15, 15, 0, 0)
	end
end

function PhanxChat:CHAT_MSG_CHANNEL_NOTICE(kind, _, _, _, _, _, _, number, name)
	if kind == "YOU_JOINED" then
		local name = arg9:match("^([^%s%-]+)")
		ChannelList[arg8] = ChannelNames[name] or name
	elseif kind == "YOU_LEFT" then
		ChannelList[arg8] = nil
	end
end

function PhanxChat:BuildChannelList(...)
	for i = 1, select("#", ...), 2 do
		local num, name = select(i, ...)
		ChannelList[num] = ChannelNames[name] or name
	end
end

------------------------------------------------------------------------
--	Sticky channels
------------------------------------------------------------------------

function PhanxChat:SetStickyChannels(v)
	if type(v) == "string" and v == "ALL" or v == "BLIZZARD" or v == "NONE" then
		self.db.stickyChannels = v
	end

	if self.db.stickyChannels == "ALL" then
		ChatTypeInfo.BATTLEGROUND.sticky = 1
		ChatTypeInfo.BN_CONVERSATION.sticky = 1
		ChatTypeInfo.BN_WHISPER.sticky = 1
		ChatTypeInfo.CHANNEL.sticky = 1
		ChatTypeInfo.EMOTE.sticky = 0
		ChatTypeInfo.GUILD.sticky = 1
		ChatTypeInfo.OFFICER.sticky = 1
		ChatTypeInfo.PARTY.sticky = 1
		ChatTypeInfo.RAID.sticky = 1
		ChatTypeInfo.RAID_WARNING.sticky = 0
		ChatTypeInfo.SAY.sticky = 1
		ChatTypeInfo.WHISPER.sticky = 1
		ChatTypeInfo.YELL.sticky = 1
	elseif self.db.stickyChannels == "BLIZZARD" and not self.isLoading then
		ChatTypeInfo.BATTLEGROUND.sticky = 1
		ChatTypeInfo.BN_CONVERSATION.sticky = 1
		ChatTypeInfo.BN_WHISPER.sticky = 1
		ChatTypeInfo.CHANNEL.sticky = 0
		ChatTypeInfo.EMOTE.sticky = 0
		ChatTypeInfo.GUILD.sticky = 1
		ChatTypeInfo.OFFICER.sticky = 0
		ChatTypeInfo.PARTY.sticky = 1
		ChatTypeInfo.RAID.sticky = 1
		ChatTypeInfo.RAID_WARNING.sticky = 0
		ChatTypeInfo.SAY.sticky = 1
		ChatTypeInfo.WHISPER.sticky = 0
		ChatTypeInfo.YELL.sticky = 0
	elseif self.db.stickyChannels == "NONE" then
		ChatTypeInfo.BATTLEGROUND.sticky = 0
		ChatTypeInfo.BN_CONVERSATION.sticky = 0
		ChatTypeInfo.BN_WHISPER.sticky = 0
		ChatTypeInfo.CHANNEL.sticky = 0
		ChatTypeInfo.EMOTE.sticky = 0
		ChatTypeInfo.GUILD.sticky = 0
		ChatTypeInfo.OFFICER.sticky = 0
		ChatTypeInfo.PARTY.sticky = 0
		ChatTypeInfo.RAID.sticky = 0
		ChatTypeInfo.RAID_WARNING.sticky = 0
		ChatTypeInfo.SAY.sticky = 0
		ChatTypeInfo.WHISPER.sticky = 0
		ChatTypeInfo.YELL.sticky = 0
	end
end

------------------------------------------------------------------------
--	Tell target
------------------------------------------------------------------------
--[[
function PhanxChat.TellTarget(message)
	if UnitExists("target") and UnitIsPlayer("target") and (UnitIsFriend("player", "target") or UnitIsCharmed("target")) then
		local targetName, targetRealm = UnitName("target")
		if targetRealm and targetRealm ~= "" and targetRealm ~= playerRealm then
			targetName = string.format("%s-%s", targetName, targetRealm)
		end
		SendChatMessage(message, "WHISPER", nil, targetName)
	end
end
]]
hooksecurefunc("ChatEdit_ParseText", function(editBox, send, parseIfNoSpaces)
	if not send and not editBox.autoCompleteParams then
		local text = editBox:GetText()
		local command = text:match("^(/[^%s]+) ")
		if command == "/tt" or command == "/wt" then
			if UnitExists("target") and UnitIsPlayer("target") and (UnitIsFriend("player", "target") or UnitIsCharmed("target")) then
				local targetName, targetRealm = UnitName("target")
				if targetRealm and targetRealm ~= "" and targetRealm ~= playerRealm then
					targetName = string.format("%s-%s", targetName, targetRealm)
				end
				editBox:SetAttribute("chatType", "WHISPER")
				editBox:SetAttribute("tellTarget", targetName)
				editBox:SetText(text:match("^/[tw]t (.*)"))
				ChatEdit_UpdateHeader(editBox)
			end
		end
	end
end)

------------------------------------------------------------------------
--	Configuration frame
------------------------------------------------------------------------

PhanxChat.optionsFrame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
PhanxChat.optionsFrame.name = GetAddOnMetadata(ADDON_NAME, "Title")
PhanxChat.optionsFrame:Hide()
PhanxChat.optionsFrame:SetScript("OnShow", function(self)
	self.CreateCheckbox = LibStub("PhanxConfig-Checkbox").CreateCheckbox
	self.CreateDropdown = LibStub("PhanxConfig-Dropdown").CreateDropdown
	self.CreateSlider = LibStub("PhanxConfig-Slider").CreateSlider

	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetPoint("TOPRIGHT", -16, -16)
	title:SetJustifyH("LEFT")
	title:SetText(self.name)

	local notes = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	notes:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	notes:SetPoint("TOPRIGHT", title, "BOTTOMRIGHT", 0, -8)
	notes:SetHeight(32)
	notes:SetJustifyH("LEFT")
	notes:SetJustifyV("TOP")
	notes:SetNonSpaceWrap(true)
	notes:SetText(L["Configure options for making your chat frames more user-friendly and less cluttered."])

	-- first checkbox needs a -2 h-offset

	local colorPlayerNames = self:CreateCheckbox(L["Color player names"])
	colorPlayerNames.desc = L["Enable player name class coloring for all chat message types."] .. "\n\n" .. L["Note that this is just a shortcut to configuring each message type individually through the Blizzard chat options."]
	colorPlayerNames:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", -2, -8)
	colorPlayerNames:SetChecked(PhanxChat.db.colorPlayerNames)
	colorPlayerNames.OnClick = function(self, checked)
		PhanxChat:SetColorPlayerNames(checked)
	end

	local disableTabFlash = self:CreateCheckbox(L["Disable tab flashing"])
	disableTabFlash.desc = L["Disable the flashing effect on chat tabs that receive new messages."]
	disableTabFlash:SetPoint("TOPLEFT", colorPlayerNames, "BOTTOMLEFT", 0, -8)
	disableTabFlash:SetChecked(PhanxChat.db.disableTabFlash)
	disableTabFlash.OnClick = function(self, checked)
		PhanxChat:SetDisableTabFlash(checked)
	end

	local enableArrowKeys = self:CreateCheckbox(L["Enable arrow keys"])
	enableArrowKeys.desc = L["Enable arrow keys in the chat edit box."]
	enableArrowKeys:SetPoint("TOPLEFT", disableTabFlash, "BOTTOMLEFT", 0, -8)
	enableArrowKeys:SetChecked(PhanxChat.db.enableArrowKeys)
	enableArrowKeys.OnClick = function(self, checked)
		PhanxChat:SetEnableArrowKeys(checked)
	end

	local enableResizeEdges = self:CreateCheckbox(L["Enable resize edges"])
	enableResizeEdges.desc = L["Enable resize controls at all edges of chat frames, instead of just in the bottom right corner."]
	enableResizeEdges:SetPoint("TOPLEFT", enableArrowKeys, "BOTTOMLEFT", 0, -8)
	enableResizeEdges:SetChecked(PhanxChat.db.enableResizeEdges)
	enableResizeEdges.OnClick = function(self, checked)
		PhanxChat:SetEnableResizeEdges(checked)
	end

	local hideButtons = self:CreateCheckbox(L["Hide buttons"])
	hideButtons.desc = L["Hide the chat frame menu and scroll buttons."]
	hideButtons:SetPoint("TOPLEFT", enableResizeEdges, "BOTTOMLEFT", 0, -8)
	hideButtons:SetChecked(PhanxChat.db.hideButtons)
	hideButtons.OnClick = function(self, checked)
		PhanxChat:SetHideButtons(checked)
	end

	local hideCrap = self:CreateCheckbox(L["Hide extra textures"])
	hideCrap.desc = L["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."]
	hideCrap:SetPoint("TOPLEFT", hideButtons, "BOTTOMLEFT", 0, -8)
	hideCrap:SetChecked(PhanxChat.db.hideCrap)
	hideCrap.OnClick = function(self, checked)
		PhanxChat:SetHideCrap(checked)
	end

	local linkURLs = self:CreateCheckbox(L["Link URLs"])
	linkURLs.desc = L["Transform URLs in chat into clickable links for easy copying."]
	linkURLs:SetPoint("TOPLEFT", hideCrap, "BOTTOMLEFT", 0, -8)
	linkURLs:SetChecked(PhanxChat.db.linkURLs)
	linkURLs.OnClick = function(self, checked)
		PhanxChat:SetLinkURLs(checked)
	end

	local lockDockedTabs = self:CreateCheckbox(L["Lock docked tabs"])
	lockDockedTabs.desc = L["Prevent locked chat tabs from being dragged unless the Shift key is down."]
	lockDockedTabs:SetPoint("TOPLEFT", linkURLs, "BOTTOMLEFT", 0, -8)
	lockDockedTabs:SetChecked(PhanxChat.db.lockDockedTabs)
	lockDockedTabs.OnClick = function(self, checked)
		PhanxChat:SetLockDockedTabs(checked)
	end

	local moveEditBox = self:CreateCheckbox(L["Move edit box"])
	moveEditBox.desc = L["Move the chat edit box above the chat frame."]
	moveEditBox:SetPoint("TOPLEFT", lockDockedTabs, "BOTTOMLEFT", 0, -8)
	moveEditBox:SetChecked(PhanxChat.db.moveEditBox)
	moveEditBox.OnClick = function(self, checked)
		PhanxChat:SetMoveEditBox(checked)
	end

	local shortChannels = self:CreateCheckbox(L["Shorten channel names"])
	shortChannels.desc = L["Shorten channel names and chat strings."]
	shortChannels:SetPoint("TOPLEFT", moveEditBox, "BOTTOMLEFT", 0, -8)
	shortChannels:SetChecked(PhanxChat.db.shortChannels)
	shortChannels.OnClick = function(self, checked)
		PhanxChat:SetShortChannels(checked)
	end

	local stickyChannels = self:CreateDropdown(L["Sticky chat"])
	stickyChannels.container.desc = L["Set which chat types should be sticky."]
	stickyChannels.container:SetPoint("TOPLEFT", notes, "BOTTOM", 8, -8)
	stickyChannels.container:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, -8)
	do
		local values = { ["ALL"] = L["All"], ["BLIZZARD"] = L["Default"], ["NONE"] = L["None"] }

		local function OnClick(self)
			PhanxChat:SetStickyChannels(self.value)
			stickyChannels.valueText:SetText(self.text)
			UIDropDownMenu_SetSelectedValue(stickyChannels, self.value)
		end

		local info = { } -- UIDropDownMenu_CreateInfo()
		UIDropDownMenu_Initialize(stickyChannels, function(self)
			local selected = UIDropDownMenu_GetSelectedValue(stickyChannels)

			info.text = L["All"]
			info.value = "ALL"
			info.func = OnClick
			info.checked = "ALL" == selected
			UIDropDownMenu_AddButton(info)

			info.text = L["Default"]
			info.value = "BLIZZARD"
			info.func = OnClick
			info.checked = "BLIZZARD" == selected
			UIDropDownMenu_AddButton(info)

			info.text = L["None"]
			info.value = "NONE"
			info.func = OnClick
			info.checked = "NONE" == selected
			UIDropDownMenu_AddButton(info)
		end)

		stickyChannels.valueText:SetText(values[PhanxChat.db.stickyChannels])
		UIDropDownMenu_SetSelectedValue(stickyChannels, PhanxChat.db.stickyChannels)
	end

	local fadeTime = self:CreateSlider(L["Fade time"], 0, 10, 1)
	fadeTime.desc = L["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."]
	fadeTime.container:SetPoint("TOPLEFT", stickyChannels.container, "BOTTOMLEFT", 0, -12)
	fadeTime.container:SetPoint("TOPRIGHT", stickyChannels.container, "BOTTOMRIGHT", 0, -12)
	fadeTime:SetValue(PhanxChat.db.fadeTime)
	fadeTime.valueText:SetText(PhanxChat.db.fadeTime)
	fadeTime.OnValueChanged = function(self, value)
		value = math.floor(value + 0.5)
		PhanxChat:SetFadeTime(value)
		return value
	end

	local currentFontSize = math.floor(select(2, ChatFrame1:GetFont()) + 0.5)
	local fontSize = self:CreateSlider(L["Font size"], 8, 24, 1)
	fontSize.desc = L["Set the font size for all chat frames."] .. "\n\n" .. L["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."]
	fontSize.container:SetPoint("TOPLEFT", fadeTime.container, "BOTTOMLEFT", 0, -10)
	fontSize.container:SetPoint("TOPRIGHT", fadeTime.container, "BOTTOMRIGHT", 0, -10)
	fontSize:SetValue(currentFontSize)
	fontSize.valueText:SetText(currentFontSize)
	fontSize.OnValueChanged = function(self, value)
		value = math.floor(value + 0.5)
		PhanxChat:SetFontSize(value)
		return value
	end

	local filterNotices = self:CreateCheckbox(L["Filter notifications"])
	filterNotices.desc = L["Hide channel notification messages."]
	filterNotices:SetPoint("TOPLEFT", fontSize, "BOTTOMLEFT", -4, -35)
	filterNotices:SetChecked(PhanxChat.db.filterNotices)
	filterNotices.OnClick = function(self, checked)
		PhanxChat:SetFilterNotices(checked)
	end

	local filterRepeats = self:CreateCheckbox(L["Filter repeats"])
	filterRepeats.desc = L["Hide repeated messages in public channels."]
	filterRepeats:SetPoint("TOPLEFT", filterNotices, "BOTTOMLEFT", 0, -8)
	filterRepeats:SetChecked(PhanxChat.db.filterRepeats)
	filterRepeats.OnClick = function(self, checked)
		PhanxChat:SetFilterRepeats(checked)
	end

	local autoStartChatLog = self:CreateCheckbox(L["Auto-start chat log"])
	autoStartChatLog.desc = L["Automatically start chat logging when you log into the game."]
	autoStartChatLog:SetPoint("TOPLEFT", filterRepeats, "BOTTOMLEFT", 0, -8)
	autoStartChatLog:SetChecked(PhanxChat.db.autoStartChatLog)
	autoStartChatLog.OnClick = function(self, checked)
		PhanxChat:SetAutoStartChatLog(checked)
	end

	self:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(PhanxChat.optionsFrame)

LibStub("LibAboutPanel").new(PhanxChat.optionsFrame.name, ADDON_NAME)

------------------------------------------------------------------------
--	Slash command
------------------------------------------------------------------------

SLASH_PHANXCHAT1 = "/pchat"
SlashCmdList.PHANXCHAT = function(v)
	if v and v == "clear" then
		for i = 1, 10 do
			_G[("ChatFrame%d"):format(i)]:Clear()
		end
	else
		InterfaceOptionsFrame_OpenToCategory(PhanxChat.optionsFrame)
	end
end

------------------------------------------------------------------------
--	Event handling
------------------------------------------------------------------------

local eventFrame = CreateFrame("Frame")
eventFrame:SetScript("OnEvent", function(self, event, ...)
	return PhanxChat[event] and PhanxChat[event](PhanxChat, ...)
end)
function PhanxChat:RegisterEvent(event)
	return eventFrame:RegisterEvent(event)
end
function PhanxChat:UnregisterEvent(event)
	return eventFrame:UnregisterEvent(event)
end
eventFrame:RegisterEvent("ADDON_LOADED")

------------------------------------------------------------------------
--	Random utility
------------------------------------------------------------------------

SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI