--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2012 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
------------------------------------------------------------------------
	Localization: esES / Spanish (Europe) / Español (EU)
	Last Updated: YYYY-MM-DD by YourName < ContactInfo >
----------------------------------------------------------------------]]

if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local _, PhanxChat = ...
PhanxChat.L = {

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

	["Conversation"]     = "Conversación",
	["General"]          = "General",
	["LocalDefense"]     = "DefensaLocal",
	["LookingForGroup"]  = "BuscarGrupo",
	["Trade"]            = "Comercio",
	["WorldDefense"]     = "DefensaGeneral",

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

	CONVERSATION_ABBR       = "BN",
	GENERAL_ABBR            = "G",
	GUILDRECRUITMENT_ABBR   = "R",
	LOCALDEFENSE_ABBR       = "D",
	LOOKINGFORGROUP_ABBR    = "BDG",
	TRADE_ABBR              = "C",
	WORLDDEFENSE_ABBR       = "D",

	GUILD_ABBR                = "H",
	INSTANCE_CHAT_ABBR        = "e",
	INSTANCE_CHAT_LEADER_ABBR = "E",
	OFFICER_ABBR              = "O",
	PARTY_ABBR                = "g",
	PARTY_GUIDE_ABBR          = "G",
	PARTY_LEADER_ABBR         = "G",
	RAID_ABBR                 = "b",
	RAID_LEADER_ABBR          = "B",
	RAID_WARNING_ABBR         = "A",
	SAY_ABBR                  = "d",
	YELL_ABBR                 = "Gr",
	WHISPER_ABBR              = "S", -- incoming
	WHISPER_INFORM_ABBR       = "@", -- outgoing

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

	["Short channel names"] = "Acortar nombres de canales",
	["Shorten channel names and chat strings."] = "Acortar los nombres de los canales de chat.",
	["Short player names"] = "Acortar nombres de personajes",
	["Shorten player names by removing realm names and Real ID last names."] = "Acortar los nombres de personajes mediante la eliminación de nombres de los servidores, y apellidos de ID real.",
	["Replace real names"] = "Reemplazar nombres reales",
	["Replace Real ID names with character names."] = "Reemplazar los nombres de ID real con los nombres de personajes.",
	["Enable arrow keys"] = "Activar teclas de flecha",
	["Enable arrow keys in the chat edit box."] = "Activar las teclas de flecha en el cuadro de escritura.",
	["Enable resize edges"] = "Activar los bordes de tamaño",
	["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."] = "Activar los bordes para cambiar el tamaño del ventana de chat, en lugar de sólo la esquina inferior derecha.",
	["Link URLs"] = "Vincular URLs",
	["Transform URLs in chat into clickable links for easy copying."] = "Cambiar URLs en mensajes de chat a vínculos para copiar fácilmente.",
	["Lock docked tabs"] = "Bloquear pestañas",
	["Prevent docked chat tabs from being dragged unless the Shift key is down."] = "Evitar arrastrar las pestañas de chat a menos que pulsas la tecla Mayús.",
	["Move edit boxes"] = "Mover cuadro de escritura",
	["Move chat edit boxes to the top their respective chat frame."] = "Mover el cuadro de escritura a la parte superior de la ventana de chat.",
	["Hide buttons"] = "Ocultar botones",
	["Hide the chat frame menu and scroll buttons."] = "Ocultar el botón de menú de chat y los botones de desplazamiento.",
	["Hide extra textures"] = "Ocultar texturas extras",
	["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = "Ocultar las texturas extras en las pestañas y el cuadro de escritura, que han añadido en el Parche 3.3.5.",
	["Hide tab flash"] = "Ocultar flash en pestaña",
	["Disable the flashing effect on chat tabs that receive new messages."] = "Ocultar el flash en las pestañas que reciben nuevos mensajes.",
	["Hide notices"] = "Ocultar anuncios",
	["Hide channel notification messages."] = "Ocultar anuncios de canal, como \"X abandonó el canal\".",
	["Hide repeats"] = "Ocultar repeticiones",
	["Hide repeated messages in public channels."] = "Ocultar mensajes repetidos en los canales públicos.",
	["Sticky chat"] = "Canales constante",
	["Set which chat types should be sticky."] = "Establecer canales de chat que son constantes.",
	["All"] = "Todos",
	["Default"] = "Predeterminados",
	["None"] = "Ningunos",
	["Fade time"] = "Tiempo de transición",
	["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."] = "Desaparecer el texto en la ventana de chat después de estos minutos. Establecer en 0 para mantener el texto siempre.",
	["Font size"] = "Tamaño de fuente",
	["Set the font size for all chat frames."] = "Establecer el tamaño de fuente para todas las ventanas de chat.",
	["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."] = "Observe que esto es simplemente un acceso rápido para configurar todos las ventanas de chat por separado en las opciones de chat del juego.",
	["Show class colors"] = "Colores de clase",
	["Show class colors in all channels."] = "Mostrar colores de clase en todas las canales.",
	["Note that this is just a shortcut to configuring each chat channel individually through the Blizzard chat options."] = "Observe que esto es solamente un acceso rrápido para configurar todos las canales por separado en las opciones de chat del juego.",
	["This option is locked by PhanxChat. If you wish to change it, you must first disable the %q option in PhanxChat."] = "Esta opción está bloqueado por PhanxChat. Para cambiarlo, primero desactivar la opción %q de PhanxChat.",
}