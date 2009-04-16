--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and improves chat frame usability.
	By Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	See README for license terms and other information.
----------------------------------------------------------------------]]

if not PhanxChat then return end

------------------------------------------------------------------------

local CreateCheckbox
do
	local function OnEnter(self)
		if self.hint then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(self.hint, nil, nil, nil, nil, true)
		end
	end

	local function OnLeave()
		GameTooltip:Hide()
	end

	function CreateCheckbox(parent, text, size)
		local check = CreateFrame("CheckButton", nil, parent)
		check:SetWidth(size or 26)
		check:SetHeight(size or 26)

		check:SetHitRectInsets(0, -100, 0, 0)

		check:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
		check:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
		check:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
		check:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
		check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")

		check:SetScript("OnEnter", OnEnter)
		check:SetScript("OnLeave", OnLeave)

		check:SetScript("OnClick", Checkbox_OnClick)

		local label = check:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		label:SetPoint("LEFT", check, "RIGHT", 0, 1)
		label:SetText(text)

		check.label = label

		return check
	end
end

------------------------------------------------------------------------

local CreateSlider
do
	local function OnEnter(self)
		if self.hint then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(self.hint, nil, nil, nil, nil, true)
		end
	end

	local function OnLeave()
		GameTooltip:Hide()
	end

	local function OnMouseWheel(self, delta)
		local step = self:GetValueStep() * delta
		local minValue, maxValue = self:GetMinMaxValues()

		if step > 0 then
			self:SetValue(min(self:GetValue() + step, maxValue))
		else
			self:SetValue(max(self:GetValue() + step, minValue))
		end
	end

	local sliderBG = {
		bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
		edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
		edgeSize = 8, tile = true, tileSize = 8,
		insets = { left = 3, right = 3, top = 6, bottom = 6 }
	}

	function CreateSlider(parent, name, lowvalue, highvalue, valuestep)
		local frame = CreateFrame("Frame", nil, parent)
		frame:SetWidth(144)
		frame:SetHeight(42)

		local slider = CreateFrame("Slider", nil, frame)
		slider:SetPoint("LEFT")
		slider:SetPoint("RIGHT")
		slider:SetHeight(17)
		slider:SetHitRectInsets(0, 0, -10, -10)
		slider:SetOrientation("HORIZONTAL")
		slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
		slider:SetBackdrop(sliderBG)

		local label = slider:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		label:SetPoint("BOTTOMLEFT", slider, "TOPLEFT")
		label:SetPoint("BOTTOMRIGHT", slider, "TOPRIGHT")
		label:SetJustifyH("LEFT")
		label:SetText(name)

		local low = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		low:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", -4, 3)
		low:SetText(lowvalue)

		local high = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		high:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", 4, 3)
		high:SetText(highvalue)

		local value = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		value:SetPoint("TOP", slider, "BOTTOM", 0, 3)
		value:SetTextColor(1, 0.8, 0)

		slider:SetMinMaxValues(lowvalue, highvalue)
		slider:SetValueStep(valuestep or 1)

		slider:EnableMouseWheel(true)
		slider:SetScript("OnMouseWheel", OnMouseWheel)
		slider:SetScript("OnEnter", OnEnter)
		slider:SetScript("OnLeave", OnLeave)

		slider.label = label
		slider.low = low
		slider.high = high
		slider.value = value

		return slider
	end
end

------------------------------------------------------------------------

local L = PhanxChat.L
if GetLocale() == "enUS" or GetLocale() == "enGB" then
	-- do nothing
elseif GetLocale() == "deDE" then

elseif GetLocale() == "esES" then

elseif GetLocale() == "frFR" then

elseif GetLocale() == "ruRU" then

elseif GetLocale() == "koKR" then

elseif GetLocale() == "zhCN" then

elseif GetLocale() == "zhTW" then

end

------------------------------------------------------------------------

local db
local shown
local cache = { }
local changed = { }
local noop = function() return end

local panel = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
panel.name = GetAddOnMetadata("PhanxChat", "Title")
panel:Hide()

------------------------------------------------------------------------

