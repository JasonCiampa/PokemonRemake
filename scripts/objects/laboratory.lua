-- PLAYER HOUSE CREATION --

local laboratory = objectHandler.create("laboratory", -649, -38, 1800, 984, 12, 809, love.graphics.newImage("assets/images/clear_meadow_town/buildings/lab/exterior/lab_exterior.png"), 0, 0, 1030, 809, "static", 1, 0)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PLAYER HOUSE ANIMATIONS --

laboratory.animations.idle = laboratory.createAnimation(1, 1, 1, 1)
laboratory.currentAnimation = laboratory.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PLAYER HOUSE FUNCTIONALITY --

laboratory.door = {}
laboratory.door.width = 168
laboratory.door.height = 240
laboratory.door.x = laboratory.x + 1188
laboratory.door.y = laboratory.y + 315
laboratory.door.leftEdge = laboratory.door.x
laboratory.door.rightEdge = laboratory.door.x + 336
laboratory.door.isOpen = false

function laboratory.door.open(door)
    if ((player.x >= door.leftEdge) and (player.x <= door.rightEdge) and (player.y > door.y)) then
        door.isOpen = true
    else
        door.isOpen = false
    end
end

function laboratory.customUpdate(object, dt)
    if (laboratory.door.isOpen) then
        laboratoryInterior = require("scripts/scenes/laboratoryInterior")
        nextScene = laboratoryInterior
        laboratory.door.isOpen = false
    end
end

function laboratory.setDrawPosition(object)
    table.insert(clearMeadowTown.bottomHalfUnderPlayerTorso, object)
    table.insert(clearMeadowTown.topHalfAbovePlayer, object)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return laboratory