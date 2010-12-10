--[[--------------------------------------------------------------------
PhanxChat
Reduces chat frame clutter and enhances chat frame functionality.

http://www.wowinterface.com/downloads/info6323-PhanxChat.html
http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx

Copyright © 2006–2010 Phanx < addons@phanx.net >

I, the copyright holder of this work, hereby release it into the public
domain. This applies worldwide. In case this is not legally possible:
I grant anyone the right to use this work for any purpose, without any
conditions, unless such conditions are required by law.
----------------------------------------------------------------------]]
--	Localization: deDE / German / Deutsch
--	Last Updated: 2010-07-30 by ac3r < wowinterface.com >
------------------------------------------------------------------------

if GetLocale() ~= "deDE" then return end
local L, _, PhanxChat = { }, ...
PhanxChat.L = L

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

L["Conversation"]     = CHAT_BN_CONVERSATION_SEND:match("%. (%w+)%]")
L["General"]          = "Allgemein"
L["GuildRecruitment"] = "Gildenrekrutierung"
L["LocalDefense"]     = "LokaleVerteidigung"
L["LookingForGroup"]  = "SucheNachGruppe"
L["Trade"]            = "Handel"
L["WorldDefense"]     = "GlobaleVerteidigung"

------------------------------------------------------------------------
--	Abbreviated Channel Names
------------------------------------------------------------------------

L.CONVERSATION_ABBR       = "C" -- needs check
L.GENERAL_ABBR            = "A"
L.GUILDRECRUITMENT_ABBR   = "GR"
L.LOCALDEFENSE_ABBR       = "LV"
L.LOOKINGFORGROUP_ABBR    = "LFG"
L.TRADE_ABBR              = "H"
L.WORLDDEFENSE_ABBR       = "GV"

L.BATTLEGROUND_ABBR        = "SF"
L.BATTLEGROUND_LEADER_ABBR = "SFL"
L.GUILD_ABBR               = "G"
L.OFFICER_ABBR             = "O"
L.PARTY_ABBR               = "G"
L.PARTY_GUIDE_ABBR         = "GL"
L.PARTY_LEADER_ABBR        = "GL"
L.RAID_ABBR                = "SZ"
L.RAID_LEADER_ABBR         = "SZL"
L.RAID_WARNING_ABBR        = "SZW"
L.SAY_ABBR                 = "S"
L.YELL_ABBR                = "S"
L.WHISPER_ABBR             = "W <" -- incoming
L.WHISPER_INFORM_ABBR      = "W >" -- outgoing

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

L["Short channel names"] = "Channelnamen abkürzen"
L["Shorten channel names and chat strings."] = "Abkürzen der Channelnamen und Chat-Bezeichnungen."
L["Short player names"] = "Spielernamen abkürzen"
L["Shorten player names by removing realm names and Real ID last names."] = "Kürze die Spielernamen, indem der Servername und die Nachnamen der Real ID entfernt werden."
L["Replace real names"] = "Echte Namen ersetzen"
L["Replace Real ID names with character names."] = "Ersetzt die echten Namen mit den Charakternamen."
L["Enable arrow keys"] = "Pfeiltasten aktivieren"
L["Enable arrow keys in the chat edit box."] = "Aktiviere die Pfeiltasten im Eingabefeld des Chats."
L["Enable resize edges"] = "Alle Ecken veränderbar"
L["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."] = "Aktivieren um die Größe des Chatfenster an allen Ecken zu verändern, anstatt nur in der unteren rechten Ecke."
L["Link URLs"] = "URLs verlinken"
L["Transform URLs in chat into clickable links for easy copying."] = "URLs im Chat für einfaches Kopieren anklickbar machen."
L["Lock docked tabs"] = "Tabs sperren"
L["Prevent docked chat tabs from being dragged unless the Shift key is down."] = "Verhindert, dass fixierte Tabs verschoben werden. Zum Verschieben die ALT-Taste gedrückt halten."
L["Move edit boxes"] = "Eingabefeld verschieben"
L["Move chat edit boxes to the top their respective chat frame."] = "Das Eingabefeld über dem Chatfenster anzeigen."
L["Hide buttons"] = "Buttons verstecken"
L["Hide the chat frame menu and scroll buttons."] = "Verstecke das Chat Menü und die Scroll Buttons."
L["Hide extra textures"] = "Extra Texturen verstecken"
L["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = "Verstecke die Extra-Texturen der Chat Tabs und dem Chat Eingabefeld, die in Patch 3.3.5 hinzugefügt wurden."
L["Hide tab flash"] = "Blinken der Tabs verhindern"
L["Disable the flashing effect on chat tabs that receive new messages."] = "Deaktiviere das Blinken der Chat Tabs, bei dennen eine neue Nachricht erhalten wurde."
L["Hide notices"] = "Meldungen verhindern"
L["Hide channel notification messages."] = "Channel-Meldungen unterdrücken"
L["Hide repeats"] = "Wiederholungen verhindern"
L["Hide repeated messages in public channels."] = "Unterdrücke Nachrichten die in öffentlichen Channels wiederholt werden."
L["Sticky chat"] = "Channel merken"
L["Set which chat types should be sticky."] = "Festlegen, welche Channels gemerkt werden sollen."
L["All"] = "Alle"
L["Default"] = "Standard"
L["None"] = "Keine"
L["Fade time"] = "Ausblenden des Textes"
L["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."] = "Zeit bis zum Ausblenden des Textes in Minuten (0 = deaktiviert)."
L["Font size"] = "Schriftgröße"
L["Set the font size for all chat frames."] = "Schriftgröße für alle Chatfenster festlegen."
L["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."] = "Beachte, dass dies nur eine Kurzform zum Konfigurieren jedes einzelne Chatfenster durch die Blizzard Chatoptionen ist."

------------------------------------------------------------------------