local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -16)
title:SetPoint("TOPRIGHT", -16, -16)
title:SetText(panel.name)

local notes = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
notes:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
notes:SetPoint("TOPRIGHT", title, "BOTTOMRIGHT", 0, -8)
notes:SetHeight(48)
notes:SetJustifyH("LEFT")
notes:SetJustifyV("TOP")
notes:SetNonSpaceWrap(true)
notes:SetText(L["PhanxChat is a chat frame modification addon to help reduce chat frame clutter and improve chat frame usability. Use this panel to configure the addon's appearance and behavior."])

------------------------------------------------------------------------

local scroll = CreateFrame("ScrollFrame", nil, panel)
scroll:SetPoint("TOP", notes, "BOTTOM", 0, -8)
scroll:SetPoint("BOTTOMLEFT", 16, 16)
scroll:SetPoint("BOTTOMRIGHT", -16, 16)

local frame = CreateFrame("Frame", nil, scroll)
scroll:SetScrollChild(frame)
frame:SetPoint("TOP")
frame:SetPoint("LEFT")
frame:SetPoint("RIGHT")
frame:SetHeight(750)

local scrollbar, upbutton, downbutton = LibStub("tekKonfig-Scroll").new(scroll, 6)
scrollbar:SetMinMaxValues(0, 300) -- height - 450
scrollbar:SetValue(0)

local f = scrollbar:GetScript("OnValueChanged")
scrollbar:SetScript("OnValueChanged", function(self, value, ...)
	scroll:SetVerticalScroll(value)
	frame:SetPoint("TOP", 0, value)
	return f(self, value, ...)
end)

local offset = 0
scroll:UpdateScrollChildRect()
scroll:EnableMouseWheel(true)
scroll:SetScript("OnMouseWheel", function(self, val) scrollbar:SetValue(scrollbar:GetValue() - val * 50) end)

------------------------------------------------------------------------

local buttons = CreateCheckbox(frame, L["Hide scroll buttons"])
buttons.hint = L["Hide the scroll up, scroll down, scroll to bottom, and menu buttons next to the chat frame"]
buttons:SetPoint("TOPLEFT")
buttons:SetScript("OnClick", function(self)
	local checked = self:GetChecked() and true or false
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

	local frame, button
	if checked then
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

		PhanxChat.hooks.ChatFrame_OnUpdate = ChatFrame_OnUpdate
		ChatFrame_OnUpdate = self.ChatFrame_OnUpdate

		PhanxChat.hooks.FCF_SetButtonSide = FCF_SetButtonSide
		FCF_SetButtonSide = noop

		db.buttons = true
	else
		ChatFrameMenuButton:Show()

		ChatFrame_OnUpdate = PhanxChat.hooks.ChatFrame_OnUpdate
		PhanxChat.hooks.ChatFrame_OnUpdate = nil

		FCF_SetButtonSide = PhanxChat.hooks.FCF_SetButtonSide
		PhanxChat.hooks.FCF_SetButtonSide = nil

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
	end

	changed.buttons = true
end)

------------------------------------------------------------------------

local channels = CreateCheckbox(frame, L["Shorten channel names"])
channels.hint = L["Shorten channel names in chat messages. For example, '[1. General]' might be shortened to '1|'."]
channels:SetPoint("TOPLEFT", buttons, "BOTTOMLEFT", 0, -8)
channels:SetScript("OnClick", function(self)
	local checked = self:GetChecked() and true or false
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

	if checked then
		for k, v in pairs(PhanxChat.newstrings) do
			PhanxChat.oldstrings[k] = _G["CHAT_"..k.."_GET"]
			_G["CHAT_"..k.."_GET"] = v
		end

		PhanxChat:BuildChannelList(GetChannelList())

		db.channels = true
	else
		for k, v in pairs(PhanxChat.oldstrings) do
			_G["CHAT_"..k.."_GET"] = v
			PhanxChat.oldstrings[k] = nil
		end

		for k in pairs(PhanxChat.channels) do
			PhanxChat.channels[k] = nil
		end

		db.channels = false
	end
end)

------------------------------------------------------------------------

