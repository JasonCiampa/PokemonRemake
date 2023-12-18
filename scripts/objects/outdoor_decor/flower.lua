-- FLOWER CREATION --

local flower = objectHandler.create("flower", 0, 0, 60, 60, 12, 48, love.graphics.newImage("assets/images/outdoor_decor/greenery/flowers/flowers_spritesheet.png"))        -- Creates the flower object
flower:disable()
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- FLOWER ANIMATIONS --

table.insert(flower.animations, flower.createAnimation(2, 1, 1, 0.125))       -- Indigo Rose Dance
table.insert(flower.animations, flower.createAnimation(2, 2, 1, 0.125))        -- Red Rose Dance
table.insert(flower.animations, flower.createAnimation(2, 3, 1, 0.125))       -- Yellow Rose Dance
table.insert(flower.animations, flower.createAnimation(2, 3, 1, 0.125))       -- Orange Daffodil Dance
table.insert(flower.animations, flower.createAnimation(2, 4, 1, 0.125))        -- Pink Daffodil Dance
table.insert(flower.animations, flower.createAnimation(2, 5, 1, 0.125))       -- White Daffodil Dance

flower.currentAnimation = flower.animations[1]

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--  FLOWER FUNCTIONALITY --

function flower.setDrawPosition(object)
    table.insert(clearMeadowTown.bottomHalfUnderPlayerTorso, object)
    table.insert(clearMeadowTown.topHalfUnderPlayerTorso, object)
end

function flower.customUpdate(object, dt)
    object.currentAnimation.update(dt)                                                 -- Updates the flower's animation so that it keeps changing frames                                                                                                      
end

function flower.customDuplicate(object, duplicateObject)

    duplicateObject.customUpdate = object.customUpdate
    duplicateObject.currentAnimation = object.animations[math.random(1, #object.animations)]
    
    return duplicateObject
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return flower