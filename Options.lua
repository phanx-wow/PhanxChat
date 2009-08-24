--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and improves chat frame usability.
	By Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	Copyright ©2006–2009 Alyssa "Phanx" Kinley
	See README for license terms and other information.

	This file provides a configuration GUI for PhanxChat.
----------------------------------------------------------------------]]

if not PhanxChat then return end

local Options = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
Options.name = GetAddOnMetadata("PhanxChat", "Title")
Options:Hide()

Options:SetScript("OnShow", function(self)
	local PhanxChat = PhanxChat
	local db = PhanxChatDB
	local L = PhanxChat.L

	local noop = function() return end

	-------------------------------------------------------------------

	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetPoint("TOPRIGHT", -16, -16)
	title:SetJustifyH("LEFT")
	title:SetText(self.name)

	local notes = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	notes:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	notes:SetPoint("TOPRIGHT", title, "BOTTOMRIGHT", 0, -8)
	notes:SetHeight(48)
	notes:SetJustifyH("LEFT")
	notes:SetJustifyV("TOP")
	notes:SetNonSpaceWrap(true)
	notes:SetText(L["PhanxChat is a chat frame modification addon to help reduce chat frame clutter and improve chat frame usability. Use this panel to configure the addon's appearance and behavior."])

	-------------------------------------------------------------------

	self.CreateCheckbox = LibStub:GetLibrary("PhanxConfig-Checkbox").CreateCheckbox
	self.CreateSlider = LibStub:GetLibrary("PhanxConfig-Slider").CreateSlider

	-------------------------------------------------------------------

	local buttons = self:CreateCheckbox(L["Hide buttons"])
	buttons.hint = L["Hide the scroll-up, scroll-down, scroll-to-bottom, and menu buttons next to the chat frame."]
	buttons:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", -2, -8)
	buttons:SetChecked(db.buttons)
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
	end)

	-------------------------------------------------------------------

	local channels = self:CreateCheckbox(L["Shorten channels"])
	channels.hint = L["Shorten channel names in chat messages. For example, '[1. General]' might be shortened to '1|'."]
	channels:SetPoint("TOPLEFT", buttons, "BOTTOMLEFT", 0, -8)
	channels:SetChecked(db.channels)
	channels:SetScript("OnClick", function(self)
		local checked = self:GetChecked() and true or false
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

		if checked then
			for k, v in pairs(PhanxChat.newstrings) do
				PhanxChat.oldstrings[k] = _G[k]
				_G[k] = v
			end

			PhanxChat:BuildChannelList(GetChannelList())

			db.channels = true
		else
			for k, v in pairs(PhanxChat.oldstrings) do
				_G[k] = v
				PhanxChat.oldstrings[k] = nil
			end

			for k in pairs(PhanxChat.channels) do
				PhanxChat.channels[k] = nil
			end

			db.channels = false
		end
	end)

	-------------------------------------------------------------------

	local arrows = self:CreateCheckbox(L["Enable arrow keys"])
	arrows.hint = L["Enable the arrow keys in the chat edit box."]
	arrows:SetPoint("TOPLEFT", channels, "BOTTOMLEFT", 0, -8)
	arrows:SetChecked(db.edit.arrows)
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

	-------------------------------------------------------------------

	local edit = self:CreateCheckbox(L["Move chat edit box"])
	edit.hint = L["Move the chat edit box to the top of the chat frame."]
	edit:SetPoint("TOPLEFT", arrows, "BOTTOMLEFT", 0, -8)
	edit:SetChecked(db.edit.move)
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

	-------------------------------------------------------------------

	local flash = self:CreateCheckbox(L["Disable tab flashing"])
	flash.hint = L["Disable the flashing effect on chat tabs when new messages are received."]
	flash:SetPoint("TOPLEFT", edit, "BOTTOMLEFT", 0, -8)
	flash:SetChecked(db.flash)
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

	-------------------------------------------------------------------

	local log = self:CreateCheckbox(L["Auto-start logging"])
	log.hint = L["Automatically enable chat logging when you log in. Chat logging can be started or stopped manually at any time using the '/chatlog' command. Logs are saved when you log out or exit the game to the 'World of Warcraft/Logs/WoWChatLog.txt' file."]
	log:SetPoint("TOPLEFT", flash, "BOTTOMLEFT", 0, -8)
	log:SetChecked(db.log)
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

	-------------------------------------------------------------------

	local names = self:CreateCheckbox(L["Color player names"])
	names.hint = L["Color player names in chat by their class if known. Classes are known if you have seen the player in your group, in your guild, online on your friends list, in a '/who' query, or have targetted or moused over them since you logged in."]
	names:SetPoint("TOPLEFT", log, "BOTTOMLEFT", 0, -8)
	names:SetChecked(db.names)
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

	-------------------------------------------------------------------

	local scroll = self:CreateCheckbox(L["Mousewheel scrolling"])
	scroll.hint = L["Enable scrolling through chat frames with the mouse wheel. Hold the Shift key while scrolling to jump to the top or bottom of the chat frame."]
	scroll:SetPoint("TOPLEFT", notes, "BOTTOM", 8, -8)
	scroll:SetChecked(db.scroll)
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

	-------------------------------------------------------------------

	local sticky = self:CreateCheckbox(L["Sticky channels"])
	sticky.hint = L["Enable sticky channel behavior for all chat types except emotes."]
	sticky:SetPoint("TOPLEFT", scroll, "BOTTOMLEFT", 0, -8)
	sticky:SetChecked(db.sticky)
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

	-------------------------------------------------------------------

	local notices = self:CreateCheckbox(L["Suppress notifications"])
	notices.hint = L["Suppress the notification messages informing you when someone leaves or joins a channel, or when channel ownership changes."]
	notices:SetPoint("TOPLEFT", sticky, "BOTTOMLEFT", 0, -8)
	notices:SetChecked(db.suppress.notices)
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

	-------------------------------------------------------------------

	local repeats = self:CreateCheckbox(L["Suppress repeats"])
	repeats.hint = L["Suppress repeated messages in public chat channels."]
	repeats:SetPoint("TOPLEFT", notices, "BOTTOMLEFT", 0, -8)
	repeats:SetChecked(db.suppress.repeats)
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

	-------------------------------------------------------------------

	local tabs = self:CreateCheckbox(L["Lock tabs"])
	tabs.hint = L["Prevent docked chat tabs from being dragged unless the Alt key is down."]
	tabs:SetPoint("TOPLEFT", repeats, "BOTTOMLEFT", 0, -8)
	tabs:SetChecked(db.tabs)
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

	-------------------------------------------------------------------

	local urls = self:CreateCheckbox(L["Link URLs"])
	urls.hint = L["Turn URLs in chat messages into clickable links for easy copying."]
	urls:SetPoint("TOPLEFT", tabs, "BOTTOMLEFT", 0, -8)
	urls:SetChecked(db.urls)
	urls:SetScript("OnClick", function(self)
		local checked = self:GetChecked() and true or false
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

		if checked then
			for event in pairs(PhanxChat.urlEvents) do
				ChatFrame_AddMessageEventFilter(event, PhanxChat.LinkURLs)
			end
			PhanxChat.hooks.SetItemRef = SetItemRef
			SetItemRef = PhanxChat.SetItemRef
			db.urls = true
		else
			for event in pairs(PhanxChat.urlEvents) do
				ChatFrame_RemoveMessageEventFilter(event, PhanxChat.LinkURLs)
			end
			SetItemRef = PhanxChat.hooks.SetItemRef
			PhanxChat.hooks.SetItemRef = nil
			db.urls = false
		end
	end)

	-------------------------------------------------------------------

	local fade = self:CreateSlider(L["Chat fade time"], 0, 10, 1)
	fade.hint = L["Set the time in minutes to keep chat messages visible before fading them out. Setting this to 0 will disable fading completely."]
	fade.container:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", 0, -(buttons:GetHeight() + 8) * 7 - 12)
	fade.container:SetPoint("TOPRIGHT", notes, "BOTTOM", -12, -(buttons:GetHeight() + 8) * 7 - 12)
	fade.value:SetText(db.fade)
	fade:SetValue(db.fade)
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

	-------------------------------------------------------------------

	local fontsize = math.floor(select(2, ChatFrame1:GetFont()) + 0.5)

	local font = self:CreateSlider(L["Chat font size"], 6, 32, 1)
	font.hint = L["Set the font size for all chat tabs at once. This is only a shortcut for doing the same thing for each tab using the default UI."]
	font.container:SetPoint("TOPLEFT", notes, "BOTTOM", 12, -(buttons:GetHeight() + 8) * 7 - 12)
	font.container:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", -(buttons:GetHeight() + 8) * 7 - 12)
	font.value:SetText(fontsize)
	font:SetValue(fontsize)
	font:SetScript("OnValueChanged", function(self)
		local value = math.floor(self:GetValue() + 0.5)
		for i = 1, 7 do
			FCF_SetChatWindowFontSize(nil, _G["ChatFrame"..i], value)
		end
		self.value:SetText(value)
	end)

	-------------------------------------------------------------------

	function self.refresh()
		buttons:SetChecked(db.buttons)
		channels:SetChecked(db.channels)
		arrows:SetChecked(db.edit.arrows)
		edit:SetChecked(db.edit)
		flash:SetChecked(db.flash)
		log:SetChecked(db.log)
		names:SetChecked(db.names)
		scroll:SetChecked(db.scroll)
		notices:SetChecked(db.suppress.notices)
		repeats:SetChecked(db.suppress.repeats)
		sticky:SetChecked(db.sticky)
		tabs:SetChecked(db.tabs)
		urls:SetChecked(db.urls)

		fade:SetValue(db.fade)
		fade.value:SetText(db.fade)

		local size = math.floor(select(2, ChatFrame1:GetFont()) + 0.5)
		font:SetValue(size)
		font.value:SetText(size)
	end

	self:SetScript("OnShow", nil)
end)

------------------------------------------------------------------------

InterfaceOptions_AddCategory(Options)

------------------------------------------------------------------------

LibStub:GetLibrary("LibAboutPanel").new(Options.name, "PhanxChat")

------------------------------------------------------------------------

SLASH_PHANXCHAT1 = "/pchat"
SLASH_PHANXCHAT2 = "/phanxchat"
SlashCmdList.PHANXCHAT = function(cmd)
	if cmd and cmd == "clear" then
		for i = 1, 7 do
			_G["ChatFrame"..i]:Clear()
		end
	else
		InterfaceOptionsFrame_OpenToCategory(Options)
	end
end

------------------------------------------------------------------------