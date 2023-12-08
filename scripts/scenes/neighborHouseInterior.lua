-- SCENE SETUP --

local neighborHouseInterior = scene.create("assets/images/clear_meadow_town/buildings/houses/single_floor_long/interior/single_floor_long_interior.jpg", 0, 0, nil)
     
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECT SETUP --

local assets = {
    require("scripts/objects/indoor_decor/bed"),
    require("scripts/objects/indoor_decor/longTable"),
    require("scripts/objects/indoor_decor/counter"),
    require("scripts/objects/indoor_decor/sink"),
}

local bed
local longTable
local counter
local sink

neighborHouseInterior.door = door.create("neighbor_house_door", 444, 719, 132, 1, 444, 576)

function neighborHouseInterior.door.update(door)
    if (clearMeadowTown == nil) then
        clearMeadowTown = require("scripts/scenes/clearMeadowTown")
    end

    previousScene = neighborHouseInterior
    nextScene = clearMeadowTown
end

function neighborHouseInterior.door.open(door)
    if ((player.x >= door.leftEdge) and (player.x <= door.rightEdge) and ((player.y + player.height) >= (door.y))) then
        door.isOpen = true
        love.audio.play(neighborHouseInterior.door.openSFX)
    else
        door.isOpen = false
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function neighborHouseInterior.load()
    -- PLAYER --
    player.physics.body:setX(515)                   
    player.physics.body:setY(620)                    

    -- BOUNDARY WALLS --
    neighborHouseInterior.loadObject(objectHandler.create("topWall", 156, 400, 1608, 1, 1, nil, nil, 156, 400, 1608, 1, "static", 1, 0))
    neighborHouseInterior.loadObject(objectHandler.create("bottomWall", 156, 720, 1608, 1, 1, nil, nil, 156, 720, 1608, 1, "static", 1, 0))
    neighborHouseInterior.loadObject(objectHandler.create("leftWall", 156, 400, 1, 320, 1, nil, nil, 156, 400, 1, 320, "static", 1, 0))
    neighborHouseInterior.loadObject(objectHandler.create("rightWall", 1764, 400, 1, 320, 1, nil, nil, 1764, 400, 1, 320, "static", 1, 0))

    bed = neighborHouseInterior.loadObject(objectHandler.duplicate(assets[1], 156, 472, 156, 551))
    bed.currentAnimation = bed.animations.idle_cyan
    longTable = neighborHouseInterior.loadObject(objectHandler.duplicate(assets[2], 612, 492, 612, 507))
    counter = neighborHouseInterior.loadObject(objectHandler.duplicate(assets[3], 1524, 504, 1524, 480))
    sink = neighborHouseInterior.loadObject(objectHandler.duplicate(assets[4], 1644, 480, 1644, 480))

    neighborHouseInterior.door.isOpen = false
end

function neighborHouseInterior.update(dt)    
    player:update(dt)

    if (love.keyboard.isDown("e")) then
        neighborHouseInterior.door:open()
    end

    if (neighborHouseInterior.door.isOpen) then
        neighborHouseInterior.door:update(neighborHouseInterior, dt)

        if (playerHouseInterior == nil) then
            playerHouseInterior = require("scripts/scenes/playerHouseInterior")
        end

        previousScene = neighborHouseInterior
        nextScene = clearMeadowTown
    end
end

function neighborHouseInterior.draw()
    love.graphics.draw(neighborHouseInterior.background, neighborHouseInterior.x, neighborHouseInterior.y)
    
    bed:draw()
    longTable:draw()
    counter:draw()
    sink:draw()

    player:draw()
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return neighborHouseInterior