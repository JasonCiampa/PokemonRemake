-- SCENE SETUP --

local clearMeadowTown = scene.create("assets/images/clear_meadow_town/clear_meadow_town_background.png", 0, 0, nil)  -- Creates a clearMeadowTown Scene

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CAMERA SETUP --

clearMeadowTown.cameras.main = clearMeadowTown.createCamera(0, 0, (WIDTH * 0.55), (WIDTH * 0.45) - ((player.width / 2) ), (HEIGHT * 0.55), (HEIGHT * 0.45), 1920, 0, 1080, 0)   -- Adds a Camera labeled "main" to the clearMeadowTown Cameras table
clearMeadowTown.activeCamera = clearMeadowTown.cameras.main                                                                                                                     -- Sets the "main" Camera to be the active Camera for clearMeadowTown

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BUTTON SETUP --

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TILEMAP SETUP --

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECT SETUP --

function clearMeadowTown.load()
    clearMeadowTown.drawUnderneathPlayer = {}
    clearMeadowTown.drawAbovePlayer = {}

    player.body:setX(2400)     -- Sets the Player to be centered on the x-axis
    player.body:setY(1080)                   -- Sets the Player to be centered on the y-axis  

-- This should be used in tile sheets
-- clearMeadowTown.createDuplicateObject()

    local playerHouse = clearMeadowTown.createObject("player_house", 2496, 328, 840, 492, 2534, 666, 742, 1, "static", 1, 0, {animator.create("assets/images/clear_meadow_town/buildings/houses/single_floor/single_floor", ".png", 1, 1)})
    function playerHouse.setDrawPosition()
        -- for the player house
        if (player.topLeftY < 647) then    -- if the player is above the collision box,
            table.insert(clearMeadowTown.drawAbovePlayer, playerHouse)
        else
            table.insert(clearMeadowTown.drawUnderneathPlayer, playerHouse)
        end
    end

    local neighborHouse = clearMeadowTown.createObject("neighbor_house", 1831, 1368, 1680, 492, 1868, 1706, 1606, 1, "static", 1, 0, {animator.create("assets/images/clear_meadow_town/buildings/houses/single_floor_expanded/single_floor_expanded", ".png", 1, 1)})
    function neighborHouse.setDrawPosition()
        -- for the player house
        if (player.topLeftY < 1687) then    -- if the player is above the collision box,
            table.insert(clearMeadowTown.drawAbovePlayer, neighborHouse)
        else
            table.insert(clearMeadowTown.drawUnderneathPlayer, neighborHouse)
        end
    end

    local laboratory = clearMeadowTown.createObject("laboratory", -650, -38, 1800, 984, 0, 34, 1030, 768, "static", 1, 0, {animator.create("assets/images/clear_meadow_town/buildings/lab/lab", ".png", 1, 1)})
    function laboratory.setDrawPosition()
        -- for the player house
        if (player.topLeftY < 800) then    -- if the player is above the collision box,
            table.insert(clearMeadowTown.drawAbovePlayer, laboratory)
        else
            table.insert(clearMeadowTown.drawUnderneathPlayer, laboratory)
        end
    end
    
    -- clearMeadowTown.createObject("bench", 360, 192, 1526, 74, "static", 1, 0, {animator.create("assets/images/outdoor_decor/bench/bench", ".png", 1, 1)})

    -- clearMeadowTown.createObject("tree", 200, 600, 3640, 1560, "static", 1, 0, {animator.create("assets/images/greenery/trees/tree", ".png", 1, 1)})

    -- clearMeadowTown.createObject("short_flower_orange", 50, 50, 2433, 725, "static", 1, 0, {animator.create("assets/images/greenery/flowers/short/shortFlowerOrange", ".png", 1, 1)})

    -- clearMeadowTown.createObject("tall_flower_purple", 50, 100, 3430, 681, "static", 1, 0, {animator.create("assets/images/greenery/flowers/tall/tallFlowerPurple", ".png", 1, 1)})
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECT UPDATING --

function clearMeadowTown.update(dt)
    clearMeadowTown.drawUnderneathPlayer = {}
    clearMeadowTown.drawAbovePlayer = {}

    clearMeadowTown.cameras.main.follow(player)
    clearMeadowTown.updateObjects(dt)
    player.move(dt)                                         -- Update the Player's movements
    player.update(dt)
    
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECT DRAWING --

function clearMeadowTown.draw()
    clearMeadowTown.activeCamera.draw()
    love.graphics.draw(clearMeadowTown.background, clearMeadowTown.x, clearMeadowTown.y)
    -- clearMeadowTown.drawObjects()

    for i = 1, #clearMeadowTown.drawUnderneathPlayer do
        clearMeadowTown.drawUnderneathPlayer[i]:draw()
    end

    player.draw()

    for i = 1, #clearMeadowTown.drawAbovePlayer do
        clearMeadowTown.drawAbovePlayer[i]:draw()
    end
end

return clearMeadowTown