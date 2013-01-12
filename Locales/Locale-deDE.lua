--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
------------------------------------------------------------------------
	Localization: deDE / German / Deutsch
	Last Updated: 2012-09-11 by staratnight @ CurseForge, 2010-07-30 by ac3r @ WoWInterface
----------------------------------------------------------------------]]

if GetLocale() ~= "deDE" then return end
local _, PhanxChat = ...
PhanxChat.L = {

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

	["Conversation"]    = "Chat",
	["General"]         = "Allgemein",
	["LocalDefense"]    = "LokaleVerteidigung",
	["LookingForGroup"] = "SucheNachGruppe",
	["Trade"]           = "Handel",
	["WorldDefense"]    = "WeltVerteidigung",

------------------------------------------------------------------------
--	Abbreviated Channel Names
------------------------------------------------------------------------

	CONVERSATION_ABBR     = "C",
	GENERAL_ABBR          = "A",
	GUILDRECRUITMENT_ABBR = "GR",
	LOCALDEFENSE_ABBR     = "LV",
	LOOKINGFORGROUP_ABBR  = "LFG",
	TRADE_ABBR            = "H",
	WORLDDEFENSE_ABBR     = "GV",

	GUILD_ABBR                = "G",
	INSTANCE_CHAT_ABBR        = "I",
	INSTANCE_CHAT_LEADER_ABBR = "IF",
	OFFICER_ABBR              = "O",
	PARTY_ABBR                = "G",
	PARTY_GUIDE_ABBR          = "GL",
	PARTY_LEADER_ABBR         = "GL",
	RAID_ABBR                 = "SZ",
	RAID_LEADER_ABBR          = "SZL",
	RAID_WARNING_ABBR         = "SZW",
	SAY_ABBR                  = "s",
	YELL_ABBR                 = "S",
	WHISPER_ABBR              = "W", -- incoming
	WHISPER_INFORM_ABBR       = "@", -- outgoing

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

	["Short channel names"] = "Channelnamen abkürzen",
	["Shorten channel names and chat strings."] = "Abkürzen der Channelnamen und Chat-Bezeichnungen.",
	["Short player names"] = "Spielernamen abkürzen",
	["Shorten player names by removing realm names and Real ID last names."] = "Kürze die Spielernamen, indem der Servername und die Nachnamen der Real ID entfernt werden.",
	["Replace real names"] = "Echte Namen ersetzen",
	["Replace Real ID names with character names."] = "Ersetzt die echten Namen mit den Charakternamen.",
	["Enable arrow keys"] = "Pfeiltasten aktivieren",
	["Enable arrow keys in the chat edit box."] = "Aktiviere die Pfeiltasten im Eingabefeld des Chats.",
	["Enable resize edges"] = "Alle Ecken veränderbar",
	["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."] = "Aktivieren um die Größe des Chatfenster an allen Ecken zu verändern, anstatt nur in der unteren rechten Ecke.",
	["Link URLs"] = "URLs verlinken",
	["Transform URLs in chat into clickable links for easy copying."] = "URLs im Chat für einfaches Kopieren anklickbar machen.",
	["Lock docked tabs"] = "Tabs sperren",
	["Prevent docked chat tabs from being dragged unless the Shift key is down."] = "Verhindert, dass fixierte Tabs verschoben werden. Zum Verschieben die ALT-Taste gedrückt halten.",
	["Move edit boxes"] = "Eingabefeld verschieben",
	["Move chat edit boxes to the top their respective chat frame."] = "Das Eingabefeld über dem Chatfenster anzeigen.",
	["Hide buttons"] = "Buttons verstecken",
	["Hide the chat frame menu and scroll buttons."] = "Verstecke das Chat Menü und die Scroll Buttons.",
	["Hide extra textures"] = "Extra Texturen verstecken",
	["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = "Verstecke die Extra-Texturen der Chat Tabs und dem Chat Eingabefeld, die in Patch 3.3.5 hinzugefügt wurden.",
	["Hide tab flash"] = "Blinken der Tabs verhindern",
	["Disable the flashing effect on chat tabs that receive new messages."] = "Deaktiviere das Blinken der Chat Tabs, bei dennen eine neue Nachricht erhalten wurde.",
	["Hide notices"] = "Meldungen verhindern",
	["Hide channel notification messages."] = "Channel-Meldungen unterdrücken",
	["Hide repeats"] = "Wiederholungen verhindern",
	["Hide repeated messages in public channels."] = "Unterdrücke Nachrichten die in öffentlichen Channels wiederholt werden.",
	["Sticky chat"] = "Channel merken",
	["Set which chat types should be sticky."] = "Festlegen, welche Channels gemerkt werden sollen.",
	["All"] = "Alle",
	["Default"] = "Standard",
	["None"] = "Keine",
	["Fade time"] = "Ausblenden des Textes",
	["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."] = "Zeit bis zum Ausblenden des Textes in Minuten (0 = deaktiviert).",
	["Font size"] = "Schriftgröße",
	["Set the font size for all chat frames."] = "Schriftgröße für alle Chatfenster festlegen.",
	["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."] = "Beachte, dass dies nur eine Kurzform zum Konfigurieren jedes einzelne Chatfenster durch die Blizzard Chatoptionen ist.",
	["Show class colors"] = "Klassenfarben anzeigen",
	["Show class colors in all channels."] = "Klassenfarben in allen Chatkanälen anzeigen.",
	["Note that this is just a shortcut to configuring each chat channel individually through the Blizzard chat options."] = "Beachte, dass dies nur eine Abkürzung zu den Blizzard-Einstellungen für einzelne Chatkanäle darstellt.",
	["This option is locked by PhanxChat. If you wish to change it, you must first disable the %q option in PhanxChat."] = "Diese Option ist in PhanxChat gesperrt. Wenn du sie ändern möchtest, musst du zunächst die Option %q in PhanxChat deaktivieren.",
}