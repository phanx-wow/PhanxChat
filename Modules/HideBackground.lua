--[[--------------------------------------------------------------------
	PhanxChat
	Copyright (c) 2006-2016 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info6323-PhanxChat.html
	http://www.curse.com/addons/wow/phanxchat
	https://github.com/Phanx/PhanxChat
----------------------------------------------------------------------]]

local _, PhanxChat = ...
local oldTextures = {}

local function Hide(frames)
	oldTextures = {}
	for frame in pairs(frames) do
		oldTextures[frame] = {}
		for i = 1, #CHAT_FRAME_TEXTURES do 
			local name = frame:GetName()
			oldTextures[frame][i] = _G[name..CHAT_FRAME_TEXTURES[i]]:GetTexture()
			_G[name..CHAT_FRAME_TEXTURES[i]]:SetTexture(nil)
		end
	end
end

local function Show(frames)
	for frame in pairs(frames) do
		for i = 1, #CHAT_FRAME_TEXTURES do 
			local name = frame:GetName()
			_G[name..CHAT_FRAME_TEXTURES[i]]:SetTexture(oldTextures[frame][i])
		end
	end
end

function PhanxChat:LoadHideBackground()
	if self.db.HideBackground and type(self.db.HideBackground) == "boolean" then
		Hide(self.frames)
	end
end

function PhanxChat:SetHideBackground(v)
	if self.debug then print("PhanxChat: SetHideBackground", v) end

	if type(v) == "boolean" then
		self.db.HideBackground = v
	end

	if self.db.HideBackground then
		Hide(self.frames)
	else
		Show(self.frames)
	end
end

table.insert(PhanxChat.RunOnLoad, PhanxChat.LoadHideBackground)
