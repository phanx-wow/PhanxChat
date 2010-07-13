------------------------------------------------------------------------
--	PhanxChat                                                         --
--	Removes chat frame clutter and adds some functionality.           --
--	by Phanx < addons@phanx.net >                                     --
--	Copyright © 2006–2010 Phanx. See README for license terms.        --
--	http://www.wowinterface.com/downloads/info6323-PhanxChat.html     --
--	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx  --
------------------------------------------------------------------------
--	Localization: koKR / Korean / 한국어
--	Last Updated: YYYY-MM-DD by YourName < ContactInfo >
------------------------------------------------------------------------

if GetLocale() ~= "koKR" then return end
local L, _, PhanxChat = { }, ...
PhanxChat.L = L

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

L["Conversation"]     = CHAT_BN_CONVERSATION_SEND:match("%.%s?(%.-)%]")
L["General"]          = "공개"
L["GuildRecruitment"] = "길드모집"
L["LocalDefense"]     = "수비"
L["LookingForGroup"]  = "파티찾기"
L["Trade"]            = "거래"
L["WorldDefense"]     = "전쟁"

L["Battleground"]        = CHAT_MSG_BATTLEGROUND
L["Battleground Leader"] = CHAT_MSG_BATTLEGROUND_LEADER
L["Dungeon Guide"]       = CHAT_PARTY_GUIDE_GET:match("%[(.-)%]")
L["Guild"]               = CHAT_MSG_GUILD
L["Officer"]             = CHAT_MSG_OFFICER
L["Party"]               = CHAT_MSG_PARTY
L["Party Leader"]        = CHAT_MSG_PARTY_LEADER
L["Raid"]                = CHAT_MSG_RAID
L["Raid Leader"]         = CHAT_MSG_RAID_LEADER
L["Raid Warning"]        = CHAT_MSG_RAID_WARNING

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

-- L.CONVERSATION_ABBR       = ""
L.GENERAL_ABBR            = "공"
L.GUILDRECRUITMENT_ABBR   = "모집"
L.LOCALDEFENSE_ABBR       = "수"
L.LOOKINGFORGROUP_ABBR    = "파찾"
L.TRADE_ABBR              = "거"
L.WORLDDEFENSE_ABBR       = "쟁"

L.BATTLEGROUND_ABBR        = "BG"
L.BATTLEGROUND_LEADER_ABBR = "BGL"
L.GUILD_ABBR               = "G"
L.OFFICER_ABBR             = "O"
L.PARTY_ABBR               = "P"
L.PARTY_GUIDE_ABBR         = "PL"
L.PARTY_LEADER_ABBR        = "PL"
L.RAID_ABBR                = "R"
L.RAID_LEADER_ABBR         = "RL"
L.RAID_WARNING_ABBR        = "RW"
L.SAY_ABBR                 = "S"
L.YELL_ABBR                = "Y"
L.WHISPER_ABBR             = "FROM" -- incoming
L.WHISPER_INFORM_ABBR      = "TO" -- outgoing

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

-- L["Short channel names"] = ""
-- L["Shorten channel names and chat strings."] = ""
-- L["Short player names"] = ""
-- L["Shorten player names by removing realm names and Real ID last names."] = ""
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