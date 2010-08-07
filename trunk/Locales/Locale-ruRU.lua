------------------------------------------------------------------------
--	PhanxChat                                                         --
--	Removes chat frame clutter and adds some functionality.           --
--	by Phanx < addons@phanx.net >                                     --
--	Copyright © 2006–2010 Phanx. See README for license terms.        --
--	http://www.wowinterface.com/downloads/info6323-PhanxChat.html     --
--	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx  --
------------------------------------------------------------------------
--	Localization: ruRU / Russian / Русский
--	Last Updated: 2010-08-06 by hungry2 < curse.com >
------------------------------------------------------------------------

if GetLocale() ~= "ruRU" then return end
local L, _, PhanxChat = { }, ...
PhanxChat.L = L

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

L["Conversation"]     = "Разговор"
L["General"]          = "Общий"
L["GuildRecruitment"] = "Гильдии"
L["LocalDefense"]     = "Оборона"
L["LookingForGroup"]  = "Поиск спутников"
L["Trade"]            = "Торговля"
L["WorldDefense"]     = "Оборона: глобальный"

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

L.CONVERSATION_ABBR       = "Ра"
L.GENERAL_ABBR            = "О"
L.GUILDRECRUITMENT_ABBR   = "НвГ"
L.LOCALDEFENSE_ABBR       = "ЛО"
L.LOOKINGFORGROUP_ABBR    = "ЛФГ"
L.TRADE_ABBR              = "Т"
L.WORLDDEFENSE_ABBR       = "МО"

L.BATTLEGROUND_ABBR        = "ПБ"
L.BATTLEGROUND_LEADER_ABBR = "ЛПБ"
L.GUILD_ABBR               = "Г"
L.OFFICER_ABBR             = "Оф"
L.PARTY_ABBR               = "Гр"
L.PARTY_GUIDE_ABBR         = "ГрЛ"
L.PARTY_LEADER_ABBR        = "ГрЛ"
L.RAID_ABBR                = "Р"
L.RAID_LEADER_ABBR         = "РЛ"
L.RAID_WARNING_ABBR        = "РВ"
L.SAY_ABBR                 = "С"
L.YELL_ABBR                = "К"
L.WHISPER_ABBR             = "Ш" -- incoming
L.WHISPER_INFORM_ABBR      = "Ш" -- outgoing

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

L["Short channel names"] = "Короткие имена каналов"
L["Shorten channel names and chat strings."] = "Сокращать имена каналов и строчки чата."
L["Short player names"] = "Короткие имена игроков"
L["Shorten player names by removing realm names and Real ID last names."] = "Сокращать имена игроков, удаляя названия серверов и фамилии Real ID."
L["Replace real names"] = "Заменить реальное имя"
L["Replace Real ID names with character names."] = "Заменять Real ID имена на имена персонажей."
L["Enable arrow keys"] = "Включить стрелки"
L["Enable arrow keys in the chat edit box."] = "Использовать стрелки курсора в окне редактирования сообщения."
L["Enable resize edges"] = "Включить рамку размера"
L["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."] = "Включить рамку изменения размера окна чата, вместо только нижнего правого угла."
L["Link URLs"] = "Копирование ссылок"
L["Transform URLs in chat into clickable links for easy copying."] = "Превратить ссылки в чате в кликабельные для простоты копирования."
L["Lock docked tabs"] = "Зафиксировать вкладки"
L["Prevent docked chat tabs from being dragged unless the Shift key is down."] = "Запретить перетаскивание зафиксированных вкладок без зажатого Shift."
L["Move edit boxes"] = "Переместить окно ввода"
L["Move chat edit boxes to the top their respective chat frame."] = "Переместить окно ввода наверх окна чата."
L["Hide buttons"] = "Скрыть кнопки"
L["Hide the chat frame menu and scroll buttons."] = "Скрыть кнопку \"Общение\" и кнопки прокрутки."
L["Hide extra textures"] = "Скрыть текстуры"
L["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = "Скрыть дополнительные текстуры вкладок и окна ввода сообщения, добавленныe а патче 3.3.5."
L["Hide tab flash"] = "Скрыть мигание вкладок"
L["Disable the flashing effect on chat tabs that receive new messages."] = "Отключить мигание вкладок с новыми сообщениями."
L["Hide notices"] = "Скрыть уведомления"
L["Hide channel notification messages."] = "Скрывать информационные сообщения канала."
L["Hide repeats"] = "Скрыть повторы"
L["Hide repeated messages in public channels."] = "Скрывать повторяющиеся сообщения в общих каналах."
L["Sticky chat"] = "Запоминать последний ввод"
L["Set which chat types should be sticky."] = "Установить какие типы чата должны запоминать последний ввод, быть \"липкими\"."
L["All"] = "Все"
L["Default"] = "По умолчанию"
L["None"] = "Никакие"
L["Fade time"] = "Время угасания"
L["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."] = "Установить время в минутах перед угасанием чата. Установив значение в 0 вы отмените угасание."
L["Font size"] = "Размер шрифта"
L["Set the font size for all chat frames."] = "Установить размер шрифта для всех окон чата."
L["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."] = "Заметьте, что это просто настраивает каждую вкладку индивидуально, как вы могли бы сделать обычным способом, через управление чатом в меню."

------------------------------------------------------------------------