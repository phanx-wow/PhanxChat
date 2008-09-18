--[[
	koKR translations for PhanxChat
	Contributed by TalksWind (TalksWind님 자료를 약간 수정했습니다. by Fansy) -date: 2008.09.17
]]

if GetLocale() == "koKR" then PHANXCHAT_LOCALS = {

	CHANNEL_GENERAL			= "공개",
	CHANNEL_TRADE				= "거래",
	CHANNEL_LOCALDEFENSE		= "수비",
	CHANNEL_WORLDDEFENSE		= "전쟁",
	CHANNEL_LOOKINGFORGROUP		= "파티찾기",
	CHANNEL_GUILDRECRUITMENT		= "길드모집",

	WHO_QUERY_RESULT			= "^%|Hplayer:.+|h%[(.+)%]|h: 레벨 %d+ .+%s?[.]* (.+)%s?<?[^>]*>? %- .+$", --need check

	SHORT_GENERAL 				= "공",
	SHORT_TRADE 				= "거",
	SHORT_LOCALDEFENSE 			= "수",
	SHORT_WORLDDEFENSE 			= "쟁",
	SHORT_LOOKINGFORGROUP		= "파찾",
	SHORT_GUILDRECRUITMENT		= "모집",

	SHORT_SAY 				= "S",
	SHORT_YELL 				= "Y",
	SHORT_GUILD 				= "G",
	SHORT_OFFICER 				= "O",
	SHORT_PARTY 				= "P",
	SHORT_RAID 				= "R",
	SHORT_RAID_LEADER 			= "RL",
	SHORT_RAID_WARNING 			= "RW",
	SHORT_BATTLEGROUND 			= "BG",
	SHORT_BATTLEGROUND_LEADER 	= "BGL",
	SHORT_WHISPER 				= "FROM",
	SHORT_WHISPER_INFORM 		= "TO",

	["enabled"] = "활성화",
	["disabled"] = "비활성화",

	["Use /pchat with the following commands:"] = "다음의 명령어와 함께 /pchat을 사용하십시오:",

	["Hide the scroll buttons"] = "스크롤 버튼을 숨김니다.",
	["Button hiding %s."] = "버튼 숨김 기능이 %s되었습니다.",

	["Shorten channel names and chat strings"] = "채널 이름과 대화 구문열을 짧게 합니다.",
	["Short channel names %s."] = "짧은 채널이름 기능이 %s되었습니다.",

	["Clear the window"] = "창을 정리합니다.",

	["Enable arrow keys in the edit box"] = "편집 박스에서 화살표 키를 활성화합니다.",
	["Edit box arrow keys %s."] = "편집 박스 화살표 키 기능이 %s되었습니다.",

	["Move the edit box above the window"] = "창 위로 편집 박스를 이동시킵니다.",
	["Edit box relocation %s."] = "편집 박스 위치 재이동 기능이 %s되었습니다.",

	["Set the text fade time in minutes (0 = disabled)"] = "분 단위로 글 사라짐 시간을 설정합니다. (0 = 비활성화)",
	["Chat fading %s."] = "대화글 사라짐 기능이 %s되었습니다.",
	["Chat fade time set to %d minutes."] = "대화글 사라짐 시간이 %d분으로 설정되었습니다.",
	["Fade time is currently set to %d minutes."] = "사라짐 시간이 현재 %d분으로 설정되어 있습니다.",

	["Stop tabs from flashing"] = "번쩍임으로 부터 탭을 중단시킵니다.",
	["Chat tab flash suppression %s."] = "대화 탭 번쩍임 억제 기능이 %s되었습니다.",

	["Set the font size for all windows"] = "모든 창을 위한 글꼴 크기를 설정합니다.",
	["Chat font size set to %d."] = "대화 글꼴 크기가 %d|1으로;로; 설정되었습니다.",

	["Start chat logging automatically"] = "대화글 기록을 자동으로 시작합니다.",
	["Automatic chat logging %s."] = "자동으로 대화글 기록 기능이 %s되었습니다.",

	["Color player names by class if known"] = "이미 알고 있다면 직업에 따라 플레이어 이름을 색상화합니다.",
	["Player name class coloring %s."] = "플레이어 이름 직업 색상화 기능이 %s되었습니다.",

	["Enable mousewheel scrolling"] = "마우스휠 스크롤을 활성화합니다.",
	["Mousewheel scrolling %s."] = "마우스휠 스크롤 기능이 %s되었습니다.",

	["Make more chat types sticky"] = "더 많은 대화 유형에 고정되도록 만듭니다.",
	["Sticky channels %s."] = "채널 고정 기능이 %s되었습니다.",

	["Suppress channel notification messages"] = "채널 알림 메시지를 억제합니다.",
	["Channel notice suppression %s."] = "채널 알림 억제 기능이 %s되었습니다.",

	["Suppress repeated messages in public channels"] = "공용 채널에서 반복되는 메시지를 억제합니다.",
	["Repeated message suppression %s."] = "반복되는 메시지 억제 기능이 %s되었습니다.",

	["Lock docked tabs in place (hold ALT to drag)"] = "현 위치에 고정된 탭을 잠금니다. (잡아 끌기는 ALT 누름)",
	["Chat tab locking %s."] = "대화 탭 잠금 기능이 %s되었습니다.",

	["Link URLs for easy copying"] = "쉬운 복사를 위해 URL에 링크를 합니다.",
	["URL linking %s."] = "URL 링크 기능이 %s되었습니다.",

	["Version %d loaded."] = "버전 %d|1을;를; 불러들였습니다.",

} end