-- File-Wide Variables/Fields

local WIDTH, HEIGHT = 1920, 1080

local sceneMaker = require("sceneMaker")    -- Gathers all of the necessary code for creating a scene from the sceneMaker.lua file and stores it in this file's sceneMaker table.

local scenes = {}
scenes.titleScreen = sceneMaker.makeScene("assets/images/background.jpg", 0, 0)
scenes.clearMeadowTown = sceneMaker.makeScene("assets/images/background/clear_meadow_town/clearMeadow.png", 0, 0)

local pokemonMaker = require

local playersPokemon = {}

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- File-Wide Functions

-- Everytime the mouse is left-clicked, this function will call the active scene's mousepressed() function.
function love.mousepressed(mouseX, mouseY, mouseButton)
    if (mouseButton == 1) then

        -- Checks which scene in the scenes list is the active one
        for sceneKey, scene in pairs(scenes) do
            if (scene.active) then
                scene.mousepressed(mouseX,mouseY)
                return
            end
        end    

    end
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

local player = require("player")
local timer = 0

function love.load()
    love.window.setMode(WIDTH, HEIGHT)

    for sceneKey, scene in pairs(scenes) do
        scene.active = false
    end    

    --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
    -- titleScreen Set-Up --

    -- Initializes the titleScreen scene
    scenes.titleScreen.active = true       -- Sets the scene to be active when the game loads.
    scenes.titleScreen.buttons.playButton = scenes.titleScreen:makeButton(WIDTH / 2, 100, (scenes.titleScreen.width / 2) - WIDTH / 4, (scenes.titleScreen.height / 2) - 50, {0, 0, 1}, {0, 0, 0.5}, {1, 1, 1}, {0.6, 0.6, 0.6}, "Play")     -- Adds a playButton to the scene

    -- Creates the code to execute whenever the playButton is clicked on.
    function scenes.titleScreen.buttons.playButton.performAction(button, mouseX, mouseY) 
        scenes.titleScreen.active = false
        scenes.clearMeadowTown.active = true
    end

   --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

    -- level1 Set-Up --

    -- Initializes the level1 scene
    scenes.clearMeadowTown.active = false       -- Sets the level1 scene to be active when the game loads.

   --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

function love.update(dt)

    -- Closes Love2D when "ESC" is clicked
    if (love.keyboard.isDown("escape")) then
        love.event.quit()
    end

    -- Executes when titleScreen is the active scene.
    if (scenes.titleScreen.active) then
        for buttonKey, button in pairs(scenes.titleScreen.buttons) do
            button:mouseHovering()
        end

    elseif (scenes.clearMeadowTown.active) then
        if (timer > 0.5) then 
            timer = 0
        end

        timer = timer + dt

        player.move(timer, dt)
    end
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

function love.draw()
    if (scenes.titleScreen.active) then
        scenes.titleScreen:draw()
        
    elseif (scenes.clearMeadowTown.active) then
        scenes.clearMeadowTown:draw()
        player:draw()
    end
end