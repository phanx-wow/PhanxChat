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

local classColors = { }
if CUSTOM_CLASS_COLORS then
	for k, v in pairs(CUSTOM_CLASS_COLORS) do classColors[k] = format("%02x%02x%02x", v.r * 255, v.g * 255, v.b * 255) end
else
	for k, v in pairs(RAID_CLASS_COLORS) do classColors[k] = format("%02x%02x%02x", v.r * 255, v.g * 255, v.b * 255) end
end

local classTokens = { }
for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do classTokens[v] = k end
for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do classTokens[v] = k end

local missing = { }

local bnames = setmetatable({ }, { __index = function(t, name)
	local result

	for i = 1, BNGetNumFriends() do
		local _, firstName, lastName, _, toonID, client = BNGetFriendInfo(i)
		if firstName and lastName then
			local fullName = format(BATTLENET_NAME_FORMAT, firstName, lastName)
			if fullName == name then
				if client == BNET_CLIENT_WOW then
					local _, toonName, _, realm, _, _, class = BNGetToonInfo(toonID)
					if class then
						local color = classColors[classTokens[class]]
						if realm ~= myRealm then
							result = format("|cff%s%s-%s|r", color, toonName, realm)
						else
							result = format("|cff%s%s|r", color, toonName)
						end
					end
				else
					result = name
				end
			end
		end
	end

	if result then
		t[name] = result
		return result
	else
		missing[name] = true
	end
end })

local function wipe_bnames()
	wipe(bnames)
	wipe(missing)
end

PhanxChat.BN_FRIEND_ACCOUNT_ONLINE = wipe_bnames
PhanxChat.BN_FRIEND_TOON_ONLINE = wipe_bnames

PhanxChat.bnames = bnames

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
		wipe_bnames()
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetReplaceRealNames)

------------------------------------------------------------------------

local BN_WHO_LIST_FORMAT = WHO_LIST_FORMAT:replace("player:%s", "%s")
local BN_WHO_LIST_GUILD_FORMAT = WHO_LIST_GUILD_FORMAT:replace("player:%s", "%s")

local prehook_OnHyperlinkShow = ChatFrame_OnHyperlinkShow

function ChatFrame_OnHyperlinkShow(frame, link, text, button)
	if link:sub(1, 8) == "BNplayer" then
		local linkName = link:sub(10):match("[^:]+")
		if linkName and linkName:len() > 0
		and IsModifiedClick("CHATLINK")
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
				local _, firstName, lastName, _, toonID = BNGetFriendInfo(i)
				if firstName and lastName and toonID then
					local fullName = format(BATTLENET_NAME_FORMAT, firstName, lastName)
					if fullName == linkName then
						local hasFocus, toonName, client, realm, faction, race, class, guild, zoneName, level, gameText = BNGetToonInfo(toonID)
						local color = ChatTypeInfo.SYSTEM
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
	end
	return prehook_OnHyperlinkShow(frame, link, text, button)
end

------------------------------------------------------------------------