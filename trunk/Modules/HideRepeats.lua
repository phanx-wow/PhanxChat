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

local NUM_HISTORY_LINES = 15

------------------------------------------------------------------------
--	Nothing beyond here is intended to be configurable.
------------------------------------------------------------------------

local _, PhanxChat = ...

local playerName
local history = { }

local REPEAT_EVENTS = {
	"CHAT_MSG_SAY",
	"CHAT_MSG_YELL",
	"CHAT_MSG_CHANNEL",
	"CHAT_MSG_EMOTE",
	"CHAT_MSG_TEXT_EMOTE",
}

local function HideRepeats(frame, event, message, sender, ...)
	if sender and sender ~= playerName and type(message) == "string" then
		if not history[frame] then
			history[frame] = { }
		end

		local t = history[frame]
		local v = ("%s:%s"):format(sender, message:gsub("%s", ""):lower())

		if t[v] then
			return true
		end

		if #t == NUM_HISTORY_LINES then
			local r = tremove(t, 1)
			t[r] = nil
		end

		tinsert(t, v)
		t[v] = true
	end
	return false, message, sender, ...
end

function PhanxChat:SetHideRepeats(v)
	if self.debug then print("PhanxChat: SetHideRepeats", v) end
	if type(v) == "boolean" then
		self.db.HideRepeats = v
	end
	playerName = UnitName("player")
	if self.db.HideRepeats then
		for _, event in ipairs(REPEAT_EVENTS) do
			ChatFrame_AddMessageEventFilter(event, HideRepeats)
		end
	elseif not self.isLoading then
		for _, event in ipairs(REPEAT_EVENTS) do
			ChatFrame_RemoveMessageEventFilter(event, HideRepeats)
		end
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetHideRepeats)