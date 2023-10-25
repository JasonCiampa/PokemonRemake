-- File-Wide Variables/Fields

local WIDTH, HEIGHT = 1920, 1080

local scenes = {}   -- Used to store all Scenes that are created.
local activeScene = 0   -- Used to store the index of the currently active Scene in the scenes table.

local sceneMaker = require("sceneMaker")    -- Gathers all of the necessary code for creating a scene from the sceneMaker.lua file and stores it in this file's sceneMaker table.

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- File-Wide Functions

-- Everytime the mouse is left-clicked, this function will call the active scene's mousepressed() function.
function love.mousepressed(mouseX, mouseY, mouseButton)
    if (mouseButton == 1) then
        scenes[activeScene].mousepressed(mouseX, mouseY)
    end
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

local titleScreen = sceneMaker.makeScene(scenes, "assets/images/background.jpg", 0, 0)

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

function love.load()
    love.window.setMode(WIDTH, HEIGHT)

    -- Initializes the titleScreen
    titleScreen.active = true       -- Sets titleScreen to be the active scene when the game loads.
    titleScreen.buttons.playButton = titleScreen:makeButton(WIDTH / 2, 100, (titleScreen.width / 2) - WIDTH / 4, (titleScreen.height / 2) - 50, {0, 0, 1}, {0, 0, 0.5}, {1, 1, 1}, {0.6, 0.6, 0.6}, "Play")     -- Adds a playButton to the scene

    -- Creates the code to execute whenever the playButton is clicked on.
    function titleScreen.buttons.playButton.performAction(button, mouseX, mouseY) 
        button.text = "Fart"
        -- local previousColor = getCurrentColor()
        -- love.graphics.setColor(button.backgroundColor)
    end
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

function love.update(dt)
    -- Closes Love2D when "ESC" is clicked
    if (love.keyboard.isDown("escape")) then
        love.event.quit()
    end

    -- Updates the activeScene variable.
    for i = 1, #scenes do 
        if (scenes[i].active) then
            activeScene = i
            break
        end
    end

    for buttonKey, button in pairs(scenes[activeScene].buttons) do
        button:mouseHovering()
    end
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

function love.draw()
    titleScreen:draw()
end