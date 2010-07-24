------------------------------------------------------------------------
--	PhanxChat                                                         --
--	Removes chat frame clutter and adds some functionality.           --
--	by Phanx < addons@phanx.net >                                     --
--	Copyright © 2006–2010 Phanx. See README for license terms.        --
--	http://www.wowinterface.com/downloads/info6323-PhanxChat.html     --
--	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx  --
------------------------------------------------------------------------
--	Localization: ruRU / Russian / Русский
--	Last Updated: YYYY-MM-DD by YourName < ContactInfo >
------------------------------------------------------------------------

if GetLocale() ~= "ruRU" then return end
local L, _, PhanxChat = { }, ...
PhanxChat.L = L

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

L["Conversation"]     = CHAT_BN_CONVERSATION_SEND:match("%.%s?(%.-)%]")
L["General"]          = "Общий"
L["GuildRecruitment"] = "Набор в гильдии"
L["LocalDefense"]     = "Оборона: локальный"
L["LookingForGroup"]  = "Поис спутников"
L["Trade"]            = "Торговля"
L["WorldDefense"]     = "Оборона: глобальный"

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

-- L.CONVERSATION_ABBR       = ""
L.GENERAL_ABBR            = "О"
L.GUILDRECRUITMENT_ABBR   = "НвГ"
L.LOCALDEFENSE_ABBR       = "ЛО"
L.LOOKINGFORGROUP_ABBR    = "ЛФГ"
L.TRADE_ABBR              = "Т"
L.WORLDDEFENSE_ABBR       = "МО"

L.BATTLEGROUND_ABBR        = "ПБ"
L.BATTLEGROUND_LEADER_ABBR = "ЛПБ"
L.GUILD_ABBR               = "Г"
L.OFFICER_ABBR             = "Оф"
L.PARTY_ABBR               = "Гр"
L.PARTY_GUIDE_ABBR         = "ГрЛ"
L.PARTY_LEADER_ABBR        = "ГрЛ"
L.RAID_ABBR                = "Р"
L.RAID_LEADER_ABBR         = "РЛ"
L.RAID_WARNING_ABBR        = "РВ"
L.SAY_ABBR                 = "С"
L.YELL_ABBR                = "К"
L.WHISPER_ABBR             = "Ш" -- incoming
L.WHISPER_INFORM_ABBR      = "Ш" -- outgoing

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