------------------------------------------------------------------------
--	PhanxChat                                                         --
--	Removes chat frame clutter and adds some functionality.           --
--	by Phanx < addons@phanx.net >                                     --
--	Copyright © 2006–2010 Phanx. See README for license terms.        --
--	http://www.wowinterface.com/downloads/info6323-PhanxChat.html     --
--	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx  --
------------------------------------------------------------------------

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
local STRING_LINK  = "|Hchannel:%s|h" .. STRING_STYLE .. "|h"

ChannelStrings = {
	CHAT_BATTLEGROUND_GET        = STRING_LINK:format("Battleground", L.BATTLEGROUND_ABBR),
	CHAT_BATTLEGROUND_LEADER_GET = STRING_LINK:format("Battleground", L.BATTLEGROUND_LEADER_ABBR),
	CHAT_GUILD_GET               = STRING_LINK:format("Guild", L.GUILD_ABBR),
	CHAT_OFFICER_GET             = STRING_LINK:format("o", L.OFFICER_ABBR),
	CHAT_PARTY_GET               = STRING_LINK:format("Party", L.PARTY_ABBR),
	CHAT_PARTY_GUIDE_GET         = STRING_LINK:format("party", L.PARTY_GUIDE_ABBR),
	CHAT_PARTY_LEADER_GET        = STRING_LINK:format("party", L.PARTY_LEADER_ABBR),
	CHAT_RAID_GET                = STRING_LINK:format("raid", L.RAID_ABBR),
	CHAT_RAID_LEADER_GET         = STRING_LINK:format("raid", L.RAID_LEADER_ABBR),
	CHAT_RAID_WARNING_GET        = STRING_STYLE:format(L.RAID_WARNING_ABBR),
	CHAT_SAY_GET                 = STRING_STYLE:format(L.SAY_ABBR) .. "%s:\32",
	CHAT_WHISPER_GET             = STRING_STYLE:format(L.WHISPER_ABBR) .. "%s:\32",
	CHAT_WHISPER_INFORM_GET      = STRING_STYLE:format(L.WHISPER_INFORM_ABBR) .. "%s:\32",
	CHAT_YELL_GET                = STRING_STYLE:format(L.YELL_ABBR) .. "%s:\32",
}

------------------------------------------------------------------------