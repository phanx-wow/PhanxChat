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

function PhanxChat:FadeTime(frame)
	if self.db.FadeTime > 0 then
		frame:SetFading(1)
		frame:SetTimeVisible(self.db.FadeTime * 60)
	else
		frame:SetFading(0)
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

------------------------------------------------------------------------