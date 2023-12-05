-- PLAYER HOUSE CREATION --

local playerHouse = objectHandler.create("player_house", 2496, 328, 840, 492, 12, 356, love.graphics.newImage("assets/images/clear_meadow_town/buildings/houses/single_floor//single_floor_spritesheet.png"), 2532, 684, 743, 1, "static", 1, 0)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PLAYER HOUSE ANIMATIONS --

playerHouse.animations.idle = playerHouse.createAnimation(1, 1, 1, 1)
playerHouse.animations.openDoor = playerHouse.createAnimation(4, 2, 1, 1)
playerHouse.currentAnimation = playerHouse.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PLAYER HOUSE FUNCTIONALITY --

playerHouse.door = {}
playerHouse.door.width = 168
playerHouse.door.height = 240
playerHouse.door.x = playerHouse.x + 324
playerHouse.door.y = playerHouse.y + 252
playerHouse.door.leftEdge = playerHouse.door.x
playerHouse.door.rightEdge = playerHouse.door.x + 168
playerHouse.door.isOpen = false

function playerHouse.door.open(door)
    if ((player.x >= door.leftEdge) and (player.x <= door.rightEdge) and (player.y > door.y)) then
        door.isOpen = true
    else
        door.isOpen = false
    end
end

function playerHouse.customUpdate(object, dt)
    if (playerHouse.door.isOpen) then

        if (playerHouseInterior == nil) then
            playerHouseInterior = require("scripts/scenes/playerHouseInterior")
        end

        nextScene = playerHouseInterior
        playerHouse.door.isOpen = false
    end
end

function playerHouse.setDrawPosition(object)
    table.insert(clearMeadowTown.bottomHalfUnderPlayerTorso, object)
    table.insert(clearMeadowTown.topHalfAbovePlayer, object)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return playerHouse