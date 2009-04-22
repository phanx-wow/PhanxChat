--[[--------------------------------------------------------------------
	Traditional Chinese translations for PhanxChat
	Last updated yyyy-mm-dd by digmouse
	Contributors:
		digmouse <CWDG> Magtheridon CN1 < whhao1988@gmail.com >
----------------------------------------------------------------------]]

if not GetLocale() == "zhTW" then return end

local L = {
-- Translating these strings is required for the addon to function in
-- this locale. These strings are used to detect server channel names.

	CHANNEL_GENERAL			= "綜合",
	CHANNEL_TRADE				= "交易",
	CHANNEL_LOCALDEFENSE		= "本地防務",
	CHANNEL_WORLDDEFENSE		= "世界防務",
	CHANNEL_LOOKINGFORGROUP		= "尋求組隊",
	CHANNEL_GUILDRECRUITMENT		= "公會招募",

-- Translating these strings is optional, but highly recommended. These
-- strings are displayed if the user has "short channel names" enabled.

	SHORT_GENERAL				= "綜",
	SHORT_TRADE				= "交",
	SHORT_LOCALDEFENSE			= "本",
	SHORT_WORLDDEFENSE			= "世",
	SHORT_LOOKINGFORGROUP		= "尋",
	SHORT_GUILDRECRUITMENT		= "招",

	SHORT_SAY					= "說",
	SHORT_YELL				= "喊",
	SHORT_GUILD				= "公",
	SHORT_OFFICER				= "官",
	SHORT_PARTY				= "隊",
	SHORT_RAID				= "團",
	SHORT_RAID_LEADER			= "領",
	SHORT_RAID_WARNING			= "警",
	SHORT_BATTLEGROUND			= "戰",
	SHORT_BATTLEGROUND_LEADER	= "戰領",
	SHORT_WHISPER				= "密自",
	SHORT_WHISPER_INFORM		= "密往",
}

-- Translating these strings is optional, but recommended. These strings
-- are shown in the configuration GUI.

L["Hide buttons"] = "隱藏滾動按鈕"
L["Hide the scroll-up, scroll-down, scroll-to-bottom, and menu buttons next to the chat frame."] = "隱藏滾動按鈕"

L["Shorten channels"] = "縮寫頻道名和聊天類型名"
L["Shorten channel names in chat messages. For example, '[1. General]' might be shortened to '1|'."] = "縮寫頻道名和聊天類型名"

L["Enable arrow keys"] = "允許在輸入框中使用方向鍵"
L["Enable the use of arrow keys in the chat edit box."] = "允許在輸入框中使用方向鍵"

L["Move chat edit box"] = "將輸入框置於聊天視窗頂部"
L["Move the chat edit box to the top of the chat frame."] = "將輸入框置於聊天視窗頂部"

L["Chat fade time"] = "設置文字消隱時間"
L["Set the time in minutes to keep chat messages visible before fading them out. Setting this to 0 will disable fading completely."] = "設置文字消隱時間（0 = 關閉）"

L["Disable tab flashing"] = "關閉聊天標籤頁閃爍"
L["Disable the flashing effect on chat tabs when new messages are received."] = "關閉聊天標籤頁閃爍"

L["Chat font size"] = "設置所有視窗的字體大小"
L["Set the font size for all chat tabs at once. This is only a shortcut for doing the same thing for each tab using the default UI."] = "設置所有視窗的字體大小"

L["Auto-start logging"] = "自動保存聊天記錄"
L["Automatically enable chat logging when you log in. Chat logging can be started or stopped manually at any time using the '/chatlog' command. Logs are saved when you log out or exit the game to the 'World of Warcraft/Logs/WoWChatLog.txt' file."] = "自動保存聊天記錄"

L["Color player names"] = "將已知玩家名字按職業顏色標識"
L["Color player names in chat by their class if known. Classes are known if you have seen the player in your group, in your guild, online on your friends list, in a '/who' query, or have targetted or moused over them since you logged in."] = "將已知玩家名字按職業顏色標識"

L["Mousewheel scrolling"] = "啟用滑鼠捲動"
L["Enable scrolling through chat frames with the mouse wheel. Hold the Shift key while scrolling to jump to the top or bottom of the chat frame."] = "啟用滑鼠捲動"

L["Sticky channels"] = "保持當前聊天頻道"
L["Enable sticky channel behavior for all chat types except emotes."] = "保持當前聊天頻道"

L["Suppress notifications"] = "屏蔽頻道更改提示信息"
L["Suppress the notification messages informing you when someone leaves or joins a channel, or when channel ownership changes."] = "屏蔽頻道更改提示信息"

L["Suppress repeats"] = "屏蔽公共頻道內的重復信息"
L["Suppress repeated messages in public chat channels."] = "屏蔽公共頻道內的重復信息"

L["Lock tabs"] = "鎖定已附著的聊天標籤"
L["Prevent docked chat tabs from being dragged unless the Alt key is down."] = "鎖定已附著的聊天標籤（按住Alt拖動）"

L["Link URLs"] = "URL連結快速複製"
L["Turn URLs in chat messages into clickable links for easy copying."] = "URL連結快速複製"

-- Don't touch this.

PHANXCHAT_LOCALS = L