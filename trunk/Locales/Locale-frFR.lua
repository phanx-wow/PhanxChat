--[[--------------------------------------------------------------------
	French translations for PhanxChat
	Last updated yyyy-mm-dd by ????
	Contributors:
		Kyron - Halcyon (Auchindoun)
		Nicolas (miaouxp)
----------------------------------------------------------------------]]

if not GetLocale() == "frFR" then return end

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

L["Hide buttons"] = "Cacher le bouton"
L["Hide the scroll-up, scroll-down, scroll-to-bottom, and menu buttons next to the chat frame."] = "Cacher les boutons de défilement"

L["Shorten channels"] = "Raccourcir le nom des canaux"
L["Shorten channel names in chat messages. For example, '[1. General]' might be shortened to '1|'."] = "Raccourcir le nom des canaux"

L["Enable arrow keys"] = "Flèches dans la fenêtre"
L["Enable the use of arrow keys in the chat edit box."] = "Activer les flèches dans la fenêtre de saisie"

L["Move chat edit box"] = "Déplacement de la fenêtre"
L["Move the chat edit box to the top of the chat frame."] = "Déplacer la fenêtre de saisie au dessus du chat"

L["Disable tab flashing"] = "Flash des onglets"
L["Disable the flashing effect on chat tabs when new messages are received."] = "Désactiver le flash des onglets"

L["Auto-start logging"] = "Sauvegarde du chat"
L["Automatically enable chat logging when you log in. Chat logging can be started or stopped manually at any time using the '/chatlog' command. Logs are saved when you log out or exit the game to the 'World of Warcraft/Logs/WoWChatLog.txt' file."] = "Démarrer la sauvegarde du chat automatiquement"

L["Color player names"] = "Noms des joueurs colorés"
L["Color player names in chat by their class if known. Classes are known if you have seen the player in your group, in your guild, online on your friends list, in a '/who' query, or have targetted or moused over them since you logged in."] = "Colorer le nom des joueurs selon leur classe, si connu"

L["Mousewheel scrolling"] = "Défilement molette"
L["Enable scrolling through chat frames with the mouse wheel. Hold the Shift key while scrolling to jump to the top or bottom of the chat frame."] = "Autoriser le défilement via la molette"

L["Sticky channels"] = "Canaux collants"
L["Enable sticky channel behavior for all chat types except emotes."] = "Rendre plus de canaux \"collant\""

L["Suppress notifications"] = "Notifications des canaux"
L["Suppress the notification messages informing you when someone leaves or joins a channel, or when channel ownership changes."] = "Supprimer les messages de notification des canaux"

L["Suppress repeats"] = "Messages redondants"
L["Suppress repeated messages in public chat channels."] = "Supprimer les messages redondants dans les canaux publics"

L["Lock tabs"] = "Bloc du déplacement des onglets"
L["Prevent docked chat tabs from being dragged unless the Alt key is down."] = "Bloquer le déplacement des onglets (maintenir Alt pour déplacer)"

L["Link URLs"] = "URLs cliquables"
L["Turn URLs in chat messages into clickable links for easy copying."] = "URLs cliquables (permettant le copier/coller)"

L["Chat fade time"] = "Fondu du texte"
L["Set the time in minutes to keep chat messages visible before fading them out. Setting this to 0 will disable fading completely."] = "Régler le délai du fondu du texte en minutes (0 = désactivé)"

L["Chat font size"] = "Taille de la police"
L["Set the font size for all chat tabs at once. This is only a shortcut for doing the same thing for each tab using the default UI."] = "Définir la taille de la police pour toutes les fenêtres"

-- Don't touch this.

PHANXCHAT_LOCALS = L