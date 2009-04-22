--[[--------------------------------------------------------------------
	Simplified Chinese translations for PhanxChat
	Last updated yyyy-mm-dd by digmouse
	Contributors:
		digmouse <CWDG> Magtheridon CN1 < whhao1988@gmail.com >
----------------------------------------------------------------------]]

if GetLocale() ~= "zhCN" then return end

local L = {
-- Translating these strings is required for the addon to function in
-- this locale. These strings are used to detect server channel names.

	CHANNEL_GENERAL			= "综合",
	CHANNEL_TRADE				= "交易",
	CHANNEL_LOCALDEFENSE		= "本地防务",
	CHANNEL_WORLDDEFENSE		= "世界防务",
	CHANNEL_LOOKINGFORGROUP		= "寻求组队",
	CHANNEL_GUILDRECRUITMENT		= "公会招募",

-- Translating these strings is optional, but highly recommended. These
-- strings are displayed if the user has "short channel names" enabled.

	SHORT_GENERAL 				= "综",
	SHORT_TRADE 				= "交",
	SHORT_LOCALDEFENSE 			= "本",
	SHORT_WORLDDEFENSE 			= "世",
	SHORT_LOOKINGFORGROUP		= "寻",
	SHORT_GUILDRECRUITMENT		= "招",

	SHORT_SAY 				= "说",
	SHORT_YELL 				= "喊",
	SHORT_GUILD 				= "公",
	SHORT_OFFICER 				= "官",
	SHORT_PARTY 				= "队",
	SHORT_RAID 				= "团",
	SHORT_RAID_LEADER 			= "领",
	SHORT_RAID_WARNING 			= "警",
	SHORT_BATTLEGROUND 			= "战",
	SHORT_BATTLEGROUND_LEADER 	= "战领",
	SHORT_WHISPER 				= "密自",
	SHORT_WHISPER_INFORM 		= "密往",
}

-- Translating these strings is optional, but recommended. These strings
-- are shown in the configuration GUI.

L["Hide buttons"] = "隐藏滚动按钮"
L["Hide the scroll-up, scroll-down, scroll-to-bottom, and menu buttons next to the chat frame."] = "隐藏滚动按钮"

L["Shorten channels"] = "缩写频道名和聊天类型名"
L["Shorten channel names in chat messages. For example, '[1. General]' might be shortened to '1|'."] = "缩写频道名和聊天类型名"

L["Enable arrow keys"] = "允许在输入框中使用方向键"
L["Enable the use of arrow keys in the chat edit box."] = "允许在输入框中使用方向键"

L["Move chat edit box"] = "将输入框置于聊天窗口顶部"
L["Move the chat edit box to the top of the chat frame."] = "将输入框置于聊天窗口顶部"

L["Chat fade time"] = "设置文字消隐时间"
L["Set the time in minutes to keep chat messages visible before fading them out. Setting this to 0 will disable fading completely."] = "设置文字消隐时间（0 = 关闭）"

L["Disable tab flashing"] = "关闭聊天标签页闪烁"
L["Disable the flashing effect on chat tabs when new messages are received."] = "关闭聊天标签页闪烁"

L["Chat font size"] = "设置所有窗口的字体大小"
L["Set the font size for all chat tabs at once. This is only a shortcut for doing the same thing for each tab using the default UI."] = "设置所有窗口的字体大小"

L["Auto-start logging"] = "自动记录聊天内容"
L["Automatically enable chat logging when you log in. Chat logging can be started or stopped manually at any time using the '/chatlog' command. Logs are saved when you log out or exit the game to the 'World of Warcraft/Logs/WoWChatLog.txt' file."] = "自动记录聊天内容"

L["Color player names"] = "将已知玩家名字按职业颜色标识"
L["Color player names in chat by their class if known. Classes are known if you have seen the player in your group, in your guild, online on your friends list, in a '/who' query, or have targetted or moused over them since you logged in."] = "将已知玩家名字按职业颜色标识"

L["Mousewheel scrolling"] = "启用鼠标卷动"
L["Enable scrolling through chat frames with the mouse wheel. Hold the Shift key while scrolling to jump to the top or bottom of the chat frame."] = "启用鼠标卷动"

L["Sticky channels"] = "保持当前聊天频道"
L["Enable sticky channel behavior for all chat types except emotes."] = "保持当前聊天频道"

L["Suppress notifications"] = "屏蔽频道更改提示"
L["Suppress the notification messages informing you when someone leaves or joins a channel, or when channel ownership changes."] = "屏蔽频道更改提示"

L["Suppress repeats"] = "屏蔽公共频道中的重复刷屏信息"
L["Suppress repeated messages in public chat channels."] = "屏蔽公共频道中的重复刷屏信息"

L["Lock tabs"] = "锁定已附着的聊天标签"
L["Prevent docked chat tabs from being dragged unless the Alt key is down."] = "锁定已附着的聊天标签（按住Alt拖动）"

L["Link URLs"] = "URL链接快速复制"
L["Turn URLs in chat messages into clickable links for easy copying."] = "URL链接快速复制"

-- Don't touch this.

PHANXCHAT_LOCALS = L