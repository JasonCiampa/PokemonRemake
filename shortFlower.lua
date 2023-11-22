-- SHORT FLOWER CREATION --

local shortFlower = physics.create("short_flower", 3900, -50, 60, 60, 36, love.graphics.newImage("assets/images/greenery/flowers/short/shortFlowerOrange_spritesheet.png"), -1000, -1000, 0, 0, "static", 1, 0)

shortFlower.colors = { {1, 0, 0, 1},  {1, 0.42, 0, 1},  {1, 0.85, 0, 1},  {0.3, 1, 0, 1},  {0, 0, 1, 1},  {0.28, 0, 1, 1} }                           -- Holds RGBA values for Red, Orange, Yellow, Green, Blue, and Purple respectively
shortFlower.color = {1, 0, 0, 1}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SHORT FLOWER ANIMATIONS --

shortFlower.animations.dance = shortFlower.createAnimation(2, 1, 1, 0.5)
shortFlower.currentAnimation = shortFlower.animations.dance

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SHORT FLOWER FUNCTIONALITY --
function shortFlower.setDrawPosition(object)
    table.insert(clearMeadowTown.bottomHalfUnderPlayerTorso, object)
    table.insert(clearMeadowTown.topHalfUnderPlayerTorso, object)
end

function shortFlower.update(dt)
    shortFlower.centerX = shortFlower.body:getX()                                                                                                -- Updates the shortFlower's centerX value to be the value of the body's x-coordinate
    shortFlower.centerY = shortFlower.body:getY()                                                                                                -- Updates the shortFlower's centerY value to be the value of the body's y-coordinate
    shortFlower.topLeftX = shortFlower.centerX - shortFlower.halfWidth                                                                           -- Updates the shortFlower's top left corner value by subtracting away from the center
    shortFlower.topLeftY = shortFlower.centerY - shortFlower.halfHeight                                                                          -- Updates the shortFlower's top left corner value by subtracting away from the center
    shortFlower:setDrawPosition()                                                                                                                -- Updates the shortFlower's draw position (above or below the player)
    shortFlower.resetAnimation()                                                                                                                 -- Resets the shortFlower's animation so it can be played again
    shortFlower.currentAnimation.update(dt)                                                                                                      -- Updates the shortFlower's animation so that it keeps changing frames
end

function shortFlower.drawTopHalf(object)
    love.graphics.setColor(object.color)
    object.currentAnimation:drawTopHalf(object.topLeftX, object.topLeftY)
    love.graphics.setColor(1, 1, 1, 1)
end

function shortFlower.duplicate(object, newX, newY, newHitboxX, newHitboxY)
    local duplicate = physics.duplicate(object, newX, newY, newHitboxX, newHitboxY)
    duplicate.setDrawPosition = shortFlower.setDrawPosition
    duplicate.update = shortFlower.update
    duplicate.drawTopHalf = shortFlower.drawTopHalf
    duplicate.color = shortFlower.colors[love.math.random(1, 6)]

    return duplicate
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return shortFlower