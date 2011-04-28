--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2006–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx
----------------------------------------------------------------------]]

local PHANXCHAT, PhanxChat = ...

local panel = LibStub( "PhanxConfig-OptionsPanel" ).CreateOptionsPanel( PHANXCHAT, nil, function( self )
	local L = PhanxChat.L
	local db = PhanxChat.db

	self.CreateCheckbox = LibStub( "PhanxConfig-Checkbox" ).CreateCheckbox
	self.CreateDropdown = LibStub( "PhanxConfig-Dropdown" ).CreateDropdown
	self.CreateSlider = LibStub( "PhanxConfig-Slider" ).CreateSlider

	local title, notes = LibStub( "PhanxConfig-Header" ).CreateHeader( self, self.name, GetAddOnMetadata( PHANXCHAT, "Notes" ) )

	--------------------------------------------------------------------

	local ShortenChannelNames = self:CreateCheckbox(L["Short channel names"])
	ShortenChannelNames.desc = L["Shorten channel names and chat strings."]
	ShortenChannelNames:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", -2, -12)
	ShortenChannelNames:SetChecked(db.ShortenChannelNames)
	ShortenChannelNames.OnClick = function(self, checked)
		if PhanxChat.debug then print("PhanxChat: ShortenChannelNames", checked) end
		PhanxChat:SetShortenChannelNames(checked)
	end

	--------------------------------------------------------------------

	local ShortenPlayerNames = self:CreateCheckbox(L["Short player names"])
	ShortenPlayerNames.desc = L["Shorten player names by removing realm names and Real ID last names."]
	ShortenPlayerNames:SetPoint("TOPLEFT", ShortenChannelNames, "BOTTOMLEFT", 0, -8)
	ShortenPlayerNames:SetChecked(db.ShortenPlayerNames)
	ShortenPlayerNames.OnClick = function(self, checked)
		if PhanxChat.debug then print("PhanxChat: ShortenPlayerNames", checked) end
		db.ShortenPlayerNames = checked
	end

	--------------------------------------------------------------------

	local ReplaceRealNames = self:CreateCheckbox(L["Replace real names"])
	ReplaceRealNames.desc = L["Replace Real ID names with character names."]
	ReplaceRealNames:SetPoint("TOPLEFT", ShortenPlayerNames, "BOTTOMLEFT", 0, -8)
	ReplaceRealNames:SetChecked(db.ReplaceRealNames)
	ReplaceRealNames.OnClick = function(self, checked)
		if PhanxChat.debug then print("PhanxChat: ReplaceRealNames", checked) end
		PhanxChat:SetReplaceRealNames(checked)
	end

	--------------------------------------------------------------------

	local EnableArrows = self:CreateCheckbox(L["Enable arrow keys"])
	EnableArrows.desc = L["Enable arrow keys in the chat edit box."]
	EnableArrows:SetPoint("TOPLEFT", ReplaceRealNames, "BOTTOMLEFT", 0, -8)
	EnableArrows:SetChecked(db.EnableArrows)
	EnableArrows.OnClick = function(self, checked)
		PhanxChat:SetEnableArrows(checked)
	end

	--------------------------------------------------------------------

	local EnableResizeEdges = self:CreateCheckbox(L["Enable resize edges"])
	EnableResizeEdges.desc = L["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."]
	EnableResizeEdges:SetPoint("TOPLEFT", EnableArrows, "BOTTOMLEFT", 0, -8)
	EnableResizeEdges:SetChecked(db.EnableResizeEdges)
	EnableResizeEdges.OnClick = function(self, checked)
		PhanxChat:SetEnableResizeEdges(checked)
	end

	--------------------------------------------------------------------

	local LinkURLs = self:CreateCheckbox(L["Link URLs"])
	LinkURLs.desc = L["Transform URLs in chat into clickable links for easy copying."]
	LinkURLs:SetPoint("TOPLEFT", EnableResizeEdges, "BOTTOMLEFT", 0, -8)
	LinkURLs:SetChecked(db.LinkURLs)
	LinkURLs.OnClick = function(self, checked)
		PhanxChat:SetLinkURLs(checked)
	end

	--------------------------------------------------------------------

	local LockTabs = self:CreateCheckbox(L["Lock docked tabs"])
	LockTabs.desc = L["Prevent docked chat tabs from being dragged unless the Shift key is down."]
	LockTabs:SetPoint("TOPLEFT", LinkURLs, "BOTTOMLEFT", 0, -8)
	LockTabs:SetChecked(db.LockTabs)
	LockTabs.OnClick = function(self, checked)
		PhanxChat:SetLockTabs(checked)
	end

	--------------------------------------------------------------------

	local MoveEditBox = self:CreateCheckbox(L["Move edit boxes"])
	MoveEditBox.desc = L["Move chat edit boxes to the top their respective chat frame."]
	MoveEditBox:SetPoint("TOPLEFT", LockTabs, "BOTTOMLEFT", 0, -8)
	MoveEditBox:SetChecked(db.MoveEditBox)
	MoveEditBox.OnClick = function(self, checked)
		PhanxChat:SetMoveEditBox(checked)
	end

	--------------------------------------------------------------------

	local HideNotices = self:CreateCheckbox(L["Hide notices"])
	HideNotices.desc = L["Hide channel notification messages."]
	HideNotices:SetPoint("TOPLEFT", MoveEditBox, "BOTTOMLEFT", 0, -8)
	HideNotices:SetChecked(db.HideNotices)
	HideNotices.OnClick = function(self, checked)
		PhanxChat:SetHideNotices(checked)
	end

	--------------------------------------------------------------------

	local HideRepeats = self:CreateCheckbox(L["Hide repeats"])
	HideRepeats.desc = L["Hide repeated messages in public channels."]
	HideRepeats:SetPoint("TOPLEFT", HideNotices, "BOTTOMLEFT", 0, -8)
	HideRepeats:SetChecked(db.HideRepeats)
	HideRepeats.OnClick = function(self, checked)
		PhanxChat:SetHideRepeats(checked)
	end

	--------------------------------------------------------------------
	--------------------------------------------------------------------

	local HideButtons = self:CreateCheckbox(L["Hide buttons"])
	HideButtons.desc = L["Hide the chat frame menu and scroll buttons."]
	HideButtons:SetPoint("TOPLEFT", notes, "BOTTOM", 2, -12)
	HideButtons:SetChecked(db.HideButtons)
	HideButtons.OnClick = function(self, checked)
		PhanxChat:SetHideButtons(checked)
	end

	--------------------------------------------------------------------

	local HideTextures = self:CreateCheckbox(L["Hide extra textures"])
	HideTextures.desc = L["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."]
	HideTextures:SetPoint("TOPLEFT", HideButtons, "BOTTOMLEFT", 0, -8)
	HideTextures:SetChecked(db.HideTextures)
	HideTextures.OnClick = function(self, checked)
		PhanxChat:SetHideTextures(checked)
	end

	--------------------------------------------------------------------

	local HideFlash = self:CreateCheckbox(L["Hide tab flash"])
	HideFlash.desc = L["Disable the flashing effect on chat tabs that receive new messages."]
	HideFlash:SetPoint("TOPLEFT", HideTextures, "BOTTOMLEFT", 0, -8)
	HideFlash:SetChecked(db.HideFlash)
	HideFlash.OnClick = function(self, checked)
		PhanxChat:SetHideFlash(checked)
	end

	--------------------------------------------------------------------

	local stickyValues = {
		["ALL"] = L["All"],
		["BLIZZARD"] = L["Default"],
		["NONE"] = L["None"],
	}
	local EnableSticky
	do
		local function OnClick(self)
			PhanxChat:SetEnableSticky(self.value)
			EnableSticky:SetValue(self.value, self.text)
		end

		local info = { } -- UIDropDownMenu_CreateInfo()

		EnableSticky = self:CreateDropdown(L["Sticky chat"], function()
			local selected = db.EnableSticky

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
	end
	EnableSticky.desc = L["Set which chat types should be sticky."]
	EnableSticky:SetPoint("TOPLEFT", HideFlash, "BOTTOMLEFT", 0, -14)
	EnableSticky:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", -2, -18 - ((HideFlash:GetHeight() + 8) * 3))
	EnableSticky:SetValue(db.EnableSticky, stickyValues[db.EnableSticky])

	--------------------------------------------------------------------

	local FadeTime = self:CreateSlider(L["Fade time"], 0, 10, 1)
	FadeTime.desc = L["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."]
	FadeTime:SetPoint("TOPLEFT", EnableSticky, "BOTTOMLEFT", 0, -12)
	FadeTime:SetPoint("TOPRIGHT", EnableSticky, "BOTTOMRIGHT", 0, -12)
	FadeTime:SetValue(db.FadeTime)
	FadeTime.OnValueChanged = function(self, value)
		value = math.floor(value + 0.5)
		PhanxChat:SetFadeTime(value)
		return value
	end

	--------------------------------------------------------------------

	local FontSize = self:CreateSlider(L["Font size"], 8, 24, 1)
	FontSize.desc = L["Set the font size for all chat frames."] .. "\n\n" .. L["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."]
	FontSize:SetPoint("TOPLEFT", FadeTime, "BOTTOMLEFT", 0, -10)
	FontSize:SetPoint("TOPRIGHT", FadeTime, "BOTTOMRIGHT", 0, -10)
	FontSize:SetValue(math.floor(select(2, ChatFrame1:GetFont()) + 0.5))
	FontSize.OnValueChanged = function(self, value)
		for frame in pairs(PhanxChat.frames) do
			FCF_SetChatWindowFontSize(nil, frame, value)
		end
	end

	--------------------------------------------------------------------

	self.refresh = function( self )
		HideFlash:SetChecked(db.HideFlash)
		EnableArrows:SetChecked(db.EnableArrows)
		EnableResizeEdges:SetChecked(db.EnableResizeEdges)
		HideButtons:SetChecked(db.HideButtons)
		HideTextures:SetChecked(db.HideTextures)
		LinkURLs:SetChecked(db.LinkURLs)
		LockTabs:SetChecked(db.LockTabs)
		MoveEditBox:SetChecked(db.MoveEditBox)
		ShortenChannelNames:SetChecked(db.ShortenChannelNames)
		ShortenPlayerNames:SetChecked(db.ShortenPlayerNames)
		EnableSticky:SetValue(db.EnableSticky, stickyValues[db.EnableSticky])
		FadeTime:SetValue(db.FadeTime)
		FontSize:SetValue(math.floor(select(2, ChatFrame1:GetFont()) + 0.5))
		HideNotices:SetChecked(db.HideNotices)
		HideRepeats:SetChecked(db.HideRepeats)
	end
end )

LibStub("LibAboutPanel").new(PHANXCHAT, PHANXCHAT)

------------------------------------------------------------------------
--	Slash command
------------------------------------------------------------------------

SLASH_PHANXCHAT1 = "/pchat"
SlashCmdList.PHANXCHAT = function(v)
	if v and v == "clear" then
		for i = 1, NUM_CHAT_WINDOWS do
			_G[("ChatFrame%d"):format(i)]:Clear()
		end
	else
		InterfaceOptionsFrame_OpenToCategory(panel)
	end
end

------------------------------------------------------------------------