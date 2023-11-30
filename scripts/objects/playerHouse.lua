-- PLAYER HOUSE CREATION --

local playerHouse = objectHandler.create("player_house", 2496, 328, 840, 492, 356, love.graphics.newImage("assets/images/clear_meadow_town/buildings/houses/single_floor/single_floor_exterior.png"), 2532, 684, 743, 1, "static", 1, 0)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PLAYER HOUSE ANIMATIONS --

playerHouse.animations.idle = playerHouse.createAnimation(1, 1, 1, 1)
playerHouse.currentAnimation = playerHouse.animations.idle

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PLAYER HOUSE FUNCTIONALITY --

playerHouse.door = {}
playerHouse.door.width = 168
playerHouse.door.height = 240
playerHouse.door.x = 2820
playerHouse.door.y = 580
playerHouse.door.leftEdge = playerHouse.door.x
playerHouse.door.rightEdge = playerHouse.door.x + 168
playerHouse.door.open = false

function playerHouse.door.toggleOpen(door)
    if ((player.x >= door.leftEdge) and (player.x <= door.rightEdge) and (player.y > door.y)) then
        door.open = true
    end
end


function playerHouse.customUpdate(object, dt)

end

function playerHouse.setDrawPosition(object)
    table.insert(clearMeadowTown.bottomHalfUnderPlayerTorso, object)
    table.insert(clearMeadowTown.topHalfAbovePlayer, object)
end

playerHouse.physics.fixture:setUserData(playerHouse)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return playerHouse