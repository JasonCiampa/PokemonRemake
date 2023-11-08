local animator = require("animator")

local player = {}

player.animations = {}                                                                                                   -- Creates an animations table to hold Animations
player.animations.frontMoving = animator.create("assets/images/main_character/front/frontMoving", ".png", 2, 2)          -- Creates a frontMoving animation
player.animations.idle = animator.create("assets/images/main_character/front/idle", ".png", 1, 1)                        -- Creates an idle animation
player.currentAnimation = player.animations.frontMoving                                                                  -- Stores the current animation

player.width = 120                                                                                                       -- Sets the Player's width to 120
player.height = 160                                                                                                      -- Sets the Player's height to 160
player.x = 0                                                                                                             -- Sets the Player's x-coordinate to 0
player.y = 0                                                                                                             -- Sets the Player's y-coordinate to 0

player.movementSpeed = 300                                                                                               -- Sets the Player's movement speed to 300px

-- Moves the Player and updates animates the movements
function player.move(timer, dt)
    player.animations.frontMoving.updatable = true                          -- Sets the frontMoving animation to be updatable            
    player.animations.idle.updatable = true                                 -- Sets the idle animation to be updatable    

    if (love.keyboard.isDown("w")) then                                     -- If the "w" key is being pressed...
        player.y = player.y - (player.movementSpeed * dt)                       -- Move the Player's y-position upward by their movementSpeed * dt
    end

    if (love.keyboard.isDown("s")) then                                     -- If the "s" key is being pressed...
        player.y = player.y + (player.movementSpeed * dt)                       -- Move the Player's y-position downward by their movementSpeed * dt
        player.currentAnimation = player.animations.frontMoving                 -- Set the Player's currentAnimation to the frontMoving Animation
        player.animations.frontMoving.update(dt)                                -- Update the frontMoving Animation
    end

    if (love.keyboard.isDown("a")) then                                     -- If the "a" key is being pressed...
        player.x = player.x - (player.movementSpeed * dt)                       -- Move the Player's x-position leftward by their movementSpeed * dt
        player.currentAnimation = player.animations.frontMoving                 -- Set the Player's currentAnimation to the frontMoving Animation
        player.animations.frontMoving.update(dt)                                -- Update the frontMoving Animation
    end

    if (love.keyboard.isDown("d")) then                                     -- If the "d" key is being pressed...
        player.x = player.x + (player.movementSpeed * dt)                       -- Move the Player's x-position rightward by their movementSpeed * dt
        player.currentAnimation = player.animations.frontMoving                 -- Set the Player's currentAnimation to the frontMoving Animation
        player.animations.frontMoving.update(dt)                                -- Update the frontMoving Animation
    end

    if(not love.keyboard.isDown("w", "a", "s", "d")) then                   -- If none of the movement keys are being pressed...
        player.currentAnimation = player.animations.idle                        -- Set the Player's currentAnimation to the idle Animation
        player.animations.idle.update(dt)                                       -- Update the idle Animation
    end
end


-- Draws the Player's currentAnimation frame
function player.draw()
    player.currentAnimation.draw(player.x - player.width / 2, player.y - player.height / 2)
end

return player














