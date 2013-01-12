--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
------------------------------------------------------------------------
	Localization: frFR / French / Français
	Last Updated: 2012-11-30 by L0relei on Curse
----------------------------------------------------------------------]]

if GetLocale() ~= "frFR" then return end
local _, PhanxChat = ...
PhanxChat.L = {

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

	["Conversation"]     = "Conversation",
	["General"]          = "Général",
	["LocalDefense"]     = "DéfenseLocale",
	["LookingForGroup"]  = "RechercheDeGroupe",
	["Trade"]            = "Commerce",
	["WorldDefense"]     = "DéfenseUniverselle",

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

	CONVERSATION_ABBR         = "C",
	GENERAL_ABBR              = "G",
	GUILDRECRUITMENT_ABBR     = "R",
	LOCALDEFENSE_ABBR         = "DL",
	LOOKINGFORGROUP_ABBR      = "RG",
	TRADE_ABBR                = "C",
	WORLDDEFENSE_ABBR         = "DM",

	GUILD_ABBR                = "G",
	INSTANCE_CHAT_ABBR        = "I",
	INSTANCE_CHAT_LEADER_ABBR = "CI",
	OFFICER_ABBR              = "O",
	PARTY_ABBR                = "G",
	PARTY_GUIDE_ABBR          = "CG",
	PARTY_LEADER_ABBR         = "CG",
	RAID_ABBR                 = "R",
	RAID_LEADER_ABBR          = "CR",
	RAID_WARNING_ABBR         = "AR",
	SAY_ABBR                  = "D",
	YELL_ABBR                 = "C",
	WHISPER_ABBR              = "De", -- incoming
	WHISPER_INFORM_ABBR       = "À",  -- outgoing

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

	["Short channel names"] = "Noms de canaux courts",
	["Shorten channel names and chat strings."] = "Raccourcir les noms de canaux et de chat.",
	["Short player names"] = "Noms de joueurs courts",
	["Shorten player names by removing realm names and Real ID last names."] = "Raccourcir les noms des joueurs en ôtant les noms de serveurs et les noms réels.",
	["Replace real names"] = "Remplacer les noms réels",
	["Replace Real ID names with character names."] = "Remplacer le nom réel par le nom de personnage.",
	["Enable arrow keys"] = "Autoriser les touches fléchées",
	["Enable arrow keys in the chat edit box."] = "Autoriser l'utilisation des touches fléchées dans la fenêtre de chat.",
	["Enable resize edges"] = "Améliorer le redimensionnement",
	["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."] = "Autoriser le redimensionnement grâce à tous les coins de la fenêtre de chat, au lieu du seul coin bas droit.",
	["Link URLs"] = "Liens URL",
	["Transform URLs in chat into clickable links for easy copying."] = "Transformer les URL dans la fenêtre de chat en liens cliquables pour les copier.",
	["Lock docked tabs"] = "Verrouiller les onglets",
	["Prevent docked chat tabs from being dragged unless the Shift key is down."] = "Enpêcher de déplacer les onglets sans appuyer sur la touche shift.",
	["Move edit boxes"] = "Déplacer la fenêtre d'édition",
	["Move chat edit boxes to the top their respective chat frame."] = "Déplacer les fenêtres d'édition en haut de leurs fenêtres de chat respectives.",
	["Hide buttons"] = "Masquer les boutons",
	["Hide the chat frame menu and scroll buttons."] = "Masquer le menu de la fenêtre de chat et les boutons de défilement.",
	["Hide extra textures"] = "Masquer les textures supplémentaires",
	["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = "asquer les textures supplémentaires des onglets et de la fenêtre d'édition ajoutées avec la 3.3.5.",
	["Hide tab flash"] = "Masquer le flash des onglets",
	["Disable the flashing effect on chat tabs that receive new messages."] = "Désactiver l'effet de flash des onglets qui ont un nouveau message.",
	["Hide notices"] = "Masquer les avertissements",
	["Hide channel notification messages."] = "Masquer les messages de notification de changement de canal.",
	["Hide repeats"] = "Masquer les spams",
	["Hide repeated messages in public channels."] = "Masquer les message spammés sur les canaux publics.",
	["Sticky chat"] = "Canal mémorisé",
	["Set which chat types should be sticky."] = "Sélectionner les types de canaux mémorisés.",
	["All"] = "Tous",
	["Default"] = "Défaut",
	["None"] = "Aucun",
	["Fade time"] = "Temps d'estompage",
	["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."] = "Régler le temps, en minutes, à attendre avant l'estompage du texte. Une valeur de 0 désactivera l'estompage.",
	["Font size"] = "Taille de police",
	["Set the font size for all chat frames."] = "Régler la taille de police pour toutes les fenêtres de chat.",
	["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."] = "Notez que ceci est juste un raccourci pour configurer les fenêtres de chat via les options de Blizzard.",
	["Show class colors"] = "Afficher les couleurs de classe",
	["Show class colors in all channels."] = "Afficher les couleurs de classe dans tous les canaux.",
	["Note that this is just a shortcut to configuring each chat channel individually through the Blizzard chat options."] = "Notez que ceci est juste un raccourci pour configurer les fenêtres de chat via les options de Blizzard.",
	["This option is locked by PhanxChat. If you wish to change it, you must first disable the %q option in PhanxChat."] = "Cette option est verrouillée par PhanxChat. Si vous souhaitez la changer, vous d'abord désactiver l'option %q dans PhanxChat.",
}