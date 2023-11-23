local cameraHandler = {}

-- Creates and returns a new Camera
function cameraHandler.create(x, y, rightShiftCoord, leftShiftCoord, downwardShiftCoord, upwardShiftCoord, rightBoundary, leftBoundary, downwardBoundary, upwardBoundary)
    local camera = {}

    camera.x = x    -- The x-coordinate of the Camera
    camera.y = y    -- The y-coordinate of the Camera

    camera.rightShiftCoord = rightShiftCoord            -- The x-coordinate that should trigger a right shift of the Camera when an Object's x-coordinate is greater
    camera.leftShiftCoord = leftShiftCoord              -- The x-coordinate that should trigger a left shift of the Camera when an Object's x-coordinate is smaller
    camera.downwardShiftCoord = downwardShiftCoord      -- The y-coordinate that should trigger a downward shift of the Camera when an Object's y-coordinate is larger
    camera.upwardShiftCoord = upwardShiftCoord          -- The y-coordinate that should trigger an upward shift of the Camera when an Object's y-coordinate is smaller

    camera.rightBoundary = rightBoundary                -- The x-coordinate that the Camera's x-coordinate can not be greater than
    camera.leftBoundary = leftBoundary                  -- The x-coordinate that the Camera's x-coordinate can not be smaller than
    camera.downwardBoundary = downwardBoundary          -- The y-coordinate that the Camera's y-coordinate can not be greater than
    camera.upwardBoundary = upwardBoundary              -- The y-coordinate that the Camera's y-coordinate can not be smaller than

    function camera.follow(object)
        objectX = object.physics.x
        objectY = object.physics.y

        -- RIGHT SHIFT HANDLER --
        if (objectX > camera.x + camera.rightShiftCoord) then                      -- If the object crosses the rightShiftCoord...
            local shiftDistance = objectX - (camera.x + camera.rightShiftCoord)        -- Calculate the shiftDistance (how far the object traveled past the rightShiftCoord)
            camera.x = camera.x + shiftDistance                                         -- Shift the Camera to the right by shiftDistance px
    
            if (camera.x > camera.rightBoundary) then                               -- If the Camera crosses the right boundary...
                camera.x = camera.rightBoundary                                         -- Reset the Camera at exactly the right boundary.
            end
        
        -- LEFT SHIFT HANDLER --
        elseif (objectX < camera.x + camera.leftShiftCoord) then                   -- If the object crosses the leftShiftCoord...
            local shiftDistance = (camera.x + camera.leftShiftCoord) - objectX     -- Calculate the shiftDistance (how far the object traveled past the leftShiftCoord)
            camera.x = camera.x - shiftDistance                                     -- Shift the Camera to the left by shiftDistance px
    
            if (camera.x < camera.leftBoundary) then                                -- If the Camera crosses the left boundary...
                camera.x = camera.leftBoundary                                          -- Reset the Camera at exactly the left boundary.
            end
        end
    
        -- DOWNWARD SHIFT HANDLER --
        if (objectY > camera.y + camera.downwardShiftCoord) then                             -- If the object crosses the downwardShiftCoord...
            local shiftDistance = objectY - (camera.y + camera.downwardShiftCoord)           -- Calculate the shiftDistance (how far the object traveled past the downwardShiftCoord)
            camera.y = camera.y + shiftDistance                                               -- Shift the Camera to the downward by shiftDistance px
    
            if (camera.y > camera.downwardBoundary) then                                      -- If the Camera crosses the downward boundary...
                camera.y = camera.downwardBoundary                                              -- Reset the Camera at exactly the downward boundary.
            end
    
        -- UPWARD SHIFT HANDLER
        elseif (objectY < camera.y + camera.upwardShiftCoord) then                           -- If the object crosses the upwardShiftCoord...
            local shiftDistance = (camera.y + camera.upwardShiftCoord) - objectY             -- Calculate the shiftDistance (how far the object traveled past the upwardShiftCoord)
            camera.y = camera.y - shiftDistance                                               -- Shift the Camera to the upward by shiftDistance px
    
            if (camera.y < camera.upwardBoundary) then                                        -- If the Camera crosses the upward boundary...
                camera.y = camera.upwardBoundary                                                -- Reset the Camera at exactly the upward boundary.
            end
        end
    end

    -- Sets the window to the camera's coordinates (what the camera sees)
    function camera.draw()
        love.graphics.translate(-camera.x, -camera.y)
    end

    return camera
end

return cameraHandler