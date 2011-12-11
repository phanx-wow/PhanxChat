--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Written by Phanx <addons@phanx.net>
	Copyright © 2006–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx
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

------------------------------------------------------------------------