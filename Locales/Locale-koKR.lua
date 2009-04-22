--[[--------------------------------------------------------------------
	Korean translations for PhanxChat
	Last updated 2008-09-17 by TalksWind
	Contributors:
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

L["Hide buttons"] = "스크롤 버튼을 숨김니다"
L["Hide the scroll-up, scroll-down, scroll-to-bottom, and menu buttons next to the chat frame."] = "스크롤 버튼을 숨김니다"

L["Shorten channels"] = "채널 이름과 대화 구문열을 짧게 합니다"
L["Shorten channel names in chat messages. For example, '[1. General]' might be shortened to '1|'."] = "채널 이름과 대화 구문열을 짧게 합니다"

L["Enable arrow keys"] = "편집 박스에서 화살표 키를 활성화합니다"
L["Enable the use of arrow keys in the chat edit box."] = "편집 박스에서 화살표 키를 활성화합니다"

L["Move chat edit box"] = "창 위로 편집 박스를 이동시킵니다"
L["Move the chat edit box to the top of the chat frame."] = "창 위로 편집 박스를 이동시킵니다"

L["Disable tab flashing"] = "번쩍임으로 부터 탭을 중단시킵니다"
L["Disable the flashing effect on chat tabs when new messages are received."] = "번쩍임으로 부터 탭을 중단시킵니다"

L["Auto-start logging"] = "대화글 기록을 자동으로 시작합니다"
L["Automatically enable chat logging when you log in. Chat logging can be started or stopped manually at any time using the '/chatlog' command. Logs are saved when you log out or exit the game to the 'World of Warcraft/Logs/WoWChatLog.txt' file."] = "대화글 기록을 자동으로 시작합니다"

L["Color player names"] = "이미 알고 있다면 직업에 따라 플레이어 이름을 색상화합니다"
L["Color player names in chat by their class if known. Classes are known if you have seen the player in your group, in your guild, online on your friends list, in a '/who' query, or have targetted or moused over them since you logged in."] = "이미 알고 있다면 직업에 따라 플레이어 이름을 색상화합니다"

L["Mousewheel scrolling"] = "마우스휠 스크롤을 활성화합니다"
L["Enable scrolling through chat frames with the mouse wheel. Hold the Shift key while scrolling to jump to the top or bottom of the chat frame."] = "마우스휠 스크롤을 활성화합니다"

L["Sticky channels"] = "더 많은 대화 유형에 고정되도록 만듭니다"
L["Enable sticky channel behavior for all chat types except emotes."] = "더 많은 대화 유형에 고정되도록 만듭니다"

L["Suppress notifications"] = "채널 알림 메시지를 억제합니다"
L["Suppress the notification messages informing you when someone leaves or joins a channel, or when channel ownership changes."] = "채널 알림 메시지를 억제합니다"

L["Suppress repeats"] = "공용 채널에서 반복되는 메시지를 억제합니다"
L["Suppress repeated messages in public chat channels."] = "공용 채널에서 반복되는 메시지를 억제합니다"

L["Lock tabs"] = "현 위치에 고정된 탭을 잠금니다"
L["Prevent docked chat tabs from being dragged unless the Alt key is down."] = "현 위치에 고정된 탭을 잠금니다 (잡아 끌기는 ALT 누름)"

L["Link URLs"] = "쉬운 복사를 위해 URL에 링크를 합니다"
L["Turn URLs in chat messages into clickable links for easy copying."] = "쉬운 복사를 위해 URL에 링크를 합니다"

L["Chat fade time"] = "분 단위로 글 사라짐 시간을 설정합니다"
L["Set the time in minutes to keep chat messages visible before fading them out. Setting this to 0 will disable fading completely."] = "분 단위로 글 사라짐 시간을 설정합니다 (0 = 비활성화)"

L["Chat font size"] = "모든 창을 위한 글꼴 크기를 설정합니다"
L["Set the font size for all chat tabs at once. This is only a shortcut for doing the same thing for each tab using the default UI."] = "모든 창을 위한 글꼴 크기를 설정합니다"

-- Don't touch this.

PHANXCHAT_LOCALS = L