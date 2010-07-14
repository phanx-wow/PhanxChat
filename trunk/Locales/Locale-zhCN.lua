------------------------------------------------------------------------
--	PhanxChat                                                         --
--	Removes chat frame clutter and adds some functionality.           --
--	by Phanx < addons@phanx.net >                                     --
--	Copyright © 2006–2010 Phanx. See README for license terms.        --
--	http://www.wowinterface.com/downloads/info6323-PhanxChat.html     --
--	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx  --
------------------------------------------------------------------------
--	Localization: zhCN / Simplified Chinese / 简体中文
--	Last Updated: YYYY-MM-DD by YourName < ContactInfo >
------------------------------------------------------------------------

if GetLocale() ~= "zhCN" then return end
local L, _, PhanxChat = { }, ...
PhanxChat.L = L

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

L["Conversation"]     = CHAT_BN_CONVERSATION_SEND:match("%.%s?(%.-)%]")
L["General"]          = "综合"
L["GuildRecruitment"] = "公会招募"
L["LocalDefense"]     = "本地防务"
L["LookingForGroup"]  = "寻求组队"
L["Trade"]            = "交易"
L["WorldDefense"]     = "世界防务"

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

-- L.CONVERSATION_ABBR       = ""
L.GENERAL_ABBR            = "综"
L.GUILDRECRUITMENT_ABBR   = "招"
L.LOCALDEFENSE_ABBR       = "本"
L.LOOKINGFORGROUP_ABBR    = "寻"
L.TRADE_ABBR              = "交"
L.WORLDDEFENSE_ABBR       = "世"

L.BATTLEGROUND_ABBR        = "战"
L.BATTLEGROUND_LEADER_ABBR = "战领"
L.GUILD_ABBR               = "公"
L.OFFICER_ABBR             = "官"
L.PARTY_ABBR               = "队"
-- L.PARTY_GUIDE_ABBR         = ""
-- L.PARTY_LEADER_ABBR        = ""
L.RAID_ABBR                = "团"
L.RAID_LEADER_ABBR         = "领"
L.RAID_WARNING_ABBR        = "警"
L.SAY_ABBR                 = "说"
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