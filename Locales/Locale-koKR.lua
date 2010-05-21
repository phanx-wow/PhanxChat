--[[--------------------------------------------------------------------
	Korean translations for PhanxChat
	Last updated: 2009-04-28 by kornshock
	Contributors:
		kornshock (WoWInterface)
		TalksWind (TalksWind님 자료를 약간 수정했습니다. by Fansy)
----------------------------------------------------------------------]]

if GetLocale() ~= "koKR" then return end

local L, _, PhanxChat = { }, ...
PhanxChat.L = L

------------------------------------------------------------------------
-- Channel Names
-- These must match the channel names sent from the server.
------------------------------------------------------------------------

L["General"]          = "공개"
L["Trade"]            = "거래"
L["LocalDefense"]     = "수비"
L["WorldDefense"]     = "전쟁"
L["LookingForGroup"]  = "파티찾기"
L["GuildRecruitment"] = "길드모집"

------------------------------------------------------------------------
-- Short Channel Names
-- These should be one- or two-character abbreviations.
------------------------------------------------------------------------

L["SHORT_GENERAL"]          = "공"
L["SHORT_TRADE"]            = "거"
L["SHORT_LOCALDEFENSE"]     = "수"
L["SHORT_WORLDDEFENSE"]     = "쟁"
L["SHORT_LOOKINGFORGROUP"]  = "파찾"
L["SHORT_GUILDRECRUITMENT"] = "모집"

------------------------------------------------------------------------
-- Short Chat Strings
-- These should be one- or two-character abbreviations.
------------------------------------------------------------------------

L["SHORT_BATTLEGROUND"]        = "BG"
L["SHORT_BATTLEGROUND_LEADER"] = "BGL"
L["SHORT_GUILD"]               = "G"
L["SHORT_OFFICER"]             = "O"
L["SHORT_PARTY"]               = "P"
L["SHORT_PARTY_GUIDE"]         = "PL"
L["SHORT_PARTY_LEADER"]        = "PL"
L["SHORT_RAID"]                = "R"
L["SHORT_RAID_LEADER"]         = "RL"
L["SHORT_RAID_WARNING"]        = "RW"
L["SHORT_SAY"]                 = "S"
L["SHORT_WHISPER"]             = "FROM"
L["SHORT_WHISPER_INFORM"]      = "TO"
L["SHORT_YELL"]                = "Y"

------------------------------------------------------------------------
--	Configuration Panel Text
--	Please verify that your translations fit in the available UI space!
------------------------------------------------------------------------

-- L["Configure options for making your chat frames more user-friendly and less cluttered."] = ""

L["Color player names"] = "직업별 캐릭터명 색상"
L["Enable player name class coloring for all chat message types."] = "알려진 캐릭터명에 대해 직업 색상을 적용합니다."
-- L["Note that this is just a shortcut to enabling class coloring for each message type individually through the Blizzard chat options."] = ""

L["Disable tab flashing"] = "탭 플래시 효과 제거"
L["Disable the flashing effect on chat tabs that receive new messages."] = "새 메시지 도착시의 탭 플래시 효과를 제거합니다."

L["Enable arrow keys"] = "화살표 키 사용"
L["Enable arrow keys in the chat edit box."] = "메시지 입력창에서 화살표 키를 사용합니다."

-- L["Enable resize edges"] = ""
-- L["Enable resize controls at all edges of chat frames, instead of just in the bottom right corner."] = ""

L["Hide buttons"] = "버튼 숨기기"
L["Hide the chat frame menu and scroll buttons."] = "스크롤 버튼을 숨깁니다."

-- L["Hide extra textures"] = ""
-- L["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = ""

L["Link URLs"] = "URL 링크"
L["Transform URLs in chat into clickable links for easy copying."] = "쉬운 URL 복사를 위해 채팅창의 URL 을 클릭가능한 링크로 표시합니다."

L["Lock docked tabs"] = "탭 고정"
L["Prevent locked chat tabs from being dragged unless the Alt key is down."] = "채팅 탭을 고정합니다. 알트키를 누른 상태에서 이동 가능."

L["Move edit box"] = "메시지 입력창 이동"
L["Move the chat edit box above the chat frame."] = "메시지 입력창에서 화살표 키를 사용합니다."

L["Shorten channel names"] = "채널명 단축"
L["Shorten channel names and chat strings."] = "메시지에서 채널명을 짧게 표시합니다."

L["Sticky chat"] = "채널 고정"
L["Set which chat types should be sticky."] = "감정표현을 제외한 모든 메시지에 대해 채널을 고정합니다." -- needs review
-- L["All"] = ""
-- L["Default"] = ""
-- L["None"] = ""

L["Fade time"] = "메시지 사라짐 설정"
L["Set the time in minutes to wait before fading chat text. A setting of 0 will disable fading."] = "메시지가 사라지는 시간을 설정합니다. 0 = 사라지지 않음."

L["Font size"] = "메시지 폰트 크기 설정"
L["Set the font size for all chat frames."] = "메시지의 폰트 크기를 설정합니다."
-- L["Note that this is just a shortcut to setting the font size for each chat frame individually through the Blizzard chat options."] = ""

L["Filter notifications"] = "알림메시지 제거"
L["Hide channel notification messages."] = "채널 관련 알림메시지를 보여주지 않습니다."

L["Filter repeats"] = "반복메시지 필터"
L["Hide repeated messages in public channels."] = "공개 채널에서 반복되는 메시지를 필터링합니다."

L["Auto-start chat log"] = "자동 채팅로그파일 생성"
L["Automatically start chat logging when you log into the game."] = "로그인시 자동 채팅로그파일을 생성합니다."
L["Chat logs are written to [ World of Warcraft > Logs > WoWChatLog.txt ] only when you log out of your character."] = "로그아웃을 하면 채팅로그가 World of Warcraft/Logs/WoWChatLog.txt 에 저장됩니다."
L["You can manually start or stop chat logging at any time by typing /chatlog."] = "로그파일 생성은 언제든지 중지하거나 시작할 수 있습니다(/chatlog)."

------------------------------------------------------------------------