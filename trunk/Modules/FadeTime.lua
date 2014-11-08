--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Copyright (c) 2006-2014 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat

	Please DO NOT upload this addon to other websites, or post modified
	versions of it. However, you are welcome to include this addon
	WITHOUT CHANGES in compilations posted on Curse and/or WoWInterface.
	You are also welcome to use any/all of its code in your own addon, as
	long as you do not use my name or the name of this addon ANYWHERE in
	your addon, including its name, outside of an optional attribution.
----------------------------------------------------------------------]]

local _, PhanxChat = ...

function PhanxChat:FadeTime(frame)
	if self.db.FadeTime > 0 then
		frame:SetFading(true)
		frame:SetTimeVisible(self.db.FadeTime * 60)
	else
		frame:SetFading(false)
	end
end

function PhanxChat:SetFadeTime(v)
	if self.debug then print("PhanxChat: SetFadeTime", v) end
	if type(v) == "number" then
		self.db.FadeTime = v
	end

	for frame in pairs(self.frames) do
		self:FadeTime(frame)
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetFadeTime)
table.insert(PhanxChat.RunOnProcessFrame, PhanxChat.FadeTime)