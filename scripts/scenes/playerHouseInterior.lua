-- SCENE SETUP --

local playerHouseInterior = scene.create("assets/images/clear_meadow_town/buildings/houses/single_floor/interior/single_floor_interior.jpg", 0, 0, nil)
     
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECT SETUP --

local assets = {
    require("scripts/objects/indoor_decor/sink"),
    require("scripts/objects/indoor_decor/table"),
    require("scripts/objects/indoor_decor/bed")
}

local sink
local table
local bed

playerHouseInterior.door = door.create("player_house_door", 821, 710, 193, 1, 821, 1014)
function playerHouseInterior.door.update(door)
    if (clearMeadowTown == nil) then
        clearMeadowTown = require("scripts/scenes/clearMeadowTown")
    end

    previousScene = playerHouseInterior
    nextScene = clearMeadowTown
end

function playerHouseInterior.door.open(door)
    if ((player.x >= door.leftEdge) and (player.x <= door.rightEdge) and ((player.y + player.height) >= (door.y))) then
        door.isOpen = true
        love.audio.play(playerHouseInterior.door.openSFX)
    else
        door.isOpen = false
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SCENE LOADING --

function playerHouseInterior.load()
    -- PLAYER --
    player.physics.body:setX(920)                   -- Sets the Player to be centered on the x-axis
    player.physics.body:setY(620)                   -- Sets the Player to be centered on the y-axis 
    
    -- BOUNDARY WALLS --
    playerHouseInterior.loadObject(objectHandler.create("topWall", 588, 400, 744, 1, 1, nil, nil, 588, 400, 744, 1, "static", 1, 0))
    playerHouseInterior.loadObject(objectHandler.create("bottomWall", 588, 720, 744, 1, 1, nil, nil, 588, 720, 744, 1, "static", 1, 0))
    playerHouseInterior.loadObject(objectHandler.create("leftWall", 588, 400, 1, 400, 1, nil, nil, 588, 400, 1, 400, "static", 1, 0))
    playerHouseInterior.loadObject(objectHandler.create("rightWall", 1332, 400, 1, 400, 1, nil, nil, 1332, 400, 1, 400, "static", 1, 0))


    -- INDOOR DECOR OBJECTS --
    sink = playerHouseInterior.loadObject(objectHandler.duplicate(assets[1], 588, 456, 588, 456))
    table =playerHouseInterior.loadObject(objectHandler.duplicate(assets[2], 885, 472, 885, 483))
    bed = playerHouseInterior.loadObject(objectHandler.duplicate(assets[3], 1188, 456, 1188, 536))
    bed.currentAnimation = bed.animations.idle_red

    playerHouseInterior.door.isOpen = false
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SCENE UPDATING --

function playerHouseInterior.update(dt)    
    player:update(dt)

    if (love.keyboard.isDown("e")) then
        playerHouseInterior.door:open()
    end

    if (playerHouseInterior.door.isOpen) then
        playerHouseInterior.door:update()    
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SCENE DRAW --

function playerHouseInterior.draw()
    love.graphics.draw(playerHouseInterior.background, playerHouseInterior.x, playerHouseInterior.y)

    sink:draw()
    table:draw()
    bed:draw()

    player:draw()
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return playerHouseInterior