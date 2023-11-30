-- SCENE SETUP --

local playerHouseInterior = scene.create("assets/images/clear_meadow_town/buildings/houses/single_floor/single_floor_interior.jpg", 0, 0, nil)
     
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CAMERA SETUP --


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECT SETUP --

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function playerHouseInterior.load()
    player.physics.body:setX(855)                   -- Sets the Player to be centered on the x-axis
    player.physics.body:setY(619)                   -- Sets the Player to be centered on the y-axis  
    player.physics.body:setLinearVelocity(0, 0)
end

function playerHouseInterior.update(dt)
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