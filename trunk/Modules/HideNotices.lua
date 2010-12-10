--[[--------------------------------------------------------------------
PhanxChat
Reduces chat frame clutter and enhances chat frame functionality.

http://www.wowinterface.com/downloads/info6323-PhanxChat.html
http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx

Copyright © 2006–2010 Phanx < addons@phanx.net >

I, the copyright holder of this work, hereby release it into the public
domain. This applies worldwide. In case this is not legally possible:
I grant anyone the right to use this work for any purpose, without any
conditions, unless such conditions are required by law.
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