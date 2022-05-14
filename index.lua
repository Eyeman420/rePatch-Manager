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

-- Init pad
local oldpad = SCE_CTRL_CROSS

-- Variable for rePatch directory
local dir = "ux0:/rePatch/"
local current_name_folder
local rename_current_folder

-- Init a index
local idx = 1

-- Loading Background
local bg = Graphics.loadImage("app0:/image/bg.png")

-- Game Title and Id
local gameList = {
	{ ["id"] = "PCSG00483", ["name"] = "Aetornoblade (JP)" },
	{ ["id"] = "PCSG00461", ["name"] = "Airship Q (JP)" },
	{ ["id"] = "PCSE00428", ["name"] = "Akiba's Trip (US)" },
	{ ["id"] = "PCSB00906", ["name"] = "Atelier Escha & Logy Plus (EU)" },
	{ ["id"] = "PCSG01116", ["name"] = "Atelier Lydie & Suelle (JP)" },
	{ ["id"] = "PCSG01102", ["name"] = "Attack On Titan 2 (JP)" },
	{ ["id"] = "PCSE01034", ["name"] = "Berserk and the Band of the Hawk (US)" },
	{ ["id"] = "PCSE00507", ["name"] = "Binding of Isaac Rebirth (US)" },
	{ ["id"] = "PCSG00935", ["name"] = "Black Wolves Saga (JP)" },
	{ ["id"] = "PCSG00987", ["name"] = "Blue Reflection (JP)" },
	{ ["id"] = "PCSE00383", ["name"] = "Borderlands 2 (US)" },
	{ ["id"] = "PCSG01113", ["name"] = "Brothers Zanki Zero (JP)" },
	{ ["id"] = "PCSG00361", ["name"] = "Bullet Girls 1 (JP)" },
	{ ["id"] = "PCSG00568", ["name"] = "Bullet Girls 2 (JP)" },
	{ ["id"] = "PCSH10099", ["name"] = "Bullet Girls Phantasia (ASIA)" },
	{ ["id"] = "PCSH10053", ["name"] = "Buried Stars (ASIA)" },
	{ ["id"] = "PCSB00213", ["name"] = "Call of Duty Declassified (EU)" },
	{ ["id"] = "PCSG01179", ["name"] = "Catherine - Full Body (JP)" },
	{ ["id"] = "PCSG00457", ["name"] = "Chaos Rings Trilogy (JP)" },
	{ ["id"] = "PCSG00454", ["name"] = "Ciel Nosurge (JP)" },
	{ ["id"] = "PCSG01162", ["name"] = "Collar X Malice Unlimited (JP)" },
	{ ["id"] = "PCSE00376", ["name"] = "Conception 2 (US)" },
	{ ["id"] = "PCSG00681", ["name"] = "Criminal Girls 2 Party Favors (JP)" },
	{ ["id"] = "PCSE00516", ["name"] = "Criminal Girls Invite Only (US)" },
	{ ["id"] = "PCSG00241", ["name"] = "Criminal Girls Invite Only (JP)" },
	{ ["id"] = "PCSG00842", ["name"] = "Damascus Gear Saikyo Exodus (JP)" },
	{ ["id"] = "PCSE01100", ["name"] = "Danganronpa V3 (US)" },
	{ ["id"] = "PCSB00788", ["name"] = "Dangonronpa Another Episode Ultra Despair Girls (EU)" },
	{ ["id"] = "PCSE00919", ["name"] = "Darkest Dungeon (US)" },
	{ ["id"] = "PCSG00599", ["name"] = "Date-A-Live Twin Edition: Rio Reincarnation (JP)" },
	{ ["id"] = "PCSE00743", ["name"] = "Deception IV The Nightmare Princess (US)" },
	{ ["id"] = "PCSG00284", ["name"] = "Demon Gaze Global Edition (JP)" },
	{ ["id"] = "PCSG00758", ["name"] = "Dengeki Bunko Fighting Climax Ignition (JP)" },
	{ ["id"] = "PCSG00272", ["name"] = "Diabolik Lovers Limited V Edition (JP)" },
	{ ["id"] = "PCSE01171", ["name"] = "Digimon Story Cyber Sleuth (US)" },
	{ ["id"] = "PCSG01126", ["name"] = "Digimon Story Cyber Sleuth Hacker's Memory TV Anime Sound Edition (JP)" },
	{ ["id"] = "PCSH00261", ["name"] = "Digimon World Next Order (ASIA)" },
	{ ["id"] = "PCSH00250", ["name"] = "DOA X 3 Venus (ASIA)" },
	{ ["id"] = "PCSE00912", ["name"] = "Dragon Quest Builders (US)" },
	{ ["id"] = "PCSG00820", ["name"] = "Dragon Quest Heroes 2 (JP)" },
	{ ["id"] = "PCSG00187", ["name"] = "Dragon's Crown (JP)" },
	{ ["id"] = "PCSB01097", ["name"] = "Drive Girls (EU)" },
	{ ["id"] = "PCSE00693", ["name"] = "Dungeon Travelers 2 (US)" },
	{ ["id"] = "PCSE00710", ["name"] = "Earth Defense Force 2 (US)" },
	{ ["id"] = "PCSG00316", ["name"] = "Eiyuu Senki 18+" },
	{ ["id"] = "PCSC00001", ["name"] = "Everybody's Golf 6 (Hot Shots Golf) (JP)" },
	{ ["id"] = "PCSA00009", ["name"] = "Everybody's Golf 6 (Hot Shots Golf) (US)" },
	{ ["id"] = "PCSF00006", ["name"] = "Everybody's Golf 6 (Hot Shots Golf) (EU)" },
	{ ["id"] = "PCSD00008", ["name"] = "Everybody's Golf 6 (Hot Shots Golf) (ASIA)" },
	{ ["id"] = "PCSG00798", ["name"] = "Fairune (JP)" },
	{ ["id"] = "PCSG01091", ["name"] = "Fate/Extella LINK (JP)" },
	{ ["id"] = "PCSH10121", ["name"] = "Fate/Extella LINK (ASIA)" },
	{ ["id"] = "PCSB00051", ["name"] = "Fifa 2013 (Fifa Football) (EU)" },
	{ ["id"] = "PCSG00122", ["name"] = "Fate/Stay Night [Realta Nua] (JP)" },
	{ ["id"] = "PCSE00013", ["name"] = "Fifa 2013 (Fifa Football) (US)" },
	{ ["id"] = "PCSB00052", ["name"] = "Fifa 2013 (Fifa Football) (EU)" },
	{ ["id"] = "PCSE00265", ["name"] = "Fifa 2014 (EU)" },
	{ ["id"] = "PCSB01184", ["name"] = "Fifa 2015 (EU)" },
	{ ["id"] = "PCSE00889", ["name"] = "Fifa 2015 (EU)" },
	{ ["id"] = "PCSE00888", ["name"] = "Fifa 2015 (EU)" },
	{ ["id"] = "PCSB00618", ["name"] = "Fifa 2015 (EU)" },
	{ ["id"] = "PCSE00999", ["name"] = "Fifa 2015 (EU)" },
	{ ["id"] = "PCSE00483", ["name"] = "Fifa 2015 (EU)" },
	{ ["id"] = "PCSB00600", ["name"] = "Fifa 2015 (EU)" },
	{ ["id"] = "PCSE00293", ["name"] = "Final Fantasy X HD Remaster (US)" },
	{ ["id"] = "PCSE00394", ["name"] = "Final Fantasy X-2 HD Remaster (US)" },
	{ ["id"] = "PCSE00395", ["name"] = "Final Fantasy X/X2 HD Remaster (US)" },
	{ ["id"] = "PCSA00147", ["name"] = "Freedom Wars (US)" },
	{ ["id"] = "PCSC00054", ["name"] = "Freedom Wars (JP)" },
	{ ["id"] = "PCSG00985", ["name"] = "Fushigi no Gensokyo TOD Reloaded (JP)" },
	{ ["id"] = "PCSE00881", ["name"] = "Gal*Gun Double Peace (US)" },
	{ ["id"] = "PCSG01074", ["name"] = "Gintama Ranburu AV Ed (JP)" },
	{ ["id"] = "PCSG01073", ["name"] = "Gintma Ranburu (JP)" },
	{ ["id"] = "PCSE00789", ["name"] = "God Eater 2 Rage Burst (US)" },
	{ ["id"] = "PCSE00801", ["name"] = "God Eater Resurrection (US)" },
	{ ["id"] = "PCSB00874", ["name"] = "God Eater Resurrection (EU)" },
	{ ["id"] = "PCSA00126", ["name"] = "God Of War Collection (US)" },
	{ ["id"] = "PCSG00206", ["name"] = "Grisaia no Kaijitsu (JP)" },
	{ ["id"] = "PCSG00421", ["name"] = "Grisaia no Kaijitsu Spinout (JP)" },
	{ ["id"] = "PCSG00508", ["name"] = "Grisaia no Rauken (JP)" },
	{ ["id"] = "PCSE00137", ["name"] = "Guilty Gear ACXX+R (US)" },
	{ ["id"] = "PCSG01013", ["name"] = "Gun Gun Pixies (JP)" },
	{ ["id"] = "PCSE00326", ["name"] = "Hatsune Miku Project Diva F (US)" },
	{ ["id"] = "PCSE00588", ["name"] = "Hyperdimension Neptunia Action U (US)" },
	{ ["id"] = "PCSE00443", ["name"] = "Hyperdimension Neptunia ReBirth 1 (US)" },
	{ ["id"] = "PCSE00508", ["name"] = "Hyperdimension Neptunia ReBirth 2 (US)" },
	{ ["id"] = "PCSE00661", ["name"] = "Hyperdimension Neptunia ReBirth 3 (US)" },
	{ ["id"] = "PCSG00756", ["name"] = "I am Setsuna (JP)" },
	{ ["id"] = "PCSG00355", ["name"] = "IA VT Colorful (JP)" },
	{ ["id"] = "PCSG00357", ["name"] = "If My Heart Had Wings Konosora (JP)" },
	{ ["id"] = "PCSE00271", ["name"] = "Injustice Gods Among Us (US)" },
	{ ["id"] = "PCSH10065", ["name"] = "Itadaki Street Dragon Quest & Final Fantasy 30th Anniversary (ASIA)" },
	{ ["id"] = "PCSG01002", ["name"] = "Is It Wrong to Try to Pick Up Girls in a Dungeon? - Infinite Combate (JP)" },
	{ ["id"] = "PCSG00675", ["name"] = "Kamen Rider Battride War Sousei (JP)" },
	{ ["id"] = "PCSG00684", ["name"] = "Kantai Collection KanColle Kai (JP)" },
	{ ["id"] = "PCSG01093", ["name"] = "Konosuba Attack of the Destroyer! (JP)" },
	{ ["id"] = "PCSG00490", ["name"] = "Legend of Heroes Trails in the Sky 3rd (JP)" },
	{ ["id"] = "PCSG00488", ["name"] = "Legend of Heroes Trails in the Sky FC (JP)" },
	{ ["id"] = "PCSG00489", ["name"] = "Legend of Heroes Trails in the Sky SC (JP)" },
	{ ["id"] = "PCSE00786", ["name"] = "Legend of Heroes Trails of Cold Steel (US)" },
	{ ["id"] = "PCSE00896", ["name"] = "Legend of Heroes Trails of Cold Steel I & II (US)" },
	{ ["id"] = "PCSE00216", ["name"] = "Let's Fish! Hooked On (US)" },
	{ ["id"] = "PCSG01191", ["name"] = "Liar Princess and the Blind Prince (JP)" },
	{ ["id"] = "PCSE00673", ["name"] = "Lost Dimension (US)" },
	{ ["id"] = "PCSE00084", ["name"] = "Madden 2013 (US)" },
	{ ["id"] = "PCSG00456", ["name"] = "Mahouka Koukou no Retousei Out of Order (JP)" },
	{ ["id"] = "PCSG00972", ["name"] = "Metal Max Xeno (ASIA)" },
	{ ["id"] = "PCSH10100", ["name"] = "Metal Max Xeno (ASIA)" },
	{ ["id"] = "PCSE00491", ["name"] = "Minecraft (US)" },
	{ ["id"] = "PCSG00610", ["name"] = "Miracle Girls Festival (JP)" },
	{ ["id"] = "PCSH00148", ["name"] = "Moe Chronicle (ASIA)" },
	{ ["id"] = "PCSG00695", ["name"] = "Moero Crystal (JP)" },
	{ ["id"] = "PCSE00373", ["name"] = "Monster Monpiece (US)" },
	{ ["id"] = "PCSB00473", ["name"] = "Monster Monpiece (EU)" },
	{ ["id"] = "PCSG01018", ["name"] = "Musou Stars (JP)" },
	{ ["id"] = "PCSG01223", ["name"] = "Nelke and the Legendary Alchemist (JP)" },
	{ ["id"] = "PCSE00066", ["name"] = "New Little King's Story (US)" },
	{ ["id"] = "PCSG00557", ["name"] = "Nights of Azure (JP)" },
	{ ["id"] = "PCSG00986", ["name"] = "Nights of Azure 2 (JP)" },
	{ ["id"] = "PCSE00233", ["name"] = "Ninja Gaiden Sigma 2 Plus (US)" },
	{ ["id"] = "PCSE00021", ["name"] = "Ninja Gaiden Sigma Plus (US)" },
	{ ["id"] = "PCSG01107", ["name"] = "Nora to Oujo to Noraneko Heart (JP)" },
	{ ["id"] = "PCSG00550", ["name"] = "Omega Labyrinth (JP)" },
	{ ["id"] = "PCSG00939", ["name"] = "Omega Labyrinth Z (JP)" },
	{ ["id"] = "PCSE00579", ["name"] = "Operation Abyss New Tokyo Legacy (US)" },
	{ ["id"] = "PCSE00120", ["name"] = "Persona 4 Golden (US)" },
	{ ["id"] = "PCSB00245", ["name"] = "Persona 4 Golden (US)" },
	{ ["id"] = "PCSE00764", ["name"] = "Persona 4 Dancing All Night (US)" },
	{ ["id"] = "PCSG00351", ["name"] = "Phantasy Star Nova (JP)" },
	{ ["id"] = "PCSG00141", ["name"] = "Phantasy Star Online 2 (JP)" },
	{ ["id"] = "PCSE00065", ["name"] = "Pinball Arcade Pro (US)" },
	{ ["id"] = "PCSG00981", ["name"] = "Plastic Memories (JP)" },
	{ ["id"] = "PCSG01163", ["name"] = "Princess Guide (JP)" },
	{ ["id"] = "PCSG00224", ["name"] = "Puyo Puyo Tetris (JP)" },
	{ ["id"] = "PCSE01111", ["name"] = "Rabi Ribi (US)" },
	{ ["id"] = "PCSE00300", ["name"] = "Ragnarok Odyssey ACE (US)" },
	{ ["id"] = "PCSE00001", ["name"] = "Ridge Racer (US)" },
	{ ["id"] = "PCSG00800", ["name"] = "Rodem the Wild (JP)" },
	{ ["id"] = "PCSE01023", ["name"] = "Salt and Sanctuary (US)" },
	{ ["id"] = "PCSG01121", ["name"] = "Secret of ManaPERS (JP)" },
	{ ["id"] = "PCSE00471", ["name"] = "Senran Kagura Bon Appetit (US)" },
	{ ["id"] = "PCSE00787", ["name"] = "Senran Kagura Estival Versus (US)" },
	{ ["id"] = "PCSE00398", ["name"] = "Senran Kagura Shinovi Versus (US)" },
	{ ["id"] = "PCSE00015", ["name"] = "Shinobido 2 Revenge of Zen (US)" },
	{ ["id"] = "PCSG00944", ["name"] = "Shiro to Kuro (JP)" },
	{ ["id"] = "PCSE01240", ["name"] = "Sir Eatsalot (US)" },
	{ ["id"] = "PCSA00097", ["name"] = "Sly Cooper collection (US)" },
	{ ["id"] = "PCSE00288", ["name"] = "Spelunky (US)" },
	{ ["id"] = "PCSG01166", ["name"] = "Steins; Gate Elite (JP)" },
	{ ["id"] = "PCSE01235", ["name"] = "Stardew Valley (US)" },
	{ ["id"] = "PCSG00146", ["name"] = "Steins; Gate My Darlings Embrace (JP)" },
	{ ["id"] = "PCSG00250", ["name"] = "Steins; Gate Linear Bounded Phenogram (JP)" },
	{ ["id"] = "PCSE00951", ["name"] = "Summon Night 6 Lost Borders (US)" },
	{ ["id"] = "PCSG00228", ["name"] = "Super Heroine Chronicle (JP)" },
	{ ["id"] = "PCSE00769", ["name"] = "Super Meat Boy (US)" },
	{ ["id"] = "PCSB00881", ["name"] = "Super Meat Boy (EU)" },
	{ ["id"] = "PCSH10001", ["name"] = "Super Robot Wars V (ASIA)" },
	{ ["id"] = "PCSH10088", ["name"] = "Super Robot Wars X (ASIA)" },
	{ ["id"] = "PCSE00717", ["name"] = "Superbeat XONiC (US)" },
	{ ["id"] = "PCSE00903", ["name"] = "Sword Art Online Hollow Realization (US)" },
	{ ["id"] = "PCSG00551", ["name"] = "Taiko V Version (JP)" },
	{ ["id"] = "PCSE01305", ["name"] = "The House In Fata Morgana (US)" },
	{ ["id"] = "PCSG00652", ["name"] = "The Legend of the Dark Witch (JP)" },
	{ ["id"] = "PCSG00062", ["name"] = "Time Travelers (JP)" },
	{ ["id"] = "PCSG00330", ["name"] = "To Love Ru Battle Ecstasy (JP)" },
	{ ["id"] = "PCSE00940", ["name"] = "Toukiden 2 (US)" },
	{ ["id"] = "PCSG00830", ["name"] = "Toukiden 2 (JP)" },
	{ ["id"] = "PCSE01116", ["name"] = "Undertale (US)" },
	{ ["id"] = "PCSG00633", ["name"] = "UPPERS (JP)" },
	{ ["id"] = "PCSE01409", ["name"] = "Utawarerumono (US)" },
	{ ["id"] = "PCSE00244", ["name"] = "Valhalla Knights 3 (US)" },
	{ ["id"] = "PCSE00948", ["name"] = "Valkyrie Drive Bhikkuni (US)" },
	{ ["id"] = "PCSB01011", ["name"] = "Valkyrie Drive Bhikkuni (EU)" },
	{ ["id"] = "PCSG01084", ["name"] = "Wagamama Hi-Spec (JP)" },
	{ ["id"] = "PCSE00245", ["name"] = "Ys Memories of Celceta (US)" },
	{ ["id"] = "PCSE01033", ["name"] = "Ys Origin (US)" },
	{ ["id"] = "PCSG00881", ["name"] = "Ys VIII (JP)" },
	{ ["id"] = "PCSG00996", ["name"] = "Yu-No PC98 (JP)" },
	{ ["id"] = "PCSG01113", ["name"] = "Zanki Zero (JP)" },
	{ ["id"] = "PCSE00089", ["name"] = "Need For Speed Most Wanted (US)" },
	{ ["id"] = "PCSG00042", ["name"] = "Zero No Kiseki Evolution (JP)" }
}

