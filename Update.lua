--[[
	Copyright (C) 2022 Eyeman
	Licensed under GNU General Public License v3.0
]]

-- THIS CODES IS USE FOR UPDATE THE GAMELIST.TXT

local f
local update_stat
local result
local cur_ver
local internet = false

-- Read gamelist
function Load_Game_List(cur_ver)
	if System.doesFileExist("ux0:/data/rePatch-Manager/gamelist.txt") then
		f = io.open("ux0:/data/rePatch-Manager/gamelist.txt")
		-- Split lines
		lines = f:lines()

		-- Read version based on gamelist.txt
		local line1 = lines()
		for ver in string.gmatch(line1, '([^,]+)') do
			cur_ver = ver
			break
		end

		cur_ver = tonumber(cur_ver)
		local text = "Current PS Vita gamelist.txt version is " .. cur_ver .. "\nLatest Github gamelist.txt version is " .. result
		System.setMessage(text, false, BUTTON_OK)
		while true do
			Graphics.initBlend()
			status = System.getMessageState()
			if status ~= RUNNING then
				break
			end
			Graphics.termBlend()
			Screen.flip()
		end
		Comparing_Version(cur_ver, result)
		io.close(f)

	else
	end
end

-- Comparing between local and internet gamelist.txt version
function Comparing_Version(cur_ver, result)

	-- Update gamelist
	if result > cur_ver then
		os.remove("ux0:/data/rePatch-Manager/gamelist.txt")
		Network.downloadFile("https://raw.githubusercontent.com/Eyeman420/rePatch-Manager/main/gamelist.txt",
			"ux0:/data/rePatch-Manager/gamelist.txt")
		update_stat = true
	else -- No need to update
		update_stat = false
	end

end

-- Initializing Network
Network.init()

-- Checking if connection is available
if Network.isWifiEnabled() then

	internet = true

	-- Get current version
	result = Network.requestString("https://raw.githubusercontent.com/Eyeman420/rePatch-Manager/main/version.txt")
	result = tonumber(result)
	Load_Game_List(cur_ver)

end

-- Terminating network
Network.term()

-- Main loop
while true do

	local message = ""
	if internet == true then -- If connect to internet
		if update_stat == true then -- Update gamelist
			message = "Successfully update the gamelist to version " .. result
		else -- Already latest version
			message = "Gamelist is already latest version " .. result
		end

		-- Popup message
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

	else -- No internet connection
		System.setMessage("Please enable WIFI", false, BUTTON_OK)
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
	
	break
end
