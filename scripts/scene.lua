local sceneHandler = {}

-- Sets the currently active Scene to newScene
function sceneHandler.change()
    sceneUnloading = true
    timer = 1
end

function sceneHandler.fadeTransition(dt) 

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

    -- SCENE LOAD FUNCTIONS --

    -- Creates and returns a new Button
    function scene.loadButton(button)
        table.insert(scene.buttons, button)      -- Disabled for now, Buttons are put into dictionary format
        return button
    end

    -- Creates and returns a new Camera
    function scene.loadCamera(camera)
        table.insert(scene.cameras, camera)      -- Inserts the new Camera into the Scene's list of Cameras
        return camera          
    end

    function scene.loadObject(object)
        table.insert(scene.objects, object)         -- Objects are stored in typical list format
        return object
    end

    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    -- OTHER SCENE FUNCTIONS --

    -- Checks if any of the Buttons in the Scene were clicked on (this function is only called after a left-click has been detected by the love.mousepressed function).
    function scene.mousepressed(mouseX, mouseY)
        for buttonKey, button in pairs(scene.buttons) do                -- For every Button in the Scene...
            if (button.active) then                                         -- If the Button is currently active...    
                if (mouseInObject(button, mouseX, mouseY)) then                 -- If the mouse is currently inside of the Button...
                    button:isPressed(mouseX, mouseY)                                -- Check if the Button was pressed
                end
            end
        end
    end

    -- Changes the active state of every Button in a list of Buttons
    function scene.setButtonStates(buttonList, activeState)
        for buttons, button in pairs(buttonList) do
            button.active = activeState
        end
    end

    function scene.updateButtons(dt)
        for buttonLabel, button in pairs(scene.buttons) do
            button:update(dt)                               -- Draws a Button on the screen
        end
    end

    -- Updates all of the Objects in the Scene's Object list on the screen
    function scene.updateObjects(dt)
        for i = 1, #scene.objects do
            scene.objects[i]:update(dt)
        end
    end

    -- Draws all of the Buttons in the Scene's Button list on the screen (and adjusts their color if the Button is being hovered over).
    function scene.drawButtons()
        -- for i = 1, #scene.buttons do     -- Disabled for now, Buttons aren't stored in typical list format
        --     scene.buttons[i]:draw()
        -- end

        for buttonLabel, button in pairs(scene.buttons) do
            button:draw()                               -- Draws a Button on the screen
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
        love.graphics.draw(scene.background, scene.x, scene.y)
    end

    -- Unloads the Scene
    function scene.unload()
        for i = #scene.objects, 1, -1 do
            scene.objects[i]:disable()
            table.remove(scene.objects, i)
        end

        for i = #scene.cameras, 1, -1 do
            table.remove(scene.cameras, i)
        end

        for i = #scene.buttons, 1, -1 do
            scene.buttons[i].active = false
            table.remove(scene.buttons, i)
        end

        scene.backgroundMusic:stop()
        player.walkingSFX:stop()
    end

    return scene
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return sceneHandler