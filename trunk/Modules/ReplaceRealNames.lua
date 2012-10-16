--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2012 Phanx <addons@phanx.net>. All rights reserved.
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

local shortNames = { }
local toonNames = { }

local function UpdateShortNames()
	--print("UpdateShortNames")
	wipe(shortNames)
	wipe(toonNames)
	for i = 1, BNGetNumFriends() do
		local pID, realName, battleTag, isBTagFriend, charName, charID, client, online, _, _, _, _, note, isRIDFriend = BNGetFriendInfo(i)
		--print(pID, realName, isRIDFriend, battleTag, isBTagFriend, online, client, charID, charName)
		if isRIDFriend then
			-- This works because the game ignores extra placeholders in the string:
			local short = gsub(realName, "|Kf", "|Kg")
			shortNames[pID] = short
			--print("Using first name", short)
		elseif isBTagFriend then
			local short = gsub(battleTag, "#.+", "")
			shortNames[pID] = short
			--print("Using BattleTag", short)
		end
		if online and charID and client == BNET_CLIENT_WOW then
			--print("Online in WoW")
			local _, charName, _, realm, _, _, _, class = BNGetToonInfo(charID)
			local token = classTokens[class]
			local color = token and (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[token]
			if color then
				--print("Valid class", class, token)
				if realm and realm:len() > 0 and realm ~= playerRealm then
					--print("Other realm", realm)
					toonNames[pID] = string.format("|cff%02x%02x%02x%s-%s|r", color.r * 255, color.g * 255, color.b * 255, charName, realm)
				else
					--print("Same realm")
					toonNames[pID] = string.format("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, charName)
				end
			else
				--print("Invalid class", class)
			end
		end
		if not toonNames[pID] then
			--print("Failed, using first name.")
			toonNames[pID] = shortNames[pID]
		end
		--print("toonName:", toonNames[pID])
	end
	--print("Done.")
end

PhanxChat.BN_FRIEND_ACCOUNT_ONLINE = UpdateShortNames
PhanxChat.BN_FRIEND_TOON_ONLINE = UpdateShortNames
PhanxChat.PLAYER_ALIVE = UpdateShortNames
PhanxChat.PLAYER_ENTERING_WORLD = UpdateShortNames

PhanxChat.bnToonNames = toonNames
PhanxChat.bnShortNames = shortNames

------------------------------------------------------------------------

local function RemoveExtraName( _, _, message, ... )
	local icon = message:match( "|TInterface\ChatFrame\UI-ChatIcon[^|]|t" )
	if icon then
		message = message:replace( "|TInterface\FriendsFrame\UI-Toast-ToastIcons.tga:16:16:0:128:64:2:29:34:61|t", icon )
	end
	return true, message:gsub( " %(.-%)", "", 1 ), ...
end

------------------------------------------------------------------------

function PhanxChat:SetReplaceRealNames(v)
	-- print("PhanxChat: SetReplaceRealNames", v)
	if type(v) == "boolean" then
		self.db.ReplaceRealNames = v
	end

	if self.db.ReplaceRealNames or self.db.ShortenPlayerNames then
		ChatFrame_AddMessageEventFilter("BN_INLINE_TOAST_ALERT", RemoveExtraName)
		self:RegisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
		self:RegisterEvent("BN_FRIEND_TOON_ONLINE")
		self:RegisterEvent("PLAYER_ENTERING_WORLD")
		UpdateShortNames()
	else
		ChatFrame_RemoveMessageEventFilter("BN_INLINE_TOAST_ALERT", RemoveExtraName)
		self:UnregisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
		self:UnregisterEvent("BN_FRIEND_TOON_ONLINE")
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		wipe(shortNames)
		wipe(toonNames)
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetReplaceRealNames)

------------------------------------------------------------------------

local BN_WHO_LIST_FORMAT = WHO_LIST_FORMAT:replace("player:%s", "%s")
local BN_WHO_LIST_GUILD_FORMAT = WHO_LIST_GUILD_FORMAT:replace("player:%s", "%s")
local BN_WHO_LIST_REALM_FORMAT = BN_WHO_LIST_FORMAT .. " (%s)"
local BN_WHO_LIST_GUILD_REALM_FORMAT = BN_WHO_LIST_GUILD_FORMAT .. " (%s)"

local prehook_OnHyperlinkShow = ChatFrame_OnHyperlinkShow

local dialogs = {
	"ADD_FRIEND",
	"ADD_GUILDMEMBER",
	"ADD_IGNORE",
	"ADD_MUTE",
	"ADD_RAIDMEMBER",
	"ADD_TEAMMEMBER",
	"CHANNEL_INVITE",
}

function ChatFrame_OnHyperlinkShow(frame, link, text, button)
	if link:sub(1, 8) == "BNplayer" then
		local linkID = tonumber(link:match("|Kf(%d+)"))
		if linkID and IsModifiedClick("CHATLINK") and not ChatEdit_GetActiveWindow() and not HelpFrameOpenTicketEditBox:IsVisible() then
			local dialogUp
			for _, dialog in ipairs(dialogs) do
				if StaticPopup_Visible(dialog) then
					dialogUp = true
					break
				end
			end
			if not dialogUp then
				for i = 1, BNGetNumFriends() do
					local pID, firstName, lastName, _, toonID = BNGetFriendInfo(i)
					if pID == linkID then
						local color = ChatTypeInfo.SYSTEM
						local fullName = format(BATTLENET_NAME_FORMAT, firstName, lastName)
						if toonID then
							local hasFocus, toonName, client, realmName, realmID, faction, race, class, guild, zoneName, level, gameText, broadcastText, broadcastTime = BNGetToonInfo(toonID)
							if client ~= BNET_CLIENT_WOW then
								return DEFAULT_CHAT_FRAME:AddMessage((L["%s is currently playing %s."]):format(fullName, gameText), color.r, color.g, color.b)
							elseif realm == GetRealmName() then
								if guild and guild ~= "" then
									return DEFAULT_CHAT_FRAME:AddMessage((BN_WHO_LIST_GUILD_FORMAT):format(link, toonName, level, race, class, guild, zone), color.r, color.g, color.b)
								else
									return DEFAULT_CHAT_FRAME:AddMessage((BN_WHO_LIST_FORMAT):format(link, toonName, level, race, class, zone), color.r, color.g, color.b)
								end
							elseif guild and guild ~= "" then
								return DEFAULT_CHAT_FRAME:AddMessage((BN_WHO_LIST_GUILD_REALM_FORMAT):format(link, toonName, level, race, class, guild, zone, realmName), color.r, color.g, color.b)
							else
								return DEFAULT_CHAT_FRAME:AddMessage((BN_WHO_LIST_REALM_FORMAT):format(link, toonName, level, race, class, zone, realmName), color.r, color.g, color.b)
							end
						else
							return DEFAULT_CHAT_FRAME:AddMessage((L["%s is currently offline."]):format(fullName), color.r, color.g, color.b)
						end
						break
					end
				end
			end
		end
	end
	return prehook_OnHyperlinkShow(frame, link, text, button)
end