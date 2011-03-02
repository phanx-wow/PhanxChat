--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2006–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx
------------------------------------------------------------------------
	Localization: zhTW / Traditional Chinese / 正體中文
	Last Updated: YYYY-MM-DD by YourName < ContactInfo >
----------------------------------------------------------------------]]

if GetLocale() ~= "zhTW" then return end
local _, PhanxChat = ...
PhanxChat.L = {

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

	["Conversation"]     = CHAT_BN_CONVERSATION_SEND:match("%.%s?(%.-)%]"), -- needs check
	["General"]          = "綜合",
	["GuildRecruitment"] = "公會招募",
	["LocalDefense"]     = "本地防務",
	["LookingForGroup"]  = "尋求組隊",
	["Trade"]            = "交易",
	["WorldDefense"]     = "世界防務",

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

--	CONVERSATION_ABBR       = "", -- needs translation
	GENERAL_ABBR            = "綜",
	GUILDRECRUITMENT_ABBR   = "招",
	LOCALDEFENSE_ABBR       = "本",
	LOOKINGFORGROUP_ABBR    = "尋",
	TRADE_ABBR              = "交",
	WORLDDEFENSE_ABBR       = "世",

	BATTLEGROUND_ABBR        = "戰",
	BATTLEGROUND_LEADER_ABBR = "戰領",
	GUILD_ABBR               = "公",
	OFFICER_ABBR             = "官",
	PARTY_ABBR               = "隊",
--	PARTY_GUIDE_ABBR         = "",
--	PARTY_LEADER_ABBR        = "",
	RAID_ABBR                = "團",
	RAID_LEADER_ABBR         = "領",
	RAID_WARNING_ABBR        = "警",
	SAY_ABBR                 = "說",
	YELL_ABBR                = "喊",
	WHISPER_ABBR             = "密自", -- incoming
	WHISPER_INFORM_ABBR      = "密往", -- outgoing

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

--	["Short channel names"] = "",
--	["Shorten channel names and chat strings."] = "",
--	["Short player names"] = "",
--	["Shorten player names by removing realm names and Real ID last names."] = "",
--	["Replace real names"] = "",
--	["Replace Real ID names with character names."] = "",
--	["Enable arrow keys"] = "",
--	["Enable arrow keys in the chat edit box."] = "",
--	["Enable resize edges"] = "",
--	["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."] = "",
--	["Link URLs"] = "",
--	["Transform URLs in chat into clickable links for easy copying."] = "",
--	["Lock docked tabs"] = "",
--	["Prevent docked chat tabs from being dragged unless the Shift key is down."] = "",
--	["Move edit boxes"] = "",
--	["Move chat edit boxes to the top their respective chat frame."] = "",
--	["Hide buttons"] = "",
--	["Hide the chat frame menu and scroll buttons."] = "",
--	["Hide extra textures"] = "",
--	["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = "",
--	["Hide tab flash"] = "",
--	["Disable the flashing effect on chat tabs that receive new messages."] = "",
--	["Hide notices"] = "",
--	["Hide channel notification messages."] = "",
--	["Hide repeats"] = "",
--	["Hide repeated messages in public channels."] = "",
--	["Sticky chat"] = "",
--	["Set which chat types should be sticky."] = "",
--	["All"] = "",
--	["Default"] = "",
--	["None"] = "",
--	["Fade time"] = "",
--	["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."] = "",
--	["Font size"] = "",
--	["Set the font size for all chat frames."] = "",
--	["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."] = "",

------------------------------------------------------------------------

}