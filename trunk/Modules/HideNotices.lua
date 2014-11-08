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

local NOTICE_EVENTS = {
	"CHAT_MSG_CHANNEL_JOIN",
	"CHAT_MSG_CHANNEL_LEAVE",
	"CHAT_MSG_CHANNEL_NOTICE",
	"CHAT_MSG_CHANNEL_NOTICE_USER",
}

local function HideNotices(frame, event, type, ...)
	return event ~= "CHAT_MSG_CHANNEL_NOTICE" or (type ~= "YOU_JOINED" and type ~= "YOU_LEFT")
end

function PhanxChat:SetHideNotices(v)
	if self.debug then print("PhanxChat: SetHideNotices", v) end
	if type(v) == "boolean" then
		self.db.HideNotices = v
	end

	if self.db.HideNotices then
		for _, event in ipairs(NOTICE_EVENTS) do
			ChatFrame_AddMessageEventFilter(event, HideNotices)
		end
	elseif not self.isLoading then
		for _, event in ipairs(NOTICE_EVENTS) do
			ChatFrame_RemoveMessageEventFilter(event, HideNotices)
		end
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetHideNotices)