-- SCENE SETUP --

local laboratoryInterior = scene.create("assets/images/clear_meadow_town/buildings/lab/interior/lab_interior.jpg", 0, 0, nil)
     
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECT SETUP --

local assets = {
    require("scripts/objects/indoor_decor/scienceKit"),
    require("scripts/objects/indoor_decor/scienceTable"),
    require("scripts/objects/indoor_decor/startersTable"),
    require("scripts/objects/pokeball")
}

local scienceKit1
local scienceKit2
local scienceKit3
local scienceKit4
local scienceKit5
local scienceKit6

local scienceTable1
local scienceTable2
local scienceTable3

local startersTable

local fireStarter
local grassStarter
local waterStarter

laboratoryInterior.door = door.create("laboratory_door", 1271, 943, 325, 5, 1271, 1596)
function laboratoryInterior.door.update(door)
    if (clearMeadowTown == nil) then
        clearMeadowTown = require("scripts/scenes/clearMeadowTown")
    end

    previousScene = laboratoryInterior
    nextScene = clearMeadowTown
end

function laboratoryInterior.door.open(door)
    if (player.x >= door.leftEdge) and (player.x <= door.rightEdge) and ((player.y + player.height) >= (door.y)) then
        door.isOpen = true
        love.audio.play(laboratoryInterior.door.openSFX)
    else
        door.isOpen = false
    end
end

laboratoryInterior.bottomHalfUnderPlayerTorso = {}
laboratoryInterior.topHalfUnderPlayerTorso = {}

laboratoryInterior.bottomHalfUnderPlayerHead = {}
laboratoryInterior.topHalfUnderPlayerHead = {}

laboratoryInterior.bottomHalfAbovePlayer = {}
laboratoryInterior.topHalfAbovePlayer = {}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SCENE LOADING --

function laboratoryInterior.load()
    -- PLAYER --
    player.physics.body:setX(1440)                   
    player.physics.body:setY(842)                   

    -- BOUNDARY WALLS --
    laboratoryInterior.loadObject(objectHandler.create("topWall", 180, 160, 1572, 1, 1, nil, nil, 180, 160, 1572, 1, "static", 1, 0))
    laboratoryInterior.loadObject(objectHandler.create("bottomWall", 180, 948, 1572, 1, 1, nil, nil, 180, 948, 1572, 1, "static", 1, 0))
    laboratoryInterior.loadObject(objectHandler.create("leftWall", 180, 160, 1, 788, 1, nil, nil, 180, 160, 1, 788, "static", 1, 0))
    laboratoryInterior.loadObject(objectHandler.create("rightWall", 1752, 160, 1, 788, 1, nil, nil, 1752, 160, 1, 788, "static", 1, 0))

    -- LAB DECOR --
    scienceKit1 = laboratoryInterior.loadObject(objectHandler.duplicate(assets[1], 180, 456, 180, 524))
    scienceKit2 = laboratoryInterior.loadObject(objectHandler.duplicate(assets[1], 348, 456, 348, 524))
    scienceKit3 = laboratoryInterior.loadObject(objectHandler.duplicate(assets[1], 780, 144, 780, 212))
    scienceKit4 = laboratoryInterior.loadObject(objectHandler.duplicate(assets[1], 948, 144, 948, 212))
    scienceKit5 = laboratoryInterior.loadObject(objectHandler.duplicate(assets[1], 1416, 384, 1416, 452))
    scienceKit6 = laboratoryInterior.loadObject(objectHandler.duplicate(assets[1], 1584, 384, 1584, 452))

    scienceTable1 = laboratoryInterior.loadObject(objectHandler.duplicate(assets[2], 396, 204, 396, 246))
    scienceTable2 = laboratoryInterior.loadObject(objectHandler.duplicate(assets[2], 1248, 204, 1248, 246))
    scienceTable3 = laboratoryInterior.loadObject(objectHandler.duplicate(assets[2], 408, 864, 408, 906))

    startersTable = laboratoryInterior.loadObject(objectHandler.duplicate(assets[3], 804, 480, 804, 530))

    fireStarter = laboratoryInterior.loadObject(objectHandler.duplicate(assets[4], 840, 552, nil, nil))
    fireStarter.currentAnimation = fireStarter.animations.fire

    grassStarter = laboratoryInterior.loadObject(objectHandler.duplicate(assets[4], 924, 504, nil, nil))
    grassStarter.currentAnimation = grassStarter.animations.grass

    waterStarter = laboratoryInterior.loadObject(objectHandler.duplicate(assets[4], 1008, 552, nil, nil))
    waterStarter.currentAnimation = waterStarter.animations.water

    laboratoryInterior.door.isOpen = false
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SCENE UPDATING --

function laboratoryInterior.update(dt)   
    laboratoryInterior.bottomHalfUnderPlayerTorso = {}
    laboratoryInterior.topHalfUnderPlayerTorso = {}

    laboratoryInterior.bottomHalfUnderPlayerHead = {}
    laboratoryInterior.topHalfUnderPlayerHead = {}

    laboratoryInterior.bottomHalfAbovePlayer = {}
    laboratoryInterior.topHalfAbovePlayer = {} 
    
    player:update(dt)

    if (love.keyboard.isDown("e")) then
        laboratoryInterior.door:open()
    end

    if (laboratoryInterior.door.isOpen) then
        laboratoryInterior.door:update()    
    end

    laboratoryInterior.updateObjects(dt)
end

function laboratoryInterior.draw()
    love.graphics.draw(laboratoryInterior.background, laboratoryInterior.x, laboratoryInterior.y)

    for i = 1, #laboratoryInterior.bottomHalfUnderPlayerTorso do
        laboratoryInterior.bottomHalfUnderPlayerTorso[i]:drawBottom()
    end

    for i = 1, #laboratoryInterior.topHalfUnderPlayerTorso do
        laboratoryInterior.topHalfUnderPlayerTorso[i]:drawTop()
    end

    player:drawBottom()

    for i = 1, #laboratoryInterior.bottomHalfUnderPlayerHead do
        laboratoryInterior.bottomHalfUnderPlayerHead[i]:drawBottom()
    end

    for i = 1, #laboratoryInterior.topHalfUnderPlayerHead do
        laboratoryInterior.topHalfUnderPlayerHead[i]:drawTop()
    end

    player:drawTop()

    for i = 1, #laboratoryInterior.bottomHalfAbovePlayer do
        laboratoryInterior.bottomHalfAbovePlayer[i]:drawBottom()
    end

    for i = 1, #laboratoryInterior.topHalfAbovePlayer do
        laboratoryInterior.topHalfAbovePlayer[i]:drawTop()
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return laboratoryInterior