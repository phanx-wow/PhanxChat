--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2006–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx
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
	wipe(shortNames)
	wipe(toonNames)

	for i = 1, BNGetNumFriends() do
		local pID, gName, sName, _, tID, client, online, _, _, _, note = BNGetFriendInfo(i)
		-- print("Checking friend", pID, gName, sName, client, online, note)
		if note and note:len() > 0 and note:len() < gName:match("|k(.+)|k"):len() then
			-- print("shortName NOTE", note)
			shortNames[pID] = note
		else
			-- print("shortName", gName)
			shortNames[pID] = gName
		end
		if online and tID and client == BNET_CLIENT_WOW then
			-- print("Online in WoW")
			local _, name, _, realm, _, _, class = BNGetToonInfo(tID)
			local color = classTokens[class] and (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[classTokens[class]]
			if color then
				-- print("Valid class", class, classTokens[class])
				if realm and realm:len() > 0 and realm ~= playerRealm then
					-- print("Other realm", realm)
					toonNames[pID] = string.format("|cff%02x%02x%02x%s-%s|r", color.r * 255, color.g * 255, color.b * 255, name, realm)
				else
					-- print("Same realm")
					toonNames[pID] = string.format("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, name)
				end
			end
		end
		if not toonNames[pID] then
			toonNames[pID] = shortNames[pID]
		end
		-- print("toonName", toonNames[pID])
	end
end

PhanxChat.BN_FRIEND_ACCOUNT_ONLINE = UpdateShortNames
PhanxChat.BN_FRIEND_TOON_ONLINE = UpdateShortNames
PhanxChat.PLAYER_ENTERING_WORLD = UpdateShortNames

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
		self:RegisterEvent("PLAYER_ENTERING_WORLD")
		UpdateShortNames()
	else
		self:UnregisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
		self:UnregisterEvent("BN_FRIEND_TOON_ONLINE")
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		wipe(shortNames)
		wipe(toonNames)
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetReplaceRealNames)

------------------------------------------------------------------------

local BN_WHO_LIST_FORMAT = WHO_LIST_FORMAT:gsub("player:%%s", "%s")
local BN_WHO_LIST_GUILD_FORMAT = WHO_LIST_GUILD_FORMAT:gsub("player:%%s", "%s")

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
							local hasFocus, toonName, client, realm, faction, race, class, guild, zone, level, gameText = BNGetToonInfo(toonID)
							if client ~= BNET_CLIENT_WOW then
								return DEFAULT_CHAT_FRAME:AddMessage((L["%s is currently playing %s."]):format(fullName, gameText), color.r, color.g, color.b)
							elseif guild and guild ~= "" then
								return DEFAULT_CHAT_FRAME:AddMessage((BN_WHO_LIST_GUILD_FORMAT):format(link, toonName, level, race, class, guild, zone), color.r, color.g, color.b)
							else
								return DEFAULT_CHAT_FRAME:AddMessage((BN_WHO_LIST_FORMAT):format(link, toonName, level, race, class, zone), color.r, color.g, color.b)
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

------------------------------------------------------------------------