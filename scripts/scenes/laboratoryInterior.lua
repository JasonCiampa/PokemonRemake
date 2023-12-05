-- SCENE SETUP --

local laboratoryInterior = scene.create("assets/images/clear_meadow_town/buildings/lab/interior/lab_interior.jpg", 0, 0, nil)
     
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECT SETUP --

function laboratoryInterior.load()
    player.physics.body:setX(855)                   -- Sets the Player to be centered on the x-axis
    player.physics.body:setY(619)                   -- Sets the Player to be centered on the y-axis  
    
    laboratoryInterior.loadCamera(mainCamera)
    laboratoryInterior.activeCamera = mainCamera
end

function laboratoryInterior.update(dt)
    laboratoryInterior.cameras[1].follow(player)
    
    player:update(dt)

    if (love.keyboard.isDown("e")) then
        nextScene = clearMeadowTown
    end

    -- laboratoryInterior.updateObjects(dt)
end

function laboratoryInterior.draw()
    love.graphics.draw(laboratoryInterior.background, laboratoryInterior.x, laboratoryInterior.y)

    player:drawTop()
    player:drawBottom()
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return laboratoryInterior