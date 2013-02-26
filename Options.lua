--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
----------------------------------------------------------------------]]

local PHANXCHAT, PhanxChat = ...

local panel = LibStub("PhanxConfig-OptionsPanel").CreateOptionsPanel(PHANXCHAT, nil, function(self)
	local L = PhanxChat.L
	local db = PhanxChat.db

	self.CreateCheckbox = LibStub("PhanxConfig-Checkbox").CreateCheckbox
	self.CreateDropdown = LibStub("PhanxConfig-Dropdown").CreateDropdown
	self.CreateSlider = LibStub("PhanxConfig-Slider").CreateSlider

	local title, notes = LibStub("PhanxConfig-Header").CreateHeader(self, self.name, GetAddOnMetadata(PHANXCHAT, "Notes"))

	--------------------------------------------------------------------

	local ShortenChannelNames = self:CreateCheckbox(L.ShortenChannelNames, L.ShortenChannelNames_Desc)
	ShortenChannelNames:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", -2, -12)
	ShortenChannelNames.OnValueChanged = function(self, value)
		if PhanxChat.debug then print("PhanxChat: ShortenChannelNames", checked) end
		PhanxChat:SetShortenChannelNames(checked)
	end

	--------------------------------------------------------------------

	local ShortenPlayerNames = self:CreateCheckbox(L.ShortenPlayerNames, L.ShortenPlayerNames_Desc)
	ShortenPlayerNames:SetPoint("TOPLEFT", ShortenChannelNames, "BOTTOMLEFT", 0, -8)
	ShortenPlayerNames.OnValueChanged = function(self, value)
		if PhanxChat.debug then print("PhanxChat: ShortenPlayerNames", checked) end
		db.ShortenPlayerNames = value
	end

	--------------------------------------------------------------------

	local ReplaceRealNames = self:CreateCheckbox(L.ReplaceRealNames, L.ReplaceRealNames_Desc)
	ReplaceRealNames:SetPoint("TOPLEFT", ShortenPlayerNames, "BOTTOMLEFT", 0, -8)
	ReplaceRealNames.OnValueChanged = function(self, value)
		if PhanxChat.debug then print("PhanxChat: ReplaceRealNames", checked) end
		PhanxChat:SetReplaceRealNames(checked)
	end

	--------------------------------------------------------------------

	local bnetValues = {
		BATTLETAG = L.ShortenRealNames_UseBattleTag,
		FIRSTNAME = L.ShortenRealNames_UseFirstName,
		FULLNAME = L.ShortenRealNames_UseFullName,
	}
	local ShortenRealNames
	do
		local function OnValueChanged(self)
			if PhanxChat.debug then print("PhanxChat: ShortenRealNames", self.value) end
			PhanxChat:SetReplaceRealNames(self.value)
			ShortenRealNames:SetValue(self.value, self.text or bnetValues[self.value])
		end

		ShortenRealNames = self:CreateDropdown(L.ShortenRealNames, L.ShortenRealNames_Desc, function()
			local info = UIDropDownMenu_CreateInfo()
			local selected = db.ShortenRealNames

			info.text = L["Replace with BattleTag"]
			info.value = "BATTLETAG"
			info.func = OnValueChanged
			info.checked = "BATTLETAG" == selected
			UIDropDownMenu_AddButton(info)

			info.text = L["Show first name only"]
			info.value = "FIRSTNAME"
			info.func = OnValueChanged
			info.checked = "FIRSTNAME" == selected
			UIDropDownMenu_AddButton(info)

			info.text = L["Keep full name"]
			info.value = "FULLNAME"
			info.func = OnValueChanged
			info.checked = "FULLNAME" == selected
			UIDropDownMenu_AddButton(info)
		end)
	end
	ShortenRealNames:SetPoint("TOPLEFT", ReplaceRealNames, "BOTTOMLEFT", 0, -8)
	ShortenRealNames:SetPoint("TOPRIGHT", notes, "BOTTOM", -8, -24 - (ReplaceRealNames:GetHeight() * 3))

	--------------------------------------------------------------------

	local EnableArrows = self:CreateCheckbox(L.EnableArrows, L.EnableArrows_Desc)
	EnableArrows:SetPoint("TOPLEFT", ShortenRealNames, "BOTTOMLEFT", 0, -8)
	EnableArrows.OnValueChanged = function(self, value)
		if PhanxChat.debug then print("PhanxChat: EnableArrows", checked) end
		PhanxChat:SetEnableArrows(checked)
	end

	--------------------------------------------------------------------

	local EnableResizeEdges = self:CreateCheckbox(L.EnableResizeEdges, L.EnableResizeEdges_Desc)
	EnableResizeEdges:SetPoint("TOPLEFT", EnableArrows, "BOTTOMLEFT", 0, -8)
	EnableResizeEdges.OnValueChanged = function(self, value)
		if PhanxChat.debug then print("PhanxChat: SetEnableResizeEdges", checked) end
		PhanxChat:SetEnableResizeEdges(checked)
	end

	--------------------------------------------------------------------

	local LinkURLs = self:CreateCheckbox(L.LinkURLs, L.LinkURLs_Desc)
	LinkURLs:SetPoint("TOPLEFT", EnableResizeEdges, "BOTTOMLEFT", 0, -8)
	LinkURLs.OnValueChanged = function(self, value)
		if PhanxChat.debug then print("PhanxChat: SetLinkURLs", checked) end
		PhanxChat:SetLinkURLs(checked)
	end

	--------------------------------------------------------------------

	local LockTabs = self:CreateCheckbox(L.LockTabs, L.LockTabs_Desc)
	LockTabs:SetPoint("TOPLEFT", LinkURLs, "BOTTOMLEFT", 0, -8)
	LockTabs.OnValueChanged = function(self, value)
		if PhanxChat.debug then print("PhanxChat: SetLockTabs", checked) end
		PhanxChat:SetLockTabs(checked)
	end

	--------------------------------------------------------------------

	local MoveEditBox = self:CreateCheckbox(L.MoveEditBox, L.MoveEditBox_Desc)
	MoveEditBox:SetPoint("TOPLEFT", LockTabs, "BOTTOMLEFT", 0, -8)
	MoveEditBox.OnValueChanged = function(self, value)
		if PhanxChat.debug then print("PhanxChat: SetMoveEditBox", checked) end
		PhanxChat:SetMoveEditBox(checked)
	end

	--------------------------------------------------------------------

	local HideNotices = self:CreateCheckbox(L.HideNotices, L.HideNotices_Desc)
	HideNotices:SetPoint("TOPLEFT", MoveEditBox, "BOTTOMLEFT", 0, -8)
	HideNotices.OnValueChanged = function(self, value)
		if PhanxChat.debug then print("PhanxChat: SetHideNotices", checked) end
		PhanxChat:SetHideNotices(checked)
	end

	--------------------------------------------------------------------

	local HideRepeats = self:CreateCheckbox(L.HideRepeats, L.HideRepeats_Desc)
	HideRepeats:SetPoint("TOPLEFT", HideNotices, "BOTTOMLEFT", 0, -8)
	HideRepeats.OnValueChanged = function(self, value)
		if PhanxChat.debug then print("PhanxChat: SetHideRepeats", checked) end
		PhanxChat:SetHideRepeats(checked)
	end

	--------------------------------------------------------------------

	local HideButtons = self:CreateCheckbox(L.HideButtons, L.HideButtons_Desc)
	HideButtons:SetPoint("TOPLEFT", notes, "BOTTOM", 2, -12)
	HideButtons.OnValueChanged = function(self, value)
		if PhanxChat.debug then print("PhanxChat: SetHideButtons", checked) end
		PhanxChat:SetHideButtons(checked)
	end

	--------------------------------------------------------------------

	local HideTextures = self:CreateCheckbox(L.HideTextures, L.HideTextures_Desc)
	HideTextures:SetPoint("TOPLEFT", HideButtons, "BOTTOMLEFT", 0, -8)
	HideTextures.OnValueChanged = function(self, value)
		if PhanxChat.debug then print("PhanxChat: SetHideTextures", checked) end
		PhanxChat:SetHideTextures(checked)
	end

	--------------------------------------------------------------------

	local HideFlash = self:CreateCheckbox(L.HideFlash, L.HideFlash_Desc)
	HideFlash:SetPoint("TOPLEFT", HideTextures, "BOTTOMLEFT", 0, -8)
	HideFlash.OnValueChanged = function(self, value)
		if PhanxChat.debug then print("PhanxChat: SetHideFlash", checked) end
		PhanxChat:SetHideFlash(checked)
	end

	--------------------------------------------------------------------

	local ShowClassColors = self:CreateCheckbox(L.ShowClassColors, L.ShowClassColors_Desc)
	ShowClassColors:SetPoint("TOPLEFT", HideFlash, "BOTTOMLEFT", 0, -8)
	ShowClassColors.OnValueChanged = function(self, value)
		if PhanxChat.debug then print("PhanxChat: SetShowClassColors", checked) end
		PhanxChat:SetShowClassColors(checked)
	end

	--------------------------------------------------------------------

	local stickyValues = {
		ALL = L.All,
		BLIZZARD = L.Default,
		NONE = L.None,
	}
	local EnableSticky
	do
		local function OnValueChanged(self)
			if PhanxChat.debug then print("PhanxChat: SetEnableSticky", self.value) end
			PhanxChat:SetEnableSticky(self.value)
			EnableSticky:SetValue(self.value, self.text)
		end

		EnableSticky = self:CreateDropdown(L.EnableSticky, L.EnableSticky_Desc function()
			local info = UIDropDownMenu_CreateInfo()
			local selected = db.EnableSticky

			info.text = L.All
			info.value = "ALL"
			info.func = OnValueChanged
			info.checked = "ALL" == selected
			UIDropDownMenu_AddButton(info)

			info.text = L.Default
			info.value = "BLIZZARD"
			info.func = OnValueChanged
			info.checked = "BLIZZARD" == selected
			UIDropDownMenu_AddButton(info)

			info.text = L.None
			info.value = "NONE"
			info.func = OnValueChanged
			info.checked = "NONE" == selected
			UIDropDownMenu_AddButton(info)
		end)
	end
	EnableSticky:SetPoint("TOPLEFT", ShowClassColors, "BOTTOMLEFT", 0, -14)
	EnableSticky:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", -2, -18 - ((ShowClassColors:GetHeight() + 8) * 4))

	--------------------------------------------------------------------

	local FadeTime = self:CreateSlider(L.FadeTime, L.FadeTime_Desc, 0, 10, 1)
	FadeTime:SetPoint("TOPLEFT", EnableSticky, "BOTTOMLEFT", 0, -12)
	FadeTime:SetPoint("TOPRIGHT", EnableSticky, "BOTTOMRIGHT", 0, -12)
	FadeTime.OnValueChanged = function(self, value)
		value = math.floor(value + 0.5)
		if PhanxChat.debug then print("PhanxChat: SetFadeTime", value) end
		PhanxChat:SetFadeTime(value)
		return value
	end

	--------------------------------------------------------------------

	local FontSize = self:CreateSlider(L.FontSize, L.FontSize_Desc .. "\n\n" .. L.FontSize_Note, 8, 24, 1)
	FontSize:SetPoint("TOPLEFT", FadeTime, "BOTTOMLEFT", 0, -10)
	FontSize:SetPoint("TOPRIGHT", FadeTime, "BOTTOMRIGHT", 0, -10)
	FontSize.OnValueChanged = function(self, value)
		if PhanxChat.debug then print("PhanxChat: FCF_SetChatWindowFontSize", value) end
		db.FontSize = value
		for frame in pairs(PhanxChat.frames) do
			FCF_SetChatWindowFontSize(nil, frame, value)
		end
	end

	--------------------------------------------------------------------

	self.refresh = function(self)
		ShortenChannelNames:SetChecked(db.ShortenChannelNames)
		RemoveServerNames:SetChecked(db.RemoveServerNames)
		ReplaceRealNames:SetChecked(db.ReplaceRealNames)
		ShortenRealNames:SetValue(db.ShortenRealNames, bnetValues[db.ShortenRealNames])
		EnableArrows:SetChecked(db.EnableArrows)
		EnableResizeEdges:SetChecked(db.EnableResizeEdges)
		LinkURLs:SetChecked(db.LinkURLs)
		LockTabs:SetChecked(db.LockTabs)
		MoveEditBox:SetChecked(db.MoveEditBox)
		HideNotices:SetChecked(db.HideNotices)
		HideRepeats:SetChecked(db.HideRepeats)

		HideButtons:SetChecked(db.HideButtons)
		HideTextures:SetChecked(db.HideTextures)
		HideFlash:SetChecked(db.HideFlash)
		EnableSticky:SetValue(db.EnableSticky, stickyValues[db.EnableSticky])
		FadeTime:SetValue(db.FadeTime)
		FontSize:SetValue(db.FontSize or floor(select(2, ChatFrame1:GetFont()) + 0.5))
		ShowClassColors:SetChecked(db.ShowClassColors)
	end

	self:refresh()
end)

LibStub("LibAboutPanel").new(PHANXCHAT, PHANXCHAT)

------------------------------------------------------------------------
--	Slash command
------------------------------------------------------------------------

SLASH_PHANXCHAT1 = "/pchat"
SlashCmdList.PHANXCHAT = function(v)
	if v == "clear" then
		for i = 1, NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i]:Clear()
		end
	else
		InterfaceOptionsFrame_OpenToCategory(panel)
	end
end