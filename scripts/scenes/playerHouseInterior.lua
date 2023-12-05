-- SCENE SETUP --

local playerHouseInterior = scene.create("assets/images/clear_meadow_town/buildings/houses/single_floor/single_floor_interior.jpg", 0, 0, nil)
     
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CAMERA SETUP --

local mainCamera = camera.create(0, 0, (WIDTH * 0.55), (WIDTH * 0.45) - ((player.width / 2) ), (HEIGHT * 0.55), (HEIGHT * 0.45), 1920, 0, 1080, 0)   -- Adds a Camera labeled "main" to the clearMeadowTown Cameras tabl

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECT SETUP --

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function playerHouseInterior.load()

    playerHouseInterior.loadCamera(mainCamera)
    playerHouseInterior.activeCamera = mainCamera

    player.physics.body:setX(855)                   -- Sets the Player to be centered on the x-axis
    player.physics.body:setY(619)                   -- Sets the Player to be centered on the y-axis  
end

function playerHouseInterior.update(dt)
    playerHouseInterior.cameras[1].follow(player)
    
    player:update(dt)

    -- playerHouseInterior.updateObjects(dt)
end

function playerHouseInterior.draw()
    love.graphics.draw(playerHouseInterior.background, playerHouseInterior.x, playerHouseInterior.y)

    player:drawTop()
    player:drawBottom()
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return playerHouseInterior