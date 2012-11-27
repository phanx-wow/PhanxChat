--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2012 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
------------------------------------------------------------------------
	Localization: ptBR / Portuguese (Brazil) / Português (Brasil)
	Last Updated: 2012-11-23 by mgaedke @ Curse
----------------------------------------------------------------------]]

if GetLocale() ~= "ptBR" then return end
local _, PhanxChat = ...
PhanxChat.L = {

------------------------------------------------------------------------
--	Server Channel Names
--	These must exactly match the channel names used in your locale.
------------------------------------------------------------------------

	["Conversation"]     = "Conversa",
	["General"]          = "Geral",
	["LocalDefense"]     = "DefesaLocal",
	["LookingForGroup"]  = "ProcurandoGrupo",
	["Trade"]            = "Comércio",
	["WorldDefense"]     = "DefesaGlobal",

------------------------------------------------------------------------
--	Abbreviated Channel Names
--	These should be one- or two-character abbreviations.
------------------------------------------------------------------------

	CONVERSATION_ABBR       = "C",
	GENERAL_ABBR            = "Ge",
	LOCALDEFENSE_ABBR       = "DL",
	LOOKINGFORGROUP_ABBR    = "PG",
	TRADE_ABBR              = "Co",
	WORLDDEFENSE_ABBR       = "DG",

	BATTLEGROUND_ABBR        = "BG",
	BATTLEGROUND_LEADER_ABBR = "LCB",
	GUILD_ABBR               = "Gd",
	OFFICER_ABBR             = "O",
	PARTY_ABBR               = "G",
	PARTY_GUIDE_ABBR         = "LG",
	PARTY_LEADER_ABBR        = "LG",
	RAID_ABBR                = "R",
	RAID_LEADER_ABBR         = "LR",
	RAID_WARNING_ABBR        = "AR",
	SAY_ABBR                 = "D",
	YELL_ABBR                = "Gr",
	WHISPER_ABBR             = "d", -- incoming
	WHISPER_INFORM_ABBR      = "p", -- outgoing

------------------------------------------------------------------------
--	User Interface Strings
--	Please verify that your translations fit in the available UI space.
------------------------------------------------------------------------

	["Short channel names"] = "Curto nomes canais",
	["Shorten channel names and chat strings."] = "Encurtar os nomes dos canais de bate-papo.",
	["Short player names"] = "Curto nomes personagens",
	["Shorten player names by removing realm names and Real ID last names."] = "Encurtar os nomes dos jogadores através da remoção de nomes de reinos e sobrenomes Real ID.",
	["Replace real names"] = "Substituir nomes reais",
	["Replace Real ID names with character names."] = "Substituir nomes Real ID com nomes de personagens.",
	["Enable arrow keys"] = "Ativar teclas de seta",
	["Enable arrow keys in the chat edit box."] = "Ativar as teclas de seta na caixa de entrada de mensagens de bate-papo.",
	["Enable resize edges"] = "Bordas redimensionamento",
	["Enable resize controls at all edges of chat frames, instead of only the bottom right corner."] = "Redimensionar a janela de bate-papo usando qualquer borda, em vez de apenas o canto direito inferior.",
	["Link URLs"] = "URLs ligação",
	["Transform URLs in chat into clickable links for easy copying."] = "Transformar URLs no bate-papo em hyperlinks clicáveis ​​para facilitar a cópia.",
	["Lock docked tabs"] = "Travar guias acopladas",
	["Prevent docked chat tabs from being dragged unless the Shift key is down."] = "Só permitem arrastar guias acoplado de bate-papo quando a tecla Shift é pressionada.",
	["Move edit boxes"] = "Mover caixas mensagens",
	["Move chat edit boxes to the top their respective chat frame."] = "Mover caixas de entrada de mensagens de bate-papo para o topo da sua respectice janelas de chat.",
	["Hide buttons"] = "Ocultar botões",
	["Hide the chat frame menu and scroll buttons."] = "Ocultar o botão de menu e botões de rolagem de bate-papo.",
	["Hide extra textures"] = "Ocultar texturas extras",
	["Hide the extra textures on chat tabs and chat edit boxes added in patch 3.3.5."] = "Ocultar as texturas extras em guias de bate-papo e caixas de entrada de mensagem adicionados no patch 3.3.5.",
	["Hide tab flash"] = "Ocultar clarão guia",
	["Disable the flashing effect on chat tabs that receive new messages."] = "Não clarão das guias de bate-papo que receber novas mensagens.",
	["Hide notices"] = "Ocultar avisos",
	["Hide channel notification messages."] = "Ocultar mensagens de notificação de canais de bate-papo.",
	["Hide repeats"] = "Ocultar repetições",
	["Hide repeated messages in public channels."] = "Ocultar mensagens repetidas nos canais públicos de bate-papo.",
	["Sticky chat"] = "Canais fixos",
	["Set which chat types should be sticky."] = "Definir quais os tipos de bate-papo deve ser fixa.",
	["All"] = "Todos",
	["Default"] = "Padrão",
	["None"] = "Nenhum",
	["Fade time"] = "Tempo para desvanecer",
	["Set the time, in minutes, to wait before fading chat text. A setting of 0 will disable fading."] = "Definir o tempo, em minutos, para esperar antes de desvanecer mensagens de bate-papo. Uma configuração de 0 desativa a desvanecer.",
	["Font size"] = "Tamanho do texto",
	["Set the font size for all chat frames."] = "Definir o tamanho da fonte para todas as janelas de bate-papo.",
	["Note that this is just a shortcut to configuring each chat frame individually through the Blizzard chat options."] = "Note que este é apenas um atalho para a configuração de cada janela de bate-papo individualmente com as opções da Blizzard.",
	["Show class colors"] = "Cores das classes",
	["Show class colors in all channels."] = "Mostrar cores das classes em todos os canais.",
	["Note that this is just a shortcut to configuring each chat channel individually through the Blizzard chat options."] = "Note-se que este é apenas um atalho para a configuração de cada canal de chat individualmente através das opções de bate-papo da Blizzard.",
	["This option is locked by PhanxChat. If you wish to change it, you must first disable the %q option in PhanxChat."] = "Esta opção está bloqueado por PhanxChat. Se você deseja mudá-lo, você deve primeiro desativar a opção %q em PhanxChat."
}