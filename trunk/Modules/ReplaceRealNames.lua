--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
----------------------------------------------------------------------]]

local _, PhanxChat = ...
local L = PhanxChat.L

------------------------------------------------------------------------

local playerRealm = GetRealmName()

local classTokens = { }
for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do classTokens[v] = k end
for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do classTokens[v] = k end

local bnetNames = { }

local function UpdateBNetNames()
	--print("UpdateBNetNames")
	wipe(bnetNames)
	for i = 1, BNGetNumFriends() do
		local pID, realName, battleTag, isBTagFriend, charName, charID, client, online, _, _, _, _, note, isRIDFriend = BNGetFriendInfo(i)
		--print(pID, realName, isRIDFriend, battleTag, isBTagFriend, online, client, charID, charName)
		if online and charID and client == BNET_CLIENT_WOW and PhanxChatDB.ReplaceRealNames then
			--print("Online in WoW")
			local _, charName, _, realm, _, _, _, class = BNGetToonInfo(charID)
			local token = classTokens[class]
			local color = token and (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[token]
			if color then
				--print("Valid class:", class, token)
				if realm and realm:len() > 0 and realm ~= playerRealm then
					--print("Other realm:", realm)
					if PhanxChat.db.ShowClassColors then
						bnetNames[pID] = format("|cff%02x%02x%02x%s-%s|r", color.r * 255, color.g * 255, color.b * 255, charName, realm)
					else
						bnetNames[pID] = format("%s-%s", charName, realm)
					end
				else
					--print("Same realm")
					if PhanxChat.db.ShowClassColors then
						bnetNames[pID] = format("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, charName)
					else
						bnetNames[pID] = charName
					end
				end
			else
				--print("Invalid class:", class)
			end
		elseif not isRIDFriend or PhanxChatDB.ShortenRealNames == "BATTLETAG" then
			bnetNames[pID] = battleTag
			--print("Using BattleTag:", battleTag)
		elseif PhanxChatDB.ShortenRealNames == "FIRSTNAME" then
			-- This works because the game ignores extra placeholders in the string:
			local short = gsub(realName, "|Kf", "|Kg")
			bnetNames[pID] = short
			--print("Using first name:", short)
		else
			-- Fall back to full name
			bnetNames[pID] = realName
			--print("Using full name:", realName)
		end
	end
	--print("Done.")
end

PhanxChat.BN_FRIEND_ACCOUNT_ONLINE = UpdateBNetNames
PhanxChat.BN_FRIEND_TOON_ONLINE = UpdateBNetNames
PhanxChat.PLAYER_ALIVE = UpdateBNetNames
PhanxChat.PLAYER_ENTERING_WORLD = UpdateBNetNames

PhanxChat.bnetNames = bnetNames

------------------------------------------------------------------------

function PhanxChat:SetReplaceRealNames(v)
	-- print("PhanxChat: SetReplaceRealNames", v)
	if type(v) == "boolean" then
		self.db.ReplaceRealNames = v
	end

	if self.db.ReplaceRealNames or self.db.ShortenRealNames then
		self:RegisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
		self:RegisterEvent("BN_FRIEND_TOON_ONLINE")
		self:RegisterEvent("PLAYER_ENTERING_WORLD")
		UpdateBNetNames()
	else
		self:UnregisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
		self:UnregisterEvent("BN_FRIEND_TOON_ONLINE")
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		wipe(bnetNames)
		wipe(bnetNames)
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetReplaceRealNames)

------------------------------------------------------------------------

local BN_WHO_LIST_FORMAT = gsub(WHO_LIST_FORMAT, "|Hplayer:", "|H")
local BN_WHO_LIST_GUILD_FORMAT = gsub(WHO_LIST_GUILD_FORMAT, "|Hplayer:", "|H")
local BN_WHO_LIST_REALM_FORMAT = BN_WHO_LIST_FORMAT .. " (%s)"
local BN_WHO_LIST_GUILD_REALM_FORMAT = BN_WHO_LIST_GUILD_FORMAT .. " (%s)"

local dialogs = {
	"ADD_FRIEND",
	"ADD_GUILDMEMBER",
	"ADD_IGNORE",
	"ADD_MUTE",
	"ADD_RAIDMEMBER",
	"ADD_TEAMMEMBER",
	"CHANNEL_INVITE",
}

hooksecurefunc("ChatFrame_OnHyperlinkShow", function(frame, link, text, button)
	if strsub(link, 1, 8) == "BNplayer" then
		local linkID = tonumber(strmatch(link, "|Kf(%d+)"))
		if not linkID or not IsModifiedClick("CHATLINK") or ChatEdit_GetActiveWindow() or HelpFrameOpenTicketEditBox:IsVisible() then
			return
		end
		for _, dialog in ipairs(dialogs) do
			if StaticPopup_Visible(dialog) then
				return
			end
		end
		for i = 1, BNGetNumFriends() do
			local pID, realName, battleTag, isBTagFriend, charName, charID, client, online, _, _, _, _, note, isRIDFriend = BNGetFriendInfo(i)
			local showName = isRIDFriend and realName or battleTag
			if pID == linkID then
				local color = ChatTypeInfo.SYSTEM
				if charID then
					local hasFocus, charName, _, realmName, _, faction, race, class, guild, zoneName, level, gameText = BNGetToonInfo(charID)
					if client ~= BNET_CLIENT_WOW then
						if client == BNET_CLIENT_D3 then
							gameText = "Diablo III"
						elseif client == BNET_CLIENT_SC2 then
							gameText = "StarCraft II"
						end
						return DEFAULT_CHAT_FRAME:AddMessage(format(L.WhoStatus_PlayingOtherGame,
							showName, gameText),
							color.r, color.g, color.b)
					elseif realm == GetRealmName() then -- #TODO: Check in the future if Blizz fixes zone being nil
						if guild and guild ~= "" then
							return DEFAULT_CHAT_FRAME:AddMessage(gsub(format(BN_WHO_LIST_GUILD_FORMAT,
								link, charName, level, race, class, guild, zoneName or ""), "  ", " "),
								color.r, color.g, color.b)
						else
							return DEFAULT_CHAT_FRAME:AddMessage(gsub(format(BN_WHO_LIST_FORMAT,
								link, charName, level, race, class, zoneName or ""), "  ", " "),
								color.r, color.g, color.b)
						end
					elseif guild and guild ~= "" then
						return DEFAULT_CHAT_FRAME:AddMessage(gsub(format(BN_WHO_LIST_GUILD_REALM_FORMAT,
							link, charName, level, race, class, guild, zoneName or "", realmName), "  ", " "),
							color.r, color.g, color.b)
					else
						return DEFAULT_CHAT_FRAME:AddMessage(gsub(format(BN_WHO_LIST_REALM_FORMAT,
							link, charName, level, race, class, zoneName or "", realmName), "  ", " "),
							color.r, color.g, color.b)
					end
				else
					return DEFAULT_CHAT_FRAME:AddMessage(format(L.WhoStatus_Offline,
						showName),
						color.r, color.g, color.b)
				end
			end
		end
	end
end)