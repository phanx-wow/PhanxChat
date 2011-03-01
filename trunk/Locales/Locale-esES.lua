--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2006–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx
------------------------------------------------------------------------
	Localization: esES / Spanish (Europe) / Español (EU)
	Last Updated: YYYY-MM-DD by YourName < ContactInfo >
----------------------------------------------------------------------]]

if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L, _, PhanxChat = { }, ...
PhanxChat.L = L

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

L["Conversation"]     = "Conversación"
L["General"]          = GENERAL
--	L["GuildRecruitment"] = ""
--	L["LocalDefense"]     = ""
--	L["LookingForGroup"]  = ""
L["Trade"]            = TRADE
--	L["WorldDefense"]     = ""

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

L.CONVERSATION_ABBR       = ""
L.GENERAL_ABBR            = "G"
L.GUILDRECRUITMENT_ABBR   = "R
L.LOCALDEFENSE_ABBR       = "D"
L.LOOKINGFORGROUP_ABBR    = "BDG"
L.TRADE_ABBR              = "C"
L.WORLDDEFENSE_ABBR       = "D"

L.BATTLEGROUND_ABBR        = "Cb"
L.BATTLEGROUND_LEADER_ABBR = "Lb"
L.GUILD_ABBR               = "H"
L.OFFICER_ABBR             = "O"
L.PARTY_ABBR               = "G"
L.PARTY_GUIDE_ABBR         = "Lg"
L.PARTY_LEADER_ABBR        = "Lg"
L.RAID_ABBR                = "B"
L.RAID_LEADER_ABBR         = "Lb"
L.RAID_WARNING_ABBR        = "Ab"
L.SAY_ABBR                 = "D"
L.YELL_ABBR                = "Gr"
L.WHISPER_ABBR             = "S de" -- incoming
L.WHISPER_INFORM_ABBR      = "S a" -- outgoing

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

L["Short channel names"] = "Acortar nombres de canales"
L["Shorten channel names and chat strings."] = "Acortar los nombres de los canales de chat."
L["Short player names"] = "Acortar nombres de personajes"
L["Shorten player names by removing realm names and Real ID last names."] = "Acortar los nombres de personajes mediante la eliminación de nombres de los servidores, y apellidos de ID real."
L["Replace real names"] = "Reemplazar nombres reales"
L["Replace Real ID names with character names."] = "Reemplazar los nombres de ID real con los nombres de personajes."
L["Enable arrow keys"] = "Activar teclas de flecha"
L["Enable arrow keys in the chat edit box."] = "Activar las teclas de flecha en el cuadro de escritura."
L["Enable resize edges"] = "Activar los bordes de tamaño"
L["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."] = "Activar los bordes para cambiar el tamaño del ventana de chat, en lugar de sólo la esquina inferior derecha."
L["Link URLs"] = "Vincular URLs"
L["Transform URLs in chat into clickable links for easy copying."] = "Cambiar URLs en mensajes de chat a vínculos para copiar fácilmente."
L["Lock docked tabs"] = "Bloquear pestañas"
L["Prevent docked chat tabs from being dragged unless the Shift key is down."] = "Evitar arrastrar las pestañas de chat a menos que pulsas la tecla Mayús."
L["Move edit boxes"] = "Mover cuadro de escritura"
L["Move chat edit boxes to the top their respective chat frame."] = "Mover el cuadro de escritura a la parte superior de la ventana de chat."
L["Hide buttons"] = "Ocultar botones"
L["Hide the chat frame menu and scroll buttons."] = "Ocultar el botón de menú de chat y los botones de desplazamiento."
L["Hide extra textures"] = "Ocultar texturas extras"
L["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = "Ocultar las texturas extras en las pestañas y el cuadro de escritura, que han añadido en el Parche 3.3.5."
L["Hide tab flash"] = "Ocultar flash en pestaña"
L["Disable the flashing effect on chat tabs that receive new messages."] = "Ocultar el flash en las pestañas que reciben nuevos mensajes."
L["Hide notices"] = "Ocultar anuncios"
L["Hide channel notification messages."] = "Ocultar anuncios de canal, como \"X abandonó el canal\"."
L["Hide repeats"] = "Ocultar repeticiones"
L["Hide repeated messages in public channels."] = "Ocultar mensajes repetidos en los canales públicos."
L["Sticky chat"] = "Canales constante"
L["Set which chat types should be sticky."] = "Establecer canales de chat que son constantes."
L["All"] = "Todos"
L["Default"] = "Predeterminados"
L["None"] = "Ningunos"
L["Fade time"] = "Tiempo de transición"
L["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."] = "Desaparecer el texto en la ventana de chat después de estos minutos. Establecer en 0 para mantener el texto siempre."
L["Font size"] = "Tamaño de fuente"
L["Set the font size for all chat frames."] = "Establecer el tamaño de fuente para todas las ventanas de chat."
L["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."] = "Observe que esto es simplemente un acceso rápido para la configuración de cada ventana de chat por separado en las opciones principal de chat."

------------------------------------------------------------------------