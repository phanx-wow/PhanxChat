--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2012 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
----------------------------------------------------------------------]]

local _, PhanxChat = ...

function PhanxChat:SetShowClassColors(enable)
	if self.debug then print("PhanxChat: SetShowClassColors", v) end
	if type(enable) == "boolean" then
		self.db.ShowClassColors = enable
	end
	if self.db.ShowClassColors then
		local checkbox
		for i = 1, #CHAT_CONFIG_CHAT_LEFT do
			checkbox = _G["ChatConfigChatSettingsLeftCheckBox"..i.."ColorClasses"]
			if checkbox then
				checkbox:SetChecked(true)
				checkbox:Disable()
			end
			ToggleChatColorNamesByClassGroup(true, CHAT_CONFIG_CHAT_LEFT[i].type)
		end
		for i = 1, 50 do
			checkbox = _G["ChatConfigChannelSettingsLeftCheckBox"..i.."ColorClasses"]
			if checkbox then
				checkbox:SetChecked(true)
				checkbox:Disable()
			end
			ToggleChatColorNamesByClassGroup(true, "CHANNEL"..i)
		end
	else
		local checkbox
		for i = 1, #CHAT_CONFIG_CHAT_LEFT do
			checkbox = _G["ChatConfigChatSettingsLeftCheckBox"..i.."ColorClasses"]
			if checkbox then
				checkbox:SetChecked(false)
				checkbox:Enable()
			end
			ToggleChatColorNamesByClassGroup(false, CHAT_CONFIG_CHAT_LEFT[i].type)
		end
		for i = 1, 50 do
			checkbox = _G["ChatConfigChannelSettingsLeftCheckBox"..i.."ColorClasses"]
			if checkbox then
				checkbox:SetChecked(false)
				checkbox:Enable()
			end
			ToggleChatColorNamesByClassGroup(false, "CHANNEL"..i)
		end
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetShowClassColors)

hooksecurefunc("ChatConfig_UpdateCheckboxes", function(frame)
	if frame == ChatConfigChatSettingsLeft or frame == ChatConfigChannelSettingsLeft then
		PhanxChat:SetShowClassColors()
	end
end)