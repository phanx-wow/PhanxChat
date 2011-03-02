--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmaicom>
	Copyright © 2006–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx
------------------------------------------------------------------------
	Localization: frFR / French / Français
	Last Updated: 2010-09-03 by Strigx < Curse.com >
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
	["GuildRecruitment"] = "Recrutement de guilde",
	["LocalDefense"]     = "Défense Locale",
	["LookingForGroup"]  = "Recherche de groupe",
	["Trade"]            = "Commerce",
	["WorldDefense"]     = "Défense",

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

	CONVERSATION_ABBR       = "C",
	GENERAL_ABBR            = "G",
	GUILDRECRUITMENT_ABBR   = "R",
	LOCALDEFENSE_ABBR       = "DL",
	LOOKINGFORGROUP_ABBR    = "RDG",
	TRADE_ABBR              = "E",
	WORLDDEFENSE_ABBR       = "DM",

	BATTLEGROUND_ABBR        = "SF",
	BATTLEGROUND_LEADER_ABBR = "SFL",
	GUILD_ABBR               = "G",
	OFFICER_ABBR             = "O",
	PARTY_ABBR               = "G",
	PARTY_GUIDE_ABBR         = "GL",
	PARTY_LEADER_ABBR        = "GL",
	RAID_ABBR                = "R",
	RAID_LEADER_ABBR         = "RL",
	RAID_WARNING_ABBR        = "AR",
	SAY_ABBR                 = "D",
	YELL_ABBR                = "C",
	WHISPER_ABBR             = "De", -- incoming
	WHISPER_INFORM_ABBR      = "À", -- outgoing

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

	["Short channel names"] = "Noms de canaux courts",
	["Shorten channel names and chat strings."] = "Raccourcis les noms de canaux et de chat",
	["Short player names"] = "Noms de joueurs courts",
	["Shorten player names by removing realm names and Real ID last names."] = "Raccourcis les noms des joueurs en ôtant les noms de serveurs et les noms de famille d'ID réélle",
	["Replace real names"] = "Remplacer noms rééls",
	["Replace Real ID names with character names."] = "Remplace le nom réél par le nom de personnage",
	["Enable arrow keys"] = "Autoriser touches flèches",
	["Enable arrow keys in the chat edit box."] = "Autoriser l'utilisation des touches flèches dans la fenêtre de chat",
	["Enable resize edges"] = "Améliorer redimensionnement",
	["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."] = "Autorise le redimensionnement grâce à tous les coins de la chatbox, au lieu du seul coin bas droit.",
	["Link URLs"] = "Liens URLs",
	["Transform URLs in chat into clickable links for easy copying."] = "Transforme les URLs dans la fenêtre de chat en liens cliquables",
	["Lock docked tabs"] = "Vérouiller les onglets",
	["Prevent docked chat tabs from being dragged unless the Shift key is down."] = "Enpêche de bouger les onglets sans appuyer sur la touche shift.",
	["Move edit boxes"] = "Bouger la fenêtre d'édition",
	["Move chat edit boxes to the top their respective chat frame."] = "Déplace les fenêtres d'édition en haut de leur fenêtres de chat respectives.",
	["Hide buttons"] = "Masquer les boutons",
	["Hide the chat frame menu and scroll buttons."] = "Masque le menu du cadre et les boutons",
	["Hide extra textures"] = "Masquer les textures supplémentaires",
	["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = "Masque les textures supplémentaires des onglets et de l'edit box ajoutées avec la 3.3.5.",
	["Hide tab flash"] = "Masquer le flash des onglets",
	["Disable the flashing effect on chat tabs that receive new messages."] = "Désactive l'effet de flash des onglets qui ont un nouveau message.",
	["Hide notices"] = "Masquer les avertissements",
	["Hide channel notification messages."] = "Masquer les messages de notification de changement de cana",
	["Hide repeats"] = "Masquer les spams",
	["Hide repeated messages in public channels."] = "Masque les message spammés sur les canaux publics",
	["Sticky chat"] = "Canal mémorisé",
	["Set which chat types should be sticky."] = "Sélectionne le type de canal mémorisé.",
	["All"] = "Tous",
	["Default"] = "Défaut",
	["None"] = "Aucun",
	["Fade time"] = "Temps d'estompage",
	["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."] = "Régle le temps, en minutes, à attendre avant l'estompage du texte. Une valeur de 0 désactivera l'estompage.",
	["Font size"] = "Taille de police",
	["Set the font size for all chat frames."] = "Régle la taille de police pour toutes les fenêtres de chat",
	["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."] = "Notez que ceci est juste un raccourcis pour configurer les fenêtres de chat via les options d'affichage de Blizzard.",

------------------------------------------------------------------------

}