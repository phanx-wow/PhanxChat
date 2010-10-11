------------------------------------------------------------------------
--	PhanxChat                                                         --
--	Removes chat frame clutter and adds some functionality.           --
--	by Phanx < addons@phanx.net >                                     --
--	Copyright © 2006–2010 Phanx. See README for license terms.        --
--	http://www.wowinterface.com/downloads/info6323-PhanxChat.html     --
--	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx  --
------------------------------------------------------------------------
--	Localization: frFR / French / Français
--	Last Updated: 2010-09-03 by Strigx < Curse.com >
------------------------------------------------------------------------

if GetLocale() ~= "frFR" then return end
local L, _, PhanxChat = { }, ...
PhanxChat.L = L

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

L["Conversation"]     = "Conversation"
L["General"]          = "Général"
L["GuildRecruitment"] = "Recrutement de guilde"
L["LocalDefense"]     = "Défense Locale"
L["LookingForGroup"]  = "Recherche de groupe"
L["Trade"]            = "Commerce"
L["WorldDefense"]     = "Défense"

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

L.CONVERSATION_ABBR       = "C"
L.GENERAL_ABBR            = "G"
L.GUILDRECRUITMENT_ABBR   = "R"
L.LOCALDEFENSE_ABBR       = "DL"
L.LOOKINGFORGROUP_ABBR    = "RDG"
L.TRADE_ABBR              = "E"
L.WORLDDEFENSE_ABBR       = "DM"

L.BATTLEGROUND_ABBR        = "SF"
L.BATTLEGROUND_LEADER_ABBR = "SFL"
L.GUILD_ABBR               = "G"
L.OFFICER_ABBR             = "O"
L.PARTY_ABBR               = "G"
L.PARTY_GUIDE_ABBR         = "GL"
L.PARTY_LEADER_ABBR        = "GL"
L.RAID_ABBR                = "R"
L.RAID_LEADER_ABBR         = "RL"
L.RAID_WARNING_ABBR        = "AR"
L.SAY_ABBR                 = "D"
L.YELL_ABBR                = "C"
L.WHISPER_ABBR             = "De" -- incoming
L.WHISPER_INFORM_ABBR      = "À" -- outgoing

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

L["Short channel names"] = "Noms de canaux courts"
L["Shorten channel names and chat strings."] = "Raccourcis les noms de canaux et de chat"
L["Short player names"] = "Noms de joueurs courts"
L["Shorten player names by removing realm names and Real ID last names."] = "Raccourcis les noms des joueurs en ôtant les noms de serveurs et les noms de famille d'ID réélle"
L["Replace real names"] = "Remplacer noms rééls"
L["Replace Real ID names with character names."] = "Remplace le nom réél par le nom de personnage"
L["Enable arrow keys"] = "Autoriser touches flèches"
L["Enable arrow keys in the chat edit box."] = "Autoriser l'utilisation des touches flèches dans la fenêtre de chat"
L["Enable resize edges"] = "Améliorer redimensionnement"
L["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."] = "Autorise le redimensionnement grâce à tous les coins de la chatbox, au lieu du seul coin bas droit."
L["Link URLs"] = "Liens URLs"
L["Transform URLs in chat into clickable links for easy copying."] = "Transforme les URLs dans la fenêtre de chat en liens cliquables"
L["Lock docked tabs"] = "Vérouiller les onglets"
L["Prevent docked chat tabs from being dragged unless the Shift key is down."] = "Enpêche de bouger les onglets sans appuyer sur la touche shift."
L["Move edit boxes"] = "Bouger la fenêtre d'édition"
L["Move chat edit boxes to the top their respective chat frame."] = "Déplace les fenêtres d'édition en haut de leur fenêtres de chat respectives."
L["Hide buttons"] = "Masquer les boutons"
L["Hide the chat frame menu and scroll buttons."] = "Masque le menu du cadre et les boutons"
L["Hide extra textures"] = "Masquer les textures supplémentaires"
L["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = "Masque les textures supplémentaires des onglets et de l'edit box ajoutées avec la 3.3.5."
L["Hide tab flash"] = "Masquer le flash des onglets"
L["Disable the flashing effect on chat tabs that receive new messages."] = "Désactive l'effet de flash des onglets qui ont un nouveau message."
L["Hide notices"] = "Masquer les avertissements"
L["Hide channel notification messages."] = "Masquer les messages de notification de changement de canal."
L["Hide repeats"] = "Masquer les spams"
L["Hide repeated messages in public channels."] = "Masque les message spammés sur les canaux publics"
L["Sticky chat"] = "Canal mémorisé"
L["Set which chat types should be sticky."] = "Sélectionne le type de canal mémorisé."
L["All"] = "Tous"
L["Default"] = "Défaut"
L["None"] = "Aucun"
L["Fade time"] = "Temps d'estompage"
L["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."] = "Régle le temps, en minutes, à attendre avant l'estompage du texte. Une valeur de 0 désactivera l'estompage."
L["Font size"] = "Taille de police"
L["Set the font size for all chat frames."] = "Régle la taille de police pour toutes les fenêtres de chat"
L["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."] = "Notez que ceci est juste un raccourcis pour configurer les fenêtres de chat via les options d'affichage de Blizzard."

------------------------------------------------------------------------