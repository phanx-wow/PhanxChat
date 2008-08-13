--[[
	zhCN translations for PhanxChat
	Contributed by digmouse <CWDG> Magtheridon CN1 < whhao1988@gmail.com >
]]

if GetLocale() == "zhTW" then PHANXCHAT_LOCALS = {

	CHANNEL_GENERAL			= "綜合",
	CHANNEL_TRADE				= "交易",
	CHANNEL_LOCALDEFENSE		= "本地防務", --need check
	CHANNEL_WORLDDEFENSE		= "世界防務",
	CHANNEL_LOOKINGFORGROUP		= "尋求組隊",
	CHANNEL_GUILDRECRUITMENT		= "公會招募", --need check

	WHO_QUERY_RESULT			= "^%|Hplayer:%w+|h%[(%w+)%]|h: 等級 %d+ %w+%s?[%w]* (%w+)%s?<?[^>]*>? %- .+$", --need check

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

	["enabled"] = "啟用",
	["disabled"] = "禁用",

	["Use /pchat with the following commands:"] = "使用/pchat加上如下命令：",

	["Hide the scroll buttons"] = "隱藏滾動按鈕",
	["Button hiding %s."] = "按鈕隱藏%s。",

	["Shorten channel names and chat strings"] = "縮寫頻道名和聊天類型名",
	["Short channel names %s."] = "簡化頻道名稱%s。",

	["Clear the window"] = "清除聊天視窗內容",

	["Enable arrow keys in the edit box"] = "允許在輸入框中使用方向鍵",
	["Edit box arrow keys %s."] = "輸入框方向控制%s。",

	["Move the edit box above the window"] = "將輸入框置於聊天視窗頂部",
	["Edit box relocation %s."] = "頂置輸入框%s。",

	["Set the text fade time in minutes (0 = disabled)"] = "設置文字消隱時間（0 = 關閉）",
	["Chat fading %s."] = "聊天文字消隱%s。",
	["Chat fade time set to %d minutes."] = "聊天文字消隱設置為%d分鐘。",
	["Fade time is currently set to %d minutes."] = "聊天文字消隱時間目前設置為%d分鐘。",

	["Stop tabs from flashing"] = "關閉聊天標籤頁閃爍",
	["Chat tab flash suppression %s."] = "聊天標籤閃爍功能%s。",

	["Set the font size for all windows"] = "設置所有視窗的字體大小",
	["Chat font size set to %d."] = "聊天視窗字體大小設置為%d。",

	["Log chat text to a file"] = "自動保存聊天記錄",
	["Chat logging %s."] = "自動聊天記錄%s。",

	["Color player names by class if known"] = "將已知玩家名字按職業顏色標識",
	["Player name class coloring %s."] = "玩家名稱染色%s。",

	["Enable mousewheel scrolling"] = "啟用滑鼠捲動",
	["Mousewheel scrolling %s."] = "滑鼠滾輪翻頁%s。",

	["Make more chat types sticky"] = "保持當前聊天頻道",
	["Sticky channels %s."] = "聊天頻道保持%s。",

	["Suppress channel notification messages"] = "屏蔽頻道更改提示信息",
	["Channel notice suppression %s."] = "屏蔽頻道提示信息%s。",

	["Suppress repeated messages in public channels"] = "屏蔽公共頻道內的重復信息",
	["Repeated message suppression %s."] = "屏蔽重復刷屏信息%s。",

	["Lock docked tabs in place (hold Alt to drag)"] = "鎖定已附著的聊天標籤（按住Alt拖動）",
	["Chat tab locking %s."] = "聊天標籤鎖定%s。",

	["Link URLs for easy copying"] = "URL連結快速複製",
	["URL linking %s."] = "URL連結%s。",

	["Version %d loaded."] = "版本%d已載入。",

} end