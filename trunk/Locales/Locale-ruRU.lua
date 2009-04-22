--[[--------------------------------------------------------------------
	Russian translations for PhanxChat
	Last updated yyyy-mm-dd by Valle of Warsong
	Contributors:
		Valle of Warsong
----------------------------------------------------------------------]]

if GetLocale() ~= "ruRU" then return end

local L = {
-- Translating these strings is required for the addon to function in
-- this locale. These strings are used to detect server channel names.

	CHANNEL_GENERAL			= "Общий",
	CHANNEL_TRADE				= "Торговля",
	CHANNEL_LOCALDEFENSE		= "Оборона: локальный",
	CHANNEL_WORLDDEFENSE		= "Оборона: глобальный",
	CHANNEL_LOOKINGFORGROUP		= "Поис спутников",
	CHANNEL_GUILDRECRUITMENT		= "Набор в гильдии",

-- Translating these strings is optional, but highly recommended. These
-- strings are displayed if the user has "short channel names" enabled.

	SHORT_GENERAL 				= "О",
	SHORT_TRADE 				= "Т",
	SHORT_LOCALDEFENSE 			= "ЛО",
	SHORT_WORLDDEFENSE 			= "МО",
	SHORT_LOOKINGFORGROUP		= "ЛФГ",
	SHORT_GUILDRECRUITMENT		= "НвГ",

	SHORT_SAY 				= "С",
	SHORT_YELL 				= "К",
	SHORT_GUILD 				= "Г",
	SHORT_OFFICER 				= "Оф",
	SHORT_PARTY 				= "Гр",
	SHORT_RAID 				= "Р",
	SHORT_RAID_LEADER 			= "РЛ",
	SHORT_RAID_WARNING 			= "РВ",
	SHORT_BATTLEGROUND 			= "ПБ",
	SHORT_BATTLEGROUND_LEADER 	= "ЛПБ",
	SHORT_WHISPER 				= "Ш",
	SHORT_WHISPER_INFORM 		= "Ш",
}

-- Translating these strings is optional, but recommended. These strings
-- are shown in the configuration GUI.

L["Hide buttons"] = "Скрыть кнопки чата"
L["Hide the scroll-up, scroll-down, scroll-to-bottom, and menu buttons next to the chat frame."] = "Скрыть кнопки чата"

L["Shorten channels"] = "Сокращать названия каналов"
L["Shorten channel names in chat messages. For example, '[1. General]' might be shortened to '1|'."] = "Сокращать названия каналов и строки чата"

L["Enable arrow keys"] = "Использовать кнопки передвижения"
L["Enable the use of arrow keys in the chat edit box."] = "Использовать кнопки передвижения в строке ввода"

L["Move chat edit box"] = "Перемещение строки ввода"
L["Move the chat edit box to the top of the chat frame."] = "Переместить строку ввода наверх"

L["Chat fade time"] = "Исчезновение текста"
L["Set the time in minutes to keep chat messages visible before fading them out. Setting this to 0 will disable fading completely."] = "Установить время исчезновения текста в минутах (0 = отключить)"

L["Disable tab flashing"] = "Отключить мерцание закладок"
L["Disable the flashing effect on chat tabs when new messages are received."] = "Отключить мерцание закладок"

L["Chat font size"] = "Установить размер шрифта"
L["Set the font size for all chat tabs at once. This is only a shortcut for doing the same thing for each tab using the default UI."] = "Установить размер шрифта для всех окон"

L["Auto-start logging"] = "Автоматическое включение записи чата"
L["Automatically enable chat logging when you log in. Chat logging can be started or stopped manually at any time using the '/chatlog' command. Logs are saved when you log out or exit the game to the 'World of Warcraft/Logs/WoWChatLog.txt' file."] = "Автоматическое включение записи чата"

L["Color player names"] = "Окраска имен игроков"
L["Color player names in chat by their class if known. Classes are known if you have seen the player in your group, in your guild, online on your friends list, in a '/who' query, or have targetted or moused over them since you logged in."] = "Окрашивать имена игроков в цвет класса если класс известен"

L["Mousewheel scrolling"] = "Прокрутка колесиком мыши"
L["Enable scrolling through chat frames with the mouse wheel. Hold the Shift key while scrolling to jump to the top or bottom of the chat frame."] = "Включить прокрутку колесиком мыши"

L["Sticky channels"] = "Липкие каналы"
L["Enable sticky channel behavior for all chat types except emotes."] = "Липкие каналы"

L["Suppress notifications"] = "Подавление уведомлений"
L["Suppress the notification messages informing you when someone leaves or joins a channel, or when channel ownership changes."] = "Подавление уведомлений каналов"

L["Suppress repeats"] = "Подавление повторяющихся сообщений"
L["Suppress repeated messages in public chat channels."] = "Подавление повторяющихся сообщений в общих каналах"

L["Lock tabs"] = "Закрепление закладок чата"
L["Prevent docked chat tabs from being dragged unless the Alt key is down."] = "Закрепить закладки чата (удерживайте Alt для перемещения)"

L["Link URLs"] = "Кликабельные URL"
L["Turn URLs in chat messages into clickable links for easy copying."] = "Кликабельные URL для облегчения копирования"

-- Don't touch this.

PHANXCHAT_LOCALS = L