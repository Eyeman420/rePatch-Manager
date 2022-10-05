--[[
	Copyright (C) 2022 Eyeman
	Licensed under GNU General Public License v3.0
]]
-- THIS CODES IS USE FOR USER MENU

-- Init some colors
local white = Color.new(255, 255, 255)
local yellow = Color.new(255, 255, 0)
local grey = Color.new(195, 195, 195, 150)
local green = Color.new(0, 128, 0)
local Orange = Color.new(255, 128, 0)

-- Init pad
local oldpad = SCE_CTRL_CROSS

-- Init a index
local idx = 1

local main_menu = {
	{["name"] = "Game", ["desc"] = "Enable or disable rePatch game folder"},
	{["name"] = "DLC", ["desc"] = "Enable or disable reAddcont game folder"},
}

-- Loading Background
local bg = Graphics.loadImage("app0:/image/bg.png")
local cross = Graphics.loadImage("app0:/image/cross.png")
local triangle = Graphics.loadImage("app0:/image/triangle.png")
local circle = Graphics.loadImage("app0:/image/circle.png")
local start = Graphics.loadImage("app0:/image/start.png")
local select = Graphics.loadImage("app0:/image/select.png")

-- if data folder exist
if System.doesFileExist("ux0:/data/rePatch-Manager/gamelist.txt") then
	print()
else
	System.createDirectory("ux0:/data/rePatch-Manager")
	System.copyFile("app0:/gamelist.txt", "ux0:/data/rePatch-Manager/gamelist.txt")
end

-- Main loop
while true do

	-- Start drawing on screen
	Graphics.initBlend()
	Screen.clear()

	-- Drawing background
	Graphics.drawImage(0,0, bg)
	Graphics.fillRect(20, 250, 20, 540, grey)
	Graphics.fillRect(300, 920, 20, 100, grey)

	-- Start drawing icon
	Graphics.drawScaleImage(810, 380, start, 0.09, 0.09)
	Graphics.drawScaleImage(810, 435, select, 0.09, 0.09)
	Graphics.drawScaleImage(810, 490, cross, 0.1, 0.1)

	-- Graphics.debugPrint(875, 395, "Back", grey)
	Graphics.debugPrint(20, 0, "Main Menu", Orange)
	Graphics.debugPrint(875, 395, "Exit", grey)
	Graphics.debugPrint(875, 450, "Update", grey)
	Graphics.debugPrint(875, 505, "Select", grey)
	
	-- Drawing samples selector
	local y = 10
	for i,lists in pairs(main_menu) do
		local x = 25
		local color = white
		if i == idx then
			color = yellow
			x = 30
		end
		Graphics.debugPrint(x, y + 40*i, lists.name, color)
	end
		
	-- Drawing selected sample description
	Graphics.debugPrint(310, 30, "Description:", white)
	Graphics.debugPrint(310, 60, main_menu[idx].desc, white)

	-- Check for input
	local pad = Controls.read()
	if Controls.check(pad, SCE_CTRL_CROSS) and not Controls.check(oldpad, SCE_CTRL_CROSS) then -- Disable file
		dofile("app0:/" .. main_menu[idx].name .. ".lua")
		
	elseif Controls.check(pad, SCE_CTRL_START) and not Controls.check(oldpad, SCE_CTRL_START) then
		Graphics.freeImage(bg)
		System.exit()

	elseif Controls.check(pad, SCE_CTRL_SELECT) and not Controls.check(oldpad, SCE_CTRL_SELECT) then
		dofile("app0:/Update.lua")
	elseif Controls.check(pad, SCE_CTRL_UP) and not Controls.check(oldpad, SCE_CTRL_UP) then
		idx = idx - 1
		if idx == 0 then
			idx = #main_menu
		end

	elseif Controls.check(pad, SCE_CTRL_DOWN) and not Controls.check(oldpad, SCE_CTRL_DOWN) then
		idx = idx + 1
		if idx > #main_menu then
			idx = 1
		end
	end

	-- Update pad status
	oldpad = pad
	
	Graphics.termBlend() -- End drawing
	Screen.flip()
end

--dofile("app0:/error.lua") --if repatch directory not found
