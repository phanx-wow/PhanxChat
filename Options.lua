--[[------------------------------------------------------------
	Tab size is 5.
--------------------------------------------------------------]]

local _G = _G
local PhanxChat = PhanxChat
local L = PhanxChat.L
local db

local strformat = string.format
local strgsub = string.gsub
local strlower = string.lower
local strmatch = string.match
local strupper = string.upper

local function print(msg)		ChatFrame1:AddMessage("|cff00ddbaPhanxChat:|r "..msg)				end
local function printf(msg, ...)	ChatFrame1:AddMessage("|cff00ddbaPhanxChat:|r "..strformat(msg, ...))	end

local function debug(msg, ...)
	do return end
	if select("#", ...) > 0 then
		ChatFrame1:AddMessage("|cffff7f7f[DEBUG] PhanxChat:|r "..strformat(msg, ...))
	else
		ChatFrame1:AddMessage("|cffff7f7f[DEBUG] PhanxChat:|r "..msg)
	end
end

local DISABLED	= "|cffff7f7f"..L["disabled"].."|r"
local ENABLED	= "|cff7fff7f"..L["enabled"].."|r"
local SETTING	= "|cffffff7f%s|r"

function PhanxChat:SetButtons()
	if not db.buttons then
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

		self.hooks.ChatFrame_OnUpdate = ChatFrame_OnUpdate
		ChatFrame_OnUpdate = self.ChatFrame_OnUpdate

		self.hooks.FCF_SetButtonSide = FCF_SetButtonSide
		FCF_SetButtonSide = noop

		db.buttons = true
		printf(L["Button hiding %s."], ENABLED)
	else
		ChatFrameMenuButton:Show()

		ChatFrame_OnUpdate = self.hooks.ChatFrame_OnUpdate
		self.hooks.ChatFrame_OnUpdate = nil

		FCF_SetButtonSide = self.hooks.FCF_SetButtonSide
		self.hooks.FCF_SetButtonSide = nil

		for i = 1, 7 do
			frame = _G["ChatFrame"..i]

			button = _G["ChatFrame"..i.."UpButton"]
			button:SetScript("OnShow", nil)
			button:Show()

			button = _G["ChatFrame"..i.."DownButton"]
			button:SetScript("OnShow", nil)
			button:Show()

			button = _G["ChatFrame"..i.."BottomButton"]
			button:ClearAllPoints()
			button:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -32, -4)
			button:Show()

			FCF_UpdateButtonSide(frame)
		end

		db.buttons = false
		printf(L["Button hiding %s."], DISABLED)
	end
end

function PhanxChat:SetChannels()
	if not db.channels then
		for k, v in pairs(self.newstrings) do
			self.oldstrings[k] = _G["CHAT_"..k.."_GET"]
			_G["CHAT_"..k.."_GET"] = v
		end
		self:BuildChannelList(GetChannelList())
		db.channels = true
		printf(L["Short channel names %s."], ENABLED)
	else
		for k, v in pairs(self.oldstrings) do
			_G["CHAT_"..k.."_GET"] = v
			self.oldstrings[k] = nil
		end
		for k in pairs(self.channels) do
			self.channels[k] = nil
		end
		db.channels = false
		printf(L["Short channel names %s."], DISABLED)
	end
end

function PhanxChat:SetEdit(a1)
	a1 = a1 and strlower(a1) or "nil"
	if a1 == "arrows" then
		self:SetEditArrows()
	elseif a1 == "move" then
		self:SetEditMove()
	end
end

function PhanxChat:SetEditArrows()
	if not db.edit.arrows then
		ChatFrameEditBox:SetAltArrowKeyMode(false)
		db.edit.arrows = true
		printf(L["Edit box arrow keys %s."], ENABLED)
	else
		ChatFrameEditBox:SetAltArrowKeyMode(true)
		db.edit.arrows = false
		printf(L["Edit box arrow keys %s."], DISABLED)
	end
end

function PhanxChat:SetEditMove()
	frame = ChatFrameEditBox
	if not db.edit.move then
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT",  ChatFrame1, "TOPLEFT", -5, 0)
		frame:SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPRIGHT", 5, 0)
		db.edit.move = true
		printf(L["Edit box relocation %s."], ENABLED)
	else
		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT",  ChatFrame1, "BOTTOMLEFT", -5, 0)
		frame:SetPoint("TOPRIGHT", ChatFrame1, "BOTTOMRIGHT", 5, 0)
		db.edit.move = false
		printf(L["Edit box relocation %s."], DISABLED)
	end
end

function PhanxChat:SetFade(v)
	v = tonumber(v)
	if v then
		v = floor(v)
		if v > 0 then
			for i = 1, 7 do
				frame = _G["ChatFrame"..i]
				frame:SetFading(1)
				frame:SetFadeDuration(v)
			end
			printf(L["Chat fade time set to %d minutes."], v)
		else
			for i = 1, 7 do
				frame = _G["ChatFrame"..i]
				frame:SetFading(0)
			end
			printf(L["Chat fading %s."], DISABLED)
		end
		db.fade = v
	else
		printf(L["Fade time is currently set to %d minutes."], db.fade)
	end
