--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
----------------------------------------------------------------------]]

local _, PhanxChat = ...
local L = PhanxChat.L

function PhanxChat:MoveEditBox(frame)
	local editBox = frame.editBox or _G[frame:GetName() .. "EditBox"]
	if not editBox then return end

	if self.db.MoveEditBox then
		editBox:ClearAllPoints()
		editBox:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", -5, 2)
		editBox:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 5, 2)

		if not InterfaceOptionsSocialPanelChatStyle.orig_tooltip then
			SetCVar("chatStyle", "classic")
			InterfaceOptionsSocialPanelChatStyle_SetChatStyle("classic")
			InterfaceOptionsSocialPanelChatStyleButton:Disable()
			InterfaceOptionsSocialPanelChatStyleText:SetAlpha(0.5)
			InterfaceOptionsSocialPanelChatStyle.orig_tooltip = InterfaceOptionsSocialPanelChatStyle
			InterfaceOptionsSocialPanelChatStyle.tooltip = format(L.OptionLockedConditional, L.MoveEditBox)
		end
	else
		editBox:ClearAllPoints()
		editBox:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", -5, -2)
		editBox:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", 5, -2)

		if InterfaceOptionsSocialPanelChatStyle.orig_tooltip then
			InterfaceOptionsSocialPanelChatStyleButton:Enable()
			InterfaceOptionsSocialPanelChatStyleText:SetAlpha(1)
			InterfaceOptionsSocialPanelChatStyle.tooltip = InterfaceOptionsSocialPanelChatStyle.orig_tooltip
			InterfaceOptionsSocialPanelChatStyle.orig_tooltip = nil
		end
	end
end

function PhanxChat:SetMoveEditBox(v)
	if self.debug then print("PhanxChat: SetMoveEditBox", v) end
	if type(v) == "boolean" then
		self.db.MoveEditBox = v
	end

	for frame in pairs(self.frames) do
		self:MoveEditBox(frame)
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetMoveEditBox)
table.insert(PhanxChat.RunOnProcessFrame, PhanxChat.MoveEditBox)