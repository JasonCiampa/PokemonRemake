-- PLAYER CREATION --

local player = objectHandler.create("player", 0, 0, 120, 160, 112, love.graphics.newImage("assets/images/player/player_spritesheet.png"))      -- Creates the Player Object
player:physicsify("dynamic", 0, 0.05, 0, 0, 120, 160)                                                                                   -- Turns the Player into a Physics Object
player.movementSpeed = 500                                                                                                              -- Sets the Player's linear velocity to be 500

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PLAYER ANIMATIONS --

player.animations.idle_up = player.createAnimation(2, 1, 1, 2)                              -- Creates an upward-idle animation
player.animations.running_up = player.createAnimation(2, 1, 3, 2)                           -- Creates an upward-running animation

player.animations.idle_down = player.createAnimation(2, 2, 1, 2)                            -- Creates an downward-idle animation
player.animations.running_down = player.createAnimation(2, 2, 3, 2)                         -- Creates an downward-running animation

player.animations.idle_left = player.createAnimation(2, 3, 1, 2)                            -- Creates an leftward-idle animation
player.animations.running_left = player.createAnimation(2, 3, 3, 2)                         -- Creates an leftward-running animation

player.animations.idle_right = player.createAnimation(2, 4, 1, 2)                           -- Creates an rightward-idle animation
player.animations.running_right = player.createAnimation(2, 4, 3, 2)                        -- Creates an rightward-running animation

player.animations.idle_direction = player.animations.idle_down                              -- Stores the direction for the idle animation                         

player.currentAnimation = player.animations.idle_down                                       -- Stores the current animation

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PLAYER MOVEMENT --

-- Moves the Player and updates animates the movements
function player.move(dt)
    
    -- UPWARD AND RIGHTWARD MOVEMENT --
    if (love.keyboard.isDown("w") and love.keyboard.isDown("d")) then                       -- If the "w" key and the "d" key are both being pressed...
        player.currentAnimation = player.animations.running_up                                  -- Set the Player's currentAnimation to the running_up Animation
        player.animations.idle_direction = player.animations.idle_up                            -- Set the idle_up as the next idle Animation
        player.currentAnimation.update(dt)                                                      -- Update the current Animation
        player.physics.body:setLinearVelocity(player.movementSpeed, -player.movementSpeed)              -- Move the Player upward and rightward by their movement speed * dt
        return                                                                                  -- Return since only one direction can be moved in at once
    end

    -- UPWARD AND LEFTWARD MOVEMENT --
    if (love.keyboard.isDown("w") and love.keyboard.isDown("a")) then                       -- If the "w" key and the "a" key are both being pressed...
        player.currentAnimation = player.animations.running_up                                  -- Set the Player's currentAnimation to the running_up Animation
        player.animations.idle_direction = player.animations.idle_up                            -- Set the idle_up as the next idle Animation
        player.currentAnimation.update(dt)                                                      -- Update the current Animation
        player.physics.body:setLinearVelocity(-player.movementSpeed, -player.movementSpeed)             -- Move the Player upward and leftward by their movement speed * dt
        return                                                                                  -- Return since only one direction can be moved in at once
    end

    -- DOWNWARD AND RIGHTWARD MOVEMENT --
    if (love.keyboard.isDown("s") and love.keyboard.isDown("d")) then                       -- If the "s" key and the "d" key are both being pressed...
        player.currentAnimation = player.animations.running_down                                -- Set the Player's currentAnimation to the running_down Animation
        player.animations.idle_direction = player.animations.idle_down                          -- Set the idle_down as the next idle Animation
        player.currentAnimation.update(dt)                                                      -- Update the current Animation
        player.physics.body:setLinearVelocity(player.movementSpeed, player.movementSpeed)              -- Move the Player downward and rightward by their movement speed * dt
        return                                                                                  -- Return since only one direction can be moved in at once
    end

    -- DOWNWARD AND LEFTWARD MOVEMENT --
    if (love.keyboard.isDown("s") and love.keyboard.isDown("a")) then                       -- If the "s" key and the "a" key are both being pressed...
        player.currentAnimation = player.animations.running_down                                -- Set the Player's currentAnimation to the running_down Animation
        player.animations.idle_direction = player.animations.idle_down                          -- Set the idle_down as the next idle Animation
        player.currentAnimation.update(dt)                                                      -- Update the current Animation
        player.physics.body:setLinearVelocity(-player.movementSpeed, player.movementSpeed)             -- Move the Player downward and leftward by their movement speed * dt
        return                                                                                  -- Return since only one direction can be moved in at once  
    end

    -- UPWARD MOVEMENT --
    if (love.keyboard.isDown("w")) then                                                     -- If the "w" key is being pressed...
        player.currentAnimation = player.animations.running_up                                  -- Set the Player's currentAnimation to the running_up Animation
        player.animations.idle_direction = player.animations.idle_up                            -- Set the idle_up as the next idle Animation
        player.currentAnimation.update(dt)                                                      -- Update the current Animation
        player.physics.body:setLinearVelocity(0, -player.movementSpeed)                                 -- Move the Player upward by their movement speed * dt
        return                                                                                  -- Return since only one direction can be moved in at once
    end

    -- DOWNWARD MOVEMENT --
    if (love.keyboard.isDown("s")) then                                                     -- If the "s" key is being pressed...
        player.currentAnimation = player.animations.running_down                                -- Set the Player's currentAnimation to the running_down Animation
        player.animations.idle_direction = player.animations.idle_down                          -- Set the idle_down as the next idle Animation
        player.currentAnimation.update(dt)                                                      -- Update the current Animation
        player.physics.body:setLinearVelocity(0, player.movementSpeed)                                  -- Move the Player downward by their movement speed * dt
        return                                                                                  -- Return since only one direction can be moved in at once
    end

    -- LEFTWARD MOVEMENT --
    if (love.keyboard.isDown("a")) then                                                     -- If the "a" key is being pressed...
        player.currentAnimation = player.animations.running_left                                -- Set the Player's currentAnimation to the running_left Animation
        player.animations.idle_direction = player.animations.idle_left                          -- Set the idle_left as the next idle Animation
        player.currentAnimation.update(dt)                                                      -- Update the current Animation
        player.physics.body:setLinearVelocity(-player.movementSpeed, 0)                                 -- Move the Player leftward by their movement speed * dt
        return                                                                                  -- Return since only one direction can be moved in at once
    end

    -- RIGHTWARD MOVEMENT --
    if (love.keyboard.isDown("d")) then                                                     -- If the "d" key is being pressed...
        player.currentAnimation = player.animations.running_right                               -- Set the Player's currentAnimation to the running_right Animation
        player.animations.idle_direction = player.animations.idle_right                         -- Set the idle_right as the next idle Animation
        player.currentAnimation.update(dt)                                                      -- Update the current Animation
        player.physics.body:setLinearVelocity(player.movementSpeed, 0)                                  -- Move the Player rightward by their movement speed * dt
        return                                                                                  -- Return since only one direction can be moved in at once
    end

    -- NO MOVEMENT
    if(not love.keyboard.isDown("w", "a", "s", "d")) then                                   -- If none of the movement keys are being pressed...
        player.currentAnimation = player.animations.idle_direction                              -- Set the Player's currentAnimation to the idle Animation
        player.currentAnimation.update(dt)                                                      -- Update the idle Animation
        player.physics.body:setLinearDamping(10)                                                        -- Set the amount of "sliding" the Player does when finishing a movement (deceleration)
    end
end

function player.customUpdate(player, dt)
    player.move(dt)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return player














