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

local missing = { }

local bnames = setmetatable({ }, { __index = function(bnames, realname)
	if missing[realname] then return end

	local result
	for i = 1, BNGetNumFriends() do
		local _, first, last, _, id, client = BNGetFriendInfo(i)
		if first and last and client == BNET_CLIENT_WOW then
			local fullname = format(BATTLENET_NAME_FORMAT, first, last)
			if fullname == realname then
				local _, name, _, realm, _, _, class = BNGetToonInfo(id)
				if class then
					local token = classTokens[class]
					if token then
						local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[token]
						if color then
							if realm ~= playerRealm then
								name = format("%s-%s", name, realm)
							end
							result = format("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, name)
						end
					end
				end
			end
		end
	end

	if not result then
		missing[realname] = true
	end

	bnames[realname] = result
	return result
end })

local function wipe_bnames()
	wipe(bnames)
	wipe(missing)
end

PhanxChat.BN_FRIEND_ACCOUNT_ONLINE = wipe_bnames
PhanxChat.BN_FRIEND_TOON_ONLINE = wipe_bnames

PhanxChat.bnames = bnames

------------------------------------------------------------------------

function PhanxChat:SetShowBNetCharacters(v)
	if self.debug then print("PhanxChat: SetShowBNetCharacters", v) end
	if type(v) == "boolean" then
		self.db.ShowBNetCharacters = v
	end

	if self.db.ShowBNetCharacters then
		self:RegisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
		self:RegisterEvent("BN_FRIEND_TOON_ONLINE")
	else
		self:UnregisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
		self:UnregisterEvent("BN_FRIEND_TOON_ONLINE")
		wipe_bnames()
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetShowBNetCharacters)

------------------------------------------------------------------------

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
						if client ~= BNET_CLIENT_WOW then
							return print(format(L["%s is currently playing %s."], fullName, gameText)
						elseif guild then
							return print(format(WHO_LIST_GUILD_FORMAT, toonName, toonName, level, race, class, guild, zoneName)
						else
							return print(format(WHO_LIST_FORMAT, toonName, toonName, level, race, class, zoneName)
						end
					end
				end
			end
		end
	end
	return prehook_OnHyperlinkShow(frame, link, text, button)
end

------------------------------------------------------------------------