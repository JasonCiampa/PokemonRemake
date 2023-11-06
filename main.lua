-- File-Wide Variables/Fields

local WIDTH, HEIGHT = 1920, 1080

local sceneMaker = require("sceneMaker")    -- Gathers all of the necessary code for creating a scene from the sceneMaker.lua file and stores it in this file's sceneMaker table.

local scenes = {}
scenes.titleScreen = sceneMaker.makeScene("assets/images/background.jpg", 0, 0)
scenes.clearMeadowTown = sceneMaker.makeScene("assets/images/clear_meadow_town/clear_meadow_background.png", 0, 0)

local player = require("player")

local pokemonMaker = require

local playersPokemon = {}

local camera = {}
camera.x = 0
camera.y = 0

function camera.adjustScreenPosition(camera, player)
    -- When the player crosses over the right boundary of the screen
    -- Get how far he crossed over to the right
    -- Set the camera further right by the distance the character traveled to the right
    if (player.x > camera.x + (WIDTH * 0.55)) then
        local diff = player.x - (camera.x + (WIDTH * 0.55))
        camera.x = camera.x + diff

        if (camera.x > 1920) then
            camera.x = 1920
        end
    
    -- When the player crosses over the left boundary of the screen
    elseif (player.x < camera.x + (WIDTH * 0.45) - (player.width / 2)) then
        local diff = (camera.x + (WIDTH * 0.45) - (player.width / 2)) - player.x
        camera.x = camera.x - diff

        if (camera.x < 0) then
            camera.x = 0
        end

    end

    -- When the player crosses over the bottom boundary of the screen
    if (player.y > camera.y + (HEIGHT * 0.55)) then
        local diff = player.y - (camera.y + (HEIGHT * 0.55))
        camera.y = camera.y + diff

        if (camera.y > 1080) then
            camera.y = 1080
        end

    -- When the player crosses over the top boundary of the screen
    elseif (player.y < camera.y + (HEIGHT * 0.45)) then
        local diff = (camera.y + (HEIGHT * 0.45)) - player.y
        camera.y = camera.y - diff

        if (camera.y < 0) then
            camera.y = 0
        end

    end
end

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
local timer = 0

function love.load()
    love.window.setMode(WIDTH, HEIGHT)

    player.x = (WIDTH / 2) - (player.width / 2)
    player.y = (HEIGHT / 2) - (player.height / 2)


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

        camera:adjustScreenPosition(player)

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
        love.graphics.translate(-camera.x, -camera.y)

        scenes.clearMeadowTown:draw()
        player:draw()

        -- love.graphics.print("Player X: " .. player.x, player.x, player.y)
        -- love.graphics.print("Player Y: " .. player.x, player.x, player.y + 100)

        -- love.graphics.print("Camera X: " .. camera.x, camera.x, camera.y + 100)
        -- love.graphics.print("Camera Y: " .. camera.y, camera.x, camera.y + 200)
        
    end
end