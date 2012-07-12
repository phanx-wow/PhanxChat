--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2012 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
----------------------------------------------------------------------]]

local _, PhanxChat = ...

function PhanxChat:MoveEditBox(frame)
	local editBox = frame.editBox or _G[frame:GetName() .. "EditBox"]
	if not editBox then return end

	if self.db.MoveEditBox then
		editBox:ClearAllPoints()
		editBox:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", -5, 2)
		editBox:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 5, 2)

		InterfaceOptionsSocialPanelChatStyle_SetChatStyle("classic")
		InterfaceOptionsSocialPanelChatStyleButton:Disable()
		-- InterfaceOptionsSocialPanelChatStyleText:SetAlpha(0)
		InterfaceOptionsSocialPanelChatStyle.tooltip = PhanxChat.L["This option cannot be changed while the edit box is at the top of the chat frame."]

		SetCVar("wholeChatWindowClickable", "0")
		InterfaceOptionsSocialPanelWholeChatWindowClickable:SetChecked(false)
		InterfaceOptionsPanel_CheckButton_Update(InterfaceOptionsSocialPanelWholeChatWindowClickable)
		InterfaceOptionsSocialPanelWholeChatWindowClickable:Disable()
		InterfaceOptionsSocialPanelWholeChatWindowClickable:Hide()
	else
		editBox:ClearAllPoints()
		editBox:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", -5, -2)
		editBox:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", 5, -2)

		InterfaceOptionsSocialPanelChatStyleButton:Enable()
		InterfaceOptionsSocialPanelWholeChatWindowClickable:Enable()

		InterfaceOptionsSocialPanelChatStyle_SetChatStyle(GetCVar("chatStyle"))
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