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
--	Localization: zhTW / Traditional Chinese / 正體中文
--	Last Updated: YYYY-MM-DD by YourName < ContactInfo >
------------------------------------------------------------------------

if GetLocale() ~= "zhTW" then return end
local L, _, PhanxChat = { }, ...
PhanxChat.L = L

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

L["Conversation"]     = CHAT_BN_CONVERSATION_SEND:match("%.%s?(%.-)%]") -- needs check
L["General"]          = "綜合"
L["GuildRecruitment"] = "公會招募"
L["LocalDefense"]     = "本地防務"
L["LookingForGroup"]  = "尋求組隊"
L["Trade"]            = "交易"
L["WorldDefense"]     = "世界防務"

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

-- L.CONVERSATION_ABBR       = "" -- needs translation
L.GENERAL_ABBR            = "綜"
L.GUILDRECRUITMENT_ABBR   = "招"
L.LOCALDEFENSE_ABBR       = "本"
L.LOOKINGFORGROUP_ABBR    = "尋"
L.TRADE_ABBR              = "交"
L.WORLDDEFENSE_ABBR       = "世"

L.BATTLEGROUND_ABBR        = "戰"
L.BATTLEGROUND_LEADER_ABBR = "戰領"
L.GUILD_ABBR               = "公"
L.OFFICER_ABBR             = "官"
L.PARTY_ABBR               = "隊"
-- L.PARTY_GUIDE_ABBR         = ""
-- L.PARTY_LEADER_ABBR        = ""
L.RAID_ABBR                = "團"
L.RAID_LEADER_ABBR         = "領"
L.RAID_WARNING_ABBR        = "警"
L.SAY_ABBR                 = "說"
L.YELL_ABBR                = "喊"
L.WHISPER_ABBR             = "密自" -- incoming
L.WHISPER_INFORM_ABBR      = "密往" -- outgoing

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