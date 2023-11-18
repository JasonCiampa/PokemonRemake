local sceneHandler = {}

-- Sets the currently active Scene to newScene
function sceneHandler.changeTo(newScene)
    activeScene = newScene
    activeScene.load()
end

-- Creates and returns a new Scene 
function sceneHandler.create(backgroundImage, x, y, backgroundMusic)

    -- SCENE FIELDS --

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

    scene.cameras = {}                                          -- Scene Camera list is created
    scene.activeCamera = ""                                     -- Scene Active Camera is set as empty (will store whichever camera is active)

    scene.buttons = {}                                          -- Scene Button list is created

    scene.objects = {}
    
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    -- SCENE CREATE FUNCTIONS --

    -- Creates and returns a new Button
    function scene.createButton(width, height, x, y, backgroundColor, textColor, text)
        return button.create(width, height, x, y, backgroundColor, textColor, text)
    end

    -- Creates and returns a new Camera
    function scene.createCamera(x, y, rightShiftCoord, leftShiftCoord, downwardShiftCoord, upwardShiftCoord, rightBoundary, leftBoundary, downwardBoundary, upwardBoundary)
        return camera.create(x, y, rightShiftCoord, leftShiftCoord, downwardShiftCoord, upwardShiftCoord, rightBoundary, leftBoundary, downwardBoundary, upwardBoundary)
    end

    -- Creates and returns a new Object
    function scene.createObject(name, width, height, x, y, physicsType, density, restitution, animations)
        local object = physics.addObject(name, width, height, x, y, physicsType, density, restitution, animations)
        table.insert(scene.objects, object)
        return object
    end

    -- Create a new duplicate Object of a passed in Object
    function scene.createDuplicateObject(object, newX, newY)
        local object = physics.addObject(object.name, object.width, object.height, object.x, object.y, object.physicsType, object.density, object.restitution, object.animations)
        table.insert(scene.objects, object)
        return object
    end

    -- Creates the tiles for a given tilemap
    function scene.createTilemap()

    end

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    -- Checks if any of the Buttons in the Scene were clicked on (this function is only called after a left-click has been detected by the love.mousepressed function).
    function scene.mousepressed(mouseX, mouseY)
        for buttonKey, button in pairs(scene.buttons) do    -- For every Button in the Scene...
            if (mouseInObject(button, mouseX, mouseY)) then
                button:isPressed(mouseX, mouseY)                    -- Check if the Button was pressed
            end
        end
    end

    -- Draws all of the Buttons in the Scene's Button list on the screen (and adjusts their color if the Button is being hovered over).
    function scene.drawButtons()
        for buttonKey, button in pairs(scene.buttons) do
            button:draw()                               -- Draws a Button on the screen
            button:mouseHovering()                      -- Adjust a Button's color if the mouse is hovering over it
        end
    end

    -- Updates all of the Objects in the Scene's Object list on the screen
    function scene.updateObjects(dt)
        for i = 1, #scene.objects do
            scene.objects[i].update(dt)
        end
    end

    -- Draws all of the Objects in the Scene's Object list on the screen
    function scene.drawObjects()
        for i = 1, #scene.objects do
            scene.objects[i]:draw()
        end
    end

    -- Loads the Scene's starting state
    function scene.load()
        -- The code for this function should be defined manually for each Scene in their own individual file.
    end

    -- Updates the Scene's state
    function scene.update()
        -- The code for this function should be defined manually for each Scene in their own individual file.
    end

    -- Draws the Scene's current state on the screen
    function scene.draw()
        -- The code for this function should be defined manually for each Scene in their own individual file.
    end

    return scene
end

return sceneHandler