local arrows = CreateCheckbox(frame, L["Enable arrow keys"])
arrows.hint = L["Enable the arrow keys in the chat edit box."]
arrows:SetPoint("TOPLEFT", channels, "BOTTOMLEFT", 0, -8)
arrows:SetScript("OnClick", function(self)
	local checked = self:GetChecked() and true or false
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

	if checked then
		ChatFrameEditBox:SetAltArrowKeyMode(false)
		db.edit.arrows = true
	else
		ChatFrameEditBox:SetAltArrowKeyMode(true)
		db.edit.arrows = false
	end
end)

------------------------------------------------------------------------

local edit = CreateCheckbox(frame, L["Edit box above chat frame"])
edit.hint = L["Move the chat edit box to the top of the chat frame"]
edit:SetPoint("TOPLEFT", arrows, "BOTTOMLEFT", 0, -8)
edit:SetScript("OnClick", function(self)
	local checked = self:GetChecked() and true or false
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

	local frame = ChatFrameEditBox
	if checked then
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT",  ChatFrame1, "TOPLEFT", -5, 0)
		frame:SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPRIGHT", 5, 0)
		db.edit.move = true
	else
		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT",  ChatFrame1, "BOTTOMLEFT", -5, 0)
		frame:SetPoint("TOPRIGHT", ChatFrame1, "BOTTOMRIGHT", 5, 0)
		db.edit.move = false
	end
end)

------------------------------------------------------------------------

local flash = CreateCheckbox(frame, L["Disable chat tab flash"])
flash.hint = L["Disable the flashing effect on chat tabs when new messages are received."]
flash:SetPoint("TOPLEFT", edit, "BOTTOMLEFT", 0, -8)
flash:SetScript("OnClick", function(self)
	local checked = self:GetChecked() and true or false
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

	if checked then
		PhanxChat.hooks.FCF_FlashTab = FCF_FlashTab
		FCF_FlashTab = noop
		db.flash = true
	else
		FCF_FlashTab = PhanxChat.hooks.FCF_FlashTab
		PhanxChat.hooks.FCF_FlashTab = nil
		db.flash = false
	end
end)

------------------------------------------------------------------------

local log = CreateCheckbox(frame, L["Auto-start chat logging"])
log.hint = L["Automatically enable chat logging when you log in. Chat logging can be started or stopped manually at any time using the '/chatlog' command. Logs are saved when you log out or exit the game to the 'World of Warcraft/Logs/WoWChatLog.txt' file."]
log:SetPoint("TOPLEFT", flash, "BOTTOMLEFT", 0, -8)
log:SetScript("OnClick", function(self)
	local checked = self:GetChecked() and true or false
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

	if checked then
		LoggingChat(1)
		db.log = true
	else
		db.log = false
	end
end)

------------------------------------------------------------------------

local names = CreateCheckbox(frame, L["Color player names by class"])
names.hint = L["Color player names in chat by their class if known. Classes are known if you have seen the player in your group, in your guild, online on your friends list, in a '/who' query, or have targetted or moused over them since you logged in."]
names:SetPoint("TOPLEFT", log, "BOTTOMLEFT", 0, -8)
names:SetScript("OnClick", function(self)
	local checked = self:GetChecked() and true or false
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

	if checked then
		PhanxChat:RegisterEvent("FRIENDLIST_UPDATE")
		PhanxChat:RegisterEvent("GUILD_ROSTER_UPDATE")
		PhanxChat:RegisterEvent("PARTY_MEMBERS_CHANGED")
		PhanxChat:RegisterEvent("RAID_ROSTER_UPDATE")
		PhanxChat:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
		PhanxChat:RegisterEvent("PLAYER_TARGET_CHANGED")
		PhanxChat:RegisterEvent("WHO_LIST_UPDATE")
		PhanxChat:RegisterEvent("CHAT_MSG_SYSTEM")

		PhanxChat:RegisterName(UnitName("player"), select(2, UnitClass("player")))

		if GetNumFriends() > 0 then
			ShowFriends()
		end

		if IsInGuild() then
			GuildRoster()
		end

		db.names = true
	else
		PhanxChat:UnregisterEvent("FRIENDLIST_UPDATE")
		PhanxChat:UnregisterEvent("GUILD_ROSTER_UPDATE")
		PhanxChat:UnregisterEvent("PARTY_MEMBERS_CHANGED")
		PhanxChat:UnregisterEvent("RAID_ROSTER_UPDATE")
		PhanxChat:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
		PhanxChat:UnregisterEvent("PLAYER_TARGET_CHANGED")
		PhanxChat:UnregisterEvent("WHO_LIST_UPDATE")
		PhanxChat:UnregisterEvent("CHAT_MSG_SYSTEM")

		wipe(PhanxChat.names)

		db.names = false
	end
end)

