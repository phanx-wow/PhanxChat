--[[--------------------------------------------------------------------
	Simplified Chinese translations for PhanxChat
	Last updated: 2008 by digmouse
	Contributors:
		digmouse <CWDG> Magtheridon CN1 < whhao1988@gmail.com >
----------------------------------------------------------------------]]

if GetLocale() ~= "zhCN" then return end

local L, _, PhanxChat = { }, ...
PhanxChat.L = L

------------------------------------------------------------------------
-- Channel Names
-- These must match the channel names sent from the server.
------------------------------------------------------------------------

L["General"]          = "综合"
L["Trade"]            = "交易"
L["LocalDefense"]     = "本地防务"
L["WorldDefense"]     = "世界防务"
L["LookingForGroup"]  = "寻求组队"
L["GuildRecruitment"] = "公会招募"

------------------------------------------------------------------------
-- Short Channel Names
-- These should be one- or two-character abbreviations.
------------------------------------------------------------------------

L["SHORT_GENERAL"]          = "综"
L["SHORT_TRADE"]            = "交"
L["SHORT_LOCALDEFENSE"]     = "本"
L["SHORT_WORLDDEFENSE"]     = "世"
L["SHORT_LOOKINGFORGROUP"]  = "寻"
L["SHORT_GUILDRECRUITMENT"] = "招"

------------------------------------------------------------------------
-- Short Chat Strings
-- These should be one- or two-character abbreviations.
------------------------------------------------------------------------

L["SHORT_BATTLEGROUND"]        = "战"
L["SHORT_BATTLEGROUND_LEADER"] = "战领"
L["SHORT_GUILD"]               = "公"
L["SHORT_OFFICER"]             = "官"
L["SHORT_PARTY"]               = "队"
L["SHORT_PARTY_GUIDE"]         = "队" -- needs review
L["SHORT_PARTY_LEADER"]        = "队" -- needs review
L["SHORT_RAID"]                = "团"
L["SHORT_RAID_LEADER"]         = "领"
L["SHORT_RAID_WARNING"]        = "警"
L["SHORT_SAY"]                 = "说"
L["SHORT_WHISPER"]             = "密自"
L["SHORT_WHISPER_INFORM"]      = "密往"
L["SHORT_YELL"]                = "喊"

------------------------------------------------------------------------
--	Configuration Panel Text
--	Please verify that your translations fit in the available UI space!
------------------------------------------------------------------------

-- L["Configure options for making your chat frames more user-friendly and less cluttered."] = ""

-- L["Color player names"] = ""
L["Enable player name class coloring for all chat message types."] = "将已知玩家名字按职业颜色标识."
-- L["Note that this is just a shortcut to enabling class coloring for each message type individually through the Blizzard chat options."] = ""

-- L["Disable tab flashing"] = ""
L["Disable the flashing effect on chat tabs that receive new messages."] = "关闭聊天标签页闪烁."

-- L["Enable arrow keys"] = ""
L["Enable arrow keys in the chat edit box."] = "允许在输入框中使用方向键."

-- L["Enable resize edges"] = ""
-- L["Enable resize controls at all edges of chat frames, instead of just in the bottom right corner."] = ""

L["Hide buttons"] = "隐藏滚动按钮"
L["Hide the chat frame menu and scroll buttons."] = "隐藏滚动按钮."

-- L["Hide extra textures"] = ""
-- L["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = ""

L["Link URLs"] = "URL链接快速复制"
L["Transform URLs in chat into clickable links for easy copying."] = "URL链接快速复制."

-- L["Lock docked tabs"] = ""
L["Prevent locked chat tabs from being dragged unless the Alt key is down."] = "锁定已附着的聊天标签（按住Alt拖动）."

-- L["Move edit box"] = ""
L["Move the chat edit box above the chat frame."] = "将输入框置于聊天窗口顶部."

-- L["Shorten channel names"] = ""
L["Shorten channel names and chat strings."] = "缩写频道名和聊天类型名."

L["Sticky chat"] = "保持当前聊天频道"
L["Set which chat types should be sticky."] = "保持当前聊天频道."
-- L["All"] = ""
-- L["Default"] = ""
-- L["None"] = ""

-- L["Fade time"] = ""
L["Set the time in minutes to wait before fading chat text. A setting of 0 will disable fading."] = "设置文字消隐时间（0 = 关闭）."

-- L["Font size"] = ""
L["Set the font size for all chat frames."] = "设置所有窗口的字体大小."
-- L["Note that this is just a shortcut to setting the font size for each chat frame individually through the Blizzard chat options."] = ""

L["Filter notifications"] = "屏蔽频道更改提示"
L["Hide channel notification messages."] = "屏蔽频道更改提示."

-- L["Filter repeats"] = ""
L["Hide repeated messages in public channels."] = "屏蔽公共频道中的重复刷屏信息."

-- L["Auto-start chat log"] = ""
L["Automatically start chat logging when you log into the game."] = "自动记录聊天内容."
-- L["Chat logs are written to [ World of Warcraft > Logs > WoWChatLog.txt ] only when you log out of your character."] = ""
-- L["You can manually start or stop chat logging at any time by typing /chatlog."] = ""

------------------------------------------------------------------------