end

function PhanxChat:SetFlash()
	if not db.flash then
		self.hooks.FCF_FlashTab = FCF_FlashTab
		FCF_FlashTab = noop
		db.flash = true
		printf(L["Chat tab flash suppression %s."], ENABLED)
	else
		FCF_FlashTab = self.hooks.FCF_FlashTab
		self.hooks.FCF_FlashTab = nil
		db.flash = false
		printf(L["Chat tab flash suppression %s."], DISABLED)
	end
end

function PhanxChat:SetLog()
	if not db.log then
		LoggingChat(1)
		db.log = true
		printf(L["Automatic chat logging %s."], ENABLED)
	else
		LoggingChat(0)
		db.log = false
		printf(L["Automatic chat logging %s."], DISABLED)
	end
end

function PhanxChat:SetNames()
	if not db.names then
		self:RegisterEvent("FRIENDLIST_UPDATE")
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

		db.names = true
		printf(L["Player name class coloring %s."], ENABLED)
	else
		self:UnregisterEvent("FRIENDLIST_UPDATE")
		self:UnregisterEvent("GUILD_ROSTER_UPDATE")
		self:UnregisterEvent("PARTY_MEMBERS_CHANGED")
		self:UnregisterEvent("RAID_ROSTER_UPDATE")
		self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
		self:UnregisterEvent("PLAYER_TARGET_CHANGED")
		self:UnregisterEvent("WHO_LIST_UPDATE")
		self:UnregisterEvent("CHAT_MSG_SYSTEM")
		for k in pairs(self.names) do
			self.names[k] = nil
		end
		db.names = false
		printf(L["Player name class coloring %s."], DISABLED)
	end
end

function PhanxChat:SetScroll()
	if not db.scroll then
		for i = 1, 7 do
			frame = _G["ChatFrame"..i]
			frame:EnableMouseWheel(true)
			frame:SetScript("OnMouseWheel", scroll)
		end
		db.scroll = true
		printf(L["Mousewheel scrolling %s."], ENABLED)
	else
		for i = 1, 7 do
			frame = _G["ChatFrame"..i]
			frame:EnableMouseWheel(false)
			frame:SetScript("OnMouseWheel", nil)
		end
		db.scroll = false
		printf(L["Mousewheel scrolling %s."], DISABLED)
	end
end

function PhanxChat:SetSticky()
	if not db.sticky then
		for k, v in pairs(self.stickytypes) do
			ChatTypeInfo[k].sticky = v
		end
		db.sticky = true
		printf(L["Sticky channels %s."], ENABLED)
	else
		for k, v in pairs(self.stickytypes) do
			ChatTypeInfo[k].sticky = 0
		end
		db.sticky = false
		printf(L["Sticky channels %s."], DISABLED)
	end
end

function PhanxChat:SetSuppress(a1)
	a1 = a1 and strlower(a1) or "nil"
	if a1 == "channels" or a1 == "notices" then
		self:SetSuppressNotices()
	elseif a1 == "repeats" then
		self:SetSuppressRepeats()
	end
end

function PhanxChat:SetSuppressNotices()
	if not db.suppress.notices then
		for event in pairs(self.eventsNotice) do
			ChatFrame_AddMessageEventFilter(event, self.SuppressNotices)
		end
		db.suppress.notices = true
		printf(L["Channel notice suppression %s."], ENABLED)
	else
		for event in pairs(self.eventsNotice) do
			ChatFrame_RemoveMessageEventFilter(event, self.SuppressNotices)
		end
		db.suppress.notices = false
		printf(L["Channel notice suppression %s."], DISABLED)
	end
end

function PhanxChat:SetSuppressRepeats()
	if not db.suppress.repeats then
		for event in pairs(self.eventsRepeat) do
			ChatFrame_AddMessageEventFilter(event, self.SuppressRepeats)
		end
		db.suppress.repeats = true
		printf(L["Repeated message suppression %s."], ENABLED)
	else
		for event in pairs(self.eventsRepeat) do
			ChatFrame_RemoveMessageEventFilter(event, self.SuppressRepeats)
		end
		db.suppress.repeats = false
		printf(L["Repeated message suppression %s."], DISABLED)
	end
end

function PhanxChat:SetTabs()
	if not db.tabs then
		for i = 2, 7 do
			frame = _G["ChatFrame"..i.."Tab"]
			if not self.hooks[frame] then self.hooks[frame] = {} end
			self.hooks[frame].OnDragStart = frame:GetScript("OnDragStart")
			frame:SetScript("OnDragStart", self.OnDragStart)
		end
		db.tabs = true
		printf(L["Chat tab locking %s."], ENABLED)
	else
		for i = 2, 7 do
			frame = _G["ChatFrame"..i.."Tab"]
			frame:SetScript("OnDragStart", self.hooks[frame].OnDragStart)
			self.hooks[frame].OnDragStart = nil
		end
		db.tabs = false
		printf(L["Chat tab locking %s."], DISABLED)
	end
end

