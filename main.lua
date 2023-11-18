--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

-- GLOBAL VARIABLES --

WIDTH, HEIGHT = 1920, 1080  -- Width and Height of the Window

-- Global imports for different game components, each with helpful functions
animator = require("animator")  
button = require("button")     
camera = require("camera")      
physics = require("physics")    
scene = require("scene")        

-- Global import for the Player
player = require("player")     

-- Global imports for all of the various Scenes in the game
titleScreen = require("titleScreen")           
clearMeadowTown = require("clearMeadowTown")     

activeScene = {}    -- Variable to hold a reference to the currently active Scene

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

    activeScene = titleScreen                                       -- Sets the currently active Scene to be the titleScreen
    activeScene.load()
end


function love.update(dt)
    checkQuit()                                                     -- Checks if the game needs to be quit
    WORLD:update(dt)                                                -- Updates the physics world
    activeScene.update(dt)                                          -- Updates the currently active scene
end


function love.draw()
    activeScene.draw()                                              -- Draws the currently active scene
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--