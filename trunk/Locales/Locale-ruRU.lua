--[[--------------------------------------------------------------------
	Russian translations for PhanxChat
	Last updated: 2008-09-26 by Valle
	Contributors:
		Valle of Warsong
----------------------------------------------------------------------]]

if GetLocale() ~= "ruRU" then return end

local L, _, PhanxChat = { }, ...
PhanxChat.L = L

------------------------------------------------------------------------
-- Channel Names
-- These must match the channel names sent from the server.
------------------------------------------------------------------------

L["General"]          = "Общий"
L["Trade"]            = "Торговля"
L["LocalDefense"]     = "Оборона: локальный"
L["WorldDefense"]     = "Оборона: глобальный"
L["LookingForGroup"]  = "Поис спутников"
L["GuildRecruitment"] = "Набор в гильдии"

------------------------------------------------------------------------
-- Short Channel Names
-- These should be one- or two-character abbreviations.
------------------------------------------------------------------------

L["SHORT_GENERAL"]          = "О"
L["SHORT_TRADE"]            = "Т"
L["SHORT_LOCALDEFENSE"]     = "ЛО"
L["SHORT_WORLDDEFENSE"]     = "МО"
L["SHORT_LOOKINGFORGROUP"]  = "ЛФГ"
L["SHORT_GUILDRECRUITMENT"] = "НвГ"

------------------------------------------------------------------------
-- Short Chat Strings
-- These should be one- or two-character abbreviations.
------------------------------------------------------------------------

L["SHORT_BATTLEGROUND"]        = "ПБ"
L["SHORT_BATTLEGROUND_LEADER"] = "ЛПБ"
L["SHORT_GUILD"]               = "Г"
L["SHORT_OFFICER"]             = "Оф"
L["SHORT_PARTY"]               = "Гр"
L["SHORT_PARTY_GUIDE"]         = "ГрЛ"
L["SHORT_PARTY_LEADER"]        = "ГрЛ"
L["SHORT_RAID"]                = "Р"
L["SHORT_RAID_LEADER"]         = "РЛ"
L["SHORT_RAID_WARNING"]        = "РВ"
L["SHORT_SAY"]                 = "С"
L["SHORT_WHISPER"]             = "Ш" -- whispers sent to you
L["SHORT_WHISPER_INFORM"]      = "Ш" -- whispers sent by you
L["SHORT_YELL"]                = "К"

------------------------------------------------------------------------
--	Configuration Panel Text
--	Please verify that your translations fit in the available UI space!
------------------------------------------------------------------------

-- L["Configure options for making your chat frames more user-friendly and less cluttered."] = ""

L["Color player names"] = "Окраска имен игроков"
L["Enable player name class coloring for all chat message types."] = "Окрашивать имена игроков в цвет класса если класс известен."
-- L["Note that this is just a shortcut to enabling class coloring for each message type individually through the Blizzard chat options."] = ""

L["Disable tab flashing"] = "Отключить мерцание закладок"
L["Disable the flashing effect on chat tabs that receive new messages."] = "Отключить мерцание закладок."

L["Enable arrow keys"] = "Использовать кнопки передвижения"
L["Enable arrow keys in the chat edit box."] = "Использовать кнопки передвижения в строке ввода."

L["Enable mousewheel"] = "Прокрутка колесиком мыши"
L["Enable mousewheel scrolling in chat frames."] = "Включить прокрутку колесиком мыши."

L["Hide buttons"] = "Скрыть кнопки чата"
L["Hide the chat frame menu and scroll buttons."] = "Скрыть кнопки чата."

L["Link URLs"] = "Кликабельные URL"
L["Transform URLs in chat into clickable links for easy copying."] = "Кликабельные URL для облегчения копирования."

L["Lock docked tabs"] = "Закрепление закладок чата"
L["Prevent locked chat tabs from being dragged unless the Alt key is down."] = "Закрепить закладки чата (удерживайте Alt для перемещения)."

L["Move edit box"] = "Перемещение строки ввода"
L["Move the chat edit box above the chat frame."] = "Переместить строку ввода наверх."

L["Shorten channel names"] = "Сокращать названия каналов"
L["Shorten channel names and chat strings."] = "Сокращать названия каналов и строки чата."

L["Sticky chat"] = "Липкие каналы"
L["Set which chat types should be sticky."] = "Липкие каналы."
-- L["All"] = ""
-- L["Default"] = ""
-- L["None"] = ""

L["Fade time"] = "Исчезновение текста"
L["Set the time in minutes to wait before fading chat text. A setting of 0 will disable fading."] = "Установить время исчезновения текста в минутах. 0 = отключить."

L["Font size"] = "Установить размер шрифта"
L["Set the font size for all chat frames."] = "Установить размер шрифта для всех окон."
L["Note that this is just a shortcut to setting the font size for each chat frame individually through the Blizzard chat options."] = ""

L["Filter notifications"] = "Подавление уведомлений"
L["Hide channel notification messages."] = "Подавление уведомлений каналов."

-- L["Filter repeats"] = ""
L["Hide repeated messages in public channels."] = "Подавление повторяющихся сообщений в общих каналах."

-- L["Auto-start chat log"] = ""
L["Automatically start chat logging when you log into the game."] = ""
-- L["Chat logs are written to [ World of Warcraft > Logs > WoWChatLog.txt ] only when you log out of your character."] = ""
L["You can manually start or stop chat logging at any time by typing /chatlog."] = "Автоматическое включение записи чата."

------------------------------------------------------------------------