-- Main loop
while true do
	-- rePatch directory table
	local folder = System.listDirectory("ux0:/rePatch/")

	-- Start drawing on screen
	Graphics.initBlend()
	Screen.clear()
	Graphics.drawImage(0, 0, bg)
	Graphics.fillRect(20, 250, 20, 540, grey) -- For game ID
	Graphics.fillRect(355, 570, 500, 540, grey) -- For status
	Graphics.fillRect(300, 920, 20, 100, grey) -- For game title

	-- Drawing folder selector
	Graphics.debugPrint(25, 20, "Game ID:", white)
	local y = 50 -- Init position y-axis
	for i, list in pairs(folder) do
		x = 25
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
	if string.find(folder[idx].name, "DIS") then -- Disable stat
		Graphics.debugPrint(364, 510, "STATUS:", white)
		Graphics.debugPrint(470, 510, "DISABLE", red)
	else -- Enable stat
		Graphics.debugPrint(364, 510, "STATUS:", white)
		Graphics.debugPrint(470, 510, "ACTIVE", green)
	end

	-- Drawing game title
	Graphics.debugPrint(310, 30, "Game Title:", white)
	local found = false
	local specific_folder = string.gsub(folder[idx].name, "DIS", "")
	local gameTitle = "Not found. Maybe can contact the author to adding on list." -- default message if not found
	local gidx = 1

	while found == false do
		if gidx == (#gameList + 1) then -- failed to find game name
			Graphics.debugPrint(310, 60, gameTitle, white)
			found = true

		elseif string.find(specific_folder, gameList[gidx].id) then
			gameTitle = gameList[gidx].name -- Change default message into game title
			Graphics.debugPrint(310, 60, gameTitle, white)
			found = true
		end
		gidx = gidx + 1
	end

	Graphics.termBlend() -- End drawing

	-- Check for input
	local pad = Controls.read()
	if Controls.check(pad, SCE_CTRL_CROSS) and not Controls.check(oldpad, SCE_CTRL_CROSS) then -- Disable file
		if string.find(folder[idx].name, "DIS") then -- Avoid redundant rename folder
			print("NULL")
		else
			current_name_folder = dir .. folder[idx].name
			System.rename(current_name_folder, current_name_folder .. "DIS") -- rename from GameID to GameIDDIS
			dofile("app0:/disable.lua")
		end
	elseif Controls.check(pad, SCE_CTRL_CIRCLE) and not Controls.check(oldpad, SCE_CTRL_CIRCLE) then -- Enable file
		if string.find(folder[idx].name, "DIS") then -- Avoid redundant rename folder
			current_name_folder = dir .. folder[idx].name
			rename_current_folder = string.gsub(current_name_folder, "DIS", "") -- remove "DIS"
			System.rename(current_name_folder, rename_current_folder) -- rename from GameIDDIS to GameID
			dofile("app0:/enable.lua")
		end

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
	Screen.flip()
end
