local player = physics.addObject("player", 0, 0, 120, 160, "assets/images/player/player_spritesheet.png", 0, 0, 120, 160, "dynamic", 0, 0.05)


player.animations.idle_up = player.createAnimation(2, 1, 1, 1)                                              -- Creates an upward-idle animation
player.animations.running_up = player.createAnimation(2, 1, 3, 1)                                           -- Creates an upward-running animation

player.animations.idle_down = player.createAnimation(2, 2, 1, 1)                                              -- Creates an downward-idle animation
player.animations.running_down = player.createAnimation(2, 2, 3, 1)                                           -- Creates an downward-running animation

player.animations.idle_left = player.createAnimation(2, 3, 1, 1)                                              -- Creates an leftward-idle animation
player.animations.running_left = player.createAnimation(2, 3, 3, 1)                                           -- Creates an leftward-running animation

player.animations.idle_right = player.createAnimation(2, 4, 1, 1)                                              -- Creates an rightward-idle animation
player.animations.running_right = player.createAnimation(2, 4, 3, 1)                                           -- Creates an rightward-running animation

player.animations.idle_direction = player.animations.idle_down

player.currentAnimation = player.animations.idle_down                                                                 -- Stores the current animation

player.movementSpeed = 500                                                                                               -- Sets the Player's movement speed to 300px

-- Moves the Player and updates animates the movements
function player.move(dt)
    local idleDirection = player.animations.idle_down

    player.enableAnimationUpdates()                                         -- Sets all of the Player's animation to be updatable                                             

    if (love.keyboard.isDown("w")) then                                     -- If the "w" key is being pressed...
        player.currentAnimation = player.animations.running_up                  -- Set the Player's currentAnimation to the running_up Animation
        player.animations.idle_direction = player.animations.idle_up               -- Set the idle_up as the next idle Animation
        player.currentAnimation.update(dt)                                 -- Update the current Animation

        if(love.keyboard.isDown("d")) then                                     -- If the "d" key is being pressed...
            player.body:setLinearVelocity(player.movementSpeed, -player.movementSpeed)                  -- Move the Player's x-position upward by their movementSpeed * dt

        elseif (love.keyboard.isDown("a")) then
            player.body:setLinearVelocity(-player.movementSpeed, -player.movementSpeed)                -- Move the Player's x-position upward by their movementSpeed * dt
        end

        player.body:setLinearVelocity(0, -player.movementSpeed)                 -- Move the Player's y-position upward by their movementSpeed * dt
        return                                                                     -- Return here since no other direction can be moving

    elseif (love.keyboard.isDown("s")) then                                     -- If the "s" key is being pressed...
        player.currentAnimation = player.animations.running_down                  -- Set the Player's currentAnimation to the running_down Animation
        player.animations.idle_direction = player.animations.idle_down               -- Set the idle_down as the next idle Animation
        player.currentAnimation.update(dt)                                 -- Update the current Animation

        if(love.keyboard.isDown("d")) then                                     -- If the "d" key is being pressed...
            player.body:setLinearVelocity(player.movementSpeed, player.movementSpeed)                  -- Move the Player's x-position upward by their movementSpeed * dt

        elseif (love.keyboard.isDown("a")) then
            player.body:setLinearVelocity(-player.movementSpeed, player.movementSpeed)                -- Move the Player's x-position upward by their movementSpeed * dt
        end

        player.body:setLinearVelocity(0, player.movementSpeed)                 -- Move the Player's y-position upward by their movementSpeed * dt
        return                                                                     -- Return here since no other direction can be moving
    end

    if (love.keyboard.isDown("a")) then                                     -- If the "w" key is being pressed...

        if(love.keyboard.isDown("s")) then                                     -- If the "d" key is being pressed...
            player.currentAnimation = player.animations.running_down                  -- Set the Player's currentAnimation to the running_down Animation
            player.animations.idle_direction = player.animations.idle_down               -- Set the idle_down as the next idle Animation
            player.currentAnimation.update(dt)                                 -- Update the current Animation
            player.body:setLinearVelocity(-player.movementSpeed, player.movementSpeed)                  -- Move the Player's x-position upward by their movementSpeed * dt

        elseif (love.keyboard.isDown("w")) then
            player.currentAnimation = player.animations.running_up                  -- Set the Player's currentAnimation to the running_up Animation
            player.animations.idle_direction = player.animations.idle_up               -- Set the idle_up as the next idle Animation
            player.currentAnimation.update(dt)                                 -- Update the current Animation
            player.body:setLinearVelocity(-player.movementSpeed, -player.movementSpeed)                -- Move the Player's x-position upward by their movementSpeed * dt
        end

        player.currentAnimation = player.animations.running_left                  -- Set the Player's currentAnimation to the running_left Animation
        player.animations.idle_direction = player.animations.idle_left               -- Set the idle_left as the next idle Animation
        player.currentAnimation.update(dt)                                 -- Update the current Animation
        player.body:setLinearVelocity(-player.movementSpeed, 0)                 -- Move the Player's y-position upward by their movementSpeed * dt
        return                                                                     -- Return here since no other direction can be moving

    elseif (love.keyboard.isDown("d")) then                                    -- If the "d" key is being pressed...

        if(love.keyboard.isDown("s")) then                                     -- If the "d" key is being pressed...
            player.currentAnimation = player.animations.running_down                  -- Set the Player's currentAnimation to the running_down Animation
            player.animations.idle_direction = player.animations.idle_down               -- Set the idle_down as the next idle Animation
            player.currentAnimation.update(dt)                                 -- Update the current Animation
            player.body:setLinearVelocity(player.movementSpeed, player.movementSpeed)                  -- Move the Player's x-position upward by their movementSpeed * dt

        elseif (love.keyboard.isDown("w")) then
            player.currentAnimation = player.animations.running_up                  -- Set the Player's currentAnimation to the running_up Animation
            player.animations.idle_direction = player.animations.idle_up               -- Set the idle_up as the next idle Animation
            player.currentAnimation.update(dt)                                 -- Update the current Animation
            player.body:setLinearVelocity(player.movementSpeed, -player.movementSpeed)                -- Move the Player's x-position upward by their movementSpeed * dt
        end

        player.currentAnimation = player.animations.running_right                  -- Set the Player's currentAnimation to the running_right Animation
        player.animations.idle_direction = player.animations.idle_right               -- Set the idle_right as the next idle Animation
        player.currentAnimation.update(dt)                                 -- Update the current Animation
        player.body:setLinearVelocity(player.movementSpeed, 0)                 -- Move the Player's y-position upward by their movementSpeed * dt
        return                                                                     -- Return here since no other direction can be moving

    end


    if(not love.keyboard.isDown("w", "a", "s", "d")) then                   -- If none of the movement keys are being pressed...
        player.currentAnimation = player.animations.idle_direction                                 -- Set the Player's currentAnimation to the idle Animation
        player.currentAnimation.update(dt)                                      -- Update the idle Animation

        player.body:setLinearDamping(10)
    end
end


return player














