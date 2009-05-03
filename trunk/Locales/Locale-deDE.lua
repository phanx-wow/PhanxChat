--[[--------------------------------------------------------------------
	German translations for PhanxChat
	Last updated yyyy-mm-dd by ????
	Contributors:
		Melikae - Proudmoore (melikae@gmx.eu)
----------------------------------------------------------------------]]

if GetLocale() ~= "deDE" then return end

local L = {
-- Translating these strings is required for the addon to function in
-- this locale. These strings are used to detect server channel names.

	CHANNEL_GENERAL			= "Allgemein",
	CHANNEL_TRADE				= "Handel",
	CHANNEL_LOCALDEFENSE		= "LokaleVerteidigung",
	CHANNEL_WORLDDEFENSE		= "GlobaleVerteidigung",
	CHANNEL_LOOKINGFORGROUP		= "SucheNachGruppe",
	CHANNEL_GUILDRECRUITMENT		= "Gildenrekrutierung",

-- Translating these strings is optional, but highly recommended. These
-- strings are displayed if the user has "short channel names" enabled.

	SHORT_GENERAL 				= "A",
	SHORT_TRADE 				= "H",
	SHORT_LOCALDEFENSE 			= "LV",
	SHORT_WORLDDEFENSE 			= "GV",
	SHORT_LOOKINGFORGROUP		= "LFG",
	SHORT_GUILDRECRUITMENT		= "R",

	SHORT_SAY 				= "S",
	SHORT_YELL 				= "S",
	SHORT_GUILD 				= "G",
	SHORT_OFFICER 				= "O",
	SHORT_PARTY 				= "G",
	SHORT_RAID 				= "SZ",
	SHORT_RAID_LEADER 			= "SZL",
	SHORT_RAID_WARNING 			= "SZW",
	SHORT_BATTLEGROUND 			= "SF",
	SHORT_BATTLEGROUND_LEADER 	= "SFL",
	SHORT_WHISPER 				= "W",
	SHORT_WHISPER_INFORM 		= "W",
}

-- Translating these strings is optional, but recommended. These strings
-- are shown in the configuration GUI.

L["Hide buttons"] = "Buttons verstecken"
L["Hide the scroll-up, scroll-down, scroll-to-bottom, and menu buttons next to the chat frame."] = "Scroll Buttons verstecken"
L["Shorten channels"] = "Kanal Namen abk�rzen"
L["Shorten channel names in chat messages. For example, '[1. General]' might be shortened to '1|'."] = "Kanal Namen und Chat Bezeichnungen abk�rzen"
L["Enable arrow keys"] = "Pfeiltasten aktivieren"
L["Enable the use of arrow keys in the chat edit box."] = "Pfeiltasten f�r das Eingabefeld aktivieren"
L["Move chat edit box"] = "Eingabefeld anzeigen"
L["Move the chat edit box to the top of the chat frame."] = "Eingabefeld �ber dem Chatfenster anzeigen"
L["Disable tab flashing"] = "Blinken verhindern"
L["Disable the flashing effect on chat tabs when new messages are received."] = "Blinken der Tabs verhindern"
L["Auto-start logging"] = "Chat automatisch aufzeichen"
L["Automatically enable chat logging when you log in. Chat logging can be started or stopped manually at any time using the '/chatlog' command. Logs are saved when you log out or exit the game to the 'World of Warcraft/Logs/WoWChatLog.txt' file."] = "Chat automatisch aufzeichen"
L["Color player names"] = "Namen der Spieler einf�rben"
L["Color player names in chat by their class if known. Classes are known if you have seen the player in your group, in your guild, online on your friends list, in a '/who' query, or have targetted or moused over them since you logged in."] = "Namen der Spieler nach Klasse einf�rben, wenn bekannt"
L["Mousewheel scrolling"] = "Mausrad scrollen"
L["Enable scrolling through chat frames with the mouse wheel. Hold the Shift key while scrolling to jump to the top or bottom of the chat frame."] = "Mit dem Mausrad scrollen aktivieren"
L["Sticky channels"] = "Kan�le merken"
L["Enable sticky channel behavior for all chat types except emotes."] = "Mehr Kan�le \"sticky\" machen"
L["Suppress notifications"] = "Kanal Meldungen unterdr�cken"
L["Suppress the notification messages informing you when someone leaves or joins a channel, or when channel ownership changes."] = "Kanal Meldungen unterdr�cken"
L["Suppress repeats"] = "Wiederholungen unterdr�cken"
L["Suppress repeated messages in public chat channels."] = "Wiederholungen in �ffentlichen Channels unterdr�cken"
L["Lock tabs"] = "Tabs verhindern"
L["Prevent docked chat tabs from being dragged unless the Alt key is down."] = "Verschieben angedockter Tabs verhindern (zum Verschieben Alt gedr�ckt halten)"
L["Link URLs"] = "URLs anklickbar"
L["Turn URLs in chat messages into clickable links for easy copying."] = "URLs f�r einfaches kopieren anklickbar machen"
L["Chat fade time"] = "Ausblenden des Textes"
L["Set the time in minutes to keep chat messages visible before fading them out. Setting this to 0 will disable fading completely."] = "Zeit bis zum Ausblenden des Textes in Minuten (0 = deaktiviert)"
L["Chat font size"] = "Schriftgr��e"
L["Set the font size for all chat tabs at once. This is only a shortcut for doing the same thing for each tab using the default UI."] = "Schriftgr��e f�r alle Fenster einstellen"

-- Don't touch this.

PHANXCHAT_LOCALS = L