------------------------------------------------------------------------

local scroll = CreateCheckbox(frame, L["Enable mouse wheel scrolling"])
scroll.hint = L["Enable scrolling through chat frames with the mouse wheel. Hold the Shift key while scrolling to jump to the top or bottom of the chat frame."]
scroll:SetPoint("TOPLEFT", names, "BOTTOMLEFT", 0, -8)
scroll:SetScript("OnClick", function(self)
	local checked = self:GetChecked() and true or false
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

	local frame
	if checked then
		for i = 1, 7 do
			frame = _G["ChatFrame"..i]
			frame:EnableMouseWheel(true)
			frame:SetScript("OnMouseWheel", PhanxChat.scroll)
		end
		db.scroll = true
	else
		for i = 1, 7 do
			frame = _G["ChatFrame"..i]
			frame:EnableMouseWheel(false)
			frame:SetScript("OnMouseWheel", nil)
		end
		db.scroll = false
	end
end)

local sticky = CreateCheckbox(frame, L["Enable sticky channels"])
sticky.hint = L["Enable sticky channel behavior for all chat types except emotes."]
sticky:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", 0, -8)
sticky:SetScript("OnClick", function(self)
	local checked = self:GetChecked() and true or false
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

	if checked then
		for k, v in pairs(PhanxChat.stickytypes) do
			ChatTypeInfo[k].sticky = v
		end
		db.sticky = true
	else
		for k, v in pairs(PhanxChat.stickytypes) do
			ChatTypeInfo[k].sticky = 0
		end
		db.sticky = false
	end
end)

------------------------------------------------------------------------

local notices = CreateCheckbox(frame, L["Suppress channel notifications"])
notices.hint = L["Suppress the notification messages informing you when someone leaves or joins a channel, or when channel ownership changes."]
notices:SetPoint("TOPLEFT", sticky, "BOTTOMLEFT", 0, -8)
notices:SetScript("OnClick", function(self)
	local checked = self:GetChecked() and true or false
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

	if checked then
		for event in pairs(PhanxChat.eventsNotice) do
			ChatFrame_AddMessageEventFilter(event, PhanxChat.SuppressNotices)
		end
		db.suppress.notices = true
	else
		for event in pairs(PhanxChat.eventsNotice) do
			ChatFrame_RemoveMessageEventFilter(event, PhanxChat.SuppressNotices)
		end
		db.suppress.notices = false
	end
end)

------------------------------------------------------------------------

local repeats = CreateCheckbox(frame, L["Suppress repeated messages"])
repeats.hint = L["Suppress repeated messages in public chat channels."]
repeats:SetPoint("TOPLEFT", notices, "BOTTOMLEFT", 0, -8)
repeats:SetScript("OnClick", function(self)
	local checked = self:GetChecked() and true or false
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

	if checked then
		for event in pairs(PhanxChat.eventsRepeat) do
			ChatFrame_AddMessageEventFilter(PhanxChat, PhanxChat.SuppressRepeats)
		end
		db.suppress.repeats = true
	else
		for event in pairs(PhanxChat.eventsRepeat) do
			ChatFrame_RemoveMessageEventFilter(event, PhanxChat.SuppressRepeats)
		end
		db.suppress.repeats = false
	end
end)

------------------------------------------------------------------------

