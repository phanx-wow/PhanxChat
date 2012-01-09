--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Written by Phanx <addons@phanx.net>
	Copyright © 2006–2012 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
------------------------------------------------------------------------
	Localization: zhCN / Simplified Chinese / 简体中文
	Last Updated: 2011-03-03 by tss1398383123 @ CurseForge
----------------------------------------------------------------------]]

if GetLocale() ~= "zhCN" then return end
local _, PhanxChat = ...
PhanxChat.L = {

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

	Conversation = CHAT_BN_CONVERSATION_SEND and CHAT_BN_CONVERSATION_SEND:match("%.%s?(%.-)%]") or "", -- needs check
	General = "综合",
	GuildRecruitment = "公会招募",
	LocalDefense = "本地防务",
	LookingForGroup = "寻求组队",
	Trade = "交易",
	WorldDefense = "世界防务",

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

--	CONVERSATION_ABBR = "", -- needs translation
	GENERAL_ABBR = "综",
	GUILDRECRUITMENT_ABBR = "招",
	LOCALDEFENSE_ABBR = "本",
	LOOKINGFORGROUP_ABBR = "寻",
	TRADE_ABBR = "交",
	WORLDDEFENSE_ABBR = "世",

	BATTLEGROUND_ABBR = "战",
	BATTLEGROUND_LEADER_ABBR = "战领",
	GUILD_ABBR = "公",
	OFFICER_ABBR = "官",
	PARTY_ABBR = "队",
	PARTY_GUIDE_ABBR = "领队",
	PARTY_LEADER_ABBR = "队长",
	RAID_ABBR = "团",
	RAID_LEADER_ABBR = "领",
	RAID_WARNING_ABBR = "警",
	SAY_ABBR = "说",
	WHISPER_ABBR = "密自",
	WHISPER_INFORM_ABBR = "密往",
	YELL_ABBR = "喊",

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

	["Short channel names"] = "缩短频道名",
	["Shorten channel names and chat strings."] = "缩短频道名和聊天类型名。",
	["Short player names"] = "缩短玩家名",
	["Shorten player names by removing realm names and Real ID last names."] = "移除玩家实名以缩短名字显示。",
	["Replace real names"] = "替换玩家实名",
	["Replace Real ID names with character names."] = "以玩家角色名替换显示战网实名。",
	["Enable arrow keys"] = "输入框中使用方向键",
	["Enable arrow keys in the chat edit box."] = "允许在输入框中使用方向键。",
	["Enable resize edges"] = "开启边缘调整",
	["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."] = "开启聊天框边缘调整，而不只是在右下角调整。",
	["Link URLs"] = "URL链接快速复制",
	["Transform URLs in chat into clickable links for easy copying."] = "被点击的URL内容将被递交到聊天输入框以便复制。",
	["Lock docked tabs"] = "隐藏附着标签",
	["Prevent docked chat tabs from being dragged unless the Shift key is down."] = "锁定已附着的聊天标签（按住Shift移动）。",
	["Move edit boxes"] = "移动聊天输入框",
	["Move chat edit boxes to the top their respective chat frame."] = "移动聊天输入框到该信息框顶部。",
	["Hide buttons"] = "隐藏按钮",
	["Hide the chat frame menu and scroll buttons."] = "隐藏聊天框菜单和滚动按钮。",
	["Hide extra textures"] = "隐藏额外材质",
	["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = "隐藏在3.3.5中为聊天框标签和聊天输入框额外加入的材质。",
	["Hide tab flash"] = "隐藏标签闪烁",
	["Disable the flashing effect on chat tabs that receive new messages."] = "禁用聊天框收到消息后标签的闪烁效果。",
	["Hide notices"] = "隐藏警告",
	["Hide channel notification messages."] = "隐藏聊天框内的警告信息。",
	["Hide repeats"] = "屏蔽重复信息",
	["Hide repeated messages in public channels."] = "屏蔽公共频道中的重复刷屏信息。",
	["Sticky chat"] = "保持聊天频道与类型",
	["Set which chat types should be sticky."] = "设定哪一聊天输出频道将被保持。",
	["All"] = "所有",
	["Default"] = "默认",
	["None"] = "无",
	["Fade time"] = "渐隐时间",
	["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."] = "设置文本消失时间，设为0将不消失。",
	["Font size"] = "字体大小",
	["Set the font size for all chat frames."] = "为所有聊天框设置字体大小。",
	["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."] = "注意，这只是链接到暴雪每个单独的聊天框设置的快捷方式。",

------------------------------------------------------------------------

}