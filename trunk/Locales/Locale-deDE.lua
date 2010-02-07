--[[--------------------------------------------------------------------
	German (Deutsch) translations for PhanxChat
	Last updated: 2008-09-26 by Melikae
	Contributors:
		Melikae - Proudmoore <melikae@gmx.eu>
----------------------------------------------------------------------]]

if GetLocale() ~= "deDE" then return end

local L, _, PhanxChat = { }, ...
PhanxChat.L = L

------------------------------------------------------------------------
-- Channel Names
-- These must match the channel names sent from the server.
------------------------------------------------------------------------

L["General"]          = "Allgemein"
L["Trade"]            = "Handel"
L["LocalDefense"]     = "LokaleVerteidigung"
L["WorldDefense"]     = "GlobaleVerteidigung"
L["LookingForGroup"]  = "SucheNachGruppe"
L["GuildRecruitment"] = "Gildenrekrutierung"

------------------------------------------------------------------------
-- Short Channel Names
-- These should be one- or two-character abbreviations.
------------------------------------------------------------------------

L["SHORT_GENERAL"]          = "A"
L["SHORT_TRADE"]            = "H"
L["SHORT_LOCALDEFENSE"]     = "LV"
L["SHORT_WORLDDEFENSE"]     = "GB"
L["SHORT_LOOKINGFORGROUP"]  = "LFG"
L["SHORT_GUILDRECRUITMENT"] = "R"

------------------------------------------------------------------------
-- Short Chat Strings
-- These should be one- or two-character abbreviations.
------------------------------------------------------------------------

L["SHORT_BATTLEGROUND"]        = "SF"
L["SHORT_BATTLEGROUND_LEADER"] = "SFL"
L["SHORT_GUILD"]               = "G"
L["SHORT_OFFICER"]             = "O"
L["SHORT_PARTY"]               = "G"
L["SHORT_PARTY_GUIDE"]         = "GL"
L["SHORT_PARTY_LEADER"]        = "GL"
L["SHORT_RAID"]                = "SZ"
L["SHORT_RAID_LEADER"]         = "SZL"
L["SHORT_RAID_WARNING"]        = "SZW"
L["SHORT_SAY"]                 = "S"
L["SHORT_WHISPER"]             = "W" -- whispers sent to you
L["SHORT_WHISPER_INFORM"]      = "W" -- whispers sent by you
L["SHORT_YELL"]                = "S"

------------------------------------------------------------------------
--	Configuration Panel Text
--	Please verify that your translations fit in the available UI space!
------------------------------------------------------------------------

-- L["Configure options for making your chat frames more user-friendly and less cluttered."] = ""

L["Color player names"] = "Namen einfärben"
L["Enable player name class coloring for all chat message types."] = "Namen der Spieler nach Klasse einfärben"
-- L["Note that this is just a shortcut to enabling class coloring for each message type individually through the Blizzard chat options."] = ""

L["Disable tab flashing"] = "Blinken verhindern"
L["Disable the flashing effect on chat tabs that receive new messages."] = "Blinken der Tabs verhindern"

L["Enable arrow keys"] = "Pfeiltasten aktivieren"
L["Enable arrow keys in the chat edit box."] = "Pfeiltasten für das Eingabefeld aktivieren"

L["Enable mousewheel"] = "Mausrad scrollen"
L["Enable mousewheel scrolling in chat frames."] = "Mit dem Mausrad scrollen aktivieren"

L["Hide buttons"] = "Buttons verstecken"
L["Hide the chat frame menu and scroll buttons."] = "Scroll Buttons verstecken"

L["Link URLs"] = "URLs anklickbar"
L["Transform URLs in chat into clickable links for easy copying."] = "URLs für einfaches kopieren anklickbar machen"

L["Lock docked tabs"] = "Tabs verhindern"
L["Prevent locked chat tabs from being dragged unless the Alt key is down."] = "Verschieben angedockter Tabs verhindern (zum Verschieben Alt gedrückt halten)"

L["Move edit box"] = "Eingabefeld anzeigen"
L["Move the chat edit box above the chat frame."] = "Eingabefeld über dem Chatfenster anzeigen"

L["Shorten channel names"] = "Kanal Namen abkürzen"
L["Shorten channel names and chat strings."] = "Kanal Namen und Chat Bezeichnungen abkürzen"

L["Sticky chat"] = "Kanäle merken"
L["Set which chat types should be sticky."] = "Mehr Kanäle \"sticky\" machen"
-- L["All"] = ""
-- L["Default"] = ""
-- L["None"] = ""

L["Fade time"] = "Ausblenden des Textes"
L["Set the time in minutes to wait before fading chat text. A setting of 0 will disable fading."] = "Zeit bis zum Ausblenden des Textes in Minuten (0 = deaktiviert)"

L["Font size"] = "Schriftgröße"
L["Set the font size for all chat frames."] = "Schriftgröße für alle Fenster einstellen"
-- L["Note that this is just a shortcut to setting the font size for each chat frame individually through the Blizzard chat options."] = ""

L["Filter notifications"] = "Kanal Meldungen unterdrücken"
L["Hide channel notification messages."] = "Kanal Meldungen unterdrücken"

L["Filter repeats"] = "Wiederholungen unterdrücken"
L["Hide repeated messages in public channels."] = "Wiederholungen in öffentlichen Channels unterdrücken"

L["Auto-start chat log"] = "Chat automatisch aufzeichen"
L["Automatically start chat logging when you log into the game."] = "Chat automatisch aufzeichen"
-- L["Chat logs are written to [ World of Warcraft > Logs > WoWChatLog.txt ] only when you log out of your character."] = ""
-- L["You can manually start or stop chat logging at any time by typing /chatlog."] = ""

------------------------------------------------------------------------