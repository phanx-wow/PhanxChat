--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2014 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat

	Please DO NOT upload this addon to other websites, or post modified
	versions of it. However, you are welcome to include this addon
	WITHOUT CHANGES in compilations posted on Curse and/or WoWInterface.
	You are also welcome to use any/all of its code in your own addon, as
	long as you do not use my name or the name of this addon ANYWHERE in
	your addon, including its name, outside of an optional attribution.
----------------------------------------------------------------------]]

local _, PhanxChat = ...
local L = PhanxChat.L

function PhanxChat:SetShowClassColors(enable)
	if type(enable) == "boolean" then
		self.db.ShowClassColors = enable
	else
		enable = self.db.ShowClassColors
	end
	if self.debug then print("PhanxChat: SetShowClassColors", enable) end
	self:ClearBNetNameCache()

	for i = 1, #CHAT_CONFIG_CHAT_LEFT do
		ToggleChatColorNamesByClassGroup(enable, CHAT_CONFIG_CHAT_LEFT[i].type)
		local checkbox = _G["ChatConfigChatSettingsLeftCheckBox"..i.."ColorClasses"]
		if checkbox then
			checkbox:SetChecked(enable)
			checkbox:Disable()
			checkbox:SetMotionScriptsWhileDisabled(true)
			checkbox.tooltip = format(L.OptionLocked, L.ShowClassColors)
		end
	end

	for i = 1, 50 do
		ToggleChatColorNamesByClassGroup(enable, "CHANNEL"..i)
		local checkbox = _G["ChatConfigChannelSettingsLeftCheckBox"..i.."ColorClasses"]
		if checkbox then
			checkbox:SetChecked(enable)
			checkbox:Disable()
			checkbox:SetMotionScriptsWhileDisabled(true)
			checkbox.tooltip = format(L.OptionLocked, L.ShowClassColors)
		end
	end
end

tinsert(PhanxChat.RunOnLoad, PhanxChat.SetShowClassColors)

hooksecurefunc("ChatConfig_UpdateCheckboxes", function(frame)
	if frame == ChatConfigChatSettingsLeft or frame == ChatConfigChannelSettingsLeft then
		PhanxChat:SetShowClassColors()
	end
end)