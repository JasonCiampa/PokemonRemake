-- SCENE SETUP --

local neighborHouseInterior = scene.create("assets/images/clear_meadow_town/buildings/houses/single_floor_expanded/interior/single_floor_expanded_interior.jpg", 0, 0, nil)
     
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECT SETUP --

function neighborHouseInterior.load()
    player.physics.body:setX(855)                   -- Sets the Player to be centered on the x-axis
    player.physics.body:setY(619)                   -- Sets the Player to be centered on the y-axis  
end

function neighborHouseInterior.update(dt)    
    player:update(dt)

    if (love.keyboard.isDown("e")) then
        nextScene = clearMeadowTown
    end

    -- neighborHouseInterior.updateObjects(dt)
end

function neighborHouseInterior.draw()
    love.graphics.draw(neighborHouseInterior.background, neighborHouseInterior.x, neighborHouseInterior.y)

    player:drawTop()
    player:drawBottom()
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return neighborHouseInterior