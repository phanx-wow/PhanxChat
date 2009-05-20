--[[--------------------------------------------------------------------
	Korean translations for PhanxChat
	Last updated 2009-04-28 by kornshock
	Contributors:
		kornshock @ WoWInterface
		TalksWind (TalksWind님 자료를 약간 수정했습니다. by Fansy)
----------------------------------------------------------------------]]

if GetLocale() ~= "koKR" then return end

local L = {
-- Translating these strings is required for the addon to function in
-- this locale. These strings are used to detect server channel names.

	CHANNEL_GENERAL			= "공개",
	CHANNEL_TRADE				= "거래",
	CHANNEL_LOCALDEFENSE		= "수비",
	CHANNEL_WORLDDEFENSE		= "전쟁",
	CHANNEL_LOOKINGFORGROUP		= "파티찾기",
	CHANNEL_GUILDRECRUITMENT		= "길드모집",

-- Translating these strings is optional, but highly recommended. These
-- strings are displayed if the user has "short channel names" enabled.

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
}

-- Translating these strings is optional, but recommended. These strings
-- are shown in the configuration GUI.

L["Hide buttons"] = "버튼 숨기기"
L["Hide the scroll-up, scroll-down, scroll-to-bottom, and menu buttons next to the chat frame."] = "스크롤 버튼을 숨깁니다."
 
L["Shorten channels"] = "채널명 단축"
L["Shorten channel names in chat messages. For example, '[1. General]' might be shortened to '1|'."] = "메시지에서 채널명을 짧게 표시합니다. 예) 1. 공개 - 1|"
 
L["Enable arrow keys"] = "화살표 키 사용"
L["Enable the use of arrow keys in the chat edit box."] = "메시지 입력창에서 화살표 키를 사용합니다."
 
L["Move chat edit box"] = "메시지 입력창 이동"
L["Move the chat edit box to the top of the chat frame."] = "메시지 입력창을 채팅창 위로 이동합니다."
 
L["Chat fade time"] = "메시지 사라짐 설정"
L["Set the time in minutes to keep chat messages visible before fading them out. Setting this to 0 will disable fading completely."] = "메시지가 사라지는 시간을 설정합니다. (0 = 사라지지 않음)"
 
L["Disable tab flashing"] = "탭 플래시 효과 제거"
L["Disable the flashing effect on chat tabs when new messages are received."] = "새 메시지 도착시의 탭 플래시 효과를 제거합니다."
 
L["Chat font size"] = "메시지 폰트 크기 설정"
L["Set the font size for all chat tabs at once. This is only a shortcut for doing the same thing for each tab using the default UI."] = "메시지의 폰트 크기를 설정합니다."
 
L["Auto-start logging"] = "자동 채팅로그파일 생성"
L["Automatically enable chat logging when you log in. Chat logging can be started or stopped manually at any time using the '/chatlog' command. Logs are saved when you log out or exit the game to the 'World of Warcraft/Logs/WoWChatLog.txt' file."] = "로그인시 자동 채팅로그파일을 생성합니다. 로그파일 생성은 언제든지 중지하거나 시작할 수 있습니다(/chatlog). 로그아웃을 하면 채팅로그가 World of Warcraft/Logs/WoWChatLog.txt 에 저장됩니다."
 
L["Color player names"] = "직업별 캐릭터명 색상"
L["Color player names in chat by their class if known. Classes are known if you have seen the player in your group, in your guild, online on your friends list, in a '/who' query, or have targetted or moused over them since you logged in."] = "알려진 캐릭터명에 대해 직업 색상을 적용합니다."
 
L["Mousewheel scrolling"] = "마우스휠 버튼 사용"
L["Enable scrolling through chat frames with the mouse wheel. Hold the Shift key while scrolling to jump to the top or bottom of the chat frame."] = "마우스휠 버튼으로 채팅창을 스크롤 할 수 있도록 설정합니다."
 
L["Sticky channels"] = "채널 고정"
L["Enable sticky channel behavior for all chat types except emotes."] = "감정표현을 제외한 모든 메시지에 대해 채널을 고정합니다."
 
L["Suppress notifications"] = "알림메시지 제거"
L["Suppress the notification messages informing you when someone leaves or joins a channel, or when channel ownership changes."] = "채널 관련 알림메시지를 보여주지 않습니다."
 
L["Suppress repeats"] = "반복메시지 필터"
L["Suppress repeated messages in public chat channels."] = "공개 채널에서 반복되는 메시지를 필터링합니다."
 
L["Lock tabs"] = "탭 고정"
L["Prevent docked chat tabs from being dragged unless the Alt key is down."] = "채팅 탭을 고정합니다.(알트키를 누른 상태에서 이동 가능)"
 
L["Link URLs"] = "URL 링크"
L["Turn URLs in chat messages into clickable links for easy copying."] = "쉬운 URL 복사를 위해 채팅창의 URL 을 클릭가능한 링크로 표시합니다."

-- Don't touch this.

PHANXCHAT_LOCALS = L