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