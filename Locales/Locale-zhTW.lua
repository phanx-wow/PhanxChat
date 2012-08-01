--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2012 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
------------------------------------------------------------------------
	Localization: zhTW / Traditional Chinese / 繁體中文
	Last Updated: 2012-07-29 by yunrong on CurseForge
----------------------------------------------------------------------]]

if GetLocale() ~= "zhTW" then return end
local _, PhanxChat = ...
PhanxChat.L = {

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

	["Conversation"]     = "對話",
	["General"]          = "綜合",
	["LocalDefense"]     = "本地防務",
	["LookingForGroup"]  = "尋求組隊",
	["Trade"]            = "交易",
	["WorldDefense"]     = "世界防務",

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

	CONVERSATION_ABBR       = "話",
	GENERAL_ABBR            = "綜",
	LOCALDEFENSE_ABBR       = "本",
	LOOKINGFORGROUP_ABBR    = "尋",
	TRADE_ABBR              = "交",
	WORLDDEFENSE_ABBR       = "世",

	BATTLEGROUND_ABBR        = "戰",
	BATTLEGROUND_LEADER_ABBR = "領",
	GUILD_ABBR               = "公",
	OFFICER_ABBR             = "官",
	PARTY_ABBR               = "隊",
	PARTY_GUIDE_ABBR         = "領",
	PARTY_LEADER_ABBR        = "領",
	RAID_ABBR                = "團",
	RAID_LEADER_ABBR         = "領",
	RAID_WARNING_ABBR        = "警",
	SAY_ABBR                 = "說",
	YELL_ABBR                = "喊",
	WHISPER_ABBR             = "自", -- incoming
	WHISPER_INFORM_ABBR      = "往", -- outgoing

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

	--["Short channel names"] = "",
	--["Shorten channel names and chat strings."] = "",
	--["Short player names"] = "",
	--["Shorten player names by removing realm names and Real ID last names."] = "",
	["Replace real names"] = "替換玩家實名",
	["Replace Real ID names with character names."] = "以玩家角色名取代顯示戰網ID。",
	["Enable arrow keys"] = "輸入框中使用方向鍵",
	["Enable arrow keys in the chat edit box."] = "允許在輸入框中使用方向鍵。",
	["Enable resize edges"] = "開啟邊緣調整",
	["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."] = "開啟聊天框邊緣調整，而不只是在右下角調整。",
	--["Link URLs"] = "",
	--["Transform URLs in chat into clickable links for easy copying."] = "",
	--["Lock docked tabs"] = "",
	--["Prevent docked chat tabs from being dragged unless the Shift key is down."] = "",
	["Move edit boxes"] = "移動聊天輸入框",
	["Move chat edit boxes to the top their respective chat frame."] = "移動聊天輸入框到該訊息框頂部。",
	["Hide buttons"] = "隱藏按鈕",
	["Hide the chat frame menu and scroll buttons."] = "隱藏聊天視窗選單和滾動按鈕。",
	["Hide extra textures"] = "隱藏額外材質",
	--["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = "",
	["Hide tab flash"] = "隱藏標籤閃爍",
	["Disable the flashing effect on chat tabs that receive new messages."] = "禁用聊天框收到消息後標籤的閃爍效果。",
	["Hide notices"] = "隱藏警告",
	["Hide channel notification messages."] = "隱藏聊天框內的警告訊息。",
	["Hide repeats"] = "隱藏重複訊息",
	["Hide repeated messages in public channels."] = "隱藏公共頻道中的重複刷頻訊息。",
	--["Sticky chat"] = "",
	--["Set which chat types should be sticky."] = "",
	["All"] = "所有",
	["Default"] = "預設",
	["None"] = "無",
	["Fade time"] = "漸隱時間",
	--["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."] = "",
	["Font size"] = "字體大小",
	--["Set the font size for all chat frames."] = "",
	--["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."] = "",
	--["Show class colors"] = "",
	--["Show class colors in all channels."] = "",
	--["Note that this is just a shortcut to configuring each chat channel individually through the Blizzard chat options."] = "",
	--["This option is locked by PhanxChat. If you wish to change it, you must first disable the %q option in PhanxChat."] = "",
}