function PhanxChat:SetURLs()
	if not db.urls then
		self.hooks.SetItemRef = SetItemRef
		SetItemRef = self.SetItemRef
		db.urls = true
		printf(L["URL linking %s."], ENABLED)
	else
		SetItemRef = self.hooks.SetItemRef
		db.urls = false
		printf(L["URL linking %s."], DISABLED)
	end
end

function PhanxChat:ClearChatFrames()
	for i = 1, 7 do
		_G["ChatFrame"..i]:Clear()
	end
end

function PhanxChat:SetFont(v)
	v = tonumber(v)
	if v then
		v = floor(v)
		if v >= 6 and v <= 32 then
			for i = 1, 7 do
				FCF_SetChatWindowFontSize(nil, _G["ChatFrame"..i], v)
			end
			printf(L["Chat font size set to %d."], v)
		end
	end
end

local VERSION_STRING = strformat(L["Version %d loaded."], PhanxChat.version)
function PhanxChat:ShowAbout()
	print(VERSION_STRING)
end

local HELP_STRING = strgsub(L["Use /pchat with the following commands:"], "/pchat", "|cffffff7f/pchat|r")
function PhanxChat:ShowHelp()
	print(HELP_STRING)
	ChatFrame1:AddMessage("  |cffffff7f buttons |r- "		..L["Hide the scroll buttons"]						.." ["..(db.buttons and ENABLED or DISABLED).."]")
	ChatFrame1:AddMessage("  |cffffff7f channels |r- "	..L["Shorten channel names and chat strings"]			.." ["..(db.channels and ENABLED or DISABLED).."]")
	ChatFrame1:AddMessage("  |cffffff7f clear |r- "		..L["Clear the window"]								)
	ChatFrame1:AddMessage("  |cffffff7f edit arrows |r- "	..L["Enable arrow keys in the edit box"]				.." ["..(db.edit.arrows and ENABLED or DISABLED).."]")
	ChatFrame1:AddMessage("  |cffffff7f edit move |r- "	..L["Move the edit box above the window"]				.." ["..(db.edit.move and ENABLED or DISABLED).."]")
	ChatFrame1:AddMessage("  |cffffff7f fade <N> |r- "	..L["Set the text fade time in minutes (0 = disabled)"]	.." ["..(db.fade > 0 and SETTING:format(db.fade) or DISABLED).."]")
	ChatFrame1:AddMessage("  |cffffff7f flash |r- "		..L["Stop tabs from flashing"]						.." ["..(db.flash and ENABLED or DISABLED).."]")
	ChatFrame1:AddMessage("  |cffffff7f font <N> |r- "	..L["Set the font size for all windows"]				)
	ChatFrame1:AddMessage("  |cffffff7f log |r- "		..L["Start chat logging automatically"]					.." ["..(db.log and ENABLED or DISABLED).."]")
	ChatFrame1:AddMessage("  |cffffff7f names |r- "		..L["Color player names by class if known"]				.." ["..(db.names and ENABLED or DISABLED).."]")
	ChatFrame1:AddMessage("  |cffffff7f scroll |r- "		..L["Enable mousewheel scrolling"]						.." ["..(db.scroll and ENABLED or DISABLED).."]")
	ChatFrame1:AddMessage("  |cffffff7f sticky |r- "		..L["Make more chat types sticky"]						.." ["..(db.sticky and ENABLED or DISABLED).."]")
	ChatFrame1:AddMessage("  |cffffff7f suppress channels |r- "	..L["Suppress channel notification messages"]		.." ["..(db.suppress.channels and ENABLED or DISABLED).."]")
	ChatFrame1:AddMessage("  |cffffff7f suppress repeats |r- "	..L["Suppress repeated messages in public channels"]	.." ["..(db.suppress.repeats and ENABLED or DISABLED).."]")
	ChatFrame1:AddMessage("  |cffffff7f tabs |r- "		..L["Lock docked tabs in place (hold Alt to drag)"]		.." ["..(db.tabs and ENABLED or DISABLED).."]")
	ChatFrame1:AddMessage("  |cffffff7f urls |r- "		..L["Link URLs for easy copying"]						.." ["..(db.urls and ENABLED or DISABLED).."]")
end

local optfuncs = {
	about	= "ShowAbout",
	buttons	= "SetButtons",
	channels	= "SetChannels",
	clear	= "ClearChatFrames",
	edit		= "SetEdit",
	fade		= "SetFade",
	flash	= "SetFlash",
	font		= "SetFont",
	help		= "ShowHelp",
	log		= "SetLog",
	names	= "SetNames",
	suppress	= "SetSuppress",
	scroll	= "SetScroll",
	sticky	= "SetSticky",
	tabs		= "SetTabs",
	urls		= "SetURLs",
}

function PhanxChat:ParseCommand(input)
	if not db then
		db = PhanxChatDB
	end

	local cmd, etc = strmatch(input, "^%s*(%a+)%s*(.*)$")
	local func = cmd and optfuncs[strlower(cmd)] or "ShowHelp"
	if self[func] then
		self[func](self, etc)
	else
		self:ShowHelp()
	end
end

SLASH_PHANXCHAT1 = "/pchat"
SlashCmdList.PHANXCHAT = function(input) PhanxChat:ParseCommand(input) end
