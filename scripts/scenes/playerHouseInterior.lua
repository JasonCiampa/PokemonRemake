-- SCENE SETUP --

local playerHouseInterior = scene.create("assets/images/clear_meadow_town/buildings/houses/single_floor/interior/single_floor_interior.jpg", 0, 0, nil)
     
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECT SETUP --

function playerHouseInterior.load()
    player.physics.body:setX(855)                   -- Sets the Player to be centered on the x-axis
    player.physics.body:setY(619)                   -- Sets the Player to be centered on the y-axis  
end

function playerHouseInterior.update(dt)    
    player:update(dt)

    if (love.keyboard.isDown("e")) then
        nextScene = clearMeadowTown
    end

    -- playerHouseInterior.updateObjects(dt)
end

function playerHouseInterior.draw()
    love.graphics.draw(playerHouseInterior.background, playerHouseInterior.x, playerHouseInterior.y)

    player:drawTop()
    player:drawBottom()
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return playerHouseInterior