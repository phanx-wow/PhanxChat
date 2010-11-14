------------------------------------------------------------------------
--	PhanxChat                                                         --
--	Removes chat frame clutter and adds some functionality.           --
--	by Phanx < addons@phanx.net >                                     --
--	Copyright © 2006–2010 Phanx. See README for license terms.        --
--	http://www.wowinterface.com/downloads/info6323-PhanxChat.html     --
--	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx  --
------------------------------------------------------------------------

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
	wipe(shortNames)
	wipe(toonNames)

	for i = 1, BNGetNumFriends() do
		local pID, gName, sName, _, tID, client, online, _, _, _, note = BNGetFriendInfo(i)
		if note and note:len() > 0 and note:len() < gName:match("|k(.+)|k"):len() then
			shortNames[pID] = note
		else
			shortNames[pID] = gName
		end
		if online and tID and client == BNET_CLIENT_WOW then
			local _, name, _, realm, _, _, class = BNGetToonInfo(tID)
			local color = classTokens[class] and (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[classTokens[class]]
			if color then
				if realm and realm:len() > 0 and realm ~= playerRealm then
					toonNames[pID] = string.format("|cff%02x%02x%02x%s-%s|r", color.r * 255, color.g * 255, color.b * 255, name, realm)
				else
					toonNames[pID] = string.format("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, name)
				end
			else
				toonNames[pID] = shortNames[pID]
			end
		end
	end
end

PhanxChat.BN_FRIEND_ACCOUNT_ONLINE = UpdateShortNames
PhanxChat.BN_FRIEND_TOON_ONLINE = UpdateShortNames

PhanxChat.bnToonNames = toonNames
PhanxChat.bnShortNames = shortNames

------------------------------------------------------------------------

function PhanxChat:SetReplaceRealNames(v)
	if self.debug then print("PhanxChat: SetReplaceRealNames", v) end
	if type(v) == "boolean" then
		self.db.ReplaceRealNames = v
	end

	if self.db.ReplaceRealNames then
		self:RegisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
		self:RegisterEvent("BN_FRIEND_TOON_ONLINE")
	else
		self:UnregisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
		self:UnregisterEvent("BN_FRIEND_TOON_ONLINE")
		wipe(shortNames)
		wipe(toonNames)
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetReplaceRealNames)

------------------------------------------------------------------------

local BN_WHO_LIST_FORMAT = WHO_LIST_FORMAT:replace("player:%s", "%s")
local BN_WHO_LIST_GUILD_FORMAT = WHO_LIST_GUILD_FORMAT:replace("player:%s", "%s")

local prehook_OnHyperlinkShow = ChatFrame_OnHyperlinkShow

function ChatFrame_OnHyperlinkShow(frame, link, text, button)
	if link:sub(1, 8) == "BNplayer" then
		local linkID = link:match("|Kf(%d+)")
		if linkID and IsModifiedClick("CHATLINK")
		and not StaticPopup_Visible("ADD_IGNORE")
		and not StaticPopup_Visible("ADD_MUTE")
		and not StaticPopup_Visible("ADD_FRIEND")
		and not StaticPopup_Visible("ADD_GUILDMEMBER")
		and not StaticPopup_Visible("ADD_TEAMMEMBER")
		and not StaticPopup_Visible("ADD_RAIDMEMBER")
		and not StaticPopup_Visible("CHANNEL_INVITE")
		and not ChatEdit_GetActiveWindow()
		and not HelpFrameOpenTicketEditBox:IsVisible() then
			for i = 1, BNGetNumFriends() do
				local pID, firstName, lastName, _, toonID = BNGetFriendInfo(i)
				if pID == linkID then
					local color = ChatTypeInfo.SYSTEM
					local fullName = format(BATTLENET_NAME_FORMAT, firstName, lastName)
					local hasFocus, toonName, client, realm, faction, race, class, guild, zoneName, level, gameText = BNGetToonInfo(toonID)
					if client ~= BNET_CLIENT_WOW then
						return DEFAULT_CHAT_FRAME:AddMessage(format(L["%s is currently playing %s."], fullName, gameText), color.r, color.g, color.b)
					elseif guild and guild ~= "" then
						return DEFAULT_CHAT_FRAME:AddMessage(format(BN_WHO_LIST_GUILD_FORMAT, link, toonName, level, race, class, guild, zoneName), color.r, color.g, color.b)
					else
						return DEFAULT_CHAT_FRAME:AddMessage(format(BN_WHO_LIST_FORMAT, link, toonName, level, race, class, zoneName), color.r, color.g, color.b)
					end
				end
			end
		end
	end
	return prehook_OnHyperlinkShow(frame, link, text, button)
end

------------------------------------------------------------------------