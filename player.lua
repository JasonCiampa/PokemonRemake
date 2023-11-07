local animator = require("animator")

local player = {}
player.spriteSheet = {}
-- player.spriteSheet.frontIdle = love.graphics.newImage("assets/images/main_character/front/main_character.png")    
-- player.spriteSheet.frontMoving1 = love.graphics.newImage("assets/images/main_character/front/main_character_frontMoving1.png")
-- player.spriteSheet.frontMoving2 = love.graphics.newImage("assets/images/main_character/front/main_character_frontMoving2.png")

player.animations = {}
player.animations.frontMoving = animator.makeAnimation("assets/images/main_character/front/", "frontMoving", ".png", 2)

player.currentAnimation = player.animations.frontMoving
player.width = 120
player.height = 160
player.x = 0
player.y = 0
player.movementSpeed = 300
player.armSwingTime = 0

function player.move(timer, dt)

    if (love.keyboard.isDown("w")) then
        player.y = player.y - (player.movementSpeed * dt)
    end

    if (love.keyboard.isDown("s")) then
        player.y = player.y + (player.movementSpeed * dt)

        player.animations.frontMoving.play(dt, 2)
        -- if (timer < 0.25) then
        --     player.currentCostume = player.spriteSheet.frontMoving1
        -- else
        --     player.currentCostume = player.spriteSheet.frontMoving2
        -- end

    end

    if (love.keyboard.isDown("a")) then
        player.x = player.x - (player.movementSpeed * dt)

        player.animations.frontMoving.play(dt, 2)
        -- if (timer < 0.25) then
        --     player.currentCostume = player.spriteSheet.frontMoving1
        -- else
        --     player.currentCostume = player.spriteSheet.frontMoving2
        -- end

    end

    if (love.keyboard.isDown("d")) then
        player.x = player.x + (player.movementSpeed * dt)

        player.animations.frontMoving.play(dt, 2)

        -- if (timer < 0.25) then
        --     player.currentCostume = player.spriteSheet.frontMoving1
        -- else
        --     player.currentCostume = player.spriteSheet.frontMoving2
        -- end
    end

    -- player.currentCostume = player.spriteSheet.frontIdle
end


function player.draw(player)
    player.currentAnimation.draw(player)
end

return player














