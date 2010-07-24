------------------------------------------------------------------------
--	PhanxChat                                                         --
--	Removes chat frame clutter and adds some functionality.           --
--	by Phanx < addons@phanx.net >                                     --
--	Copyright © 2006–2010 Phanx. See README for license terms.        --
--	http://www.wowinterface.com/downloads/info6323-PhanxChat.html     --
--	http://wow.curse.com/downloads/wow-addons/details/phanxchat.aspx  --
------------------------------------------------------------------------

local _, PhanxChat = ...

------------------------------------------------------------------------

local function OnClick(self, button)
	PlaySound("igChatBottom")
	local frame = self:GetParent()
	if frame.ScrollToBottom then
		frame:ScrollToBottom()
	else
		frame:GetParent():ScrollToBottom()
	end
	_G[frame:GetName() .. "ButtonFrameBottomButton"]:Hide()
end

function PhanxChat:HideButtons(frame)
	local name = frame:GetName()
	local buttonFrame = _G[name .. "ButtonFrame"]
	local upButton = _G[name .. "ButtonFrameUpButton"]
	local downButton = _G[name .. "ButtonFrameDownButton"]
	local bottomButton = _G[name .. "ButtonFrameBottomButton"]

	if self.db.HideButtons then
		buttonFrame:SetScript("OnShow", buttonFrame.Hide)
		buttonFrame:Hide()

		upButton:SetScript("OnShow", upButton.Hide)
		upButton:Hide()

		downButton:SetScript("OnShow", downButton.Hide)
		downButton:Hide()

		bottomButton:ClearAllPoints()
		bottomButton:SetParent(frame)
		bottomButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, -4)
		bottomButton:SetAlpha(0.75)
		bottomButton:Hide()

		if not self.hooks[bottomButton] then
			self.hooks[bottomButton] = { }
		end
		if not self.hooks[bottomButton].OnClick then
			self.hooks[bottomButton].OnClick = bottomButton:GetScript("OnClick")
			bottomButton:SetScript("OnClick", OnClick)
		end
	else
		buttonFrame:SetScript("OnShow", nil)
		buttonFrame:Show()

		upButton:SetScript("OnShow", nil)
		upButton:Show()

		downButton:SetScript("OnShow", nil)
		downButton:Show()

		bottomButton:ClearAllPoints()
		bottomButton:SetParent(buttonFrame)
		bottomButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", 0, -4)
		bottomButton:SetAlpha(1)
		bottomButton:Show()

		if self.hooks[bottomButton] and self.hooks[bottomButton].OnClick then
			bottomButton:SetScript("OnClick", self.hooks[bottomButton].OnClick)
			self.hooks[bottomButton].OnClick = nil
		end

		FCF_UpdateButtonSide(frame)
	end
end

------------------------------------------------------------------------
--[[ -- for use with a posthook
function PhanxChat.BNToastFrame_UpdateAnchor(forceAnchor)
	if BNToastFrame.buttonSide == "left" then
		xoffset = 5
	else
		xoffset = -5
	end
	BNToastFrame:ClearAllPoints()
	if BNToastFrame.topSide then
		BNToastFrame:SetPoint("BOTTOM"..BNToastFrame.buttonSide, ChatFrame1, "TOP"..BNToastFrame.buttonSide, xoffset, BN_TOAST_TOP_OFFSET)
	else
		BNToastFrame:SetPoint("TOP"..BNToastFrame.buttonSide, ChatFrame1, "BOTTOM"..BNToastFrame.buttonSide, xoffset, BN_TOAST_BOTTOM_OFFSET)
	end
end
]]

function PhanxChat:SetHideButtons(v)
	if self.debug then print("PhanxChat: SetHideButtons", v) end
	if type(v) == "boolean" then
		self.db.HideButtons = v
	end

	for frame in pairs(self.frames) do
		self:HideButtons(frame)
	end

	if self.db.HideButtons then
		ChatFrameMenuButton:SetScript("OnShow", ChatFrameMenuButton.Hide)
		ChatFrameMenuButton:Hide()

		FriendsMicroButton:SetScript("OnShow", FriendsMicroButton.Hide)
		FriendsMicroButton:Hide()

		GeneralDockManagerOverflowButton:SetScript("OnShow", GeneralDockManagerOverflowButton.Hide)
		GeneralDockManagerOverflowButton:Hide()

		if not self.hooks.BN_TOAST_LEFT_OFFSET then
			self.hooks.BN_TOAST_LEFT_OFFSET = BN_TOAST_LEFT_OFFSET
			BN_TOAST_LEFT_OFFSET = BN_TOAST_LEFT_OFFSET + ChatFrame1ButtonFrame:GetWidth() + 5
		end
	elseif not self.isLoading then
		ChatFrameMenuButton:SetScript("OnShow", nil)
		ChatFrameMenuButton:Show()

		FriendsMicroButton:SetScript("OnShow", nil)
		FriendsMicroButton:Show()

		GeneralDockManagerOverflowButton:SetScript("OnShow", nil)
		GeneralDockManagerOverflowButton:Show()

		if self.hooks.BN_TOAST_LEFT_OFFSET then
			BN_TOAST_LEFT_OFFSET = self.hooks.BN_TOAST_LEFT_OFFSET
			self.hooks.BN_TOAST_LEFT_OFFSET = nil
		end
	end
end

------------------------------------------------------------------------

table.insert(PhanxChat.RunOnLoad, PhanxChat.SetHideButtons)
table.insert(PhanxChat.RunOnProcessFrame, PhanxChat.HideButtons)

------------------------------------------------------------------------