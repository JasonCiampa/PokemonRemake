-- File-Wide Variables/Fields

local WIDTH, HEIGHT = 1920, 1080

local sceneMaker = require("sceneMaker")    -- Gathers all of the necessary code for creating a scene from the sceneMaker.lua file and stores it in this file's sceneMaker table.

local scenes = {}
scenes.titleScreen = sceneMaker.makeScene("assets/images/background.jpg", 0, 0)
scenes.level1 = sceneMaker.makeScene("assets/images/grass/grass.png", 0, 0)

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
        button.text = "Fart"
        scenes.titleScreen.active = false
        scenes.level1.active = true
    end

   --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

    -- level1 Set-Up --

    -- Initializes the level1 scene
    scenes.level1.active = false       -- Sets the level1 scene to be active when the game loads.
    scenes.level1.buttons.playButton = scenes.level1:makeButton(WIDTH / 2, 100, (scenes.level1.width / 2) - WIDTH / 4, ((scenes.level1.height / 2) - 50) - 100, {0, 0, 1}, {0, 0, 0.5}, {1, 1, 1}, {0.6, 0.6, 0.6}, "TEST")     -- Adds a playButton to the scene

    -- Creates the code to execute whenever the playButton is clicked on.
    function scenes.level1.buttons.playButton.performAction(button, mouseX, mouseY) 
        scenes.level1.active = false
        scenes.titleScreen.active = true
    end

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

    elseif (scenes.level1.active) then
        for buttonKey, button in pairs(scenes.level1.buttons) do
            button:mouseHovering()
        end
    end
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

function love.draw()
    if (scenes.titleScreen.active) then
        scenes.titleScreen:draw()
        
    elseif (scenes.level1.active) then
        local currentHeight = 0
        local halfHeight = 90
        love.graphics.draw(scenes.level1.background, scenes.level1.x, scenes.level1.y)    
        love.graphics.draw(scenes.level1.background, scenes.level1.x + 100, scenes.level1.y)    


        for i = 1, 20 do
            currentHeight = currentHeight + halfHeight
            love.graphics.draw(scenes.level1.background, scenes.level1.x, currentHeight)
            love.graphics.draw(scenes.level1.background, scenes.level1.x + 100, currentHeight)
            love.graphics.draw(scenes.level1.background, scenes.level1.x + 200, currentHeight)
            love.graphics.draw(scenes.level1.background, scenes.level1.x + 300, currentHeight)

        end


    end
end