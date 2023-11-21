-- SCENE SETUP --

local titleScreen = scene.create("assets/images/title_screen/background.jpg", 0, 0, nil)  -- Creates a titleScreen Scene

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CAMERA SETUP --

titleScreen.cameras.main = titleScreen.createCamera(0, 0)   -- Adds a Camera labeled "main" to the titleScreen Cameras table
titleScreen.activeCamera = titleScreen.cameras.main         -- Sets the "main" Camera to be the active Camera for titleScreen

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- BUTTON SETUP --

titleScreen.buttons.play = titleScreen.createButton(WIDTH / 2, 100, (titleScreen.width / 2) - WIDTH / 4, (titleScreen.height / 2) - 50, {0, 0, 1}, {1, 1, 1}, "Play")     -- Adds a play Button to the titleScreen Button list

-- Sets playButton's action to be to change the Scene to clearMeadowTown
function titleScreen.buttons.play.performAction(button, mouseX, mouseY) 
    clearMeadowTown = require("clearMeadowTown")   
    scene.changeTo(clearMeadowTown)                                  -- Changes the Scene from titleScreen to clearMeadowTown
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OBJECT SETUP --

-- titleScreen.createObject()

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TILEMAP SETUP --

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function titleScreen.load()
    
end

function titleScreen.update(dt)

end

function titleScreen.draw()
    titleScreen.activeCamera.draw()
    love.graphics.draw(titleScreen.background, titleScreen.x, titleScreen.y)
    titleScreen.drawButtons()
end

return titleScreen