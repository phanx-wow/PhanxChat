------------------------------------------------------------------------
--	PhanxChat                                                         --
--	Removes chat frame clutter and adds some functionality.           --
--	by Phanx < addons@phanx.net >                                     --
--	Copyright © 2006–2010 Phanx. See README for license terms.        --
--	http://www.wowinterface.com/downloads/info6323-PhanxChat.html     --
--	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx  --
------------------------------------------------------------------------

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
	if type(v) == "boolean" then
		self.db.FadeTime = v
	end

	for frame in pairs(self.frames) do
		self:FadeTime(frame)
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetFadeTime)
table.insert(PhanxChat.RunOnProcessFrame, PhanxChat.FadeTime)

------------------------------------------------------------------------