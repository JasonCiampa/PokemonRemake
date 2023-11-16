WIDTH, HEIGHT = 1920, 1080  -- Width and Height of the Window

local physics = require("physics")

local scene = require("scene")
local player = require("player")

local scenes = {}
scenes.titleScreen = scene.create("assets/images/title_screen/background.jpg", 0, 0)

local clearMeadowTown = require("clearMeadowTown")
-- scenes.clearMeadowTown = scene.create("assets/images/clear_meadow_town/clear_meadow_background.png", 0, 0)

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- Returns the current color
function getCurrentColor()
    return {love.graphics.getColor()}
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- Detects whether an object was clicked on (true) or not (false)
function mouseInObject(object, mouseX, mouseY)
    return ((mouseX >= object.x) and (mouseX <= object.x + object.width)) and ((mouseY >= object.y) and (mouseY <= object.y + object.height))
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- Determines whether the mouse is hovering over an object (true) or not (false)
function isMouseHovering(object)
    local mouseX, mouseY = love.mouse.getPosition()
    if (mouseInObject(object, mouseX, mouseY)) then
        return true
    else
        return false
    end
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- File-Wide Functions

-- Everytime the mouse is left-clicked, this function will call the active scene's mousepressed() function.
function love.mousepressed(mouseX, mouseY, mouseButton)
    if (mouseButton == 1) then                                                          -- If the mouseButton was left-click...

        -- Checks which scene in the scenes list is the active one
        for sceneKey, scene in pairs(scenes) do                                             -- For every Scene in the scenes list...
            if (scene.active) then                                                              -- If the Scene is active...
                scene.mousepressed(mouseX,mouseY)                                                   -- Call the Scene to process the click
                return
            end
        end    

    end
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

function love.load()
    love.window.setMode(WIDTH, HEIGHT)                              -- Sets the window size

    player.x = (WIDTH / 2) - (player.width / 2)                     -- Sets the Player to be centered on the x-axis
    player.y = (HEIGHT / 2) - (player.height / 2)                   -- Sets the Player to be centered on the y-axis

    for sceneKey, scene in pairs(scenes) do                         -- For every Scene in the scenes list...
        scene.active = false                                            -- Set every Scene to be not active when the game loads
    end    

    -- TITLE SCREEN SETUP --
    scenes.titleScreen.active = true       -- Sets titleScreen to be active when the game loads.

    scenes.titleScreen.buttons.play = scenes.titleScreen.createButton(WIDTH / 2, 100, (scenes.titleScreen.width / 2) - WIDTH / 4, (scenes.titleScreen.height / 2) - 50, {0, 0, 1}, {1, 1, 1}, "Play")     -- Adds a play Button to the titleScreen Button list

    -- Creates the code to execute whenever the playButton is clicked on.
    function scenes.titleScreen.buttons.play.performAction(button, mouseX, mouseY) 
        scene.change(scenes.titleScreen, scenes.clearMeadowTown)                        -- Changes the Scene from titleScreen to clearMeadowTown
    end


    -- CLEAR MEADOW TOWN SETUP --

    -- 40 tiles wide, 10 tiles tall
    -- 96 x 216 per tile
    scenes.clearMeadowTown.tilemap = {
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    }

    player_house = scenes.clearMeadowTown.createObject("player_house", nil, width, height, x, y, physicsType, density, restitution)

end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

function love.update(dt)
    WORLD:update(dt)

    -- Closes Love2D when "ESC" is clicked
    if (love.keyboard.isDown("escape")) then
        love.event.quit()
    end

    -- TITLE SCREEN --
    if (scenes.titleScreen.active) then
        for buttonKey, button in pairs(scenes.titleScreen.buttons) do       -- For every Button in the Scene...
            button:mouseHovering()                                              -- Adjust a Button's color if the mouse is hovering over it
        end

    -- CLEAR MEADOW TOWN --
    elseif (scenes.clearMeadowTown.active) then
        scenes.clearMeadowTown.cameras.main.follow(player)             -- Update the Camera's position
        player.move(dt)                                         -- Update the Player's movements
        player.update(dt)
    end
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

function love.draw()

    -- TITLE SCREEN --
    if (scenes.titleScreen.active) then
        scenes.titleScreen.draw()                      -- Draws the Title Screen Scene and all of its Buttons
        
    -- CLEAR MEADOW TOWN --
    elseif (scenes.clearMeadowTown.active) then
        scenes.clearMeadowTown.activeCamera.draw()     -- Updates the Camera
        scenes.clearMeadowTown.draw()                  -- Draws the Clear Meadow Town Scene and all of its Buttons
        player.draw()                                  -- Draws the Player
    end
    
end