local tabs = CreateCheckbox(frame, L["Lock docked chat tabs"])
tabs.hint = L["Prevent docked chat tabs from being dragged unless the Alt key is down."]
tabs:SetPoint("TOPLEFT", repeats, "BOTTOMLEFT", 0, -8)
tabs:SetScript("OnClick", function(self)
	local checked = self:GetChecked() and true or false
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

	local frame
	if checked then
		for i = 2, 7 do
			frame = _G["ChatFrame"..i.."Tab"]
			if not PhanxChat.hooks[frame] then
				PhanxChat.hooks[frame] = {}
			end
			PhanxChat.hooks[frame].OnDragStart = frame:GetScript("OnDragStart")
			frame:SetScript("OnDragStart", PhanxChat.OnDragStart)
		end
		db.tabs = true
	else
		for i = 2, 7 do
			frame = _G["ChatFrame"..i.."Tab"]
			frame:SetScript("OnDragStart", PhanxChat.hooks[frame].OnDragStart)
			PhanxChat.hooks[frame].OnDragStart = nil
		end
		db.tabs = false
	end
end)

------------------------------------------------------------------------

local urls = CreateCheckbox(frame, L["Link URLs in chat"])
urls.hint = L["Turn URLs in chat messages into clickable links for easy copying."]
urls:SetPoint("TOPLEFT", tabs, "BOTTOMLEFT", 0, -8)
urls:SetScript("OnClick", function(self)
	local checked = self:GetChecked() and true or false
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

	if checked then
		PhanxChat.hooks.SetItemRef = SetItemRef
		SetItemRef = PhanxChat.SetItemRef
		db.urls = true
	else
		SetItemRef = PhanxChat.hooks.SetItemRef
		PhanxChat.hooks.SetItemRef = nil
		db.urls = false
	end
end)

------------------------------------------------------------------------

local fade = CreateSlider(frame, L["Chat fade time"], 0, 10, 1)
fade.hint = L["Set the time in minutes to keep chat messages visible before fading them out. Setting this to 0 will disable fading completely."]
fade:GetParent():SetPoint("TOPLEFT", urls, "BOTTOMLEFT", 0, -24)
fade:SetScript("OnValueChanged", function(self)
	local value = math.floor(self:GetValue() + 0.5)
	local frame
	if value > 0 then
		for i = 1, 7 do
			frame = _G["ChatFrame"..i]
			frame:SetFading(1)
			frame:SetFadeDuration(value)
		end
	else
		for i = 1, 7 do
			frame = _G["ChatFrame"..i]
			frame:SetFading(0)
		end
	end
	self.value:SetText(value)
	db.fade = value
end)
_G.PhanxChatFadeSlider = fade

------------------------------------------------------------------------

local font = CreateSlider(frame, L["Chat font size"], 6, 32, 1)
font.hint = L["Set the font size for all chat tabs at once. This is only a shortcut for doing the same thing for each tab using the default UI."]
font:GetParent():SetPoint("TOPLEFT", fade, "BOTTOMLEFT", 0, -24)
font:SetScript("OnValueChanged", function(self)
	local value = math.floor(self:GetValue() + 0.5)
	for i = 1, 7 do
		FCF_SetChatWindowFontSize(nil, _G["ChatFrame"..i], value)
	end
	self.value:SetText(value)
end)

------------------------------------------------------------------------

local clear = CreateFrame("Button", nil, frame)
clear:SetPoint("TOPLEFT", font, "BOTTOMLEFT", 0, -24)
clear:SetWidth(80)
clear:SetHeight(22)
clear:SetNormalFontObject(GameFontNormalSmall)
clear:SetDisabledFontObject(GameFontDisable)
clear:SetHighlightFontObject(GameFontHighlightSmall)
clear:SetNormalTexture("Interface\\Buttons\\UI-Panel-Button-Up")
clear:SetPushedTexture("Interface\\Buttons\\UI-Panel-Button-Down")
clear:SetHighlightTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
clear:SetDisabledTexture("Interface\\Buttons\\UI-Panel-Button-Disabled")
clear:GetNormalTexture():SetTexCoord(0, 0.625, 0, 0.6875)
clear:GetPushedTexture():SetTexCoord(0, 0.625, 0, 0.6875)
clear:GetHighlightTexture():SetTexCoord(0, 0.625, 0, 0.6875)
clear:GetDisabledTexture():SetTexCoord(0, 0.625, 0, 0.6875)
clear:GetHighlightTexture():SetBlendMode("ADD")
clear:SetScript("OnEnter", function(self)
	if self.hint then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(self.hint, nil, nil, nil, nil, true)
	end
end)
clear:SetScript("OnLeave", function()
	GameTooltip:Hide()
end)
clear:SetText(L["Clear chat"])
clear.hint = L["Clear the text from all chat frames at once. Note that text in frames that aren't currently visible may not be cleared right away, due to a Blizzard limitation."]
clear:SetScript("OnClick", function(self)
	for i = 1, 7 do
		_G["ChatFrame"..i]:Clear()
	end
end)

