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

    scene.background = love.graphics.newImage(backgroundImage)                      -- Stores the Scene's background image
    scene.width = scene.background:getWidth()                                       -- Stores the width of the Scene's background image
    scene.height = scene.background:getHeight()                                     -- Stores the height of the Scene's background image
    scene.x = x                                                                     -- Stores the x-coordinate of the Scene
    scene.y = y                                                                     -- Stores the y-coordinate of the Scene

    if (backgroundMusic ~= nil) then                                                -- If Scene background music was passed into the function...
        scene.backgroundMusic = love.audio.newSource(backgroundMusic, "stream")         -- Stores the background music for the Scene
        scene.backgroundMusic:setVolume(0.50)                                           -- Sets the Scene's background music volume to half
        scene.backgroundMusic:setLooping(true)                                          -- Sets the Scene's background music to loop
    end

    scene.cameras = {}                                                              -- Stores all of the Scene's Cameras
    scene.activeCamera = {}                                                         -- Stores the Scene's active Cameras

    scene.buttons = {}                                                              -- Stores all of the Scene's Buttons

    scene.objects = {}                                                              -- Stores all of the Scene's Objects
    
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
    function scene.createObject(name, objectX, objectY, objectWidth, objectHeight, splitPoint, spritesheet, hitboxX, hitboxY, hitboxWidth, hitboxHeight, physicsType, density, restitution)
        local object = physics.create(name, objectX, objectY, objectWidth, objectHeight, splitPoint, spritesheet, hitboxX, hitboxY, hitboxWidth, hitboxHeight, physicsType, density, restitution)
        table.insert(scene.objects, object)
        return object
    end


    function scene.loadObject(object)
        table.insert(scene.objects, object)
        return object
    end

    -- Create a new duplicate Object of a passed in Object
    function scene.createDuplicateObject(object, newX, newY, newHitboxX, newHitboxY)
        if (newHitboxX == nil and newHitboxY == nil) then
            newHitboxX = object.hitbox.topLeftX + (newX - object.topLeftX) 
            newHitboxY = object.hitbox.topLeftY + (newY - object.topLeftY)
        end

        local duplicateObject = scene.createObject(object.name, newX, newY, object.width, object.height, object.splitPoint, object.spritesheet, newHitboxX, newHitboxY, object.hitbox.width, object.hitbox.height, object.physicsType, object.density, object.restitution)
        duplicateObject.setDrawPosition = object.setDrawPosition
        duplicateObject.animations = object.animations
        duplicateObject.currentAnimation = object.currentAnimation
        duplicateObject.drawTopHalf = object.drawTopHalf
    end

    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    -- OTHER SCENE FUNCTIONS --

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

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return sceneHandler