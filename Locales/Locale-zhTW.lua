--[[--------------------------------------------------------------------
	Traditional Chinese translations for PhanxChat
	Last updated: 2008 by digmouse
	Contributors:
		digmouse <CWDG> Magtheridon CN1 < whhao1988@gmail.com >
----------------------------------------------------------------------]]

if GetLocale() ~= "zhTW" then return end

local L, _, PhanxChat = { }, ...
PhanxChat.L = L

------------------------------------------------------------------------
-- Channel Names
-- These must match the channel names sent from the server.
------------------------------------------------------------------------

L["General"]          = "綜合"
L["Trade"]            = "交易"
L["LocalDefense"]     = "本地防務"
L["WorldDefense"]     = "世界防務"
L["LookingForGroup"]  = "尋求組隊"
L["GuildRecruitment"] = "公會招募"

------------------------------------------------------------------------
-- Short Channel Names
-- These should be one- or two-character abbreviations.
------------------------------------------------------------------------

L["SHORT_GENERAL"]          = "綜"
L["SHORT_TRADE"]            = "交"
L["SHORT_LOCALDEFENSE"]     = "本"
L["SHORT_WORLDDEFENSE"]     = "世"
L["SHORT_LOOKINGFORGROUP"]  = "尋"
L["SHORT_GUILDRECRUITMENT"] = "招"

------------------------------------------------------------------------
-- Short Chat Strings
-- These should be one- or two-character abbreviations.
------------------------------------------------------------------------

L["SHORT_BATTLEGROUND"]        = "戰"
L["SHORT_BATTLEGROUND_LEADER"] = "戰領"
L["SHORT_GUILD"]               = "公"
L["SHORT_OFFICER"]             = "官"
L["SHORT_PARTY"]               = "隊"
L["SHORT_PARTY_GUIDE"]         = "隊" -- needs review
L["SHORT_PARTY_LEADER"]        = "隊" -- needs review
L["SHORT_RAID"]                = "團"
L["SHORT_RAID_LEADER"]         = "領"
L["SHORT_RAID_WARNING"]        = "警"
L["SHORT_SAY"]                 = "說"
L["SHORT_WHISPER"]             = "密自" -- whispers sent to you
L["SHORT_WHISPER_INFORM"]      = "密往" -- whispers sent by you
L["SHORT_YELL"]                = "喊"

------------------------------------------------------------------------
--	Configuration Panel Text
--	Please verify that your translations fit in the available UI space!
------------------------------------------------------------------------

-- L["Configure options for making your chat frames more user-friendly and less cluttered."] = ""

-- L["Color player names"] = ""
L["Enable player name class coloring for all chat message types."] = "將已知玩家名字按職業顏色標識."
-- L["Note that this is just a shortcut to enabling class coloring for each message type individually through the Blizzard chat options."] = ""

L["Disable tab flashing"] = "關閉聊天標籤頁閃爍"
L["Disable the flashing effect on chat tabs that receive new messages."] = "關閉聊天標籤頁閃爍."

-- L["Enable arrow keys"] = ""
L["Enable arrow keys in the chat edit box."] = "允許在輸入框中使用方向鍵."

-- L["Enable resize edges"] = ""
-- L["Enable resize controls at all edges of chat frames, instead of just in the bottom right corner."] = ""

L["Hide buttons"] = "隱藏滾動按鈕"
L["Hide the chat frame menu and scroll buttons."] = "隱藏滾動按鈕."

-- L["Hide extra textures"] = ""
-- L["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = ""

L["Link URLs"] = "URL連結快速複製"
L["Transform URLs in chat into clickable links for easy copying."] = "URL連結快速複製"

L["Lock docked tabs"] = "鎖定已附著的聊天標籤"
L["Prevent locked chat tabs from being dragged unless the Alt key is down."] = "鎖定已附著的聊天標籤（按住Alt拖動）."

-- L["Move edit box"] = ""
L["Move the chat edit box above the chat frame."] = "將輸入框置於聊天視窗頂部."

-- L["Shorten channel names"] = ""
L["Shorten channel names and chat strings."] = "縮寫頻道名和聊天類型名."

L["Sticky chat"] = "保持當前聊天頻道"
L["Set which chat types should be sticky."] = "保持當前聊天頻道."
-- L["All"] = ""
-- L["Default"] = ""
-- L["None"] = ""

-- L["Fade time"] = ""
L["Set the time in minutes to wait before fading chat text. A setting of 0 will disable fading."] = "設置文字消隱時間（0 = 關閉）."

-- L["Font size"] = ""
L["Set the font size for all chat frames."] = "設置所有視窗的字體大小."
-- L["Note that this is just a shortcut to setting the font size for each chat frame individually through the Blizzard chat options."] = ""

L["Filter notifications"] = "屏蔽頻道更改提示信息"
L["Hide channel notification messages."] = "屏蔽頻道更改提示信息."

L["Filter repeats"] = ""
L["Hide repeated messages in public channels."] = "屏蔽公共頻道內的重復信息."

L["Auto-start chat log"] = "自動保存聊天記錄"
L["Automatically start chat logging when you log into the game."] = "自動保存聊天記錄."
-- L["Chat logs are written to [ World of Warcraft > Logs > WoWChatLog.txt ] only when you log out of your character."] = ""
-- L["You can manually start or stop chat logging at any time by typing /chatlog."] = ""

------------------------------------------------------------------------