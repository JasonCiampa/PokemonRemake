-- SHORT FLOWER CREATION --

local shortFlower = objectHandler.create("short_flower", 3900, -50, 60, 60, 48, love.graphics.newImage("assets/images/greenery/flowers/short/shortFlower_spritesheet.png"))        -- Creates the shortFlower object

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SHORT FLOWER ANIMATIONS --

table.insert(shortFlower.animations, shortFlower.createAnimation(2, 1, 1, 0.125))       -- Orange Dance
table.insert(shortFlower.animations, shortFlower.createAnimation(2, 2, 1, 0.12))       -- Pink Dance
table.insert(shortFlower.animations, shortFlower.createAnimation(2, 3, 1, 0.115))       -- White Dance

shortFlower.currentAnimation = shortFlower.animations[1]

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SHORT FLOWER FUNCTIONALITY --
function shortFlower.setDrawPosition(object)
    table.insert(clearMeadowTown.bottomHalfUnderPlayerTorso, object)
    table.insert(clearMeadowTown.topHalfUnderPlayerTorso, object)
end

function shortFlower.customUpdate(flower, dt)
    flower.currentAnimation.update(dt)                                                 -- Updates the flower's animation so that it keeps changing frames                                                                                                      
end

function shortFlower.drawTopHalf(object)
    object.currentAnimation:drawTopHalf(object.topLeftX, object.topLeftY)
end

function shortFlower.customDuplicate(object, newX, newY, newHitboxX, newHitboxY)
    local duplicate = object.duplicate(object, newX, newY, newHitboxX, newHitboxY)

    duplicate.setDrawPosition = object.setDrawPosition
    duplicate.customUpdate = object.customUpdate
    duplicate.drawTopHalf = object.drawTopHalf
    duplicate.animations = object.animations
    duplicate.currentAnimation = object.animations[math.random(1, #object.animations)]
    
    return duplicate
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return shortFlower