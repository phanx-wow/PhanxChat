--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	by Phanx < addons@phanx.net >
	Copyright © 2006–2010 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx
------------------------------------------------------------------------
	Localization: esES / Spanish (Europe) / Español (EU)
	Last Updated: YYYY-MM-DD by YourName < ContactInfo >
----------------------------------------------------------------------]]

if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L, _, PhanxChat = { }, ...
PhanxChat.L = L

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

L["Conversation"]     = CHAT_BN_CONVERSATION_SEND:match("%. (%w+)%]")
L["General"]          = GENERAL
-- L["GuildRecruitment"] = ""
-- L["LocalDefense"]     = ""
L["LookingForGroup"]  = LOOKING
L["Trade"]            = TRADE
-- L["WorldDefense"]     = ""

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

-- L.CONVERSATION_ABBR       = ""
-- L.GENERAL_ABBR            = ""
-- L.GUILDRECRUITMENT_ABBR   = ""
-- L.LOCALDEFENSE_ABBR       = ""
-- L.LOOKINGFORGROUP_ABBR    = ""
-- L.TRADE_ABBR              = ""
-- L.WORLDDEFENSE_ABBR       = ""

-- L.BATTLEGROUND_ABBR        = ""
-- L.BATTLEGROUND_LEADER_ABBR = ""
-- L.GUILD_ABBR               = ""
-- L.OFFICER_ABBR             = ""
-- L.PARTY_ABBR               = ""
-- L.PARTY_GUIDE_ABBR         = ""
-- L.PARTY_LEADER_ABBR        = ""
-- L.RAID_ABBR                = ""
-- L.RAID_LEADER_ABBR         = ""
-- L.RAID_WARNING_ABBR        = ""
-- L.SAY_ABBR                 = ""
-- L.YELL_ABBR                = ""
-- L.WHISPER_ABBR             = "" -- incoming
-- L.WHISPER_INFORM_ABBR      = "" -- outgoing

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

-- L["Short channel names"] = ""
-- L["Shorten channel names and chat strings."] = ""
-- L["Short player names"] = ""
-- L["Shorten player names by removing realm names and Real ID last names."] = ""
-- L["Replace real names"] = ""
-- L["Replace Real ID names with character names."] = ""
-- L["Enable arrow keys"] = ""
-- L["Enable arrow keys in the chat edit box."] = ""
-- L["Enable resize edges"] = ""
-- L["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."] = ""
-- L["Link URLs"] = ""
-- L["Transform URLs in chat into clickable links for easy copying."] = ""
-- L["Lock docked tabs"] = ""
-- L["Prevent docked chat tabs from being dragged unless the Shift key is down."] = ""
-- L["Move edit boxes"] = ""
-- L["Move chat edit boxes to the top their respective chat frame."] = ""
-- L["Hide buttons"] = ""
-- L["Hide the chat frame menu and scroll buttons."] = ""
-- L["Hide extra textures"] = ""
-- L["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = ""
-- L["Hide tab flash"] = ""
-- L["Disable the flashing effect on chat tabs that receive new messages."] = ""
-- L["Hide notices"] = ""
-- L["Hide channel notification messages."] = ""
-- L["Hide repeats"] = ""
-- L["Hide repeated messages in public channels."] = ""
-- L["Sticky chat"] = ""
-- L["Set which chat types should be sticky."] = ""
-- L["All"] = ""
-- L["Default"] = ""
-- L["None"] = ""
-- L["Fade time"] = ""
-- L["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."] = ""
-- L["Font size"] = ""
-- L["Set the font size for all chat frames."] = ""
-- L["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."] = ""

------------------------------------------------------------------------