------------------------------------------------------------------------

panel:SetScript("OnShow", function(self)
	if not db then
		db = PhanxChatDB
	end

	cache.buttons = db.buttons
	cache.channels = db.channels
	cache.arrows = db.edit.arrows
	cache.edit = db.edit.move
	cache.flash = db.flash
	cache.log = db.log
	cache.names = db.names
	cache.scroll = db.scroll
	cache.notices = db.suppress.channels
	cache.repeats = db.suppress.repeats
	cache.sticky = db.sticky
	cache.tabs = db.tabs
	cache.urls = db.urls
	cache.fade = db.fade

	buttons:SetChecked(cache.buttons)
	channels:SetChecked(cache.channels)
	arrows:SetChecked(cache.arrows)
	edit:SetChecked(cache.edit)
	flash:SetChecked(cache.flash)
	log:SetChecked(cache.log)
	names:SetChecked(cache.names)
	scroll:SetChecked(cache.scroll)
	notices:SetChecked(cache.notices)
	repeats:SetChecked(cache.repeats)
	sticky:SetChecked(cache.sticky)
	tabs:SetChecked(cache.tabs)
	urls:SetChecked(cache.urls)

	fade:SetValue(cache.fade)
	fade.value:SetText(cache.fade)

	local size = math.floor(select(2, ChatFrame1:GetFont()) + 0.5)
	font:SetValue(size)
	font.value:SetText(size)

	shown = true
end)

------------------------------------------------------------------------

panel.okay = function()
	if shown then
		wipe(cache)
		wipe(changes)
		shown = false
	end
end

panel.cancel = function()
	if shown then
		if changed.buttons then
			local checked = buttons:GetChecked() and true or false
			if checked ~= cache.buttons then
				buttons:Click()
			end
		end
		if changed.channels then
		end
		if changed.arrows then
		end
		if changed.edit then
		end
		if changed.flash then
		end
		if changed.log then
		end
		if changed.names then
		end
		if changed.scroll then
		end
		if changed.notices then
		end
		if changed.repeats then
		end
		if changed.sticky then
		end
		if changed.tabs then
		end
		if changed.urls then
		end
		if changed.fade then
		end

		wipe(cache)
		wipe(changed)
		shown = false
	end
end

panel.defaults = function()
	buttons:SetChecked(db.buttons)
	channels:SetChecked(db.channels)
	arrows:SetChecked(db.edit.arrows)
	edit:SetChecked(db.edit.move)
	flash:SetChecked(db.flash)
	log:SetChecked(db.log)
	names:SetChecked(db.names)
	scroll:SetChecked(db.scroll)
	notices:SetChecked(db.suppress.channels)
	repeats:SetChecked(db.suppress.repeats)
	sticky:SetChecked(db.sticky)
	tabs:SetChecked(db.tabs)
	urls:SetChecked(db.urls)
	fade:SetValue(db.fade)
	font:SetValue(math.floor(select(2, ChatFrame1:GetFont()) + 0.5))
end

------------------------------------------------------------------------

InterfaceOptions_AddCategory(panel)

SLASH_PHANXCHAT1 = "/pchat"
SLASH_PHANXCHAT2 = "/phanxchat"
SlashCmdList.PHANXCHAT = function() InterfaceOptionsFrame_OpenToCategory(panel) end

------------------------------------------------------------------------