--[[--------------------------------------------------------------------
	French translations for PhanxChat
	Last updated: 2008-04-22 by Beartotem
	Contributors:
		Beartotem of Ravenholdt (US)
		Kyron - Halcyon (Auchindoun)
		Nicolas (miaouxp)
----------------------------------------------------------------------]]

if GetLocale() ~= "frFR" then return end

local L, _, PhanxChat = { }, ...
PhanxChat.L = L

------------------------------------------------------------------------
-- Channel Names
-- These must match the channel names sent from the server.
------------------------------------------------------------------------

L["General"]          = "Général"
L["Trade"]            = "Commerce"
L["LocalDefense"]     = "Défense Locale"
L["WorldDefense"]     = "Défense du monde"
L["LookingForGroup"]  = "Recherche de groupe"
L["GuildRecruitment"] = "Recrutement de guilde"

------------------------------------------------------------------------
-- Short Channel Names
-- These should be one- or two-character abbreviations.
------------------------------------------------------------------------

L["SHORT_GENERAL"]          = "G"
L["SHORT_TRADE"]            = "E"
L["SHORT_LOCALDEFENSE"]     = "DL"
L["SHORT_WORLDDEFENSE"]     = "DM"
L["SHORT_LOOKINGFORGROUP"]  = "RDG"
L["SHORT_GUILDRECRUITMENT"] = "R"

------------------------------------------------------------------------
-- Short Chat Strings
-- These should be one- or two-character abbreviations.
------------------------------------------------------------------------

L["SHORT_BATTLEGROUND"]        = "BG"
L["SHORT_BATTLEGROUND_LEADER"] = "BGL"
L["SHORT_GUILD"]               = "G"
L["SHORT_OFFICER"]             = "O"
L["SHORT_PARTY"]               = "G"
L["SHORT_PARTY_GUIDE"]         = "GL"
L["SHORT_PARTY_LEADER"]        = "GL"
L["SHORT_RAID"]                = "R"
L["SHORT_RAID_LEADER"]         = "RL"
L["SHORT_RAID_WARNING"]        = "AR"
L["SHORT_SAY"]                 = "D"
L["SHORT_WHISPER"]             = "W"
L["SHORT_WHISPER_INFORM"]      = "W"
L["SHORT_YELL"]                = "C"

------------------------------------------------------------------------
--	Configuration Panel Text
--	Please verify that your translations fit in the available UI space!
------------------------------------------------------------------------

-- L["Configure options for making your chat frames more user-friendly and less cluttered."] = ""

L["Color player names"] = "Colorer le nom des joueurs"
L["Enable player name class coloring for all chat message types."] = "Colore le nom des joueurs selon leur classe, si elle est connu."
-- L["Note that this is just a shortcut to enabling class coloring for each message type individually through the Blizzard chat options."] = ""

L["Disable tab flashing"] = "Empêcher flash des onglets"
L["Disable the flashing effect on chat tabs that receive new messages."] = "Désactive le flash des onglets lorsque de nouveaux messages arrivent."

L["Enable arrow keys"] = "Activer les flèches"
L["Enable arrow keys in the chat edit box."] = "Permet l’usage des flèches du clavier dans l’espace de saisie."

L["Enable mousewheel"] = "Activer la roue de sourie"
L["Enable mousewheel scrolling in chat frames."] = "Permet le défilement avec la molette de la sourie. Appuyer sur ‘Maj’ pour que la molette défile le chat jusqu’à la première ou la dernière ligne."

L["Hide buttons"] = "Cacher les boutons"
L["Hide the chat frame menu and scroll buttons."] = "Cache les boutons de défilement."

L["Link URLs"] = "URLs copiable"
L["Transform URLs in chat into clickable links for easy copying."] = "Transforme les URLs en liens cliquables qui permet de les copier/coller."

L["Lock docked tabs"] = "Vérrouillage des onglets"
L["Prevent locked chat tabs from being dragged unless the Alt key is down."] = "Empêche le déplacement des onglets (maintenir Alt pour les déplacer)."

L["Move edit box"] = "Déplacer l’espace de saisie"
L["Move the chat edit box above the chat frame."] = "Déplace l’espace de saisie du texte au dessus du chat."

L["Shorten channel names"] = "Raccourcir les canaux"
L["Shorten channel names and chat strings."] = "Raccourcit le nom des canaux."

L["Sticky chat"] = "Canaux collants"
L["Set which chat types should be sticky."] = "Rend tous les canaux \"collant\"."
-- L["All"] = ""
-- L["Default"] = ""
-- L["None"] = ""

L["Fade time"] = "Temps de fondu"
L["Set the time in minutes to wait before fading chat text. A setting of 0 will disable fading."] = "Règle le temps, en minute, avant que les messages du chat ne partent en fondu. Régler ceci à 0 désactive le fondu du texte."

L["Font size"] = "Taille de la police"
L["Set the font size for all chat frames."] = "Défini la taille de la police pour tout les onglets à la fois."
L["Note that this is just a shortcut to setting the font size for each chat frame individually through the Blizzard chat options."] = "Ceci est seulement un raccourcit et peut être fait individuellement pour chaque onglet en utilisant l’interface par défaut."

L["Filter notifications"] = "Suprimer les notifications"
L["Hide channel notification messages."] = "Supprime les messages vous informent lorsque quelqu’un rejoint ou quitte un canal, ou lorsque le maitre du canal change."

L["Filter repeats"] = "Supprimer les répétition"
L["Hide repeated messages in public channels."] = "Supprime les messages redondants dans les canaux publics."

L["Auto-start chat log"] = "Enregistrement auto"
L["Automatically start chat logging when you log into the game."] = "Démarre l'enregistrement du chat automatiquement."
L["Chat logs are written to [ World of Warcraft > Logs > WoWChatLog.txt ] only when you log out of your character."] = "L’enregistrement est sauvegarder dans le fichier \"World of Warcraft/Logs/WoWChatLog.txt\" lorsque vous quitter le jeu ou changer de personnage."
L["You can manually start or stop chat logging at any time by typing /chatlog."] = "L'enregistrement du chat peut être arrêter ou démarrer a tout moment avec la commande \"/chatlog\"."

------------------------------------------------------------------------