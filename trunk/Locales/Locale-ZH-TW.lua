--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
------------------------------------------------------------------------
	Traditional Chinese localization
	Last updated 2012-07-29 by yunrong @ CurseForge
	***
----------------------------------------------------------------------]]

if GetLocale() ~= "zhTW" then return end
local _, PhanxChat = ...
local C, S, L = PhanxChat.ChannelNames, PhanxChat.ShortStrings, PhanxChat.L

------------------------------------------------------------------------
--	Channel Names
--	Must match the default channel names shown in your game client.
------------------------------------------------------------------------

C.Conversation    = "對話"
C.General         = "綜合"
C.LocalDefense    = "本地防務"
C.LookingForGroup = "尋求組隊"
C.Trade           = "交易"
C.WorldDefense    = "世界防務"

------------------------------------------------------------------------
-- Short Channel Names
-- Use the shortest abbreviations that make sense in your language.
------------------------------------------------------------------------

S.Conversation    = "話"
S.General         = "綜"
S.LocalDefense    = "本"
S.LookingForGroup = "尋"
S.Trade           = "交"
S.WorldDefense    = "世"

S.Guild              = "公"
S.InstanceChat       = "副"
S.InstanceChatLeader = "領"
S.Officer            = "官"
S.Party              = "隊"
S.PartyGuide         = "領"
S.PartyLeader        = "領"
S.Raid               = "團"
S.RaidLeader         = "領"
S.RaidWarning        = "警"
S.Say                = "說"
S.WhisperIncoming    = "自"
S.WhisperOutgoing    = "往"
S.Yell               = "喊"

------------------------------------------------------------------------
-- Options Panel
------------------------------------------------------------------------

L.All = "所有"
L.Default = "預設"
L.EnableArrows = "輸入框中使用方向鍵"
L.EnableArrows_Desc = "允許在輸入框中使用方向鍵。"
L.EnableResizeEdges = "開啟邊緣調整"
L.EnableResizeEdges_Desc = "開啟聊天框邊緣調整，而不只是在右下角調整。"
--L.EnableSticky = "Sticky chat"
--L.EnableSticky_Desc = "Set which chat types should be sticky."
L.FadeTime = "漸隱時間"
--L.FadeTime_Desc = "Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."
L.FontSize = "字體大小"
--L.FontSize_Desc = "Set the font size for all chat frames."
--L.FontSize_Note = "Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."
L.HideButtons = "隱藏按鈕"
L.HideButtons_Desc = "隱藏聊天視窗選單和滾動按鈕。"
L.HideFlash = "隱藏標籤閃爍"
L.HideFlash_Desc = "禁用聊天框收到消息後標籤的閃爍效果。"
L.HideNotices = "隱藏警告"
L.HideNotices_Desc = "隱藏聊天框內的警告訊息。"
L.HideRepeats = "隱藏重複訊息"
L.HideRepeats_Desc = "隱藏公共頻道中的重複刷頻訊息。"
L.HideTextures = "隱藏額外材質"
--L.HideTextures_Desc = "Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."
--L.LinkURLs = "Link URLs"
--L.LinkURLs_Desc = "Transform URLs in chat into clickable links for easy copying."
--L.LockTabs = "Lock docked tabs"
--L.LockTabs_Desc = "Prevent docked chat tabs from being dragged unless the Shift key is down."
L.MoveEditBox = "移動聊天輸入框"
L.MoveEditBox_Desc = "移動聊天輸入框到該訊息框頂部。"
L.None = "無"
--L.OptionLocked = "This option is locked by PhanxChat. Use the %q option in PhanxChat instead."
--L.OptionLockedConditional = "This option is locked by PhanxChat. If you wish to change it, you must first disable the %q option in PhanxChat."
--L.RemoveRealmNames = "Remove realm names"
--L.RemoveRealmNames_Desc = "Shorten player names by removing realm names."
L.ReplaceRealNames = "替換玩家實名"
L.ReplaceRealNames_Desc = "以玩家角色名取代顯示戰網ID。"
--L.ShortenChannelNames = "Short channel names"
--L.ShortenChannelNames_Desc = "Shorten channel names and chat strings."
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