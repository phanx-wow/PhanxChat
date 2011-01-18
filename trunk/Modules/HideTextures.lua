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

--[[ -- not currently used
function PhanxChat.PanelTemplates_TabResize(tab, padding, absoluteSize, maxWidth, absoluteTextSize)
	local tabName = tab:GetName()
	if tabName:match("^ChatFrame%d") then
		absoluteSize = _G[("%sText"):format(tabName)]:GetStringWidth() + 35
	end
	return PhanxChat.hooks.PanelTemplates_TabResize(tab, padding, absoluteSize, maxWidth, absoluteTextSize)
end
]]

function PhanxChat:HideTextures(frame)
	if self.db.HideTextures then
		local name = frame:GetName()

		frame.clickAnywhereButton:SetScript("OnShow", frame.clickAnywhereButton.Hide)
		frame.clickAnywhereButton:Hide()

		local editBox = _G[name .. "EditBox"]

		if editBox then
			_G[name .. "EditBoxLeft"]:SetAlpha(0)
			_G[name .. "EditBoxRight"]:SetAlpha(0)
			_G[name .. "EditBoxMid"]:SetAlpha(0)

			editBox.focusLeft:SetTexture([[Interface\ChatFrame\UI-ChatInputBorder-Left2]])
			editBox.focusRight:SetTexture([[Interface\ChatFrame\UI-ChatInputBorder-Right2]])
			editBox.focusMid:SetTexture([[Interface\ChatFrame\UI-ChatInputBorder-Mid2]])
		end

		local tab = _G[name .. "Tab"]
		local tabText = _G[name .. "TabText"]

		tabText:ClearAllPoints()
		tabText:SetPoint("BOTTOMLEFT", tab, 10, 5)
		tabText:SetPoint("BOTTOMRIGHT", tab, -10, 5)
		tabText:SetJustifyH("LEFT")

		tab.noMouseAlpha = 0
		FCFTab_UpdateAlpha(frame)

		tab.leftSelectedTexture:SetAlpha(0)
		tab.leftHighlightTexture:SetTexture(nil)

		tab.rightSelectedTexture:SetAlpha(0)
		tab.rightHighlightTexture:SetTexture(nil)

		tab.middleSelectedTexture:SetAlpha(0)
		tab.middleHighlightTexture:SetTexture([[Interface\PaperDollInfoFrame\UI-Character-Tab-Highlight]])
		tab.middleHighlightTexture:SetHorizTile(false)
		tab.middleHighlightTexture:ClearAllPoints()
		tab.middleHighlightTexture:SetHeight(32)
		tab.middleHighlightTexture:SetPoint("LEFT", _G[name .. "TabLeft"], 0, -7)
		tab.middleHighlightTexture:SetPoint("RIGHT", _G[name .. "TabRight"], 0, -7)

		if not self.hooks[tab.middleHighlightTexture] then
			self.hooks[tab.middleHighlightTexture] = { }
		end
		if not self.hooks[tab.middleHighlightTexture].SetVertexColor then
			self.hooks[tab.middleHighlightTexture].SetVertexColor = tab.middleHighlightTexture.SetVertexColor
			tab.middleHighlightTexture.SetVertexColor = noop
		end
	else
		local name = frame:GetName()

		frame.clickAnywhereButton:SetScript("OnShow", nil)
		frame.clickAnywhereButton:Show()

		local editBox = _G[name .. "EditBox"]

		if editBox then
			_G[name .. "EditBoxLeft"]:SetAlpha(1)
			_G[name .. "EditBoxRight"]:SetAlpha(1)
			_G[name .. "EditBoxMid"]:SetAlpha(1)

			editBox.focusLeft:SetTexture([[Interface\ChatFrame\UI-ChatInputBorderFocus-Left]])
			editBox.focusRight:SetTexture([[Interface\ChatFrame\UI-ChatInputBorderFocus-Right]])
			editBox.focusMid:SetTexture([[Interface\ChatFrame\UI-ChatInputBorderFocus-Mid]])
		end

		local tab = _G[name .. "Tab"]
		local tabText = _G[name .. "TabText"]

		tab.noMouseAlpha = 0.4
		FCFTab_UpdateAlpha(frame)

		tabText:ClearAllPoints()
		tabText:SetPoint("BOTTOMLEFT", tab, 10, 5)
		tabText:SetPoint("BOTTOMRIGHT", tab, -10, 5)
		tabText:SetJustifyH("LEFT")

		tab.leftSelectedTexture:SetAlpha(1)
		tab.leftHighlightTexture:SetTexture([[Interface\ChatFrame\ChatFrameTab-HighlightLeft]])

		tab.rightSelectedTexture:SetAlpha(1)
		tab.rightHighlightTexture:SetTexture([[Interface\ChatFrame\ChatFrameTab-HighlightRight]])

		tab.middleSelectedTexture:SetAlpha(1)
		tab.middleHighlightTexture:SetTexture([[Interface\ChatFrame\ChatFrameTab-HighlightMid]])
		tab.middleHighlightTexture:SetHorizTile(true)
		tab.middleHighlightTexture:ClearAllPoints()
		tab.middleHighlightTexture:SetWidth(44)
		tab.middleHighlightTexture:SetHeight(32)
		tab.middleHighlightTexture:SetPoint("TOPLEFT", _G[name .. "TabMiddle"], 0, 0)
		tab.middleHighlightTexture:SetPoint("TOPRIGHT", _G[name .. "TabMiddle"], 0, 0)

		if self.hooks[tab.middleHighlightTexture] and self.hooks[tab.middleHighlightTexture].SetVertexColor then
			tab.middleHighlightTexture.SetVertexColor = self.hooks[tab.middleHighlightTexture].SetVertexColor
			self.hooks[tab.middleHighlightTexture].SetVertexColor = nil
		end
	end
end

function PhanxChat:SetHideTextures(v)
	if self.debug then print("PhanxChat: SetHideTextures", v) end
	if type(v) == "boolean" then
		self.db.HideTextures = v
	end

	for frame in pairs(self.frames) do
		self:HideTextures(frame)
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetHideTextures)
table.insert(PhanxChat.RunOnProcessFrame, PhanxChat.HideTextures)

------------------------------------------------------------------------