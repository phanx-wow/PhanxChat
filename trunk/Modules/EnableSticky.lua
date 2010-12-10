--[[--------------------------------------------------------------------
PhanxChat
Reduces chat frame clutter and enhances chat frame functionality.

http://www.wowinterface.com/downloads/info6323-PhanxChat.html
http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx

Copyright © 2006–2010 Phanx < addons@phanx.net >

I, the copyright holder of this work, hereby release it into the public
domain. This applies worldwide. In case this is not legally possible:
I grant anyone the right to use this work for any purpose, without any
conditions, unless such conditions are required by law.
----------------------------------------------------------------------]]

local _, PhanxChat = ...

local StickyChannels

function PhanxChat:SetEnableSticky(v)
	if self.debug then print("PhanxChat: SetEnableSticky", v) end
	if type(v) == "string" and v == "ALL" or v == "BLIZZARD" or v == "NONE" then
		self.db.EnableSticky = v
	end

	if self.db.EnableSticky == "ALL" then
		for chatType in pairs(StickyChannels) do
			ChatTypeInfo[chatType].sticky = 1
		end
		ChatTypeInfo.EMOTE.sticky = 0
		ChatTypeInfo.RAID_WARNING.sticky = 0
	elseif self.db.EnableSticky == "BLIZZARD" then
		for chatType, defaultValue in pairs(StickyChannels) do
			ChatTypeInfo[chatType].sticky = defaultValue
		end
	elseif self.db.EnableSticky == "NONE" then
		for chatType in pairs(StickyChannels) do
			ChatTypeInfo[chatType].sticky = 0
		end
	end

	for frame in pairs(PhanxChat.frames) do
		local editBox = _G[frame:GetName() .. "EditBox"]
		if editBox then
			local stickyType = editBox:GetAttribute("stickyType")
			if ChatTypeInfo[stickyType].sticky == 0 then
				editBox:SetAttribute("chatType", "SAY")
				editBox:SetAttribute("stickyType", "SAY")
			end
		end
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetEnableSticky)

------------------------------------------------------------------------

StickyChannels = {
	BATTLEGROUND = ChatTypeInfo.BATTLEGROUND.sticky,
	BN_CONVERSATION = ChatTypeInfo.BN_CONVERSATION.sticky,
	BN_WHISPER = ChatTypeInfo.BN_WHISPER.sticky,
	CHANNEL = ChatTypeInfo.CHANNEL.sticky,
	EMOTE = ChatTypeInfo.EMOTE.sticky,
	GUILD = ChatTypeInfo.GUILD.sticky,
	OFFICER = ChatTypeInfo.OFFICER.sticky,
	PARTY = ChatTypeInfo.PARTY.sticky,
	RAID = ChatTypeInfo.RAID.sticky,
	RAID_WARNING = ChatTypeInfo.RAID_WARNING.sticky,
	SAY = ChatTypeInfo.SAY.sticky,
	WHISPER = ChatTypeInfo.WHISPER.sticky,
	YELL = ChatTypeInfo.YELL.sticky,
}

------------------------------------------------------------------------