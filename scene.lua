local button = require("button")
local camera = require("camera")  

-- Creates a new Scene
local sceneHandler = {}

-- Creates and returns a new Scene
function sceneHandler.create(backgroundImage, x, y, backgroundMusic)
    local scene = {}

    scene.background = love.graphics.newImage(backgroundImage)  -- Scene background image is set
    scene.width = scene.background:getWidth()                   -- Scene width is set to the width of the Scene's background image
    scene.height = scene.background:getHeight()                 -- Scene height is set set to the height of the Scene's background image
    scene.x = x                                                 -- Scene x-coordinate is set
    scene.y = y                                                 -- Scene y-coordinate is set

    if (backgroundMusic ~= nil) then                            -- If Scene background music was passed into the function...
        scene.backgroundMusic = backgroundMusic                     -- Scene background music is set
        scene.backgroundMusic:setVolume(0.50)                       -- Scene background music volume is set to half
        scene.backgroundMusic:setLooping(true)                      -- Scene background music is set to loop
    end
    
    scene.buttons = {}                                          -- Scene Button list is created
    scene.cameras = {}                                          -- Scene Camera list is created
    scene.activeCamera = ""                                     -- Scene Active Camera is set as empty (will store whichever camera is active)

    scene.active = false                                        -- Scene is set to be inactive


    -- Creates and returns a new Button
    function scene.createButton(width, height, x, y, backgroundColor, textColor, text)
        return button.create(width, height, x, y, backgroundColor, textColor, text)
    end

    -- Creates and returns a new Camera
    function scene.createCamera(x, y, rightShiftCoord, leftShiftCoord, downwardShiftCoord, upwardShiftCoord, rightBoundary, leftBoundary, downwardBoundary, upwardBoundary)
        return camera.create(x, y, rightShiftCoord, leftShiftCoord, downwardShiftCoord, upwardShiftCoord, rightBoundary, leftBoundary, downwardBoundary, upwardBoundary)
    end

    -- Checks if any of the Buttons in the Scene were clicked on (this function is only called after a left-click has been detected by the love.mousepressed function).
    function scene.mousepressed(mouseX, mouseY)
        for buttonKey, button in pairs(scene.buttons) do    -- For every Button in the Scene...
            if (mouseInObject(button, mouseX, mouseY)) then
                button:isPressed(mouseX, mouseY)                    -- Check if the Button was pressed
            end
        end
    end

    -- Draws the Scene on the screen.
    function scene.draw()
        love.graphics.draw(scene.background, scene.x, scene.y)

        for buttonKey, button in pairs(scene.buttons) do -- Found out how to iterate over key and value pairs from here: https://opensource.com/article/22/11/iterate-over-tables-lua 
            button:draw()
        end
    end

    return scene
end


-- Changes from the currentScene to the nextScene (switches their .active values)
function sceneHandler.change(currentScene, nextScene)
    currentScene.active = false
    nextScene.active = true
end

return sceneHandler