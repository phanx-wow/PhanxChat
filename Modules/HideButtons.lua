--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2018 Phanx <addons@phanx.net>. All rights reserved.
	https://www.wowinterface.com/downloads/info6323-PhanxChat.html
	https://www.curseforge.com/wow/addons/phanxchat
	https://github.com/phanx-wow/PhanxChat
----------------------------------------------------------------------]]

local _, PhanxChat = ...
local L = PhanxChat.L

local noop = function() end

------------------------------------------------------------------------

local function BottomButton_OnClick(self, button)
	PlaySound(SOUNDKIT.IG_CHAT_BOTTOM)
	local frame = self:GetParent()
	if frame.ScrollToBottom then
		frame:ScrollToBottom()
	else
		frame:GetParent():ScrollToBottom()
	end
	frame.ScrollToBottomButton:Hide()
end

local function ChatFrame_OnShow(self)
	if not PhanxChat.db.HideButtons then return end
	if self:AtBottom() then
		self.ScrollToBottomButton:Hide()
	else
		self.ScrollToBottomButton:Show()
	end
end

function PhanxChat:HideButtons(frame)
	local name = frame:GetName()
	local bottomButton = frame.ScrollToBottomButton
	local buttonFrame = _G[name .. "ButtonFrame"]
	frame:HookScript("OnShow", ChatFrame_OnShow)

	if self.db.HideButtons then
		buttonFrame.Show = noop
		buttonFrame:Hide()


		bottomButton:ClearAllPoints()
		bottomButton:SetParent(frame)
		bottomButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, -4)
		bottomButton:SetAlpha(0.75)
		bottomButton:Hide()

		if not self.hooks[bottomButton] then
			self.hooks[bottomButton] = { }
		end
		if not self.hooks[bottomButton].OnClick then
			self.hooks[bottomButton].OnClick = bottomButton:GetScript("OnClick")
			bottomButton:SetScript("OnClick", BottomButton_OnClick)
		end
	else
		buttonFrame.Show = nil
		buttonFrame:Show()
		bottomButton:ClearAllPoints()
		bottomButton:SetParent(buttonFrame)
		bottomButton:SetPoint("BOTTOM", buttonFrame, "BOTTOM", 0, -7)
		bottomButton:SetAlpha(1)
		bottomButton:Show()

		if self.hooks[bottomButton] and self.hooks[bottomButton].OnClick then
			bottomButton:SetScript("OnClick", self.hooks[bottomButton].OnClick)
			self.hooks[bottomButton].OnClick = nil
		end

		FCF_UpdateButtonSide(frame)
	end
end

------------------------------------------------------------------------

function PhanxChat:SetHideButtons(v)
	if self.debug then print("PhanxChat: SetHideButtons", v) end
	if type(v) == "boolean" then
		self.db.HideButtons = v
	end

	for frame in pairs(self.frames) do
		self:HideButtons(frame)
	end

	if self.db.HideButtons then
		ChatFrameMenuButton:SetScript("OnShow", ChatFrameMenuButton.Hide)
		ChatFrameMenuButton:Hide()

		QuickJoinToastButton:SetScript("OnShow", QuickJoinToastButton.Hide)
		QuickJoinToastButton:Hide()
	elseif not self.isLoading then
		ChatFrameMenuButton:SetScript("OnShow", nil)
		ChatFrameMenuButton:Show()

		QuickJoinToastButton:SetScript("OnShow", nil)
		QuickJoinToastButton:Show()
	end
end

BNToastFrame:SetClampedToScreen(true)

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetHideButtons)
table.insert(PhanxChat.RunOnProcessFrame, PhanxChat.HideButtons)
