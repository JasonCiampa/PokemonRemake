local player = physics.addObject("player", 120, 160, 0, 0, "dynamic", 0, 1)
local barrier = physics.addObject("barrier", 120, 160, 1920, 160, "static", 1, 1)
barrier.animations.idle = animator.create("assets/images/greenery/grass/grass", ".png", 1, 1)
barrier.currentAnimation = barrier.animations.idle

player.animations.frontMoving = animator.create("assets/images/main_character/front/frontMoving", ".png", 2, 2)          -- Creates a frontMoving animation
player.animations.idle = animator.create("assets/images/main_character/front/idle", ".png", 1, 1)                        -- Creates an idle animation
player.currentAnimation = player.animations.frontMoving                                                                  -- Stores the current animation

player.movementSpeed = 500                                                                                               -- Sets the Player's movement speed to 300px

-- Moves the Player and updates animates the movements
function player.move(dt)
    player.animations.frontMoving.updatable = true                          -- Sets the frontMoving animation to be updatable            
    player.animations.idle.updatable = true                                 -- Sets the idle animation to be updatable    

    if (love.keyboard.isDown("w")) then                                     -- If the "w" key is being pressed...
        player.body:setLinearVelocity(0, -player.movementSpeed)                -- Move the player to the right
    end

    if (love.keyboard.isDown("s")) then                                     -- If the "s" key is being pressed...
        player.body:setLinearVelocity(0, player.movementSpeed)                       -- Move the Player's y-position downward by their movementSpeed * dt
        player.currentAnimation = player.animations.frontMoving                 -- Set the Player's currentAnimation to the frontMoving Animation
        player.animations.frontMoving.update(dt)                                -- Update the frontMoving Animation
    end

    if (love.keyboard.isDown("a")) then                                     -- If the "a" key is being pressed...
        player.body:setLinearVelocity(-player.movementSpeed, 0)                       -- Move the Player's x-position leftward by their movementSpeed * dt
        player.currentAnimation = player.animations.frontMoving                 -- Set the Player's currentAnimation to the frontMoving Animation
        player.animations.frontMoving.update(dt)                                -- Update the frontMoving Animation
    end

    if (love.keyboard.isDown("d")) then                                     -- If the "d" key is being pressed...
        player.body:setLinearVelocity(player.movementSpeed, 0)              -- Move the Player's x-position rightward by their movementSpeed * dt
        player.currentAnimation = player.animations.frontMoving                 -- Set the Player's currentAnimation to the frontMoving Animation
        player.animations.frontMoving.update(dt)                                -- Update the frontMoving Animation
    end

    if(not love.keyboard.isDown("w", "a", "s", "d")) then                   -- If none of the movement keys are being pressed...
        player.currentAnimation = player.animations.idle                        -- Set the Player's currentAnimation to the idle Animation
        player.animations.idle.update(dt)                                       -- Update the idle Animation

        player.body:setLinearDamping(10)
    end
end

return player














