--[[
	Copyright (C) 2022 Eyeman
	Licensed under GNU General Public License v3.0
]]


-- Init some colors
local white = Color.new(255, 255, 255)
local yellow = Color.new(255, 255, 0)
local grey = Color.new(195, 195, 195, 150)
local green = Color.new(0, 128, 0)
local red = Color.new(255, 0, 0)

-- Check folder existance
function CheckFolder(directory)
	if System.doesDirExist(directory) then
		return true
	else
		System.setMessage("Not found folder rePatch in ux0:/rePatch", false, BUTTON_OK)
		while true do
			Graphics.initBlend()
			status = System.getMessageState()
			if status ~= RUNNING then
				break
			end
		Graphics.termBlend()
		Screen.flip()
		end
		System.exit()
		
	end
end

-- Print current game status
function Print_Status(folder_name)
	-- Drawing selected folder status
	if string.find(folder_name, "DIS") then -- Disable status
		Graphics.debugPrint(364, 510, "STATUS:", white)
		Graphics.debugPrint(470, 510, "DISABLE", red)
	else -- Enable status
		Graphics.debugPrint(364, 510, "STATUS:", white)
		Graphics.debugPrint(470, 510, "ACTIVE", green)
	end
end

-- Print current game title
function Print_Game_Title(folder_name, game_name)
	Graphics.debugPrint(310, 30, "Game Title:", white)
	local found = false
	local specific_folder = string.gsub(folder_name, "DIS", "")
	local game_title = "Not found. Maybe can contact the author to adding on list." -- default message if not found
	local gidx = 1

	while found == false do
		if gidx == (#game_name + 1) then -- failed to find game title
			Graphics.debugPrint(310, 60, game_title, white)
			found = true

		elseif string.find(specific_folder, game_name[gidx].id) then
			game_title = game_name[gidx].name -- Change default message into game title
			Graphics.debugPrint(310, 60, game_title, white)
			found = true
		end
		gidx = gidx + 1
	end
end

-- Print message either enable or disable
function Print_Message(status)

	local message
	if status == true then
		message = "Sucessfully enable rePatch game"
	else
		message = "Sucessfully disable rePatch game"
	end
	System.setMessage(message, false, BUTTON_OK)
	while true do
		Graphics.initBlend()
		status = System.getMessageState()
		if status ~= RUNNING then
			break
		end
		Graphics.termBlend()
		Screen.flip()
		
	end
end

function Load_Game_List(game_list)
	local f
	if System.doesFileExist("app0:/gamelist.txt") then
        f = io.open("app0:/gamelist.txt")
	else
		System.setMessage("gamelist.txt not exist in app0:/", false, BUTTON_OK)
		while true do
			Graphics.initBlend()
			status = System.getMessageState()
			if status ~= RUNNING then
				break
			end
		Graphics.termBlend()
		Screen.flip()
		end
		System.exit()
		
	end
	lines = f:lines()
	local i = 1
	
	for line in lines do
	    local id
 		local name
	    local c = 1
 		for word in string.gmatch(line, '([^,]+)') do
  	    	-- print(word)
   	    	if c%2 ~= 0 then -- odd number for id, even number for name 
   	    	id = word
   	    	else
    			name = word
    		end

      		c = c+1
 		end

  	  -- Add into dictionary
		game_list[i] = {["id"] = id, ["name"] = name}
		i = i+1
	end

	io.close(f)
	return game_list
end

-- Init pad
local oldpad = SCE_CTRL_CROSS

-- Variable for rePatch directory
local dir = "ux0:/rePatch"
local current_name_folder
local rename_current_folder

-- Init a index
local idx = 1

-- Loading Background
local bg = Graphics.loadImage("app0:/image/bg.png")
local cross = Graphics.loadImage("app0:/image/cross.png")
local triangle = Graphics.loadImage("app0:/image/triangle.png")
local circle = Graphics.loadImage("app0:/image/circle.png")

-- Game Title and Id
local game_list = {}
game_list = Load_Game_List(game_list)

-- Check folder
local folder_status
folder_status = CheckFolder(dir)

-- Main loop
while folder_status == true do

	-- rePatch directory table
	local folder = System.listDirectory(dir .. "/")

	-- Start drawing on screen
	Graphics.initBlend()
	Screen.clear()
	Graphics.drawImage(0, 0, bg)
	Graphics.fillRect(20, 250, 20, 540, grey) -- For game ID
	Graphics.fillRect(355, 570, 500, 540, grey) -- For status
	Graphics.fillRect(300, 920, 20, 100, grey) -- For game title

	-- Start drawing icon
	Graphics.drawScaleImage(810, 380, triangle, 0.1, 0.1)
	Graphics.drawScaleImage(810, 435, circle, 0.1, 0.1)
	Graphics.drawScaleImage(810, 490, cross, 0.1, 0.1)

	Graphics.debugPrint(875, 395, "Back", grey)
	Graphics.debugPrint(875, 450, "Enable", grey)
	Graphics.debugPrint(875, 505, "Disable", grey)

	-- Drawing folder selector
	Graphics.debugPrint(25, 20, "Game ID:", white)
	local y = 50 -- Init position y-axis
	for i, list in pairs(folder) do
		local color
		local x = 25
		if i >= idx and y < 544 then
			if i == idx then
				color = yellow
				x = 30
			else
				color = white
			end
			Graphics.debugPrint(x, y, string.gsub(list.name, "DIS", ""), color)
			y = y + 25
		end
	end

	-- Drawing selected folder status
	Print_Status(folder[idx].name)

	-- Drawing game title
	Print_Game_Title(folder[idx].name, game_list)

	--Graphics.termBlend() -- End drawing
	--Screen.flip()

	-- Check for input
	local pad = Controls.read()
	if Controls.check(pad, SCE_CTRL_CROSS) and not Controls.check(oldpad, SCE_CTRL_CROSS) then -- Disable file
		if string.find(folder[idx].name, "DIS") then -- Avoid redundant rename folder
			print("NULL")
		else
			current_name_folder = dir .. "/" .. folder[idx].name
			System.rename(current_name_folder, current_name_folder .. "DIS") -- rename from GameID to GameIDDIS
			Print_Message(false) -- Popup message disable
		end
	elseif Controls.check(pad, SCE_CTRL_CIRCLE) and not Controls.check(oldpad, SCE_CTRL_CIRCLE) then -- Enable file
		if string.find(folder[idx].name, "DIS") then -- Avoid redundant rename folder
			current_name_folder = dir .. "/" .. folder[idx].name
			rename_current_folder = string.gsub(current_name_folder, "DIS", "") -- remove "DIS"
			System.rename(current_name_folder, rename_current_folder) -- rename from GameIDDIS to GameID
			Print_Message(true) -- Popup message enable
		end

	elseif Controls.check(pad, SCE_CTRL_TRIANGLE) and not Controls.check(oldpad, SCE_CTRL_TRIANGLE) then -- Return to main menu
		break
		
	elseif Controls.check(pad, SCE_CTRL_UP) and not Controls.check(oldpad, SCE_CTRL_UP) then
		idx = idx - 1
		if idx == 0 then
			idx = #folder
		end

	elseif Controls.check(pad, SCE_CTRL_DOWN) and not Controls.check(oldpad, SCE_CTRL_DOWN) then
		idx = idx + 1
		if idx > #folder then
			idx = 1
		end
	end

	-- Update pad status
	oldpad = pad
	
	Graphics.termBlend() -- End drawing
	Screen.flip()
end

--dofile("app0:/error.lua") --if repatch directory not found
