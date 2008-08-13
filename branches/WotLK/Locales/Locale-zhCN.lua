--[[
	zhCN translations for PhanxChat
	Contributed by digmouse <CWDG> Magtheridon CN1 < whhao1988@gmail.com >
]]

if GetLocale() == "zhCN" then PHANXCHAT_LOCALS = {

	CHANNEL_GENERAL			= "综合",
	CHANNEL_TRADE				= "交易",
	CHANNEL_LOCALDEFENSE		= "本地防务",
	CHANNEL_WORLDDEFENSE		= "世界防务",
	CHANNEL_LOOKINGFORGROUP		= "寻求组队",
	CHANNEL_GUILDRECRUITMENT		= "公会招募", --need check

	WHO_QUERY_RESULT			= "^%|Hplayer:.+|h%[(.+)%]|h: 等级 %d+ .+ (.+)%s?<?[^>]*>? %- .+$", --need check

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

	["enabled"] = "启用",
	["disabled"] = "禁用",

	["Use /pchat with the following commands:"] = "使用/pchat加上如下命令：",

	["Hide the scroll buttons"] = "隐藏滚动按钮",
	["Button hiding %s."] = "按钮隐藏%s。",

	["Shorten channel names and chat strings"] = "缩写频道名和聊天类型名",
	["Short channel names %s."] = "简化频道名称%s。",

	["Clear the window"] = "清除聊天窗口内容",

	["Enable arrow keys in the edit box"] = "允许在输入框中使用方向键",
	["Edit box arrow keys %s."] = "输入框方向控制%s。",

	["Move the edit box above the window"] = "将输入框置于聊天窗口顶部",
	["Edit box relocation %s."] = "顶置输入框%s。",

	["Set the text fade time in minutes (0 = disabled)"] = "设置文字消隐时间（0 = 关闭）",
	["Chat fading %s."] = "聊天文字消隐%s。",
	["Chat fade time set to %d minutes."] = "聊天文字消隐设置为%d分钟。",
	["Fade time is currently set to %d minutes."] = "聊天文字消隐时间目前设置为%d分钟。",

	["Stop tabs from flashing"] = "关闭聊天标签页闪烁",
	["Chat tab flash suppression %s."] = "聊天标签闪烁功能%s。",

	["Set the font size for all windows"] = "设置所有窗口的字体大小",
	["Chat font size set to %d."] = "聊天窗口字体大小设置为%d。",

	["Start chat logging automatically"] = "自动记录聊天内容",
	["Automatic chat logging %s."] = "自动聊天记录%s。",

	["Color player names by class if known"] = "将已知玩家名字按职业颜色标识",
	["Player name class coloring %s."] = "玩家名称染色%s。",

	["Enable mousewheel scrolling"] = "启用鼠标卷动",
	["Mousewheel scrolling %s."] = "鼠标滚轮翻页%s。",

	["Make more chat types sticky"] = "保持当前聊天频道",
	["Sticky channels %s."] = "聊天频道保持%s。",

	["Suppress channel notification messages"] = "屏蔽频道更改提示",
	["Channel notice suppression %s."] = "屏蔽频道提示信息%s。",

	["Suppress repeated messages in public channels"] = "屏蔽公共频道中的重复刷屏信息",
	["Repeated message suppression %s."] = "屏蔽重复信息%s。",

	["Lock docked tabs in place (hold Alt to drag)"] = "锁定已附着的聊天标签（按住Alt拖动）",
	["Chat tab locking %s."] = "聊天标签锁定%s。",

	["Link URLs for easy copying"] = "URL链接快速复制",
	["URL linking %s."] = "URL链接%s。",

	["Version %d loaded."] = "版本%d已载入。",

} end