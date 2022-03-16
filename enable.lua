-- Init some colors
local white = Color.new(255, 255, 255)
local grey = Color.new(195, 195, 195,150)

-- Loading Background
local bg = Graphics.loadImage("app0:/image/bgMessage.png")

-- Main loop
while true do
	-- Start drawing on screen
	Graphics.initBlend()
	Screen.clear()
    Graphics.drawImage(0,0, bg)
    Graphics.fillRect(240, 720, 204, 340, grey) -- For repatch message

    -- Drawing status
    Graphics.debugPrint(300, 257, "Successfully Enable rePatch game", white)

    Graphics.termBlend() -- End drawing
    Screen.flip()
    
    -- Check for input
	if Controls.check(Controls.read(), SCE_CTRL_CROSS) then -- To return index.lua
		break
    end
end