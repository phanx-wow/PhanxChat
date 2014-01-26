--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
------------------------------------------------------------------------
	Russian localization
	See the end of this file for a complete list of translators.
----------------------------------------------------------------------]]

if GetLocale() ~= "ruRU" then return end
local _, PhanxChat = ...
local C, S, L = PhanxChat.ChannelNames, PhanxChat.ShortStrings, PhanxChat.L

------------------------------------------------------------------------
--	Channel Names
--	Must match the default channel names shown in your game client.
------------------------------------------------------------------------

C.Conversation    = "Разговор"
C.General         = "Общий"
C.LocalDefense    = "ОборонаЛокальный"
C.LookingForGroup = "ПоискСпутников"
C.Trade           = "Торговля"
C.WorldDefense    = "ОборонаГлобальный"

------------------------------------------------------------------------
-- Short Channel Names
-- Use the shortest abbreviations that make sense in your language.
------------------------------------------------------------------------

S.Conversation    = "Ра"
S.General         = "О"
S.LocalDefense    = "ОЛ"
S.LookingForGroup = "ПС"
S.Trade           = "Т"
S.WorldDefense    = "ОГ"

S.Guild              = "Г"
S.InstanceChat       = "П"
S.InstanceChatLeader = "ЛП"
S.Officer            = "Оф"
S.Party              = "Гр"
S.PartyGuide         = "ГрЛ"
S.PartyLeader        = "ГрЛ"
S.Raid               = "Р"
S.RaidLeader         = "РЛ"
S.RaidWarning        = "РВ"
S.Say                = "С"
S.WhisperIncoming    = "Ш"
S.WhisperOutgoing    = "@"
S.Yell               = "К"

------------------------------------------------------------------------
-- Options Panel
------------------------------------------------------------------------

L.All = "Все"
L.Default = "По умолчанию"
L.EnableArrows = "Включить стрелки"
L.EnableArrows_Desc = "Использовать стрелки курсора в окне редактирования сообщения."
L.EnableResizeEdges = "Включить рамку размера"
L.EnableResizeEdges_Desc = "Включить рамку изменения размера окна чата, вместо только нижнего правого угла."
L.EnableSticky = "Запоминать последний ввод"
L.EnableSticky_Desc = "Установить какие типы чата должны запоминать последний ввод, быть \"липкими\"."
L.FadeTime = "Время угасания"
L.FadeTime_Desc = "Установить время в минутах перед угасанием чата. Установив значение в 0 вы отмените угасание."
L.FontSize = "Размер шрифта"
L.FontSize_Desc = "Установить размер шрифта для всех окон чата."
L.FontSize_Note = "Заметьте, что это просто настраивает каждую вкладку индивидуально, как вы могли бы сделать обычным способом, через управление чатом в меню."
L.HideButtons = "Скрыть кнопки"
L.HideButtons_Desc = "Скрыть кнопку \"Общение\" и кнопки прокрутки."
L.HideFlash = "Скрыть мигание вкладок"
L.HideFlash_Desc = "Отключить мигание вкладок с новыми сообщениями."
L.HideNotices = "Скрыть уведомления"
L.HideNotices_Desc = "Скрывать информационные сообщения канала."
L.HideRepeats = "Скрыть повторы"
L.HideRepeats_Desc = "Скрывать повторяющиеся сообщения в общих каналах."
L.HideTextures = "Скрыть текстуры"
L.HideTextures_Desc = "Скрыть дополнительные текстуры вкладок и окна ввода сообщения, добавленныe а патче 3.3.5."
L.LinkURLs = "Копирование ссылок"
L.LinkURLs_Desc = "Превратить ссылки в чате в кликабельные для простоты копирования."
L.LockTabs = "Зафиксировать вкладки"
L.LockTabs_Desc = "Запретить перетаскивание зафиксированных вкладок без зажатого Shift."
L.MoveEditBox = "Переместить окно ввода"
L.MoveEditBox_Desc = "Переместить окно ввода наверх окна чата."
L.None = "Никакие"
--L.OptionLocked = "This option is locked by PhanxChat. Use the %q option in PhanxChat instead."
--L.OptionLockedConditional = "This option is locked by PhanxChat. If you wish to change it, you must first disable the %q option in PhanxChat."
--L.RemoveRealmNames = "Remove realm names"
--L.RemoveRealmNames_Desc = "Shorten player names by removing realm names."
L.ReplaceRealNames = "Заменить реальное имя"
L.ReplaceRealNames_Desc = "Заменять Real ID имена на имена персонажей."
L.ShortenChannelNames = "Короткие имена каналов"
L.ShortenChannelNames_Desc = "Сокращать имена каналов и строчки чата."
--L.ShortenRealNames = "Shorten real names"
--L.ShortenRealNames_Desc = "Choose how to shorten Real ID names, if at all."
--L.ShortenRealNames_UseBattleTag = "Replace with BattleTag"
--L.ShortenRealNames_UseFirstName = "Show first name only"
--L.ShortenRealNames_UseFullName = "Keep full name"
--L.ShowClassColors = "Show class colors"
--L.ShowClassColors_Desc = "Show class colors in all channels."
--L.Whisper_BadTarget = "You can't whisper that target!"
--L.Whisper_NoTarget = "You don't have a target to whisper!"
--L.WhoStatus_Offline = "%s is currently offline."
--L.WhoStatus_PlayingOtherGame = "%s is currently playing %s."

--[[--------------------------------------------------------------------
	Special thanks to the following people who have contributed
	Russian translations for PhanxChat:
	- hungry2 @ CurseForge
----------------------------------------------------------------------]]