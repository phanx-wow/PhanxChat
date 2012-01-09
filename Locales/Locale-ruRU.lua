--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Written by Phanx <addons@phanx.net>
	Copyright © 2006–2012 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
------------------------------------------------------------------------
	Localization: ruRU / Russian / Русский
	Last Updated: 2010-08-06 by hungry2 < curse.com >
----------------------------------------------------------------------]]

if GetLocale() ~= "ruRU" then return end
local _, PhanxChat = ...
PhanxChat.L = {

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

	["Conversation"]     = "Разговор",
	["General"]          = "Общий",
	["GuildRecruitment"] = "Гильдии",
	["LocalDefense"]     = "Оборона",
	["LookingForGroup"]  = "Поиск спутников",
	["Trade"]            = "Торговля",
	["WorldDefense"]     = "Оборона: глобальный",

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

	CONVERSATION_ABBR       = "Ра",
	GENERAL_ABBR            = "О",
	GUILDRECRUITMENT_ABBR   = "НвГ",
	LOCALDEFENSE_ABBR       = "ЛО",
	LOOKINGFORGROUP_ABBR    = "ЛФГ",
	TRADE_ABBR              = "Т",
	WORLDDEFENSE_ABBR       = "МО",

	BATTLEGROUND_ABBR        = "ПБ",
	BATTLEGROUND_LEADER_ABBR = "ЛПБ",
	GUILD_ABBR               = "Г",
	OFFICER_ABBR             = "Оф",
	PARTY_ABBR               = "Гр",
	PARTY_GUIDE_ABBR         = "ГрЛ",
	PARTY_LEADER_ABBR        = "ГрЛ",
	RAID_ABBR                = "Р",
	RAID_LEADER_ABBR         = "РЛ",
	RAID_WARNING_ABBR        = "РВ",
	SAY_ABBR                 = "С",
	YELL_ABBR                = "К",
	WHISPER_ABBR             = "Ш", -- incoming
	WHISPER_INFORM_ABBR      = "Ш", -- outgoing

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

	["Short channel names"] = "Короткие имена каналов",
	["Shorten channel names and chat strings."] = "Сокращать имена каналов и строчки чата.",
	["Short player names"] = "Короткие имена игроков",
	["Shorten player names by removing realm names and Real ID last names."] = "Сокращать имена игроков, удаляя названия серверов и фамилии Real ID.",
	["Replace real names"] = "Заменить реальное имя",
	["Replace Real ID names with character names."] = "Заменять Real ID имена на имена персонажей.",
	["Enable arrow keys"] = "Включить стрелки",
	["Enable arrow keys in the chat edit box."] = "Использовать стрелки курсора в окне редактирования сообщения.",
	["Enable resize edges"] = "Включить рамку размера",
	["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."] = "Включить рамку изменения размера окна чата, вместо только нижнего правого угла.",
	["Link URLs"] = "Копирование ссылок",
	["Transform URLs in chat into clickable links for easy copying."] = "Превратить ссылки в чате в кликабельные для простоты копирования.",
	["Lock docked tabs"] = "Зафиксировать вкладки",
	["Prevent docked chat tabs from being dragged unless the Shift key is down."] = "Запретить перетаскивание зафиксированных вкладок без зажатого Shift.",
	["Move edit boxes"] = "Переместить окно ввода",
	["Move chat edit boxes to the top their respective chat frame."] = "Переместить окно ввода наверх окна чата.",
	["Hide buttons"] = "Скрыть кнопки",
	["Hide the chat frame menu and scroll buttons."] = "Скрыть кнопку \"Общение\" и кнопки прокрутки.",
	["Hide extra textures"] = "Скрыть текстуры",
	["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = "Скрыть дополнительные текстуры вкладок и окна ввода сообщения, добавленныe а патче 3.3.5.",
	["Hide tab flash"] = "Скрыть мигание вкладок",
	["Disable the flashing effect on chat tabs that receive new messages."] = "Отключить мигание вкладок с новыми сообщениями.",
	["Hide notices"] = "Скрыть уведомления",
	["Hide channel notification messages."] = "Скрывать информационные сообщения канала.",
	["Hide repeats"] = "Скрыть повторы",
	["Hide repeated messages in public channels."] = "Скрывать повторяющиеся сообщения в общих каналах.",
	["Sticky chat"] = "Запоминать последний ввод",
	["Set which chat types should be sticky."] = "Установить какие типы чата должны запоминать последний ввод, быть \"липкими\".",
	["All"] = "Все",
	["Default"] = "По умолчанию",
	["None"] = "Никакие",
	["Fade time"] = "Время угасания",
	["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."] = "Установить время в минутах перед угасанием чата. Установив значение в 0 вы отмените угасание.",
	["Font size"] = "Размер шрифта",
	["Set the font size for all chat frames."] = "Установить размер шрифта для всех окон чата.",
	["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."] = "Заметьте, что это просто настраивает каждую вкладку индивидуально, как вы могли бы сделать обычным способом, через управление чатом в меню.",

------------------------------------------------------------------------

}