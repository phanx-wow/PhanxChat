--[[------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and improves chat frame usability.
	By Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	See README for license terms and other information.
--------------------------------------------------------------]]

local NUM_SCROLL_LINES = 3		-- number of lines to scroll per mousewheel turn

local COLOR_UNKNOWN = "aaaaaa"	-- color for unknown names (nil = don't use default color)

local PLAYER_STYLE = "%s"		-- %s = name

local URL_STYLE = "|cff00ccff%s|r"	-- %s = URL

local STRING_STYLE = "%s| %%s: "	-- %s = short string, %%s = player name

local CHANNEL_STYLE = "%1| " 		-- %1 = channel number, %2 = channel name

local STICKY_TYPES = {			-- 1 = sticky, 0 = not sticky
	SAY = 1,
	YELL = 1,
	GUILD = 1,
	OFFICER = 1,
	PARTY = 1,
	RAID = 1,
	RAID_WARNING = 1,
	BATTLEGROUND = 1,
	WHISPER = 1,
	CHANNEL = 1,
	EMOTE = 0,
}

local blacklist = {				-- frames to exempt from formatting
	["default"] = {
		[ChatFrame2] = true, -- Combat Log
	},
	["Blackrock - Lirrel"] = {
		[ChatFrame3] = true, -- Loot
		[ChatFrame7] = true, -- Quiet
	},
	["Sargeras - Bherasha"] = {
		[ChatFrame3] = true, -- Loot
	},
	["Sargeras - Ghinjo"] = {
		[ChatFrame3] = true, -- Loot
	},
	["Sargeras - Mauaji"] = {
		[ChatFrame3] = true, -- Loot
	},
}

local customchannels = {			-- short names for custom channels
	["obgyns"] = "OB",
	["totemorgy"] = "SH",
}

local L = PHANXCHAT_LOCALS or {
	SHORT_SAY					= "s",	-- English custom chat strings
	SHORT_YELL				= "y",	-- If you are playing in another locale you will need to change
	SHORT_GUILD				= "g",	-- these in the relevant translation file instead of here.
	SHORT_OFFICER				= "o",
	SHORT_PARTY				= "p",
	SHORT_RAID				= "r",
	SHORT_RAID_LEADER			= "R",
	SHORT_RAID_WARNING			= "R",
	SHORT_BATTLEGROUND			= "b",
	SHORT_BATTLEGROUND_LEADER	= "B",
	SHORT_WHISPER				= "f",
	SHORT_WHISPER_INFORM		= "t",

	SHORT_GENERAL				= "gn",	-- English short channel names
	SHORT_TRADE				= "tr",	-- If you are playing in another locale you will need to change
	SHORT_LOCALDEFENSE			= "de",	-- these in the relevant translation file instead of here.
	SHORT_WORLDDEFENSE			= "de",
	SHORT_LOOKINGFORGROUP		= "lf",
	SHORT_GUILDRECRUITMENT		= "gr",

--[[------------------------------------------------------------

	That's all, folks!
	Nothing past this line is intended to be user-configurable.

--------------------------------------------------------------]]

	CHANNEL_GENERAL			= "General",
	CHANNEL_TRADE				= "Trade",
	CHANNEL_LOCALDEFENSE		= "LocalDefense",
	CHANNEL_WORLDDEFENSE		= "WorldDefense",
	CHANNEL_LOOKINGFORGROUP		= "LookingForGroup",
	CHANNEL_GUILDRECRUITMENT		= "GuildRecruitment",

	WHO_QUERY_RESULT			= "^%|Hplayer:%w+|h%[(%w+)%]|h: Level %d+ %w+%s?[%w]* (%w+)%s?<?[^>]*>? %- .+$"
}
setmetatable(L, { __index = function(t, k) t[k] = k; return k end })
if PHANXCHAT_LOCALS then PHANXCHAT_LOCALS = nil end

PhanxChat = CreateFrame("Frame")

local _G = getfenv(0)

local PhanxChat, self = PhanxChat, PhanxChat

PhanxChat.version = tonumber(GetAddOnMetadata("PhanxChat", "Version"):match("(%d+)"))

PhanxChat.L = L

PhanxChat.channels = {}
PhanxChat.names = {}
PhanxChat.hooks = {}
PhanxChat.oldstrings = {}
PhanxChat.stickytypes = STICKY_TYPES

local channels = PhanxChat.channels
local names = PhanxChat.names
local hooks = PhanxChat.hooks
local oldstrings = PhanxChat.oldstrings

local db, frame, button, icon, name, class, currentLink, _

local playerName = UnitName("player")

local noop = function() end

local pairs = pairs
local select = select
local strformat = string.format
local GetFriendInfo = GetFriendInfo
local GetGuildRosterInfo = GetGuildRosterInfo
local GetNumFriends = GetNumFriends
local GetNumGuildMembers = GetNumGuildMembers
local GetNumPartyMembers = GetNumPartyMembers
local GetNumRaidMembers = GetNumRaidMembers
local GetNumWhoResults = GetNumWhoResults
local GetRaidRosterInfo = GetRaidRosterInfo
local GetWhoInfo = GetWhoInfo
local UnitClass = UnitClass
local UnitExists = UnitExists
local UnitIsFriend = UnitIsFriend
local UnitIsPlayer = UnitIsPlayer
local UnitName = UnitName

local function print(msg)		ChatFrame1:AddMessage("|cff00ddbaPhanxChat:|r "..msg)				end
local function printf(msg, ...)	ChatFrame1:AddMessage("|cff00ddbaPhanxChat:|r "..msg:format(...))	end

local function debug(msg, ...)
--	ChatFrame1:AddMessage("|cffff7f7f[DEBUG] PhanxChat:|r "..msg)
end

local CHANNEL_NAMES = {
	[L.CHANNEL_GENERAL]			= L.SHORT_GENERAL,
	[L.CHANNEL_TRADE]			= L.SHORT_TRADE,
	[L.CHANNEL_LOCALDEFENSE]		= L.SHORT_LOCALDEFENSE,
	[L.CHANNEL_WORLDDEFENSE]		= L.SHORT_WORLDDEFENSE,
	[L.CHANNEL_LOOKINGFORGROUP]	= L.SHORT_LOOKINGFORGROUP,
	[L.CHANNEL_GUILDRECRUITMENT]	= L.SHORT_GUILDRECRUITMENT,
}
for k, v in pairs(customchannels) do
	CHANNEL_NAMES[k] = v
end

local CHAT_STRINGS = {
	SAY					= L.SHORT_SAY,
	YELL					= L.SHORT_YELL,
	GUILD				= L.SHORT_GUILD,
	OFFICER				= L.SHORT_OFFICER,
	PARTY				= L.SHORT_PARTY,
	RAID					= L.SHORT_RAID,
	RAID_LEADER			= L.SHORT_RAID_LEADER,
	RAID_WARNING			= L.SHORT_RAID_WARNING,
	BATTLEGROUND			= L.SHORT_BATTLEGROUND,
	BATTLEGROUND_LEADER		= L.SHORT_BATTLEGROUND_LEADER,
	WHISPER				= L.SHORT_WHISPER,
	WHISPER_INFORM			= L.SHORT_WHISPER_INFORM,
}
for k, v in pairs(CHAT_STRINGS) do
	CHAT_STRINGS[k] = STRING_STYLE:format(v):gsub("%%%%", "%")
end
PhanxChat.newstrings = CHAT_STRINGS

local CLASS_COLORS = {}
for k, v in pairs(RAID_CLASS_COLORS) do
	CLASS_COLORS[k] = ("%02x%02x%02x"):format(v.r * 255, v.g * 255, v.b * 255)
end

PLAYER_STYLE = "|Hplayer:%s|h"..PLAYER_STYLE.."|h"

URL_STYLE = " |Hurl:%s|h"..URL_STYLE.."|h "

local URL_PATTERNS = {
	{ "%f[%S](%a+://%S+)", "%1" }, -- X://Y
	{ "%f[%S](www%.[%w_%.%-]+%.%S+)", "%1" }, -- www.X.Y
	{ "%f[%S]([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d:?%d-/?%S*)", "%1" }, -- A.B.C.D:N/X
	{ "%f[%S]([%w_%.%-]+[%w_%-]%.%a%a[GgMmOoTtUuVv]?[Oo]?:?[0-6]?%d-/?%S*)", "%1" }, -- X.Y
	{ "(%S+@[%w_%.%-]+%.%a+)", "%1" }, -- X@Y.Z
}

--[[------------------------------------------------------------
	Suppress channel notices
--------------------------------------------------------------]]

PhanxChat.eventsNotice = {
	CHAT_MSG_CHANNEL_JOIN = true,
	CHAT_MSG_CHANNEL_LEAVE = true,
	CHAT_MSG_CHANNEL_NOTICE = true,
	CHAT_MSG_CHANNEL_NOTICE_USER = true,
}

function PhanxChat.SuppressNotices(msg)
	return true
end

PhanxChat.eventsRepeat = {
	CHAT_MSG_SAY = true,
	CHAT_MSG_YELL = true,
	CHAT_MSG_CHANNEL = true,
	CHAT_MSG_EMOTE = true,
	CHAT_MSG_TEXT_EMOTE = true,
}

local NUM_HISTORY_LINES = 10
local history = {}

function PhanxChat.SuppressRepeats(msg)
	if arg2 and arg2 ~= playerName then
		local frame = this
		if not history[frame] then
			history[frame] = {}
		end
		local t = history[frame]
		local v = string.lower(arg2.." "..msg)

		if t[v] then return end

		if #t == NUM_HISTORY_LINES then
			local rem = table.remove(t, 1)
			t[rem] = nil
		end
		table.insert(t, v)
		t[v] = true
	end
end

--[[------------------------------------------------------------
	AddMessage
	channels, names, urls
--------------------------------------------------------------]]

local formatEvents = {
	CHAT_MSG_SAY = true,
	CHAT_MSG_YELL = true,
	CHAT_MSG_WHISPER = true,
	CHAT_MSG_WHISPER_INFORM = true,
	CHAT_MSG_GUILD = true,
	CHAT_MSG_OFFICER = true,
	CHAT_MSG_PARTY = true,
	CHAT_MSG_RAID = true,
	CHAT_MSG_RAID_LEADER = true,
	CHAT_MSG_RAID_WARNING = true,
	CHAT_MSG_BATTLEGROUND = true,
	CHAT_MSG_BATTLEGROUND_LEADER = true,
	CHAT_MSG_CHANNEL = true,
	CHAT_MSG_AFK = true,
	CHAT_MSG_DND = true,
	CHAT_MSG_SYSTEM = true,
}

function PhanxChat.AddMessage(frame, text, r, g, b, id)
	if formatEvents[event] then
		if db.names then
			name = event ~= "CHAT_MSG_SYSTEM" and arg2 or text:match(".*|h%[(.-)%]|h.*")
			if name then
				text = text:gsub( "|Hplayer:(.-)|h%[.-%]|h", PLAYER_STYLE:format( "%1", names[name] or COLOR_UNKNOWN and "|cff"..COLOR_UNKNOWN..name.."|r" or name ) )
			end
		end
		if event == "CHAT_MSG_CHANNEL" and db.channels then
			text = text:gsub( "%[%d+%.%s?[^%]%-]+%]%s?", CHANNEL_STYLE:gsub("%%1", arg8, 1):gsub("%%2", channels[arg8], 1), 1 )
		end
		if db.urls then
			text = text.." "
			for i, v in ipairs(URL_PATTERNS) do
				text = text:gsub(v[1], URL_STYLE:format(v[2], v[2]))
			end
		end
	end
	hooks[frame].AddMessage(frame, text, r, g, b, id)
end

--[[------------------------------------------------------------
	Buttons
--------------------------------------------------------------]]

local function hide()
	this:Hide()
end

local function scroll()
	if arg1 > 0 then
		if IsShiftKeyDown() then
			this:ScrollToTop()
		elseif IsControlKeyDown() then
			this:PageUp()
		else
			for i = 1, NUM_SCROLL_LINES do
				this:ScrollUp()
			end
		end
	elseif arg1 < 0 then
		if IsShiftKeyDown() then
			this:ScrollToBottom()
		elseif IsControlKeyDown() then
			this:PageDown()
		else
			for i = 1, NUM_SCROLL_LINES do
				this:ScrollDown()
			end
		end
	end
end

function PhanxChat.ChatFrame_OnUpdate(frame, elapsed)
	button = _G[frame:GetName().."BottomButton"]
	if frame:AtBottom() then
		button:Hide()
	else
		button:Show()
		hooks.ChatFrame_OnUpdate(frame, elapsed)
	end
end

--[[------------------------------------------------------------
	Channels
--------------------------------------------------------------]]

function PhanxChat.ChatEdit_UpdateHeader(frame)
	if not frame then
		frame = ChatFrameEditBox
	end
	if frame:IsShown() then
		local header = _G[frame:GetName().."Header"]
		local text = header:GetText()
		for k, v in pairs(CHANNEL_NAMES) do
			text = text:gsub(k, v)
		end
		text = text:gsub("%[(%w+)%.%s(%w*)%]", CHANNEL_STYLE)
		frame:SetTextInsets(header:GetWidth() + 15, 15, 0, 0)
	end
end

function PhanxChat:CHAT_MSG_CHANNEL_NOTICE(kind, _, _, _, _, _, _, number, name)
	if kind == "YOU_JOINED" then
		local name = arg9:match("^([^%s%-]+)")
		self.channels[arg8] = CHANNEL_NAMES[name] or name
	elseif kind == "YOU_LEFT" then
		self.channels[arg8] = nil
	end
end

function PhanxChat:BuildChannelList(...)
	for i = 1, select("#", ...), 2 do
		local num, name = select(i, ...)
		self.channels[num] = CHANNEL_NAMES[name] or name
	end
end

--[[------------------------------------------------------------
	Names
	Non-English class names copied from LibBabble-Class-3.0
--------------------------------------------------------------]]

local englishClass
do
	local locale = GetLocale()
	if locale == "deDE" then englishClass = {
		["Todestritter"] = "DEATHKNIGHT",
		["Druide"] = "DRUID",
		["Druidin"] = "DRUID",
		["Jäger"] = "HUNTER",
		["Jägerin"] = "HUNTER",
		["Magier"] = "MAGE",
		["Magierin"] = "MAGE",
		["Paladin"] = "PALADIN",
		["Priester"] = "PRIEST",
		["Priesterin"] = "PRIEST",
		["Schurke"] = "ROGUE",
		["Schurkin"] = "ROGUE",
		["Schamane"] = "SHAMAN",
		["Schamanin"] = "SHAMAN",
		["Hexenmeister"] = "WARLOCK",
		["Hexenmeisterin"] = "WARLOCK",
		["Krieger"] = "WARRIOR",
		["Kriegerin"] = "WARRIOR",
	}
	elseif locale == "esES" then englishClass = {
	--	[""] = "DEATHKNIGHT",
		["Druida"] = "DRUID",
		["Cazador"] = "HUNTER",
		["Cazadora"] = "HUNTER",
		["Mago"] = "MAGE",
		["Maga"] = "MAGE",
		["Paladín"] = "PALADIN",
		["Sacerdote"] = "PRIEST",
		["Sacerdotisa"] = "PRIEST",
		["Pícaro"] = "ROGUE",
		["Pícara"] = "ROGUE",
		["Chamán"] = "SHAMAN",
		["Brujo"] = "WARLOCK",
		["Bruja"] = "WARLOCK",
		["Guerrrero"] = "WARRIOR",
		["Guerrera"] = "WARRIOR",
	}
	elseif locale == "frFR" then englishClass = {
		["Chevalier de la mort"] = "DEATHKNIGHT",
		["Druide"] = "DRUID",
		["Druidesse"] = "DRUID",
		["Chasseur"] = "HUNTER",
		["Chasseresse"] = "HUNTER",
		["Mage"] = "MAGE", 
		["Paladin"] = "PALADIN", 
		["Prêtre"] = "PRIEST",
		["Prêtresse"] = "PRIEST",
		["Voleur"] = "ROGUE",
		["Voleuse"] = "ROGUE",
		["Chaman"] = "SHAMAN",
		["Chamane"] = "SHAMAN",
		["Démoniste"] = "WARLOCK",
		["Guerrier"] = "WARRIOR",
		["Guerrière"] = "WARRIOR",
	}
	elseif locale == "koKR" then englishClass = {
		["죽음의 기사"] = "DEATHKNIGHT",
		["드루이드"] = "DRUID", 
		["사냥꾼"] = "HUNTER", 
		["마법사"] = "MAGE", 
		["성기사"] = "PALADIN", 
		["사제"] = "PRIEST", 
		["도적"] = "ROGUE", 
		["주술사"] = "SHAMAN", 
		["흑마법사"] = "WARLOCK",
		["전사"] = "WARRIOR",
	}
	elseif locale == "ruRU" then englishClass = {
		["Рыцарь Смерти"] = "DEATHKNIGHT",
		["Друид"] = "DRUID",
		["Охотник"] = "HUNTER",
		["Охотница"] = "HUNTER",
		["Маг"] = "MAGE",
		["Паладин"] = "PALADIN",
		["Жрец"] = "PRIEST",
		["Жрица"] = "PRIEST",
		["Разбойник"] = "ROGUE",
		["Разбойница"] = "ROGUE",
		["Шаман"] = "SHAMAN",
		["Шаманка"] = "SHAMAN",
		["Чернокнижник"] = "WARLOCK",
		["Чернокнижница"] = "WARLOCK",
		["Воин"] = "WARRIOR",
	}
	elseif locale == "zhCN" then englishClass = {
		["死亡骑士"] = "DEATHKNIGHT",
		["德鲁伊"] = "DRUID",
		["猎人"] = "HUNTER",
		["法师"] = "MAGE",
		["圣骑士"] = "PALADIN",
		["牧师"] = "PRIEST",
		["萨满祭司"] = "SHAMAN",
		["潜行者"] = "ROGUE",
		["术士"] = "WARLOCK",
		["战士"] = "WARRIOR",
	}
	elseif locale == "zhTW" then englishClass = {
		["死亡騎士"] = "DEATHKNIGHT",
		["德魯伊"] = "DRUID",
		["獵人"] = "HUNTER",
		["法師"] = "MAGE",
		["聖騎士"] = "PALADIN",
		["牧師"] = "PRIEST",
		["盜賊"] = "ROGUE",
		["薩滿"] = "SHAMAN",
		["術士"] = "WARLOCK",
		["戰士"] = "WARRIOR",
	}
	end
end

function PhanxChat:RegisterName(name, class)
	if not name or not class or names[name] then return end
	local upperclass = class:upper():gsub(" ", "", 1)
	if upperclass == "UNKNOWN" then return end
	if CLASS_COLORS[upperclass] then
		--debug("adding "..class.." "..name)
		names[name] = "|cff"..CLASS_COLORS[upperclass]..name.."|r"
	elseif englishClass and CLASS_COLORS[englishClass[class]] then
		names[name] = "|cff"..CLASS_COLORS[englishClass[class]]..name.."|r"
	end
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
	local name, class, unregister
	for i = 1, GetNumGuildMembers(true) do
		name, _, _, _, class = GetGuildRosterInfo(i)
		self:RegisterName(name, class)
		unregister = true
	end
	if unregister then
		self:UnregisterEvent("PLAYER_GUILD_UPDATE")
		self:UnregisterEvent("GUILD_ROSTER_UPDATE")
	end
end

function PhanxChat:LFG_UPDATE()
	local type = UIDropDownMenu_GetSelectedID(LFMFrameTypeDropDown)
	local name = UIDropDownMenu_GetSelectedID(LFMFrameNameDropDown)
	for i = 1, select(1, GetNumLFGResults(selectedLFMType, selectedLFMName)) do
		local name, _, _, _, _, _, _, _, _, _, classFileName = GetLFGResults(selectedLFMType, selectedLFMName, resultIndex)
		if name then
			self:RegisterName(name, classFileName)
		end
	end
end

PhanxChat.MEETINGSTONE_UPDATE = PhanxChat.LFG_UPDATE

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
	local name, class
	if not UnitExists("target") or not UnitIsPlayer("target") or not UnitIsFriend("player", "target") then return end
	self:RegisterName(UnitName("target"), select(2, UnitClass("target")))
end

function PhanxChat:UPDATE_MOUSEOVER_UNIT()
	local name, class
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

--[[------------------------------------------------------------
	Tabs
--------------------------------------------------------------]]

function PhanxChat.OnDragStart(frame)
	if IsAltKeyDown() or not _G[frame:GetName():sub(1, -4)].isDocked then
		hooks[frame].OnDragStart(frame)
	end
end

--[[------------------------------------------------------------
	Tell Target
--------------------------------------------------------------]]

local function TellTarget(msg)
	if UnitExists("target") and UnitIsPlayer("target") and (UnitIsFriend("player", "target") or UnitIsCharmed("target")) then
		SendChatMessage(msg, "WHISPER", nil, UnitName("target"))
	end
end

--[[------------------------------------------------------------
	URL Copy
--------------------------------------------------------------]]

local function URLCopyDialog_Show(link)
	currentLink = link
	StaticPopup_Show("URL_COPY_DIALOG")
end

local function URLCopyDialog_OnShow()
	local frame = _G[this:GetName().."WideEditBox"]
	if frame then
		frame:SetText(currentLink)
		frame:SetFocus()
		frame:HighlightText(0)
	end
	local button = _G[this:GetName().."Button2"]
	if button then
		button:ClearAllPoints()
		button:SetWidth(200)
		button:SetPoint("CENTER", frame, "CENTER", 0, -30)
	end
	local icon = _G[this:GetName().."AlertIcon"]
	if icon then
		icon:Hide()
	end
end

local function URLCopyDialog_OnHide()
	this:GetParent():Hide()
end

StaticPopupDialogs.URL_COPY_DIALOG = {
	text = "URL",
	button2 = TEXT(CLOSE),
	hasEditBox = 1,
	hasWideEditBox = 1,
	showAlert = 1,
	OnShow = URLCopyDialog_OnShow,
	EditBoxOnEscapePressed = URLCopyDialog_OnHide,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
}

function PhanxChat.SetItemRef(link, ...)
	if link:sub(1, 3) == "url" then
		URLCopyDialog_Show(link:sub(5))
		return
	end
	hooks.SetItemRef(link, ...)
end

--[[------------------------------------------------------------
	Initialize
--------------------------------------------------------------]]

local defaults = {
	buttons = true,
	channels = true,
	edit = {
		arrows = true,
		move = true,
	},
	fade = 5,
	flash = true,
	names = true,
	log = false,
	scroll = true,
	sticky = true,
	suppress = {
		channels = true,
		repeats = true,
	},
	tabs = true,
	urls = true,
	version = PhanxChat.version,
}

function PhanxChat:VARIABLES_LOADED()
	if not PhanxChatDB then
		--debug("Initializing new settings")
		PhanxChatDB = defaults
		db = PhanxChatDB
	else
		db = PhanxChatDB
		if not db.version or type(db.version) ~= "number" then
			-- really ancient!
			db.version = 0
		end
		if db.version ~= self.version then
			--debug("Upgrading old settings")
			for k, v in pairs(defaults) do
				if db[k] == nil or type(db[k]) ~= type(defaults[k]) then
					db[k] = v
				end
			end
			db.version = self.version
		end
	end

	local ignore = {}
	do
		local profile = GetRealmName().." - "..UnitName("player")
		if blacklist[profile] then
			for k, v in pairs(blacklist[profile]) do
				ignore[k] = v
			end
		end
		for k, v in pairs(blacklist.default) do
			ignore[k] = v
		end
	end
	self.ignoredframes = ignore

	for i = 1, 7 do
		frame = _G["ChatFrame"..i]

		if not ignore[frame] then
			if not hooks[frame] then hooks[frame] = {} end
			hooks[frame].AddMessage = frame.AddMessage
			frame.AddMessage = self.AddMessage
		end

		frame:SetMaxLines(250)
		frame:SetMaxResize(1600, 1200)
		frame:SetMinResize(64, 32)
	end

	if db.buttons then
		for i = 1, 7 do
			frame = _G["ChatFrame"..i]

			button = _G["ChatFrame"..i.."UpButton"]
			button:SetScript("OnShow", hide)
			button:Hide()

			button = _G["ChatFrame"..i.."DownButton"]
			button:SetScript("OnShow", hide)
			button:Hide()

			button = _G["ChatFrame"..i.."BottomButton"]
			button:ClearAllPoints()
			button:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", -32, -4)
			button:Hide()
		end

		ChatFrameMenuButton:Hide()

		hooks.ChatFrame_OnUpdate = ChatFrame_OnUpdate
		ChatFrame_OnUpdate = self.ChatFrame_OnUpdate

		hooks.FCF_SetButtonSide = FCF_SetButtonSide
		FCF_SetButtonSide = noop
	end

	if db.channels then
		for k, v in pairs(CHAT_STRINGS) do
			oldstrings[k] = _G["CHAT_"..k.."_GET"]
			_G["CHAT_"..k.."_GET"] = v
		end
		hooksecurefunc("ChatEdit_UpdateHeader", self.ChatEdit_UpdateHeader)

		self:BuildChannelList(GetChannelList())
		self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE")
	end

	if db.fade > 0 then
		local t = db.fade
		for i = 1, 7 do
			frame = _G["ChatFrame"..i]
			frame:SetFading(1)
			frame:SetFadeDuration(t)
		end
	else
		for i = 1, 7 do
			frame = _G["ChatFrame"..i]
			frame:SetFading(0)
		end
	end

	if db.flash then
		hooks.FCF_FlashTab = FCF_FlashTab
		FCF_FlashTab = noop
	end

	if db.edit.arrows then
		ChatFrameEditBox:SetAltArrowKeyMode(false)
	end

	if db.edit.move then
		frame = ChatFrameEditBox
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT",  ChatFrame1, "TOPLEFT", -5, 0)
		frame:SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPRIGHT", 5, 0)
	end

	if db.log then
		LoggingChat(1)
	end

	if db.names then
		self:RegisterEvent("FRIENDLIST_UPDATE")
		self:RegisterEvent("PLAYER_GUILD_UPDATE") -- workaround for people who don't get guild info immediately
		self:RegisterEvent("GUILD_ROSTER_UPDATE")
		self:RegisterEvent("PARTY_MEMBERS_CHANGED")
		self:RegisterEvent("RAID_ROSTER_UPDATE")
		self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
		self:RegisterEvent("PLAYER_TARGET_CHANGED")
		self:RegisterEvent("WHO_LIST_UPDATE")
		self:RegisterEvent("CHAT_MSG_SYSTEM")

		self:RegisterName(UnitName("player"), select(2, UnitClass("player")))

		if GetNumFriends() > 0 then
			ShowFriends()
		end

		if IsInGuild() then
			GuildRoster()
		end
	end

	if db.scroll then
		for i = 1, 7 do
			frame = _G["ChatFrame"..i]
			frame:EnableMouseWheel(true)
			frame:SetScript("OnMouseWheel", scroll)
		end
	end

	if db.sticky then
		for k, v in pairs(STICKY_TYPES) do
			ChatTypeInfo[k].sticky = v
		end
	end

	if db.suppress.channels then
		for event in pairs(self.eventsNotice) do
			ChatFrame_AddMessageEventFilter(event, self.SuppressNotices)
		end
	end

	if db.suppress.repeats then
		for event in pairs(self.eventsRepeat) do
			ChatFrame_AddMessageEventFilter(event, self.SuppressRepeats)
		end
	end

	if db.tabs then
		for i = 2, 7 do
			frame = _G["ChatFrame"..i.."Tab"]
			if not hooks[frame] then hooks[frame] = {} end
			hooks[frame].OnDragStart = frame:GetScript("OnDragStart")
			frame:SetScript("OnDragStart", self.OnDragStart)
		end
	end

	if db.urls then
		hooks.SetItemRef = SetItemRef
		SetItemRef = self.SetItemRef
	end

	SLASH_TELLTARGET1 = "/tt"
	SLASH_TELLTARGET2 = "/wt"
	SlashCmdList.TELLTARGET = TellTarget
end

PhanxChat:SetScript("OnEvent", function(self, event, ...)
	if self[event] then
		--debug("Handling event "..event)
		self[event](self, ...)
	else
		--debug("No handler found for event "..event)
		self:UnregisterEvent(event)
	end
end)

PhanxChat:RegisterEvent("VARIABLES_LOADED")