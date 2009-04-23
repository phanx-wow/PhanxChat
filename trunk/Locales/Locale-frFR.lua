--[[--------------------------------------------------------------------
	French translations for PhanxChat
	Last updated 2008-04-22 by Beartotem of Ravenholdt(US)
	Contributors:
		Beartotem of Ravenholdt(US)
		Kyron - Halcyon (Auchindoun)
		Nicolas (miaouxp)
----------------------------------------------------------------------]]

if GetLocale() ~= "frFR" then return end

local L = {
-- Translating these strings is required for the addon to function in
-- this locale. These strings are used to detect server channel names.

	CHANNEL_GENERAL			= "Général",
	CHANNEL_TRADE				= "Commerce",
	CHANNEL_LOCALDEFENSE		= "Défense Locale",
	CHANNEL_WORLDDEFENSE		= "Défense du monde",
	CHANNEL_LOOKINGFORGROUP		= "Recherche de groupe",
	CHANNEL_GUILDRECRUITMENT		= "Recrutement de guilde",

-- Translating these strings is optional, but highly recommended. These
-- strings are displayed if the user has "short channel names" enabled.

	SHORT_GENERAL 				= "G",
	SHORT_TRADE 				= "E",
	SHORT_LOCALDEFENSE 			= "DL",
	SHORT_WORLDDEFENSE 			= "DM",
	SHORT_LOOKINGFORGROUP		= "RDG",
	SHORT_GUILDRECRUITMENT		= "R",

	SHORT_SAY 				= "D",
	SHORT_YELL 				= "C",
	SHORT_GUILD 				= "G",
	SHORT_OFFICER 				= "O",
	SHORT_PARTY 				= "G",
	SHORT_RAID 				= "R",
	SHORT_RAID_LEADER 			= "RL",
	SHORT_RAID_WARNING 			= "AR",
	SHORT_BATTLEGROUND 			= "BG",
	SHORT_BATTLEGROUND_LEADER 	= "BGL",
	SHORT_WHISPER 				= "W",
	SHORT_WHISPER_INFORM 		= "W",
}

-- Translating these strings is optional, but recommended. These strings
-- are shown in the configuration GUI.

L["Hide buttons"] = "Cacher les boutons"
L["Hide the scroll-up, scroll-down, scroll-to-bottom, and menu buttons next to the chat frame."] = "Cache les boutons de défilement."

L["Shorten channels"] = "Raccourcir les canaux"
L["Shorten channel names in chat messages. For example, '[1. General]' might be shortened to '1|'."] = "Raccourcit le nom des canaux. Par exemple \"[1. Général]\" devient \"1|\"."

L["Enable arrow keys"] = "Activer les flèches."
L["Enable the arrow keys in the chat edit box."] = "Permet l'usage des flèches du clavier dans l'espace de saisie."

L["Move chat edit box"] = "Déplacer l'espace de saisie"
L["Move the chat edit box to the top of the chat frame."] = "Déplace l'espace de saisie du texte au dessus du chat."

L["Disable tab flashing"] = "Empêcher flash des onglets"
L["Disable the flashing effect on chat tabs when new messages are received."] = "Désactive le flash des onglets lorsque de nouveaux messages arrivent."

L["Auto-start logging"] = "Enregistrement auto"
L["Automatically enable chat logging when you log in. Chat logging can be started or stopped manually at any time using the '/chatlog' command. Logs are saved when you log out or exit the game to the 'World of Warcraft/Logs/WoWChatLog.txt' file."] = "Démarre l'enregistrement du chat automatiquement. L'enregistrement du chat peut être arrêter ou démarrer a tout moment avec la commande \"/chatlog\". L’enregistrement est sauvegarder dans le fichier \"World of Warcraft/Logs/WoWChatLog.txt\" lorsque vous quitter le jeu ou changer de personnage."

L["Color player names"] = "Colorer le nom des joueurs"
L["Color player names in chat by their class if known. Classes are known if you have seen the player in your group, in your guild, online on your friends list, in a '/who' query, or have targetted or moused over them since you logged in."] = "Colore le nom des joueurs selon leur classe, si elle est connu. Leur classe est connu si vous avez former une équipe avec eux, s'il sont dans votre guilde ou dans votre liste d'amis, si vous les avez visés ou pointés avec votre curseur."

L["Mousewheel scrolling"] = "Activer la roue de sourie"
L["Enable scrolling through chat frames with the mouse wheel. Hold the Shift key while scrolling to jump to the top or bottom of the chat frame."] = "Permet le défilement avec la molette de la sourie. Appuyer sur ‘Maj’ pour que la molette défile le chat jusqu’à la première ou la dernière ligne."

L["Sticky channels"] = "Canaux collants"
L["Enable sticky channel behavior for all chat types except emotes."] = "Rend tous les canaux \"collant\""

L["Suppress notifications"] = "Suprimer les notifications"
L["Suppress the notification messages informing you when someone leaves or joins a channel, or when channel ownership changes."] = "Supprime les messages vous informent lorsque quelqu’un rejoint ou quitte un canal, ou lorsque le maitre du canal change."

L["Suppress repeats"] = "Supprimer les répétition"
L["Suppress repeated messages in public chat channels."] = "Supprime les messages redondants dans les canaux publics"

L["Lock tabs"] = "Vérrouillage des onglets"
L["Prevent docked chat tabs from being dragged unless the Alt key is down."] = "Empêche le déplacement des onglets (maintenir Alt pour les déplacer)."

L["Link URLs"] = "URLs copiable"
L["Turn URLs in chat messages into clickable links for easy copying."] = "Transforme les URLs en liens cliquables qui permet de les copier/coller."

L["Chat fade time"] = "Temps de fondu du texte"
L["Set the time in minutes to keep chat messages visible before fading them out. Setting this to 0 will disable fading completely."] = "Règle le temps, en minute, avant que les messages du chat ne partent en fondu. Régler ceci à 0 désactive le fondu du texte."

L["Chat font size"] = "Taille de la police"
L["Set the font size for all chat tabs at once. This is only a shortcut for doing the same thing for each tab using the default UI."] = "Défini la taille de la police pour tout les onglets à la fois. Ceci est seulement un raccourcit et peut être fait individuellement pour chaque onglet en utilisant l’interface par défaut."

-- Don't touch this.

PHANXCHAT_LOCALS = L