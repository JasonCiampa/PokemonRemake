-- SCENE SETUP --

local titleScreen = scene.create("assets/images/title_screen/background.jpg", 0, 0, "assets/audio/music/Overture - Super Mario Galaxy.mp3")  -- Creates a titleScreen Scene

titleScreen.pokemonSpaceText = love.graphics.newImage("assets/images/title_screen/pokemon_space.png")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CAMERA SETUP --

local mainCamera

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BUTTON SETUP --

local playButton

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function titleScreen.load()
    titleScreen.backgroundMusic:setVolume(0.15)                                           -- Sets the Scene's background music volume to 15%
    love.audio.play(titleScreen.backgroundMusic)
    
    mainCamera = titleScreen.loadCamera(camera.create(0, 0))   -- Adds a Camera labeled "main" to the titleScreen Cameras table)
    titleScreen.activeCamera = mainCamera
        
    playButton = titleScreen.loadButton(button.create(WIDTH / 2, 100, (titleScreen.width / 2) - WIDTH / 4, (titleScreen.height / 2) + 50, {1, 0, 1}, {1, 1, 1}, "Play"))     -- Adds a play Button to the titleScreen Button list

    -- Sets playButton's action to be to change the Scene to clearMeadowTown
    function playButton.performAction(button, mouseX, mouseY) 
        if (playerHouseInterior == nil) then
            playerHouseInterior = require("scripts/scenes/playerHouseInterior")
        end

        previousScene = titleScreen
        nextScene = playerHouseInterior                                  -- Changes the Scene from titleScreen to playerHouseInterior
    end
end

function titleScreen.update(dt)
    titleScreen.updateButtons(dt)
end

function titleScreen.draw()
    titleScreen.activeCamera.draw()
    love.graphics.draw(titleScreen.background, titleScreen.x, titleScreen.y)
    love.graphics.draw(titleScreen.pokemonSpaceText)
    titleScreen.drawButtons()
end

return titleScreen