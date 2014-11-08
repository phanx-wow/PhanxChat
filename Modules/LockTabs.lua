--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2014 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat

	Please DO NOT upload this addon to other websites, or post modified
	versions of it. However, you are welcome to include a copy of it
	WITHOUT CHANGES in compilations posted on Curse and/or WoWInterface.
	You are also welcome to use any/all of its code in your own addon, as
	long as you do not use my name or the name of this addon ANYWHERE in
	your addon, including its name, outside of an optional attribution.
----------------------------------------------------------------------]]

local _, PhanxChat = ...

local function OnDragStart(tab)
	if IsAltKeyDown() or not _G[tab:GetName():sub(1, -4)].isDocked then
		PhanxChat.hooks[tab].OnDragStart(tab)
	end
end

function PhanxChat:LockTabs(frame)
	if frame == DEFAULT_CHAT_FRAME then return end

	local tab = _G[frame:GetName() .. "Tab"]

	if self.db.LockTabs then
		if not self.hooks[tab] then
			self.hooks[tab] = { }
		end
		if not self.hooks[tab].OnDragStart then
			self.hooks[tab].OnDragStart = tab:GetScript("OnDragStart")
			tab:SetScript("OnDragStart", OnDragStart)
		end
	else
		if self.hooks[tab] and self.hooks[tab].OnDragStart then
			tab:SetScript("OnDragStart", self.hooks[tab].OnDragStart)
			self.hooks[tab].OnDragStart = nil
		end
	end
end

function PhanxChat:SetLockTabs(v)
	if self.debug then print("PhanxChat: SetLockTabs", v) end
	if type(v) == "boolean" then
		self.db.LockTabs = v
	end

	for frame in pairs(self.frames) do
		self:LockTabs(frame)
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetLockTabs)
table.insert(PhanxChat.RunOnProcessFrame, PhanxChat.LockTabs)