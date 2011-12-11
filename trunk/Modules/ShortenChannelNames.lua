--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Written by Phanx <addons@phanx.net>
	Copyright © 2006–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx
----------------------------------------------------------------------]]

local _, PhanxChat = ...
local L = PhanxChat.L

local ChannelStrings
local hooks = { }

function PhanxChat:SetShortenChannelNames(v)
	if self.debug then print("PhanxChat: SetShortenChannelNames", v) end
	if type(v) == "boolean" then
		self.db.ShortenChannelNames = v
	end

	if self.db.ShortenChannelNames then
		if not hooks.CHAT_BATTLEGROUND_GET then
			for k, v in pairs(ChannelStrings) do
				hooks[k] = _G[k]
				_G[k] = v
			end
		end
	else
		if hooks.CHAT_BATTLEGROUND_GET then
			for k, v in pairs(hooks) do
				_G[k] = v
				hooks[k] = nil
			end
		end
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetShortenChannelNames)

------------------------------------------------------------------------

local STRING_STYLE = PhanxChat.STRING_STYLE

ChannelStrings = {
	CHAT_BATTLEGROUND_GET        = "|Hchannel:Battleground|h" .. STRING_STYLE:format(L.BATTLEGROUND_ABBR) .. "|h%s:\32",
	CHAT_BATTLEGROUND_LEADER_GET = "|Hchannel:Battleground|h" .. STRING_STYLE:format(L.BATTLEGROUND_LEADER_ABBR) .. "|h%s:\32",
	CHAT_BN_WHISPER_GET          = STRING_STYLE:format(L.WHISPER_ABBR) .. "%s:\32",
	CHAT_BN_WHISPER_INFORM_GET   = STRING_STYLE:format(L.WHISPER_INFORM_ABBR) .. "%s:\32",
	CHAT_GUILD_GET               = "|Hchannel:Guild|h" .. STRING_STYLE:format(L.GUILD_ABBR) .. "|h%s:\32",
	CHAT_OFFICER_GET             = "|Hchannel:o|h" .. STRING_STYLE:format(L.OFFICER_ABBR) .. "|h%s:\32",
	CHAT_PARTY_GET               = "|Hchannel:Party|h" .. STRING_STYLE:format(L.PARTY_ABBR) .. "|h%s:\32",
	CHAT_PARTY_GUIDE_GET         = "|Hchannel:party|h" .. STRING_STYLE:format(L.PARTY_GUIDE_ABBR) .. "|h%s:\32",
	CHAT_PARTY_LEADER_GET        = "|Hchannel:party|h" .. STRING_STYLE:format(L.PARTY_LEADER_ABBR) .. "|h%s:\32",
	CHAT_RAID_GET                = "|Hchannel:raid|h" .. STRING_STYLE:format(L.RAID_ABBR) .. "|h%s:\32",
	CHAT_RAID_LEADER_GET         = "|Hchannel:raid|h" .. STRING_STYLE:format(L.RAID_LEADER_ABBR) .. "|h%s:\32",
	CHAT_RAID_WARNING_GET        = STRING_STYLE:format(L.RAID_WARNING_ABBR) .. "%s:\32",
	CHAT_SAY_GET                 = STRING_STYLE:format(L.SAY_ABBR) .. "%s:\32",
	CHAT_WHISPER_GET             = STRING_STYLE:format(L.WHISPER_ABBR) .. "%s:\32",
	CHAT_WHISPER_INFORM_GET      = STRING_STYLE:format(L.WHISPER_INFORM_ABBR) .. "%s:\32",
	CHAT_YELL_GET                = STRING_STYLE:format(L.YELL_ABBR) .. "%s:\32",
}

------------------------------------------------------------------------