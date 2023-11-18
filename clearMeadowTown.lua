-- SCENE SETUP --

local clearMeadowTown = scene.create("assets/images/clear_meadow_town/clear_meadow_town_background.png", 0, 0, nil)  -- Creates a clearMeadowTown Scene

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CAMERA SETUP --

clearMeadowTown.cameras.main = clearMeadowTown.createCamera(0, 0, (WIDTH * 0.55), (WIDTH * 0.45) - ((player.width / 2) ), (HEIGHT * 0.55), (HEIGHT * 0.45), 1920, 0, 1080, 0)   -- Adds a Camera labeled "main" to the clearMeadowTown Cameras table
clearMeadowTown.activeCamera = clearMeadowTown.cameras.main                                                                                                                     -- Sets the "main" Camera to be the active Camera for clearMeadowTown

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BUTTON SETUP --

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECT SETUP --
-- clearMeadowTown.createObject()

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TILEMAP SETUP --

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function clearMeadowTown.update(dt)
    clearMeadowTown.cameras.main.follow(player)
    player.move(dt)                                         -- Update the Player's movements
    player.update(dt)
end

function clearMeadowTown.draw()
    clearMeadowTown.activeCamera.draw()
    love.graphics.draw(clearMeadowTown.background, clearMeadowTown.x, clearMeadowTown.y)
    player.draw()
end

return clearMeadowTown