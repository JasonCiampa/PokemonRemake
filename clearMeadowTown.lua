-- IMPORTS --
local scene = require("scene")
local camera = require("camera")

-- SCENE SETUP --
local clearMeadowTown = scene.create("assets/images/clear_meadow_town/clear_meadow_background.png", 0, 0)   -- Creates a clearMeadowTown Scene

-- CAMERA SETUP
clearMeadowTown.cameras.main = createCamera(0, 0, (WIDTH * 0.55), (WIDTH * 0.45) - ((player.width / 2) ), (HEIGHT * 0.55), (HEIGHT * 0.45), 1920, 0, 1080, 0) -- Adds a Camera labeled "main" to the clearMeadowTown Cameras table
clearMeadowTown.activeCamera = clearMeadowTown.cameras.main











return clearMeadowTown