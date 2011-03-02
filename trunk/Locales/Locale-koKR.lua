--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2006–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx
------------------------------------------------------------------------
	Localization: koKR / Korean / 한국어
	Last Updated: 2010-12-30 by talkswind < curse.com >
----------------------------------------------------------------------]]

if GetLocale() ~= "koKR" then return end
local _, PhanxChat = ...
PhanxChat.L = {

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

	["Conversation"]     = "대화",
	["General"]          = "공개",
	["GuildRecruitment"] = "길드모집",
	["LocalDefense"]     = "수비",
	["LookingForGroup"]  = "파티찾기",
	["Trade"]            = "거래",
	["WorldDefense"]     = "전쟁",

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

	CONVERSATION_ABBR     = "대화",
	GENERAL_ABBR          = "공",
	GUILDRECRUITMENT_ABBR = "길모",
	LOCALDEFENSE_ABBR     = "수",
	LOOKINGFORGROUP_ABBR  = "파찾",
	TRADE_ABBR            = "거",
	WORLDDEFENSE_ABBR     = "쟁",

	BATTLEGROUND_ABBR        = "전장",
	BATTLEGROUND_LEADER_ABBR = "전지",
	GUILD_ABBR               = "길",
	OFFICER_ABBR             = "관",
	PARTY_ABBR               = "파",
	PARTY_GUIDE_ABBR         = "파지",
	PARTY_LEADER_ABBR        = "파대",
	RAID_ABBR                = "공",
	RAID_LEADER_ABBR         = "공대",
	RAID_WARNING_ABBR        = "공경",
	SAY_ABBR                 = "일",
	YELL_ABBR                = "외",
	WHISPER_ABBR             = "귓받", -- incoming
	WHISPER_INFORM_ABBR      = "귓전", -- outgoing

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

	["Short channel names"] = "채널 이름 줄임",
	["Shorten channel names and chat strings."] = "채널 이름과 대화 구문열을 줄입니다.",
	["Short player names"] = "플레이어 이름 줄임",
	["Shorten player names by removing realm names and Real ID last names."] = "서버 이름과 뒷이름의 실제 ID 제거를 통해 플레이어 이름을 줄입니다.",
	["Replace real names"] = "서버 이름 대체",
	["Replace Real ID names with character names."] = "캐릭터 이름으로 실제 ID 이름을 대체합니다.",
	["Enable arrow keys"] = "화살표 키 활성화",
	["Enable arrow keys in the chat edit box."] = "대화 입력 박스에서 화살표 키를 활성화합니다.",
	["Enable resize edges"] = "구석 크기 조절 활성화",
	["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."] = "하단 오른쪽 모서리에 한정 된 것이 아닌, 모든 대화창 구석에서의 크기 조절을 활성화합니다.",
	["Link URLs"] = "URL 링크",
	["Transform URLs in chat into clickable links for easy copying."] = "대화 메시지에서 쉬운 복사를 위해 클릭이 가능한 링크로 URL을 변환합니다.",
	["Lock docked tabs"] = "고정된 탭 잠금",
	["Prevent docked chat tabs from being dragged unless the Shift key is down."] = "고정된 대화창 탭을 Shift 키를 누르지 않고도 잡아 끌 수 있는 것을 방지합니다.",
	["Move edit boxes"] = "대화 입력 박스 이동",
	["Move chat edit boxes to the top their respective chat frame."] = "대화 입력 박스를 그것의 각각의 대화창의 상단으로 이동합니다.",
	["Hide buttons"] = "버튼 숨김",
	["Hide the chat frame menu and scroll buttons."] = "대화창 메뉴와 스크롤 버튼을 숨깁니다.",
	["Hide extra textures"] = "별도의 텍스쳐 숨김",
	["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = "3.3.5. 패치에서 대화창 탭과 편집 박스에 추가된 별도의 텍스쳐를 숨깁니다.",
	["Hide tab flash"] = "탭 번쩍임 숨김",
	["Disable the flashing effect on chat tabs that receive new messages."] = "새로운 메시지를 받은 경우에 대화창 탭에서의 번쩍임 효과를 비활성화합니다.",
	["Hide notices"] = "알림 메시지 숨김",
	["Hide channel notification messages."] = "채널 알림 메시지를 숨깁니다.",
	["Hide repeats"] = "반복 메시지 숨김",
	["Hide repeated messages in public channels."] = "공용 채널에서 반복되는 메시지를 숨깁니다.",
	["Sticky chat"] = "채널 고정",
	["Set which chat types should be sticky."] = "어떤 유형의 채널을 고정할 것인지를 설정합니다.",
	["All"] = "모두",
	["Default"] = "기본값",
	["None"] = "없음",
	["Fade time"] = "사라짐 시간",
	["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."] = "대화 메시지가 사라지기 전에 기다려야 할 분단위 시간을 설정합니다. 이것을 0으로 설정하면 사라짐 기능을 비활성화하게 됩니다.",
	["Font size"] = "글꼴 크기",
	["Set the font size for all chat frames."] = "대화창 모두에 적용할 글꼴 크기를 설정합니다.",
	["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."] = "이것은 블리자드 대화창 옵션을 통해 각각의 대화창을 개별적으로 설정하기 위한 하나의 지름길이란 점에 유의하십시요.",

------------------------------------------------------------------------

}