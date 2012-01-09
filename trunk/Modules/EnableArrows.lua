--[[--------------------------------------------------------------------
	PhanxChat
	Reduces chat frame clutter and enhances chat frame functionality.
	Written by Phanx <addons@phanx.net>
	Copyright © 2006–2012 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
----------------------------------------------------------------------]]

local _, PhanxChat = ...

function PhanxChat:EnableArrows(frame)
	local editBox = _G[frame:GetName() .. "EditBox"]
	if editBox then
		editBox:SetAltArrowKeyMode(not self.db.EnableArrows)
	end
end

function PhanxChat:SetEnableArrows(v)
	if self.debug then print("PhanxChat: SetEnableArrows", v) end
	if type(v) == "boolean" then
		self.db.EnableArrows = v
	end

	for frame in pairs(self.frames) do
		self:EnableArrows(frame)
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetEnableArrows)
table.insert(PhanxChat.RunOnProcessFrame, PhanxChat.EnableArrows)

------------------------------------------------------------------------