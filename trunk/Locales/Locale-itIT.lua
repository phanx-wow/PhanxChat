--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2012 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
------------------------------------------------------------------------
	Localization: Italian / Italian / Italiano
	Last Updated: 2012-07-31 by Phanx
----------------------------------------------------------------------]]

if GetLocale() ~= "itIT" then return end
local _, PhanxChat = ...
PhanxChat.L = {

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

	["Conversation"]     = "Conversazione",
	["General"]          = "Generale",
	["LocalDefense"]     = "DifesaLocale",
	["LookingForGroup"]  = "CercaGruppo",
	["Trade"]            = "Commercio",
	["WorldDefense"]     = "DifesaMondiale",

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

	CONVERSATION_ABBR     = "BN",
	GENERAL_ABBR          = "G",
	LOCALDEFENSE_ABBR     = "DL",
	LOOKINGFORGROUP_ABBR  = "CG",
	TRADE_ABBR            = "C",
	WORLDDEFENSE_ABBR     = "DM",

	GUILD_ABBR               = "G",
	INSTANCE_CHAT_ABBR        = "i",
	INSTANCE_CHAT_LEADER_ABBR = "Ci",
	OFFICER_ABBR             = "Uf",
	PARTY_ABBR               = "Gr",
	PARTY_GUIDE_ABBR         = "GS",
	PARTY_LEADER_ABBR        = "CG",
	RAID_ABBR                = "I",
	RAID_LEADER_ABBR         = "CI",
	RAID_WARNING_ABBR        = "AI",
	SAY_ABBR                 = "D",
	YELL_ABBR                = "Ur",
	WHISPER_ABBR             = "Sd", -- incoming
	WHISPER_INFORM_ABBR      = "Sa", -- outgoing

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

	--["Short channel names"] = "",
	--["Shorten channel names and chat strings."] = "",
	--["Short player names"] = "",
	--["Shorten player names by removing realm names and Real ID last names."] = "",
	--["Replace real names"] = "",
	--["Replace Real ID names with character names."] = "",
	--["Enable arrow keys"] = "",
	--["Enable arrow keys in the chat edit box."] = "",
	--["Enable resize edges"] = "",
	--["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."] = "",
	--["Link URLs"] = "",
	--["Transform URLs in chat into clickable links for easy copying."] = "",
	--["Lock docked tabs"] = "",
	--["Prevent docked chat tabs from being dragged unless the Shift key is down."] = "",
	--["Move edit boxes"] = "",
	--["Move chat edit boxes to the top their respective chat frame."] = "",
	--["Hide buttons"] = "",
	--["Hide the chat frame menu and scroll buttons."] = "",
	--["Hide extra textures"] = "",
	--["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = "",
	--["Hide tab flash"] = "",
	--["Disable the flashing effect on chat tabs that receive new messages."] = "",
	--["Hide notices"] = "",
	--["Hide channel notification messages."] = "",
	--["Hide repeats"] = "",
	--["Hide repeated messages in public channels."] = "",
	--["Sticky chat"] = "",
	--["Set which chat types should be sticky."] = "",
	--["All"] = "",
	--["Default"] = "",
	--["None"] = "",
	--["Fade time"] = "",
	--["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."] = "",
	--["Font size"] = "",
	--["Set the font size for all chat frames."] = "",
	--["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."] = "",
	--["Show class colors"] = "",
	--["Show class colors in all channels."] = "",
	--["Note that this is just a shortcut to configuring each chat channel individually through the Blizzard chat options."] = "",
	--["This option is locked by PhanxChat. If you wish to change it, you must first disable the %q option in PhanxChat."] = "",
}