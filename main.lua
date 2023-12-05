--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- GLOBAL VARIABLES --

WIDTH, HEIGHT = 1920, 1080  -- Width and Height of the Window

-- Global imports for different game components, each with helpful functions
animator = require("scripts/animator")  
button = require("scripts/button")     
camera = require("scripts/camera")  
objectHandler = require("scripts/object")    
scene = require("scripts/scene")        

-- Global import for the Player
player = require("scripts/objects/player")     
         

activeScene = {}    -- Variable to hold a reference to the currently active Scene
nextScene = nil      -- Variable to hold a reference to the Scene that should become active next

printDebug = true
printDebugText = ""

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- GLOBAL FUNCTIONS --

-- Returns the current color
function getCurrentColor()
    return {love.graphics.getColor()}
end

-- Detects whether an object was clicked on (true) or not (false)
function mouseInObject(object, mouseX, mouseY)
    return ((mouseX >= object.x) and (mouseX <= object.x + object.width)) and ((mouseY >= object.y) and (mouseY <= object.y + object.height))
end

-- Determines whether the mouse is hovering over an object (true) or not (false)
function isMouseHovering(object)
    local mouseX, mouseY = love.mouse.getPosition()     -- Sets the mouse's coordinates
    if (mouseInObject(object, mouseX, mouseY)) then     -- If the mouse's position is inside of the object...
        return true                                         -- The mouse is hovering over the object
    else
        return false                                        -- The mouse is not hovering over the object
    end
end

-- Everytime the mouse is left-clicked, this function will call the active scene's mousepressed() function.
function love.mousepressed(mouseX, mouseY, mouseButton)
    if (mouseButton == 1) then                              -- If the mouseButton was left-click...
        activeScene.mousepressed(mouseX,mouseY)                 -- Have the currently active Scene process the click
    end
end

-- Quits the game if the user has pressed their escape key
function checkQuit()
    if (love.keyboard.isDown("escape")) then    -- If the user has pressed their "escape" key...
        love.event.quit()                           -- Close Love2D
    end
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- LOVE2D CALLBACK FUNCTIONS --

function love.load()
    love.window.setMode(WIDTH, HEIGHT)                              -- Sets the window size

    titleScreen = require("scripts/scenes/titleScreen")             -- Imports the titleScreen file
    activeScene = titleScreen                                       -- Sets the currently active Scene to be the titleScreen
    activeScene.load()                                              -- Loads the currently active scene

end


function love.update(dt)
    if (nextScene ~= nil) then
        scene.changeTo(nextScene)
    end

    checkQuit()                                                     -- Checks if the game needs to be quit
    world:update(dt)                                                -- Updates the physics world
    activeScene.update(dt)                                          -- Updates the currently active scene
end


function love.draw()
    activeScene.draw()                                              -- Draws the currently active scene

    -- DEBUGGING STATEMENTS --
    if (printDebug) then
        love.graphics.print(printDebugText, player.physics.x, player.physics.y - 50)
        love.graphics.print("Player X: " .. player.x, player.physics.x, player.physics.y + 100)
        love.graphics.print("Player Y: " .. player.y, player.physics.x, player.physics.y + 125)
    end

end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--