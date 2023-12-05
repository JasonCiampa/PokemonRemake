-- NEIGHBOR HOUSE CREATION --

local neighborHouse = objectHandler.create("neighbor_house", 1831, 1368, 1680, 492, 12, 355, love.graphics.newImage("assets/images/clear_meadow_town/buildings/houses/single_floor_long/exterior/single_floor_long_exterior.png"), 1868, 1723, 1606, 1, "static", 1, 0)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- NEIGHBOR HOUSE ANIMATIONS --

neighborHouse.animations.idle = neighborHouse.createAnimation(1, 1, 1, 1)
neighborHouse.currentAnimation = neighborHouse.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- NEIGHBOR HOUSE FUNCTIONALITY --

neighborHouse.door = {}
neighborHouse.door.width = 168
neighborHouse.door.height = 240
neighborHouse.door.x = neighborHouse.x + 444
neighborHouse.door.y = neighborHouse.y + 252
neighborHouse.door.leftEdge = neighborHouse.door.x
neighborHouse.door.rightEdge = neighborHouse.door.x + 168
neighborHouse.door.isOpen = false

function neighborHouse.door.open(door)
    if ((player.x >= door.leftEdge) and (player.x <= door.rightEdge) and (player.y > door.y)) then
        door.isOpen = true
    else
        door.isOpen = false
    end
end

function neighborHouse.customUpdate(object, dt)
    if (neighborHouse.door.isOpen) then
        neighborHouseInterior = require("scripts/scenes/neighborHouseInterior")
        nextScene = neighborHouseInterior
        neighborHouse.door.isOpen = false
    end
end

function neighborHouse.setDrawPosition(object)
    table.insert(clearMeadowTown.bottomHalfUnderPlayerTorso, object)
    table.insert(clearMeadowTown.topHalfAbovePlayer, object)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return neighborHouse