local player = {}
player.spriteSheet = {}
player.spriteSheet.frontIdle = love.graphics.newImage("assets/images/main_character/front/main_character.png")    
player.spriteSheet.frontMoving1 = love.graphics.newImage("assets/images/main_character/front/main_character_frontMoving1.png")
player.spriteSheet.frontMoving2 = love.graphics.newImage("assets/images/main_character/front/main_character_frontMoving2.png")

player.currentCostume = player.spriteSheet.frontIdle
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

        if (timer < 0.25) then
            player.currentCostume = player.spriteSheet.frontMoving1
        else
            player.currentCostume = player.spriteSheet.frontMoving2
        end

    end

    if (love.keyboard.isDown("a")) then
        player.x = player.x - (player.movementSpeed * dt)

        if (timer < 0.25) then
            player.currentCostume = player.spriteSheet.frontMoving1
        else
            player.currentCostume = player.spriteSheet.frontMoving2
        end

    end

    if (love.keyboard.isDown("d")) then
        player.x = player.x + (player.movementSpeed * dt)

        if (timer < 0.25) then
            player.currentCostume = player.spriteSheet.frontMoving1
        else
            player.currentCostume = player.spriteSheet.frontMoving2
        end
    end

    -- player.currentCostume = player.spriteSheet.frontIdle
end


function player.draw(player)
    love.graphics.draw(player.currentCostume, player.x, player.y)
end

return player














