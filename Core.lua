------------------------------------------------------------------------
--	PhanxChat                                                         --
--	Removes chat frame clutter and adds some functionality.           --
--	by Phanx < addons@phanx.net >                                     --
--	Copyright © 2006–2010 Phanx. See README for license terms.        --
--	http://www.wowinterface.com/downloads/info6323-PhanxChat.html     --
--	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx  --
------------------------------------------------------------------------

local STRING_STYLE  = "%s||"
	-- %s = chat string (eg. "Guild", "2. Trade") (required)
	-- Pipe characters must be escaped by doubling them.

local CHANNEL_STYLE = "%d"
	-- %d = channel number (optional)
	-- %s = channel name (optional)

local PLAYER_STYLE  = "%s"
	-- %s = player name (required)

local NUM_LINES_TO_SCROLL = 3
	-- Lines scrolled per turn of mouse wheel

local DEFAULT_STRINGS = {
	-- If you play in a non-English locale, you'll need to edit the
	-- relevant file in the Locales subfolder instead of this table.

	CONVERSATION_ABBR       = "",
	GENERAL_ABBR            = "GEN",
	GUILDRECRUITMENT_ABBR   = "REC",
	LOCALDEFENSE_ABBR       = "DEF",
	LOOKINGFORGROUP_ABBR    = "LFG",
	TRADE_ABBR              = "TRD",
	WORLDDEFENSE_ABBR       = "DEF",

	BATTLEGROUND_ABBR        = "bg",
	BATTLEGROUND_LEADER_ABBR = "BG",
	GUILD_ABBR               =  "g",
	OFFICER_ABBR             =  "o",
	PARTY_ABBR               =  "p",
	PARTY_GUIDE_ABBR         =  "P",
	PARTY_LEADER_ABBR        =  "P",
	RAID_ABBR                =  "r",
	RAID_LEADER_ABBR         =  "R",
	RAID_WARNING_ABBR        = "RW",
	SAY_ABBR                 =  "s",
	YELL_ABBR                =  "y",
	WHISPER_ABBR             =  "F",
	WHISPER_INFORM_ABBR      =  "T",
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
--	Beyond here lies nothin'
------------------------------------------------------------------------

local PHANXCHAT, PhanxChat = ...

PhanxChat.debug = false

PhanxChat.RunOnLoad = { }
PhanxChat.RunOnProcessFrame = { }

local frames = { }
PhanxChat.frames = frames

local hooks = { }
PhanxChat.hooks = hooks

local noop = function() return end

local db

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

local STRING_LINK    = "|h" .. STRING_STYLE .. "|h"
local CHANNEL_LINK   = "|h" .. STRING_STYLE:format(CHANNEL_STYLE) .. "|h"
local PLAYER_LINK    = "|Hplayer:%s|h" .. PLAYER_STYLE.. "|h"
local PLAYER_BN_LINK = "|HBNplayer:%s:%s|h" .. PLAYER_STYLE .. "|h"

local ChannelNames = {
	[L["Conversation"]]		= CONVERSATION_ABBR,
	[L["General"]]          = GENERAL_ABBR,
	[L["GuildRecruitment"]] = GUILDRECRUITMENT_ABBR,
	[L["LocalDefense"]]     = LOCALDEFENSE_ABBR,
	[L["LookingForGroup"]]  = LOOKINGFORGROUP_ABBR,
	[L["Trade"]]            = TRADE_ABBR,
	[L["WorldDefense"]]     = WORLDDEFENSE_ABBR,
}

local ChannelStrings = {
	["|h%[" .. L["Battleground"] .. "%]|h%s?"]        = STRING_LINK:format(L.BATTLEGROUND_ABBR),
	["|h%[" .. L["Battleground Leader"] .. "%]|h%s?"] = STRING_LINK:format(L.BATTLEGROUND_LEADER_ABBR),
	["|h%[" .. L["Dungeon Guide"] .. "%]|h%s?"]       = STRING_LINK:format(L.PARTY_GUIDE_ABBR),
	["|h%[" .. L["Guild"] .. "%]|h%s?"]               = STRING_LINK:format(L.GUILD_ABBR),
	["|h%[" .. L["Officer"] .. "%]|h%s?"]             = STRING_LINK:format(L.OFFICER_ABBR),
	["|h%[" .. L["Party"] .. "%]|h%s?"]               = STRING_LINK:format(L.PARTY_ABBR),
	["|h%[" .. L["Party Leader"] .. "%]|h%s?"]        = STRING_LINK:format(L.PARTY_LEADER_ABBR),
	["|h%[" .. L["Raid"] .. "%]|h%s?"]                = STRING_LINK:format(L.RAID_ABBR),
	["|h%[" .. L["Raid Leader"] .. "%]|h%s?"]         = STRING_LINK:format(L.RAID_LEADER_ABBR),
	["|h%[" .. L["Raid Warning"] .. "%]|h%s?"]        = STRING_LINK:format(L.RAID_WARNING_ABBR),

	[CHAT_SAY_GET:gsub("%%s", "(|Hplayer:.+|h)"):gsub(":%s?", "")] = STRING_STYLE:format(L.SAY_ABBR) .. "%1",
	[CHAT_YELL_GET:gsub("%%s", "(|Hplayer:.+|h)"):gsub(":%s?", "")] = STRING_STYLE:format(L.YELL_ABBR) .. "%1",
	[CHAT_WHISPER_GET:gsub("%%s", "(|Hplayer:.+|h)"):gsub(":%s?", "")] = STRING_STYLE:format(L.WHISPER_ABBR) .. "%1",
	[CHAT_WHISPER_INFORM_GET:gsub("%%s", "(|Hplayer:.+|h)"):gsub(":%s?", "")] = STRING_STYLE:format(L.WHISPER_INFORM_ABBR) .. "%1",
}

local AddMessage = function(frame, message, ...)
	if type(message) == "string" then
		if db.ShortenChannelNames then
			local cblob, cnum, cname = message:match("(|h%[(%d+)%.%s?([^%]%-%s]+)%]|h%s?).+")
			if cblob then
				message = message:replace(cblob, CHANNEL_LINK:replace("%d", cnum):replace("%s", ChannelNames[cname] or cname:sub(1, 3))) -- truncate unknown channel names
			else
				for k, v in pairs(ChannelStrings) do
					local new = message:gsub(k, v)
					if message ~= new then
						message = new
						break
					end
				end
			end
		end

		local pblob, pdata, pname = message:match("(|Hplayer:(.-)|h%[(.-)%]|h)")
		if pblob then
			if db.ShortenPlayerNames then
				if pname:match("|cff") then
					pname = pname:gsub("%-[^|]+", "")
				else
					pname = pname:match("[^%-]+")
				end
			end
			message = message:replace(pblob, PLAYER_LINK:format(pdata, pname))
		end

		local bblob, bname, bdata = message:match("(|BNplayer:(.-):(.-)|h%[.-%]|h)")
		if bblob then
			if db.ShortenPlayerNames then
				message = message:replace(bblob, PLAYER_BN_LINK:format(bname, bdata, bname:match("%S+")))
			else
				message = message:replace(bblob, PLAYER_BN_LINK:format(bname, bdata, bname))
			end
		end
	end
	hooks[frame].AddMessage(frame, message, ...)
end

------------------------------------------------------------------------

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
end

------------------------------------------------------------------------

hooksecurefunc("ChatEdit_ParseText", function(editBox)
	if not editBox.autoCompleteParams then
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

function PhanxChat:ProcessFrame(frame)
	if frames[frame] then return end

	frame:SetClampRectInsets(0, 0, 0, 0)
	frame:SetMaxLines(250)
	frame:SetMaxResize(UIParent:GetWidth(), UIParent:GetHeight())
	frame:SetMinResize(150, 25)

	if frame ~= COMBATLOG then
		if not hooks[frame] then
			hooks[frame] = { }
		end
		if not hooks[frame].AddMessage then
			hooks[frame].AddMessage = frame.AddMessage
			frame.AddMessage = AddMessage
		end
	end

	if self.debug then print("PhanxChat: ProcessFrame", frame:GetName()) end

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
		EnableSticky        = "ALL",	-- may be ALL, BLIZZARD, or NONE
		FadeTime			= 1,
		HideButtons         = true,
		HideFlash           = false,
		HideNotices         = false,
		HideRepeats         = true,
		HideTextures        = true,
		LinkURLs            = true,
		LockTabs            = true,
		MoveEditBox         = true,
		ShortenChannelNames = true,
		ShortenPlayerNames  = false,
	}

	if not PhanxChatDB then
		PhanxChatDB = { }
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

	for _, func in ipairs(self.RunOnLoad) do
		func(self)
	end

	self.isLoading = nil

	if self.noTranslations then
		-- do nothing for now
	end

	self.frame:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
end

------------------------------------------------------------------------

PhanxChat.frame = CreateFrame("Frame")
PhanxChat.frame:RegisterEvent("ADDON_LOADED")
PhanxChat.frame:SetScript("OnEvent", function(self, event, ...) return PhanxChat[event] and PhanxChat[event](PhanxChat, ...) end)

------------------------------------------------------------------------