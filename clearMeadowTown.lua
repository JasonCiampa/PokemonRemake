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
    player.body:setX(0)     -- Sets the Player to be centered on the x-axis
    player.body:setY(2000)                   -- Sets the Player to be centered on the y-axis  
    

-- This should be used in tile sheets
-- clearMeadowTown.createDuplicateObject()

    clearMeadowTown.createObject("player_house", 840, 492, 2496, 330, "static", 1, 0, {animator.create("assets/images/clear_meadow_town/buildings/houses/single_floor/single_floor", ".png", 1, 1)})
    -- clearMeadowTown.objects[1].animations.idle = 
    -- clearMeadowTown.objects[1].currentAnimation = 

    -- clearMeadowTown.createObject("neighbor_house", 1680, 492, 1831, 1367, "static", 1, 0, {animator.create("assets/images/clear_meadow_town/buildings/houses/single_floor_expanded/single_floor_expanded", ".png", 1, 1)})
    -- -- clearMeadowTown.objects[2].animations.idle = 
    -- -- clearMeadowTown.objects[2].currentAnimation = 

    -- clearMeadowTown.createObject("laboratory", 840, 492, -650, -38, "static", 1, 0, {animator.create("assets/images/clear_meadow_town/buildings/lab/lab", ".png", 1, 1)})

    -- clearMeadowTown.createObject("bench", 360, 192, 1526, 74, "static", 1, 0, {animator.create("assets/images/outdoor_decor/bench/bench", ".png", 1, 1)})

    -- clearMeadowTown.createObject("tree", 200, 600, 3640, 1560, "static", 1, 0, {animator.create("assets/images/greenery/trees/tree", ".png", 1, 1)})

    -- clearMeadowTown.createObject("short_flower_orange", 50, 50, 2433, 725, "static", 1, 0, {animator.create("assets/images/greenery/flowers/short/shortFlowerOrange", ".png", 1, 1)})

    -- clearMeadowTown.createObject("tall_flower_purple", 50, 100, 3430, 681, "static", 1, 0, {animator.create("assets/images/greenery/flowers/tall/tallFlowerPurple", ".png", 1, 1)})
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECT UPDATING --

function clearMeadowTown.update(dt)
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
    clearMeadowTown.drawObjects()
    player.draw()

    love.graphics.setColor(1, 1, 1, 1)
    if (testBool) then
        love.graphics.rectangle("fill", player.x, player.y, 100, 100)
    end
end

return clearMeadowTown